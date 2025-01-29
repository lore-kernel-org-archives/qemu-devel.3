Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48917C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2w-0000rX-Jy; Tue, 28 Jan 2025 20:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2t-0000oU-BR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2r-0003WE-FC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21675fd60feso141230685ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114748; x=1738719548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weeu4pGBnKKliPk8DdBFAKHVxY9v63/VAYgurHgBoNI=;
 b=udhN2Y80TF+DHzMjLC+dwc0uNKtlUFWbtNsI5ito0cbEL5k/rN1WXmUhP5lQhluSs+
 BqivAIlLJCCX6htRrYS/jqvIjIMBGzfoMhoZdINBlnBwleYsvye/lYOwGQUeZPppuIQo
 WdY4LsTzAmmbKlam/MkbBa8wVtwiG6PC178G5pvVM6llOx7FFSQBGNi2gIQF+WPB1bab
 U48d5KGzOupG3XoYiWoDOpExycOC+guLQfFx2Zaoh/JNWw7qT05GWcQYWCzpyoggbGgo
 vkkT2yM0pqSUW+iORnQ5/BfpnShk2kgNL43J6W/h29psKMf+IyOhabKxDmoQsXKtznRd
 04UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114748; x=1738719548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weeu4pGBnKKliPk8DdBFAKHVxY9v63/VAYgurHgBoNI=;
 b=mi6XWl+3E1+n0IqSlouVIrJCRXlxxSIO4aO9Qj3A0eMmH7sPXItAOj64HeSaW+JpzN
 4BeOGcD5OuRFsOJ66u8Pvb2sk7wCJZNqFn32ly/EqJyhjbfBpRBsxgsucqdYYWMRSqM1
 T/T97oRlgnUg4vrbJUP5P6RWf1r9CSYbcyP6WZ2aKDx8w5Arpb6BwFqnAQVHB4XhNfRD
 pS+IOy1aV0OZm4xPhuVNbBN+dQXA+Pm6WuiBCNT7X5bsoawaQ45mss53Prbn7jYU2VyV
 B8oSia6qfuVMaR1ZLtQrcJg2GdqZhh9mcHiV5Ra/wE2mq82TyCzxga1nRykWPv9xqaRo
 fKCQ==
X-Gm-Message-State: AOJu0Yz+FeMw8d1ypdU74rbl384lNmsblUyYHodg9M9iAbUt53gj3A/U
 RBDG8T4lYMh5gvgLqBnIbsanWkfXE0WAkoSKJlWmPc5lFPOGQnlt+xOA+xX1auSrHrr9r/UntVA
 d
X-Gm-Gg: ASbGnctlA3S/YKJ9QPW8pP5x3uzteavLf9FI995CFWeC586kYmCsLBmkdkV0zkoSOAj
 UER3tePFhQJVur/6MBWwAl5h8WwuHxnj0MmvJlQZJQMlu3i8wX7F5RVGqy4qV7Rpik5+FPGkG2F
 +EVaCULii/C9Ti4mcEXkV2hcXKWIHDgz3wUN1H2xiTgioJiv3DXAvEC5JO+6vmjhUvhZY/JPxR9
 CsfK+Gd3YFAcasU2xz/ZlqqUb/zezSl+xGby/8xy2w8/O1VuWwJIsuYoXO/8DYKJ8CzoeCOAsKG
 0TaxdUbnwYemJheG65rY87Ykyz94QT3qodBKojL8OtXfpOA/4w==
X-Google-Smtp-Source: AGHT+IF+yT0XeLQFy0N9WsuCP8h0tSRVY+TgKolMNBSrsaUVGkTPvAbc6Ld2wUuLsTobUz9IV7Gvxg==
X-Received: by 2002:a17:903:11c3:b0:215:5625:885b with SMTP id
 d9443c01a7336-21dd7e3be5bmr18701195ad.52.1738114748034; 
 Tue, 28 Jan 2025 17:39:08 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 13/34] target/arm: Remove fp_status_a64
Date: Tue, 28 Jan 2025 17:38:36 -0800
Message-ID: <20250129013857.135256-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Replace with fp_status[FPST_A64].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/sme_helper.c |  2 +-
 target/arm/tcg/vec_helper.c | 10 +++++-----
 target/arm/vfp_helper.c     | 16 ++++++++--------
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06dbee5725..05a58de045 100644
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
index ceb2dcb3fb..777e5f5dd8 100644
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
index 6e336e10c6..dcc48e43db 100644
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
index 61f268efad..9ed04b1b0a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2184,7 +2184,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.fp_status_a64, desc,
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
@@ -2194,7 +2194,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status_a64;
+    float_status *status = &env->vfp.fp_status[FPST_A64];
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
@@ -2246,7 +2246,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status_a64, desc,
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
 }
 
@@ -2257,7 +2257,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status_a64;
+    float_status *status = &env->vfp.fp_status[FPST_A64];
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
 
     for (i = 0; i < oprsz; i += 16) {
@@ -2936,7 +2936,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
 
-    *statusp = env->vfp.fp_status_a64;
+    *statusp = env->vfp.fp_status[FPST_A64];
     set_default_nan_mode(true, statusp);
 
     if (ebf) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 6a6eb48530..e0d0623097 100644
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
@@ -154,7 +154,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
      * be the architecturally up-to-date exception flag information first.
      */
     set_float_exception_flags(0, &env->vfp.fp_status_a32);
-    set_float_exception_flags(0, &env->vfp.fp_status_a64);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A32_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_A64_F16]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
@@ -197,7 +197,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
             break;
         }
         set_float_rounding_mode(i, &env->vfp.fp_status_a32);
-        set_float_rounding_mode(i, &env->vfp.fp_status_a64);
+        set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A32_F16]);
         set_float_rounding_mode(i, &env->vfp.fp_status[FPST_A64_F16]);
     }
@@ -215,7 +215,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
-        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_a64);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_A64]);
         /* FIZ is A64 only so FZ always makes A32 code flush inputs to zero */
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_a32);
     }
@@ -226,12 +226,12 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
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
@@ -242,10 +242,10 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
 
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
2.43.0


