Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CBC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zx-0004Vc-DS; Fri, 31 May 2024 08:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zi-0004Oc-3z
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0003Re-5T
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:25 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso25019661fa.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157057; x=1717761857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aQa2AuT1Bi5uxsh3w4IqozLpeLeJYZKbRpaX8un4RDE=;
 b=kdqwNfcQac6g6bBMQzw5/1gpJorXMzupEipCn+3LVYv6dU+CstMkZEqubnj4CYujFF
 lnA1+S4cSlxu4dyOAOr4n9H0f95Olrashx1vwhnGSEqN75QpWvvA0ZsADlMwN88jcx8J
 BawWn6t7JG1x8MfKfvSamJAOnaTJSqQ2kYimZH4vLaD+bG9ISAlwNSdm8S3JqSnhX202
 75FeXhqx5OpDpb/Mt62xqBBJDeHk7FPa0GQQm7JtQQXvS0fYvi4nzmp/F9ch41WAhfq9
 CeZjr1Yr7us2t3NN2UJ0lu7Eite9foaH5dS0Jsf1TzzCbwbegNtdkSjMD2wH0QQKdoWt
 oatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157057; x=1717761857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQa2AuT1Bi5uxsh3w4IqozLpeLeJYZKbRpaX8un4RDE=;
 b=RGi3q73a5sljsN27Cj/Hz5pl5hM5stys2RuyDgb8ibeEduUpfois2XvPML0hhHeEYh
 pYMwnELU061prle/k5iVKxIrLe1KmLvU4nD8vMtVpZbH8qdhQfhqYc2HGOeez5V2GKV3
 NNTA0En/ILC50iidhPUjyRpziDtq+Wiq9U7SdvEXx1LJ9rzd77XyJTIMftMxISfv7mbp
 uzQU4YvOQX4hHDpImy1xnE8kqFc3faGvkmyHWsVBctcq3peSGSPiIs78sia56eK9/KPy
 V0g6pPrDdiVaaHxDclInX26piy0JXXtDW8MQb19qPjp9oblpAAqPgQV1CFtQcoQUezIP
 pTIw==
X-Gm-Message-State: AOJu0YzHKmBaDJ8/kjGZMHp/ZpLQSrFI89fGZoOK82ejVqzLx5Fz3TnO
 2IRmKE/vbbpUjWBGf6X3Z3HXJ/FiKaAvJlL7NeUlN4oK3iIx7BvZJE6Hi5X6P7s+uQPpKgHnfPr
 t
X-Google-Smtp-Source: AGHT+IEK+rBNHNB1EcW1oxGchZ7l6BZkYWeT8Y6UW5INqMUsbaobmQ19vwlsjzUKIoc2WOhay39fig==
X-Received: by 2002:a2e:b80f:0:b0:2ea:7688:4e8d with SMTP id
 38308e7fff4ca-2ea951f6fddmr9961571fa.49.1717157057420; 
 Fri, 31 May 2024 05:04:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/43] target/arm: Convert SQRSHL and UQRSHL (register) to gvec
Date: Fri, 31 May 2024 13:03:37 +0100
Message-Id: <20240531120401.394550-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index f345087ddb4..9a89c9cea74 100644
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
index 6c6d4d49e7b..048cb45ebe9 100644
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
index 6d4996b8d86..788578c8fa1 100644
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
index 63c3ec2e735..6dc96269d5e 100644
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
index 88301f0dcb7..b29a7c725f6 100644
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
index 97bd69eb3f8..b9d577f6206 100644
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
index a3eec470926..5f1576393e2 100644
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


