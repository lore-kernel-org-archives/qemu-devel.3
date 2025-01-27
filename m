Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6124AC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUv-0006Tl-5h; Mon, 27 Jan 2025 18:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUm-0006Ns-99
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:21 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUj-0005b8-VI
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:20 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso8638738a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020376; x=1738625176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weeu4pGBnKKliPk8DdBFAKHVxY9v63/VAYgurHgBoNI=;
 b=DMXsuQVZvLXmEZ5aNq8E1dKbADKgudE0GuWHvmmR6vFZ3JkrCjATHakoDZhi4OTW9D
 b4iH8cuBTc/fD2N2QCJVJWqGXcSt7SZbNwx8wowz2ETCIGxPfXgYSUvmNzF2pZDjOFUp
 s+wcXTSNj6JVa/Cxo4Rp38T6kpyOJjtTaQa1egHfJfE/Cw/n6OcK0HOiO4AQQs3QXC2b
 OKI2fHS7Q2TI72xAZPne9BB5iPeRsHiCyRj04uhcl/CjPLZj1x6bsGDRYw0qStGa+ODo
 ZnsZqa6V1gulbHC5kPUTtaMekCQaZs8ZiBWGDMyq8+1yPI26aj0ZCr4w+O/CKa1K75ow
 Khgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020376; x=1738625176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weeu4pGBnKKliPk8DdBFAKHVxY9v63/VAYgurHgBoNI=;
 b=jjsYMQEQZ1DcvDio7oGywuaX0ib3omE4PG0Shsu2M3efD5wdXsRWcSG33J9trXslwp
 IQFCKrTnKKVqLTlHm1RFZNk3GIgmfeNI0L7A1NISAnOzrCkBXgqioqNPhDMqD9vmYHXg
 s7+3kJJPXI2ZHQnytOf+V4tkIWf6U5CxnZz8u2E4FQH+Um1j6ToeFyCSgSfW2H7ZDCgM
 M782xFbH1XkSkwngCZwZozfp14I7hmEiAc9RKit9x7sjrmoV5QmKiElp19U5IUQEwXTi
 ualGpfUQcqEbLR2/S5raU1LBtQTK1w5keP5SW4U86Yydw/SbMMWtIJVB8P1WwGAnGQ1R
 VqQA==
X-Gm-Message-State: AOJu0Yz7vW+YCnfrMgm5XlnsWb0VGF1cnMWyw5fEYqZO2HOF2Cx3sONj
 JgWNuakvOCxao/UQyYnZhNm8za+ZSV6U/V37bXmJIE/djFx/+sHj0Fwwb/xe6e/QrCpuEbCUVi6
 w
X-Gm-Gg: ASbGncvOg4E0uB1Z3KRYYOBAr6ZeFI7Sxc+kmfFiBet/0q0oYWof09U2GssGT/2OLBi
 Dj+Qk1OEKz4hR5wLDH3isf2BDwPxhAhP7gatpq+fhXzC18N8LoIDIWCjUVP/UvBMPIhph8tEJqB
 CjN30U0mMeZu8fEyWkmF2Kn8XgmnGRmp+GpJR1xvsGyf+wQ90RHHUrm2Iac6MCbaZfd+3bUNJEW
 5ABKZuqPnwTIYGr796y93+s1reg1rWO27L/fQr9DrdO3X7Ik4Z1vdB4YYRY56lG73YvDthKpsgW
 tAJmSJo4aME8+b4jSWHEN2nNDlk4XCsJKj5q0wM=
X-Google-Smtp-Source: AGHT+IEG9PjD/OazgzB5cs1rHHnnx5wMRwXlBhuYrPDslRxc7Th5fZzCJq0VDrN9a88PveLacx/lWQ==
X-Received: by 2002:a17:90b:54cb:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2f782cb4d3fmr69542291a91.16.1738020376638; 
 Mon, 27 Jan 2025 15:26:16 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 13/22] target/arm: Remove fp_status_a64
Date: Mon, 27 Jan 2025 15:25:55 -0800
Message-ID: <20250127232604.20386-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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


