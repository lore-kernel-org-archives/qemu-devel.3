Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C79C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATj-00087Y-BY; Thu, 23 May 2024 11:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATd-00080I-4T
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATU-0002VA-CV
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-351d309bbcfso1459041f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478520; x=1717083320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DZ0XogwvoEk1CIW3KfzIg6OFTQ+zVDl21J4bUvuGp7U=;
 b=FVWv/Ogqqkr97Yu0Sp6IZEu1XYqlipuRoORM//wfCN04shhbZI2pUuCvpU3zjdAIe/
 8pLpv5uuta2W+rph05tdXpEzUYRJ/hF2CcBw38DUle9rCyO9OynKwLYBndLgMAl3KXsR
 y7pl2Z0I4jvEU3jNj19GMSf3gpMssSnPpiRD9TWi53tNOZ9SE3b++fsTs9nA14JK227t
 u7cNgVUXQnGbm0FXVfo1VDMOtE/vgQZ0Oo+p3F2swwY2lJAS56sBCqH5F6wXArzJa0Jt
 wb6slVDthj/OCIjClgDBIGgndD3vKLX8YTcenbx1oPd24fWR0vj3ft5JYf0+djOxIwHh
 YShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478520; x=1717083320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZ0XogwvoEk1CIW3KfzIg6OFTQ+zVDl21J4bUvuGp7U=;
 b=CpxRQxblmwLUEenmO7a7wkgrITmcdyfFzYLz0JY+JWJFTbj38TsCa/QhyKlcxqO6od
 BBl1mlVv/q/WOrbPe1FjWf+iws3aQwWgCPnqPWeNqu7YGZIyNiTX+RglpwJMVxWSooE0
 d/em7X2Q3F80Mb/8xjThVk6TXwRhUDuqnCx0HuorpXyHnBdyTNJHCSEXoq9ZtTSkiJu+
 WlIhGNDtTrBJEvhFpvvEVbTKsw8/4DjoVrIjKphXyTECGNwW1ajNIe05Y38BniT/AMha
 +LSXGTsWUcxoH+XJ3GQcHxUG9U5uQyKlTnk1WWPbRCRTCCPo5cW3Qw0yYMTLjfhKggJs
 A/tw==
X-Gm-Message-State: AOJu0YyN2KXYEDv2rFEsSAjxdML+ZkX4TWuHbDWFQOJ8v7fcgpsMuVmI
 cXVqnQN87uLhU+mGcsEmAIk939cPFf/18eiIL9YTCvRQ7CL6w/c9hfST5obbcwajghQ2RD/r6YY
 S
X-Google-Smtp-Source: AGHT+IGIkDJfGir38Ztj9lhluqM74iUzs0zbpnycqvIJ8JzIqqzZCbvVChxdDOeMhIzrKV52GSOuhg==
X-Received: by 2002:adf:ab12:0:b0:355:3e8:3b9a with SMTP id
 ffacd0b85a97d-35503e83c89mr317159f8f.64.1716478520310; 
 Thu, 23 May 2024 08:35:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/37] target/arm: Convert FCMEQ, FCMGE, FCMGT, FACGE,
 FACGT to decodetree
Date: Thu, 23 May 2024 16:34:54 +0100
Message-Id: <20240523153505.2900433-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
Message-id: 20240506010403.6204-19-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |   5 +
 target/arm/tcg/a64.decode      |  30 ++++++
 target/arm/tcg/translate-a64.c | 188 +++++++++++++++++++--------------
 target/arm/tcg/vec_helper.c    |  30 ++++++
 4 files changed, 174 insertions(+), 79 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e021c185178..8d076011c18 100644
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
index 11527bb5e5e..7fc3277be67 100644
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
index c8a20f0231d..4094003759d 100644
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
@@ -9220,43 +9290,33 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
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
 
@@ -9271,43 +9331,33 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
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
 
@@ -9348,15 +9398,15 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
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
@@ -9509,17 +9559,17 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
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
@@ -9539,33 +9589,23 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
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
 
@@ -11225,12 +11265,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
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
@@ -11262,13 +11297,18 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
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
@@ -11610,14 +11650,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
@@ -11632,13 +11667,18 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
@@ -11704,43 +11744,33 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
index b925b9f21be..dabefa3526d 100644
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


