Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38106C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0k-0007fm-J8; Fri, 21 Aug 2026 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0h-0007Nj-Ls
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0f-0007L6-KQ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso15556835e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310124; x=1787914924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A8JHAqmDcN4O81D571sT2d4dAyJDQaqEm7zYyrqJnRE=;
 b=hNkVFvauIibw+jdXd9GIpPGGwzBt7JBvCx20fDpMTwE7YpQcbR2AFz3h+MYWfZ6Q7E
 8No+VlNMRnjKC7Z9fn2IumJTRWzwLck9q9lK52+Zf3qP1/r5eglx5shIA9qHF/mpH/7B
 aqBbZqEH7Z+Dvwzhu4qR/WtF3B/JzHwbemXe3sPRoR6J/mLkFUxcwvc0k5kAoVysCnDP
 W/8/sI3ge7NmdgPge3q93ni/LbKKeO+NjPhOcv/zLrX20ZfsGBaTEm9Wwqe37vo5Sc9k
 c6oOoBMoC+nbVZTaPegBZ1QrVaO20zJ92LKzUhD2bg9ZtmEqwTbeiNl28Z7HmX4DkgjX
 GeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310124; x=1787914924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A8JHAqmDcN4O81D571sT2d4dAyJDQaqEm7zYyrqJnRE=;
 b=SsldKHaL3RKZc/u2+0GKcWFkcFUsC29GPuOZm8LEzt427VaucH0beYudQMInI11D0J
 9A73vaUbCX1CMpKzB/8Txk1BOJK/4i17COy5K2QM2bN5FwVabMtzlWz/DNJk1KXQ8Gcm
 dbJJMt5SAtFZaYk3EO7fDxAgytjtemX0N4eRiMtrh3VgD3ux0v00O30JntspuWpwfreH
 PCfWHeDFIL3DASH6m2iTrqYUm875wy2ZU4gpWuSTRaQWgmwuRv3Zm8/qz8gXkLk45Xza
 iZDdo2XOMlzJl2VpFHux6eDuQtXVj6l6EvL7ZX+bGPFX0LAgYBbLe4ZKJgC1OwBEklJu
 vG5g==
X-Gm-Message-State: AOJu0YyCd9Rh8+J2S96bLcCV5HYzJ+5zRhwirSyLx2Ug1Fkz8c59QHK7
 Vmm72147P2lRSUkCr6FHnscKV08OjYWHtP0q7TIytNKCkYRfD/QiHIAwO8E+4jbnnCn4ndRCBaQ
 QYUL1
X-Gm-Gg: AR+sD10aNfcS2HBGqxLrww5g3IPd09q1Z3a/a63T+TaJN/9BnqPBHbL0QRx14YIO2K2
 LXY+d0fZytMxz5e9l2bNAcmeKL4APq7SErO+0QYSVGwYa9fdXWZGWD64AbqrOdx8TyOjfwlxtR8
 JM8rl5s06cqT0OX4SkP0dOEIfRx11qZMQIHNQ7JKABxC77f0AvV3smQboPmgYR1LmYkN44dOhnZ
 N6xf3LWXz7XkKM4Yw2TzcCVePKxkIted482z84mjpqzkBMJMnHeJmNkpAENUbJpFhEMqr6U5ILK
 CBvnIhKIi4XtiR0Yf/N8Pg3y1Trf57EjxPozIBfjDenQEi2wR+88M4RxwSrLZCDOn5meSgm3m6l
 q8XA/AjOv7FPpV0tMXDdDKvrHr2uF4w76s3andRcU654jrJdN831hcB7id7ataFEvvIoqLTRljb
 zcfjZTmySPLX/boFyw2vk8HlutrbUsuz3A8AT25lP6OoULrniFdTDYdzmwtT/mE1KML3B+Qu9An
 Bm3KxpTLWryLYH3wbfAtAGoTFMssFm/BXT64hFWAaMB30wqDvagm7+zFxOCLzLpXAmb3w==
X-Received: by 2002:a05:600c:1912:b0:499:8d9b:832c with SMTP id
 5b1f17b1804b1-499b9182141mr45304635e9.4.1787310123715; 
 Fri, 21 Aug 2026 04:02:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/43] target/arm: Handle NSACR.NSASEDIS in CPACR accesses
Date: Fri, 21 Aug 2026 12:00:34 +0100
Message-ID: <20260821110101.3971391-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In cpacr_read() and cpacr_write() we have code that implements the
"CPACR.{cp10,cp11} behave as RAZ/WI from NonSecure when NSACR.cp10 is
0" behaviour.  There is a similar requirement for CPACR.ASEDIS: if
NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.

This doesn't matter to us yet because we don't currently implement
ASEDIS or NSASEDIS. But we're about to do that, so add the handling
to cpacr_read() and cpacr_write().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index adae2b2b8e5..6a707b80cff 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -588,11 +588,19 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /*
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     * Similarly, if NSACR.NSASEDIS is 1 then CPACR.ASEDIS ignores writes
+     * and reads as 1.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
-        value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            mask = R_CPACR_ASEDIS_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
     }
 
     env->cp15.cpacr_el1 = value;
@@ -603,12 +611,18 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     /*
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     * Similarly NSACR.NSASEDIS makes CPACR.ASEDIS read as 1.
      */
     uint64_t value = env->cp15.cpacr_el1;
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            value |= R_CPACR_ASEDIS_MASK;
+        }
     }
     return value;
 }
-- 
2.43.0


