Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CACCCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnKx-0007XM-DH; Mon, 20 Oct 2025 06:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKu-0007W5-VH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:56 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKr-0000fi-Q6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:56 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3dbf11fa9eso801786566b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956911; x=1761561711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jE4c+DzA7hGd1ZZ06SZYxXAmtQ/3gkE36PLjdjn6oR0=;
 b=n1ncR1BrG0gmqAzdkNbPf0jcW59HyjpwSRnLomJkr2D7pVhOpDkmABD+sFR5S3wINs
 n3IV3pe9RMpPiaL3+5spx8S9AzTOsWw5I4n64wvHP8J0s5HTNgh161J/NPtrUyywSYyb
 9zT9P7D2DKU57OofGTYpWorMogvr3BDEiO4IhsyU+kRQ33G/mfL2qX2r3QCmkh0jMexk
 1ZQiXM+nF1d64/jsj7r7TXmewhKNIER9RIG+g3x7PWMe/loVbQcQpNE0xtrmYPjJtly2
 nzMFaqwAajDV1+ZcLSuy6iRFx8IG+kRlmDzafas5om+vK3JRf098tn0IgJM4+DztPMPn
 NlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956911; x=1761561711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jE4c+DzA7hGd1ZZ06SZYxXAmtQ/3gkE36PLjdjn6oR0=;
 b=Iiy8rjxtNpqMbilOufRu85aeBr4EKHHOuMPwf9I4oWjWSoYCtlSJvgNfMUY2TzuwHu
 HbqiAzYKnLKMTOeOGkP2pCPCsgd7vQzP2SqdK5K0KaOXQWnXHQglm6irjH5rhr+QDqzj
 cyTtNgSYXRetaXv7yDYVMYlFgXSoLr2EqjlcIxzf4my7ABsziVGEyvNYhwmkEpS9+L3f
 kZAwgXtI1EQIRaadL4b3BAL098H+PjAY4/zX8BlST1Ni5Sa6Bm3DvA6u/NoMCL5w8uKL
 500nPS4LfYrpXPalcMxXyfKfLvWFQ2zN+v3gmwtdtO6We8TRrJ2o7JS/4F6qF/fGCLCA
 5ivg==
X-Gm-Message-State: AOJu0YyBwpOFDLD89Gp3XJYPQAaCF20PZyTlIzOCIZ3+r1gJAH4HALHt
 5+C8EC9T/+bBIbnryEcKXN3IGP824DLxP/qFAabjqdZ7wfaSwEX/D+/F3awVC8/wW8g=
X-Gm-Gg: ASbGncuBiPRY2WnmM+e9HeYWxeO10MI0r3vajqTKRiCBTypHuTKGzCR06j2aSXj4D+4
 rO/eA7S6j2/k1sCMwVHnSUQzad+t5RdVAaQ6HRIZ7UKAhuetE272VfEYqOZklWTRjqzXcL2UYIU
 6CbCUg0lJpk9vmPgqZw1LlgdOhloGD4LeTKukvTZrHdBFBZ9GrqN+AEP4dZCo7y55JN4sSyJx9r
 cN7yoK/aKu4g2uRRPpsdkczo+6ww1A4vQm1BElpNA1zRSOdfMx0hHmT3rZWjAadati4R5/bfbjx
 JKUnJwS0B4+cnN3jq5oKN1tlB5Ar8tlsLtXoQUbjCLCmC1HhicB27Ft8ifwJFsdfK2U/1GHonKT
 0aRNXjh5FAj2UveCSe4vqr0yUIUTFp0U2rIRK24aBvQ3jcTgsm0R7zZYymFYg22yrKfdgZ3Nbj9
 NDjaclju67D+pE2HLrgndWyw==
X-Google-Smtp-Source: AGHT+IGFAZlSSm1QjMgKAiApb+9UtWNbIXiLZiy92fc+gVIA5oeyJCRs5mtDPpsTvbhnpxGR6+O2HA==
X-Received: by 2002:a17:906:c144:b0:b04:3e43:eccc with SMTP id
 a640c23a62f3a-b64739502dcmr1595601366b.40.1760956910983; 
 Mon, 20 Oct 2025 03:41:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e8391547sm761197266b.22.2025.10.20.03.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8BC95F85F;
 Mon, 20 Oct 2025 11:41:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/11] gitlab: use template for ubuntu-24.04-aarch64 jobs
Date: Mon, 20 Oct 2025 11:41:39 +0100
Message-ID: <20251020104149.4034124-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Most of the test is pure boilerplate so to save ourselves from
repetition move all the main bits into a minimal copy of
native_build_job_template but without the caching.

We keep all the current allow_fail and configure setups but do take
the opportunity to replace the -j`nproc --ignore=40` hack with
something that almost, but not quite, saturates the machine its being
built on.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251016150357.876415-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index d26c7827f45..46db9ae0138 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -2,150 +2,112 @@
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 24.04"
 
+.ubuntu_aarch64_template:
+  extends: .custom_runner_template
+  needs: []
+  stage: build
+  tags:
+    - ubuntu_24.04
+    - aarch64
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) - 4)
+    - section_end setup
+  script:
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - ../configure $CONFIGURE_ARGS ||
+          { cat config.log meson-logs/meson-log.txt && exit 1; }
+    - section_end configure
+    - section_start build "Building QEMU"
+    - make --output-sync -j"$JOBS"
+    - section_end build
+    - section_start test "Running tests"
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        make -j"$JOBS" $MAKE_CHECK_ARGS ;
+      fi
+    - section_end test
+
 ubuntu-24.04-aarch64-all-linux-static:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
- - if: "$AARCH64_RUNNER_AVAILABLE"
- script:
- - mkdir build
- - cd build
- # Disable -static-pie due to build error with system libc:
- # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
- - ../configure --enable-debug --static --disable-system --disable-pie
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make check-tcg
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    # Disable -static-pie due to build error with system libc:
+    # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
+    CONFIGURE_ARGS: --enable-debug --static --disable-system --disable-pie
+    MAKE_CHECK_ARGS: check-tcg
 
 ubuntu-24.04-aarch64-all:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-without-defaults:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-user --without-default-devices --without-default-features
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --disable-user --without-default-devices --without-default-features
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-alldbg:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
- - if: "$AARCH64_RUNNER_AVAILABLE"
- script:
- - mkdir build
- - cd build
- - ../configure --enable-debug
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make clean
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --enable-debug
+    MAKE_CHECK_ARGS: check-tcg
 
 ubuntu-24.04-aarch64-clang:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-ubsan
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-tci:
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --enable-tcg-interpreter
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --enable-tcg-interpreter
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
 
 ubuntu-24.04-aarch64-notcg:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH64_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-tcg --with-devices-aarch64=minimal
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+  extends: .ubuntu_aarch64_template
+  variables:
+    CONFIGURE_ARGS: --disable-tcg --with-devices-aarch64=minimal
+    MAKE_CHECK_ARGS: check
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+      when: manual
+      allow_failure: true
+    - if: "$AARCH64_RUNNER_AVAILABLE"
+      when: manual
+      allow_failure: true
-- 
2.47.3


