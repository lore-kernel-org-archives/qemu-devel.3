Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE9C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8L-0005QS-4G; Tue, 11 Feb 2025 11:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6L-00075P-Lc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6G-0003gr-MM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so21260725e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291221; x=1739896021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=poKrQuzhS2uugvdc9PAiay1VTfyd7wsrJvpd8x1vuMA=;
 b=PW0U5OCqvidJpUdP81o09nq+m+4R7c+xxX/3qtK8w1glV9Z9jG18RZI463BuNgUz/+
 4zGVagv+/N0rEPlPc3heDG1lRdwLBY8DLehu+A+WpiVq8BaW2oecf12KG/+fUFm68p6E
 1rrVFJCMPqMmORPpQoAseqd9UvdVcEQ4Z7JOEx7AFetwkDmqdK3KPSpxLebEQf/uuIR9
 st+D/uvpYHXJXTipFv+/LUcbaPrlfJhw6EP4jyLdw0vUivZJuXouLqT6zgFEM1HbznCV
 4KQIzm9tX32yDbtPyZJVj3Vo0OKgKgvyfbP8iryuIeE2JxGwkJfOCVa26TV3QyaHT2dD
 m32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291221; x=1739896021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poKrQuzhS2uugvdc9PAiay1VTfyd7wsrJvpd8x1vuMA=;
 b=Mm8CloHYggcDGWd5h2VRoFKdRvGwVaeOsvlyViuc0UPsH/RV5SJC9pn4HnHeeRmQku
 Vu+nZqjJBeh3aTJepzdQMIvCCHoX5FRg2KBLEDHUYsRLnYl9wmWkqCdU7jjNZiy08w+d
 fsO4EwEPqFvpNVYxuTqFsYDOdMO3JJHxjtU17nXuXq/QLGiTXxR6ZjriQzESc1FqvP4d
 xjwSp5ZdEHMUuGoMSU+/Nr6kZJHt97VanUukzX2HIWovec6HCGo9UnAxB7m6QtmD3Xlb
 VGRoMo7LzNlLv0yTWLXD6FmzaECNGp7w/ycnDkQeG2H39esLjQDb8hcPZkBF03Ygf6IX
 w8mw==
X-Gm-Message-State: AOJu0YyPZ7UCXLmxo3ef/vVTs9iGEw0S3EOAPnN4K1TFhqJIqlswpbLU
 T+7B1QNB43S/bjEsjzuX9OyZWCls2ERwGFGg+JHvZYGuJf5DNux29unaV5x4w2AI84bLRRqHoV2
 o
X-Gm-Gg: ASbGncuppYMMJVMfzyNttYpY4Lf3fnhOoTzoXZZF81g4EVuZpEt0yf7vgXkbx2NiVxm
 un/VM7+5DHC9hms0N69Bk7BIjqK95hE9oPDjuh52fVkzFO26gdttDOiBe3nSfd6pX+ol/EGZx+i
 eFHIcJZ1Kxg3jm9+EzWP4E98EzO8AfpSbuBPF/i2rx2LlAAOmjQjc+WvAd90ZIsTGcmQOZ61O8w
 3VfRpjQ5kJSSutHttF2eCe4olE0G036+mcJczvX6bjayYqWfOY0hYC62IIQNve2wxhjqFoOoX3j
 pNcUuS8pDRtG/9XEObFo
X-Google-Smtp-Source: AGHT+IF0apTLK1havq6G3nugqrwhjSKO66aokttkx7mY3Wix+qrkyUeevItszVILxx78QIVi6RL1qQ==
X-Received: by 2002:a05:600c:3147:b0:439:45e2:897f with SMTP id
 5b1f17b1804b1-4394c814388mr57248845e9.11.1739291221547; 
 Tue, 11 Feb 2025 08:27:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.27.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/68] target/arm: Remove fp_status_a64
Date: Tue, 11 Feb 2025 16:25:49 +0000
Message-Id: <20250211162554.4135349-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Replace with fp_status[FPST_A64].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/sme_helper.c |  2 +-
 target/arm/tcg/vec_helper.c | 10 +++++-----
 target/arm/vfp_helper.c     | 16 ++++++++--------
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1593cc1036a..0d8b99bd8af 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -691,7 +691,6 @@ typedef struct CPUArchState {
             float_status fp_status[FPST_COUNT];
             struct {
                 float_status fp_status_a32;
-                float_status fp_status_a64;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 88bff67300c..f04f28b681a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -551,7 +551,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 6e336e10c6a..dcc48e43db3 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1044,7 +1044,7 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
      * round-to-odd -- see above.
      */
     fpst_f16 = env->vfp.fp_status[FPST_A64_F16];
-    fpst_std = env->vfp.fp_status_a64;
+    fpst_std = env->vfp.fp_status[FPST_A64];
     set_default_nan_mode(true, &fpst_std);
     set_default_nan_mode(true, &fpst_f16);
     fpst_odd = fpst_std;
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 78f14503f49..215affc2711 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2172,7 +2172,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
             negx = 0x8000800080008000ull;
         }
     }
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
@@ -2182,7 +2182,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status_a64;
+    float_status *status = &env->vfp.fp_status[FPST_A64];
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
     int negx = 0, negf = 0;
 
@@ -2253,7 +2253,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
             negx = 0x8000800080008000ull;
         }
     }
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, negx, negf, desc,
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
@@ -2264,7 +2264,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status_a64;
+    float_status *status = &env->vfp.fp_status[FPST_A64];
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
     int negx = 0, negf = 0;
 
@@ -2951,7 +2951,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
 
-    *statusp = is_a64(env) ? env->vfp.fp_status_a64 : env->vfp.fp_status_a32;
+    *statusp = is_a64(env) ? env->vfp.fp_status[FPST_A64] : env->vfp.fp_status_a32;
     set_default_nan_mode(true, statusp);
 
     if (ebf) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index dae46a099a3..e6b4f63401b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -125,7 +125,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_STD_F16])
           & ~float_flag_input_denormal_flushed);
 
-    a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
+    a64_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_A64]);
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status[FPST_A64_F16])
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
@@ -156,7 +156,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * be the architecturally up-to-date exception flag information first.
      */
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
-    set_float_exception_flags(0, &env->vfp.fp_status_a64);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
@@ -199,7 +199,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             break;
         }
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
-        set_float_rounding_mode(i, &env->vfp.fp_status_a64);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
     }
@@ -217,7 +217,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
     }
@@ -228,12 +228,12 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
          */
         bool fitz_enabled = (val & FPCR_FIZ) ||
             (val & (FPCR_FZ | FPCR_AH)) == FPCR_FZ;
-        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status_a64);
+        set_flush_inputs_to_zero(fitz_enabled, &env->vfp.fp_status[FPST_A64]);
     }
     if (changed & FPCR_DN) {
         bool dnan_enabled = val & FPCR_DN;
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a32);
-        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_a64);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A32_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_A64_F16]);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH]);
@@ -244,10 +244,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 
         if (ah_enabled) {
             /* Change behaviours for A64 FP operations */
-            arm_set_ah_fp_behaviours(&env->vfp.fp_status_a64);
+            arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
             arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
         } else {
-            arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
+            arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
             arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
         }
     }
-- 
2.34.1


