Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0CED49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlcD-0006Mv-V2; Sun, 01 Dec 2024 10:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlab-0000Ms-UI
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:26 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaZ-0005JB-AS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:25 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f228d8cd0eso776300eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065822; x=1733670622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJJi/8Q55zoqtl5S4umY3kkUPvgeHBt0rML5IBq7/+Q=;
 b=y9yhztMgV917Wmr1jCxpajmC6rmz3tZMJGsKZWs1IljHDTKEQP4xDI9PJ+xnlio1Tj
 oBUMJI7D4MwmjR12zbk+iskg35l86eqM7eRy7MU+1ZjT9wogCruvCA5UTJSgXcsBJklO
 e09BCD9BbozPXICRjazc/+ZZJ0Qyu3D7B1CeVKcyXzIMEI4BVFSwPdyVAa7JPO0c6SIB
 t8I5esHAQYXMSi71oDWJh9kGdLfKEtt6PdxH2Bx5LZ1g4TGjU+Q2lngzXiwyvKzRtqOZ
 Rec6QxPjBuPa85tWmb2YbPRoR0Dxdn6FzVj24wuss30KO3XOcs5nPZqG1MUiU84BXhSf
 Nbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065822; x=1733670622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJJi/8Q55zoqtl5S4umY3kkUPvgeHBt0rML5IBq7/+Q=;
 b=qJURnZBAQKNd37W033OtpdXLWFmBPLfE1DFTmt44EjuKeetFb0tSZtBgPwE55k5FnK
 Kas4B1S3F0n5dO4ygkZc002IVT1Gt/wYCS5Yc10UJeYcD3Za8PDHygWjHAjXam5lOWME
 VySyn1ef9gyhCsIddIB75VNkOL92cpTmetVq3kKjfVgvL6m5r5uonWMhfaEDIEaC3+c4
 4fnBjy9wiefxD5b+EN2mjEYGxb5tKcZtGr2DraXvJEQs8NtMGHvHb+HqPIkqQD8I7YvK
 ncT3j4QryPOhDzBaIosihIPighBGevCIqwbRWPPaYaUr8js+Zs3WKEm9KZdrqNf1y+NI
 nJdA==
X-Gm-Message-State: AOJu0YwBuMoTnuxPRWX529u7kWhVerSnn5S5IrirPLFmU6U1gLZQ9DVd
 x0l8sShI2YWzZRFR/stKk6hYrf+1RtfwF4SLu/ziBIZPzNn1hd0lRLiBslzToQ42qyFKs/WguOu
 NOBw=
X-Gm-Gg: ASbGncvRIRoAP1I68ODKyFKQH+7J26oMQjmMnaW4W9AIwNMU9WvQelZe6XNNAflHCoz
 IGJIvbDmRI/pkM67NBszWDqyXD7wX7cVro56rjERGFlX3WDpvPuJ/uHMlz9TGoLI2TYTj0cVfDP
 E+kXBtFCq39YAtyuiVqrktATdAHCMfQtTM1VbPO2cc0V/a5X6TyQMNsicX7cHb+CJLZHzhQ1j8S
 0aVxv4xRyghfIatmivhM3EyrVmA9JCsiAjxiX4DEmuwnbzL15kKYxD/FZnBnLgXYiivwU5EnvWx
 0WlOl4zc5DMzw/Go8+v6UojFrdl+E3pFpTFx
X-Google-Smtp-Source: AGHT+IGjLkyeuI6lIQdt2c6/qsOXuxV2Uzx9RfPfVhxQRte6L0KAHRLGVlGvsQr0XXkSo8Z7MHi2AQ==
X-Received: by 2002:a05:6830:34a8:b0:718:8dc:a5e with SMTP id
 46e09a7af769-71d65c9a3c9mr14535391a34.9.1733065821959; 
 Sun, 01 Dec 2024 07:10:21 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 64/67] target/arm: Convert FRECPE, FRECPX,
 FRSQRTE to decodetree
Date: Sun,  1 Dec 2024 09:06:03 -0600
Message-ID: <20241201150607.12812-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Remove disas_simd_scalar_two_reg_misc and
disas_simd_two_reg_misc_fp16 as these were the
last insns decoded by those functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 330 ++++-----------------------------
 target/arm/tcg/a64.decode      |  15 ++
 2 files changed, 53 insertions(+), 292 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 211e313cb3..c60e9a35cf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8505,6 +8505,27 @@ TRANS_FEAT(FRINT64Z_s, aa64_frint, do_fp1_scalar, a,
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
@@ -9483,36 +9504,28 @@ static gen_helper_gvec_2_ptr * const f_fcle0[] = {
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
@@ -9532,14 +9545,8 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
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
@@ -9556,76 +9563,6 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
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
@@ -9705,13 +9642,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -9764,6 +9694,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x2e: /* FCMLT (zero) */
         case 0x6c: /* FCMGE (zero) */
         case 0x6d: /* FCMLE (zero) */
+        case 0x3d: /* FRECPE */
+        case 0x7d: /* FRSQRTE */
             unallocated_encoding(s);
             return;
         }
@@ -9859,190 +9791,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
-        case 0x6f: /* FNEG */
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
@@ -10051,8 +9799,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 640b2726c8..1e6bf15510 100644
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
-- 
2.43.0


