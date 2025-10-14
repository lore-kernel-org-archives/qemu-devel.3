Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F15BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cWW-0005pD-0d; Tue, 14 Oct 2025 06:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVU-0004dE-P8
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVG-0003Xt-5X
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so6844445e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438609; x=1761043409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNf+WB9/HHEpVf98t3lNdtnVbvRPlPY/srMoe1KsGrk=;
 b=vYxkpwhyStJsgyTnCCsHwsc2q1jdP5zvS8Ji24tLgUXP29kiKZLuKdDqeuIc+m1JmU
 KpxKqId55SIr/FBmK2mkYwsqJB14BFD6iFNGMyS6lhJZBg1LZj6Wp6V8yaAFf310Yy9t
 0pXCy9/GRDGFDSbgG+XTn2oLKOiFTZahHDbNdxBjeYGsUd7MrrkoiM++B6m4PDNSkGJE
 lfnIs+frqaadaavhoL1Z7ZuUriCZuyGYWYzeqrAYxLVT+xiHD7nJBQo++iRiOflPX5ty
 uTSyiVVcYUG1ZYQ8pvdg4U6zkhLTB343+kdmjXZ1me3vQnnwhSnhsUcjSaaiYH3/uyq4
 saKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438609; x=1761043409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNf+WB9/HHEpVf98t3lNdtnVbvRPlPY/srMoe1KsGrk=;
 b=Y/aEVzaWMEE3sAZnhTa5nwYVe71y+J/MIstyRBbiN4FTi4qdSJp3yvZs1iW6QB9T46
 aUgRrkyemFcf1zQmIEHmQGw7hRdhXOTpjO80W/bUm4ISS6eqMZtNZb58YVMxwbJ22EdN
 eDH7lH5mUHf9/hllAt5DC6z7kpEFCp4IEnnB8LICxwwYdNNDV5rqnQjnvtz4nJmXfJep
 s7RrDiCuUUdhC40gdlxWvDTpvvZcpO22NuTv/Ghwj52xPBBTR+iz3D91GsFjDSTBYwEM
 l316aZx7V8W+SCR2ORFzGOF5y0t0g6HraQ6/Fd8evyLYIKivZO6Sj0lpRfVhPBEWAp0M
 J1zQ==
X-Gm-Message-State: AOJu0YzLFhmLulEsTi7EAO5oXBU7mqUQ0p+v4qPF9V8/5u1LYXpMstFV
 lTPwwwe0FAJdBP+bIs9NVQBFG2ByQaXn5hXO/U/L9Kk5UE2RNBf0wIbnkoHkdNHXk68=
X-Gm-Gg: ASbGnct1ahr1I4Gdrl7a03SrZw8gkxA4KqQdCYBurLhfOat5CinosuORvfhT4+8HQMe
 fxkW6vmrwbQDq1LqFbeT29Aityu8kYqWGVM+erlr7FLGdXjyfve95dOmCvDN0yWgBDcQW3C0K4r
 g80pZASefOTkO10hX/Bluead4Ib37S/o1k/n3qMuuafb76dkmCtdR5AISsqTvprw5CzS7AcD2g2
 ypRAGCqfSaIBq+1wNMnwvIiJEzU56EhHzXGHt00D0zWHfE9k63D6FeraLWHyIr097AyDWD+zs14
 fgA195LU3/Ar5d8O2Y/2MkwViP7Exq27a5ExvGQgjs0O989tMvvFfwrvdl8UQ4NA+7X9yOC0z4i
 wPplDPVDH0AGgNyCrjRvSjyQSS8QTymh4hB755sm9oH66fiGJPW4/VcKp
X-Google-Smtp-Source: AGHT+IE5oziyVLzMIkHDhEJ8wnG4fD4sgI+5JeehZ5XWbQwN1z03PE5wfCSOix15Sslw5ge5i5kl4w==
X-Received: by 2002:a05:600c:8b54:b0:46f:d897:516f with SMTP id
 5b1f17b1804b1-46fd89758e7mr18901755e9.34.1760438608426; 
 Tue, 14 Oct 2025 03:43:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497b8fcsm234993105e9.2.2025.10.14.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:43:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C97A45F871;
 Tue, 14 Oct 2025 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org
Subject: [PATCH 4/5] scripts/setup: update the armhf overlay
Date: Tue, 14 Oct 2025 11:43:21 +0100
Message-ID: <20251014104323.3023714-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014104323.3023714-1-alex.bennee@linaro.org>
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

We certainly didn't generate the armhf list via lcitool as it couldn't
deal with ubuntu or foreign layers. Now we can properly generate the
list.

Fixes: 1417704564a (tests/lcitool: generate package lists for ansible)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 ...armhf-cross.yml => ubuntu-2404-armhf.yaml} | 65 +++----------------
 tests/lcitool/refresh                         | 11 ++++
 2 files changed, 20 insertions(+), 56 deletions(-)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-armhf-cross.yml => ubuntu-2404-armhf.yaml} (65%)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml
similarity index 65%
rename from scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
rename to scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml
index 0cc34cd10b9..f06f95514bd 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml
@@ -1,64 +1,13 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
+#  $ lcitool variables --host-arch aarch64 --cross-arch armv7l ubuntu-2404 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
 packages:
-  - bash
-  - bc
-  - bison
-  - bsdextrautils
-  - bzip2
-  - ca-certificates
-  - ccache
-  - dbus
-  - debianutils
-  - diffutils
-  - exuberant-ctags
-  - findutils
-  - flex
-  - gcc
-  - gcovr
-  - gettext
-  - git
-  - hostname
-  - libglib2.0-dev
-  - libpcre2-dev
-  - libsndio-dev
-  - libspice-protocol-dev
-  - llvm
-  - locales
-  - make
-  - meson
-  - mtools
-  - ncat
-  - ninja-build
-  - openssh-client
-  - pkgconf
-  - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
-  - python3-pip
-  - python3-sphinx
-  - python3-sphinx-rtd-theme
-  - python3-tomli
-  - python3-venv
-  - python3-yaml
-  - rpm2cpio
-  - sed
-  - socat
-  - sparse
-  - swtpm
-  - tar
-  - tesseract-ocr
-  - tesseract-ocr-eng
-  - xorriso
-  - zstd
   - gcc-arm-linux-gnueabihf
   - libaio-dev:armhf
-  - libasan6:armhf
+  - libasan8:armhf
   - libasound2-dev:armhf
   - libattr1-dev:armhf
   - libbpf-dev:armhf
@@ -68,6 +17,7 @@ packages:
   - libcacard-dev:armhf
   - libcap-ng-dev:armhf
   - libcapstone-dev:armhf
+  - libcbor-dev:armhf
   - libcmocka-dev:armhf
   - libcurl4-gnutls-dev:armhf
   - libdaxctl-dev:armhf
@@ -82,7 +32,7 @@ packages:
   - libglusterfs-dev:armhf
   - libgnutls28-dev:armhf
   - libgtk-3-dev:armhf
-  - libibumad-dev:armhf
+  - libgtk-vnc-2.0-dev:armhf
   - libibverbs-dev:armhf
   - libiscsi-dev:armhf
   - libjemalloc-dev:armhf
@@ -94,11 +44,11 @@ packages:
   - libnfs-dev:armhf
   - libnuma-dev:armhf
   - libpam0g-dev:armhf
+  - libpcre2-dev:armhf
   - libpipewire-0.3-dev:armhf
   - libpixman-1-dev:armhf
   - libpng-dev:armhf
   - libpulse-dev:armhf
-  - librbd-dev:armhf
   - librdmacm-dev:armhf
   - libsasl2-dev:armhf
   - libsdl2-dev:armhf
@@ -107,8 +57,11 @@ packages:
   - libselinux1-dev:armhf
   - libslirp-dev:armhf
   - libsnappy-dev:armhf
+  - libsndio-dev:armhf
+  - libspice-protocol-dev:armhf
   - libspice-server-dev:armhf
   - libssh-dev:armhf
+  - libstd-rust-dev:armhf
   - libsystemd-dev:armhf
   - libtasn1-6-dev:armhf
   - libubsan1:armhf
@@ -119,7 +72,7 @@ packages:
   - libvdeplug-dev:armhf
   - libvirglrenderer-dev:armhf
   - libvte-2.91-dev:armhf
-  - libxen-dev:armhf
+  - libxdp-dev:armhf
   - libzstd-dev:armhf
   - nettle-dev:armhf
   - systemtap-sdt-dev:armhf
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 056cfb6e9d7..8ad45da19c1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -99,6 +99,16 @@ def generate_yaml(os, target, arch, trailer=None):
                          arch, target, "qemu"]
     generate(filename, cmd, trailer)
 
+# an overlay file only cares about the additional packages for cross
+# so we can skip all the host packages needed.
+def generate_cross_overlay_yaml(os, target, arch, name, cross, trailer=None):
+    filename = Path(src_dir, "scripts", "ci", "setup", os, f"{target}-{name}.yaml")
+    cmd = lcitool_cmd + ["variables", "--format", "yaml",
+                         "--layer", "foreign",
+                         "-a", arch, "--cross", cross,
+                         target, "qemu"]
+    generate(filename, cmd, trailer)
+
 
 alpine_extras = [
     "# https://gitlab.alpinelinux.org/alpine/aports/-/issues/17463\n",
@@ -271,6 +281,7 @@ try:
     # Ansible package lists
     #
     generate_yaml("ubuntu", "ubuntu-2404", "aarch64")
+    generate_cross_overlay_yaml("ubuntu", "ubuntu-2404", "aarch64", "armhf", cross="armv7l")
     generate_yaml("ubuntu", "ubuntu-2404", "s390x")
 
 
-- 
2.47.3


