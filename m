Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39975CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxqD-0000gT-8s; Mon, 17 Nov 2025 06:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpi-0008W5-NE
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:48 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpZ-0005m3-Uf
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:46 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42bb288c219so1462590f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380536; x=1763985336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fOUEkPwhvaQG6OX3bRBBhu6M7xGuUW1rQkX3xy0dv4=;
 b=WMra4m2XJ9Hp1v0Ff34RqSg1rCG0y/FONdHTEYy+hixIyQQkOJ6xauGL1zGA9rhUFh
 xM9dlPtbQuPtVhd+R2XsXxDBgljlaJGA4W9+MWzAiUVZVj+c/GxC6RM9XugTXE9IkRyI
 Wel56NevrzMInADVdaHb/evEB7d0g70rrhjEVOrigtzENGFQFk6t6fk7+WVJb++549TM
 00IN/oZDGRZbm7qGhvEIBH3YPWLDizFPzkK7p7R+IyRgXMzBzzDrPKqYe1ScEH/+42h8
 oFkXNfHCrRPyNE5UKGi4JdDzZGf5kQfQk6A3QEcE1OdA2DZNC34NFhk2xnjg28ehZ0DU
 WKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380536; x=1763985336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0fOUEkPwhvaQG6OX3bRBBhu6M7xGuUW1rQkX3xy0dv4=;
 b=SAW2U+PvQQt46RSjPhM/VQErzL4l3hrOJGAPpgaRaqUJiaaMGo8nufe46yLDmgMPoO
 I90Re7zj1UR10XJYqKZ1m9odpAolHSIMqinqNM44YYDWuAR3vsK2hNqZBNcB6jEtlkDC
 TnC/DQ+qq9x4RcRFhdtqK+QD9mT6um5XUb/KdM/Aiy5WaXlyGAEqmjlyKiK9EZisnwWB
 OT1lDcr1TeGWQ3QaV5ENq8vWNUVRXLEOLURBG3ACBX+LkH/mQgSb/OLKXYheVnqjJ15w
 vsubYr1gZ6Z6Xu8oZnLMHz/vRg3cYDArv46fxESP8OhRUXVzcPVjCUOfv/zvZjedxMgO
 NLLw==
X-Gm-Message-State: AOJu0YylOWwIqIrouWrC9dDafjCoJNCKocVzUJKT3mVHDMbGsxbaVRrV
 smAQgWOaAZTd5RuvbA/cEcGBEGMIEfJXvFtDVd0DeFZlom3jc4r5NlKemmljYsLLoZg=
X-Gm-Gg: ASbGnct8pii+Ux1esUPOHMWRVflEokuAxiWde29Bq0u5X86eCvepuBbq/Hxn0RVX7pw
 eI2FwIiZ1T05DXbwSVIEngobfvXxV6b+DMLWsW7YTuBSWWOfwSTc0fJoGHman/fM0V9X+m8n9XQ
 W6H9oOmCFW9I7Bj/qJNPvEMmWM28rMMFgbMnHxUcV7QBTdVJY8+CEeSljpoxI3SZEG5h11D1Y3+
 8Adh8M4tMBC78/G43su1jHSUGGx6Z1bbGeg0DLVZnsbJuwU6LP4wO1C8wiyj0oiqixOXcoy8ZmL
 i+mesut+yw77EymMjdzh11CVJZ2AkS5BeyIcw53YpPjqNSJuS6Niq2kEzYMiwL+qkS0tFyuilpA
 mj4lMU4qPuzQbPWZIRIm/6n4zrrW2Gu/Hl7Rpl/hPqxkyI4JV4HJJX+7BSBrUEPYCbUgTqW9sr8
 eQr4VCoGGQWeY=
X-Google-Smtp-Source: AGHT+IFeD/hDtKO9YvM173MvDkgUZ+EvP5YUDp0RRachrwjonv1bq4baAlDSjKMMuEbsaA2CqZclXQ==
X-Received: by 2002:a05:6000:2405:b0:42b:3b55:8917 with SMTP id
 ffacd0b85a97d-42b59377ff8mr11391645f8f.36.1763380536325; 
 Mon, 17 Nov 2025 03:55:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84a4fsm25748557f8f.11.2025.11.17.03.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7635D5FA6F;
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
Subject: [PATCH v3 12/18] gitlab: add initial ppc64le custom-runner test
Date: Mon, 17 Nov 2025 11:55:17 +0000
Message-ID: <20251117115523.3993105-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

This is a plain configure build but I only run a subset of the tests
until the kinks have been worked out.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113102525.1255370-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use QEMU_CI_UPSTREAM when checking namespace
---
 docs/devel/testing/ci-jobs.rst.inc            |  6 +++
 .gitlab-ci.d/custom-runners.yml               |  1 +
 .../custom-runners/debian-13-ppc64le.yml      | 41 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index b92d372a0a9..f1c70344ece 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -174,6 +174,12 @@ If you've got access to an IBM Z host that can be used as a gitlab-CI
 runner, you can set this variable to enable the tests that require this
 kind of host. The runner should be tagged with "s390x".
 
+PPC64LE_RUNNER_AVAILABLE
+~~~~~~~~~~~~~~~~~~~~~~~~
+If you've got access to an PPC64LE host that can be used as a gitlab-CI
+runner, you can set this variable to enable the tests that require this
+kind of host. The runner should be tagged with "ppc64le".
+
 CCACHE_DISABLE
 ~~~~~~~~~~~~~~
 The jobs are configured to use "ccache" by default since this typically
diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 142fbf4a242..3e28e48c97c 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -31,3 +31,4 @@
 include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
+  - local: '/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml'
diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
new file mode 100644
index 00000000000..e088c3b67b7
--- /dev/null
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -0,0 +1,41 @@
+# All jobs should run successfully in an environment setup by the
+# scripts/ci/setup/build-environment.yml task:
+# "Install basic packages to build QEMU on Ubuntu/Debian"
+
+.debian_ppc64le_template:
+  extends: .custom_runner_template
+  needs: []
+  stage: build
+  tags:
+    - debian_13
+    - ppc64le
+  rules:
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: "$PPC64LE_RUNNER_AVAILABLE"
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) - 2)
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
+debian-13-ppc64le-default:
+  extends: .debian_ppc64le_template
+  variables:
+    # qtest currently fails: https://gitlab.com/qemu-project/qemu/-/issues/3207
+    MAKE_CHECK_ARGS: check-unit check-tcg check-softfloat
-- 
2.47.3


