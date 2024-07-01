Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02323C3065D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa3-0002tY-E8; Mon, 01 Jul 2024 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZC-0000mv-Q9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ2-0005Qa-It
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42574064b16so19649565e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850055; x=1720454855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JxKVJIA5wo1qWrq4v4ZGoeISyR7a2N05QyKg/e3Ewm4=;
 b=YVnNa8zphu1q/VVCeMfH5DQyBmvN5VbM3qSX5vbflXerk9cQMGnMFpbg7gRWe9o9Rj
 EreY5I5c2BJpqHDWLLRBF+rVg3GTVPY3haOBqCzxN/dni+/jh+PVsTwIPt/+noeHH+yD
 LSoUo9hG7laegMojzV5fbgxjZ5BcqeZgaAwoe50CWBiuAtQ4q5qE0sGnczpxrxdDs4gf
 kJcMETdhlolXrgcv0oihbNPVcwLdJ3J2nHHm9+A8NhL48KJep+uyT9mTpLcOHbN+XLiP
 jf+U6HCkKMh/1FNelwTcFMg/rQeYlbuxylXPLzWtqArFWeMhT7jYF2nJ56tdzv+MhlY/
 dPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850055; x=1720454855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxKVJIA5wo1qWrq4v4ZGoeISyR7a2N05QyKg/e3Ewm4=;
 b=kqDjbnYlzmbzwSRds/luc6M3aKXaPNPLCbkauBDLP+FsDLh1oOo5M42hNyUqyEHZG/
 ThvCrWawe6cOboADNrC7umuR0vw2XoSHhoRCYEYMYhqaVFIgzbnj/EJr+2igDB+hZsjp
 GyKXDQF7zwMpvZD7S+dV+xtF7bvLhGPTd1Zts+XLfsggn1guoUHJXJ2YKx0WR0sS8uet
 vvG26aUvE2kuXVr8/UYgpFBwvaC0PEKKP+gcJMR0J3sVSsE4mJc9xuhcB38UQOC/Ccup
 lQ5tWnJYNjacyuJc52Ft1zhw8mC0n1mQbufDYHqMKjQ7wMcdyY55fxCmofhL9R2qU5lT
 UfBA==
X-Gm-Message-State: AOJu0Yw9tv9smmi7yb0dMTJc6ewkb4nahUEHbbwG6ejrZ2YGDy/q/6Fv
 6bfo0yhdd5HfB5Cc5ZImr3egP2mIlOU2qFu1IF/J8t0/Qn+NMh66FNhUdLqQeY3kMj5AJmeInXN
 bhCs=
X-Google-Smtp-Source: AGHT+IEhtCnVu3uCRu5XcQ6dasr5azw7hI2DiT11OSVDeHpICGLnC125N8QfXjUtzv8ga2PNRMD47Q==
X-Received: by 2002:a05:600c:3388:b0:424:a587:51d3 with SMTP id
 5b1f17b1804b1-4257a02f6f2mr41278005e9.13.1719850054860; 
 Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] target/arm: Convert SQRDMLAH, SQRDMLSH to decodetree
Date: Mon,  1 Jul 2024 17:07:10 +0100
Message-Id: <20240701160729.1910763-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  10 ++
 target/arm/tcg/a64.decode      |  16 +++
 target/arm/tcg/translate-a64.c | 206 +++++++++++++--------------------
 target/arm/tcg/vec_helper.c    |  72 ++++++++++++
 4 files changed, 180 insertions(+), 124 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index eca2043fc2a..970d059dec5 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -979,6 +979,16 @@ DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(neon_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(neon_sqrdmlah_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrdmlah_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(neon_sqrdmlsh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrdmlsh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2b7a3254a0e..613cc9365cf 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -781,6 +781,8 @@ CMEQ_s          0111 1110 111 ..... 10001 1 ..... ..... @rrr_d
 
 SQDMULH_s       0101 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
 SQRDMULH_s      0111 1110 ..1 ..... 10110 1 ..... ..... @rrr_e
+SQRDMLAH_s      0111 1110 ..0 ..... 10000 1 ..... ..... @rrr_e
+SQRDMLSH_s      0111 1110 ..0 ..... 10001 1 ..... ..... @rrr_e
 
 ### Advanced SIMD scalar pairwise
 
@@ -941,6 +943,8 @@ MLS_v           0.10 1110 ..1 ..... 10010 1 ..... ..... @qrrr_e
 
 SQDMULH_v       0.00 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
 SQRDMULH_v      0.10 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
+SQRDMLAH_v      0.10 1110 ..0 ..... 10000 1 ..... ..... @qrrr_e
+SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
@@ -966,6 +970,12 @@ SQDMULH_si      0101 1111 10 .. .... 1100 . 0 ..... .....   @rrx_s
 SQRDMULH_si     0101 1111 01 .. .... 1101 . 0 ..... .....   @rrx_h
 SQRDMULH_si     0101 1111 10 . ..... 1101 . 0 ..... .....   @rrx_s
 
+SQRDMLAH_si     0111 1111 01 .. .... 1101 . 0 ..... .....   @rrx_h
+SQRDMLAH_si     0111 1111 10 .. .... 1101 . 0 ..... .....   @rrx_s
+
+SQRDMLSH_si     0111 1111 01 .. .... 1111 . 0 ..... .....   @rrx_h
+SQRDMLSH_si     0111 1111 10 .. .... 1111 . 0 ..... .....   @rrx_s
+
 ### Advanced SIMD vector x indexed element
 
 FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
@@ -1004,6 +1014,12 @@ SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
 SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
 SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
 
+SQRDMLAH_vi     0.10 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
+SQRDMLAH_vi     0.10 1111 10 .. .... 1101 . 0 ..... .....   @qrrx_s
+
+SQRDMLSH_vi     0.10 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_h
+SQRDMLSH_vi     0.10 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 93543da39cc..32c24c74220 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5235,6 +5235,43 @@ static const ENVScalar2 f_scalar_sqrdmulh = {
 };
 TRANS(SQRDMULH_s, do_env_scalar2_hs, a, &f_scalar_sqrdmulh)
 
+typedef struct ENVScalar3 {
+    NeonGenThreeOpEnvFn *gen_hs[2];
+} ENVScalar3;
+
+static bool do_env_scalar3_hs(DisasContext *s, arg_rrr_e *a,
+                              const ENVScalar3 *f)
+{
+    TCGv_i32 t0, t1, t2;
+
+    if (a->esz != MO_16 && a->esz != MO_32) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    t2 = tcg_temp_new_i32();
+    read_vec_element_i32(s, t0, a->rn, 0, a->esz);
+    read_vec_element_i32(s, t1, a->rm, 0, a->esz);
+    read_vec_element_i32(s, t2, a->rd, 0, a->esz);
+    f->gen_hs[a->esz - 1](t0, tcg_env, t0, t1, t2);
+    write_fp_sreg(s, a->rd, t0);
+    return true;
+}
+
+static const ENVScalar3 f_scalar_sqrdmlah = {
+    { gen_helper_neon_qrdmlah_s16, gen_helper_neon_qrdmlah_s32 }
+};
+TRANS_FEAT(SQRDMLAH_s, aa64_rdm, do_env_scalar3_hs, a, &f_scalar_sqrdmlah)
+
+static const ENVScalar3 f_scalar_sqrdmlsh = {
+    { gen_helper_neon_qrdmlsh_s16, gen_helper_neon_qrdmlsh_s32 }
+};
+TRANS_FEAT(SQRDMLSH_s, aa64_rdm, do_env_scalar3_hs, a, &f_scalar_sqrdmlsh)
+
 static bool do_cmop_d(DisasContext *s, arg_rrr_e *a, TCGCond cond)
 {
     if (fp_access_check(s)) {
@@ -5552,6 +5589,8 @@ TRANS(CMTST_v, do_gvec_fn3, a, gen_gvec_cmtst)
 
 TRANS(SQDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqdmulh_qc)
 TRANS(SQRDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmulh_qc)
+TRANS_FEAT(SQRDMLAH_v, aa64_rdm, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmlah_qc)
+TRANS_FEAT(SQRDMLSH_v, aa64_rdm, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmlsh_qc)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -5681,6 +5720,29 @@ static bool do_env_scalar2_idx_hs(DisasContext *s, arg_rrx_e *a,
 TRANS(SQDMULH_si, do_env_scalar2_idx_hs, a, &f_scalar_sqdmulh)
 TRANS(SQRDMULH_si, do_env_scalar2_idx_hs, a, &f_scalar_sqrdmulh)
 
+static bool do_env_scalar3_idx_hs(DisasContext *s, arg_rrx_e *a,
+                                  const ENVScalar3 *f)
+{
+    if (a->esz < MO_16 || a->esz > MO_32) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, t0, a->rn, 0, a->esz);
+        read_vec_element_i32(s, t1, a->rm, a->idx, a->esz);
+        read_vec_element_i32(s, t2, a->rd, 0, a->esz);
+        f->gen_hs[a->esz - 1](t0, tcg_env, t0, t1, t2);
+        write_fp_sreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+TRANS_FEAT(SQRDMLAH_si, aa64_rdm, do_env_scalar3_idx_hs, a, &f_scalar_sqrdmlah)
+TRANS_FEAT(SQRDMLSH_si, aa64_rdm, do_env_scalar3_idx_hs, a, &f_scalar_sqrdmlsh)
+
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5838,6 +5900,20 @@ static gen_helper_gvec_4 * const f_vector_idx_sqrdmulh[2] = {
 };
 TRANS(SQRDMULH_vi, do_int3_qc_vector_idx, a, f_vector_idx_sqrdmulh)
 
+static gen_helper_gvec_4 * const f_vector_idx_sqrdmlah[2] = {
+    gen_helper_neon_sqrdmlah_idx_h,
+    gen_helper_neon_sqrdmlah_idx_s,
+};
+TRANS_FEAT(SQRDMLAH_vi, aa64_rdm, do_int3_qc_vector_idx, a,
+           f_vector_idx_sqrdmlah)
+
+static gen_helper_gvec_4 * const f_vector_idx_sqrdmlsh[2] = {
+    gen_helper_neon_sqrdmlsh_idx_h,
+    gen_helper_neon_sqrdmlsh_idx_s,
+};
+TRANS_FEAT(SQRDMLSH_vi, aa64_rdm, do_int3_qc_vector_idx, a,
+           f_vector_idx_sqrdmlsh)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -9536,84 +9612,6 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar three same extra
- *  31 30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
- * +-----+---+-----------+------+---+------+---+--------+---+----+----+
- * | 0 1 | U | 1 1 1 1 0 | size | 0 |  Rm  | 1 | opcode | 1 | Rn | Rd |
- * +-----+---+-----------+------+---+------+---+--------+---+----+----+
- */
-static void disas_simd_scalar_three_reg_same_extra(DisasContext *s,
-                                                   uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 4);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    bool u = extract32(insn, 29, 1);
-    TCGv_i32 ele1, ele2, ele3;
-    TCGv_i64 res;
-    bool feature;
-
-    switch (u * 16 + opcode) {
-    case 0x10: /* SQRDMLAH (vector) */
-    case 0x11: /* SQRDMLSH (vector) */
-        if (size != 1 && size != 2) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_rdm, s);
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    /* Do a single operation on the lowest element in the vector.
-     * We use the standard Neon helpers and rely on 0 OP 0 == 0
-     * with no side effects for all these operations.
-     * OPTME: special-purpose helpers would avoid doing some
-     * unnecessary work in the helper for the 16 bit cases.
-     */
-    ele1 = tcg_temp_new_i32();
-    ele2 = tcg_temp_new_i32();
-    ele3 = tcg_temp_new_i32();
-
-    read_vec_element_i32(s, ele1, rn, 0, size);
-    read_vec_element_i32(s, ele2, rm, 0, size);
-    read_vec_element_i32(s, ele3, rd, 0, size);
-
-    switch (opcode) {
-    case 0x0: /* SQRDMLAH */
-        if (size == 1) {
-            gen_helper_neon_qrdmlah_s16(ele3, tcg_env, ele1, ele2, ele3);
-        } else {
-            gen_helper_neon_qrdmlah_s32(ele3, tcg_env, ele1, ele2, ele3);
-        }
-        break;
-    case 0x1: /* SQRDMLSH */
-        if (size == 1) {
-            gen_helper_neon_qrdmlsh_s16(ele3, tcg_env, ele1, ele2, ele3);
-        } else {
-            gen_helper_neon_qrdmlsh_s32(ele3, tcg_env, ele1, ele2, ele3);
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    res = tcg_temp_new_i64();
-    tcg_gen_extu_i32_i64(res, ele3);
-    write_fp_dreg(s, rd, res);
-}
-
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
                             TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
@@ -10892,14 +10890,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int rot;
 
     switch (u * 16 + opcode) {
-    case 0x10: /* SQRDMLAH (vector) */
-    case 0x11: /* SQRDMLSH (vector) */
-        if (size != 1 && size != 2) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_rdm, s);
-        break;
     case 0x02: /* SDOT (vector) */
     case 0x12: /* UDOT (vector) */
         if (size != MO_32) {
@@ -10957,6 +10947,8 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x10: /* SQRDMLAH (vector) */
+    case 0x11: /* SQRDMLSH (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10969,14 +10961,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0: /* SQRDMLAH (vector) */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmlah_qc, size);
-        return;
-
-    case 0x1: /* SQRDMLSH (vector) */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqrdmlsh_qc, size);
-        return;
-
     case 0x2: /* SDOT / UDOT */
         gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0,
                          u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b);
@@ -12059,13 +12043,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x1d: /* SQRDMLAH */
-    case 0x1f: /* SQRDMLSH */
-        if (!dc_isar_feature(aa64_rdm, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x0e: /* SDOT */
     case 0x1e: /* UDOT */
         if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
@@ -12127,6 +12104,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
     case 0x1c: /* FMLSL2 */
+    case 0x1d: /* SQRDMLAH */
+    case 0x1f: /* SQRDMLSH */
         unallocated_encoding(s);
         return;
     }
@@ -12320,33 +12299,13 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                                 tcg_op, tcg_idx);
                 }
                 break;
-            case 0x1d: /* SQRDMLAH */
-                read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
-                if (size == 1) {
-                    gen_helper_neon_qrdmlah_s16(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx, tcg_res);
-                } else {
-                    gen_helper_neon_qrdmlah_s32(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx, tcg_res);
-                }
-                break;
-            case 0x1f: /* SQRDMLSH */
-                read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
-                if (size == 1) {
-                    gen_helper_neon_qrdmlsh_s16(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx, tcg_res);
-                } else {
-                    gen_helper_neon_qrdmlsh_s32(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx, tcg_res);
-                }
-                break;
             default:
             case 0x01: /* FMLA */
             case 0x05: /* FMLS */
             case 0x09: /* FMUL */
             case 0x19: /* FMULX */
+            case 0x1d: /* SQRDMLAH */
+            case 0x1f: /* SQRDMLSH */
                 g_assert_not_reached();
             }
 
@@ -12538,7 +12497,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x0e000000, 0xbf208c00, disas_simd_tb },
     { 0x0e000800, 0xbf208c00, disas_simd_zip_trn },
     { 0x2e000000, 0xbf208400, disas_simd_ext },
-    { 0x5e008400, 0xdf208400, disas_simd_scalar_three_reg_same_extra },
     { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d477479bb19..98604d170fd 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -347,6 +347,42 @@ void HELPER(neon_sqrdmulh_idx_h)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqrdmlah_idx_h)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+    intptr_t elements = opr_sz / 2;
+    intptr_t eltspersegment = MIN(16 / 2, elements);
+
+    for (i = 0; i < elements; i += 16 / 2) {
+        int16_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            d[i + j] = do_sqrdmlah_h(n[i + j], mm, d[i + j], false, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmlsh_idx_h)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+    intptr_t elements = opr_sz / 2;
+    intptr_t eltspersegment = MIN(16 / 2, elements);
+
+    for (i = 0; i < elements; i += 16 / 2) {
+        int16_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            d[i + j] = do_sqrdmlah_h(n[i + j], mm, d[i + j], true, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(sve2_sqrdmlah_h)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
@@ -546,6 +582,42 @@ void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqrdmlah_idx_s)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
+
+    for (i = 0; i < elements; i += 16 / 4) {
+        int32_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            d[i + j] = do_sqrdmlah_s(n[i + j], mm, d[i + j], false, true, vq);
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmlsh_idx_s)(void *vd, void *vn, void *vm,
+                                 void *vq, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    int idx = simd_data(desc);
+    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
+
+    for (i = 0; i < elements; i += 16 / 4) {
+        int32_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            d[i + j] = do_sqrdmlah_s(n[i + j], mm, d[i + j], true, true, vq);
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


