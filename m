Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A4AC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2v-0000qk-Me; Tue, 28 Jan 2025 20:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2s-0000oF-7p
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:10 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2q-0003Vl-Ba
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:10 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216395e151bso3230935ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114747; x=1738719547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8VYMWiplic3kZJLmX14exYupN5jn8vNAASn/D9iwtU=;
 b=rwVskywwgncaOfMEjA3fCRWqkVMEBVW7oxTXa5xHqTbhCtyIOYSIPggYwxn0RSMhfp
 qMkRMgUQjOU7IaAxUeeIya/YO4RDWoNAYcqx+Nw9ZTKyLYMMc8b3gZVwhtHj4GfFoRXG
 poPd8d29NWc16eSHtbGfRJuhJaym6MGeCgLkx0z9+3EZobwDoyZjhjrmX4BkS6j5g3P/
 QzEGF9t34efCWWEoBR9sCE+yx70cngJYrQlJkcZyBa2Qcj7zr5Rd32jUjOgTNPHsBdPt
 R7AypIdvwmFwEBCExWUBVe0HLkLqvviDnhvj4M3e/tPG5BOl7qOwQkX06mpqUQvU1XmW
 BruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114747; x=1738719547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8VYMWiplic3kZJLmX14exYupN5jn8vNAASn/D9iwtU=;
 b=Fy8boDUBTE9uBZ9rokMJP0x1gvtU/Av+DtncYryzBdupdYDPhjF1etIO25imUYZUUK
 jAzLq1Vdod2788xXeFmiQYI56n4vLdFRwNFdCdOdsqIEJFEY+7nYR8JSMOttKEzy3NCk
 1f/HWJAoq9tEt/sbr0GIm8KHv8okLGtQWowtmFuMcxpEdtlTQ9oXiA4BUcRQpHMpWTZH
 GztLBOg3Qhlho5jfJe1EoEjSHt9pqsHljsYRgfvXgbwYlpFHYsWJSfKAA8zG+X5ZwbAs
 VEecffrwAj7zGUztdqQixCtKpw/KSXiDq4xVz+AE/iTfVd3HHS6jDGkDDrVUA3FVLVJX
 FBOA==
X-Gm-Message-State: AOJu0YxR3awa3sXfmx6vBCOkt4D8bH6GPhI0APta/j+3s3QhEetko1qa
 WxYwwWQJhtLf7IpSt2SY5wtSakDMrI1JkDXyTmHWRb7QMaRc8IgtvLsowwcIDjwrSvNTbrurJIf
 K
X-Gm-Gg: ASbGnctlK5k4yMAuDb7zVgsA3a5H82/sCIjmhfMcFWBWQVHQoirAPYkZblMmC/eeA65
 pPBbhp9nVMk306ZvRq4k16/CxgZgfwrhjP4PzmNmZ5Og+bgdewsHEGFuLzX6FMu/7Eg4DHGwlxy
 xYiCdP798UP1f+c3qj9QeZUWd3RJxwNbhEo4ZqyYbXjxqUNbXpnNTwWTp9lJ2flpKwlVFPj3Z/9
 6N+3T0st/4XwBWeMEk8Hu6uOENlLU8z10tC3grXFgoJ8gFa/u/TKtL8ZRyRkuTJIN7pA7CbD5V0
 FbfL8wW6DuWoP6qCKrkY7cuESSPSEAsuo8iyXQj1hkZFFbpx6A==
X-Google-Smtp-Source: AGHT+IFZ2Lap53EZRTpzDbELfT5dXKRe7yNGTE91YcJFKdF7u6OrWTy5uv+GILt5YZFro+V2kzBM9A==
X-Received: by 2002:a17:903:2445:b0:216:5db1:5dc1 with SMTP id
 d9443c01a7336-21dd7618768mr21918585ad.1.1738114746777; 
 Tue, 28 Jan 2025 17:39:06 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 11/34] target/arm: Remove fp_status_f16_a64
Date: Tue, 28 Jan 2025 17:38:34 -0800
Message-ID: <20250129013857.135256-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Replace with fp_status[FPST_A64_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/sme_helper.c |  2 +-
 target/arm/tcg/vec_helper.c |  8 ++++----
 target/arm/vfp_helper.c     | 16 ++++++++--------
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5e3d952588..9e39c8d0d3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -693,7 +693,6 @@ typedef struct CPUArchState {
                 float_status fp_status_a32;
                 float_status fp_status_a64;
                 float_status fp_status_f16_a32;
-                float_status fp_status_f16_a64;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01a0428c6e..4fc1d00d60 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -554,7 +554,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 727c085f37..6e336e10c6 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1043,7 +1043,7 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
      * produces default NaNs. We also need a second copy of fp_status with
      * round-to-odd -- see above.
      */
-    fpst_f16 = env->vfp.fp_status_f16_a64;
+    fpst_f16 = env->vfp.fp_status[FPST_A64_F16];
     fpst_std = env->vfp.fp_status_a64;
     set_default_nan_mode(true, &fpst_std);
     set_default_nan_mode(true, &fpst_f16);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 60839ae560..927dece4c1 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2185,7 +2185,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
+             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2195,7 +2195,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
         float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negn;
@@ -2247,7 +2247,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2258,7 +2258,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
 
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 78be434caf..bcb05d7ff9 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -126,7 +126,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
           & ~float_flag_input_denormal_flushed);
 
     a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
-    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
+    a64_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A64_F16])
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
      * We do not merge in flags from FPST_AH or FPST_AH_F16, because
@@ -156,7 +156,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
@@ -199,16 +199,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
         set_float_rounding_mode(i, &env->vfp.fp_status_a64);
         set_float_rounding_mode(i, &env->vfp.fp_status_f16_a32);
-        set_float_rounding_mode(i, &env->vfp.fp_status_f16_a64);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
     }
     if (changed & FPCR_FZ16) {
         bool ftz_enabled = val & FPCR_FZ16;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
@@ -233,7 +233,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
@@ -243,10 +243,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         if (ah_enabled) {
             /* Change behaviours for A64 FP operations */
             arm_set_ah_fp_behaviours(&env->vfp.fp_status_a64);
-            arm_set_ah_fp_behaviours(&env->vfp.fp_status_f16_a64);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
         } else {
             arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
-            arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
         }
     }
     /*
-- 
2.43.0


