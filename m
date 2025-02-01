Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3D8C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGZ7-0000Fa-4a; Sat, 01 Feb 2025 11:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYn-0007S8-8m
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYk-0001Lo-BU
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso20621345e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428089; x=1739032889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RfaeHPukqP5/vmbxYrDVYoRgPjTPHLeoO2dTIS1VQiA=;
 b=xrWkNgOYcVskBP5X9rMoJTr4iDpmhzoO5/XzJValMIEGjQSyyGqejLbROqnl4rqmwq
 XtK8epczLegoXMavEaKcX/3vCGQqIc/ZbzBxfs8RPNU8ZH0fDr6knc97wSIW7lygb+do
 vy68CyZLfDRxtCMLD/Pr9+l5BQDIgOfwmzCO7IXjlIvY0lybHegmxM0ookcCAL79+7Xm
 G89G3o4pf4UDDlFFb0fH86HquhCGL0ryLWPcpJF4wl4vt4v5lamRwp1Wl6CunVYS692S
 JTalhlsDThr6OA9W10yThSZS/mZ86Exk5CdJTJ900xzD1RGdehyVUoPMM3pHDGYxYlK/
 JZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428089; x=1739032889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfaeHPukqP5/vmbxYrDVYoRgPjTPHLeoO2dTIS1VQiA=;
 b=tVzAfAgx/OMwY3zugFM6m4d7gTPHixbqwyGwK90gijLMbpXj1BCUhmVtogc+bOi2b4
 ZvYs9YCRGUum59RmyJfZyOE0t+0BDw0GPXTBXHhyT5m18mH8TBm+maHr+3YoHHaT/zT/
 bkdXgXnlVTCWWwuYEkpeQyIT4IwohPwf4X10DwS0PnmrC88aTTUoByODqqTQ2EfsDs0P
 aPPi3NWfuIKkHE87UTtfyCr9cJ+G8FVkWz4ZQJ9TdRawMjzfuPjzZFxIS9aV3dq3t440
 B6JvZdooGwSXZlT/9W2LlJJpYAf1Ra5TBIxvWe6/4MFywl4I72K9Llp3PsP+MHj//E8I
 FcTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNz5vSPAc06zGFSgq8cuRyWHs1fcePSqLyvyh25QGRKUuzCqsa/npzjgQpoaunTRXJDv8MLoHXNBO6@nongnu.org
X-Gm-Message-State: AOJu0YxhXYzAIxR0XaweDcwJdm/oT1leY99aYfrt0XM5PcnDl6t5lNrJ
 JEul1u20pVea7CXMduE5e8/K1UpcQjCPaIj4txFeSF7Wbqtma+7527EnevzYJ+NgC6wd594/dVN
 b
X-Gm-Gg: ASbGncsIl8GmrEMfNwxU4k421hudpFYbytuuWH7ZEVolRMzd5kZ8gw1BHkeWYphgAvF
 A9S8lM4QYI32OF2nzFi2GJFW7+b0krgHyNX3oKjncOEXo0LiE6Hq9dtSCaeekJ3f0zjrZTC+ZUg
 VFkGX1kUft+lngRvw+xTjp1FZyCrclOTNDytZsMgt56c0gS86UM6Dr711igrk+07EDxxAGqyklx
 dLLGGiS/SyGj6UNXreK4e64RnPXd8ZScuMDvnCXAamQzbbYOPIt41K5Z31WGAu2Bzn/WmSSPUA6
 Ht3UDZC3bhySu/E6Wy8A
X-Google-Smtp-Source: AGHT+IH2Jm3CzGZr2u8b/Th4Csts3hz+6VM4hjY4l0NGhThSrGeEgOVroPNgE+IGIbj/H7X6OiCeVw==
X-Received: by 2002:a05:600c:1d1e:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-438dc3bd896mr142840605e9.8.1738428088887; 
 Sat, 01 Feb 2025 08:41:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 58/69] target/arm: Remove standard_fp_status_f16
Date: Sat,  1 Feb 2025 16:40:01 +0000
Message-Id: <20250201164012.1660228-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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
index c025649ff24..893a2cdd0a5 100644
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
index 8fa220a7165..b887edf1d19 100644
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
index 66a482a9add..4920afeb012 100644
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


