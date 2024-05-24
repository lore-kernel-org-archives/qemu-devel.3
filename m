Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29058C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEa-0006mt-ST; Fri, 24 May 2024 19:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEV-0006fz-3M
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEO-0005pa-1K
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f44b59e234so10477545ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592905; x=1717197705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbSO9gWb/VqmpcekSNeGDFpRCpDUVYIPPLbeSgFGxfc=;
 b=rlciHbwpRHrZyJehlStjcd3X2pX4cPiXet0IqKuECRiv7uOBpPYYcZL5mavP/FHlnP
 5Ip4EwingI9gG/73retwOxJVwM9EFx5wH6IOLz3Bs2RlA7I4JykpbGDN+pfdT5hgppAl
 5pPsXmaF6Nsj7nCEds/zbBKoU8isqcPgMRVGPyYkLUyYLpuDd+x5+z8OlqNOAJgwv/d4
 gjIP4R+zeW9X+9KNNyzD/6JULwo00VMwVZ1uqLxPiglRD63ftf2zZR/zx48nJNN/Cvof
 /FN6pLoNmpTRH7sTLhwjybgn7kH6029bonbNZ/Mgd6TZz29sPCdGu18BJnlXF44VWH1R
 vVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592905; x=1717197705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZbSO9gWb/VqmpcekSNeGDFpRCpDUVYIPPLbeSgFGxfc=;
 b=nRbXu0kCTgxHmXvP2kjHNzeEHuCfV0rz9T/mrEvh7qgTqPl4KSD+ZS8eE608zbPIl9
 tkUYjuJouD7lQR32t8Ig+t81bUIXjPS/gl3qkT+pz1zDNBhaieHQnYSxEpAoedzZbeQO
 lwAeqVfuM5OWAoy8QdEgxheQ0+W57YKiFnPtNVSiFC4AuhYHSodBK0rRGyibDCJGBUsx
 VYgRkktQPU6JNi6PYnGFVDilkRjR2gzQveGv2XIv02mu/arHymUi+/wJ9SxFyFHKHId+
 9C127YSwtKVMsoJJLJC8zYtKvWayEqrZ4InZ7MD44qPOzV4nxQC4/sIc7/U+OMkSEBKJ
 0HOA==
X-Gm-Message-State: AOJu0YzHy24R57iVJvkjXYi7rRNZn02k7VR6g/3fK5fWezIECiWAqmse
 y8N0TufiRPMEqvABibuiywM57cRSpUCTXNtbTodxJPT7CxBzc+dZvYCtZmxe4Mc1hSQvCWXh8fs
 s
X-Google-Smtp-Source: AGHT+IGQX4wTayC5eZ1gWmvFsPiWbUHgaemWjfcq7kMmvw/mHFPlcAj1Au9r3LIUYX5DKeNrwlBFRw==
X-Received: by 2002:a17:902:e847:b0:1f3:29c:f9a5 with SMTP id
 d9443c01a7336-1f4486e6080mr45605365ad.13.1716592904923; 
 Fri, 24 May 2024 16:21:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 25/67] target/arm: Convert FCMEQ, FCMGE, FCMGT, FACGE,
 FACGT to decodetree
Date: Fri, 24 May 2024 16:20:39 -0700
Message-Id: <20240524232121.284515-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   5 +
 target/arm/tcg/a64.decode      |  30 ++++++
 target/arm/tcg/translate-a64.c | 188 +++++++++++++++++++--------------
 target/arm/tcg/vec_helper.c    |  30 ++++++
 4 files changed, 174 insertions(+), 79 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e021c18517..8d076011c1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -727,18 +727,23 @@ DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fceq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facge_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facgt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 11527bb5e5..7fc3277be6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -713,6 +713,21 @@ FMINNM_s        0001 1110 ..1 ..... 0111 10 ..... ..... @rrr_hsd
 FMULX_s         0101 1110 010 ..... 00011 1 ..... ..... @rrr_h
 FMULX_s         0101 1110 0.1 ..... 11011 1 ..... ..... @rrr_sd
 
+FCMEQ_s         0101 1110 010 ..... 00100 1 ..... ..... @rrr_h
+FCMEQ_s         0101 1110 0.1 ..... 11100 1 ..... ..... @rrr_sd
+
+FCMGE_s         0111 1110 010 ..... 00100 1 ..... ..... @rrr_h
+FCMGE_s         0111 1110 0.1 ..... 11100 1 ..... ..... @rrr_sd
+
+FCMGT_s         0111 1110 110 ..... 00100 1 ..... ..... @rrr_h
+FCMGT_s         0111 1110 1.1 ..... 11100 1 ..... ..... @rrr_sd
+
+FACGE_s         0111 1110 010 ..... 00101 1 ..... ..... @rrr_h
+FACGE_s         0111 1110 0.1 ..... 11101 1 ..... ..... @rrr_sd
+
+FACGT_s         0111 1110 110 ..... 00101 1 ..... ..... @rrr_h
+FACGT_s         0111 1110 1.1 ..... 11101 1 ..... ..... @rrr_sd
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -748,6 +763,21 @@ FMLA_v          0.00 1110 0.1 ..... 11001 1 ..... ..... @qrrr_sd
 FMLS_v          0.00 1110 110 ..... 00001 1 ..... ..... @qrrr_h
 FMLS_v          0.00 1110 1.1 ..... 11001 1 ..... ..... @qrrr_sd
 
+FCMEQ_v         0.00 1110 010 ..... 00100 1 ..... ..... @qrrr_h
+FCMEQ_v         0.00 1110 0.1 ..... 11100 1 ..... ..... @qrrr_sd
+
+FCMGE_v         0.10 1110 010 ..... 00100 1 ..... ..... @qrrr_h
+FCMGE_v         0.10 1110 0.1 ..... 11100 1 ..... ..... @qrrr_sd
+
+FCMGT_v         0.10 1110 110 ..... 00100 1 ..... ..... @qrrr_h
+FCMGT_v         0.10 1110 1.1 ..... 11100 1 ..... ..... @qrrr_sd
+
+FACGE_v         0.10 1110 010 ..... 00101 1 ..... ..... @qrrr_h
+FACGE_v         0.10 1110 0.1 ..... 11101 1 ..... ..... @qrrr_sd
+
+FACGT_v         0.10 1110 110 ..... 00101 1 ..... ..... @qrrr_h
+FACGT_v         0.10 1110 1.1 ..... 11101 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f84c12378d..75b0c1a005 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4975,6 +4975,41 @@ static const FPScalar f_scalar_fnmul = {
 };
 TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul)
 
+static const FPScalar f_scalar_fcmeq = {
+    gen_helper_advsimd_ceq_f16,
+    gen_helper_neon_ceq_f32,
+    gen_helper_neon_ceq_f64,
+};
+TRANS(FCMEQ_s, do_fp3_scalar, a, &f_scalar_fcmeq)
+
+static const FPScalar f_scalar_fcmge = {
+    gen_helper_advsimd_cge_f16,
+    gen_helper_neon_cge_f32,
+    gen_helper_neon_cge_f64,
+};
+TRANS(FCMGE_s, do_fp3_scalar, a, &f_scalar_fcmge)
+
+static const FPScalar f_scalar_fcmgt = {
+    gen_helper_advsimd_cgt_f16,
+    gen_helper_neon_cgt_f32,
+    gen_helper_neon_cgt_f64,
+};
+TRANS(FCMGT_s, do_fp3_scalar, a, &f_scalar_fcmgt)
+
+static const FPScalar f_scalar_facge = {
+    gen_helper_advsimd_acge_f16,
+    gen_helper_neon_acge_f32,
+    gen_helper_neon_acge_f64,
+};
+TRANS(FACGE_s, do_fp3_scalar, a, &f_scalar_facge)
+
+static const FPScalar f_scalar_facgt = {
+    gen_helper_advsimd_acgt_f16,
+    gen_helper_neon_acgt_f32,
+    gen_helper_neon_acgt_f64,
+};
+TRANS(FACGT_s, do_fp3_scalar, a, &f_scalar_facgt)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5080,6 +5115,41 @@ static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
 };
 TRANS(FMLS_v, do_fp3_vector, a, f_vector_fmls)
 
+static gen_helper_gvec_3_ptr * const f_vector_fcmeq[3] = {
+    gen_helper_gvec_fceq_h,
+    gen_helper_gvec_fceq_s,
+    gen_helper_gvec_fceq_d,
+};
+TRANS(FCMEQ_v, do_fp3_vector, a, f_vector_fcmeq)
+
+static gen_helper_gvec_3_ptr * const f_vector_fcmge[3] = {
+    gen_helper_gvec_fcge_h,
+    gen_helper_gvec_fcge_s,
+    gen_helper_gvec_fcge_d,
+};
+TRANS(FCMGE_v, do_fp3_vector, a, f_vector_fcmge)
+
+static gen_helper_gvec_3_ptr * const f_vector_fcmgt[3] = {
+    gen_helper_gvec_fcgt_h,
+    gen_helper_gvec_fcgt_s,
+    gen_helper_gvec_fcgt_d,
+};
+TRANS(FCMGT_v, do_fp3_vector, a, f_vector_fcmgt)
+
+static gen_helper_gvec_3_ptr * const f_vector_facge[3] = {
+    gen_helper_gvec_facge_h,
+    gen_helper_gvec_facge_s,
+    gen_helper_gvec_facge_d,
+};
+TRANS(FACGE_v, do_fp3_vector, a, f_vector_facge)
+
+static gen_helper_gvec_3_ptr * const f_vector_facgt[3] = {
+    gen_helper_gvec_facgt_h,
+    gen_helper_gvec_facgt_s,
+    gen_helper_gvec_facgt_d,
+};
+TRANS(FACGT_v, do_fp3_vector, a, f_vector_facgt)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9227,43 +9297,33 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             read_vec_element(s, tcg_op2, rm, pass, MO_64);
 
             switch (fpopcode) {
-            case 0x1c: /* FCMEQ */
-                gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1f: /* FRECPS */
                 gen_helper_recpsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5c: /* FCMGE */
-                gen_helper_neon_cge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x5d: /* FACGE */
-                gen_helper_neon_acge_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_vfp_absd(tcg_res, tcg_res);
                 break;
-            case 0x7c: /* FCMGT */
-                gen_helper_neon_cgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x7d: /* FACGT */
-                gen_helper_neon_acgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             default:
             case 0x18: /* FMAXNM */
             case 0x19: /* FMLA */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x1c: /* FCMEQ */
             case 0x1e: /* FMAX */
             case 0x38: /* FMINNM */
             case 0x39: /* FMLS */
             case 0x3a: /* FSUB */
             case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
+            case 0x5c: /* FCMGE */
+            case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7c: /* FCMGT */
+            case 0x7d: /* FACGT */
                 g_assert_not_reached();
             }
 
@@ -9278,43 +9338,33 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
 
             switch (fpopcode) {
-            case 0x1c: /* FCMEQ */
-                gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1f: /* FRECPS */
                 gen_helper_recpsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x5c: /* FCMGE */
-                gen_helper_neon_cge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x5d: /* FACGE */
-                gen_helper_neon_acge_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7a: /* FABD */
                 gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
                 gen_vfp_abss(tcg_res, tcg_res);
                 break;
-            case 0x7c: /* FCMGT */
-                gen_helper_neon_cgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x7d: /* FACGT */
-                gen_helper_neon_acgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             default:
             case 0x18: /* FMAXNM */
             case 0x19: /* FMLA */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
+            case 0x1c: /* FCMEQ */
             case 0x1e: /* FMAX */
             case 0x38: /* FMINNM */
             case 0x39: /* FMLS */
             case 0x3a: /* FSUB */
             case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
+            case 0x5c: /* FCMGE */
+            case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7c: /* FCMGT */
+            case 0x7d: /* FACGT */
                 g_assert_not_reached();
             }
 
@@ -9355,15 +9405,15 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         switch (fpopcode) {
         case 0x1f: /* FRECPS */
         case 0x3f: /* FRSQRTS */
+        case 0x7a: /* FABD */
+            break;
+        default:
+        case 0x1b: /* FMULX */
         case 0x5d: /* FACGE */
         case 0x7d: /* FACGT */
         case 0x1c: /* FCMEQ */
         case 0x5c: /* FCMGE */
         case 0x7c: /* FCMGT */
-        case 0x7a: /* FABD */
-            break;
-        default:
-        case 0x1b: /* FMULX */
             unallocated_encoding(s);
             return;
         }
@@ -9516,17 +9566,17 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     TCGv_i32 tcg_res;
 
     switch (fpopcode) {
-    case 0x04: /* FCMEQ (reg) */
     case 0x07: /* FRECPS */
     case 0x0f: /* FRSQRTS */
-    case 0x14: /* FCMGE (reg) */
-    case 0x15: /* FACGE */
     case 0x1a: /* FABD */
-    case 0x1c: /* FCMGT (reg) */
-    case 0x1d: /* FACGT */
         break;
     default:
     case 0x03: /* FMULX */
+    case 0x04: /* FCMEQ (reg) */
+    case 0x14: /* FCMGE (reg) */
+    case 0x15: /* FACGE */
+    case 0x1c: /* FCMGT (reg) */
+    case 0x1d: /* FACGT */
         unallocated_encoding(s);
         return;
     }
@@ -9546,33 +9596,23 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     tcg_res = tcg_temp_new_i32();
 
     switch (fpopcode) {
-    case 0x04: /* FCMEQ (reg) */
-        gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x07: /* FRECPS */
         gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
     case 0x0f: /* FRSQRTS */
         gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
-    case 0x14: /* FCMGE (reg) */
-        gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x15: /* FACGE */
-        gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x1a: /* FABD */
         gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
         tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
         break;
-    case 0x1c: /* FCMGT (reg) */
-        gen_helper_advsimd_cgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x1d: /* FACGT */
-        gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     default:
     case 0x03: /* FMULX */
+    case 0x04: /* FCMEQ (reg) */
+    case 0x14: /* FCMGE (reg) */
+    case 0x15: /* FACGE */
+    case 0x1c: /* FCMGT (reg) */
+    case 0x1d: /* FACGT */
         g_assert_not_reached();
     }
 
@@ -11232,12 +11272,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
     case 0x1f: /* FRECPS */
     case 0x3f: /* FRSQRTS */
-    case 0x5d: /* FACGE */
-    case 0x7d: /* FACGT */
-    case 0x1c: /* FCMEQ */
-    case 0x5c: /* FCMGE */
     case 0x7a: /* FABD */
-    case 0x7c: /* FCMGT */
         if (!fp_access_check(s)) {
             return;
         }
@@ -11269,13 +11304,18 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x19: /* FMLA */
     case 0x1a: /* FADD */
     case 0x1b: /* FMULX */
+    case 0x1c: /* FCMEQ */
     case 0x1e: /* FMAX */
     case 0x38: /* FMINNM */
     case 0x39: /* FMLS */
     case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
     case 0x5b: /* FMUL */
+    case 0x5c: /* FCMGE */
+    case 0x5d: /* FACGE */
     case 0x5f: /* FDIV */
+    case 0x7d: /* FACGT */
+    case 0x7c: /* FCMGT */
         unallocated_encoding(s);
         return;
     }
@@ -11617,14 +11657,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     int pass;
 
     switch (fpopcode) {
-    case 0x4: /* FCMEQ */
     case 0x7: /* FRECPS */
     case 0xf: /* FRSQRTS */
-    case 0x14: /* FCMGE */
-    case 0x15: /* FACGE */
     case 0x1a: /* FABD */
-    case 0x1c: /* FCMGT */
-    case 0x1d: /* FACGT */
         pairwise = false;
         break;
     case 0x10: /* FMAXNMP */
@@ -11639,13 +11674,18 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x1: /* FMLA */
     case 0x2: /* FADD */
     case 0x3: /* FMULX */
+    case 0x4: /* FCMEQ */
     case 0x6: /* FMAX */
     case 0x8: /* FMINNM */
     case 0x9: /* FMLS */
     case 0xa: /* FSUB */
     case 0xe: /* FMIN */
     case 0x13: /* FMUL */
+    case 0x14: /* FCMGE */
+    case 0x15: /* FACGE */
     case 0x17: /* FDIV */
+    case 0x1c: /* FCMGT */
+    case 0x1d: /* FACGT */
         unallocated_encoding(s);
         return;
     }
@@ -11711,43 +11751,33 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
             switch (fpopcode) {
-            case 0x4: /* FCMEQ */
-                gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x7: /* FRECPS */
                 gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x14: /* FCMGE */
-                gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x15: /* FACGE */
-                gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1a: /* FABD */
                 gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
                 tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
                 break;
-            case 0x1c: /* FCMGT */
-                gen_helper_advsimd_cgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x1d: /* FACGT */
-                gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             default:
             case 0x0: /* FMAXNM */
             case 0x1: /* FMLA */
             case 0x2: /* FADD */
             case 0x3: /* FMULX */
+            case 0x4: /* FCMEQ */
             case 0x6: /* FMAX */
             case 0x8: /* FMINNM */
             case 0x9: /* FMLS */
             case 0xa: /* FSUB */
             case 0xe: /* FMIN */
             case 0x13: /* FMUL */
+            case 0x14: /* FCMGE */
+            case 0x15: /* FACGE */
             case 0x17: /* FDIV */
+            case 0x1c: /* FCMGT */
+            case 0x1d: /* FACGT */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b925b9f21b..dabefa3526 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -971,6 +971,11 @@ static uint32_t float32_ceq(float32 op1, float32 op2, float_status *stat)
     return -float32_eq_quiet(op1, op2, stat);
 }
 
+static uint64_t float64_ceq(float64 op1, float64 op2, float_status *stat)
+{
+    return -float64_eq_quiet(op1, op2, stat);
+}
+
 static uint16_t float16_cge(float16 op1, float16 op2, float_status *stat)
 {
     return -float16_le(op2, op1, stat);
@@ -981,6 +986,11 @@ static uint32_t float32_cge(float32 op1, float32 op2, float_status *stat)
     return -float32_le(op2, op1, stat);
 }
 
+static uint64_t float64_cge(float64 op1, float64 op2, float_status *stat)
+{
+    return -float64_le(op2, op1, stat);
+}
+
 static uint16_t float16_cgt(float16 op1, float16 op2, float_status *stat)
 {
     return -float16_lt(op2, op1, stat);
@@ -991,6 +1001,11 @@ static uint32_t float32_cgt(float32 op1, float32 op2, float_status *stat)
     return -float32_lt(op2, op1, stat);
 }
 
+static uint64_t float64_cgt(float64 op1, float64 op2, float_status *stat)
+{
+    return -float64_lt(op2, op1, stat);
+}
+
 static uint16_t float16_acge(float16 op1, float16 op2, float_status *stat)
 {
     return -float16_le(float16_abs(op2), float16_abs(op1), stat);
@@ -1001,6 +1016,11 @@ static uint32_t float32_acge(float32 op1, float32 op2, float_status *stat)
     return -float32_le(float32_abs(op2), float32_abs(op1), stat);
 }
 
+static uint64_t float64_acge(float64 op1, float64 op2, float_status *stat)
+{
+    return -float64_le(float64_abs(op2), float64_abs(op1), stat);
+}
+
 static uint16_t float16_acgt(float16 op1, float16 op2, float_status *stat)
 {
     return -float16_lt(float16_abs(op2), float16_abs(op1), stat);
@@ -1011,6 +1031,11 @@ static uint32_t float32_acgt(float32 op1, float32 op2, float_status *stat)
     return -float32_lt(float32_abs(op2), float32_abs(op1), stat);
 }
 
+static uint64_t float64_acgt(float64 op1, float64 op2, float_status *stat)
+{
+    return -float64_lt(float64_abs(op2), float64_abs(op1), stat);
+}
+
 static int16_t vfp_tosszh(float16 x, void *fpstp)
 {
     float_status *fpst = fpstp;
@@ -1216,18 +1241,23 @@ DO_3OP(gvec_fabd_s, float32_abd, float32)
 
 DO_3OP(gvec_fceq_h, float16_ceq, float16)
 DO_3OP(gvec_fceq_s, float32_ceq, float32)
+DO_3OP(gvec_fceq_d, float64_ceq, float64)
 
 DO_3OP(gvec_fcge_h, float16_cge, float16)
 DO_3OP(gvec_fcge_s, float32_cge, float32)
+DO_3OP(gvec_fcge_d, float64_cge, float64)
 
 DO_3OP(gvec_fcgt_h, float16_cgt, float16)
 DO_3OP(gvec_fcgt_s, float32_cgt, float32)
+DO_3OP(gvec_fcgt_d, float64_cgt, float64)
 
 DO_3OP(gvec_facge_h, float16_acge, float16)
 DO_3OP(gvec_facge_s, float32_acge, float32)
+DO_3OP(gvec_facge_d, float64_acge, float64)
 
 DO_3OP(gvec_facgt_h, float16_acgt, float16)
 DO_3OP(gvec_facgt_s, float32_acgt, float32)
+DO_3OP(gvec_facgt_d, float64_acgt, float64)
 
 DO_3OP(gvec_fmax_h, float16_max, float16)
 DO_3OP(gvec_fmax_s, float32_max, float32)
-- 
2.34.1


