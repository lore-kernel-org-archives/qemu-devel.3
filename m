Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA6C35FFB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTvt-0007aY-W1; Tue, 17 Sep 2024 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvo-0007V6-Vt
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTve-0008WT-3m
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso53332645e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563072; x=1727167872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1+M6zkfEBX1OMy70pQcqHZElyhMK4N/jFaUZEQCrcQ=;
 b=uZ3UjKEVZszzgWUbSekWuTgizkRU/MME7s/NGswsWXKT/ipbypq1Bl8BDdUaSrS4ce
 8fHnD46STVmbYSfQiFSa8jO3fholo6wloUvgeA+5in/uCSLQT8JHucrhXbqdFQ+IzBw7
 PIAZ5nAYmEUbNBpzSb1XShBuyWbU6FmjpSJJF1miZb7Bm11Bqu+vHaoQJnLmi31Lt4Gl
 3orJsNXNG/92aJSbKkmZzH+WomW7MCDGzyhglSH0QzHIN9XFde1/Q2YmHliCTL2ny7Tz
 8wiZDn3aaWnImOXBuTjKGVeM2OgmjpUajeFtk1KOfytLa/YgzrIaRgr7PNWtPpnXD7kE
 DG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563072; x=1727167872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1+M6zkfEBX1OMy70pQcqHZElyhMK4N/jFaUZEQCrcQ=;
 b=FsBSV5m7S2Oxj3ccxduYWT/RDjWO/SsOBnufcMvFnmsiLi7d9M0v7CCVhr/KEJ+bE8
 uKszoqBFLNzpnU2/cnjK9iP5tzIn/iWEFk/f1gb1BJA1AnLBETM7OeLysi78DFU9NhEE
 tDr0MHkVphgwIdVx5c9eg9AEzETpAItxp6WRshx2RJtX4klZdXzwhuCjOhkB/J9S0P0f
 42i9M11OfLne8HzI2yak6J0joqTmsu1a68ogj45KNjlkgA/rUdMJ7C7NQtF8XrTfEL7B
 PrWbffTTvrVpty6T5nYvLiqMbQA1fjHd/aw9frfdc6pFW5GuOTPMTK2sfMn63wiQ47mS
 P1+Q==
X-Gm-Message-State: AOJu0Yz3718zUwv+aFZyIOUKbwG3QOv6+ILgb874uP2UnIuEIkqGXjvB
 lCtzd9SZHGU80w5WvGsdQP+C/V9eTBgCQ8sEcKQ88uSYIVpCXaoWpEwnbM6PJJou/L3zT/zMa6c
 Sw8o=
X-Google-Smtp-Source: AGHT+IHpwmGZ5HNwM+opd9KtNIQ0Fndg7C6UtV53Xckwx+8+THHAm2n2pgiVDvRkm2NNhPfSxao0DA==
X-Received: by 2002:a05:600c:19c6:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-42cdb5913f2mr118915295e9.31.1726563072186; 
 Tue, 17 Sep 2024 01:51:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.131.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b1947f9sm132235885e9.41.2024.09.17.01.51.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Sep 2024 01:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/3] .gitlab-ci.d/cirrus: Drop support for macOS 13 (Ventura)
Date: Tue, 17 Sep 2024 10:50:57 +0200
Message-ID: <20240917085058.1740-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240917085058.1740-1-philmd@linaro.org>
References: <20240917085058.1740-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

macOS 15 "Sequoia" was released on September 16, 2024 [1].

According to QEMU's support policy, we stop supporting
the previous major release two years after the the new
major release has been published. Time to remove support
for macOS 13 (Ventura, released on October 2022, [2]).

Promote the macOS 14 job, which was only built manually,
to be run by default.

[1] https://www.apple.com/newsroom/2024/09/macos-sequoia-is-available-today/
[2] https://www.apple.com/newsroom/2022/10/macos-ventura-is-now-available/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .gitlab-ci.d/cirrus.yml           | 17 -----------------
 .gitlab-ci.d/cirrus/macos-13.vars | 16 ----------------
 tests/lcitool/refresh             |  1 -
 3 files changed, 34 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/macos-13.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 92c97eefc1..f061687f1b 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -60,22 +60,6 @@ x64-freebsd-14-build:
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
     TEST_TARGETS: check
 
-aarch64-macos-13-base-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: macos-13
-    CIRRUS_VM_INSTANCE_TYPE: macos_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
-    CIRRUS_VM_CPUS: 12
-    CIRRUS_VM_RAM: 24G
-    UPDATE_COMMAND: brew update
-    INSTALL_COMMAND: brew install
-    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
-    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
-    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-
 aarch64-macos-14-base-build:
   extends: .cirrus_build_job
   variables:
@@ -90,4 +74,3 @@ aarch64-macos-14-base-build:
     PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-    QEMU_JOB_OPTIONAL: 1
diff --git a/.gitlab-ci.d/cirrus/macos-13.vars b/.gitlab-ci.d/cirrus/macos-13.vars
deleted file mode 100644
index ac3fa3a847..0000000000
--- a/.gitlab-ci.d/cirrus/macos-13.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables macos-13 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-CCACHE='/opt/homebrew/bin/ccache'
-CPAN_PKGS=''
-CROSS_PKGS=''
-MAKE='/opt/homebrew/bin/gmake'
-NINJA='/opt/homebrew/bin/ninja'
-PACKAGING_COMMAND='brew'
-PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
-PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 92381f3c46..d111b01480 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -202,7 +202,6 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-14")
-    generate_cirrus("macos-13")
     generate_cirrus("macos-14")
 
     #
-- 
2.45.2


