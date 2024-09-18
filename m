Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596DDCCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squCz-0003gi-PC; Wed, 18 Sep 2024 08:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squCv-0003Yd-OW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squCs-0002pO-2F
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374d29ad8a7so4756576f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726664092; x=1727268892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG+Q8S7Fct5ef/VuA95TQ7RdVMOBfi9LTalM/pVY76g=;
 b=nZ4uQSziFqvC6DmS1XVLpOFijMpRNxsA1stNjDT+LL1z3bQbuQwZZdYtEnP0IiS1Yn
 pIUbTMn7sK7a6xOg92PdNmj160kPtlewD/kM0+djNNHDjfZX9B48D70OEZWTEZTC8Vy8
 yIL7K9MeMajcXZIqjwwu3biM5mHsZr23so0q/lrO0h4FA3BEinNozNTztXyf/SnrmYlL
 L9L6ri9zjJxlRcuW7Cgxi5UWf9SLq8CVZv+/rBteiFR0C7G9amOUo4k9AINSnigkfxed
 QYu2pcG/yGJBv8pWc4hTUqEZZP4Ls38kaGa7moqwt3neV6BY6aA/f54RtoJan0Mgombq
 fv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664092; x=1727268892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG+Q8S7Fct5ef/VuA95TQ7RdVMOBfi9LTalM/pVY76g=;
 b=eVbLnWGpk1Ws7aKtq0adq940phwUn5tG3XLixgtKG1VIyG7s534gFy2A8DM11SxDM4
 stbz+hdsvbqylqSdiqFTwaXmKbKhjo0h8Rsw6cgGKuW4CG7Tf6mZLSg63P4Eiu7C4OxE
 EXOiAQ013gR4koZXmPW59Y45stqUTH7SgDqyCvyfF7zIrU4MJgf8R5tRtkCYRXL8E6to
 0d1S6CjHhhypOVxVDJV9RhTxAf4fipuAwObV3JmgjInjvCbTEvNoW4vNDzfBd+tZQUmp
 wldVdgNBRKAIXE9XFyJKkSKb3bfNMZGRBTlmmsCQZp6GYcrGPUbs9A42aF3rf74MsQSP
 dDdw==
X-Gm-Message-State: AOJu0Yxo5J6B4b45QcXNwSCA6KBkESs6UVjakoJIKCdDkLtd2k4X1unq
 T1N73bhL+quSVoinGYet2l01aqL65CMjWkP7TDmuDes1GR/6yg+7CG5olDfpS4x1aYatAidB5SF
 h
X-Google-Smtp-Source: AGHT+IEcMktMLkLRiG9fFlQ0vXktisDT0E+rpzj+sgkqzy5ZxbfY1M00cK7fnDf7jboLibneT1jp5A==
X-Received: by 2002:a5d:6789:0:b0:374:b960:f847 with SMTP id
 ffacd0b85a97d-378c2d51750mr11808484f8f.41.1726664092065; 
 Wed, 18 Sep 2024 05:54:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7051335fsm16410645e9.30.2024.09.18.05.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:54:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 2/2] .gitlab-ci.d: Make separate collapsible log sections for
 build and test
Date: Wed, 18 Sep 2024 13:54:49 +0100
Message-Id: <20240918125449.3125571-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918125449.3125571-1-peter.maydell@linaro.org>
References: <20240918125449.3125571-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

GitLab lets a CI job create its own collapsible log sections by
emitting special escape codes, as documented here:

https://docs.gitlab.com/ee/ci/yaml/script.html#expand-and-collapse-job-log-sections

Use these to make "configure", "build" and "test" separate
collapsible stages.

As recommended by the GitLab docs, we use some shell which is
sourced in the CI job to define functions to emit the magic
lines that start and end sections, to hide the ugliness of
the printf lines from the log.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/buildtest-template.yml  | 14 ++++++++++++++
 .gitlab-ci.d/buildtest.yml           |  1 +
 .gitlab-ci.d/crossbuild-template.yml | 25 ++++++++++++++++++++++++
 scripts/ci/gitlab-ci-section         | 29 ++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 scripts/ci/gitlab-ci-section

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 5f2fc7e6f49..8c69c60d215 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -8,8 +8,11 @@
     key: "$CI_JOB_NAME"
     when: always
   before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
     - JOBS=$(expr $(nproc) + 1)
     - cat /packages.txt
+    - section_end setup
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
@@ -19,6 +22,7 @@
     - mkdir build
     - cd build
     - ccache --zero-stats
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
@@ -27,11 +31,16 @@
       then
         pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
       fi || exit 1;
+    - section_end configure
+    - section_start build "Building QEMU"
     - $MAKE -j"$JOBS"
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
     - ccache --show-stats
 
 # We jump some hoops in common_test_job_template to avoid
@@ -54,6 +63,8 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
     - meson subprojects download $(cd build/subprojects && echo *)
     - cd build
@@ -63,7 +74,10 @@
     - if [ "x${QEMU_TEST_CACHE_DIR}" != "x" ]; then
         $MAKE precache-functional ;
       fi
+    - section_end buildenv
+    - section_start test "Running tests"
     - $MAKE NINJA=":" $MAKE_CHECK_ARGS
+    - section_end test
 
 .native_test_job_template:
   extends: .common_test_job_template
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 2ab8c4806e4..87848c2ffe8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -188,6 +188,7 @@ build-previous-qemu:
     # Override the default flags as we need more to grab the old version
     GIT_FETCH_EXTRA_FLAGS: --prune --quiet
   before_script:
+    - source scripts/ci/gitlab-ci-section
     - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
     - git remote add upstream https://gitlab.com/qemu-project/qemu
     - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index d1cb7a35dbf..45a98103554 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -9,8 +9,11 @@
     when: always
   timeout: 80m
   before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
     - JOBS=$(expr $(nproc) + 1)
     - cat /packages.txt
+    - section_end setup
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
@@ -19,22 +22,30 @@
     - mkdir build
     - cd build
     - ccache --zero-stats
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
         --target-list-exclude="arm-softmmu
           i386-softmmu microblaze-softmmu mips-softmmu mipsel-softmmu
           mips64-softmmu ppc-softmmu riscv32-softmmu sh4-softmmu
           sparc-softmmu xtensa-softmmu $CROSS_SKIP_TARGETS"
+    - section_end configure
+    - section_start build "Building QEMU"
     - make -j"$JOBS" all check-build
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
+    - section_start installer "Building the installer"
     - if grep -q "EXESUF=.exe" config-host.mak;
       then make installer;
       version="$(git describe --match v[0-9]* 2>/dev/null || git rev-parse --short HEAD)";
       mv -v qemu-setup*.exe qemu-setup-${version}.exe;
       fi
+    - section_end installer
     - ccache --show-stats
 
 # Job to cross-build specific accelerators.
@@ -52,6 +63,7 @@
       - ccache/
     key: "$CI_JOB_NAME"
   before_script:
+    - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
     - export CCACHE_BASEDIR="$(pwd)"
@@ -60,13 +72,19 @@
     - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
     - mkdir build
     - cd build
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
         --disable-tools --enable-${ACCEL:-kvm} $EXTRA_CONFIGURE_OPTS
+    - section_end configure
+    - section_start build "Building QEMU"
     - make -j"$JOBS" all check-build
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
 
 .cross_user_build_job:
   extends: .base_job_template
@@ -77,6 +95,7 @@
       - ccache/
     key: "$CI_JOB_NAME"
   before_script:
+    - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
     - export CCACHE_BASEDIR="$(pwd)"
@@ -84,16 +103,22 @@
     - export CCACHE_MAXSIZE="500M"
     - mkdir build
     - cd build
+    - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
         --disable-system --target-list-exclude="aarch64_be-linux-user
           alpha-linux-user m68k-linux-user microblazeel-linux-user
           or1k-linux-user ppc-linux-user sparc-linux-user
           xtensa-linux-user $CROSS_SKIP_TARGETS"
+    - section_end configure
+    - section_start build "Building QEMU"
     - make -j"$JOBS" all check-build
+    - section_end build
+    - section_start test "Running tests"
     - if test -n "$MAKE_CHECK_ARGS";
       then
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
+    - section_end test
 
 # We can still run some tests on some of our cross build jobs. They can add this
 # template to their extends to save the build logs and test results
diff --git a/scripts/ci/gitlab-ci-section b/scripts/ci/gitlab-ci-section
new file mode 100644
index 00000000000..9bbe80420d6
--- /dev/null
+++ b/scripts/ci/gitlab-ci-section
@@ -0,0 +1,29 @@
+# Copyright (c) 2024 Linaro Ltd
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# gitlab-ci-section: This is a shell script fragment which defines
+# functions section_start and section_end which will emit marker lines
+# that GitLab will interpret as the beginning or end of a "collapsible
+# section" in a CI job log. See
+# https://docs.gitlab.com/ee/ci/yaml/script.html#expand-and-collapse-job-log-sections
+#
+# This is intended to be sourced in the before_script section of
+# a CI config; the section_start and section_end functions will
+# then be available for use in the before_script and script sections.
+
+# Section names are [-_.A-Za-z0-9] and the section_start pairs with
+# a section_end with the same section name.
+# The description can be any printable text without newlines; this is
+# what will appear in the log.
+
+# Usage:
+# section_start section_name "Description of the section"
+section_start () {
+    printf "section_start:%s:%s\r\e[0K%s\n" "$(date +%s)" "$1" "$2"
+}
+
+# Usage:
+# section_end section_name
+section_end () {
+    printf "section_end:%s:%s\r\e[0K\n" "$(date +%s)" "$1"
+}
-- 
2.34.1


