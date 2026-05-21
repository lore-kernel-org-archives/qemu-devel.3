Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF6CD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Hj-00044h-LO; Thu, 21 May 2026 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hf-00041q-6W
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3HZ-0008S3-AI
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so86301305e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369466; x=1779974266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PThoZOxV0LW0fYP1TUUIgrfXheAn9II689EuBa5/Dx4=;
 b=vysnVXVLgNa15kTPutTvD/X+P2uK2930JW9YEN82XQviX126CDBku8DCX5a9Ff/RdE
 c4Gf8h234ZPqpwspmEl8M9oDSGYwzHh7+qiJl8ZjGA0o9NmCLPPAUhPvipJ0/g3rdl8A
 5gvOu7Q69slmG7vD1oRGjuMuG4FLkBB7kQJv2r2/hmSNp6X+MnpF1a8iKS1I7AjqjFgr
 R1bTZKFCUxXynTqYeu/zN8cC4Mby1+/fzFvxPeXJDxWS5YNAeXiSuzfRlAigoDXkB9o5
 WMT6ndoFiHqmUXkh6D3+EgDWoubpwPD4tx+559v0FOR2qWGy9TiyZRwPAsNjUFJh+3d0
 5Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369466; x=1779974266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PThoZOxV0LW0fYP1TUUIgrfXheAn9II689EuBa5/Dx4=;
 b=ba9dpDdxxndEDeVk4L4f9P3WVvGic5yavUH3+eq8bXYPwKW7rMCPoiPvftn1VxD/+D
 S9aKuH8GePKCet/NI7Z2EcFA/hn/xVA8hCzltAAv+6H9eB9je8HvoSi7qEPIxAjo7xxx
 4qLaX5RNwN7DdMTLfbezvZqy01fV0FI8eH8XF7xB2iifYIS2O4QMvVp94Lgs09kOFcGm
 S7x4S8B41pxWrpeYqLFUP3T0FerQY0SGtpKrGFhdz38wrVhDEqGykRCnHF2MnoRYK7nD
 p5dmw41ffEsyxoLBOcJwiVOdog+X1+Lt/CcFoi1AjZYTw+UFSaj3xHgAfbMlmiZ0tt8h
 7ojA==
X-Gm-Message-State: AOJu0YxtWMESD6bOJVfuraqd3V3vg53uj4m977jp1EcmxcVWKVF85/ab
 LcaTu07pugo/vYQOlwUMUMN6aWiCnenUMGjK/lnyE1mB0aUm2RTcLZ4g6etu1BK2KFo=
X-Gm-Gg: Acq92OH8UrSB4BMPXAMf7djvOq+l1F5XMjrTinKpTmbzVIAJFzeMga/q1O+/diIMFxa
 lM2umv/oVrTOsmUVXt8QKDfg/vqp46P/dRVWwfEtxmn/cuM+D8Ml+d/owmnrQ3bu/6nYzwBt4Mr
 d5xWV2ub13mhqvJe9J60gkQtBtPlvIOP6VssdsMqnOP4j+na7PMgOckbv8AVzPtXTKRT5By56ZQ
 tsOEDG3XUN+2VupxNHgFJpoJkd7T3OeN7HTFiC4HwU/WZJHJXPCIGnoSCX7eIqZ/jTgyc2ZkMj6
 xUBb7w/vOimSZzcsB/ScAyOAuGmFsmhG7ztFkqABBCscz5YP/83EliYylaKQylXpOzzsH5O/TH2
 qjTGvuXC9YFgofVA/dfBYOUBLZqfpBX6qR95fN6TDPT8GFpcd/fmSJXEpSBf2jJOK26h4B3zX4J
 okq+a/T9s/3qPHBc9hCqJ6JrE=
X-Received: by 2002:a05:600c:4f51:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-4903607878amr50131935e9.24.1779369466119; 
 Thu, 21 May 2026 06:17:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d52c8bsm71285645e9.8.2026.05.21.06.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4D3E5FA8E;
 Thu, 21 May 2026 14:17:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 05/16] ci: drop cirrus MacOS build
Date: Thu, 21 May 2026 14:17:27 +0100
Message-ID: <20260521131739.540157-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/refresh             |  1 -
 .gitlab-ci.d/cirrus.yml           | 14 --------------
 .gitlab-ci.d/cirrus/macos-14.vars | 16 ----------------
 3 files changed, 31 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

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


