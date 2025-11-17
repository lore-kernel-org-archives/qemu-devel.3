Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC32CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VD-0003xb-4t; Mon, 17 Nov 2025 10:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1US-0003eL-7J
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UN-0007z4-Vi
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:02 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so15656005e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394597; x=1763999397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3HTIjkIvHvycYf3zgWmHPIApgogggk5xVuJ4StlxZo=;
 b=k2VoLH/r8QNDWyjl2C+AKsu8wqBizHeWzyxodz4NLd8c2iRH8jhAkHVG/fvWIRzVdk
 E14MWHxHKOpE2lS2FVMbtH/PogWoe3p42Zn2KCz9t2aZ0bq2HZkG9kcOzOWRWhYtUN65
 pB63quIxOGPudK/eObrvSlPaO9yhmiPyGiMDfUNn1sBrIXmPi9r2hIuRxdcEfadUeC/0
 Wk+/Sfr5/+dJxX3VS+5w/hMPRXudbZ42b4osULFFfDiUFkCY+9LB3yUZKBGvt3ub1ItS
 d0ICKiJ8uJddEHo+YsxfuMm55WUk5Z8T5esMmC9AzU4rfRKE/eO4IxYKVvSkGXlQrKHm
 thWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394597; x=1763999397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3HTIjkIvHvycYf3zgWmHPIApgogggk5xVuJ4StlxZo=;
 b=wPAsHksEKLGhbK5OzHHUUQzeJh77Go+yxY/LJIu0tazGaAcW+blHxRleQr6NE7IY0d
 TM1GN5m9xkXCW6uOWFxQDKsvX1m8qktDmFVEkNcnBgR4oL7yQD+FvT1vh3UDlY5U9UqW
 oPayc+xJWd0jfzfwh2Qp9QHDc9gGrNNTlVaUHFUax17yOLwkh0AkZ/Z4/ef9YIYLMfDR
 VO8lozx1P/B+kH7dd9FHNFnw/06HcF07c4pKTKzDmOD/OIcedV3LNheXPD5PKd8Il4Iu
 DMSTfeAFlSYxaazF3oV+w2+1Do2Cy3TJMkb+wXelx6qT80TgBcP/WbeZSMlLJcOWctIH
 xy8w==
X-Gm-Message-State: AOJu0Yxd11dc9Yahr49508Bce+1Kn/TKT83Bmz6gymZrbTaxp7EQYpd4
 YuX7i/jXNaWdsZXNL0DjNs1uBVP4EPc7OiWf44PSoVQvVlOsnNb2kt+YTq43hcGA9GU=
X-Gm-Gg: ASbGncv5syQqhTf/OHwaIUPB/9MRV2Vg4XnmgWpfZJyPx1+UMGohqLY8XQ7Qd8/vK0y
 aYVlgncjGHPI+6bOpPb2p/PnBe5gKtFwjvChCdWV8TiQ2j8injvPqpjcVdRAHRrfZTiDgEL5t9h
 BdU9Ak0OXMwy8P5ejXbM1E9c7oJThADg9j2jyp9sYo0k6i3tzKT/YaMSIDk2EtwRUJvpkBM7mXT
 lh5Zuvu0rKVuWDC5lSijUNN3gIlIwzrmmB3Gb+9+k4n3T48uRm6t6317qVc1j6C9e6MU8eDJVua
 Oia5QnCVAitx1da+HRkYm6KHUcs5c7PhWF6DRmJtEuzYBgC5KSWTWcO2ZWTdLqEdCY2WFRE0LHq
 +uLHSzJsUHCfinJpRo936q/4HSHBSUzKn5LPhPIqEcwFTwNp7uCveIxZE2krLhaCc8LzSvynWtV
 gu
X-Google-Smtp-Source: AGHT+IHslAqiuF4k7Kv7kgNuPN/au+xEYPzBGhIBIVrTdfutQqAXlj6TYJKkVvO8JKVl7N6zGRnFWg==
X-Received: by 2002:a05:6000:1788:b0:42b:4139:577b with SMTP id
 ffacd0b85a97d-42b5938fe6dmr12406574f8f.45.1763394597347; 
 Mon, 17 Nov 2025 07:49:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84a4fsm26725320f8f.11.2025.11.17.07.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A22485FA6F;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PULL 13/18] gitlab: use template for ubuntu-24.04-s390x jobs
Date: Mon, 17 Nov 2025 15:49:42 +0000
Message-ID: <20251117154948.4122164-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

We keep all the current allow_fail, manual and configure setups but do
take the opportunity to replace the inline nproc calls to using a
common JOBS variable. We also fix the namespace check to use the
QEMU_CI_UPSTREAM variable.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251117115523.3993105-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index 45dbee17880..2fc940e127c 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -2,129 +2,84 @@
 # setup by the scripts/ci/setup/ubuntu/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 24.04"
 
+.ubuntu_s390x_template:
+  extends: .custom_runner_template
+  needs: []
+  stage: build
+  tags:
+    - ubuntu_24.04
+    - s390x
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: "$S390X_RUNNER_AVAILABLE"
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) - 1)
+    - section_end setup
+  script:
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - ../configure $CONFIGURE_ARGS ||
+        { cat config.log meson-logs/meson-log.txt; exit 1; }
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
 ubuntu-24.04-s390x-all-linux:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - s390x
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
- - if: "$S390X_RUNNER_AVAILABLE"
- script:
- - mkdir build
- - cd build
- - ../configure --enable-debug --disable-system --disable-tools --disable-docs
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc`
- - make --output-sync check-tcg
- - make --output-sync -j`nproc` check
+  extends: .ubuntu_s390x_template
+  needs: []
+  variables:
+    CONFIGURE_ARGS: --enable-debug --disable-system --disable-tools --disable-docs
+    MAKE_CHECK_ARGS: check-tcg check
 
 ubuntu-24.04-s390x-all-system:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - s390x
- timeout: 75m
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   allow_failure: true
- - if: "$S390X_RUNNER_AVAILABLE"
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-user
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc`
- - make --output-sync -j`nproc` check
+  extends: .ubuntu_s390x_template
+  needs: []
+  variables:
+    CONFIGURE_ARGS: --disable-user
+    MAKE_CHECK_ARGS: check
+  allow_failure: true
 
 ubuntu-24.04-s390x-alldbg:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - s390x
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$S390X_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --enable-debug
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make clean
- - make --output-sync -j`nproc`
- - make --output-sync -j`nproc` check
+  extends: .ubuntu_s390x_template
+  needs: []
+  variables:
+    CONFIGURE_ARGS: --enable-debug
+    MAKE_CHECK_ARGS: check
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-s390x-clang:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - s390x
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$S390X_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --cc=clang --cxx=clang++ --enable-ubsan
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc`
- - make --output-sync -j`nproc` check
+  extends: .ubuntu_s390x_template
+  needs: []
+  variables:
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
+    MAKE_CHECK_ARGS: check
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-s390x-tci:
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - s390x
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$S390X_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --enable-tcg-interpreter
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc`
+  extends: .ubuntu_s390x_template
+  needs: []
+  variables:
+    CONFIGURE_ARGS: --enable-tcg-interpreter
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-s390x-notcg:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - s390x
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$S390X_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --disable-tcg
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc`
- - make --output-sync -j`nproc` check
+  extends: .ubuntu_s390x_template
+  needs: []
+  variables:
+    CONFIGURE_ARGS: --disable-tcg
+    MAKE_CHECK_ARGS: check
+  allow_failure: true
+  when: manual
-- 
2.47.3


