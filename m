Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7BAC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3Te-00034I-Lc; Tue, 28 May 2024 16:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TU-0002uW-VQ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TI-0003cx-08
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so1013302b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928259; x=1717533059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZPt4l3XVbDKhFseUMAVsphifUIVII/61XwPrGFOleE=;
 b=J/xU/xWprR9gKC+xV+X1Hztqw3CmeiJuM/KttwEx+S+f5eDOgqZDbv1oYz/SfpshCI
 HCamQGo8JaqsuWl7DRioVPzzI9c/1nHlZYnENSBhjUeH1nWAMq7xzyTCxehHyEcsevMd
 j+g0rJqY8TwYvHtTnE51/ke3p2PowI1VfO/86b1pKUp1G7ozojXd4KQeMzTr8dM9iczi
 Ec7dbdesgexeDcx+b/yI93P5K0xB7JH1bZ53AWue51RFFBWMb3NCw7jOv6thRGXZuU/U
 qcysmq5RS9+TE8TEq+izRcwzDnCJOF0Mn2IFg5uVL0mdWuBKs/706IKhJue24cy3peX3
 sfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928259; x=1717533059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZPt4l3XVbDKhFseUMAVsphifUIVII/61XwPrGFOleE=;
 b=wGWMBitQlCJkZKF7CBJKUhoSt97z+X6NF1XieTuv4sJ4TcDJXHiFsa+N5rapJn9A96
 YrtXgSfbJJR5ta9vfriBEIRTQKNlaBR7LMODxvcObHiMPRgqfjtKDyoz97mA55CWQWQ8
 EAE6yB1NjyBGQ07T96D58JOBEoigvfiOhgJI7PzI1ebPaFf664Ho02ELk/tvqrex6idN
 foXxfMZ/WyKarc+JTVXcJd8T2cuWEhODOFH7Ie+i9i+B1hAbNp4pypepWgK1VukeLedX
 ruxXw3n0w3xaK4G47iIzp+8F51cpcym9nvEy8RREwNPYAIeywMiZmKTghJBO6s0yxWvE
 b+Kg==
X-Gm-Message-State: AOJu0Yw69PRxcPOxRKMbJAbGe40R1g+CWSvIR/n8qzMcXQCN3fCVKMi7
 97QYpKl5JNUM8/eMUbSPYrUOxzdddM/kkKSBJcvYCr82WdlVh9v0Rm58IbQLytu/IPCUc3YJLD4
 t
X-Google-Smtp-Source: AGHT+IF7NYxnXxQOfyuyca/r1Xk+C8ck6Egvz6lF/DFi6lTZsX3q/bMgczbTEgDjfzobAPN/B1gY8Q==
X-Received: by 2002:a05:6a00:4c82:b0:6f3:e6e0:d9f3 with SMTP id
 d2e1a72fcca58-6f8f4193539mr15244731b3a.31.1716928258325; 
 Tue, 28 May 2024 13:30:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 14/33] target/arm: Convert SQRSHL and UQRSHL (register) to
 gvec
Date: Tue, 28 May 2024 13:30:25 -0700
Message-Id: <20240528203044.612851-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  8 ++++++
 target/arm/tcg/translate.h      |  4 +++
 target/arm/tcg/neon-dp.decode   | 17 ++----------
 target/arm/tcg/gengvec.c        | 24 ++++++++++++++++
 target/arm/tcg/neon_helper.c    | 24 ++++++++++++++++
 target/arm/tcg/translate-a64.c  | 17 +++++-------
 target/arm/tcg/translate-neon.c | 49 ++-------------------------------
 7 files changed, 71 insertions(+), 72 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f345087ddb..9a89c9cea7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -334,6 +334,14 @@ DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6c6d4d49e7..048cb45ebe 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -467,6 +467,10 @@ void gen_neon_sqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 void gen_neon_uqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_neon_sqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_neon_uqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
diff --git a/target/arm/tcg/neon-dp.decode b/target/arm/tcg/neon-dp.decode
index 6d4996b8d8..788578c8fa 100644
--- a/target/arm/tcg/neon-dp.decode
+++ b/target/arm/tcg/neon-dp.decode
@@ -102,25 +102,12 @@ VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 
 VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
-
-# Insns operating on 64-bit elements (size!=0b11 handled elsewhere)
-# The _rev suffix indicates that Vn and Vm are reversed (as explained
-# by the comment for the @3same_rev format).
-@3same_64_rev    .... ... . . . 11 .... .... .... . q:1 . . .... \
-                 &3same vm=%vn_dp vn=%vm_dp vd=%vd_dp size=3
-
 VQSHL_S_3s       1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_rev
 VQSHL_U_3s       1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_rev
 VRSHL_S_3s       1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_rev
 VRSHL_U_3s       1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_rev
-{
-  VQRSHL_S64_3s  1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
-  VQRSHL_S_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_rev
-}
-{
-  VQRSHL_U64_3s  1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
-  VQRSHL_U_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_rev
-}
+VQRSHL_S_3s      1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_rev
+VQRSHL_U_3s      1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_rev
 
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 63c3ec2e73..6dc96269d5 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1264,6 +1264,30 @@ void gen_neon_uqshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        opr_sz, max_sz, 0, fns[vece]);
 }
 
+void gen_neon_sqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        gen_helper_neon_sqrshl_b, gen_helper_neon_sqrshl_h,
+        gen_helper_neon_sqrshl_s, gen_helper_neon_sqrshl_d,
+    };
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, tcg_env,
+                       opr_sz, max_sz, 0, fns[vece]);
+}
+
+void gen_neon_uqrshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3_ptr * const fns[] = {
+        gen_helper_neon_uqrshl_b, gen_helper_neon_uqrshl_h,
+        gen_helper_neon_uqrshl_s, gen_helper_neon_uqrshl_d,
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
index 88301f0dcb..b29a7c725f 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -435,11 +435,23 @@ uint64_t HELPER(neon_qshlu_s64)(CPUARMState *env, uint64_t val, uint64_t shift)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 8, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_u8, neon_u8, 4)
+NEON_GVEC_VOP2_ENV(neon_uqrshl_b, uint8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, (int8_t)src2, 16, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_u16, neon_u16, 2)
+NEON_GVEC_VOP2_ENV(neon_uqrshl_h, uint16_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, (int8_t)src2, 32, true, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_uqrshl_s, uint32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_d(src1, (int8_t)src2, true, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_uqrshl_d, uint64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qrshl_u32)(CPUARMState *env, uint32_t val, uint32_t shift)
@@ -455,11 +467,23 @@ uint64_t HELPER(neon_qrshl_u64)(CPUARMState *env, uint64_t val, uint64_t shift)
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 8, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_s8, neon_s8, 4)
+NEON_GVEC_VOP2_ENV(neon_sqrshl_b, int8_t)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) \
     (dest = do_sqrshl_bhs(src1, (int8_t)src2, 16, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_s16, neon_s16, 2)
+NEON_GVEC_VOP2_ENV(neon_sqrshl_h, int16_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, (int8_t)src2, 32, true, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_sqrshl_s, int32_t)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_d(src1, (int8_t)src2, true, env->vfp.qc))
+NEON_GVEC_VOP2_ENV(neon_sqrshl_d, int64_t)
 #undef NEON_FN
 
 uint32_t HELPER(neon_qrshl_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 97bd69eb3f..b9d577f620 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10968,6 +10968,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x0b: /* SQRSHL, UQRSHL */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_uqrshl, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_neon_sqrshl, size);
+        }
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11103,16 +11110,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0xb: /* SQRSHL, UQRSHL */
-            {
-                static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                    { gen_helper_neon_qrshl_s8, gen_helper_neon_qrshl_u8 },
-                    { gen_helper_neon_qrshl_s16, gen_helper_neon_qrshl_u16 },
-                    { gen_helper_neon_qrshl_s32, gen_helper_neon_qrshl_u32 },
-                };
-                genenvfn = fns[size][u];
-                break;
-            }
             default:
                 g_assert_not_reached();
             }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index a3eec47092..5f1576393e 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -798,6 +798,8 @@ DO_3SAME(VRSHL_S, gen_gvec_srshl)
 DO_3SAME(VRSHL_U, gen_gvec_urshl)
 DO_3SAME(VQSHL_S, gen_neon_sqshl)
 DO_3SAME(VQSHL_U, gen_neon_uqshl)
+DO_3SAME(VQRSHL_S, gen_neon_sqrshl)
+DO_3SAME(VQRSHL_U, gen_neon_uqrshl)
 
 /* These insns are all gvec_bitsel but with the inputs in various orders. */
 #define DO_3SAME_BITSEL(INSN, O1, O2, O3)                               \
@@ -916,26 +918,6 @@ DO_SHA2(SHA256H, gen_helper_crypto_sha256h)
 DO_SHA2(SHA256H2, gen_helper_crypto_sha256h2)
 DO_SHA2(SHA256SU1, gen_helper_crypto_sha256su1)
 
-#define DO_3SAME_64(INSN, FUNC)                                         \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        static const GVecGen3 op = { .fni8 = FUNC };                    \
-        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &op);      \
-    }                                                                   \
-    DO_3SAME(INSN, gen_##INSN##_3s)
-
-#define DO_3SAME_64_ENV(INSN, FUNC)                                     \
-    static void gen_##INSN##_elt(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)    \
-    {                                                                   \
-        FUNC(d, tcg_env, n, m);                                         \
-    }                                                                   \
-    DO_3SAME_64(INSN, gen_##INSN##_elt)
-
-DO_3SAME_64_ENV(VQRSHL_S64, gen_helper_neon_qrshl_s64)
-DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
-
 #define DO_3SAME_32(INSN, FUNC)                                         \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
                                 uint32_t rn_ofs, uint32_t rm_ofs,       \
@@ -969,30 +951,6 @@ DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
         FUNC(d, tcg_env, n, m);                                         \
     }
 
-#define DO_3SAME_32_ENV(INSN, FUNC)                                     \
-    WRAP_ENV_FN(gen_##INSN##_tramp8, gen_helper_neon_##FUNC##8);        \
-    WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##16);      \
-    WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##32);      \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        static const GVecGen3 ops[4] = {                                \
-            { .fni4 = gen_##INSN##_tramp8 },                            \
-            { .fni4 = gen_##INSN##_tramp16 },                           \
-            { .fni4 = gen_##INSN##_tramp32 },                           \
-            { 0 },                                                      \
-        };                                                              \
-        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece]); \
-    }                                                                   \
-    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
-    {                                                                   \
-        if (a->size > 2) {                                              \
-            return false;                                               \
-        }                                                               \
-        return do_3same(s, a, gen_##INSN##_3s);                         \
-    }
-
 DO_3SAME_32(VHADD_S, hadd_s)
 DO_3SAME_32(VHADD_U, hadd_u)
 DO_3SAME_32(VHSUB_S, hsub_s)
@@ -1000,9 +958,6 @@ DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
 DO_3SAME_32(VRHADD_U, rhadd_u)
 
-DO_3SAME_32_ENV(VQRSHL_S, qrshl_s)
-DO_3SAME_32_ENV(VQRSHL_U, qrshl_u)
-
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
     WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
     WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##_s32);    \
-- 
2.34.1


