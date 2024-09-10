Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA5EDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4pr-0005gb-9A; Tue, 10 Sep 2024 13:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pZ-0004lh-FY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:09 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pV-0004Z9-T5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:08 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5365a9574b6so6640889e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989944; x=1726594744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x182aOeWN0VUpTIjJ/KVESHfoVOy56+KeRdhKF4bGRU=;
 b=VTvAdUaiSv7bs6SF4fpAXWjIYzoZcp8Ty2CGTr5XLIWBtHnmQmnoPrgQvkN6+ZEFYy
 gPb/7/0OIxy1U56QWgkuRdnJvXimWfIxVgo90MMUTnejh4zqLPiOYhLHjUaW5IaEUAXE
 pBiMOSAjVrb2ELi4V7i5HfWFzPkoKH46k12ePF+vFBq9Muv76Qfn4bObg07nVc5Ujc6N
 wJO0AbjVse5SD8vnUmxFY98eNT6DS1+hP+1r+LpezpmfO5PoBzQlPbXqwRANyHEHpt7L
 EX1KLXV9ZM2GyN/DK3wSkn+JRYmDZAppoOMHqVTJ+mZiYItI0Kmo1J5gwqNazl6uSnh4
 y6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989944; x=1726594744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x182aOeWN0VUpTIjJ/KVESHfoVOy56+KeRdhKF4bGRU=;
 b=XO/rpcr1/GBgMvMFHqUOyfZpWrNol/bHick6vPah0/6mD70WryQuKCIkqlgBjX1oip
 K1XlvE/ihbIZgcsZnZ9H0ykhwaC50lgCvSPEciyporSQgtqN+nCVAdwt0A+3JPxdOVZk
 ancJlAAS53Zhbd12NAorqEZgbTpqIqh99pCff+JZbA4pf4wQ+xfEKaPWWPTXxfD6uWMd
 7Myw2GjgjR1qRfSLhCxlepwcTKk+mk8XkrhG/VASq+royvMg9tVVBcWcU9KVM45JZ4DR
 XcUC2ujEcuJThuYuve5VCkWCymnUflFBApnmd7x3LQyzxFJkp0pDMW5kAsJcGHDYsgfX
 Sd0g==
X-Gm-Message-State: AOJu0Yz35LPPILOeUPHIqE/ypjMglg8IbSMO7pu4k/RCufVTPlF/wT/w
 9ZauouLXqe5EGatPtE1sEvGpxXzgpj3lQoE5nyhKt0DkfAi7nLrsOp7ec/zrX4E=
X-Google-Smtp-Source: AGHT+IEqDtyW7LzNvYTqOawZYfdKrXV6Cn0I4oO96SU86YfF/QyZnYCHGy903SXVHaFtudcazSfl/w==
X-Received: by 2002:a05:6512:3983:b0:533:71f:3a3d with SMTP id
 2adb3069b0e04-536587ae7a3mr14453478e87.24.1725989943063; 
 Tue, 10 Sep 2024 10:39:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c60ef3sm504237166b.110.2024.09.10.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 852115F78C;
 Tue, 10 Sep 2024 18:39:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 01/10] tests/docker: remove debian-armel-cross
Date: Tue, 10 Sep 2024 18:38:51 +0100
Message-Id: <20240910173900.4154726-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As debian-11 transitions to LTS we are starting to have problems
building the image. While we could update to a later Debian building a
32 bit QEMU without modern floating point is niche host amongst the
few remaining 32 bit hosts we regularly build for. For now we still
have armhf-debian-cross-container which is currently built from the
more recent debian-12.

Message-Id: <20240910140733.4007719-2-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/container-cross.yml              |   6 -
 .gitlab-ci.d/crossbuilds.yml                  |   7 -
 .../dockerfiles/debian-armel-cross.docker     | 179 ------------------
 tests/lcitool/refresh                         |   6 -
 4 files changed, 198 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index e3103940a0..9a3ebd885e 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -22,12 +22,6 @@ arm64-debian-cross-container:
   variables:
     NAME: debian-arm64-cross
 
-armel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-armel-cross
-
 armhf-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index cb499e4ee0..459273f9da 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,13 +1,6 @@
 include:
   - local: '/.gitlab-ci.d/crossbuild-template.yml'
 
-cross-armel-user:
-  extends: .cross_user_build_job
-  needs:
-    job: armel-debian-cross-container
-  variables:
-    IMAGE: debian-armel-cross
-
 cross-armhf-user:
   extends: .cross_user_build_job
   needs:
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
deleted file mode 100644
index 8476fc8cce..0000000000
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ /dev/null
@@ -1,179 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch armv6l debian-11 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:11-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libglib2.0-dev \
-                      libgtk-vnc-2.0-dev \
-                      libpcre2-dev \
-                      libsndio-dev \
-                      libspice-protocol-dev \
-                      llvm \
-                      locales \
-                      make \
-                      meson \
-                      mtools \
-                      ncat \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      sed \
-                      socat \
-                      sparse \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
-
-RUN /usr/bin/pip3 install tomli
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture armel && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-arm-linux-gnueabi \
-                      libaio-dev:armel \
-                      libasan6:armel \
-                      libasound2-dev:armel \
-                      libattr1-dev:armel \
-                      libbpf-dev:armel \
-                      libbrlapi-dev:armel \
-                      libbz2-dev:armel \
-                      libc6-dev:armel \
-                      libcacard-dev:armel \
-                      libcap-ng-dev:armel \
-                      libcapstone-dev:armel \
-                      libcmocka-dev:armel \
-                      libcurl4-gnutls-dev:armel \
-                      libdaxctl-dev:armel \
-                      libdrm-dev:armel \
-                      libepoxy-dev:armel \
-                      libfdt-dev:armel \
-                      libffi-dev:armel \
-                      libfuse3-dev:armel \
-                      libgbm-dev:armel \
-                      libgcrypt20-dev:armel \
-                      libglib2.0-dev:armel \
-                      libglusterfs-dev:armel \
-                      libgnutls28-dev:armel \
-                      libgtk-3-dev:armel \
-                      libibverbs-dev:armel \
-                      libiscsi-dev:armel \
-                      libjemalloc-dev:armel \
-                      libjpeg62-turbo-dev:armel \
-                      libjson-c-dev:armel \
-                      liblttng-ust-dev:armel \
-                      liblzo2-dev:armel \
-                      libncursesw5-dev:armel \
-                      libnfs-dev:armel \
-                      libnuma-dev:armel \
-                      libpam0g-dev:armel \
-                      libpipewire-0.3-dev:armel \
-                      libpixman-1-dev:armel \
-                      libpng-dev:armel \
-                      libpulse-dev:armel \
-                      librbd-dev:armel \
-                      librdmacm-dev:armel \
-                      libsasl2-dev:armel \
-                      libsdl2-dev:armel \
-                      libsdl2-image-dev:armel \
-                      libseccomp-dev:armel \
-                      libselinux1-dev:armel \
-                      libslirp-dev:armel \
-                      libsnappy-dev:armel \
-                      libspice-server-dev:armel \
-                      libssh-gcrypt-dev:armel \
-                      libsystemd-dev:armel \
-                      libtasn1-6-dev:armel \
-                      libubsan1:armel \
-                      libudev-dev:armel \
-                      liburing-dev:armel \
-                      libusb-1.0-0-dev:armel \
-                      libusbredirhost-dev:armel \
-                      libvdeplug-dev:armel \
-                      libvirglrenderer-dev:armel \
-                      libvte-2.91-dev:armel \
-                      libzstd-dev:armel \
-                      nettle-dev:armel \
-                      systemtap-sdt-dev:armel \
-                      zlib1g-dev:armel && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/arm-linux-gnueabi-gcc'\n\
-ar = '/usr/bin/arm-linux-gnueabi-gcc-ar'\n\
-strip = '/usr/bin/arm-linux-gnueabi-strip'\n\
-pkgconfig = '/usr/bin/arm-linux-gnueabi-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'arm'\n\
-cpu = 'arm'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabi && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabi-gcc
-
-ENV ABI "arm-linux-gnueabi"
-ENV MESON_OPTS "--cross-file=arm-linux-gnueabi"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
-ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user,armeb-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index ac803e34f1..199d5fad87 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -154,12 +154,6 @@ try:
                         trailer=cross_build("aarch64-linux-gnu-",
                                             "aarch64-softmmu,aarch64-linux-user"))
 
-    # migration to bookworm stalled: https://lists.debian.org/debian-arm/2023/09/msg00006.html
-    generate_dockerfile("debian-armel-cross", "debian-11",
-                        cross="armv6l",
-                        trailer=cross_build("arm-linux-gnueabi-",
-                                            "arm-softmmu,arm-linux-user,armeb-linux-user"))
-
     generate_dockerfile("debian-armhf-cross", "debian-12",
                         cross="armv7l",
                         trailer=cross_build("arm-linux-gnueabihf-",
-- 
2.39.2


