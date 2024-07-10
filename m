Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A9C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZU2-0001iA-Sb; Wed, 10 Jul 2024 11:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRZU0-0001hY-QN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:43:52 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRZTx-0003Xp-6p
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:43:52 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77e85cb9b4so475706366b.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720626227; x=1721231027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6JqAorFs/em6J4VZ+sjkdquNBfzZiSo+i3e7ddIGido=;
 b=OmKBpXG3LvXDPx2QDaF5rSUecGRp77lwvbzaIuC4999m2CrEppTPtd5vFRdoGIKxgJ
 cadxCV48kfz9RL0/999CSgITxYls0iiM8to2Nfn6b+AV8UH0KQGPyL8fOUvev1gr0uoN
 WFQZYO2yphd40G0DfjdTI0Fzz5v1kQWVk5tg/NJc1ZB6aMKICDMhxp0MuvNH8GigIxPU
 AtmLzkvzNPqcItJhy2QUQ9TpAbK8K+lFRouEIcYFaUo1NwbNTtUEBtXex2lufi5bxj++
 E5rSpgcAmVv/XLnSpSRNjq5ZJLKbPXy0yxXWSivD4tEPxr0qCfLguU5kD8LRdSY5tEiO
 MsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720626227; x=1721231027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6JqAorFs/em6J4VZ+sjkdquNBfzZiSo+i3e7ddIGido=;
 b=WgD6cnRh/eqTtBP9jLxlhp8bVxPeCg8MWlp7Db7uuUan3sxn57G3sjiKkBCox8kQHu
 KLC85cnQiJoSAnXC8kKrUZXTE3x/BGynWwLxmahGidst1D2VHwFImuZbWCC2D9+aO+2+
 v7UVHbjCRD0sgqO1LOPevApLiFzSD4RZ7YUTOQ6XWnbf+ybqTAgQ3CjtGjqwgwBFxwu6
 w9LRR1kHf7Bm4sdsg8M6aw51L45pwbQrv7QmerFc4zzG7JXiZg30qGCTbf9q4rJHdd4j
 F7Cm69dyNggd0NLq27y55r3P/+0J4ULT/xZLO/h/T9NO0wx5tuDScvTsnxmPTedhjyTF
 W3Ew==
X-Gm-Message-State: AOJu0YzXQLIQi+arCt+KXi/XnY9QQwv0JeFa7Inbl0Dl1XqjbFC1yuFi
 +cErzGNkgu6Tn9cbXrhjSDKteOYve24I8lcaq890zCCdWK/8vFgvFveLu/uR1Uc=
X-Google-Smtp-Source: AGHT+IEqQSa4r6mnjghInns3KAObVGnSUJcUqXZG4Ms5rF8rfnTMoHkC/77NqaIG6hZJY4mlPh6tDw==
X-Received: by 2002:a17:906:bcf4:b0:a72:5967:b3a with SMTP id
 a640c23a62f3a-a780b6b1d6bmr364060466b.22.1720626226061; 
 Wed, 10 Jul 2024 08:43:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7ff038sm167430466b.115.2024.07.10.08.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 08:43:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D1975F937;
 Wed, 10 Jul 2024 16:43:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] build deps: update lcitool to include rust bits
Date: Wed, 10 Jul 2024 16:43:35 +0100
Message-Id: <20240710154335.2510260-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For rust development we need cargo, rustc and bindgen in our various
development environments. Update the libvirt-ci project to (!495) and
regenerate the containers and other dependency lists.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
NB:
  - this is currently waiting on the upstream MR, but if you manually
  add the remote
  https://gitlab.com/stsquad/libvirt-ci/-/tree/more-rust-mappings the
  submodule update will work.
---
 .gitlab-ci.d/cirrus/freebsd-13.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 3 +++
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 3 +++
 tests/docker/dockerfiles/alpine.docker                | 3 +++
 tests/docker/dockerfiles/centos9.docker               | 3 +++
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++++
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++++
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++++
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++++
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian.docker                | 3 +++
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 +++
 tests/docker/dockerfiles/fedora.docker                | 3 +++
 tests/docker/dockerfiles/opensuse-leap.docker         | 2 ++
 tests/docker/dockerfiles/ubuntu2204.docker            | 3 +++
 tests/lcitool/libvirt-ci                              | 2 +-
 tests/lcitool/projects/qemu.yml                       | 3 +++
 tests/vm/generated/freebsd.json                       | 2 ++
 24 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/freebsd-13.vars
index 3785afca36..8c3b02d089 100644
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-13.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip-3.8'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-13.vars b/.gitlab-ci.d/cirrus/macos-13.vars
index 534f029956..3c8ba1a277 100644
--- a/.gitlab-ci.d/cirrus/macos-13.vars
+++ b/.gitlab-ci.d/cirrus/macos-13.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 43070f4a26..d227c5deca 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index fd5489cd82..6f856a5da2 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -7,10 +7,12 @@
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
   - ca-certificates
+  - cargo
   - ccache
   - clang
   - dbus
@@ -112,6 +114,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
+  - rustc
   - sed
   - socat
   - sparse
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index afa04502cf..217515f90d 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -7,10 +7,12 @@
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
   - ca-certificates
+  - cargo
   - ccache
   - clang
   - dbus
@@ -110,6 +112,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
+  - rustc
   - sed
   - socat
   - sparse
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index b079a83fe2..fc488c94ac 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -18,6 +18,7 @@ RUN apk update && \
         bzip2-dev \
         ca-certificates \
         capstone-dev \
+        cargo \
         ccache \
         ceph-dev \
         clang \
@@ -89,6 +90,8 @@ RUN apk update && \
         py3-yaml \
         python3 \
         rpm2cpio \
+        rust \
+        rust-bindgen \
         samurai \
         sdl2-dev \
         sdl2_image-dev \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0256865b9e..e6a69c56f8 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -16,12 +16,14 @@ RUN dnf distro-sync -y && \
         alsa-lib-devel \
         bash \
         bc \
+        bindgen-cli \
         bison \
         brlapi-devel \
         bzip2 \
         bzip2-devel \
         ca-certificates \
         capstone-devel \
+        cargo \
         ccache \
         clang \
         ctags \
@@ -102,6 +104,7 @@ RUN dnf distro-sync -y && \
         python3-sphinx_rtd_theme \
         python3-tomli \
         rdma-core-devel \
+        rust \
         sed \
         snappy-devel \
         socat \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 8058695979..62f8c000ed 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
 
 ENV ABI "x86_64-linux-gnu"
 ENV MESON_OPTS "--cross-file=x86_64-linux-gnu"
+ENV RUST_TARGET "x86_64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 15457d7657..42523e9113 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -168,6 +171,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
 
 ENV ABI "aarch64-linux-gnu"
 ENV MESON_OPTS "--cross-file=aarch64-linux-gnu"
+ENV RUST_TARGET "aarch64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
 ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index c26ffc2e9e..35d42dba97 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabi && \
 
 ENV ABI "arm-linux-gnueabi"
 ENV MESON_OPTS "--cross-file=arm-linux-gnueabi"
+ENV RUST_TARGET "armv5te-unknown-linux-gnueabi"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user,armeb-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 8f87656d89..1b2c260e5a 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -168,6 +171,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
 
 ENV ABI "arm-linux-gnueabihf"
 ENV MESON_OPTS "--cross-file=arm-linux-gnueabihf"
+ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index f4ef054a2e..50ad6179a2 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
 
 ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
+ENV RUST_TARGET "i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 59c4c68dce..27db4509b6 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
 
 ENV ABI "mips64el-linux-gnuabi64"
 ENV MESON_OPTS "--cross-file=mips64el-linux-gnuabi64"
+ENV RUST_TARGET "mips64el-unknown-linux-gnuabi64"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
 ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 880c774f1c..725a632e4b 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
 
 ENV ABI "mipsel-linux-gnu"
 ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
+ENV RUST_TARGET "mipsel-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
 ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 1d55b9514c..c85b43704c 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
 
 ENV ABI "powerpc64le-linux-gnu"
 ENV MESON_OPTS "--cross-file=powerpc64le-linux-gnu"
+ENV RUST_TARGET "powerpc64le-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
 ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 62ccda6ab1..022c84b0da 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -166,6 +169,7 @@ endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
 
 ENV ABI "s390x-linux-gnu"
 ENV MESON_OPTS "--cross-file=s390x-linux-gnu"
+ENV RUST_TARGET "s390x-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 0d1d401eb8..c30fab88f7 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       clang \
                       dbus \
@@ -119,6 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 007e1574bd..d1a1922b35 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -20,9 +20,11 @@ exec "$@"\n' > /usr/bin/nosync && \
     nosync dnf install -y \
                bash \
                bc \
+               bindgen-cli \
                bison \
                bzip2 \
                ca-certificates \
+               cargo \
                ccache \
                ctags \
                dbus-daemon \
@@ -52,6 +54,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
+               rust \
                sed \
                socat \
                sparse \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 44f239c088..bb05ca4172 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -23,12 +23,14 @@ exec "$@"\n' > /usr/bin/nosync && \
                alsa-lib-devel \
                bash \
                bc \
+               bindgen-cli \
                bison \
                brlapi-devel \
                bzip2 \
                bzip2-devel \
                ca-certificates \
                capstone-devel \
+               cargo \
                ccache \
                clang \
                ctags \
@@ -112,6 +114,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
                rdma-core-devel \
+               rust \
                sed \
                snappy-devel \
                socat \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 836f531ac1..3e8bc8447e 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -16,6 +16,7 @@ RUN zypper update -y && \
            brlapi-devel \
            bzip2 \
            ca-certificates \
+           cargo \
            ccache \
            clang \
            ctags \
@@ -94,6 +95,7 @@ RUN zypper update -y && \
            python311-pip \
            python311-setuptools \
            rdma-core-devel \
+           rust \
            sed \
            snappy-devel \
            sndio-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index beeb44fc28..98ee55f7e0 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       clang \
                       dbus \
@@ -119,6 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 0e9490cebc..9b2b2ceb80 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
+Subproject commit 9b2b2ceb80a7a215bdfb9000bcc2c1a30457ec69
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 0c85784259..7e85b27b66 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -3,11 +3,13 @@ packages:
  - alsa
  - bash
  - bc
+ - bindgen
  - bison
  - brlapi
  - bzip2
  - bzip2-libs
  - capstone
+ - cargo
  - ccache
  - clang
  - cmocka
@@ -100,6 +102,7 @@ packages:
  - python3-tomli
  - python3-venv
  - rpm2cpio
+ - rust
  - sdl2
  - sdl2-image
  - sed
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 2d5895ebed..3d36c8af7c 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -60,6 +60,8 @@
     "py39-yaml",
     "python3",
     "rpm2cpio",
+    "rust",
+    "rust-bindgen-cli",
     "sdl2",
     "sdl2_image",
     "snappy",
-- 
2.39.2


