Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E38AC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zr-0004SQ-Ud; Fri, 31 May 2024 08:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zg-0004Mr-3k
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zZ-0003RA-M8
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421140314d5so18991135e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157056; x=1717761856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UKTkfJYDyC5bj3EZEi5uBLG4feLcboqQxClNLVSg1Es=;
 b=y8quDRGnPJ7hbrTSKHtbVgPsXD6ZQIia5MQvFNMrAWiSyUuZmVKx8xxWxjbxESiuML
 FTBHOW+Kil+axU8ce+FtTMLB8kmj5XfbWz7P1DJG6KQ4dUPu8UPwyPg7NBHc9pu6qUM1
 sZD7ZD1UUcs7nrBzimVPjn/QLCJB9CJRLJnZ2o+DGYC9H8Exxrm/mesQNmI7um497/4r
 daYbDq1VUV4i21WLDktlY+bl/8KL6NZIUypQE2tLhruaw4HncSuOCMdpaxsXrZY3dg52
 zQ6rP18qc66X19trOR0bv4hCPa/en6bdwWEUzgrkK8ATtCQ0UpFWWFbTfQQ5FgHYVkjj
 dZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157056; x=1717761856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKTkfJYDyC5bj3EZEi5uBLG4feLcboqQxClNLVSg1Es=;
 b=N8x+TGnFH5WLIUv0A1lcSH7pPL/+gDcDNiXA9P2j+YXXRjYovmDDI6/apsxR3G27lT
 2uDYcoMjTnIsLoGL1KDk2j/KsWMa04xtzJA6A0lT+y44ynKUr/Wsyq+VQ8XkqTsvHMIQ
 WdLmhDzoY3hFH7YGhlklxjGDq2K1XOtR/P8HZNRvojrQ03zb3foisFsnDt0INhZTPzCD
 leEKnEZF3lb8ru1/aEZaXFLybyIqnpZ+0MIIAF66FIvTuF1c3qmVAmmOlp68+U97y69Z
 LGOpvroGQWSC6rwL2t/fsbtziSH+V4J2D9p0V9WJBNBI7uZ0mD955a+Lx9Kiu3ZRtBbY
 KB9Q==
X-Gm-Message-State: AOJu0YyCX1c+qAgo4qPeu7xcWP9ICR1oYUhgxWm4n8J4qG1v77hO9jp+
 qhCARw9WeePTUYKRb1Xzl+JSmH7cgX6tYEKzcE9u3ocyJMvUoqbICk62A0lrJOF/5T5rCBXS79X
 h
X-Google-Smtp-Source: AGHT+IEoQFO86jPYCjUT9J2rzTEpHrFXFKjrV1YuyWTnAgBgAOFeaLgsMN4S44AEkBlb5Zn4RBIkDQ==
X-Received: by 2002:a05:600c:4515:b0:420:139e:9eda with SMTP id
 5b1f17b1804b1-4212e050715mr14456675e9.12.1717157056233; 
 Fri, 31 May 2024 05:04:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/43] target/arm: Convert SQSHL and UQSHL (register) to gvec
Date: Fri, 31 May 2024 13:03:35 +0100
Message-Id: <20240531120401.394550-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240528203044.612851-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  8 ++++++++
 target/arm/tcg/translate.h      |  4 ++++
 target/arm/tcg/neon-dp.decode   | 10 ++-------
 target/arm/tcg/gengvec.c        | 24 ++++++++++++++++++++++
 target/arm/tcg/neon_helper.c    | 36 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 17 +++++++---------
 target/arm/tcg/translate-neon.c |  6 ++----
 7 files changed, 83 insertions(+), 22 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 25eb7bf5dfd..f345087ddb4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -326,6 +326,14 @@ DEF_HELPER_3(neon_qrshl_u32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
 DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
+DEF_HELPER_FLAGS_5(neon_sqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index ea63ffc47b3..6c6d4d49e7b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -463,6 +463,10 @@ void gen_gvec_srshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_urshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_neon_sqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_neon_uqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/neon-dp.decode b/target/arm/tcg/neon-dp.decode
index 8525c65c0d2..6d4996b8d86 100644
--- a/target/arm/tcg/neon-dp.decode
+++ b/target/arm/tcg/neon-dp.decode
@@ -109,14 +109,8 @@ VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 @3same_64_rev    .... ... . . . 11 .... .... .... . q:1 . . .... \
                  &3same vm=%vn_dp vn=%vm_dp vd=%vd_dp size=3
 
-{
-  VQSHL_S64_3s   1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
-  VQSHL_S_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_rev
-}
-{
-  VQSHL_U64_3s   1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
-  VQSHL_U_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_rev
-}
+VQSHL_S_3s       1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_rev
+VQSHL_U_3s       1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_rev
 VRSHL_S_3s       1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_rev
 VRSHL_U_3s       1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_rev
 {
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 216a9f81e3b..63c3ec2e735 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1240,6 +1240,30 @@ void gen_gvec_urshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
 }
 
+void gen_neon_sqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        gen_helper_neon_sqshl_b, gen_helper_neon_sqshl_h,
+        gen_helper_neon_sqshl_s, gen_helper_neon_sqshl_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, tcg_env,
+                       opr_sz, max_sz, 0, fns[vece]);
+}
+
+void gen_neon_uqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        gen_helper_neon_uqshl_b, gen_helper_neon_uqshl_h,
+        gen_helper_neon_uqshl_s, gen_helper_neon_uqshl_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, tcg_env,
+                       opr_sz, max_sz, 0, fns[vece]);
+}
+
 void gen_uqadd_bhs(TCGv_i64 res, TCGv_i64 qc, TCGv_i64 a, TCGv_i64 b, MemOp esz)
 {
     uint64_t max = MAKE_64BIT_MASK(0, 8 << esz);
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 516ecc1dcbe..88301f0dcb7 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -129,6 +129,18 @@ void HELPER(name)(void *vd, void *vn, void *vm, uint32_t desc) \
     clear_tail(d, opr_sz, simd_maxsz(desc));                    \
 }
 
+#define NEON_GVEC_VOP2_ENV(name, vtype) \
+void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    vtype *d = vd, *n = vn, *m = vm;                            \
+    CPUARMState *env = venv;                                    \
+    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
+        NEON_FN(d[i], n[i], m[i]);                              \
+    }                                                           \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
+}
+
 /* Pairwise operations.  */
 /* For 32-bit elements each segment only contains a single element, so
    the elementwise and pairwise operations are the same.  */
@@ -339,11 +351,23 @@ uint64_t HELPER(neon_rshl_u64)(uint64_t val, uint64_t shift)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_u8, neon_u8, 4)
+NEON_GVEC_VOP2_ENV(neon_uqshl_b, uint8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_u16, neon_u16, 2)
+NEON_GVEC_VOP2_ENV(neon_uqshl_h, uint16_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, (int8_t)src2, 32, false, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_uqshl_s, uint32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_d(src1, (int8_t)src2, false, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_uqshl_d, uint64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qshl_u32)(CPUARMState *env, uint32_t val, uint32_t shift)
@@ -359,11 +383,23 @@ uint64_t HELPER(neon_qshl_u64)(CPUARMState *env, uint64_t val, uint64_t shift)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_s8, neon_s8, 4)
+NEON_GVEC_VOP2_ENV(neon_sqshl_b, int8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_s16, neon_s16, 2)
+NEON_GVEC_VOP2_ENV(neon_sqshl_h, int16_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, (int8_t)src2, 32, false, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_sqshl_s, int32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_d(src1, (int8_t)src2, false, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_sqshl_d, int64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qshl_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c751da78ef0..c88702dad66 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10937,6 +10937,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x09: /* SQSHL, UQSHL */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_uqshl, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_sqshl, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11072,16 +11079,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x9: /* SQSHL, UQSHL */
-            {
-                static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                    { gen_helper_neon_qshl_s8, gen_helper_neon_qshl_u8 },
-                    { gen_helper_neon_qshl_s16, gen_helper_neon_qshl_u16 },
-                    { gen_helper_neon_qshl_s32, gen_helper_neon_qshl_u32 },
-                };
-                genenvfn = fns[size][u];
-                break;
-            }
             case 0xb: /* SQRSHL, UQRSHL */
             {
                 static NeonGenTwoOpEnvFn * const fns[3][2] = {
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 337488bbf16..a3eec470926 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -796,6 +796,8 @@ DO_3SAME(VQSUB_S, gen_gvec_sqsub_qc)
 DO_3SAME(VQSUB_U, gen_gvec_uqsub_qc)
 DO_3SAME(VRSHL_S, gen_gvec_srshl)
 DO_3SAME(VRSHL_U, gen_gvec_urshl)
+DO_3SAME(VQSHL_S, gen_neon_sqshl)
+DO_3SAME(VQSHL_U, gen_neon_uqshl)
 
 /* These insns are all gvec_bitsel but with the inputs in various orders. */
 #define DO_3SAME_BITSEL(INSN, O1, O2, O3)                               \
@@ -931,8 +933,6 @@ DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
     }                                                                   \
     DO_3SAME_64(INSN, gen_##INSN##_elt)
 
-DO_3SAME_64_ENV(VQSHL_S64, gen_helper_neon_qshl_s64)
-DO_3SAME_64_ENV(VQSHL_U64, gen_helper_neon_qshl_u64)
 DO_3SAME_64_ENV(VQRSHL_S64, gen_helper_neon_qrshl_s64)
 DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
 
@@ -1000,8 +1000,6 @@ DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
 DO_3SAME_32(VRHADD_U, rhadd_u)
 
-DO_3SAME_32_ENV(VQSHL_S, qshl_s)
-DO_3SAME_32_ENV(VQSHL_U, qshl_u)
 DO_3SAME_32_ENV(VQRSHL_S, qrshl_s)
 DO_3SAME_32_ENV(VQRSHL_U, qrshl_u)
 
-- 
2.34.1


