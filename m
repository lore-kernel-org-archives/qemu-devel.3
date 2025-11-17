Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9A9CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpk-0008Vq-Ah; Mon, 17 Nov 2025 06:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpe-0008RI-Jg
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpW-0005jp-Sp
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so22850905e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380533; x=1763985333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6HSnkvpjHkS7tonHb5zKH2VLJ9Qc9MClLALRrKy+8k=;
 b=eTwb9++X2TSgaiF/IDO1JHMOUNyWBIOCCo5TwVN1gbsb0m0vX3KgMlp7M9xBF94YoR
 ZGtrRa35eceJCJQrEv5JggDGWcT7b2qiJfXD8mGnDF6TnFKi0r6dRVpzH5gggB+tsA24
 iBHQXGAzZQbf+hDv9pG+r9rrZL35cWmBRk9Ib4MwMPSpd6E27VSmRAX6Z4f5jo68Hi8R
 ovyLDasrEM3r/0fs0l97cF73fo8gT2aqjN/Vzc3929e2nMHoRKFQPxb10ZbwGuHF+W80
 wBcwTCEnZOWlF74Wd+pkuMw66PMLaR2x6PiqO2Ud0iwgNT2uVOaISQlnl+dtQBjpy1L6
 roGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380533; x=1763985333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t6HSnkvpjHkS7tonHb5zKH2VLJ9Qc9MClLALRrKy+8k=;
 b=Huk2Hxs6GUSped+GH4vev1/bJ5Viy7CEaENXdnX+CPd6dZj3J68QFFl++9m3EFcI7C
 jyyY+LPBmzChwq773fFyhbLfQ16LzRvzCJubwwumNVDjlWKmSJSesmdzxtgyQI7g0Zto
 XItqgoPwyoqfq6n3Ik8Tzr7ZFSvUwnTahSmRazPF/DuBEacjaQfSgBd46oewBqOzwkCW
 kchjWkUc/iEwn1s9X9fvbgTZrjiEQPD7A4kKQPHfpNQIOw6c8fI/863HH4XUs1nS9uIC
 KCeialkDSkOu+R+kqf7h1rYqkVBI9shpEtxmxZGlYuHrJqSPS2YYPraJFyODCzghY/mL
 7v/Q==
X-Gm-Message-State: AOJu0Yw2pdbp51sDhh23aUznTdvm+T/flCsHrveKzwD+WMTQv03/jCIX
 rhZzD5geyPUYeEN/XY3o686VKlNPy7R14qDbt7zgjKfWfkqAUIwD1o/zySBDkw8RY74=
X-Gm-Gg: ASbGncuBUX5MIELvKl2DuBdwlGpgnGmmLmisrh7WTpr7fSdrgqc1a/wHwKx8Uj2WSBY
 ReaBfDFPDceumwKzCvnaI4WEr/1S8cWPbndTxiL6U534Z5jX7GYu0V/wbH4d0VUO70nPr28Qby0
 yBTT8rncP70ntV2GaF37SWxl9YpKJea1rk/M+JAqWXNZnbJ5/UUeQMx6iEIHJRXgb0y5oX1xjcj
 XnY78l0nBXHuWaKU1P3nVMNYggcXR5LEyQcr2iiKWMW1L7EkGzcGD548bh1IFTJHNa2YIRH9xLv
 xdYraAKek2qhwyC8MAZmujO8iMUQ0niHu3oNOyLdUNgutFm55fUmFqjSUW2ofq6aM+UnED4XIWB
 gZp6RRMdmXMTYawa53dkrWQxGlbotPUBN4c16HyXUZeievxlZsOmoaD9S/ncr8v/476vZM949w7
 J+iziBK3w7+eg=
X-Google-Smtp-Source: AGHT+IGqDbB1aBZg+Atb/z9ha5gUFE7YiqK8g5oU2lZ2KS67jdaSS6NvTIX/311+4j55ecLpjl9IGQ==
X-Received: by 2002:a05:600c:4585:b0:477:7725:c16a with SMTP id
 5b1f17b1804b1-4778fe5717amr117639735e9.10.1763380533202; 
 Mon, 17 Nov 2025 03:55:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e6acsm315026085e9.9.2025.11.17.03.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FC625FC09;
 Mon, 17 Nov 2025 11:55:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 13/18] gitlab: use template for ubuntu-24.04-s390x jobs
Date: Mon, 17 Nov 2025 11:55:18 +0000
Message-ID: <20251117115523.3993105-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

We keep all the current allow_fail, manual and configure setups but do
take the opportunity to replace the inline nproc calls to using a
common JOBS variable. We also fix the namespace check to use the
QEMU_CI_UPSTREAM variable.

Message-ID: <20251113102525.1255370-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v3
  - use the QEMU_CI_UPSTREAM variable
---
 .../custom-runners/ubuntu-24.04-s390x.yml     | 185 +++++++-----------
 1 file changed, 70 insertions(+), 115 deletions(-)

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


