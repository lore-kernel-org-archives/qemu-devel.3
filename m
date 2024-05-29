Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB161C3DA40
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsI-0000jH-BW; Wed, 29 May 2024 12:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLsF-0000dg-9l
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:59 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLry-0003IZ-E8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:59 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5dcb5a0db4so287915166b.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998980; x=1717603780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4c+mzXCPJbcGknUfyxudyAM0HmL0zBvdg6RSd3UrhQ=;
 b=PbMYAr2W+ed4qP8+osUWsE4FAJzReh94RQmv/yX07TSbnrsh4h8CxxczRO2xuZMX+Y
 eDQOTSePmi+WysrJyc6E9EhSbOhtcRMNe2+SY3ctAZeztloGLembUCHPxZRR9Hfy5sty
 +0GRSAMh5sDQuE9EU/y7hDbUpSU0PtHveDOL5aV+s2Cj4Q71bdNzW/TusyZfShOjiwgY
 AFUg/MQIBBGa3dj+DbVpS3eI61c6I2lwnTsrzpD1DVRZu/wJ7HOgUJDUvd8KXdmebxq/
 lLKgNl9isbfP/GBylNuXamJM0NURPLhXktqA8KX8lkFpLjJghkEQHD2fuNwSwc5kGNkm
 dl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998980; x=1717603780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4c+mzXCPJbcGknUfyxudyAM0HmL0zBvdg6RSd3UrhQ=;
 b=Ly4n2xMklqC6fE1AbU0a4rZkmvra+qyNvPHQGM5QjleksQTMRdjV1tk8N0HH8XOcGH
 DE4+baQ6ZWDe0QCE1OghxYJhfUAOIOGEOvbRnZ8YFXs/b4t8E0zav4iGaFmbeJlJEufG
 6V4DiJFKYcRbsH9OVzWIIjYqb3V6tvPCKgmE4uLyY3z5W3KviKKwTC7y/hFQXEVGhcyf
 /S6UnCIzGwOssVQ7PKDJR17AfQUmS/b115j3LEaQdAHDMxFjCgjeIvOOrODSBTPlNAm3
 jiA6p/r5l2seV7P0N5UFWrIfR7nFG4ymkypxrhyZDP6XfhR6qbNqTI+F371Q4fYUBoaK
 YrwQ==
X-Gm-Message-State: AOJu0Yx0GXbIE7i+z4qHHt2ozuzT2npCvvsky45cCS0ZXLjHzkvhkaDc
 8d2fs/Gmj/X9NzMWXgVYHaQTgC0ZYVOosPZvZt9onfbH34s4yuySidVivcj71OQ=
X-Google-Smtp-Source: AGHT+IGuVbshIz6YFklaT35fPuLhovUMpF10xcqsW2MIcqNhMxSfcJhIjb+XHO+Y4nE2UWu7Ktjh6w==
X-Received: by 2002:a17:906:168d:b0:a5d:1334:da86 with SMTP id
 a640c23a62f3a-a6264f12a22mr843322666b.62.1716998980298; 
 Wed, 29 May 2024 09:09:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8c1a1sm729659166b.166.2024.05.29.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF14D5FA93;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 08/10] tests/lcitool: generate package lists for ansible
Date: Wed, 29 May 2024 17:09:32 +0100
Message-Id: <20240529160934.982373-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This includes updating libvirt-ci to the currently in-flight MR:

  https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/488

With the new ability to output YAML we can build the package list for
our ansible setup scripts. We will integrate them in the next commit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - updated to latest revision of MR
---
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  | 127 ++++++++++++++++++
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    | 125 +++++++++++++++++
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/refresh                         |  16 ++-
 4 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml

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
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index a300a26c0d..6e8fa79119 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit a300a26c0d7f48544c40af268b3245ebd63c7351
+Subproject commit 6e8fa79119d131d95502b20051dd84353be57816
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index ace4d08364..3577a411a6 100755
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


