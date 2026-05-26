Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6959BCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ3-0002h0-VE; Tue, 26 May 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYm-0002ZW-4c
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYh-00064U-GF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so6600380f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793369; x=1780398169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghWjWHQ0gH7GDcjsPPLJuO9OGZOWgMGWzpLqAqoM+Go=;
 b=nkOgSfogiBYADtLCewGXGNxg/ue8ysf2gK15F5WYbWHzQ1LxFAG19FF42slyo5oI8/
 YUJQRp1U/YWQyY7+OoVZtwIKTqmbPlazR1PZiZaWox2JYeR8cmC5Y9RMnuKi4ny2u8Gn
 dan56ET620M1BTCA3L7KcHfkLooa5plsPddGV79z+22LTkIU8kZGfYDqDzkPeEk6c+XP
 KMNCNqlp9CmFggE4IDH6x+BMc5u+ccWRVJtjwZ7eGNuE2rvXyTo5BekQAakvCcNAD+Zy
 sWwdKs5q59NU0crrDbXls81IzpRYJYcdmyr01qVP3LRdCN4b20vuszfpXjrq63V9XWrQ
 tNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793369; x=1780398169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ghWjWHQ0gH7GDcjsPPLJuO9OGZOWgMGWzpLqAqoM+Go=;
 b=HT97+Y/ZSYc+fbQA16CLvWzyiEVsMOpVByIMdln+QlAmojcO4fBnG1Se8RfnI6feyT
 zXLOx6fQ+pwAGmKBmobMi778lQLo+z9H6Qbt5xsNc9lJcLIp1Qq+27Aco2/O7nAwmOvx
 tlyybylew6Jba844lJDae/Yn8+LnE3jlZjHPv2E8xI0iX6CC1i0UeKJzds7Q8HfpyTBC
 XoM9NpDsC2Blm7hAtFDxP2lzdt9QLKSBxqVJlonOU9iD2vVQbWbtrgpSMwNjsfVq890m
 RSRo+iDHiywGMFINir6eCydZoI+2joPPHP9KvNjL5ICW7C6KeVqTeTPIBEDQgpilDf8x
 6B/Q==
X-Gm-Message-State: AOJu0YyaA3jrVIjlvAxzNqOK9Vlr7T01F0u4TTV/w0bVOdQPFCHd+917
 Gf4oIj0SyCkNtLHiXNfcFDIcGmOdWp0szvrhcG7cjd6IPJco+5bkPblfZnxraZ80Lpg=
X-Gm-Gg: Acq92OHeyDwhnQeqqNsmIYokN6afxKXp603LQ30WXoTH/MZilrqOJA/AFJCJUSfjI0S
 01D7OWvepsGHQlVfEgdV8vtlWeSAhxnPLxZh0FFew4QGar4uOV8+Tv+7uLdEfaffhCLw1ENdNIh
 PosDvhiNGrDx7c6dwBifqDftVtiRX8jiW7hrWAr94Tkm0mQjO0gLR0pseJkiiTtc7Tfnd88BVR2
 rUpqnoPCsl2RBpT8e0oMKSHZc6Mm5ecxWvSaCOkaXBLvddvtxQAnCFgbjTwbkYW4r+tYZmyH6in
 Q6U5l1/lzUN4+DwAou8toi1/CM9TFsIRaJwkh2brhM5PLHEJSpfhqA22x0qL1xvW6cRYG3XUFii
 t8L5wmi+sw9QADeGvsRJwQLOE1YgPi92QsBkGTAcR32ODJH8JkDGIQyQ+VUdRwAlYmfHFG6kdnQ
 Q6b95thSYqYmL7bdsyXu8Zj0I=
X-Received: by 2002:a05:6000:2283:b0:43e:a8d8:f3dc with SMTP id
 ffacd0b85a97d-45ea31626abmr36235170f8f.13.1779793368989; 
 Tue, 26 May 2026 04:02:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4903bsm32113650f8f.21.2026.05.26.04.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0361760373;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 05/14] ci: drop cirrus MacOS build
Date: Tue, 26 May 2026 12:02:33 +0100
Message-ID: <20260526110243.470002-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/refresh             |  1 -
 .gitlab-ci.d/cirrus.yml           | 14 --------------
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ----------------
 3 files changed, 31 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

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


