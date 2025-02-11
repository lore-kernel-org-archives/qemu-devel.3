Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDD4C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8M-0005e7-09; Tue, 11 Feb 2025 11:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6I-00072s-QP
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6C-0003dj-RO
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:04 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso13529695e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291217; x=1739896017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9VYNQPNSDpG57Mk7D4T225CeVSRDAUtc5gMO8lsg+EI=;
 b=KiZuHxfj8wPJNRldWHpYQG4JiJlZwdXrod+nplgzKQMK3IiUinKVG+d8zbX1fW5etD
 efhpyGd6p1gUFiXdTf0lzIbxGQoLZzpDR46ZfDMHrxfTmn6dKmF8NlwQTVBaGRA0qLxd
 oFCecvw4PHGPBrvWHDFDLnA3UxWKSMyQpJfq8/tXm5AYRKqLDYzmTHSHIRqNx0LC/0KU
 Z2rfmFMflGyHjZq68oZK/eO5FoddFqAE43rSQcYMhzuTdYIm9uDeDCm0Z93b9sCkrq2v
 rbu8T1TklI3SVhJsuBIm0znAGTalmWGI0NLGXvy7+m4M3CDifQbe+qqJRMRYk8vlYw1w
 0t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291217; x=1739896017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VYNQPNSDpG57Mk7D4T225CeVSRDAUtc5gMO8lsg+EI=;
 b=CyeLmrsBwTmgRMcb6uOF5Vk8QzZwbvUceZ5IzOBK6a0QcGkJv31MKLKhtCvREs9W/g
 jOOlghPirmRxbt54S+fWW0tweU51MVOqujFo5uTPDwKfZHxxVNqBxd+38IcXop/KDTN8
 GRWOn5jVZl3Rc5vtRSiAKwmkvMk9qrtYru0SQI2HmcLwfDIl6XNNbQtLCaf3HvDoWRpY
 E65BPszAipQ1zNA/3rfO3jz7htJqMUb3Z0iflMNwvWGuAzBv1REUGmgjMBSnigL/v6ZA
 KvRbwEeVb/albVlqV8iexx9KzRAkqjaIwGcWej7sm4pBH1YvdHg8Gbiui8T+HZcT6ymg
 gjRQ==
X-Gm-Message-State: AOJu0Yz+V+YoKROY621ts4obgjuukXzMPCDGKocUxG25a/rVTU5FUG4L
 /44Mpu6gL5wHT3G1CL0wIt/0VqvXQcrOWK3NRstIKl1gjmcZPEJ2n1OEAejskv3yQogXuIilI6M
 d
X-Gm-Gg: ASbGncspoqU4n9GPoaaNrqXmfw6ME8AL3GOfZ+lfdoRZu5vVEtLVT1iYCTVq8paVyen
 MMmJXbwxRBNC4khYBPDLLq9rJaF7m5i0OOn7sarFcf2kEutL37Fp7vftSNOLx2U+4MMt7Zun1D2
 g87dLpsQ6HHqVHXo+T5DIqQUtCuipkn+z0o7SMlTGe/w6w3DQMWCC1TE7LrkUno0Xa8aq5x5u14
 U1W8FdIe5e5s3m8ZDX+u6p0j5AhBxx4cPAn2UH6aY5GkGSKiM/z/1slnwfWqXnZ6Ruf3pEHIFcN
 NxFbyzC8JkHrs3fFMX6s
X-Google-Smtp-Source: AGHT+IEISbiBj7JA2HgBogD7gJqQucB65eQ7tefw1d9xGOtmir+xy37Db5PASqqJEgP1OaaCMygBlQ==
X-Received: by 2002:a05:600c:4446:b0:439:4589:1a9f with SMTP id
 5b1f17b1804b1-43945891d31mr77447175e9.14.1739291217002; 
 Tue, 11 Feb 2025 08:26:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/68] target/arm: Remove standard_fp_status
Date: Tue, 11 Feb 2025 16:25:44 +0000
Message-Id: <20250211162554.4135349-59-peter.maydell@linaro.org>
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

Replace with fp_status[FPST_STD].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  8 ++++----
 target/arm/tcg/mve_helper.c | 28 ++++++++++++++--------------
 target/arm/tcg/vec_helper.c |  4 ++--
 target/arm/vfp_helper.c     |  4 ++--
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 085d5383e05..9f57dfc3e9c 100644
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
index c6d91fd2c8f..75b6b93c7c8 100644
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
index 911a53a23a8..3763d71e20b 100644
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
index ff3f7d8208f..cffd0222602 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2154,7 +2154,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
-    do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, negx, 0, desc,
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
@@ -2235,7 +2235,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
-    do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, negx, 0, desc,
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 61e769d4303..28b9132be5a 100644
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
@@ -159,7 +159,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
-    set_float_exception_flags(0, &env->vfp.standard_fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
     set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
-- 
2.34.1


