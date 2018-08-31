FROM golang:1.11 as build

ARG PROJECT_PATH=/go/src/github.com/yyoshiki41/nvidia_smi_exporter
WORKDIR ${PROJECT_PATH}
COPY . ${PROJECT_PATH}/

RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/nvidia_smi_exporter

FROM nvidia/cuda:9.0-base-ubuntu16.04
COPY --from=build /bin/nvidia_smi_exporter /bin/nvidia_smi_exporter

EXPOSE 9101

ENTRYPOINT ["/bin/nvidia_smi_exporter"]
