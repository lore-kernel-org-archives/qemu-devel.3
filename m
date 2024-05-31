Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE8AC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10J-0004j3-2y; Fri, 31 May 2024 08:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zs-0004SW-42
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zl-0003Vg-TO
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421338c4c3bso645055e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157068; x=1717761868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aP7ySJ96PqUQh3TmU5xPDEvvI7Y9spkxYd7QLSUWJHo=;
 b=nkDUqeuc+4hNFvnua9lpXaC2LxDh9EcO3cC3/Q4mJqsbef1ub+XJ1RZ5o0ZQ4aIHUe
 LXXMvH7PbSQiDnOB+ZiEAOx9I7X4HxIvuUY+bWMd2VINlNb1Y0hQkoHxEHKFYV6zkGva
 sMxRbl17Sh4vjmpS3g/DVm94XWfhsIXzbUNpzdWB6yjmTZ+mCC67JBNbskNI9nGNcGhA
 POV2e+6tdnHb6Av3X+fgjwrHuiHcOCl4IfwsuwACESzugkF5HCoZoFtJfAsfntHxwKZg
 HkNttgidZa3Rja7Wwoilg0Kx+9uFGyP71VXsB4Kl2t731Bf+rTZCXLYucbYhNUQau3zC
 JRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157068; x=1717761868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aP7ySJ96PqUQh3TmU5xPDEvvI7Y9spkxYd7QLSUWJHo=;
 b=FHj9w5AOZ6fthZa/dLtT9uMPeGemlQz5RaM364Xdm1Nc0eLEthKOKwyDkPWcVXqFK8
 Z+zEi7L4Z4boktMi5qoSiIX4K8pbchiDPNnAI6pd260bdPtt+4TsZERG89dm4TVfS0Er
 jYrS6dqxybXswQJ5o2r99KH1rhTHzjTXjBR+vwe7wmQRk4Xd4emjQ0VzANddNyJWDQ12
 qPPLN9CL6EFEcmnkvaJhqO3xW1O8boPur/p+6Wc1EMpkhm2ULEKMcdhzrROd1qZzbpCI
 wqzlMSyJgyRW8OPwytCfnyfPip58cd6L8EbctWd9Xi2DZqwL0XAPnOJR6d+e6f6YHOt2
 jYGA==
X-Gm-Message-State: AOJu0YwekBPkvUgv3KN5zFrVajRFAGZd+jVgD3ezWyrFHSah55E5a+bQ
 pah8aHWq27h2xs9S8Hg9ObXqdIiWGyO5xSRn1eB9uVVYQYONb5QeAuNy0OvpTmu6c59i0DkNGwQ
 8
X-Google-Smtp-Source: AGHT+IG+/7RfL4+wldyiMeWie7W+rXzoTLGFyeT90j3yhhSr+jWL3mMe9HWLu4BT3/hVR4fc/ngI5A==
X-Received: by 2002:a05:600c:3b90:b0:420:1551:96a9 with SMTP id
 5b1f17b1804b1-4212e0b08b2mr15371345e9.39.1717157068360; 
 Fri, 31 May 2024 05:04:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/43] target/arm: Convert SQDMULH, SQRDMULH to decodetree
Date: Fri, 31 May 2024 13:03:54 +0100
Message-Id: <20240531120401.394550-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

These are the last instructions within disas_simd_three_reg_same
and disas_simd_scalar_three_reg_same, so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240528203044.612851-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  10 ++
 target/arm/tcg/a64.decode      |  18 +++
 target/arm/tcg/translate-a64.c | 276 ++++++++++-----------------------
 target/arm/tcg/vec_helper.c    |  64 ++++++++
 4 files changed, 172 insertions(+), 196 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 85f93025636..24feecee9b4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -968,6 +968,16 @@ DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(neon_sqdmulh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqdmulh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2dea68a0a9d..f7f897f9fcc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -774,6 +774,9 @@ CMHS_s          0111 1110 111 ..... 00111 1 ..... ..... @rrr_d
 CMTST_s         0101 1110 111 ..... 10001 1 ..... ..... @rrr_d
 CMEQ_s          0111 1110 111 ..... 10001 1 ..... ..... @rrr_d
 
+SQDMULH_s       0101 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
+SQRDMULH_s      0111 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -931,6 +934,9 @@ PMUL_v          0.10 1110 001 ..... 10011 1 ..... ..... @qrrr_b
 MLA_v           0.00 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 MLS_v           0.10 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 
+SQDMULH_v       0.00 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
+SQRDMULH_v      0.10 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -949,6 +955,12 @@ FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
 
+SQDMULH_si      0101 1111 01 .. .... 1100 . 0 ..... .....   @rrx_h
+SQDMULH_si      0101 1111 10 .. .... 1100 . 0 ..... .....   @rrx_s
+
+SQRDMULH_si     0101 1111 01 .. .... 1101 . 0 ..... .....   @rrx_h
+SQRDMULH_si     0101 1111 10 . ..... 1101 . 0 ..... .....   @rrx_s
+
 ### Advanced SIMD vector x indexed element
 
 FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
@@ -980,3 +992,9 @@ MLA_vi          0.10 1111 10 . ..... 0000 . 0 ..... .....   @qrrx_s
 
 MLS_vi          0.10 1111 01 .. .... 0100 . 0 ..... .....   @qrrx_h
 MLS_vi          0.10 1111 10 . ..... 0100 . 0 ..... .....   @qrrx_s
+
+SQDMULH_vi      0.00 1111 01 .. .... 1100 . 0 ..... .....   @qrrx_h
+SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
+
+SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
+SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c673b95ec7a..14226c56cfd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1350,6 +1350,14 @@ static bool do_gvec_fn3_no64(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
     return true;
 }
 
+static bool do_gvec_fn3_no8_no64(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
+{
+    if (a->esz == MO_8) {
+        return false;
+    }
+    return do_gvec_fn3_no64(s, a, fn);
+}
+
 static bool do_gvec_fn4(DisasContext *s, arg_qrrrr_e *a, GVecGen4Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -5167,6 +5175,25 @@ static const ENVScalar2 f_scalar_uqrshl = {
 };
 TRANS(UQRSHL_s, do_env_scalar2, a, &f_scalar_uqrshl)
 
+static bool do_env_scalar2_hs(DisasContext *s, arg_rrr_e *a,
+                              const ENVScalar2 *f)
+{
+    if (a->esz == MO_16 || a->esz == MO_32) {
+        return do_env_scalar2(s, a, f);
+    }
+    return false;
+}
+
+static const ENVScalar2 f_scalar_sqdmulh = {
+    { NULL, gen_helper_neon_qdmulh_s16, gen_helper_neon_qdmulh_s32 }
+};
+TRANS(SQDMULH_s, do_env_scalar2_hs, a, &f_scalar_sqdmulh)
+
+static const ENVScalar2 f_scalar_sqrdmulh = {
+    { NULL, gen_helper_neon_qrdmulh_s16, gen_helper_neon_qrdmulh_s32 }
+};
+TRANS(SQRDMULH_s, do_env_scalar2_hs, a, &f_scalar_sqrdmulh)
+
 static bool do_cmop_d(DisasContext *s, arg_rrr_e *a, TCGCond cond)
 {
     if (fp_access_check(s)) {
@@ -5482,6 +5509,9 @@ TRANS(CMHS_v, do_cmop_v, a, TCG_COND_GEU)
 TRANS(CMEQ_v, do_cmop_v, a, TCG_COND_EQ)
 TRANS(CMTST_v, do_gvec_fn3, a, gen_gvec_cmtst)
 
+TRANS(SQDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqdmulh_qc)
+TRANS(SQRDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmulh_qc)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5589,6 +5619,27 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 TRANS(FMLA_si, do_fmla_scalar_idx, a, false)
 TRANS(FMLS_si, do_fmla_scalar_idx, a, true)
 
+static bool do_env_scalar2_idx_hs(DisasContext *s, arg_rrx_e *a,
+                                  const ENVScalar2 *f)
+{
+    if (a->esz < MO_16 || a->esz > MO_32) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, t0, a->rn, 0, a->esz);
+        read_vec_element_i32(s, t1, a->rm, a->idx, a->esz);
+        f->gen_bhs[a->esz](t0, tcg_env, t0, t1);
+        write_fp_sreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+TRANS(SQDMULH_si, do_env_scalar2_idx_hs, a, &f_scalar_sqdmulh)
+TRANS(SQRDMULH_si, do_env_scalar2_idx_hs, a, &f_scalar_sqrdmulh)
+
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5719,6 +5770,33 @@ static bool do_mla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool sub)
 TRANS(MLA_vi, do_mla_vector_idx, a, false)
 TRANS(MLS_vi, do_mla_vector_idx, a, true)
 
+static bool do_int3_qc_vector_idx(DisasContext *s, arg_qrrx_e *a,
+                                  gen_helper_gvec_4 * const fns[2])
+{
+    assert(a->esz == MO_16 || a->esz == MO_32);
+    if (fp_access_check(s)) {
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           offsetof(CPUARMState, vfp.qc),
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           a->idx, fns[a->esz - 1]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_4 * const f_vector_idx_sqdmulh[2] = {
+    gen_helper_neon_sqdmulh_idx_h,
+    gen_helper_neon_sqdmulh_idx_s,
+};
+TRANS(SQDMULH_vi, do_int3_qc_vector_idx, a, f_vector_idx_sqdmulh)
+
+static gen_helper_gvec_4 * const f_vector_idx_sqrdmulh[2] = {
+    gen_helper_neon_sqrdmulh_idx_h,
+    gen_helper_neon_sqrdmulh_idx_s,
+};
+TRANS(SQRDMULH_vi, do_int3_qc_vector_idx, a, f_vector_idx_sqrdmulh)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -9500,109 +9578,6 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar three same
- *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
- * +-----+---+-----------+------+---+------+--------+---+------+------+
- * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
- * +-----+---+-----------+------+---+------+--------+---+------+------+
- */
-static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    bool u = extract32(insn, 29, 1);
-    TCGv_i64 tcg_rd;
-
-    switch (opcode) {
-    case 0x16: /* SQDMULH, SQRDMULH (vector) */
-        if (size != 1 && size != 2) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-    case 0x1: /* SQADD, UQADD */
-    case 0x5: /* SQSUB, UQSUB */
-    case 0x6: /* CMGT, CMHI */
-    case 0x7: /* CMGE, CMHS */
-    case 0x8: /* SSHL, USHL */
-    case 0x9: /* SQSHL, UQSHL */
-    case 0xa: /* SRSHL, URSHL */
-    case 0xb: /* SQRSHL, UQRSHL */
-    case 0x10: /* ADD, SUB (vector) */
-    case 0x11: /* CMTST, CMEQ */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rd = tcg_temp_new_i64();
-
-    if (size == 3) {
-        g_assert_not_reached();
-    } else {
-        /* Do a single operation on the lowest element in the vector.
-         * We use the standard Neon helpers and rely on 0 OP 0 == 0 with
-         * no side effects for all these operations.
-         * OPTME: special-purpose helpers would avoid doing some
-         * unnecessary work in the helper for the 8 and 16 bit cases.
-         */
-        NeonGenTwoOpEnvFn *genenvfn = NULL;
-        void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
-
-        switch (opcode) {
-        case 0x16: /* SQDMULH, SQRDMULH */
-        {
-            static NeonGenTwoOpEnvFn * const fns[2][2] = {
-                { gen_helper_neon_qdmulh_s16, gen_helper_neon_qrdmulh_s16 },
-                { gen_helper_neon_qdmulh_s32, gen_helper_neon_qrdmulh_s32 },
-            };
-            assert(size == 1 || size == 2);
-            genenvfn = fns[size - 1][u];
-            break;
-        }
-        default:
-        case 0x1: /* SQADD, UQADD */
-        case 0x5: /* SQSUB, UQSUB */
-        case 0x9: /* SQSHL, UQSHL */
-        case 0xb: /* SQRSHL, UQRSHL */
-            g_assert_not_reached();
-        }
-
-        if (genenvfn) {
-            TCGv_i32 tcg_rn = tcg_temp_new_i32();
-            TCGv_i32 tcg_rm = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_rn, rn, 0, size);
-            read_vec_element_i32(s, tcg_rm, rm, 0, size);
-            genenvfn(tcg_rn, tcg_env, tcg_rn, tcg_rm);
-            tcg_gen_extu_i32_i64(tcg_rd, tcg_rn);
-        } else {
-            TCGv_i64 tcg_rn = tcg_temp_new_i64();
-            TCGv_i64 tcg_rm = tcg_temp_new_i64();
-            TCGv_i64 qc = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_rn, rn, 0, size | (u ? 0 : MO_SIGN));
-            read_vec_element(s, tcg_rm, rm, 0, size | (u ? 0 : MO_SIGN));
-            tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-            genfn(tcg_rd, qc, tcg_rn, tcg_rm, size);
-            tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-            if (!u) {
-                /* Truncate signed 64-bit result for writeback. */
-                tcg_gen_ext_i64(tcg_rd, tcg_rd, size);
-            }
-        }
-    }
-
-    write_fp_dreg(s, rd, tcg_rd);
-}
-
 /* AdvSIMD scalar three same extra
  *  31 30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
  * +-----+---+-----------+------+---+------+---+--------+---+----+----+
@@ -10940,94 +10915,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Integer op subgroup of C3.6.16. */
-static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
-{
-    int is_q = extract32(insn, 30, 1);
-    int u = extract32(insn, 29, 1);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 11, 5);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    switch (opcode) {
-    case 0x16: /* SQDMULH, SQRDMULH */
-        if (size == 0 || size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-
-    case 0x0: /* SHADD, UHADD */
-    case 0x01: /* SQADD, UQADD */
-    case 0x02: /* SRHADD, URHADD */
-    case 0x04: /* SHSUB, UHSUB */
-    case 0x05: /* SQSUB, UQSUB */
-    case 0x06: /* CMGT, CMHI */
-    case 0x07: /* CMGE, CMHS */
-    case 0x08: /* SSHL, USHL */
-    case 0x09: /* SQSHL, UQSHL */
-    case 0x0a: /* SRSHL, URSHL */
-    case 0x0b: /* SQRSHL, UQRSHL */
-    case 0x0c: /* SMAX, UMAX */
-    case 0x0d: /* SMIN, UMIN */
-    case 0x0e: /* SABD, UABD */
-    case 0x0f: /* SABA, UABA */
-    case 0x10: /* ADD, SUB */
-    case 0x11: /* CMTST, CMEQ */
-    case 0x12: /* MLA, MLS */
-    case 0x13: /* MUL, PMUL */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x16: /* SQDMULH, SQRDMULH */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmulh_qc, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqdmulh_qc, size);
-        }
-        return;
-    }
-    g_assert_not_reached();
-}
-
-/* AdvSIMD three same
- *  31  30  29  28       24 23  22  21 20  16 15    11  10 9    5 4    0
- * +---+---+---+-----------+------+---+------+--------+---+------+------+
- * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+--------+---+------+------+
- */
-static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
-{
-    int opcode = extract32(insn, 11, 5);
-
-    switch (opcode) {
-    default:
-        disas_simd_3same_int(s, insn);
-        break;
-    case 0x3: /* logic ops */
-    case 0x14: /* SMAXP, UMAXP */
-    case 0x15: /* SMINP, UMINP */
-    case 0x17: /* ADDP */
-    case 0x18 ... 0x31: /* floating point ops */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 /* AdvSIMD three same extra
  *  31   30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
  * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
@@ -12214,9 +12101,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x0c: /* SQDMULH */
-    case 0x0d: /* SQRDMULH */
-        break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
         if (!dc_isar_feature(aa64_rdm, s)) {
@@ -12278,6 +12162,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x05: /* FMLS */
     case 0x08: /* MUL */
     case 0x09: /* FMUL */
+    case 0x0c: /* SQDMULH */
+    case 0x0d: /* SQRDMULH */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
@@ -12683,7 +12569,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
  */
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
-    { 0x0e200400, 0x9f200400, disas_simd_three_reg_same },
     { 0x0e008400, 0x9f208400, disas_simd_three_reg_same_extra },
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
@@ -12695,7 +12580,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x2e000000, 0xbf208400, disas_simd_ext },
-    { 0x5e200400, 0xdf200400, disas_simd_scalar_three_reg_same },
     { 0x5e008400, 0xdf208400, disas_simd_scalar_three_reg_same_extra },
     { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d8e96386be6..b05922b425f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -311,6 +311,38 @@ void HELPER(neon_sqrdmulh_h)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqdmulh_idx_h)(void *vd, void *vn, void *vm,
+                                void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+
+    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+        int16_t mm = m[i];
+        for (j = 0; j < 16 / 2; ++j) {
+            d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, false, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmulh_idx_h)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+
+    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+        int16_t mm = m[i];
+        for (j = 0; j < 16 / 2; ++j) {
+            d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(sve2_sqrdmlah_h)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
@@ -474,6 +506,38 @@ void HELPER(neon_sqrdmulh_s)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
+                                void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+
+    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+        int32_t mm = m[i];
+        for (j = 0; j < 16 / 4; ++j) {
+            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+
+    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+        int32_t mm = m[i];
+        for (j = 0; j < 16 / 4; ++j) {
+            d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(sve2_sqrdmlah_s)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
-- 
2.34.1


