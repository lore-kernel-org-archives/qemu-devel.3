Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17591C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat2-0000i3-Qu; Sun, 18 Jan 2026 17:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasn-0000Xr-Nj
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:33 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasl-0000Sb-QU
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:29 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so36932565ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773866; x=1769378666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEZduNYwLQr146mwdh+OzwJtbyPDzZLUuan1YMoWbuQ=;
 b=yUI2Xum9m0CTQjAv3kSnAHElMMH0O3KIi3A3HO7d8TqaSTdhWyrs3KBEogIsGpXjs5
 NoW0Qiajlv/E5kqFgWUrOQHueeNXOMBzzjDSgefgByJJvyUzdDDzxO2vcY1m49KO7eFm
 CO//3CpNmoDcaR/vssLaziTRx8duydqWlkFK31NzED1MSPjrB1eQ/OUWK/4dAQTQsRpx
 Zjir4bGEVzcFA+N0MOdlkUEzs0Il2pv1nJOzBYWfBzaePakDFO0hCsCuQHkT9L+4dLhE
 GuUYmylGUrpwcwWJcdjXEXZlS1wbf6c842uxpzX8rwbTlqyi5FNH14VfVWIgHo7wyv5R
 t/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773866; x=1769378666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEZduNYwLQr146mwdh+OzwJtbyPDzZLUuan1YMoWbuQ=;
 b=grpro7FKPffKoM5veuSwt5jUoa1U/ZoiOP9qgfdZv09/1UD6KKt/DNptPgn04JDf+d
 ZEQ69uAqYkGJR8GRm9qxi65kjwNwPRPOWeh1ueU/RgREHuxioDIJJlj96BSxEUndH7jD
 c1jo+BxsvszqFp19mn5C35De5wgpgfAbAHhgmu0n14VtiV/1uoQ4RBf4lK0y95AVIxpE
 oUsJcLftFpxh8+gUxVjESDgeumM2xpY8G3Ja7rTcvJQrCiJW4NSyZ9A7Ebso/8ymoLas
 gNSdfcOC0AYrcSLVqEwNxpOhv+Oev5vv8Xp8z2oEBTHrOuin4reNWMt3Scf8Lvl5LK1d
 m28Q==
X-Gm-Message-State: AOJu0Yyv3v4KjOUG3JOSEUOx9LodF0EH50Ufu4F/HBDGq1WiAsTj/a7o
 LCC0Nz5V4bjnW7/b4bPth1NYXOpVXkOxeG0Q8r3LNEZ4wg6ThtqsR/b7i7QKvYdhuQ3qWx5Dmmj
 IDShxIKGO6A==
X-Gm-Gg: AY/fxX5tuAd+97mg19sB+wTvpTKkskxpsjqtJTKB83cn6Xk1VFWTfa2KbAyWp++uQme
 vJ0N1o2317l4Yxpes415Ye1mNk/nzEqsPJHZIDOnlF5ShcTRdb5Ucec4dUu+MKYuYV24+96DDfc
 Qm9UfTCIf+JD3kDlYogpzTE5ZfmKq313o/G9eGQJNV89+OrqqXPyOLprbDwS7dPzwt3x8Yo+ZKV
 SwkHPr6qF5Tfv7tH5Av4D2xQ65b7xmN9l52OptzCvPb1/tR4A6a0lPdeL8yQL2KfFOEBQEyiLiU
 IgCXhb90A02z7tahIchoSdpT5nFmMmfNVx7xxRKmju+gQrM7W2rAtjJhMdM4/SB9KDDwhcL/pqV
 jtMbXA3fDd+ZsDCrCTDEcJiJBNuvz+wSXtCHzENQ8s9t9NaNc4gxN7Oln9hQBsDN1RmoPHB/zlH
 dUqv24zhkkY2pt2YvH1g==
X-Received: by 2002:a17:903:1ae4:b0:2a0:f828:24a3 with SMTP id
 d9443c01a7336-2a7175cc0f1mr88732775ad.28.1768773865930; 
 Sun, 18 Jan 2026 14:04:25 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/54] gitlab: Remove 32-bit host testing
Date: Mon, 19 Jan 2026 09:03:23 +1100
Message-ID: <20260118220414.8177-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These deprecated builds will be disabled.
Remove testing of armhf and i686.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/container-cross.yml | 12 ---------
 .gitlab-ci.d/containers.yml      |  2 --
 .gitlab-ci.d/crossbuilds.yml     | 45 --------------------------------
 3 files changed, 59 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index b376c837dc..d7ae57fb1f 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -22,12 +22,6 @@ arm64-debian-cross-container:
   variables:
     NAME: debian-arm64-cross
 
-armhf-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-armhf-cross
-
 hexagon-cross-container:
   extends: .container_job_template
   stage: containers
@@ -40,12 +34,6 @@ loongarch-debian-cross-container:
   variables:
     NAME: debian-loongarch-cross
 
-i686-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-i686-cross
-
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 9b6d33ac13..6aeccf8be0 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -47,10 +47,8 @@ weekly-container-builds:
     - amd64-debian-user-cross-container
     - amd64-debian-legacy-cross-container
     - arm64-debian-cross-container
-    - armhf-debian-cross-container
     - hexagon-cross-container
     - loongarch-debian-cross-container
-    - i686-debian-cross-container
     - mips64el-debian-cross-container
     - ppc64el-debian-cross-container
     - riscv64-debian-cross-container
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 99dfa7eea6..59ff8b1d87 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,13 +1,6 @@
 include:
   - local: '/.gitlab-ci.d/crossbuild-template.yml'
 
-cross-armhf-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: armhf-debian-cross-container
-  variables:
-    IMAGE: debian-armhf-cross
-
 cross-arm64-system:
   extends: .cross_system_build_job
   needs:
@@ -30,44 +23,6 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
-cross-i686-system:
-  extends:
-    - .cross_system_build_job
-    - .cross_test_artifacts
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    EXTRA_CONFIGURE_OPTS: --disable-kvm
-    MAKE_CHECK_ARGS: check-qtest
-
-cross-i686-user:
-  extends:
-    - .cross_user_build_job
-    - .cross_test_artifacts
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    MAKE_CHECK_ARGS: check
-
-cross-i686-tci:
-  extends:
-    - .cross_accel_build_job
-    - .cross_test_artifacts
-  timeout: 60m
-  needs:
-    - job: i686-debian-cross-container
-  variables:
-    IMAGE: debian-i686-cross
-    ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
-    # Force tests to run with reduced parallelism, to see whether this
-    # reduces the flakiness of this CI job. The CI
-    # environment by default shows us 8 CPUs and so we
-    # would otherwise be using a parallelism of 9.
-    MAKE_CHECK_ARGS: check check-tcg -j2
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


