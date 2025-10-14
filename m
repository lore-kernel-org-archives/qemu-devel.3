Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3894CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cVc-0004cC-W2; Tue, 14 Oct 2025 06:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVJ-0004PZ-6x
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVA-0003XO-Pv
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so41763045e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438607; x=1761043407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EO8zY+f+eRKXz2hwkLNT6XbeCb6L/izof5+RV6C6SZU=;
 b=sQEimhS6YJc3p+eM8jleuzLoDCPgTIA3U7mkIZT8XIy5aqvymfpjBTIay47TSJpqqk
 ecS2dK9riAQXgobfl7q0yBTdwz/J0TId/ko0FNAhWsqLi050NsVxHJrY1u99uzsJ4yvE
 LrQn8mThCBQgxG2Q8Am+cbmLPBM4+SolfLLRHrzqff84wnDS82+ypW9EjB6V+0JlUKfv
 eFXf8I1B6UGyOQgG58wusuukOlXXLoEz4M6q1vVhdlKvOJP4lIn16K2ndd3dt9MM4qiw
 rWKPMzlLJAUGAHB9Ldo+dilpydbQdw7sIZlgqjyqvuJ/XGJyoEmO9VrjZtbuOMySezl1
 x5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438607; x=1761043407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EO8zY+f+eRKXz2hwkLNT6XbeCb6L/izof5+RV6C6SZU=;
 b=oxlSRebESf/V/i6QBEtv8r56EqMxD8AUdP2F2/Z0rv0H9TQQHGgzcjkuu2El5XyAso
 4LAzgSJGV3damYxR1TbInQyyheeOiCXlz8Z9NVdq5Re+EE0a+vjiaEpo+AHwYlCLrCPP
 B7BmgBmDkUZv56bLEvosNoaCw2Lzbvt9wYAxZxQlYtP9dS7UohXhkhtKcLrvoKkly+T9
 wSOy443jo87qTjfwueFkNFvFR1XO2zujFxaafT4jWGJe4quB0A2EVL4I2+C00lv1RHNU
 BdGrRy+9vh5QWHU4eyHIDd8hYDRLps7XuIE8sJqlOU5R31aRhU8Ye7C9HK/DMtmrrSw1
 jYqw==
X-Gm-Message-State: AOJu0YxjEOJykpFStROiO55ptyzrl43x0zXEUlQI3g6Db/+61xT7TQK6
 jYCWEmGYNxalFABwnFGsTu2UD1r9GT8nO/XEefiWlagcjqNtVR0zK8QonlkrEQEn6SETBLYUn4x
 ZFhIr
X-Gm-Gg: ASbGncvXuNBaWv4T31fpPaTFuiUN48G4dqyqGWJHPH6W9ZKtjDdO8bw5B5VhWSp74lZ
 ulvCV6Ka9pq2LvFkYiMSbDGt6B1p1Hlht0AEmVa0RUrpV5BRJ8J65dXno36QILxNhRNNv9ZaGtv
 X2NanP6DNUNh3zYTjd+vAmuK0tq8UuSuO35jeW4rFt4J44VLNH2h1dsysEDG/b1oiv1h0e2JQFz
 mjAnTnkdD6EsGWz53XfFjEffIXmTycA6LKfH5DrxN9E6AXm1GLSmSxYULmkPWqJKexbt6a8CYUz
 zzkKmzuAScH/ZoqZnd6rvNZV/raBcDJHy6SlVxeUMwMfI6rMMQmCy+QlOLm4BFBxUNkR+rkXBJa
 eRAx3jgPzbeuyo/ckKg7g5BmIN11AkAZE96tJ3NTAHuQHpsBB5G69FKvNgdQuYOJFIeY=
X-Google-Smtp-Source: AGHT+IFwJhO+nMnCak8vPAUUDB2ZPcS6LECaLtXCr5s84NxuuwP7ekdNQERMTqllx5VSHmlodx9k6g==
X-Received: by 2002:a05:600c:c091:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-46fae33dffamr95782725e9.20.1760438607269; 
 Tue, 14 Oct 2025 03:43:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb483bbb4sm228072675e9.5.2025.10.14.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CBAE5F82E;
 Tue, 14 Oct 2025 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org
Subject: [PATCH 2/5] gitlab: use template for ubuntu-24.04-aarch64 jobs
Date: Tue, 14 Oct 2025 11:43:19 +0100
Message-ID: <20251014104323.3023714-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014104323.3023714-1-alex.bennee@linaro.org>
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Most of the test is pure boilerplate so to save ourselves from
repetition move all the main bits into a minimal copy of
native_build_job_template but without the caching.

We keep all the current allow_fail and configure setups but do take
the opportunity to replace the -j`nproc --ignore=40` hack with
something that almost, but not quite, saturates the machine its being
built on.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../custom-runners/ubuntu-24.04-aarch64.yml   | 230 ++++++++----------
 1 file changed, 96 insertions(+), 134 deletions(-)

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


