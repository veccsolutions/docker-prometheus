FROM prom/prometheus:v2.21.0

USER root

# move the prometheus config file to a directory so we can mount one through NFS
RUN mkdir /prometheus-config \
    && mv /etc/prometheus/prometheus.yml /prometheus-config/prometheus.yml \
    && ln -s /prometheus-config/prometheus.yml /etc/prometheus/prometheus.yml

USER nobody

ENTRYPOINT [ "/bin/prometheus", \
             "--config.file=/etc/prometheus/prometheus.yml", \
              "--storage.tsdb.path=/prometheus", \
              "--storage.tsdb.retention.time=3650d", \
              "--web.console.libraries=/usr/share/prometheus/console_libraries", \
              "--web.console.templates=/usr/share/prometheus/consoles" ]
