Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AB8C61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzB5-0005v2-2T; Tue, 25 Aug 2026 17:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzB3-0005ue-KU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzB1-0000NU-DH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787695166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibCvbWvqN9g5f8V33GgCDHqvbj20Kj0b2C6ZKMuxDGo=;
 b=PoDAb6t+0Dsaz+Ah+M18c09FibfE46iA6GkRp+qGR5+uABO8eN0Q+MXijhZbxY8ICegmSP
 FyV2qZn2MIDPs8p2DAVTJtCJ9NCEYmc85uJfTxhL2aGGTxFOZ7VWJnfBFLD5w6Xi7lY+kt
 w3/mrEgggTWGqZ9BlfJt4xMNAvl2nP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-cFDgHPZBMNqH4zB9UMTl8g-1; Tue,
 25 Aug 2026 17:59:22 -0400
X-MC-Unique: cFDgHPZBMNqH4zB9UMTl8g-1
X-Mimecast-MFC-AGG-ID: cFDgHPZBMNqH4zB9UMTl8g_1787695160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DBCF190F9ED; Tue, 25 Aug 2026 21:59:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8923A1944B32; Tue, 25 Aug 2026 21:59:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 05/16] tests: re-add opencv2 and numpy dependencies
Date: Tue, 25 Aug 2026 17:58:40 -0400
Message-ID: <20260825215851.1780608-6-jsnow@redhat.com>
In-Reply-To: <20260825215851.1780608-1-jsnow@redhat.com>
References: <20260825215851.1780608-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fixes: 2a428c8541ec5e9be54aad5f0a446ec8172226c9

Some of the dependencies identified as avocado dependencies were in
fact still being used, and should be re-added to our lcitool
configuration to ensure that these tests are being executed in the CI
environment.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/docker/dockerfiles/alpine.docker               |  1 +
 tests/docker/dockerfiles/centos9.docker              |  2 ++
 tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 ++
 tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 ++
 tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 ++
 tests/docker/dockerfiles/debian-i686-cross.docker    |  2 ++
 tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 ++
 tests/docker/dockerfiles/debian.docker               |  2 ++
 tests/docker/dockerfiles/fedora-rust-nightly.docker  |  2 ++
 tests/docker/dockerfiles/fedora-win64-cross.docker   |  2 ++
 tests/docker/dockerfiles/fedora.docker               |  2 ++
 tests/docker/dockerfiles/opensuse-leap.docker        |  2 ++
 tests/docker/dockerfiles/ubuntu2404.docker           |  2 ++
 .gitlab-ci.d/macos-14.vars                           |  2 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml       |  2 ++
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml     |  2 ++
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml       |  2 ++
 tests/lcitool/mappings.yml                           | 12 ++++++++++++
 tests/lcitool/projects/qemu.yml                      |  2 ++
 tests/vm/generated/freebsd.json                      |  2 ++
 22 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 8a5a355e89a..7c342e801c5 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -83,6 +83,7 @@ RUN apk update && \
         pixman-dev \
         pkgconf \
         pulseaudio-dev \
+        py3-numpy \
         py3-pip \
         py3-setuptools \
         py3-sphinx \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 8101370a2db..6f5c400c2db 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -130,6 +130,8 @@ RUN dnf --quiet distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
 RUN /usr/bin/pip3.11 install \
+                     numpy \
+                     opencv-python \
                      sphinx \
                      sphinx-rtd-theme
 
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index e945e641e20..975b9f346e6 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 0ee3a3f61c4..3efce404827 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index aacc1846801..91e8587b5d4 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 476031bd4db..a60b72e05b9 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 87e24d4dc0f..a7599b4f618 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index d0a9805f864..52661d4d9e4 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 179be9573d7..0a04777b363 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -41,6 +41,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 56605a42a2f..77869f71546 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -113,6 +113,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 0f3dc370a4f..0f7b4c13388 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -104,6 +104,8 @@ exec "$@"\n' > /usr/bin/nosync && \
                        pkgconfig \
                        pulseaudio-libs-devel \
                        python3 \
+                       python3-numpy \
+                       python3-opencv \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 6f972f61738..3ed3e15df33 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -44,6 +44,8 @@ exec "$@"\n' > /usr/bin/nosync && \
                        ninja-build \
                        openssh-clients \
                        python3 \
+                       python3-numpy \
+                       python3-opencv \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 99bb38a3665..8fa8bea1abf 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -104,6 +104,8 @@ exec "$@"\n' > /usr/bin/nosync && \
                        pkgconfig \
                        pulseaudio-libs-devel \
                        python3 \
+                       python3-numpy \
+                       python3-opencv \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index a634f39c1ec..3a3d6f73c89 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -95,6 +95,8 @@ RUN zypper update -y && \
            pkgconfig \
            python3-Sphinx \
            python3-base \
+           python3-numpy \
+           python3-opencv \
            python3-pip \
            python3-setuptools \
            python3-sphinx_rtd_theme \
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index d80f3a33d3b..bb8f4e4e53f 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -113,6 +113,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
+                      python3-numpy \
+                      python3-opencv \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
diff --git a/.gitlab-ci.d/macos-14.vars b/.gitlab-ci.d/macos-14.vars
index 0c187624dd0..f96e173f663 100644
--- a/.gitlab-ci.d/macos-14.vars
+++ b/.gitlab-ci.d/macos-14.vars
@@ -12,5 +12,5 @@ NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
 PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
-PYPI_PKGS='sphinx sphinx-rtd-theme tomli'
+PYPI_PKGS='numpy sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index c4d229830b6..86c6d8bac0f 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -105,6 +105,8 @@ packages:
   - openssh-client
   - pkgconf
   - python3
+  - python3-numpy
+  - python3-opencv
   - python3-pip
   - python3-setuptools
   - python3-sphinx
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index f6fa68d476f..cbdc56369fa 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -106,6 +106,8 @@ packages:
   - openssh-client
   - pkgconf
   - python3
+  - python3-numpy
+  - python3-opencv
   - python3-pip
   - python3-setuptools
   - python3-sphinx
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 6c4cefe97e5..2ce56537208 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -104,6 +104,8 @@ packages:
   - openssh-client
   - pkgconf
   - python3
+  - python3-numpy
+  - python3-opencv
   - python3-pip
   - python3-setuptools
   - python3-sphinx
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index d2d40613167..cb56cdb3da1 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -18,12 +18,18 @@ mappings:
   python3-sphinx-rtd-theme:
     CentOSStream9:
 
+  python3-opencv:
+    CentOSStream9:
+
   python3-venv:
     CentOSStream9: python3.11
 
   python3-wheel:
     CentOSStream9: python3.11-wheel
 
+  python3-numpy:
+    CentOSStream9:
+
   meson:
     # Use Meson from PyPI wherever Rust is enabled
     Debian:
@@ -51,3 +57,9 @@ pypi_mappings:
     apk:
     Fedora:
     Debian12:
+
+  python3-numpy:
+    CentOSStream9: numpy
+
+  python3-opencv:
+    CentOSStream9: opencv-python
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index b3c99936723..abbd3e3f0b8 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -91,6 +91,8 @@ packages:
  - pkg-config
  - pulseaudio
  - python3
+ - python3-numpy
+ - python3-opencv
  - python3-pip
  - python3-setuptools
  - python3-sphinx
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index ee3402f0d2b..c35591b39d6 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -49,9 +49,11 @@
     "ncurses",
     "nettle",
     "ninja",
+    "opencv",
     "pixman",
     "pkgconf",
     "png",
+    "py312-numpy",
     "py312-pip",
     "py312-setuptools",
     "py312-sphinx",
-- 
2.55.0


