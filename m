Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226FCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7C-0001S5-8a; Tue, 11 Feb 2025 11:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6I-00074S-Vz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6E-0003eH-Dg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso12785105e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291220; x=1739896020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3mYsCvENURYZ/OnRanZbkTeZfQ/KyYR0wQPKt6Xcrl0=;
 b=MYhDYL9JgxBlUKBM48TS6vGTIyvCH0UJ8kLoYvYSRqmHinS1MhbFo88JG4Jk4s3udJ
 vEN6oNAvGyMvpLn6xDSjkrVsNnjRJtwp2734xxh2ADczf2FYMAAXA3zXsuOKjKJ07Oq8
 iPLw5ua9gSdDfv10rNXtegGcgS6eqFas7OjtQ4xuIGpfzH4KM0bWEVt6k+Fno3JRtfjz
 XZog9GpfIe7EY/7CK3p4UU03jduR16p+D0Zj/rT4DFEVMhc4qVx+/ecu2vhpyIWo4+D1
 m+zhMg9RYH8MR9zXf/6f8qJ//L/Qx+S54aiqzoa65bNzj0tpGEvuu0vqC5/h11IAak+I
 GINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291220; x=1739896020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mYsCvENURYZ/OnRanZbkTeZfQ/KyYR0wQPKt6Xcrl0=;
 b=tb6DKDHLatyVGPljn3hlbjX/DZ+lXrevNfYR2MKKwABiCpW2YpQS5G9HRNIrWhq9CP
 GIDgwIiM0m0DC5NLzYDvpFf96s+4Cg1yGjeG+eoDOHOZiDbA8e2wyPGsa/42yUqMk844
 PA3hNKcLeluo6lSCGwpyckmpvI+Q4Ddq9Byay2JtveyqS0htaB2WTDparVEGENFNgmK1
 av158ynPyDq3ZlF2FIu+DJfYa+bfT6RfWaI53LdfdxjYEHSRPRX7NFR3buNJWap+qKub
 U3wqyFmLZt4+nE+sg3+UdU58lEib0RMR83Ljgf15eP/Rwhoo7LFGloJjLDClHp1hyoIj
 4Byg==
X-Gm-Message-State: AOJu0YwqXbS4QDmfy7tipWY3j7PZ/BFa//vLhnQ28MZCJzRyX4re+S2L
 tl+Rbg3fpdH9wqfEGfPprHWH09aj7++VSbMdhWH1QMUZKale2+7VSimC8MKCGDGZYYP/VJNZ8ym
 d
X-Gm-Gg: ASbGnctoqZYdPfio51KfUCXKwkU7qGyerv3OYDE6GYvOcwkIlDDYNe3XIxXer29rwPf
 u7kD1mfYGZJPm98IiR6Wp0okzAwlX4mR6/spw106lZ290hLWST1C5du1iuRdCfuRKTEhripTO+j
 xNo4hwjYjBheHjz/NjEB/hD6ImxbstHdP37/Q/6rd0zH9gTn2JKcuwHtLR2BcYKWZNBtKF59Vcd
 qL7yIBbIUlYdLiX4g25m/AXAHOJrh8T1fyGxW66K79xiK6qBF0nnALwvX22CFHIsi0OK0PM8guQ
 tqo0lSdkQk6zfZ1bvLeE
X-Google-Smtp-Source: AGHT+IEjrb4zPZwm0wt+6fsvH8WND1U8v8QRvGxCekX4EiGCIa4f9z75ZP/9OK0GXQG8P783vcSAzg==
X-Received: by 2002:a05:6000:1862:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-38de438e5d1mr2996948f8f.4.1739291219656; 
 Tue, 11 Feb 2025 08:26:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/68] target/arm: Remove fp_status_f16_a64
Date: Tue, 11 Feb 2025 16:25:47 +0000
Message-Id: <20250211162554.4135349-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Replace with fp_status[FPST_A64_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/sme_helper.c |  2 +-
 target/arm/tcg/vec_helper.c |  9 ++++-----
 target/arm/vfp_helper.c     | 16 ++++++++--------
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 577c69dec1a..6cf97ba9c93 100644
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
index 6b4839b5bac..18e7debe295 100644
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
index 727c085f374..6e336e10c6a 100644
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
index cffd0222602..48dbd8bdd23 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2173,7 +2173,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
+             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2183,7 +2183,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2254,7 +2254,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2265,7 +2265,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2275,7 +2275,6 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
             negx = 0x8000;
         }
     }
-
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 2bb98c4ee49..ea6018864d3 100644
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
@@ -158,7 +158,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH]);
@@ -201,16 +201,16 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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
@@ -235,7 +235,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
@@ -245,10 +245,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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
2.34.1


