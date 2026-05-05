Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459EAFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKD9V-0001RR-Qd; Tue, 05 May 2026 06:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD9E-0001Lb-54
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKD95-0007wv-G7
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:37:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so65788845e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977414; x=1778582214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zra89p+LjrcYZzKJAGpwVAh4Lg0xHxXtCB71g2w9S5Y=;
 b=RLgRzgonOUXBi/dAF++1f+7wHU2jCAKr8xoo7d8UN56p0X6grqBCBvA7FN4ASl5R/k
 z6+058pSkXgANQMg9BhJPiNQc4rkUpDmjesq61deagFYNumVo9v0YqahMpRxKqf+oONv
 /fpfHKzq5VTZg/rJu9tZnivMhq706B54wQW7+Oq06fklWJK8lftaGB5YY/edCpwRFfa5
 KP40ShX5YxB7b2qr9v5gLCmSzfkyIaM93RyvJx+MMjtzneiOU8v0qbSzagE8w7vsinr+
 xGLGAxq2Q38jQYXFiheqWC6mXxlNtl4XnMY02vnKVeofo5VRFd7YVoLKPZlyqBGecaC5
 aRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977414; x=1778582214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zra89p+LjrcYZzKJAGpwVAh4Lg0xHxXtCB71g2w9S5Y=;
 b=fFNvVmSjgcCont4ppI7NaRy8ZpkvojUGU3kODEDocW4BbUHWkajSrueow4HsFUvoUW
 0flYYy4/QVsS3afzqrOmIYKSeuYs0DHHqXeqKGhT2lFBFlOJyVJXEPJsdDytQbFvWnAb
 Y7elbDr7guewXaxyHH7V4dhr3PQRw7mDeeDUZbPviJ9lAgBfOmpP4wXmxQ9J30fkAcU4
 s7HjNsziF5aiZrzEy20jMoYBuFjlkg52pcywUSoNUfRNDLRYgKN9KhGt3nsdJev6UgAa
 MDg6q5MYavkcy/pMwvq36AsQf4gfUo18cmUzlFlsGwAbxiEBIKBS0EJxFgsAe9o0Yty+
 EGog==
X-Gm-Message-State: AOJu0YxmwDfHNP3L1dNajrXrdv7OYo7HEkMi4V2sxgdQ4JcitURUKfRs
 pCL0BZ09c7ZwGIfo8ErsPKVlJhBm9LA03ndMBvtY99zwTBCTKtZjfCPAVhws7Z8c5C8=
X-Gm-Gg: AeBDiesQv6C1GnfQoUom1+b7YoHhyKl5lVy9yYKPbbTv6Ax1f6F7p3Que3kAbeIUDXM
 hSYkSFs5cABGpEf6neatHUO5pS/O4GZA/cKMtVhbH1qqaDJAeUbR/aKwRU68/kHy6MVJgllbDGT
 KJl+gouCRP6HzQDjUtb/PfU+CXSTZm6cCe1Fsm5lCT1eVSaCCIEfAlBiqZ02nluN/dW7Ykns98B
 nDHm0OVCZ2eUrzVkDg8pkcJPGcQTzz3Et5EustAKdymCG3tnck+cUZlhi16VQ6GXidsMPaTdU+2
 gYiD27mXGF04TU+/DAdxcWC66gJ5B1g9JUfk3V5LxM2B9Hk6AXIDUzKSMUoKMT+9wOWUw70YlFL
 FD27qLEAKCDaeuwKhSkDvYV48AyterFozFcTiy7oUZkAz2Mr8kTV+ENQE7NDjcdZ2jmpQ3e2cKI
 TIuz/EW5DrPRK6MHsseFaM4vNxhbgHKa9U/Q==
X-Received: by 2002:a05:6000:268a:b0:44f:da08:18f2 with SMTP id
 ffacd0b85a97d-44fda0818fdmr5946685f8f.12.1777977413617; 
 Tue, 05 May 2026 03:36:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02802sm3501679f8f.17.2026.05.05.03.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:36:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E78FD5F9CD;
 Tue, 05 May 2026 11:36:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] ci: drop cirrus MacOS build
Date: Tue,  5 May 2026 11:36:47 +0100
Message-ID: <20260505103649.68361-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505103649.68361-1-alex.bennee@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

CirrusCI is closing down soon so time to migrate.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/cirrus.yml           | 14 --------------
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ----------------
 tests/lcitool/refresh             |  1 -
 3 files changed, 31 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index f2a9a64b76a..b71ab090b65 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -44,17 +44,3 @@ x64-freebsd-14-build:
     INSTALL_COMMAND: pkg install -y
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu --enable-rust
     TEST_TARGETS: check
-
-aarch64-macos-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: macos-14
-    CIRRUS_VM_INSTANCE_TYPE: macos_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-runner:sonoma
-    UPDATE_COMMAND: brew update
-    INSTALL_COMMAND: brew install
-    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
-    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu --enable-rust
-    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
deleted file mode 100644
index def77cfdea5..00000000000
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables macos-14 qemu
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
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
-PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e4d01d792b7..fa4a16e3583 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -311,7 +311,6 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-14")
-    generate_cirrus("macos-14")
 
     #
     # VM packages lists
-- 
2.47.3


