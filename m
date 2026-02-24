Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63BDF4BB6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwxP-0003ww-Qx; Tue, 24 Feb 2026 13:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuwx1-0003Ir-IG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuwww-0002QI-3X
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771956956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1flnAmc/GClOWOe0FW2nBA5PZ7F6mlEYg2eIhz/bPI=;
 b=hIfNWwmOXNc0e2NZ5risA2/gC0Hx8uNt9dkfZENK3p1lLOTaqaiheF7LRUI/quqUJDi/s6
 uWxX/03S3/R7Rry1zOwW6tluvxvXFOx1a8yebmrzvnd2DzlrzsfKCkciztgZ3wwjejch+w
 oDJC7Dmi72EC3YJ43KfBHj755f+CN/k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-vAqlYDOfPYyeWquys2g2Uw-1; Tue,
 24 Feb 2026 13:15:51 -0500
X-MC-Unique: vAqlYDOfPYyeWquys2g2Uw-1
X-Mimecast-MFC-AGG-ID: vAqlYDOfPYyeWquys2g2Uw_1771956949
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82B6E195608E; Tue, 24 Feb 2026 18:15:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D68B21800668; Tue, 24 Feb 2026 18:15:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 10/19] tests/lcitool: add python3 wheel and setuptools deps
 for qemu
Date: Tue, 24 Feb 2026 13:14:29 -0500
Message-ID: <20260224181440.832943-11-jsnow@redhat.com>
In-Reply-To: <20260224181440.832943-1-jsnow@redhat.com>
References: <20260224181440.832943-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

Installing local dependencies while offline, without PyPI access,
requires the python3-setuptools and python3-wheel packages. Most
distributions have these available anyway for one reason or another, but
not all of them.

If you are asking yourself "Wait, aren't these packages guaranteed via
installation of pip, via the ensurepip module, which mkvenv takes
immense pains to provide for us?" - Well... since Python 3.13, "pip"
does not actually come with "setuptools" or "wheel" anymore, and so if
we want to build and install a python package, we actually need these
available in the host environment.

(Note that you don't need these packages just to install a pre-built
package, you only need them to *build* a package. With cutting edge
setuptools and pip, all locally installed packages, even in editable
mode, must be "built" first before being installed. Thus, these
dependencies are being added specifically to facilitate installing
qemu.git/python/qemu to the configure-time venv.)

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260218213416.674483-12-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 .gitlab-ci.d/cirrus/freebsd-14.vars           | 2 +-
 .gitlab-ci.d/windows.yml                      | 2 ++
 tests/docker/dockerfiles/alpine.docker        | 2 ++
 tests/docker/dockerfiles/centos9.docker       | 2 ++
 tests/docker/dockerfiles/opensuse-leap.docker | 1 +
 tests/lcitool/mappings.yml                    | 2 +-
 tests/lcitool/projects/qemu.yml               | 2 ++
 tests/vm/generated/freebsd.json               | 2 ++
 tests/vm/haiku.x86_64                         | 2 ++
 tests/vm/netbsd                               | 1 +
 tests/vm/openbsd                              | 3 +++
 11 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 6477440ef30..98fbde6cc64 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-setuptools py311-sphinx py311-sphinx_rtd_theme py311-tomli py311-wheel python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 5ef4d34d1ea..145500ae464 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -89,6 +89,8 @@ msys2-64bit:
       mingw-w64-x86_64-pkgconf
       mingw-w64-x86_64-python
       mingw-w64-x86_64-python-certifi
+      mingw-w64-x86_64-python-setuptools
+      mingw-w64-x86_64-python-wheel
       mingw-w64-x86_64-rust
       mingw-w64-x86_64-rust-bindgen
       mingw-w64-x86_64-zstd"
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 76d8dd8cfc7..c0303feb48a 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -87,8 +87,10 @@ RUN apk update && \
         py3-numpy \
         py3-pillow \
         py3-pip \
+        py3-setuptools \
         py3-sphinx \
         py3-sphinx_rtd_theme \
+        py3-wheel \
         py3-yaml \
         python3 \
         rpm2cpio \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 90ac1f7fade..6b1aa6dc0de 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -101,9 +101,11 @@ RUN dnf --quiet distro-sync -y && \
                 python3-numpy \
                 python3-pillow \
                 python3-pip \
+                python3-setuptools \
                 python3-sphinx \
                 python3-sphinx_rtd_theme \
                 python3-tomli \
+                python3-wheel \
                 rdma-core-devel \
                 rust \
                 rust-std-static \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index a041d439768..d693f2c6f85 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -98,6 +98,7 @@ RUN zypper update -y && \
            python311-base \
            python311-pip \
            python311-setuptools \
+           python311-wheel \
            rdma-core-devel \
            rust \
            rust-bindgen \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index a749cf8c515..60618971584 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -66,7 +66,7 @@ mappings:
     OpenSUSELeap15: python311-base
 
   python3-wheel:
-    OpenSUSELeap15: python311-pip
+    OpenSUSELeap15: python311-wheel
 
   rust:
     Debian12: rustc-web
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 1ee7dcf3d46..5e34e953514 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -98,11 +98,13 @@ packages:
  - python3-pillow
  - python3-pip
  - python3-PyYAML
+ - python3-setuptools
  - python3-sphinx
  - python3-sphinx-rtd-theme
  - python3-sqlite3
  - python3-tomli
  - python3-venv
+ - python3-wheel
  - rpm2cpio
  - rust
  - rust-std
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index f586827b136..08b6eb61553 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -57,9 +57,11 @@
     "py311-pillow",
     "py311-pip",
     "py311-pyyaml",
+    "py311-setuptools",
     "py311-sphinx",
     "py311-sphinx_rtd_theme",
     "py311-tomli",
+    "py311-wheel",
     "python3",
     "rpm2cpio",
     "rust",
diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
index 529283c39f6..3ea48dc38a1 100755
--- a/tests/vm/haiku.x86_64
+++ b/tests/vm/haiku.x86_64
@@ -80,6 +80,8 @@ class HaikuVM(basevm.BaseVM):
         "ninja",
         "pip",
         "tomli_python310",
+        "wheel_python310",
+        "setuptools_python310",
     ]
 
     BUILD_SCRIPT = """
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 77d17a0dedf..b365045066c 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,6 +31,7 @@ class NetBSDVM(basevm.BaseVM):
         "pkgconf",
         "xz",
         "python313",
+        "py313-wheel",
         "ninja-build",
 
         # gnu tools
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2ea86a01bad..5222041b855 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -60,6 +60,9 @@ class OpenBSDVM(basevm.BaseVM):
 
         # libs: networking
         "libslirp",
+
+        # Python stuff
+        "py3-setuptools",
     ]
 
     BUILD_SCRIPT = """
-- 
2.53.0


