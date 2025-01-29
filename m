Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D55FC02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2y-0000sN-4m; Tue, 28 Jan 2025 20:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2q-0000nR-5y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:08 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2o-0003V2-6M
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:07 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2163b0c09afso115531415ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114745; x=1738719545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/o3PZF+VYx9BlUZcSvSihlV0semqIWO9oR/VySJrxZU=;
 b=w16XCVW3VYxiyLaZpsmZVxHxNUXbJcxSTcshsxbB7Fn0isdCfcdhTR+jcD9jvZxpUj
 jHJa8mD8G/m5XQ/n7D5fvqME96tZOzm8c4dOcJTLDZTRdQqMylhHoprLu9Z9ordERKGI
 WWtJDMfTjwZqPcq+CCo+TcSNuWgqoQFO+zinOoLdg/0I0Y+AaezrJzsvvXLuQL92KdfQ
 l9DK+7NBSZiKsswOOtBmDoB2t8Oo5SUS0VWU3CHCzXeuS/TJjKWhQfVi0qZld1JsSpi8
 iM38j/TRlm8d3INj+ZbIzWtdF73KemoGUm7rjC5MrhXd0tdy4Yv1Dk1rFMZcqdCIKa0n
 2XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114745; x=1738719545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o3PZF+VYx9BlUZcSvSihlV0semqIWO9oR/VySJrxZU=;
 b=D7WyFcQ/ocQyxmiw08ABl00f6InaHecGMVT8t67XsGo+acwNMaRpcHjuDHdcoDYF98
 B8HJzFw8DI2wZb6aoWqAzSt0MfUO3LNs5Yj79Mse7h3FRn8sXmcKeqP7eImWnW79I0UE
 DYDkTbgds6n1PEymjoap3SYX3cFJQ1d9yhkt4qIOPI5jaoqhd0CpY40B5WqgA1goyvDy
 pdFUyWgl4VvbB8bhu6suLjehHgq0qr83BBRTh4EIO1L7pAolFASQuDkOSKPL/wQoiOKb
 GI9rskk5l9bz+lgRYWyaeL8DWl4S3GlWCmui1Xi9X/k2U7fhYiwFmRyH9loiRCVKbKm7
 +KEg==
X-Gm-Message-State: AOJu0Yx5utfsD9f7zAYSmZp4cojuDZjpGTmS17YWdz739JQuTwuAat8H
 SSi8VxWIHYG2o3z4iwIA5fSSKm7OqoYLcnU00vl3sr4685MN4y2oceAhIbjU4TVahnZOF2E8CXG
 F
X-Gm-Gg: ASbGncvqCFqGriQ8UxyFUC6FNG0TdCtSEtTuBPeD6b7vmwa8KbYsHWrWGPI5NzqfhcI
 h8LhM+VTf7ys0l/etuAqvuRkkQNn7AXzcx7ZyNrL8Bc5/9m4XShE93YD/Acql2zD5RvDk6mfo/G
 doxsHsonJpVyAK228ZwVJj1o3SgHzgygQtWniNWuV+fzPeZROs+EvpMl22NyLTn3qRbJbpX4QNU
 V/SKc0cdjcUKFuWVEu11ZT/g/U+gkxRza0z4bPtQhxfLIZosiIzMu3gwvebg/rl6T3unvhlkpZI
 LGmjBWrvJgFf/SakusgZEjKL1/IynzSs0AKsGJzNQ3WuFIbPEA==
X-Google-Smtp-Source: AGHT+IE/fwcfB9IdyEFVN8nDtugGuxMamm2B1iPoOBWxOaCN4QR0/eBQWk5mmOETqJWePfhwWnqOBg==
X-Received: by 2002:a17:902:d584:b0:216:2a36:5b2a with SMTP id
 d9443c01a7336-21dd7df1bfcmr14526455ad.47.1738114744524; 
 Tue, 28 Jan 2025 17:39:04 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 08/34] target/arm: Remove standard_fp_status
Date: Tue, 28 Jan 2025 17:38:31 -0800
Message-ID: <20250129013857.135256-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Replace with fp_status[FPST_STD].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  8 ++++----
 target/arm/tcg/mve_helper.c | 28 ++++++++++++++--------------
 target/arm/tcg/vec_helper.c |  4 ++--
 target/arm/vfp_helper.c     |  4 ++--
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 893a2cdd0a..18afff8509 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -696,7 +696,6 @@ typedef struct CPUArchState {
                 float_status fp_status_f16_a64;
                 float_status ah_fp_status;
                 float_status ah_fp_status_f16;
-                float_status standard_fp_status;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b887edf1d1..26e3465a4b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -546,13 +546,13 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
-    set_flush_to_zero(1, &env->vfp.standard_fp_status);
-    set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
-    set_default_nan_mode(1, &env->vfp.standard_fp_status);
+    set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
+    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
-    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 911a53a23a..3763d71e20 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2815,7 +2815,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2889,7 +2889,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2927,7 +2927,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2965,7 +2965,7 @@ DO_VFMA(vfmss, 4, float32, true)
                 continue;                                               \
             }                                                           \
             fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
                 scratch_fpst = *fpst0;                                  \
@@ -3050,7 +3050,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3085,7 +3085,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3118,7 +3118,7 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         TYPE ra = (TYPE)ra_in;                                  \
         float_status *fpst = (ESIZE == 2) ?                     \
             &env->vfp.fp_status[FPST_STD_F16] :                 \
-            &env->vfp.standard_fp_status;                       \
+            &env->vfp.fp_status[FPST_STD];                       \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
                 TYPE v = m[H##ESIZE(e)];                        \
@@ -3169,7 +3169,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3203,7 +3203,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3268,7 +3268,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3302,7 +3302,7 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         float_status scratch_fpst;                                      \
         float_status *base_fpst = (ESIZE == 2) ?                        \
             &env->vfp.fp_status[FPST_STD_F16] :                         \
-            &env->vfp.standard_fp_status;                               \
+            &env->vfp.fp_status[FPST_STD];                               \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
@@ -3347,7 +3347,7 @@ static void do_vcvt_sh(CPUARMState *env, void *vd, void *vm, int top)
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
-    float_status *base_fpst = &env->vfp.standard_fp_status;
+    float_status *base_fpst = &env->vfp.fp_status[FPST_STD];
     bool old_fz = get_flush_to_zero(base_fpst);
     set_flush_to_zero(false, base_fpst);
     for (e = 0; e < 16 / 4; e++, mask >>= 4) {
@@ -3377,7 +3377,7 @@ static void do_vcvt_hs(CPUARMState *env, void *vd, void *vm, int top)
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
-    float_status *base_fpst = &env->vfp.standard_fp_status;
+    float_status *base_fpst = &env->vfp.fp_status[FPST_STD];
     bool old_fiz = get_flush_inputs_to_zero(base_fpst);
     set_flush_inputs_to_zero(false, base_fpst);
     for (e = 0; e < 16 / 4; e++, mask >>= 4) {
@@ -3428,7 +3428,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b369c9f45b..60839ae560 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2177,7 +2177,7 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
@@ -2239,7 +2239,7 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 28c2b40bd8..93db713a40 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -118,7 +118,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     uint32_t a32_flags = 0, a64_flags = 0;
 
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
-    a32_flags |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
           & ~float_flag_input_denormal_flushed);
@@ -157,7 +157,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
-    set_float_exception_flags(0, &env->vfp.standard_fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
     set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
-- 
2.43.0


