Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE72FCD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWV-00084z-3r; Thu, 13 Nov 2025 05:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWS-0007y3-7y
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:48 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWH-0007Kx-T7
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:47 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so1067955a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029536; x=1763634336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mX0M3LOGjPT1gv22GpEZQAc5eiq0deu9LATKf3fjSA=;
 b=so64QNKYMQ14Lnvs+2ladinSsPUhasgwsixA9dPWGRy9NyLus6+1Y1iIugDgJUrNgq
 90CdQK2aiA7YXjwb6fnkH3zhmbrfqEM7UmjdR1KpM/oedPIl45IzJWdV141vtKjDV/wz
 mdhdRd1gsq0M5dAafhwwrdk/1dyYUfhyxMvKLDeFS7AraozByUPRYPd9ofSOKwIKDkWU
 6TS0+aMwcjaTNynNwL5ttZg5+SAJPT4BQQ+utMp/5OBYSq5Pt3idqFXU1oPfnUsOpjvb
 jdHonYQQvZARDAEWwTO4GrE5DAW/3QCRyzltdtp44yO+1fUykrqldCq8uQLK3zBPY+5k
 sDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029536; x=1763634336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+mX0M3LOGjPT1gv22GpEZQAc5eiq0deu9LATKf3fjSA=;
 b=X4xwVN1DZv+EJxQ/Ct4zh+NJpkaBQ5R0k8Lh25LZnDfJyCu6s3FS50o3bNzUDgSeyG
 f1otM7Y6UrBimPVTJ69rpoUm8sQYVFkrwnExtBKHQiGPcOTc3+s6AC+ljRRtNsuKkeCr
 niL8cgwIEsYgjsWPxwgdlSx1WH4ud//7ODzMle7VwXC3R/EIEWO67fyGSJ8fcdTzHm3f
 wb5zrOc0aAN+go54WxKVOjcKKuaENC4AK8KAx4cM30yqKerRDNBR9akSYFHDZIS/5iFo
 qCcYSY1G36JylzbJZ8v3ttOSlBKMdKOqbFt1kS2ScGtVZENrF1qGny/2LO/NwJgSasze
 rLAQ==
X-Gm-Message-State: AOJu0Yz4e6o03qM0uam6CwrWfa2pDSTyaVSUDEWDwUs/6FtOYDOMDIXA
 ubIGdPDdrqyNLbODK0ImlrZhNcaezQ7DDPlWiORYAIMDuE5afZPzcYQzlK2SAhfk7qM=
X-Gm-Gg: ASbGncsnnOT4NphWSjNHssr4a0iU4+fm7lKBFtGsvdPFJCZBwJ3EfIgVNDNz0iiIsxg
 WsbdMf2ewsFItN+zT5yk1G/rwa1/+hoJWQuQZP7vZpic2SXKLladMWj50FAm1R2Ky9CEu+y17S0
 47GbqvIYwdksyhG/pkHi2dc5bdWAjlfxyVivcBIh+0Xdqf8gwvNpGYziquZtf9+b45Tbpp097/e
 LZx6LfUhh50Ukl3YpwRNO5RXspYM2SCeetsRE6+pugq2IWybD/V38NUyMWMnu2NODgTm+MilN7m
 CrQKSd8m4YIGpbqpJ1+JG5BcGED6LPsFUQ6E6aHPGnyLiqyjOpzZYI/sdWMM2/zjWH3tHBIvf9a
 faUQqNIJ9rkNqQ9EMCv0pMWQsb9ZtTVH4NPP4BBNuOq8kYsX2CsSr/YVWn6e6T3b0tceBzm1l+T
 1A
X-Google-Smtp-Source: AGHT+IHokhjt+vQuWaV2ZwJGprM5cAeBy7CMGCczfZdjW9NMSm1CbibrOBr/4uWmCyZ4IhZvddK09A==
X-Received: by 2002:a17:907:3d89:b0:b72:6b3c:1f0d with SMTP id
 a640c23a62f3a-b7331a70a51mr621279166b.35.1763029536137; 
 Thu, 13 Nov 2025 02:25:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad48dcsm134585266b.25.2025.11.13.02.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A40760DC4;
 Thu, 13 Nov 2025 10:25:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>
Subject: [PATCH v2 16/18] gitlab: make custom runners need QEMU_CI to run
Date: Thu, 13 Nov 2025 10:25:22 +0000
Message-ID: <20251113102525.1255370-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

In addition to not being triggered by schedule we should follow the
same rules about QEMU_CI. One day we may figure out how to fold the
custom runner rules into the .base_job_template but today is not that
day.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml    | 2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 +-
 .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
index 6492d013de8..be73c14b95e 100644
--- a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -11,7 +11,7 @@
     - ppc64le
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
+    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index c8adb8171c0..7a30a18d0bc 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -11,7 +11,7 @@
     - aarch64
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index fcb49ae884d..c30816a806e 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -11,7 +11,7 @@
     - s390x
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
+    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI'
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
-- 
2.47.3


