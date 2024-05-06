Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7239C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmg-0007v9-CS; Sun, 05 May 2024 21:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmW-0007pQ-P2
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmF-0002UH-Qi
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:40 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ff57410ebbso1197019a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957461; x=1715562261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGNsBDM4+C3w3H13kQTwPNEqyw2VIfsTsxU5CPZqbuE=;
 b=tNJhSVg8z91qqb1wkd2CiLymS5w4AaHnpr+cyHfzpCedxL6DmjYUwjo2CzSyiy7kBC
 mJbMp2QUZtjeZJNDPvPEw7+gayRoJgEcAUElnXT+q7mm6fqwhg5jc8fZBdnXAdTCNale
 MiQUZv4KCZzkP1DIxZAw1eULeYYQqfHHHv815UUHERfKz4kFhHzpOsSXn4zD/hnvpjTg
 vJrDSZIv9BktLrmTcs0iJX4yT5hy8SSNrf2mZsoQfifaVrv5QGKXuGlJVltXqpM30m7/
 X97CO8Pp60l0Fjxql9LONeCTRXhl83BzsnhvFjTC/IVONU07o0ewpvQus0j/lZqxnIK9
 KXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957461; x=1715562261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGNsBDM4+C3w3H13kQTwPNEqyw2VIfsTsxU5CPZqbuE=;
 b=fqiimD64mJMD1tN38csrJAZO8SrSVudrnRxDNvfjrgbkR1hvZ71edQTUPvs+BGhkY+
 cnKwwT1YwHWYV7Uhsq+6WBr3WHOOkuOoRXPTcyf+lZ0clhmxpz56M6nCY1HA0HQEtVkW
 YDnT8I4SD5xCSsNGtmBrI9t2mRv/6hHCmDJEU+xcPDwRM5c4sz+qsU2MJlFmqvjioOG6
 FBxXBsh4k0a69JL8KK7MJeDGiyhUkETEssVixCQmm3pq48PI42qs+fpKvS9yaoIvYxjh
 cXgdqm8ZinSDe1tIg1NLhzIXgOkMRHbV0JwDTDUZ+ut+WV0TFxmywA54G+ITnReLgOny
 Ihhw==
X-Gm-Message-State: AOJu0YywogIGoP3a2Xfvk5eWn30zWI/zbG2UHl9vsZx32XHrure9O5CI
 ANP+NMC94YEjUlhuuNbC7DqLtgLjZmPCaOxeSNFLbfNepfVb+cLQiFsvTS0eFBLsvSd09d2gY79
 J
X-Google-Smtp-Source: AGHT+IEUaxsAeaDOMr1xEjAb7snD117M3hU5t3M8wJ6NGzbgYQ/OfJMAaETIvJEgwkOe+QwO1d1n5A==
X-Received: by 2002:a05:6a20:2d0c:b0:1ac:efbd:dc46 with SMTP id
 g12-20020a056a202d0c00b001acefbddc46mr9291220pzl.2.1714957461379; 
 Sun, 05 May 2024 18:04:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/57] target/arm: Convert FABD to decodetree
Date: Sun,  5 May 2024 18:03:25 -0700
Message-Id: <20240506010403.6204-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  1 +
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 60 ++++++++++++++++++++++------------
 target/arm/tcg/vec_helper.c    |  6 ++++
 4 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8d076011c1..ff6e3094f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -724,6 +724,7 @@ DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 94d35733df..6aa6643d19 100644
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
index ce3f716798..5f5f62c907 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5011,6 +5011,31 @@ static const FPScalar f_scalar_facgt = {
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
@@ -5151,6 +5176,13 @@ static gen_helper_gvec_3_ptr * const f_vector_facgt[3] = {
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
@@ -9297,10 +9329,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
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
@@ -9316,6 +9344,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x5c: /* FCMGE */
             case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7a: /* FABD */
             case 0x7c: /* FCMGT */
             case 0x7d: /* FACGT */
                 g_assert_not_reached();
@@ -9338,10 +9367,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
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
@@ -9357,6 +9382,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x5c: /* FCMGE */
             case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7a: /* FABD */
             case 0x7c: /* FCMGT */
             case 0x7d: /* FACGT */
                 g_assert_not_reached();
@@ -9399,7 +9425,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         switch (fpopcode) {
         case 0x1f: /* FRECPS */
         case 0x3f: /* FRSQRTS */
-        case 0x7a: /* FABD */
             break;
         default:
         case 0x1b: /* FMULX */
@@ -9407,6 +9432,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         case 0x7d: /* FACGT */
         case 0x1c: /* FCMEQ */
         case 0x5c: /* FCMGE */
+        case 0x7a: /* FABD */
         case 0x7c: /* FCMGT */
             unallocated_encoding(s);
             return;
@@ -9562,13 +9588,13 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
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
@@ -9596,15 +9622,12 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
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
@@ -11266,7 +11289,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
     case 0x1f: /* FRECPS */
     case 0x3f: /* FRSQRTS */
-    case 0x7a: /* FABD */
         if (!fp_access_check(s)) {
             return;
         }
@@ -11308,6 +11330,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x5c: /* FCMGE */
     case 0x5d: /* FACGE */
     case 0x5f: /* FDIV */
+    case 0x7a: /* FABD */
     case 0x7d: /* FACGT */
     case 0x7c: /* FCMGT */
         unallocated_encoding(s);
@@ -11653,7 +11676,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     switch (fpopcode) {
     case 0x7: /* FRECPS */
     case 0xf: /* FRSQRTS */
-    case 0x1a: /* FABD */
         pairwise = false;
         break;
     case 0x10: /* FMAXNMP */
@@ -11678,6 +11700,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
     case 0x17: /* FDIV */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT */
     case 0x1d: /* FACGT */
         unallocated_encoding(s);
@@ -11751,10 +11774,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
@@ -11770,6 +11789,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0x14: /* FCMGE */
             case 0x15: /* FACGE */
             case 0x17: /* FDIV */
+            case 0x1a: /* FABD */
             case 0x1c: /* FCMGT */
             case 0x1d: /* FACGT */
                 g_assert_not_reached();
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index dabefa3526..e9d7922f30 100644
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


