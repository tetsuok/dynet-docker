FROM nvidia/cuda:8.0-cudnn5-devel

RUN apt-get update && apt-get install -y \
    ca-certificates \
    cmake \
    git \
    mercurial \
    ninja-build \
    --no-install-recommends \
    && rm -fr /var/lib/apt/lists/*

RUN git clone --depth 10 https://github.com/clab/dynet.git && \
    cd dynet/third_party && \
    hg clone https://bitbucket.org/eigen/eigen/ -r 346ecdb && \
    cd .. && \
    mkdir build && \
    cd build && \
    cmake .. -DEIGEN3_INCLUDE_DIR=../third_party/eigen -DENABLE_CPP_EXAMPLES=ON -DBACKEND=cuda -G Ninja && \
    ninja
