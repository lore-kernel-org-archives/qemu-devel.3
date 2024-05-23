Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C19C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATp-0008Pg-Kp; Thu, 23 May 2024 11:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATg-00084k-Iz
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATY-0002VG-D9
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-354f51ac110so1521856f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478521; x=1717083321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kUZwbzSy6Dfx4AZrHNzUFlcqY6oMe4ofcuETyK7EYJ8=;
 b=TqKydHaBgGI5eaPXAK5qOPlExXOlueeJGzWAWKqz90TU/UhsEPmwq3uvipSo0xfmIj
 Ey7nrCnoN26G4TRQJcQb1bHHCq+Hm7zx8aWy9TKWGv5yVqznP/RUz/1aMP2lmXHOS4cg
 wQHK3B8xRSPBeC6NeCe3c7DAhw29IEBKhaMQLDDQF5emINNtrB7k0HNjobZ+Ww1dLlkH
 8cEtkxCvjqanJphePjfRCH5shSS4FwHO+JqvH1bo8hunA/SX/iam1SpVgOUu19Hq+Toh
 lL/dpEH5hkFGO8y8rHT/Zd4kdOYbxu+hZOEGwWl9VbRwsHkBLHtsRQ4MoyrSqFp72xxu
 r2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478521; x=1717083321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kUZwbzSy6Dfx4AZrHNzUFlcqY6oMe4ofcuETyK7EYJ8=;
 b=ZCnASJWdv7vVPcaZBh/8P4cVKaJIOPBHMlWiabFV3dUjDNf9RzDSgUFbcBzPGEg4TU
 9p8vEBx8wTz5WByIUAI0GkThaV0Dh/1kgB70ibDNRPYOB1kvXZDD4EUWsVuj7g8C/XML
 /e+XqDGQLxRdwF+wcntWc6bcKcmQU2w7O9F/6udf3O1Q3RAnb5eL6DwIBXzoSA7TmJDP
 LC3q+xp3ScZT1Nlp1sWkO1s2F2APVtsAtWcPXAYR7OYAJhKcDWPwFMeDY6HWzSBfDw4e
 GoOIAOZ8VM4oJSqqCovX5oWMryF0Y9jc1M2/Pezbq2gZiyLbQeGDtSTFQhSpGDGCwE5E
 0nkw==
X-Gm-Message-State: AOJu0YzJntL2TBrAxo4Ku3JbTNH33t0SE9M/F2D1wPqQ/TsF6xB+wy6h
 QzL245UDRg3MGOp+L+VRWPuQWjA9EuSISBEGFiG42NcNWjN3Wiut3DN8tjUTtsRGDjPuvirIBrx
 k
X-Google-Smtp-Source: AGHT+IEAEnF+ay+MC7kQJpVigRbW4MbbCeordwbGBrQauIOCm2JwSylbXyG3xkMqKAyD5I0FihpN8w==
X-Received: by 2002:a5d:4485:0:b0:354:d32c:fbf1 with SMTP id
 ffacd0b85a97d-354d8cb784bmr4466096f8f.17.1716478520769; 
 Thu, 23 May 2024 08:35:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/37] target/arm: Convert FABD to decodetree
Date: Thu, 23 May 2024 16:34:55 +0100
Message-Id: <20240523153505.2900433-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-20-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  1 +
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 60 ++++++++++++++++++++++------------
 target/arm/tcg/vec_helper.c    |  6 ++++
 4 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8d076011c18..ff6e3094f41 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -724,6 +724,7 @@ DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7fc3277be67..a852b5f06f0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -728,6 +728,9 @@ FACGE_s         0111 1110 0.1 ..... 11101 1 ..... ..... @rrr_sd
 FACGT_s         0111 1110 110 ..... 00101 1 ..... ..... @rrr_h
 FACGT_s         0111 1110 1.1 ..... 11101 1 ..... ..... @rrr_sd
 
+FABD_s          0111 1110 110 ..... 00010 1 ..... ..... @rrr_h
+FABD_s          0111 1110 1.1 ..... 11010 1 ..... ..... @rrr_sd
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -778,6 +781,9 @@ FACGE_v         0.10 1110 0.1 ..... 11101 1 ..... ..... @qrrr_sd
 FACGT_v         0.10 1110 110 ..... 00101 1 ..... ..... @qrrr_h
 FACGT_v         0.10 1110 1.1 ..... 11101 1 ..... ..... @qrrr_sd
 
+FABD_v          0.10 1110 110 ..... 00010 1 ..... ..... @qrrr_h
+FABD_v          0.10 1110 1.1 ..... 11010 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4094003759d..9d1ddfbdddc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5010,6 +5010,31 @@ static const FPScalar f_scalar_facgt = {
 };
 TRANS(FACGT_s, do_fp3_scalar, a, &f_scalar_facgt)
 
+static void gen_fabd_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subh(d, n, m, s);
+    gen_vfp_absh(d, d);
+}
+
+static void gen_fabd_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subs(d, n, m, s);
+    gen_vfp_abss(d, d);
+}
+
+static void gen_fabd_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subd(d, n, m, s);
+    gen_vfp_absd(d, d);
+}
+
+static const FPScalar f_scalar_fabd = {
+    gen_fabd_h,
+    gen_fabd_s,
+    gen_fabd_d,
+};
+TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5150,6 +5175,13 @@ static gen_helper_gvec_3_ptr * const f_vector_facgt[3] = {
 };
 TRANS(FACGT_v, do_fp3_vector, a, f_vector_facgt)
 
+static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
+    gen_helper_gvec_fabd_h,
+    gen_helper_gvec_fabd_s,
+    gen_helper_gvec_fabd_d,
+};
+TRANS(FABD_v, do_fp3_vector, a, f_vector_fabd)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9296,10 +9328,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x7a: /* FABD */
-                gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-                gen_vfp_absd(tcg_res, tcg_res);
-                break;
             default:
             case 0x18: /* FMAXNM */
             case 0x19: /* FMLA */
@@ -9315,6 +9343,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x5c: /* FCMGE */
             case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7a: /* FABD */
             case 0x7c: /* FCMGT */
             case 0x7d: /* FACGT */
                 g_assert_not_reached();
@@ -9337,10 +9366,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x7a: /* FABD */
-                gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-                gen_vfp_abss(tcg_res, tcg_res);
-                break;
             default:
             case 0x18: /* FMAXNM */
             case 0x19: /* FMLA */
@@ -9356,6 +9381,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x5c: /* FCMGE */
             case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7a: /* FABD */
             case 0x7c: /* FCMGT */
             case 0x7d: /* FACGT */
                 g_assert_not_reached();
@@ -9398,7 +9424,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         switch (fpopcode) {
         case 0x1f: /* FRECPS */
         case 0x3f: /* FRSQRTS */
-        case 0x7a: /* FABD */
             break;
         default:
         case 0x1b: /* FMULX */
@@ -9406,6 +9431,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         case 0x7d: /* FACGT */
         case 0x1c: /* FCMEQ */
         case 0x5c: /* FCMGE */
+        case 0x7a: /* FABD */
         case 0x7c: /* FCMGT */
             unallocated_encoding(s);
             return;
@@ -9561,13 +9587,13 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     switch (fpopcode) {
     case 0x07: /* FRECPS */
     case 0x0f: /* FRSQRTS */
-    case 0x1a: /* FABD */
         break;
     default:
     case 0x03: /* FMULX */
     case 0x04: /* FCMEQ (reg) */
     case 0x14: /* FCMGE (reg) */
     case 0x15: /* FACGE */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT (reg) */
     case 0x1d: /* FACGT */
         unallocated_encoding(s);
@@ -9595,15 +9621,12 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     case 0x0f: /* FRSQRTS */
         gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
-    case 0x1a: /* FABD */
-        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-        tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
-        break;
     default:
     case 0x03: /* FMULX */
     case 0x04: /* FCMEQ (reg) */
     case 0x14: /* FCMGE (reg) */
     case 0x15: /* FACGE */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT (reg) */
     case 0x1d: /* FACGT */
         g_assert_not_reached();
@@ -11265,7 +11288,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
     case 0x1f: /* FRECPS */
     case 0x3f: /* FRSQRTS */
-    case 0x7a: /* FABD */
         if (!fp_access_check(s)) {
             return;
         }
@@ -11307,6 +11329,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x5c: /* FCMGE */
     case 0x5d: /* FACGE */
     case 0x5f: /* FDIV */
+    case 0x7a: /* FABD */
     case 0x7d: /* FACGT */
     case 0x7c: /* FCMGT */
         unallocated_encoding(s);
@@ -11652,7 +11675,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     switch (fpopcode) {
     case 0x7: /* FRECPS */
     case 0xf: /* FRSQRTS */
-    case 0x1a: /* FABD */
         pairwise = false;
         break;
     case 0x10: /* FMAXNMP */
@@ -11677,6 +11699,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
     case 0x17: /* FDIV */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT */
     case 0x1d: /* FACGT */
         unallocated_encoding(s);
@@ -11750,10 +11773,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1a: /* FABD */
-                gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-                tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
-                break;
             default:
             case 0x0: /* FMAXNM */
             case 0x1: /* FMLA */
@@ -11769,6 +11788,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0x14: /* FCMGE */
             case 0x15: /* FACGE */
             case 0x17: /* FDIV */
+            case 0x1a: /* FABD */
             case 0x1c: /* FCMGT */
             case 0x1d: /* FACGT */
                 g_assert_not_reached();
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index dabefa3526d..e9d7922f303 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1154,6 +1154,11 @@ static float32 float32_abd(float32 op1, float32 op2, float_status *stat)
     return float32_abs(float32_sub(op1, op2, stat));
 }
 
+static float64 float64_abd(float64 op1, float64 op2, float_status *stat)
+{
+    return float64_abs(float64_sub(op1, op2, stat));
+}
+
 /*
  * Reciprocal step. These are the AArch32 version which uses a
  * non-fused multiply-and-subtract.
@@ -1238,6 +1243,7 @@ DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
 
 DO_3OP(gvec_fabd_h, float16_abd, float16)
 DO_3OP(gvec_fabd_s, float32_abd, float32)
+DO_3OP(gvec_fabd_d, float64_abd, float64)
 
 DO_3OP(gvec_fceq_h, float16_ceq, float16)
 DO_3OP(gvec_fceq_s, float32_ceq, float32)
-- 
2.34.1


