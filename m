Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CF4E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aC-0008Fs-9p; Fri, 13 Dec 2024 12:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y1-0008HV-TT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xr-0001iJ-P0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1079433f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111222; x=1734716022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+UDn0aAMuczaa4QpohakpRN/RqACfQ7Fq2tPcYSYVo=;
 b=GD4Kifrcdj9jbx5ThJOpcNnphQQbRdxFSdfUiDTyVsmPjP+64EhWtYID98y/pMLZNK
 WYcP29EcfIJMxvurIWW8T+BRgFx/yiphYm6lij7QzQsYpo2C1SxeW7XgVmC3MOhyLAVY
 27cGfWScb77awNI/nyzt1iEydlA4a2RG+x9fvu3mhwDA+rZjtHE3wdv2Tnu4lagzKF/X
 q0dF3fMhBtKM4RJYglD4IGE4eFfQQlJtNrzPENDPWTdj6N0oK/Elo2FyX2Ch4pd9cKBC
 sCQPaaxLdfgBiFFC+tcXRpPtmU7TOfgN4LRTHz7ksghD3HA7SJQD+Isvalz54ttoPeIb
 ZWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111222; x=1734716022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+UDn0aAMuczaa4QpohakpRN/RqACfQ7Fq2tPcYSYVo=;
 b=HFaH3jUKTv9jiRZgo9nlHFjPRyU0yF8ncSuGtWyW24tWlJxEbYAE3WjMl4m530jbpY
 69lEpjygrtGLrLTiOdvAoZNWQMe2XSzSGUNVe/okCNKwseMVgg1FHHVUmirB6f9o8aok
 8Lv+4zsNs0rTKBx6k5Qb7tfSt3dZHo/mSuKiafgI8A5jI3VsBCgGWDDYyjwfhjPJStKu
 sOYDwQ6qEQ9vZ5fRT/6LM66rX+vb4KxjSqbCl5552wRVIXThv4ztR/a2T46e1QmZr9mI
 A18gGQPRLTTG57sSSUVE1EvY5/pMyPGN56NoXo7cy9OS5tegTVOAbK5wRyliEYiZtcZJ
 xiGA==
X-Gm-Message-State: AOJu0YzDXiMq1l08eO5fSIjy9ljeaDgHXP8nsF1OG1lMc+wrlek0F0VJ
 3xrrf7COvscXBqgZg6oMFIzJ/pXIisuy+f+frLQ/Er1hY/KN6TBHapJ7NTqX9q2VvL6PIGXo4pZ
 T
X-Gm-Gg: ASbGncshe8ArS3OhpKk7bNjowGiYuaGdWGVd0MtM3ldk370HlslqU23Gw1/FkieL7nK
 5HdEmCuHc/nRage2Vn9VJ4fstFd5a517L24iiVEcYuoDg8bTF4zGucwg5kUwL+GZLX0s2O11482
 fMO7CUP0Lqo9PbKv6jktr90YUkS0CSMotOhuPo2N88oAOTjY3SX12kaLWJsY8UgPg+XhGfRPUiI
 PLXoeLlPZkgYFrO0xNqWjfUTQjgF3utoIxV/ZkaZ9i7q9orgYubwvv9HgkujA==
X-Google-Smtp-Source: AGHT+IH2AzHz5SHQxOCMVZr+mit4HutVvmBrl3rGofuX0/+xQsOCAqFX/sfWmkaETpvS+ObmTK2irQ==
X-Received: by 2002:adf:f545:0:b0:385:f409:b42 with SMTP id
 ffacd0b85a97d-3888e0c0831mr2435209f8f.53.1734111221936; 
 Fri, 13 Dec 2024 09:33:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/85] target/arm: Convert FRECPE, FRECPX, FRSQRTE to decodetree
Date: Fri, 13 Dec 2024 17:32:10 +0000
Message-Id: <20241213173229.3308926-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Remove disas_simd_scalar_two_reg_misc and
disas_simd_two_reg_misc_fp16 as these were the
last insns decoded by those functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-67-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  15 ++
 target/arm/tcg/translate-a64.c | 329 ++++-----------------------------
 2 files changed, 53 insertions(+), 291 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d1c4a330f2d..9b3b09c3bb2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1667,6 +1667,15 @@ FCMLE0_s        0111 1110 1.1 00000 11011 0 ..... .....     @rr_sd
 FCMLT0_s        0101 1110 111 11000 11101 0 ..... .....     @rr_h
 FCMLT0_s        0101 1110 1.1 00000 11101 0 ..... .....     @rr_sd
 
+FRECPE_s        0101 1110 111 11001 11011 0 ..... .....     @rr_h
+FRECPE_s        0101 1110 1.1 00001 11011 0 ..... .....     @rr_sd
+
+FRECPX_s        0101 1110 111 11001 11111 0 ..... .....     @rr_h
+FRECPX_s        0101 1110 1.1 00001 11111 0 ..... .....     @rr_sd
+
+FRSQRTE_s       0111 1110 111 11001 11011 0 ..... .....     @rr_h
+FRSQRTE_s       0111 1110 1.1 00001 11011 0 ..... .....     @rr_sd
+
 @icvt_h         . ....... .. ...... ...... rn:5 rd:5 \
                 &fcvt sf=0 esz=1 shift=0
 @icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
@@ -1848,6 +1857,12 @@ FCMLE0_v        0.10 1110 1.1 00000 11011 0 ..... .....     @qrr_sd
 FCMLT0_v        0.00 1110 111 11000 11101 0 ..... .....     @qrr_h
 FCMLT0_v        0.00 1110 1.1 00000 11101 0 ..... .....     @qrr_sd
 
+FRECPE_v        0.00 1110 111 11001 11011 0 ..... .....     @qrr_h
+FRECPE_v        0.00 1110 1.1 00001 11011 0 ..... .....     @qrr_sd
+
+FRSQRTE_v       0.10 1110 111 11001 11011 0 ..... .....     @qrr_h
+FRSQRTE_v       0.10 1110 1.1 00001 11011 0 ..... .....     @qrr_sd
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1776862161a..63cf25251b9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8501,6 +8501,27 @@ TRANS_FEAT(FRINT64Z_s, aa64_frint, do_fp1_scalar, a,
            &f_scalar_frint64, FPROUNDING_ZERO)
 TRANS_FEAT(FRINT64X_s, aa64_frint, do_fp1_scalar, a, &f_scalar_frint64, -1)
 
+static const FPScalar1 f_scalar_frecpe = {
+    gen_helper_recpe_f16,
+    gen_helper_recpe_f32,
+    gen_helper_recpe_f64,
+};
+TRANS(FRECPE_s, do_fp1_scalar, a, &f_scalar_frecpe, -1)
+
+static const FPScalar1 f_scalar_frecpx = {
+    gen_helper_frecpx_f16,
+    gen_helper_frecpx_f32,
+    gen_helper_frecpx_f64,
+};
+TRANS(FRECPX_s, do_fp1_scalar, a, &f_scalar_frecpx, -1)
+
+static const FPScalar1 f_scalar_frsqrte = {
+    gen_helper_rsqrte_f16,
+    gen_helper_rsqrte_f32,
+    gen_helper_rsqrte_f64,
+};
+TRANS(FRSQRTE_s, do_fp1_scalar, a, &f_scalar_frsqrte, -1)
+
 static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
 {
     if (fp_access_check(s)) {
@@ -9471,36 +9492,28 @@ static gen_helper_gvec_2_ptr * const f_fcle0[] = {
 };
 TRANS(FCMLE0_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_fcle0)
 
+static gen_helper_gvec_2_ptr * const f_frecpe[] = {
+    gen_helper_gvec_frecpe_h,
+    gen_helper_gvec_frecpe_s,
+    gen_helper_gvec_frecpe_d,
+};
+TRANS(FRECPE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frecpe)
+
+static gen_helper_gvec_2_ptr * const f_frsqrte[] = {
+    gen_helper_gvec_frsqrte_h,
+    gen_helper_gvec_frsqrte_s,
+    gen_helper_gvec_frsqrte_d,
+};
+TRANS(FRSQRTE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
+
 static void handle_2misc_reciprocal(DisasContext *s, int opcode,
                                     bool is_scalar, bool is_u, bool is_q,
                                     int size, int rn, int rd)
 {
     bool is_double = (size == 3);
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
     if (is_double) {
-        TCGv_i64 tcg_op = tcg_temp_new_i64();
-        TCGv_i64 tcg_res = tcg_temp_new_i64();
-        int pass;
-
-        for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-            switch (opcode) {
-            case 0x3d: /* FRECPE */
-                gen_helper_recpe_f64(tcg_res, tcg_op, fpst);
-                break;
-            case 0x3f: /* FRECPX */
-                gen_helper_frecpx_f64(tcg_res, tcg_op, fpst);
-                break;
-            case 0x7d: /* FRSQRTE */
-                gen_helper_rsqrte_f64(tcg_res, tcg_op, fpst);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        }
-        clear_vec_high(s, !is_scalar, rd);
+        g_assert_not_reached();
     } else {
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         TCGv_i32 tcg_res = tcg_temp_new_i32();
@@ -9520,14 +9533,8 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
                 gen_helper_recpe_u32(tcg_res, tcg_op);
                 break;
             case 0x3d: /* FRECPE */
-                gen_helper_recpe_f32(tcg_res, tcg_op, fpst);
-                break;
             case 0x3f: /* FRECPX */
-                gen_helper_frecpx_f32(tcg_res, tcg_op, fpst);
-                break;
             case 0x7d: /* FRSQRTE */
-                gen_helper_rsqrte_f32(tcg_res, tcg_op, fpst);
-                break;
             default:
                 g_assert_not_reached();
             }
@@ -9544,76 +9551,6 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
     }
 }
 
-/* AdvSIMD scalar two reg misc
- *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----+---+-----------+------+-----------+--------+-----+------+------+
- * | 0 1 | U | 1 1 1 1 0 | size | 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----+---+-----------+------+-----------+--------+-----+------+------+
- */
-static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 12, 5);
-    int size = extract32(insn, 22, 2);
-    bool u = extract32(insn, 29, 1);
-
-    switch (opcode) {
-    case 0xc ... 0xf:
-    case 0x16 ... 0x1d:
-    case 0x1f:
-        /* Floating point: U, size[1] and opcode indicate operation;
-         * size[0] indicates single or double precision.
-         */
-        opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
-        size = extract32(size, 0, 1) ? 3 : 2;
-        switch (opcode) {
-        case 0x3d: /* FRECPE */
-        case 0x3f: /* FRECPX */
-        case 0x7d: /* FRSQRTE */
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_reciprocal(s, opcode, true, u, true, size, rn, rd);
-            return;
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-        case 0x5a: /* FCVTNU */
-        case 0x5b: /* FCVTMU */
-        case 0x7a: /* FCVTPU */
-        case 0x7b: /* FCVTZU */
-        case 0x1c: /* FCVTAS */
-        case 0x5c: /* FCVTAU */
-        case 0x56: /* FCVTXN, FCVTXN2 */
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        case 0x2c: /* FCMGT (zero) */
-        case 0x2d: /* FCMEQ (zero) */
-        case 0x2e: /* FCMLT (zero) */
-        case 0x6c: /* FCMGE (zero) */
-        case 0x6d: /* FCMLE (zero) */
-        default:
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    default:
-    case 0x3: /* USQADD / SUQADD */
-    case 0x7: /* SQABS / SQNEG */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-    case 0xa: /* CMLT */
-    case 0xb: /* ABS, NEG */
-    case 0x12: /* SQXTUN */
-    case 0x14: /* SQXTN, UQXTN */
-        unallocated_encoding(s);
-        return;
-    }
-    g_assert_not_reached();
-}
-
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -9693,13 +9630,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
-        case 0x3d: /* FRECPE */
-        case 0x7d: /* FRSQRTE */
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
             if (!fp_access_check(s)) {
                 return;
             }
@@ -9752,6 +9682,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x2e: /* FCMLT (zero) */
         case 0x6c: /* FCMGE (zero) */
         case 0x6d: /* FCMLE (zero) */
+        case 0x3d: /* FRECPE */
+        case 0x7d: /* FRSQRTE */
             unallocated_encoding(s);
             return;
         }
@@ -9847,189 +9779,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD [scalar] two register miscellaneous (FP16)
- *
- *   31  30  29 28  27     24  23 22 21       17 16    12 11 10 9    5 4    0
- * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
- * | 0 | Q | U | S | 1 1 1 0 | a | 1 1 1 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +---+---+---+---+---------+---+-------------+--------+-----+------+------+
- *   mask: 1000 1111 0111 1110 0000 1100 0000 0000 0x8f7e 0c00
- *   val:  0000 1110 0111 1000 0000 1000 0000 0000 0x0e78 0800
- *
- * This actually covers two groups where scalar access is governed by
- * bit 28. A bunch of the instructions (float to integral) only exist
- * in the vector form and are un-allocated for the scalar decode. Also
- * in the scalar decode Q is always 1.
- */
-static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
-{
-    int fpop, opcode, a, u;
-    int rn, rd;
-    bool is_q;
-    bool is_scalar;
-
-    int pass;
-    TCGv_i32 tcg_rmode = NULL;
-    TCGv_ptr tcg_fpstatus = NULL;
-    bool need_fpst = true;
-    int rmode = -1;
-
-    if (!dc_isar_feature(aa64_fp16, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    rd = extract32(insn, 0, 5);
-    rn = extract32(insn, 5, 5);
-
-    a = extract32(insn, 23, 1);
-    u = extract32(insn, 29, 1);
-    is_scalar = extract32(insn, 28, 1);
-    is_q = extract32(insn, 30, 1);
-
-    opcode = extract32(insn, 12, 5);
-    fpop = deposit32(opcode, 5, 1, a);
-    fpop = deposit32(fpop, 6, 1, u);
-
-    switch (fpop) {
-    case 0x3d: /* FRECPE */
-    case 0x3f: /* FRECPX */
-        break;
-    case 0x7d: /* FRSQRTE */
-        break;
-    default:
-    case 0x2f: /* FABS */
-    case 0x6f: /* FNEG */
-    case 0x7f: /* FSQRT (vector) */
-    case 0x18: /* FRINTN */
-    case 0x19: /* FRINTM */
-    case 0x38: /* FRINTP */
-    case 0x39: /* FRINTZ */
-    case 0x58: /* FRINTA */
-    case 0x59: /* FRINTX */
-    case 0x79: /* FRINTI */
-    case 0x1d: /* SCVTF */
-    case 0x5d: /* UCVTF */
-    case 0x1a: /* FCVTNS */
-    case 0x1b: /* FCVTMS */
-    case 0x1c: /* FCVTAS */
-    case 0x3a: /* FCVTPS */
-    case 0x3b: /* FCVTZS */
-    case 0x5a: /* FCVTNU */
-    case 0x5b: /* FCVTMU */
-    case 0x5c: /* FCVTAU */
-    case 0x7a: /* FCVTPU */
-    case 0x7b: /* FCVTZU */
-    case 0x2c: /* FCMGT (zero) */
-    case 0x2d: /* FCMEQ (zero) */
-    case 0x2e: /* FCMLT (zero) */
-    case 0x6c: /* FCMGE (zero) */
-    case 0x6d: /* FCMLE (zero) */
-        unallocated_encoding(s);
-        return;
-    }
-
-
-    /* Check additional constraints for the scalar encoding */
-    if (is_scalar) {
-        if (!is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (rmode >= 0 || need_fpst) {
-        tcg_fpstatus = fpstatus_ptr(FPST_FPCR_F16);
-    }
-
-    if (rmode >= 0) {
-        tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
-    }
-
-    if (is_scalar) {
-        TCGv_i32 tcg_op = read_fp_hreg(s, rn);
-        TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-        switch (fpop) {
-        case 0x3d: /* FRECPE */
-            gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        case 0x3f: /* FRECPX */
-            gen_helper_frecpx_f16(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        case 0x7d: /* FRSQRTE */
-            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        default:
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x1c: /* FCVTAS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-        case 0x5a: /* FCVTNU */
-        case 0x5b: /* FCVTMU */
-        case 0x5c: /* FCVTAU */
-        case 0x7a: /* FCVTPU */
-        case 0x7b: /* FCVTZU */
-            g_assert_not_reached();
-        }
-
-        /* limit any sign extension going on */
-        tcg_gen_andi_i32(tcg_res, tcg_res, 0xffff);
-        write_fp_sreg(s, rd, tcg_res);
-    } else {
-        for (pass = 0; pass < (is_q ? 8 : 4); pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_16);
-
-            switch (fpop) {
-            case 0x3d: /* FRECPE */
-                gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
-                break;
-            case 0x7d: /* FRSQRTE */
-                gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
-                break;
-            default:
-            case 0x2f: /* FABS */
-            case 0x6f: /* FNEG */
-            case 0x7f: /* FSQRT */
-            case 0x18: /* FRINTN */
-            case 0x19: /* FRINTM */
-            case 0x38: /* FRINTP */
-            case 0x39: /* FRINTZ */
-            case 0x58: /* FRINTA */
-            case 0x79: /* FRINTI */
-            case 0x59: /* FRINTX */
-            case 0x1a: /* FCVTNS */
-            case 0x1b: /* FCVTMS */
-            case 0x1c: /* FCVTAS */
-            case 0x3a: /* FCVTPS */
-            case 0x3b: /* FCVTZS */
-            case 0x5a: /* FCVTNU */
-            case 0x5b: /* FCVTMU */
-            case 0x5c: /* FCVTAU */
-            case 0x7a: /* FCVTPU */
-            case 0x7b: /* FCVTZU */
-                g_assert_not_reached();
-            }
-
-            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-        }
-
-        clear_vec_high(s, is_q, rd);
-    }
-
-    if (tcg_rmode) {
-        gen_restore_rmode(tcg_rmode, tcg_fpstatus);
-    }
-}
-
 /* C3.6 Data processing - SIMD, inc Crypto
  *
  * As the decode gets a little complex we are using a table based
@@ -10038,8 +9787,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.34.1


