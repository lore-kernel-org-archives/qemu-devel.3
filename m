Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29BCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnQ-00016d-4b; Sun, 05 May 2024 21:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmj-0007wi-Tg
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:53 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmL-0002Vs-F0
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:52 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2b4aa87e01aso924112a91.3
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957467; x=1715562267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FD2ij6FW17rbQ5QKEP3ZfUWIk6ASYpj5aPo33ig0zYg=;
 b=S3S2liTCvy2mVx3No9uHkOOzpu7CyGnUdTXEA8eONsGAiJ/zs2uRjr+jbkqE85lctI
 NoD3f79r8VbhXjCabhb7DY0OEtfk9FMuxbet2WUNAJYPm4QlgSF3i6pyKwmlDPs6mpOV
 YC12Gg5C2RgHZF9FkeOYXFR4m9lcTXsE7Lc5naC0qR21Bd8wgO+idJhv8GIzlsIz5lmT
 rmxE/D03agZF/NoVHvU8i31jDFYiZTEsVzsT7K9qnDOUtRdkLbV25LOj/9flThoI5Yw7
 yfeBdJz74LtGvUYD0i4sbMUHTpusxP38nDihZvqVknE+E6o0GhzbunAzTLJbI3zjc/Ul
 //Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957467; x=1715562267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FD2ij6FW17rbQ5QKEP3ZfUWIk6ASYpj5aPo33ig0zYg=;
 b=f0vBAK2WwDYtpeoLi/ZinxHkjg97YOSnrlzCzOdsqglWG+JKroABFDMUM/MvlDNuvM
 2iPeL/kqBe1k97O0PpSOkVQ9+4Yv2v74kdrwNtKTFUtpV0qsHydU22Z4di1MGsbo1V02
 q/iZ3BMuhebOPHKm5m/UHHMqTjlekvrN/7Sg3A5RsnnfZWVQRFuIKPhaFQLy3sof9Duz
 g+zArgbFFqi6mvZ256RDgr9nIaYIkpKth92I5uutLIbVWuL/EbtRY6wbqa0v/DVxXKoL
 LzrcRxh7xQIPk8KJ4UZfRWXJDdB6jVTkYA3cQ4ikz4v1UrC57OV8ybPR5yQlyOWZuJJI
 SOmw==
X-Gm-Message-State: AOJu0YwqZb3U06JTahRR29WsGG7JbdgHMMUwT4lzAV2a6s3F1DZjrHQF
 nVEvMFRjP0k9OtjLvw6yicG2SP7gIWlfzryuE7fa0hSjhjtmoWrzDoFTYPbIJIhokdsvaC6VrUS
 A
X-Google-Smtp-Source: AGHT+IEGMM3IvxnEfNg7G1vo2ClQLu33eFP623pLQGT/ChWlel4tTMWVqZQflQE55BRMBPOmCv+Niw==
X-Received: by 2002:a17:90b:374e:b0:2a8:1fdf:b1b0 with SMTP id
 ne14-20020a17090b374e00b002a81fdfb1b0mr7319085pjb.29.1714957467019; 
 Sun, 05 May 2024 18:04:27 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 26/57] target/arm: Convert SMAXP, SMINP, UMAXP,
 UMINP to decodetree
Date: Sun,  5 May 2024 18:03:32 -0700
Message-Id: <20240506010403.6204-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These are the last instructions within handle_simd_3same_pair
so remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  16 +++++
 target/arm/tcg/translate.h     |   8 +++
 target/arm/tcg/a64.decode      |   4 ++
 target/arm/tcg/gengvec.c       |  48 +++++++++++++
 target/arm/tcg/translate-a64.c | 119 +++++----------------------------
 target/arm/tcg/vec_helper.c    |  16 +++++
 6 files changed, 109 insertions(+), 102 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 51ed49aa50..f830531dd3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1064,6 +1064,22 @@ DEF_HELPER_FLAGS_4(gvec_addp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_addp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_addp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_smaxp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_umaxp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umaxp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umaxp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 04771f483b..3abdbedfe5 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -516,6 +516,14 @@ void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 
 void gen_gvec_addp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_smaxp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_umaxp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ed3603b92f..16e9675335 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -837,6 +837,10 @@ FMINNMP_v       0.10 1110 110 ..... 00000 1 ..... ..... @qrrr_h
 FMINNMP_v       0.10 1110 1.1 ..... 11000 1 ..... ..... @qrrr_sd
 
 ADDP_v          0.00 1110 ..1 ..... 10111 1 ..... ..... @qrrr_e
+SMAXP_v         0.00 1110 ..1 ..... 10100 1 ..... ..... @qrrr_e
+SMINP_v         0.00 1110 ..1 ..... 10101 1 ..... ..... @qrrr_e
+UMAXP_v         0.10 1110 ..1 ..... 10100 1 ..... ..... @qrrr_e
+UMINP_v         0.10 1110 ..1 ..... 10101 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index f010dd5a0e..22c9d17dce 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1622,3 +1622,51 @@ void gen_gvec_addp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     };
     tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
 }
+
+void gen_gvec_smaxp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_smaxp_b,
+        gen_helper_gvec_smaxp_h,
+        gen_helper_gvec_smaxp_s,
+    };
+    tcg_debug_assert(vece <= MO_32);
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
+
+void gen_gvec_sminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_sminp_b,
+        gen_helper_gvec_sminp_h,
+        gen_helper_gvec_sminp_s,
+    };
+    tcg_debug_assert(vece <= MO_32);
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
+
+void gen_gvec_umaxp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_umaxp_b,
+        gen_helper_gvec_umaxp_h,
+        gen_helper_gvec_umaxp_s,
+    };
+    tcg_debug_assert(vece <= MO_32);
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
+
+void gen_gvec_uminp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_uminp_b,
+        gen_helper_gvec_uminp_h,
+        gen_helper_gvec_uminp_s,
+    };
+    tcg_debug_assert(vece <= MO_32);
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2ba211f4a5..be63f46247 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1353,6 +1353,17 @@ static bool do_gvec_fn3(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
     return true;
 }
 
+static bool do_gvec_fn3_no64(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
+{
+    if (a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn3(s, a->q, a->rd, a->rn, a->rm, fn, a->esz);
+    }
+    return true;
+}
+
 static bool do_gvec_fn4(DisasContext *s, arg_qrrrr_e *a, GVecGen4Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -5247,6 +5258,10 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 TRANS(FMINNMP_v, do_fp3_vector, a, f_vector_fminnmp)
 
 TRANS(ADDP_v, do_gvec_fn3, a, gen_gvec_addp)
+TRANS(SMAXP_v, do_gvec_fn3_no64, a, gen_gvec_smaxp)
+TRANS(SMINP_v, do_gvec_fn3_no64, a, gen_gvec_sminp)
+TRANS(UMAXP_v, do_gvec_fn3_no64, a, gen_gvec_umaxp)
+TRANS(UMINP_v, do_gvec_fn3_no64, a, gen_gvec_uminp)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -10890,84 +10905,6 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Pairwise op subgroup of C3.6.16.
- *
- * This is called directly for float pairwise
- * operations where the opcode and size are calculated differently.
- */
-static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
-                                   int size, int rn, int rm, int rd)
-{
-    int pass;
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    /* These operations work on the concatenated rm:rn, with each pair of
-     * adjacent elements being operated on to produce an element in the result.
-     */
-    if (size == 3) {
-        g_assert_not_reached();
-    } else {
-        int maxpass = is_q ? 4 : 2;
-        TCGv_i32 tcg_res[4];
-
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            NeonGenTwoOpFn *genfn = NULL;
-            int passreg = pass < (maxpass / 2) ? rn : rm;
-            int passelt = (is_q && (pass & 1)) ? 2 : 0;
-
-            read_vec_element_i32(s, tcg_op1, passreg, passelt, MO_32);
-            read_vec_element_i32(s, tcg_op2, passreg, passelt + 1, MO_32);
-            tcg_res[pass] = tcg_temp_new_i32();
-
-            switch (opcode) {
-            case 0x14: /* SMAXP, UMAXP */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_pmax_s8, gen_helper_neon_pmax_u8 },
-                    { gen_helper_neon_pmax_s16, gen_helper_neon_pmax_u16 },
-                    { tcg_gen_smax_i32, tcg_gen_umax_i32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
-            case 0x15: /* SMINP, UMINP */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_pmin_s8, gen_helper_neon_pmin_u8 },
-                    { gen_helper_neon_pmin_s16, gen_helper_neon_pmin_u16 },
-                    { tcg_gen_smin_i32, tcg_gen_umin_i32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
-            default:
-            case 0x17: /* ADDP */
-            case 0x58: /* FMAXNMP */
-            case 0x5a: /* FADDP */
-            case 0x5e: /* FMAXP */
-            case 0x78: /* FMINNMP */
-            case 0x7e: /* FMINP */
-                g_assert_not_reached();
-            }
-
-            /* FP ops called directly, otherwise call now */
-            if (genfn) {
-                genfn(tcg_res[pass], tcg_op1, tcg_op2);
-            }
-        }
-
-        for (pass = 0; pass < maxpass; pass++) {
-            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
-        }
-        clear_vec_high(s, is_q, rd);
-    }
-}
-
 /* Floating point op subgroup of C3.6.16. */
 static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 {
@@ -11308,30 +11245,6 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x3: /* logic ops */
         disas_simd_3same_logic(s, insn);
         break;
-    case 0x14: /* SMAXP, UMAXP */
-    case 0x15: /* SMINP, UMINP */
-    {
-        /* Pairwise operations */
-        int is_q = extract32(insn, 30, 1);
-        int u = extract32(insn, 29, 1);
-        int size = extract32(insn, 22, 2);
-        int rm = extract32(insn, 16, 5);
-        int rn = extract32(insn, 5, 5);
-        int rd = extract32(insn, 0, 5);
-        if (opcode == 0x17) {
-            if (u || (size == 3 && !is_q)) {
-                unallocated_encoding(s);
-                return;
-            }
-        } else {
-            if (size == 3) {
-                unallocated_encoding(s);
-                return;
-            }
-        }
-        handle_simd_3same_pair(s, is_q, u, opcode, size, rn, rm, rd);
-        break;
-    }
     case 0x18 ... 0x31:
         /* floating point ops, sz[1] and U are part of opcode */
         disas_simd_3same_float(s, insn);
@@ -11339,6 +11252,8 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     default:
         disas_simd_3same_int(s, insn);
         break;
+    case 0x14: /* SMAXP, UMAXP */
+    case 0x15: /* SMINP, UMINP */
     case 0x17: /* ADDP */
         unallocated_encoding(s);
         break;
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5069899415..56fea14edb 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2259,6 +2259,22 @@ DO_3OP_PAIR(gvec_addp_s, ADD, uint32_t, H4)
 DO_3OP_PAIR(gvec_addp_d, ADD, uint64_t, )
 #undef  ADD
 
+DO_3OP_PAIR(gvec_smaxp_b, MAX, int8_t, H1)
+DO_3OP_PAIR(gvec_smaxp_h, MAX, int16_t, H2)
+DO_3OP_PAIR(gvec_smaxp_s, MAX, int32_t, H4)
+
+DO_3OP_PAIR(gvec_umaxp_b, MAX, uint8_t, H1)
+DO_3OP_PAIR(gvec_umaxp_h, MAX, uint16_t, H2)
+DO_3OP_PAIR(gvec_umaxp_s, MAX, uint32_t, H4)
+
+DO_3OP_PAIR(gvec_sminp_b, MIN, int8_t, H1)
+DO_3OP_PAIR(gvec_sminp_h, MIN, int16_t, H2)
+DO_3OP_PAIR(gvec_sminp_s, MIN, int32_t, H4)
+
+DO_3OP_PAIR(gvec_uminp_b, MIN, uint8_t, H1)
+DO_3OP_PAIR(gvec_uminp_h, MIN, uint16_t, H2)
+DO_3OP_PAIR(gvec_uminp_s, MIN, uint32_t, H4)
+
 #undef DO_3OP_PAIR
 
 #define DO_VCVT_FIXED(NAME, FUNC, TYPE)                                 \
-- 
2.34.1


