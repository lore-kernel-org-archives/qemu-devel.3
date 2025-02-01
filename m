Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E95C02195
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZO-0001vF-EX; Sat, 01 Feb 2025 11:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYq-0007Tq-3C
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYo-0001Mn-Em
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:35 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so2764880f8f.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428093; x=1739032893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pJ4Llm9zmJe0iTGfKF6gDwvUK7rJ3o7BNts192kJkZI=;
 b=S5qUZWU7MalbRYKixVz0HgueIp9QsIZCu2V3X1Bh4DwLYH8nibZ0I7uFzvZjKsdvKT
 EFdVqz+k9tP2ZnRABcjHZxmMcskNLyMcoRVzuBWiS288v7QFEyY6vie50920O4HQUprR
 apRZgbuF73RFPfwMTu3akDQPhzI+723650B/lVJQAtxSbp/s3rkFZx8rIAXHGJFLP6vn
 FLmj4UrtHmJYuArxvF5FcUH2Y4CNEjQULqAqL9zm+c7qd8o4EAdcDYzC5cXok5y9ptSg
 CcVIyKVg/M1UsBiMzoBeexDow8I2oE+H2ig6iJzWCwjrG8TViQYtkuK8mPKuGn8Hoh3p
 UftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428093; x=1739032893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ4Llm9zmJe0iTGfKF6gDwvUK7rJ3o7BNts192kJkZI=;
 b=SWoikQ5OSJbQ785ism6dsQWAn0HuKTl4D2daWQobZ2pLq0dtWQXixB7PLm9oSQcMTx
 t7y24dhwwyscYZ1aSn/yNZcX+xGJ7MZJYWvUmC5PxjX0p70IIj0oBrCfCtyRepQV/EPI
 at95SPsKhzU/JfKvLEgFl4OJKorNBFkNxwmAbBMSfphk1UsA65y/efLH1XtGIP5hQ2QS
 uTocfeXdeOKTCXc+kwGpY2oNGagK4kfhmmxvl82N+8RVaNbC5lPXzYK5jrtoo0u9QoTx
 DTwCzEMDRu23tJMzWIOstfD3YI2EVj7WRGgXa41kbBYV1Yi2uhTEzR37IsPhMvwDCh5o
 GBNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjfeV4vVQK4ysUpB9fsax/i654BmOS+7/EfMCkQQU6FY5ivDpcIi8LjF+SJZYGh+TqpfDJ/VqGluAb@nongnu.org
X-Gm-Message-State: AOJu0YzrncUNyW7RaYrmLkDvZ9T2LVgukmCzk6lYj8h+9GPjQ+MZSxQK
 qpu0Pth2s6/QckBB6PCzSALW/cEgear5zvpQuv9vTjMfjbkE8lRCe8TrZcgPU1CmA0eY8TBjhNU
 6
X-Gm-Gg: ASbGncsYc55WRrG/XcrzdqsrxmATkSSaFe1RTpPrN25WwiK5kpqhW92zrL/1sHW055H
 WwwtS+0LYP6UmdLGnC5O3+gYW52kNPuYjSRHNr/+sgKDcxEHPfXr1J88A83LDLTlJS9BIXu9SLo
 fROKiVGvTM9t6X8a1sz0XbqbPfP/2AI2aa8ogFUPmUV9nBREbl8IE4s1SJBGfhWT2bACtVdK/j0
 +Wr9qgXn7ZKVyirzHV3kx6uRRqUKM1n6nt8ZC4hl4yexIG0FPf8km+d1/b2RXoPmIuzM3uBzxPI
 Kl92AtJebi+N6N5S1c+P
X-Google-Smtp-Source: AGHT+IEddXm7uIyK1pg7Dzxx3PuRbe/slx2NB4vSnnBWjVY55Dj66rImDAukkHBTUK90CQucrB8qfg==
X-Received: by 2002:a5d:64c6:0:b0:386:4a16:dadb with SMTP id
 ffacd0b85a97d-38c60f1832amr7918473f8f.11.1738428092896; 
 Sat, 01 Feb 2025 08:41:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 61/69] target/arm: Remove ah_fp_status
Date: Sat,  1 Feb 2025 16:40:04 +0000
Message-Id: <20250201164012.1660228-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Replace with fp_status[FPST_AH].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 3 +--
 target/arm/cpu.c        | 6 +++---
 target/arm/vfp_helper.c | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0f7d5d54305..5e3d952588a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -233,7 +233,7 @@ typedef struct NVICState NVICState;
  * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
  * using a fixed value for it.
  *
- * The ah_fp_status is needed because some insns have different
+ * FPST_AH is needed because some insns have different
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
@@ -694,7 +694,6 @@ typedef struct CPUArchState {
                 float_status fp_status_a64;
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
-                float_status ah_fp_status;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ffb2151de56..01a0428c6ed 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -556,9 +556,9 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
-    set_flush_to_zero(1, &env->vfp.ah_fp_status);
-    set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
+    set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
+    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index b77f27d1811..09e707badeb 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
+     * We do not merge in flags from FPST_AH or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -161,7 +161,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
@@ -236,7 +236,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
-- 
2.34.1


