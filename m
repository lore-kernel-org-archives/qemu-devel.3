Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70EECEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1eU-0000bp-SG; Mon, 17 Nov 2025 11:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1e5-0000WW-Pj
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:00:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1e0-0001QB-M5
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:59:58 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so31924095e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763395193; x=1763999993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNWITXPnBwm+dKWkmPsmS5nGVQDwZ78WREOSrMpAYqw=;
 b=cq3wHwiishYtLFmnKIvYGxDT1pihj+Dyj1/gBTTZxwNsfHeIWbsBgiy/MsOgilMP5O
 YV3rezmceLDovSNyHtlWGYHSYG8Yr+EZyFn8o5s7DtknewaO5sXz84kOymvLATZOYOU5
 9wDy1SLnZgRv0wP4umezg3blCdDY6BEcVlY4XtOWZkCULrVcOHqS8FWNx4tZZ6hsmB5P
 zbVcQIfqnE4PmLB+SziROFLggmD+Pqq+Z2kCaUwBBqtF2XhsGoCclMxeVrrx1FbruKVU
 2C5ZDbe73TEQKXZyxQLzcAnxsWca9VxmluiL9GIp2cpCZmu3NxGQE8c7dLb+6H0Hyq/E
 B1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763395193; x=1763999993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNWITXPnBwm+dKWkmPsmS5nGVQDwZ78WREOSrMpAYqw=;
 b=neKIG2CDe8DRco6f8pNd0eo2sbjDmo0kVitRGCM5ud28SkbDn60ZzR3JDfaP0tigU8
 Qc4UB3HQmGtjVYKAu10bvQFsGeyHZ5WK33mvbMp2/wmAq+9/H+sFViM0VM0s++Dhp2TX
 YNrqvjwMRVebL66pqDnhoHck0OErZUVs7pUr+AaNOxKnh6pmVdF75i4ARqmPyamspJV2
 8YXx2sToTMbIOVC4sabSB+ZwhN/DaCzpb2vbECLZW0MTxOea1AqNBXx0wWvUVlhxk4kv
 Ayt25+7zvvdXIIi/X2Na2QCHY52hAayJ7okLpG+CMJJ/SDqpeiR9i6Ds4k87N1DIUIpl
 ly7g==
X-Gm-Message-State: AOJu0YxTgJrViWlbkcXhDkrDdxLOteKT3eFURJdeYYsbLIEArsUmko/b
 EXTtUpPDNzfh7jN2iXqeMpST3KNXya4Hw9uR8A0bZ9qrMDlzF7iDzeVrbySSFPDYRnA=
X-Gm-Gg: ASbGnctowGG+je8RzTKvQpOqajjV6ryTWF4BFpvIWGjE+c4PNk9G+Uop098y7tlvCqu
 jtKMVMzrRXCpmu/lL0ohmARiJ+AxDnz38GQvcdbop29ZAWmZimUxo5Pb7iijhuMSlUrNM2BYZ49
 gUhPwZdg7x+TglT7lsfEYTo+F5LxyghN4+FbNuT412F45KPhHnjQk2YmtaOwok50WZfu0df//kt
 z09Y7EzvUS11yTNehz2ucBlfg2bkd0F2fjtOiC2mx6yWa9ipoygWPNY2yZMuPbONNNF9XIYoDtj
 X+o/UEUDXbGRxMYSp5IEY2rm+vQ2oyghv2OjQD4qlzbk6k3t6oPLdUNKZqFc4RN3uW13PwoAP/W
 QaI7YILBrVtCyn0JK2yY9LrJogZIU7L36T0gHJ65mmuJ/KCLFW0AQwLqDBphJ/Lz37X8FwCgB3U
 Go
X-Google-Smtp-Source: AGHT+IFvl7oL27KhJNS0+phoLDtgdRYgihXVSyFrrPNpHcVrK6b2JMn4V70rdcgvM8l2DRcm4aWGug==
X-Received: by 2002:a05:600c:1f91:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-4778feadab1mr113476935e9.28.1763395193340; 
 Mon, 17 Nov 2025 07:59:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm24359795e9.14.2025.11.17.07.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:59:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD7185FC09;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 15/18] gitlab: suppress custom runners being triggered by
 schedule
Date: Mon, 17 Nov 2025 15:49:44 +0000
Message-ID: <20251117154948.4122164-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-ID: <20251117115523.3993105-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


