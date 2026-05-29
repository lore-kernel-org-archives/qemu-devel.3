Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3C3CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpx8-00022W-2I; Fri, 29 May 2026 01:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwd-0001qq-LY
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwb-00025F-MJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4905529b933so51279655e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033179; x=1780637979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PInaLkLsSHxr2Zu4FVhXd24CuOUOBCp9L2ktyQui7Rg=;
 b=FMNyi1HI24Z81ibesR1i406AlrA/0DldPIc4LvOiXPTdjKw2Bzkczo6+VC62ukHXjT
 CJ+kMr6TRCYz2cauKIKf46HWX/j/+mF/HF9IIMCmgf76eWhfYJ8ZR044w4dPTnM+KnZ0
 ShxMbIoctxzfnRM/rLckzrAPacokCJf3ygwhn5kssCxMuXyBiKyJMBCjqTfufQ+eOpJT
 Kfk8e+vkcqSAROdkMS7jtjrOsOCQR9qb+fGun3HgSV7VQ1cWH/2uYgqU7rY16bxt+okN
 TSya7Q325fobvdC8vh9KRfeRsgx++/Lmg3yoJlpTo9TdfHWQvKvgmuor0kWW0BxW8kFo
 ushg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033179; x=1780637979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PInaLkLsSHxr2Zu4FVhXd24CuOUOBCp9L2ktyQui7Rg=;
 b=s3lxNVOAWIxgvIUoyxnrsmaf9JZ+OBEWKaaz1tI1bm4LnUkhICs33CE/oSVxe9fpWf
 I4xRJEgOpMiTccbKzuWAV9Hwzu4Tg1RNtYIzQqImRS+d62WkR+Kwc6Hk6uEw2jAwBpem
 jDmp7mo63AXvwqT2LS9cqM8f7LObv0cZWZ0HPUIbDgDli3SzgnPfa3luFMpgGQMDfehS
 bN5otXCOCNrmp+TtiUVLxYnOOlHYoiJbnA9ujLtjg/UtzY+gmxLgBHW12JI+DXcRH9Td
 uYbpx1qSIJ53pbs/lutMmkqv3OZvw2eEF5/QpyVAd1PekYAu2RhswGWn/TYUX2KvwX8F
 THsw==
X-Gm-Message-State: AOJu0YxG22SJnNw8cYHQrUndqm6hou9fCthROP6753CU/fRvdlP4DApH
 s2JfJ/PFLC4igHJuqa0w3+ZcArQJS0jP9hzdZK/8dkZzpPgSgddZDvAW9OShOUoircWWKfcnSgv
 zxIlb
X-Gm-Gg: Acq92OE/0cRyAdVLS3norxWHdP/4eem7q1lAu1Fz9ZUSYRzDBq+ErrIPrl23IFdMDOv
 UC83QCouY9oP5t0AsBtJEizW8jd4lr4KIHQITkU8JaFTe4LiH7cdorlEkSg3mVQal4aN3gI1xqW
 52Bvt+Qs7L1xgSAlLjjXgx0mFLLrzfrQLCmVhZcfNHW5y89DoW2zkjGxE9ZuQravpdhZJls9zL2
 mzqrfLclCE/RUb+jmFqC+2IZlL60K0jdvn2AY2mPv3tona3xYPzwgIQCXc9dXNjgGVyFFRfTAxv
 H2qbmWe3hG+lzJ1OfWASVqeSbDKle203CuZHls4RQiGHfHBcFKlMn42DILLWC8FqCb0WfT1CH0N
 WJ3w8rd+dmhR3uQ1SB7uqPN6Njnmwhh/Yi0JMKbcsVJVTImIOgZ6AIpwTcNrqdmwlBEnIl/fy95
 3fNCG8M7FZ7rbr+cGXNYJtpRSas2iJ3m+lhADVRfZqPbFe
X-Received: by 2002:a05:600c:c3cd:10b0:490:469c:556b with SMTP id
 5b1f17b1804b1-4909c08763fmr16497825e9.12.1780033179474; 
 Thu, 28 May 2026 22:39:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca6575csm35023525e9.4.2026.05.28.22.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 624F360335;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/13] ci: drop cirrus MacOS build
Date: Fri, 29 May 2026 06:39:23 +0100
Message-ID: <20260529053931.283970-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260526110243.470002-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 365435b0d70..4be6a9261ee 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -301,7 +301,6 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-14")
-    generate_cirrus("macos-14")
 
     #
     # VM packages lists
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
-- 
2.47.3


