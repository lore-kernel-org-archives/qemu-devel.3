Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8681BC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYt-0005OV-Fl; Fri, 24 Jan 2025 11:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYd-0004Fs-LS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYa-0005aV-3v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so23481905e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736159; x=1738340959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Bgl+ZIxVXe0JFRcnJx8Zd9vTtPNDxDGEduc3gMGLhE=;
 b=NbObekREb4g8E2a3l5qsq/7B7njOfV9rH1b/uffiCkBcjjUhwzKVWxXEYBno9zEdyY
 XyONPkttvd8xazHwWDU3Sq3v/0j9K4dFQ3mz1NVcko7R+Vtl+zdPDFs3ZwOoBAA/mlyk
 J7GbwD90y4QHN1ue2M7J1cXQ5oTJun0Nn4Xm7+yCs2sg4uxkZgV2nsxo4zBhnPaEomm5
 pmd7inscEtHJp51I2yMk91H6lTrEc5C6yQeqDUk6VftEf+DWJ6hM/nOVHIZrj7FNAYru
 7EMiuWQu9jbhyNUnkE2ZIaF1rdw5LFfgH8szJKKcIUW2P0BfOmgAfvsWTwQLtFpfEug2
 kgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736159; x=1738340959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Bgl+ZIxVXe0JFRcnJx8Zd9vTtPNDxDGEduc3gMGLhE=;
 b=sMSQSMSVn7jlsPtpJ8bHnVmAQgb588eEZKMTmLbHV0+CzrCm9GXcLkXGrtLelitHAe
 g27Mmaxi7xiloiPibUUVt7r08TsUOY4OiPyxyPV/cnaJJbsaQZTuzNmWQDvGhqL4v2Mh
 ZYIP/n8bK62Do1udMaIXXjo+L3CWQZt5+uxFoN4XH9uGD12dR9CNNHkITOyMQEviHRwY
 HIFQZW0CeNNwF2EnBBkJhVgfMrhFA6hYnHznrBhLGvjOVPiobxbHhSujiOnMRgcHv1+U
 8MDxJ7MfunSePYd05UUFBRKk7VfbQA2twinLQZRqTLq5GPCdaHal8CE5Gsits52RIU5U
 6vOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVONy8Hx5z7DZbcbQGyaopDrBRv8nAzxfIUJEOuvzK0hGAArMpEE4h2lJe2gQ0Diw0J4Fhknh0+0tan@nongnu.org
X-Gm-Message-State: AOJu0YxQ4qO6kLxEkuCUotqKGaD0mzS6P3KWeIcp78MVLVJ6EwIz0tSF
 Dcsk0+fvfpiKYVTJ9Fy7PHsRk7fNTNpR4PxMYuTntgY/uPkQUfu9gd7dtrmVGos=
X-Gm-Gg: ASbGncvLLahT+sJtwI+vrnn/Yk+DGurSczxV9WSv+NPepFSZEaf4A0p0RMLrcDytV0V
 N4HAyC05XGQjxBBf7k54I5DgENkDM4P1EG+eN3536HbJI5HfBX1ZxWYFriKi3HrocICVXPX3ILN
 3Qn6EIhMF8/CtwEqOXVsjQmX6H1kaVcsIW7ySSTwBx6cH7kL1cB0gY9QddjX7jEQKXqG7dSH88G
 HTCk9Upj6qKBBZiVV5+o+VVqJad/lpe3Quf7BCBCxcxadxAejPsmmx3Rq9bKVxPPZQA7IdD+K1A
 YXM/ZeSKcKc=
X-Google-Smtp-Source: AGHT+IF0a+8UgIf0TpPNPzNEtT/p9a7asyrvpsnB4z93WH+cHF2nPxplgx6E9gdvLUy7O4yzZj6q7A==
X-Received: by 2002:a05:600c:34c9:b0:436:f975:29d with SMTP id
 5b1f17b1804b1-438913bffd9mr286485905e9.6.1737736158666; 
 Fri, 24 Jan 2025 08:29:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 32/76] target/arm: Set up float_status to use for FPCR.AH=1
 behaviour
Date: Fri, 24 Jan 2025 16:27:52 +0000
Message-Id: <20250124162836.2332150-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When FPCR.AH is 1, the behaviour of some instructions changes:
 * AdvSIMD BFCVT, BFCVTN, BFCVTN2, BFMLALB, BFMLALT
 * SVE BFCVT, BFCVTNT, BFMLALB, BFMLALT, BFMLSLB, BFMLSLT
 * SME BFCVT, BFCVTN, BFMLAL, BFMLSL (these are all in SME2 which
   QEMU does not yet implement)
 * FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS

The behaviour change is:
 * the instructions do not update the FPSR cumulative exception flags
 * trapped floating point exceptions are disabled (a no-op for QEMU,
   which doesn't implement FPCR.{IDE,IXE,UFE,OFE,DZE,IOE})
 * rounding is always round-to-nearest-even regardless of FPCR.RMode
 * denormalized inputs and outputs are always flushed to zero, as if
   FPCR.{FZ,FIZ} is {1,1}
 * FPCR.FZ16 is still honoured for half-precision inputs

(See the Arm ARM DDI0487L.a section A1.5.9.)

We can provide all these behaviours with another pair of float_status fields
which we use only for these insns, when FPCR.AH is 1. These float_status
fields will always have:
 * flush_to_zero and flush_inputs_to_zero set for the non-F16 field
 * rounding mode set to round-to-nearest-even
and so the only FPCR fields they need to honour are DN and FZ16.

In this commit we only define the new fp_status fields and give them
the required behaviour when FPSR is updated.  In subsequent commits
we will arrange to use this new fp_status field for the instructions
that should be affected by FPCR.AH in this way.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm not super enthusiastic about the ah_fp_status naming, which sort
of suggests it's always to be used when AH=1, rather than "for this
specific group of insns when AH=1". But I couldn't think of a better
name that was still reasonably short...
---
 target/arm/cpu.h           | 15 +++++++++++++++
 target/arm/internals.h     |  2 ++
 target/arm/tcg/translate.h | 14 ++++++++++++++
 target/arm/cpu.c           |  4 ++++
 target/arm/vfp_helper.c    | 13 ++++++++++++-
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8b44c725d0..cfb16151577 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -640,6 +640,13 @@ typedef struct CPUArchState {
          *  standard_fp_status : the ARM "Standard FPSCR Value"
          *  standard_fp_status_fp16 : used for half-precision
          *       calculations with the ARM "Standard FPSCR Value"
+         *  ah_fp_status: used for the A64 insns which change behaviour
+         *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
+         *       and the reciprocal and square root estimate/step insns)
+         *  ah_fp_status_f16: used for the A64 insns which change behaviour
+         *       when FPCR.AH == 1 (bfloat16 conversions and multiplies,
+         *       and the reciprocal and square root estimate/step insns);
+         *       for half-precision
          *
          * Half-precision operations are governed by a separate
          * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
@@ -654,6 +661,12 @@ typedef struct CPUArchState {
          * the "standard FPSCR" tracks the FPSCR.FZ16 bit rather than
          * using a fixed value for it.
          *
+         * The ah_fp_status is needed because some insns have different
+         * behaviour when FPCR.AH == 1: they don't update cumulative
+         * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
+         * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
+         * which means we need an ah_fp_status_f16 as well.
+         *
          * To avoid having to transfer exception bits around, we simply
          * say that the FPSCR cumulative exception flags are the logical
          * OR of the flags in the four fp statuses. This relies on the
@@ -666,6 +679,8 @@ typedef struct CPUArchState {
         float_status fp_status_f16_a64;
         float_status standard_fp_status;
         float_status standard_fp_status_f16;
+        float_status ah_fp_status;
+        float_status ah_fp_status_f16;
 
         uint64_t zcr_el[4];   /* ZCR_EL[1-3] */
         uint64_t smcr_el[4];  /* SMCR_EL[1-3] */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 98073acc276..b3187341456 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1831,5 +1831,7 @@ int alle1_tlbmask(CPUARMState *env);
 
 /* Set the float_status behaviour to match the Arm defaults */
 void arm_set_default_fp_behaviours(float_status *s);
+/* Set the float_status behaviour to match Arm FPCR.AH=1 behaviour */
+void arm_set_ah_fp_behaviours(float_status *s);
 
 #endif
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index c37c0b539e2..d6edd8db76b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -676,6 +676,8 @@ typedef enum ARMFPStatusFlavour {
     FPST_FPCR_A64,
     FPST_FPCR_F16_A32,
     FPST_FPCR_F16_A64,
+    FPST_FPCR_AH,
+    FPST_FPCR_AH_F16,
     FPST_STD,
     FPST_STD_F16,
 } ARMFPStatusFlavour;
@@ -696,6 +698,12 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_FPCR_F16_A64
  *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
+ * FPST_FPCR_AH:
+ *   for AArch64 operations which change behaviour when AH=1 (specifically,
+ *   bfloat16 conversions and multiplies, and the reciprocal and square root
+ *   estimate/step insns)
+ * FPST_FPCR_AH_F16:
+ *   ditto, but for half-precision operations
  * FPST_STD
  *   for A32/T32 Neon operations using the "standard FPSCR value"
  * FPST_STD_F16
@@ -719,6 +727,12 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_FPCR_F16_A64:
         offset = offsetof(CPUARMState, vfp.fp_status_f16_a64);
         break;
+    case FPST_FPCR_AH:
+        offset = offsetof(CPUARMState, vfp.ah_fp_status);
+        break;
+    case FPST_FPCR_AH_F16:
+        offset = offsetof(CPUARMState, vfp.ah_fp_status_f16);
+        break;
     case FPST_STD:
         offset = offsetof(CPUARMState, vfp.standard_fp_status);
         break;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1ba22c4c7aa..8fa220a7165 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -556,6 +556,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
+    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
+    set_flush_to_zero(1, &env->vfp.ah_fp_status);
+    set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
+    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status_f16);
 
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 2eb75bd7ecc..50a8a659577 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -64,7 +64,7 @@ void arm_set_default_fp_behaviours(float_status *s)
  *    set Invalid for a QNaN
  *  * default NaN has sign bit set, msb frac bit set
  */
-static void arm_set_ah_fp_behaviours(float_status *s)
+void arm_set_ah_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_after_rounding, s);
     set_float_detect_ftz(detect_ftz_after_rounding, s);
@@ -128,6 +128,11 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
+    /*
+     * We do not merge in flags from ah_fp_status or ah_fp_status_f16, because
+     * they are used for insns that must not set the cumulative exception bits.
+     */
+
     /*
      * Flushing an input denormal only because FPCR.FIZ == 1 does
      * not set FPSR.IDC. So squash it unless (FPCR.AH == 0 && FPCR.FZ == 1).
@@ -154,6 +159,8 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
     set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.ah_fp_status);
+    set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
 }
 
 static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
@@ -199,9 +206,11 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
@@ -225,6 +234,8 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
+        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status_f16);
     }
     if (changed & FPCR_AH) {
         bool ah_enabled = val & FPCR_AH;
-- 
2.34.1


