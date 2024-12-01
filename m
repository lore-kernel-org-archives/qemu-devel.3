Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DD3D49775
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbl-0005CT-PA; Sun, 01 Dec 2024 10:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaZ-00006A-2o
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:23 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaV-0005Hr-Io
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:22 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71d40fdde2fso1097865a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065818; x=1733670618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm4PPwN43zI/81mihQM/YiAqHFi2Rv5PbNhvEtT5wyY=;
 b=gCvZXK4YGvZeko/eoIZbxG2E2ALdSgiuMXPbMo9FW2HUbOUeqysObHa9TP5XQp9HHH
 U+34NP5tQLkdl7JL8N5xqE+N8X213kOvhcekFIwzItZaxCLABLoE4VHjGuPo6Afimedc
 WTulNcKriPPaM0+iq+CmNKvwSaHNXyHRLT1MLBFLwUdxCbUV94vou0VALwJc86Yv+vT0
 Tf8DHMRROBJ6buxxgB1Vxpnw0ETlmDO7hW/NEDzL9WLdbItGY8Ux/sazt4SZOYywiZ/V
 Fsnv5/bH64lBHZC8R2qT9bf/y1Y50N49BHH6iBPpNONRnfP1ShA7h9q8bBsrOPQXOYQY
 vIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065818; x=1733670618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rm4PPwN43zI/81mihQM/YiAqHFi2Rv5PbNhvEtT5wyY=;
 b=gXGltC49ud9MZSxn3tw72wGaHYYHp8buKdOxB8rUhbi+wP6OzN8DFx0qhdYy9RFHst
 ScECZ54tI0YbJBNqsDomzEpVUMlD+7uWWkbsL21HqKbNdTrhT7Ez3/ExhAbXvf5FiCLn
 LpTS9H39LBiWiU5I4rBjheLTZJ6f4lV+mf2wzgSaYZoyLFmSJm4dt4gfQy+9geCCCaWB
 em2ghD9EVghTgUzROsokN2020bbeeL65YGCn9MPSJ+Glo17gjfFRhFGE0Orw89Cte7Sr
 q7mmMOgopTqAX6btYHhxyE3ziXcmxwOq78oXMEz5uskH8HWXQqe6HCE8rkqEQ+2Y67rO
 n5VA==
X-Gm-Message-State: AOJu0YwpJHG6965AjJY9xTje3UkZkodS7wcwtgrJDZubLqRJ6IDCa/dV
 KaQx3ca1NDk9VNBria1fJa/6Cx0LssLPXA1CkumB0n5U1IZoA+pB06tVGR0FFbhcnpgzWxHrWOd
 azx4=
X-Gm-Gg: ASbGncuD2w+Ej+qUUoLOknrDRA2TysuN3Zv7VhCqYzOOMTYhO70J1D6+14UGwgFMmsJ
 i0/FYjr3DJcUXc9BExpALQKLaYBOAifQPloI37AAG2vJT4Yrt4VV2mc6pDx1B9rNZbCPwfcfdFp
 mNwGxFBv+h1bVj717qSF7nYswn9klX5wNfHu4E0nii1bEAHqzbcTz7U8/Wb1HwUa2uFum+xfdBu
 ghxi+7MaiW/aMUfXbt0eMbScnJ5jroISvhETqoGIji2A/LKp/GtbOy+T1ncDM2Ryl24mbs4FFGs
 1g4r09oK0N3ZFXBUQNUo/AZs3WZNSgHX/z5c
X-Google-Smtp-Source: AGHT+IG3C44yPrkUffXlNcJ4X4aq+B/QLkCBAZ+E0Kb9sMgExOnPM6eSWWVLGdatfTXzJSu1P0O0Gw==
X-Received: by 2002:a05:6830:4117:b0:71a:4b13:c561 with SMTP id
 46e09a7af769-71d65cacd81mr16848906a34.16.1733065818337; 
 Sun, 01 Dec 2024 07:10:18 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 61/67] target/arm: Convert FCVTZ[SU] (vector,
 fixed-point) to decodetree
Date: Sun,  1 Dec 2024 09:06:00 -0600
Message-ID: <20241201150607.12812-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Remove handle_simd_shift_fpint_conv and disas_simd_shift_imm
as these were the last insns decoded by those functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   4 +
 target/arm/tcg/translate-a64.c | 160 +++------------------------------
 target/arm/tcg/vec_helper.c    |   2 +
 target/arm/vfp_helper.c        |   4 +
 target/arm/tcg/a64.decode      |   8 ++
 5 files changed, 32 insertions(+), 146 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b227ac54d9..0c8a56c3ae 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -178,8 +178,10 @@ DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosqd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touqd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
 DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
 DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
@@ -660,6 +662,8 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_vcvt_sd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_ud, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_ds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 26ae38b99e..f49c86a114 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9344,107 +9344,21 @@ TRANS(UCVTF_vi, do_gvec_op2_fpst,
 TRANS(UCVTF_vf, do_gvec_op2_fpst,
       a->esz, a->q, a->rd, a->rn, a->shift, f_ucvtf_v)
 
-/* FCVTZS, FVCVTZU - FP to fixedpoint conversion */
-static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
-                                         bool is_q, bool is_u,
-                                         int immh, int immb, int rn, int rd)
-{
-    int immhb = immh << 3 | immb;
-    int pass, size, fracbits;
-    TCGv_ptr tcg_fpstatus;
-    TCGv_i32 tcg_rmode, tcg_shift;
+static gen_helper_gvec_2_ptr * const f_fcvtzs_vf[] = {
+    gen_helper_gvec_vcvt_rz_hs,
+    gen_helper_gvec_vcvt_rz_fs,
+    gen_helper_gvec_vcvt_rz_ds,
+};
+TRANS(FCVTZS_vf, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, a->shift, f_fcvtzs_vf)
 
-    if (immh & 0x8) {
-        size = MO_64;
-        if (!is_scalar && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-    } else if (immh & 0x4) {
-        size = MO_32;
-    } else if (immh & 0x2) {
-        size = MO_16;
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-    } else {
-        /* Should have split out AdvSIMD modified immediate earlier.  */
-        assert(immh == 1);
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    assert(!(is_scalar && is_q));
-
-    tcg_fpstatus = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
-    tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, tcg_fpstatus);
-    fracbits = (16 << size) - immhb;
-    tcg_shift = tcg_constant_i32(fracbits);
-
-    if (size == MO_64) {
-        int maxpass = is_scalar ? 1 : 2;
-
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i64 tcg_op = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-            if (is_u) {
-                gen_helper_vfp_touqd(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
-            } else {
-                gen_helper_vfp_tosqd(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
-            }
-            write_vec_element(s, tcg_op, rd, pass, MO_64);
-        }
-        clear_vec_high(s, is_q, rd);
-    } else {
-        void (*fn)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
-        int maxpass = is_scalar ? 1 : ((8 << is_q) >> size);
-
-        switch (size) {
-        case MO_16:
-            if (is_u) {
-                fn = gen_helper_vfp_touhh;
-            } else {
-                fn = gen_helper_vfp_toshh;
-            }
-            break;
-        case MO_32:
-            if (is_u) {
-                fn = gen_helper_vfp_touls;
-            } else {
-                fn = gen_helper_vfp_tosls;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op, rn, pass, size);
-            fn(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
-            if (is_scalar) {
-                if (size == MO_16 && !is_u) {
-                    tcg_gen_ext16u_i32(tcg_op, tcg_op);
-                }
-                write_fp_sreg(s, rd, tcg_op);
-            } else {
-                write_vec_element_i32(s, tcg_op, rd, pass, size);
-            }
-        }
-        if (!is_scalar) {
-            clear_vec_high(s, is_q, rd);
-        }
-    }
-
-    gen_restore_rmode(tcg_rmode, tcg_fpstatus);
-}
+static gen_helper_gvec_2_ptr * const f_fcvtzu_vf[] = {
+    gen_helper_gvec_vcvt_rz_hu,
+    gen_helper_gvec_vcvt_rz_fu,
+    gen_helper_gvec_vcvt_rz_du,
+};
+TRANS(FCVTZU_vf, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, a->shift, f_fcvtzu_vf)
 
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
@@ -9771,51 +9685,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     g_assert_not_reached();
 }
 
-/* AdvSIMD shift by immediate
- *  31  30   29 28         23 22  19 18  16 15    11  10 9    5 4    0
- * +---+---+---+-------------+------+------+--------+---+------+------+
- * | 0 | Q | U | 0 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
- * +---+---+---+-------------+------+------+--------+---+------+------+
- */
-static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 5);
-    int immb = extract32(insn, 16, 3);
-    int immh = extract32(insn, 19, 4);
-    bool is_u = extract32(insn, 29, 1);
-    bool is_q = extract32(insn, 30, 1);
-
-    if (immh == 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (opcode) {
-    case 0x1f: /* FCVTZS/ FCVTZU */
-        handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
-        return;
-    default:
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA (accumulate) */
-    case 0x04: /* SRSHR / URSHR (rounding) */
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-    case 0x08: /* SRI */
-    case 0x0a: /* SHL / SLI */
-    case 0x0c: /* SQSHLU */
-    case 0x0e: /* SQSHL, UQSHL */
-    case 0x10: /* SHRN / SQSHRUN */
-    case 0x11: /* RSHRN / SQRSHRUN */
-    case 0x12: /* SQSHRN / UQSHRN */
-    case 0x13: /* SQRSHRN / UQRSHRN */
-    case 0x14: /* SSHLL / USHLL */
-    case 0x1c: /* SCVTF / UCVTF */
-        unallocated_encoding(s);
-        return;
-    }
-}
-
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -10312,7 +10181,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
     { 0x00000000, 0x00000000, NULL }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index aa85cea0ca..9b269a4f18 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2512,6 +2512,8 @@ DO_VCVT_FIXED(gvec_vcvt_uf, helper_vfp_ultos, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_sh, helper_vfp_shtoh, uint16_t)
 DO_VCVT_FIXED(gvec_vcvt_uh, helper_vfp_uhtoh, uint16_t)
 
+DO_VCVT_FIXED(gvec_vcvt_rz_ds, helper_vfp_tosqd_round_to_zero, uint64_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_du, helper_vfp_touqd_round_to_zero, uint64_t)
 DO_VCVT_FIXED(gvec_vcvt_rz_fs, helper_vfp_tosls_round_to_zero, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_rz_fu, helper_vfp_touls_round_to_zero, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_rz_hs, helper_vfp_toshh_round_to_zero, uint16_t)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index f24992c798..5a19af509c 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -495,6 +495,10 @@ VFP_CONV_FIX_A64(sq, h, 16, dh_ctype_f16, 64, int64)
 VFP_CONV_FIX(uh, h, 16, dh_ctype_f16, 32, uint16)
 VFP_CONV_FIX(ul, h, 16, dh_ctype_f16, 32, uint32)
 VFP_CONV_FIX_A64(uq, h, 16, dh_ctype_f16, 64, uint64)
+VFP_CONV_FLOAT_FIX_ROUND(sq, d, 64, float64, 64, int64,
+                         float_round_to_zero, _round_to_zero)
+VFP_CONV_FLOAT_FIX_ROUND(uq, d, 64, float64, 64, uint64,
+                         float_round_to_zero, _round_to_zero)
 
 #undef VFP_CONV_FIX
 #undef VFP_CONV_FIX_FLOAT
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bb94374f22..ea838ad04f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1808,3 +1808,11 @@ SCVTF_vf        0.00 11110 ....... 111001 ..... .....       @fcvtq_d
 UCVTF_vf        0.10 11110 ....... 111001 ..... .....       @fcvtq_h
 UCVTF_vf        0.10 11110 ....... 111001 ..... .....       @fcvtq_s
 UCVTF_vf        0.10 11110 ....... 111001 ..... .....       @fcvtq_d
+
+FCVTZS_vf       0.00 11110 ....... 111111 ..... .....       @fcvtq_h
+FCVTZS_vf       0.00 11110 ....... 111111 ..... .....       @fcvtq_s
+FCVTZS_vf       0.00 11110 ....... 111111 ..... .....       @fcvtq_d
+
+FCVTZU_vf       0.10 11110 ....... 111111 ..... .....       @fcvtq_h
+FCVTZU_vf       0.10 11110 ....... 111111 ..... .....       @fcvtq_s
+FCVTZU_vf       0.10 11110 ....... 111111 ..... .....       @fcvtq_d
-- 
2.43.0


