Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDB4C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80U-0007NT-L3; Thu, 06 Feb 2025 14:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg807-0007A4-EV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg804-0000TM-Sn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:27 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f49bd087cso9131315ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871843; x=1739476643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gdYxBdEqJ0uWnKxFXykRwPyqfo99tq7h+X2aYPXavI=;
 b=RpqfLlq5Zgv0hEiGc1/z9nZazSJDw9X8wN515rlCDp+4UD1fXiZCZ5ZFks1+3Xhqqq
 AGfvW7zoJ59vKHoxflM5Jx9Plju7eKrkMyg5wMXMU3Y2L/zJfuIDrOanJpNhXFF7EeuB
 Re5l/B+XRZkWrvdo5z7QRHTNpjK8DA+X+OmoVcPNU9k96/gTCmJrUT7cUHUM46nvr4oT
 fBbRcWCShPCQmieMNvTyHjlM+tI5WocJoGaUR892izDqkm4meSbM0sGeqaZiD1KYtzJ/
 cTYoFV0s4B8yOZ/XVBy7o0Yp0LGZi5O59P9ka5a55JgzP0flRjTZ/qnVR1UkNr+R8YBa
 VuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871843; x=1739476643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gdYxBdEqJ0uWnKxFXykRwPyqfo99tq7h+X2aYPXavI=;
 b=QRL7ROhVizQmHN8r2o1tODZ2iUVFXwOuuiWcG+hkgeMJ+Tc8DbhSiBS9KFNz7kx8IW
 qA5bn1N5HSN6ZgHE75jljXOxPMr2TtHIR+v4lNheOGROxtkQaeajFg3HkJGq3ttQTL4H
 rtKvJWqX9Sp5/CHEj+CMqByVSDZuApY+JQyXqz+qe39Pj7H+O609GUJwpv8LyPm/fWy6
 wdcjNyZmFl4H3/OiPW5onRrnqwfjal7AuMG/U74am3k1EOpd25Ydc8Aq6PBZGGERBRtG
 DxquMw1dAgXNuFOOkrKUx9o1WOeD2BBRyEtv9MB8xBx1jou8ihJNTL12E8Z5QQUkbnVB
 F40g==
X-Gm-Message-State: AOJu0Yz9et4kRe1FWFS1jj8lNmM4ocevcn2EjG4JvI4/bUIhFjksGzSu
 rCGdI2LmeNJTx4UWcDh8qCaqZex2hn2ghjScIogjOKfI0z7CB4ZrL1oCUUdbw1bAJdOsiCEx0Qx
 b
X-Gm-Gg: ASbGncsqv5mDDR8u3laCyX9FqUGUuRmfaVB9AAVpGDidKWskQYYFpkqFd/6x68WOwFE
 CriAgNjMAXs5CiJNEeC+AdfHouw/dLCXnmGEqcNG4gSBUxb91UYegWnHSHgHi1+Tt/gjjdC7qEy
 ecsy04ROk8ffnA4XJM4Dqij8rWdJyOiuK6TGgNR3El1SrX9CoEHD0+SNhy75yYeCz4rvvxQaY8N
 G+B+uxzd7xXtsDn5VhVWe4g76Bo3CArja79jYP4KFBMxKxMolYUJtiiUcu1aVXmHg10y0RIVzYy
 JnI12g6DtQtYO4pnO/o/QARIA3of0OuTJi/0vkdtqx9pdzI=
X-Google-Smtp-Source: AGHT+IGGILMxv070Lvy1mY8cP8CGQ25IqbLwZWKBHY9M6Ob5l6GkJtAV14dtNzoEpiVAEEfe6TFcQQ==
X-Received: by 2002:a05:6a00:420b:b0:71e:e4f:3e58 with SMTP id
 d2e1a72fcca58-7305d4e7461mr850654b3a.17.1738871843516; 
 Thu, 06 Feb 2025 11:57:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/61] target/arm: Introduce FPST_ZA, FPST_ZA_F16
Date: Thu,  6 Feb 2025 11:56:23 -0800
Message-ID: <20250206195715.2150758-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Rather than repeatedly copying FPST_FPCR to locals
and setting default nan mode, create dedicated float_status.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        | 12 +++++++++++-
 target/arm/cpu.c        |  4 ++++
 target/arm/vfp_helper.c | 10 ++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e6513ef1e5..42c39ac6bd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -219,6 +219,8 @@ typedef struct NVICState NVICState;
  *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
  *       and the reciprocal and square root estimate/step insns);
  *       for half-precision
+ * ZA: the "streaming sve" fp status.
+ * ZA_F16: likewise for half-precision.
  *
  * Half-precision operations are governed by a separate
  * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
@@ -239,6 +241,12 @@ typedef struct NVICState NVICState;
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
  * which means we need an FPST_AH_F16 as well.
  *
+ * The "ZA" float_status are for Streaming SVE operations which use
+ * default-NaN and do not generate fp exceptions, which means that they
+ * do not accumulate exception bits back into FPCR.
+ * See e.g. FPAdd vs FPAdd_ZA pseudocode functions, and the setting
+ * of fpcr.DN and fpexec parameters.
+ *
  * To avoid having to transfer exception bits around, we simply
  * say that the FPSCR cumulative exception flags are the logical
  * OR of the flags in the four fp statuses. This relies on the
@@ -252,10 +260,12 @@ typedef enum ARMFPStatusFlavour {
     FPST_A64_F16,
     FPST_AH,
     FPST_AH_F16,
+    FPST_ZA,
+    FPST_ZA_F16,
     FPST_STD,
     FPST_STD_F16,
 } ARMFPStatusFlavour;
-#define FPST_COUNT  8
+#define FPST_COUNT  10
 
 typedef struct CPUArchState {
     /* Regs for current mode.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 180e11c5d7..ba08c05ec6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -550,11 +550,15 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index ff4b25bf28..f26c0d211e 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -202,6 +202,8 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_ZA]);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_ZA_F16]);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
@@ -209,15 +211,18 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_ZA_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_ZA_F16]);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_ZA]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A32]);
     }
@@ -229,6 +234,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool fitz_enabled = (val & FPCR_FIZ) ||
             (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
         set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_A64]);
+        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_ZA]);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
@@ -246,9 +252,13 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             /* Change behaviours for A64 FP operations */
             arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
             arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
         } else {
             arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
             arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
         }
     }
     /*
-- 
2.43.0


