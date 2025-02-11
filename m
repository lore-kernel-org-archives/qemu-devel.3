Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D819CC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8W-0006EG-0V; Tue, 11 Feb 2025 11:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6I-00072f-Q4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:09 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6C-0003dI-Jz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso19853115e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291216; x=1739896016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j7Y68wjeOb/Kb0SXOQGa0U0IFqx7BAUAd1xpGevlz4c=;
 b=LWGVP4gE1wMfhjqXyNsbbCF+mPHI06vGGUaC1CegLcTidAZl9Rlq4dWkoWWKixhe6a
 aYVWUP6eXFgVPIxU7lLM2CX4455H01ev5WRVH8QfkX6zCHNRVx++8Ee4a1aRfrsLmvti
 eaS5oln2Q8eeUCxToHuoMk1IQXw1A5+bpGFvZQU+xR2BNA4Qzir8W27uDZCmkscYWHHv
 iIir8Q+zF75hEgMoUUy+kK6lcQMvXTzmYXa+SgWjHX5DvBvWwfi1Hm+ivD7xbqxEM9br
 4hwQmfT+h/MmG13NFH36JTzMQAtVWisyhxJPKcbdkCxl3iMiaT8OHw3RikSw5R3ZxIjD
 x84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291216; x=1739896016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7Y68wjeOb/Kb0SXOQGa0U0IFqx7BAUAd1xpGevlz4c=;
 b=YvH/va15ELT0S8VXjiRCUwr2LXCBi3k1IhmhTssxX8W3svKT0kEOA7gYAFpcMD1gQz
 L6qGRs9MEwqYo8gwEo5haNerq9SuDkyrlkJx/jDvmzb9o8kQDOpdNPzpJ4l2cHs+NJY7
 p5tb+0CQVNSUEicKKbwHgIVK9SmGRRdRzCEfHmUaYnTYIYrt/e6jeqsDvt86FnvAnzOI
 ldGGXJt337irqrkvrelMHP+87eDLahbFejwLVSgEua4RXXhu3kmrXyqTan8q4jpapcvo
 h1UctEWLnmZwDEMbv3GEI9g4u38YGz4ovWrGuQUCVowxqmLZsn/cl3kQ2H2DvCC7dCr1
 Hx6Q==
X-Gm-Message-State: AOJu0YxhNjX8zF5n6EDS2IE/KNpon5TJd/efa+bIe5d3u1FyByqObcgG
 unqfmOxmmEXzPZwKNelXQAwGGBxt+jWK6cB5TQYpZtsRhoIxapW/kkqewM1yC0Y02zl+OZAcdRA
 H
X-Gm-Gg: ASbGncvVpaFE6hSRLJISJhhv8OvOWO1lHKpNpgnc5oKGX4avg82vh7HBfnJArsjN1DU
 ovCfDe27lsw2uBGkbSJ2nQgghUm7jO3FAnfkEXqMf04Nkr97PfZK2FmJFTDOUKgkieMv8WWmoqi
 fAqOyr9Cvs9C7KCUHvslbWevRrllwWAaUhb7bW9xfjvddS2dDsWwro1a42u930kUaKYT1bRLUrL
 ebtmF7vIMWiXbRUgHZigQwD6A1qR0pqKZhn3LBpavdhqC6hwBhnyzx7acav2OztqPrBMEqAoqcw
 +UFXhXoE5W/MVxwN/xPa
X-Google-Smtp-Source: AGHT+IHcucq+OM6eUwa+sInEs7J+QYscxPpMD6FaQmitqEUqWWbHwKtnIW3MQCUG88SevUizMA0ukw==
X-Received: by 2002:a7b:ce8c:0:b0:439:31a6:276a with SMTP id
 5b1f17b1804b1-4394ceaf874mr36889045e9.2.1739291216114; 
 Tue, 11 Feb 2025 08:26:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/68] target/arm: Remove standard_fp_status_f16
Date: Tue, 11 Feb 2025 16:25:43 +0000
Message-Id: <20250211162554.4135349-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Replace with fp_status[FPST_STD_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  4 ++--
 target/arm/tcg/mve_helper.c | 24 ++++++++++++------------
 target/arm/vfp_helper.c     |  8 ++++----
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bf68e135d73..085d5383e05 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -697,7 +697,6 @@ typedef struct CPUArchState {
                 float_status ah_fp_status;
                 float_status ah_fp_status_f16;
                 float_status standard_fp_status;
-                float_status standard_fp_status_f16;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1307ee34ce5..c6d91fd2c8f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -549,13 +549,13 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_flush_to_zero(1, &env->vfp.standard_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
     set_default_nan_mode(1, &env->vfp.standard_fp_status);
-    set_default_nan_mode(1, &env->vfp.standard_fp_status_f16);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
-    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status_f16);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
     set_flush_to_zero(1, &env->vfp.ah_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 03ebef5ef21..911a53a23a8 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2814,7 +2814,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
@@ -2888,7 +2888,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 r[e] = 0;                                               \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
@@ -2926,7 +2926,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
@@ -2964,7 +2964,7 @@ DO_VFMA(vfmss, 4, float32, true)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE * 2)) == 0) {          \
                 continue;                                               \
             }                                                           \
-            fpst0 = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :   \
+            fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
                 &env->vfp.standard_fp_status;                           \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
@@ -3049,7 +3049,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
@@ -3084,7 +3084,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
@@ -3117,7 +3117,7 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         TYPE *m = vm;                                           \
         TYPE ra = (TYPE)ra_in;                                  \
         float_status *fpst = (ESIZE == 2) ?                     \
-            &env->vfp.standard_fp_status_f16 :                  \
+            &env->vfp.fp_status[FPST_STD_F16] :                 \
             &env->vfp.standard_fp_status;                       \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
@@ -3168,7 +3168,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
@@ -3202,7 +3202,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
@@ -3267,7 +3267,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
@@ -3301,7 +3301,7 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         float_status *fpst;                                             \
         float_status scratch_fpst;                                      \
         float_status *base_fpst = (ESIZE == 2) ?                        \
-            &env->vfp.standard_fp_status_f16 :                          \
+            &env->vfp.fp_status[FPST_STD_F16] :                         \
             &env->vfp.standard_fp_status;                               \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
@@ -3427,7 +3427,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.standard_fp_status_f16 :    \
+            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
                 &env->vfp.standard_fp_status;                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 9d58fa7d6f5..61e769d4303 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -122,7 +122,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
           & ~float_flag_input_denormal_flushed);
-    a32_flags |= (get_float_exception_flags(&env->vfp.standard_fp_status_f16)
+    a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_STD_F16])
           & ~float_flag_input_denormal_flushed);
 
     a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
@@ -160,7 +160,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
-    set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
     set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
 }
@@ -207,11 +207,11 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         bool ftz_enabled = val & FPCR_FZ16;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
-        set_flush_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.standard_fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
     }
     if (changed & FPCR_FZ) {
-- 
2.34.1


