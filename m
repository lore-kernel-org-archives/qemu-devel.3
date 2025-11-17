Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7B7CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpn-0008WC-4A; Mon, 17 Nov 2025 06:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpf-0008S6-W7
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpX-0005kV-Uq
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so13099045e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380534; x=1763985334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkBjjycuEHq7s63eouJrlIMTBjvbHE+kUgoNjQOl88I=;
 b=tBVHRdKTZC5bb1y0bj9z/1+XbsyA1FvLksE4JFJiMVHdxcl8+JNZ6eZzBr8QYZp6O1
 LeQBcKSJ8ay/tbG4K6kbVqXVqzd0GG2TL7nFeReOweiC9NbHSW2BLFjdRR/AEY6SSncE
 a0/BDhv4pHxNKQ7Ec6O5hq/vReGxEnEkmJu96KCwdcZFHEZwodcRU45oy9xtx0ZIx7CK
 1wuLPI6Faq0u6RiHCOchInm4Ww/lLtzTvQ8surt7xWER94eKam7C8u0WdC4w2NgbSdwV
 2EDA2DumMMYo8scQNu26UhFMaELh7PyU7nIDFIxmb/FHMmeCZS5WjfPongbQRdan5ec8
 77IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380534; x=1763985334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TkBjjycuEHq7s63eouJrlIMTBjvbHE+kUgoNjQOl88I=;
 b=TO9yXTdfKF8Sr7HZS82E3yg4IfSAM930qZvX4Z5X6N/dnbSK1pgGUpluDkwOZYZtsg
 3roz7G7PCG3McNHvEb3BC4j4aMdvdoe0CnhSZuYPq8jisBOtoYguq1Mfm6ASGxWeuMq6
 ZLFW8Go16pXEyp/BBycoXJSMdisQSC4RfzhiLAa8tBMmSZ4Tm0asP1V7T01D1SPasmwE
 78GwyPFGmykUoTgInvL/qQRizVc9+BhkVu4IVSMrTwd4HzcFCysEZybGbvjy7D2PC5Ja
 JqCdvGy+knP1UYjAIHnUmBEkXORxQoTXkg18DHzNYw7Plx3FdvmUGdVQC0tbJQ9Dan6K
 74pw==
X-Gm-Message-State: AOJu0YzZpIjMfWIiGcveVd1q0u2sWIzhzBt+lYM0sewehSSOFluWZqtx
 rrfStJcRopocugG4no7AoC+vKKD8+Wg3o5SZ3x3/r2WbDbn9Q0oLRgl/3FdxrsHrAas=
X-Gm-Gg: ASbGncstCVWZMYhGt7JUqMUmy0kW8I3ZKpv1lJd2BeLMTITRK8wBJCgIYOBSaBc5QOE
 c7V+TpbPK9GjE2lr/wsPNIqwkSMtNEv2SicMYmctHzYbC4FGk416WjRL+I5l0syuZf1zgcj/UOs
 GFdnqSSWc/PTAPpABf6kez74f1KDCu6SdWp1hfDkLbZ4X3XTLzPK+ijTUAGGOcxb+dvIvqEVbQs
 1vblXyVrI5paxOsQ6ItFy/zAk4qr7STDIshj4Bcj3yEQ1ZfnMWH7TOQIkqG9iHkoz/ri7TZtoQK
 JWC1033ah2Pm4irkpxeMWndHXWAHc5WhEyLXYJCcn2Bd0rsNpEyFu6/HPFbvT0Sv9FlznUsat3X
 cuR0aqB1VxKMY6iL3mO98Ld/ZQ0Fs3FR/ySFOcVjQLkxW4GUF/9+uQa2SZ6vqqhdtbWyUsPcSAl
 t7
X-Google-Smtp-Source: AGHT+IEkU+aIogpO7d9dF5Xsyays0qnG9yDmKpr2QhbmQCEdeMh5d7DXHaxMTwqHSCTkFXZnvC43AQ==
X-Received: by 2002:a05:600c:c177:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4778fe683d6mr105748855e9.13.1763380534468; 
 Mon, 17 Nov 2025 03:55:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e2bcf9sm305417615e9.3.2025.11.17.03.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C01065FC43;
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
Subject: [PATCH v3 15/18] gitlab: suppress custom runners being triggered by
 schedule
Date: Mon, 17 Nov 2025 11:55:20 +0000
Message-ID: <20251117115523.3993105-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
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

Otherwise the mere presence of the RUNNER env vars is enough to
trigger the jobs.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113102525.1255370-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml    | 2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
index e088c3b67b7..40b1f408f90 100644
--- a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -11,7 +11,7 @@
     - ppc64le
   rules:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: "$PPC64LE_RUNNER_AVAILABLE"
+    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index 6f950baee0d..c8adb8171c0 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -11,7 +11,7 @@
     - aarch64
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: "$AARCH64_RUNNER_AVAILABLE"
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index 2fc940e127c..fb093d05b5d 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -11,7 +11,7 @@
     - s390x
   rules:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: "$S390X_RUNNER_AVAILABLE"
+    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
-- 
2.47.3


