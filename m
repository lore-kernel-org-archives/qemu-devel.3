Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A67C27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe6-0007oJ-3d; Thu, 06 Jun 2024 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe3-0007mF-Sp
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe0-0000tg-QO
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:03 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b7c82e39eso926335e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674658; x=1718279458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBlMBkLWYWGokSaLB9pj45So7IsxTXXq9NxV7kl0WyA=;
 b=QdAryM+u+LfQ1dIJHuyoQ/AimauZY66DtxO4pXwr/vPA3pxAlni3Lh2ccPuF8P1Jrl
 qcvz7Si/bjzKiOCKvsVucjOuUUwrIIH0NEndeZUOJE71URjnuPFvCFnjebHM0TF1jzMD
 3PWD4tzWLJIKOcS1giScQaOXq7/LplNfbVQNLmQJLNxih5vhAIqfH3E8Sgi0/lNAgiFe
 liVkhtm3D5+ZG8dyNIB5UIV+YizJqxSEIpdHttk7ChZz93k9I54tOP+ObIV6+9tv3XnJ
 R2pzF93nf7w7YXKPpmmRGlU+9PyqQdNOqRVI0UWhynMYR9Q8K4tUzP/ntcFoGwRuKnga
 BbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674658; x=1718279458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBlMBkLWYWGokSaLB9pj45So7IsxTXXq9NxV7kl0WyA=;
 b=aTCicxIhsDhfLN73690Pjsekup3fjNwHHqBos9E/1UecSp5zs2E5iNunYHhwoh4xRU
 WJLh71bPHdeCDWkXtBpNEGzPdgpVlYoUGvl2KF+eD2FvCwRtEKLz9wj0Bj6ybiXkSpBO
 Pz3BVfgVgHoACV5h6zDbFUrZ19gFHz8ZwgxcHX3+pu2TUg9ofFBIEGmNCRFzmkVLdRUW
 mDNrwcErJB6zQ/GhURCNQOzdXcjDc8HezHGvT+HgdeT4ZM0+f4kNaqBeBZ6BuXnMtoBd
 +zSe/h9wwJVYfmJLFvUf5rYrhSbSIpadolyOYIYa9OxMIH8cvNpYIlYolB53fOypySfy
 1lDg==
X-Gm-Message-State: AOJu0YyA6rRzVGM7P2nstYbZ/aT57WgxeTfy8mQB0TLZJJyXmEpBdsHn
 tUR+YInOl++6EY+ZvTGHFb8P3fdkLQGWi8QZZl7hgFt9OC5DS2naPLuLpQBu28c=
X-Google-Smtp-Source: AGHT+IGfFiyYmWNEt1YKxjNQ7RkpY5WfhDxyik8dq9fOoAtRd8Aok7Zdub6nWIooxgMfHf+VChPFHQ==
X-Received: by 2002:a2e:b619:0:b0:2e7:2d1f:edbd with SMTP id
 38308e7fff4ca-2eac7a715b1mr40573801fa.39.1717674657969; 
 Thu, 06 Jun 2024 04:50:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9ea35sm957024a12.15.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F110A5FA1A;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 11/12] tests/lcitool: generate package lists for ansible
Date: Thu,  6 Jun 2024 12:50:46 +0100
Message-Id: <20240606115047.421045-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With the new ability to output YAML we can build the package list for
our ansible setup scripts. We will integrate them in the next commit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-12-alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
new file mode 100644
index 0000000000..8d7d8725fb
--- /dev/null
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -0,0 +1,127 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables --host-arch aarch64 ubuntu-2204 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+packages:
+  - bash
+  - bc
+  - bison
+  - bsdextrautils
+  - bzip2
+  - ca-certificates
+  - ccache
+  - clang
+  - dbus
+  - debianutils
+  - diffutils
+  - exuberant-ctags
+  - findutils
+  - flex
+  - gcc
+  - gcovr
+  - gettext
+  - git
+  - hostname
+  - libaio-dev
+  - libasan6
+  - libasound2-dev
+  - libattr1-dev
+  - libbpf-dev
+  - libbrlapi-dev
+  - libbz2-dev
+  - libc6-dev
+  - libcacard-dev
+  - libcap-ng-dev
+  - libcapstone-dev
+  - libcmocka-dev
+  - libcurl4-gnutls-dev
+  - libdaxctl-dev
+  - libdrm-dev
+  - libepoxy-dev
+  - libfdt-dev
+  - libffi-dev
+  - libfuse3-dev
+  - libgbm-dev
+  - libgcrypt20-dev
+  - libglib2.0-dev
+  - libglusterfs-dev
+  - libgnutls28-dev
+  - libgtk-3-dev
+  - libibumad-dev
+  - libibverbs-dev
+  - libiscsi-dev
+  - libjemalloc-dev
+  - libjpeg-turbo8-dev
+  - libjson-c-dev
+  - liblttng-ust-dev
+  - liblzo2-dev
+  - libncursesw5-dev
+  - libnfs-dev
+  - libnuma-dev
+  - libpam0g-dev
+  - libpcre2-dev
+  - libpipewire-0.3-dev
+  - libpixman-1-dev
+  - libpng-dev
+  - libpulse-dev
+  - librbd-dev
+  - librdmacm-dev
+  - libsasl2-dev
+  - libsdl2-dev
+  - libsdl2-image-dev
+  - libseccomp-dev
+  - libselinux1-dev
+  - libslirp-dev
+  - libsnappy-dev
+  - libsndio-dev
+  - libspice-protocol-dev
+  - libspice-server-dev
+  - libssh-dev
+  - libsystemd-dev
+  - libtasn1-6-dev
+  - libubsan1
+  - libudev-dev
+  - liburing-dev
+  - libusb-1.0-0-dev
+  - libusbredirhost-dev
+  - libvdeplug-dev
+  - libvirglrenderer-dev
+  - libvte-2.91-dev
+  - libxen-dev
+  - libzstd-dev
+  - llvm
+  - locales
+  - make
+  - meson
+  - mtools
+  - multipath-tools
+  - ncat
+  - nettle-dev
+  - ninja-build
+  - openssh-client
+  - pkgconf
+  - python3
+  - python3-numpy
+  - python3-opencv
+  - python3-pillow
+  - python3-pip
+  - python3-sphinx
+  - python3-sphinx-rtd-theme
+  - python3-tomli
+  - python3-venv
+  - python3-yaml
+  - rpm2cpio
+  - sed
+  - socat
+  - sparse
+  - swtpm
+  - systemtap-sdt-dev
+  - tar
+  - tesseract-ocr
+  - tesseract-ocr-eng
+  - xorriso
+  - zlib1g-dev
+  - zstd
+
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
new file mode 100644
index 0000000000..0cc34cd10b
--- /dev/null
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
@@ -0,0 +1,127 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+packages:
+  - bash
+  - bc
+  - bison
+  - bsdextrautils
+  - bzip2
+  - ca-certificates
+  - ccache
+  - dbus
+  - debianutils
+  - diffutils
+  - exuberant-ctags
+  - findutils
+  - flex
+  - gcc
+  - gcovr
+  - gettext
+  - git
+  - hostname
+  - libglib2.0-dev
+  - libpcre2-dev
+  - libsndio-dev
+  - libspice-protocol-dev
+  - llvm
+  - locales
+  - make
+  - meson
+  - mtools
+  - ncat
+  - ninja-build
+  - openssh-client
+  - pkgconf
+  - python3
+  - python3-numpy
+  - python3-opencv
+  - python3-pillow
+  - python3-pip
+  - python3-sphinx
+  - python3-sphinx-rtd-theme
+  - python3-tomli
+  - python3-venv
+  - python3-yaml
+  - rpm2cpio
+  - sed
+  - socat
+  - sparse
+  - swtpm
+  - tar
+  - tesseract-ocr
+  - tesseract-ocr-eng
+  - xorriso
+  - zstd
+  - gcc-arm-linux-gnueabihf
+  - libaio-dev:armhf
+  - libasan6:armhf
+  - libasound2-dev:armhf
+  - libattr1-dev:armhf
+  - libbpf-dev:armhf
+  - libbrlapi-dev:armhf
+  - libbz2-dev:armhf
+  - libc6-dev:armhf
+  - libcacard-dev:armhf
+  - libcap-ng-dev:armhf
+  - libcapstone-dev:armhf
+  - libcmocka-dev:armhf
+  - libcurl4-gnutls-dev:armhf
+  - libdaxctl-dev:armhf
+  - libdrm-dev:armhf
+  - libepoxy-dev:armhf
+  - libfdt-dev:armhf
+  - libffi-dev:armhf
+  - libfuse3-dev:armhf
+  - libgbm-dev:armhf
+  - libgcrypt20-dev:armhf
+  - libglib2.0-dev:armhf
+  - libglusterfs-dev:armhf
+  - libgnutls28-dev:armhf
+  - libgtk-3-dev:armhf
+  - libibumad-dev:armhf
+  - libibverbs-dev:armhf
+  - libiscsi-dev:armhf
+  - libjemalloc-dev:armhf
+  - libjpeg-turbo8-dev:armhf
+  - libjson-c-dev:armhf
+  - liblttng-ust-dev:armhf
+  - liblzo2-dev:armhf
+  - libncursesw5-dev:armhf
+  - libnfs-dev:armhf
+  - libnuma-dev:armhf
+  - libpam0g-dev:armhf
+  - libpipewire-0.3-dev:armhf
+  - libpixman-1-dev:armhf
+  - libpng-dev:armhf
+  - libpulse-dev:armhf
+  - librbd-dev:armhf
+  - librdmacm-dev:armhf
+  - libsasl2-dev:armhf
+  - libsdl2-dev:armhf
+  - libsdl2-image-dev:armhf
+  - libseccomp-dev:armhf
+  - libselinux1-dev:armhf
+  - libslirp-dev:armhf
+  - libsnappy-dev:armhf
+  - libspice-server-dev:armhf
+  - libssh-dev:armhf
+  - libsystemd-dev:armhf
+  - libtasn1-6-dev:armhf
+  - libubsan1:armhf
+  - libudev-dev:armhf
+  - liburing-dev:armhf
+  - libusb-1.0-0-dev:armhf
+  - libusbredirhost-dev:armhf
+  - libvdeplug-dev:armhf
+  - libvirglrenderer-dev:armhf
+  - libvte-2.91-dev:armhf
+  - libxen-dev:armhf
+  - libzstd-dev:armhf
+  - nettle-dev:armhf
+  - systemtap-sdt-dev:armhf
+  - zlib1g-dev:armhf
+
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
new file mode 100644
index 0000000000..16050a5058
--- /dev/null
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -0,0 +1,125 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables --host-arch s390x ubuntu-2204 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+packages:
+  - bash
+  - bc
+  - bison
+  - bsdextrautils
+  - bzip2
+  - ca-certificates
+  - ccache
+  - clang
+  - dbus
+  - debianutils
+  - diffutils
+  - exuberant-ctags
+  - findutils
+  - flex
+  - gcc
+  - gcovr
+  - gettext
+  - git
+  - hostname
+  - libaio-dev
+  - libasan6
+  - libasound2-dev
+  - libattr1-dev
+  - libbpf-dev
+  - libbrlapi-dev
+  - libbz2-dev
+  - libc6-dev
+  - libcacard-dev
+  - libcap-ng-dev
+  - libcapstone-dev
+  - libcmocka-dev
+  - libcurl4-gnutls-dev
+  - libdaxctl-dev
+  - libdrm-dev
+  - libepoxy-dev
+  - libfdt-dev
+  - libffi-dev
+  - libfuse3-dev
+  - libgbm-dev
+  - libgcrypt20-dev
+  - libglib2.0-dev
+  - libglusterfs-dev
+  - libgnutls28-dev
+  - libgtk-3-dev
+  - libibumad-dev
+  - libibverbs-dev
+  - libiscsi-dev
+  - libjemalloc-dev
+  - libjpeg-turbo8-dev
+  - libjson-c-dev
+  - liblttng-ust-dev
+  - liblzo2-dev
+  - libncursesw5-dev
+  - libnfs-dev
+  - libnuma-dev
+  - libpam0g-dev
+  - libpcre2-dev
+  - libpipewire-0.3-dev
+  - libpixman-1-dev
+  - libpng-dev
+  - libpulse-dev
+  - librbd-dev
+  - librdmacm-dev
+  - libsasl2-dev
+  - libsdl2-dev
+  - libsdl2-image-dev
+  - libseccomp-dev
+  - libselinux1-dev
+  - libslirp-dev
+  - libsnappy-dev
+  - libsndio-dev
+  - libspice-protocol-dev
+  - libssh-dev
+  - libsystemd-dev
+  - libtasn1-6-dev
+  - libubsan1
+  - libudev-dev
+  - liburing-dev
+  - libusb-1.0-0-dev
+  - libusbredirhost-dev
+  - libvdeplug-dev
+  - libvirglrenderer-dev
+  - libvte-2.91-dev
+  - libzstd-dev
+  - llvm
+  - locales
+  - make
+  - meson
+  - mtools
+  - multipath-tools
+  - ncat
+  - nettle-dev
+  - ninja-build
+  - openssh-client
+  - pkgconf
+  - python3
+  - python3-numpy
+  - python3-opencv
+  - python3-pillow
+  - python3-pip
+  - python3-sphinx
+  - python3-sphinx-rtd-theme
+  - python3-tomli
+  - python3-venv
+  - python3-yaml
+  - rpm2cpio
+  - sed
+  - socat
+  - sparse
+  - swtpm
+  - systemtap-sdt-dev
+  - tar
+  - tesseract-ocr
+  - tesseract-ocr-eng
+  - xorriso
+  - zlib1g-dev
+  - zstd
+
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 9d8e9c6a4a..b25e3ac4dd 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -80,7 +80,7 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
 
 def generate_cirrus(target, trailer=None):
     filename = Path(src_dir, ".gitlab-ci.d", "cirrus", target + ".vars")
-    cmd = lcitool_cmd + ["variables", target, "qemu"]
+    cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
     generate(filename, cmd, trailer)
 
 
@@ -90,6 +90,13 @@ def generate_pkglist(vm, target):
     generate(filename, cmd, None)
 
 
+def generate_yaml(os, target, arch, trailer=None):
+    filename = Path(src_dir, "scripts", "ci", "setup", os, f"{target}-{arch}.yaml")
+    cmd = lcitool_cmd + ["variables", "--format", "yaml", "-a",
+                         arch, target, "qemu"]
+    generate(filename, cmd, trailer)
+
+
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
@@ -209,6 +216,13 @@ try:
     #
     generate_pkglist("freebsd", "freebsd-13")
 
+    #
+    # Ansible package lists
+    #
+    generate_yaml("ubuntu", "ubuntu-2204", "aarch64")
+    generate_yaml("ubuntu", "ubuntu-2204", "s390x")
+
+
     sys.exit(0)
 except Exception as ex:
     print(str(ex), file=sys.stderr)
-- 
2.39.2


