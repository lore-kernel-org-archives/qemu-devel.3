Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F92CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1ef-0000cL-4L; Mon, 17 Nov 2025 11:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1e5-0000WY-QD
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:00:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1e0-0001QC-Oz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:59:59 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so3214322f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763395194; x=1763999994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzjPz1y4BgxoUVJItsec9f9h6jjJhOZ9mjrKjQy+bwc=;
 b=cA28D4rZJzwevs9r8lKwdulzW2l0P3rmlxisLdLHa7VHB6rpOVyYnu5jDDziSGHnFf
 ZgYML/Finr27smRyMrUax1+PUD77Wi0Ha68yl93wGFGnmoXlH79RJ/94qplTnYrQniH/
 1Mw4Z+y+wb1NkXhroT/njmD/ijxmtHmUnI/khIdT6T47sf6TTVoqvDPSbrqJKfYsAR7g
 LeH51KyQLaCi4bLP74uNXZ5WCGq2U1T0uX01ajTiCU8Hq6yUuljGysUUmLw1l07xKS3H
 jvVZouE8GFB8m/SzX4ifEUF0+FhYfPWp7R1Dyt10pbT5xku5iI1gnCthhAwdc+dvncqm
 WWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763395194; x=1763999994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzjPz1y4BgxoUVJItsec9f9h6jjJhOZ9mjrKjQy+bwc=;
 b=nhsWnzuEd9KO7zgmd7nA81Am5RyuxZF4KZsM+1oflu3bB+jUVOUYnDbz+CRTPGpjP0
 8tyIBDOD8y1pzWgZEYGDwZoP4AkexWmL2L4wjEHJKZysRUbQgJJM+uRlRznecJCMg2nh
 +ihzFwRk9EskCv7MaFpXjJdnnF0IkNL6UgfhPpuLJGLNZr6QE8FKQ6ZcrLOXPVhqv8Az
 kn7kOwy3BXcPx6i2w8rprTF3ErjnWs36BLHJwElslvTtE6EytH/SQF1kaUZybQahUr1d
 Z6BIGuggZ/LycoM37AAzIAv7C82fJ44oktTlWuyRtxLXUSZ+UKu/jMjaoC1LtXd7kW3i
 fo6w==
X-Gm-Message-State: AOJu0Yz6q7WfXIT/3OkHpolSaqYrezoVDraDVEGIlotuUW6Awujii/ig
 IGyp2nC5adSOLXTwDdCb3CBFtup/a4qJ+JTuVa3G5N143OPxbWlLWuaSdNUGnubJwJ0=
X-Gm-Gg: ASbGnctKxvX+54u85/HUkIQVpYJhYhqOGNjn/LYTV59hwjiQSnbvAvF3AIN7wGSVsQN
 AEYDTQe1OQ4sq0rOb0uCVjU4+1xywQpoDoNUdmHLXycRslzQdALYWXkMc7gxs6NVfDbATeapXjd
 8fgCjytpflLZNzJ1yuNV5dbvqk1jsZhFO6yspA06+ijU93W9qolC5sZxBZEj/T8VC7HFBmBub+X
 m1QA+nKb9a4YLTUHhpGmWig65D6HJFA8zSdftEXyKMki1nC/zw/3G6UBri3Knecq4c+8ZoGZlLN
 dqZqoQrax9QQZDo+E4lzlgXW8NTeGLp1CXqpiUNyQghAbYJhe+uEkK2gqtNymCEtxWMl6+pPvNM
 ldQt6t6hxgI0AbXdKr0FGSo2C+LdboEqAkXuR40BfouZix8/cKdSooIGBPn1qA/SxuKxoPh2JCr
 mz
X-Google-Smtp-Source: AGHT+IFHU1TSSgy+Jf4uGqlkYA/+l54edUsn9Abnhr8rqmdri4O1aouGZ1an2CDtoCLICXzkjiKJ5w==
X-Received: by 2002:a05:6000:178a:b0:42b:2ea5:61b6 with SMTP id
 ffacd0b85a97d-42b593951e4mr12960995f8f.46.1763395193741; 
 Mon, 17 Nov 2025 07:59:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17291sm26858933f8f.32.2025.11.17.07.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:59:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E80B75FC43;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 16/18] gitlab: make custom runners need QEMU_CI to run
Date: Mon, 17 Nov 2025 15:49:45 +0000
Message-ID: <20251117154948.4122164-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
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

In addition to not being triggered by schedule we should follow the
same rules about QEMU_CI. One day we may figure out how to fold the
custom runner rules into the .base_job_template but today is not that
day.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251117115523.3993105-17-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
index 40b1f408f90..23b188dc72b 100644
--- a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
+++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
@@ -11,6 +11,10 @@
     - ppc64le
   rules:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+      when: never
+    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI == "1"'
+      when: manual
     - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index c8adb8171c0..98d99193457 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -11,6 +11,10 @@
     - aarch64
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+      when: never
+    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI == "1"'
+      when: manual
     - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
index fb093d05b5d..efa8252d948 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -11,6 +11,10 @@
     - s390x
   rules:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /^staging/'
+    - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+      when: never
+    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule" && $QEMU_CI == "1"'
+      when: manual
     - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE != "schedule"'
   before_script:
     - source scripts/ci/gitlab-ci-section
-- 
2.47.3


