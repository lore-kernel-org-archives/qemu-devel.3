Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CF1CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbGW-00061x-97; Fri, 19 Sep 2025 09:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbGA-0005qI-Ek
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbG1-0003Fw-PZ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3qRrJAaK7Vt26daB2oI+M4qBvsgliKbIycm8tDrK67c=;
 b=DLt+Hfod00w5jOiKqhLECFm1zncFHfnBXIsJaLoJHHzCQlKYL2UvBp2AQT2PprQeKHZ9/l
 JnnF45jqmFWMsP+2XORt6g4Mbg5Ci1ltghNg3Q7J07VAgvpIibLiIl+63mjeww4rCHqVh4
 VuauMBIWfZeb4ujsfdujdjUUtOT+h60=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-VCvmttc9OUCHDztPwFLWEQ-1; Fri,
 19 Sep 2025 09:34:32 -0400
X-MC-Unique: VCvmttc9OUCHDztPwFLWEQ-1
X-Mimecast-MFC-AGG-ID: VCvmttc9OUCHDztPwFLWEQ_1758288868
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A94E51955F3C; Fri, 19 Sep 2025 13:34:28 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C0A71800451; Fri, 19 Sep 2025 13:34:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 10/24] lcitool: update, switch to f41
Date: Fri, 19 Sep 2025 17:33:04 +0400
Message-ID: <20250919133320.240145-11-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-1-marcandre.lureau@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |  3 ++-
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |  3 ++-
 tests/docker/dockerfiles/alpine.docker             |  2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |  5 ++++-
 tests/docker/dockerfiles/debian-arm64-cross.docker |  5 ++++-
 tests/docker/dockerfiles/debian-armhf-cross.docker |  5 ++++-
 tests/docker/dockerfiles/debian-i686-cross.docker  |  5 ++++-
 .../dockerfiles/debian-mips64el-cross.docker       |  5 ++++-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  5 ++++-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  5 ++++-
 .../docker/dockerfiles/debian-riscv64-cross.docker |  8 ++++++--
 tests/docker/dockerfiles/debian-s390x-cross.docker |  5 ++++-
 tests/docker/dockerfiles/debian.docker             |  5 ++++-
 .../docker/dockerfiles/fedora-rust-nightly.docker  | 14 ++++++++------
 tests/docker/dockerfiles/fedora-win64-cross.docker | 11 +++++++----
 tests/docker/dockerfiles/fedora.docker             | 14 ++++++++------
 tests/docker/dockerfiles/opensuse-leap.docker      |  4 ++--
 tests/docker/dockerfiles/ubuntu2204.docker         |  5 ++++-
 tests/lcitool/projects/qemu.yml                    |  1 -
 tests/lcitool/refresh                              |  6 +++---
 20 files changed, 79 insertions(+), 37 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index f11e980826..bbcb5dd4ac 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -95,7 +95,6 @@ packages:
   - llvm
   - locales
   - make
-  - meson
   - mtools
   - multipath-tools
   - ncat
@@ -108,10 +107,12 @@ packages:
   - python3-opencv
   - python3-pillow
   - python3-pip
+  - python3-setuptools
   - python3-sphinx
   - python3-sphinx-rtd-theme
   - python3-tomli
   - python3-venv
+  - python3-wheel
   - python3-yaml
   - rpm2cpio
   - rustc-1.77
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 6559cb2934..00eb1b0f91 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -93,7 +93,6 @@ packages:
   - llvm
   - locales
   - make
-  - meson
   - mtools
   - multipath-tools
   - ncat
@@ -106,10 +105,12 @@ packages:
   - python3-opencv
   - python3-pillow
   - python3-pip
+  - python3-setuptools
   - python3-sphinx
   - python3-sphinx-rtd-theme
   - python3-tomli
   - python3-venv
+  - python3-wheel
   - python3-yaml
   - rpm2cpio
   - rustc-1.77
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index bf3bd5a30d..bd1ef5505d 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -78,7 +78,7 @@ RUN apk update && \
         nmap-ncat \
         numactl-dev \
         openssh-client \
-        pcre-dev \
+        pcre2-dev \
         pipewire-dev \
         pixman-dev \
         pkgconf \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 081f3e00f7..bba6de4e2d 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 91c555a36e..8bbcd75157 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index f0e2efcda0..455b84424c 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 025beb1ce2..8b8993ffe4 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 4a941dd870..c89cb6c680 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4d3e5d711b..4e10d9501f 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 22b4457ba9..cf61cb7f4a 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index b0386cd3a1..79ec37616d 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -4,7 +4,7 @@
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:trixie-slim
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -23,11 +23,13 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglib2.0-dev \
                       locales \
                       make \
-                      meson \
                       ninja-build \
                       pkgconf \
                       python3 \
+                      python3-pip \
+                      python3-setuptools \
                       python3-venv \
+                      python3-wheel \
                       sed \
                       tar && \
     eatmydata apt-get autoremove -y && \
@@ -36,6 +38,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 13ec52c8ad..1782e0e90f 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -34,7 +34,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       ncat \
                       ninja-build \
@@ -45,9 +44,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -67,6 +68,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 0a57c1a1d3..62f89e4d8c 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -104,7 +104,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       multipath-tools \
                       ncat \
@@ -117,9 +116,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-web \
@@ -146,6 +147,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 4a033309b3..fd71dd8790 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-40 qemu
+#  $ lcitool dockerfile --layers all fedora-41 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:40
+FROM registry.fedoraproject.org/fedora:41
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
@@ -91,7 +91,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                lzo-devel \
                make \
                mesa-libgbm-devel \
-               meson \
                mtools \
                ncurses-devel \
                nettle-devel \
@@ -100,7 +99,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                numactl-devel \
                openssh-clients \
                pam-devel \
-               pcre-static \
+               pcre2-static \
                pipewire-devel \
                pixman-devel \
                pkgconfig \
@@ -111,9 +110,10 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-opencv \
                python3-pillow \
                python3-pip \
+               python3-setuptools \
                python3-sphinx \
                python3-sphinx_rtd_theme \
-               python3-zombie-imp \
+               python3-wheel \
                rdma-core-devel \
                rust \
                sed \
@@ -124,7 +124,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                spice-server-devel \
                swtpm \
                systemd-devel \
-               systemtap-sdt-devel \
+               systemtap-sdt-dtrace \
                tar \
                tesseract \
                tesseract-langpack-eng \
@@ -148,6 +148,8 @@ exec "$@"\n' > /usr/bin/nosync && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index a950344402..ed7d270984 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-40 qemu,qemu-win-installer
+#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-41 qemu,qemu-win-installer
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:40
+FROM registry.fedoraproject.org/fedora:41
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
@@ -38,7 +38,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                hostname \
                llvm \
                make \
-               meson \
                mtools \
                ninja-build \
                nmap-ncat \
@@ -49,9 +48,10 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-opencv \
                python3-pillow \
                python3-pip \
+               python3-setuptools \
                python3-sphinx \
                python3-sphinx_rtd_theme \
-               python3-zombie-imp \
+               python3-wheel \
                rust \
                sed \
                socat \
@@ -69,6 +69,8 @@ exec "$@"\n' > /usr/bin/nosync && \
     nosync dnf clean all -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -90,6 +92,7 @@ RUN nosync dnf install -y \
                mingw64-gtk-vnc2 \
                mingw64-gtk3 \
                mingw64-libepoxy \
+               mingw64-libfdt \
                mingw64-libgcrypt \
                mingw64-libjpeg-turbo \
                mingw64-libpng \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 014e3ccf17..e367c53c09 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-40 qemu
+#  $ lcitool dockerfile --layers all fedora-41 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:40
+FROM registry.fedoraproject.org/fedora:41
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
@@ -91,7 +91,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                lzo-devel \
                make \
                mesa-libgbm-devel \
-               meson \
                mtools \
                ncurses-devel \
                nettle-devel \
@@ -100,7 +99,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                numactl-devel \
                openssh-clients \
                pam-devel \
-               pcre-static \
+               pcre2-static \
                pipewire-devel \
                pixman-devel \
                pkgconfig \
@@ -111,9 +110,10 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-opencv \
                python3-pillow \
                python3-pip \
+               python3-setuptools \
                python3-sphinx \
                python3-sphinx_rtd_theme \
-               python3-zombie-imp \
+               python3-wheel \
                rdma-core-devel \
                rust \
                sed \
@@ -124,7 +124,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                spice-server-devel \
                swtpm \
                systemd-devel \
-               systemtap-sdt-devel \
+               systemtap-sdt-dtrace \
                tar \
                tesseract \
                tesseract-langpack-eng \
@@ -148,6 +148,8 @@ exec "$@"\n' > /usr/bin/nosync && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index e90225dc23..60763857bb 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -89,7 +89,7 @@ RUN zypper update -y && \
            ninja \
            openssh \
            pam-devel \
-           pcre-devel-static \
+           pcre2-devel-static \
            pipewire-devel \
            pkgconfig \
            python311 \
@@ -132,7 +132,7 @@ RUN zypper update -y && \
 
 RUN /usr/bin/pip3.11 install \
                      PyYAML \
-                     meson==1.5.0 \
+                     meson==1.8.1 \
                      pillow \
                      sphinx \
                      sphinx-rtd-theme
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 28a6f93243..ea67c7602a 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -102,7 +102,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       llvm \
                       locales \
                       make \
-                      meson \
                       mtools \
                       multipath-tools \
                       ncat \
@@ -115,10 +114,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
+                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-tomli \
                       python3-venv \
+                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       rustc-1.77 \
@@ -145,6 +146,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3 install meson==1.8.1
+
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index c07242f272..f22fc46fdc 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -91,7 +91,6 @@ packages:
  - pkg-config
  - pulseaudio
  - python3
- - python3-imp
  - python3-numpy
  - python3-opencv
  - python3-pillow
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index d3488b2679..f49eb638f8 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -171,7 +171,7 @@ try:
     generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
-    generate_dockerfile("fedora", "fedora-40")
+    generate_dockerfile("fedora", "fedora-41")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
                         trailer="".join(ubuntu2204_rust_extras))
@@ -179,7 +179,7 @@ try:
     #
     # Non-fatal Rust-enabled build
     #
-    generate_dockerfile("fedora-rust-nightly", "fedora-40",
+    generate_dockerfile("fedora-rust-nightly", "fedora-41",
                         trailer="".join(fedora_rustup_nightly_extras))
 
     #
@@ -237,7 +237,7 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-40",
+    generate_dockerfile("fedora-win64-cross", "fedora-41",
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-- 
2.51.0


