Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA37AE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33G-0002Kt-SV; Tue, 10 Dec 2024 11:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32j-0000PJ-6J
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:25:01 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32g-0007dy-9A
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:25:00 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30229d5b21cso16506281fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847896; x=1734452696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vL0IkRbzyzTmgSkob8iw7n8NRX8uGpW6FN24HKKb4W8=;
 b=Vf9zaAWzS/0AWnlSKC/Lec6ffcU/HraDgzbVErHS7r2FbTvyGAUs36Z2zwAZ3Z8mKx
 kvFMCt4SDRJfYRzWfPREdORM93ITpGzajVP5nVvJbQIcID5nb37fK/b44+tjvlEUvgVR
 Wx9dzTLNCjJ2o4nmUYTLJG4n5e+UEPZrjxT2zcMJ5eEOkp3fHk1UugbC269K85PCNECS
 Vc7bFjiziM7XaubrFz44b2ie0kGd4uXDJy7B0ZXRWa343G8sCYf1yNhbjxVEyT5dqdq5
 tXaJWoOPQUsP8wuzqZ/fagVADCpeIc7TnREWLyedz27asfxZFW7EeFcLLcSGRXGM6Tu4
 4vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847896; x=1734452696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vL0IkRbzyzTmgSkob8iw7n8NRX8uGpW6FN24HKKb4W8=;
 b=mH4kaAr4EVZ8FOuD/D8ZDs3gEYUcfoRyRGJ5SfNxBZDzGunROIO8uRlnKhf+zHs8zi
 qDP5jW4Yca2dbrmUGOyP4nyq9B6SDMuOehUg5rSmwR5KuvvE7DUwI0QZ/7Q87NxgFf55
 ucZRgGFvXfhzkvBgA+LtNxJXGJVASjlp4vAHn6ZZQfU4WHJHvwbXapFx5GxooXwkBI6L
 m4bRUFDRiln0a0CqAj8z6xQ2IpPMURT6bjeljikyrAaq0kd0W3VHRGWZzbvcN7pckEMj
 ozW8DspK46Y+1qU4tXtmgkazV5SLv1+bGqYP5VgF0sjXi68/fDn1R0324YGXTVvmCzex
 Jjfw==
X-Gm-Message-State: AOJu0YzaWZ+63w2iKXl9tTSh1c2J3azfRipIjqXbVDjVlyT4FsWzcU7N
 JA8yh+6V8f2tmw+ON/6xXAithKa1+GufLgbbiSYWXJDXfdqzRd1ia5Q3iIYms6fEK5QfloRhPsu
 PkUZfzOKh
X-Gm-Gg: ASbGncuHS1uhMfz+HdRkSaUS8zNS6CiqxtHSk4PzgudJzjGLGOuaEdQ26/0Ltcw4JUd
 h96M8qxCxCHBxub5hhQAzfWvNjdez6ORiKEIkCITmg1NY84v0O19D0V1FX4TPYWscq9ORRwO/rC
 SlRYI5en3rInPuDohnQ7nmhj5dfihpgfzBz8OeTOxhATgDKlvGciC4L95HSTkC/q6TH61aZyhXw
 sy5UDCxLl/vZrMDTlO3kI8I8iDdzbMhDCA3lLwFyHtelTDhWtwn8gza9xo=
X-Google-Smtp-Source: AGHT+IFxD2ZJGvLNUKSfs9nkyYbE+MfAI/+vqVHXXTBJYCSDrB48rmdfac2yDA4CCCKp1G48Ia+BxQ==
X-Received: by 2002:a05:6512:108c:b0:540:1a33:ded8 with SMTP id
 2adb3069b0e04-540240c04fcmr2140661e87.17.1733847895895; 
 Tue, 10 Dec 2024 08:24:55 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 63/69] target/arm: Convert FCVTZ[SU] (vector,
 fixed-point) to decodetree
Date: Tue, 10 Dec 2024 10:17:27 -0600
Message-ID: <20241210161733.1830573-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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
index 0f94fa4fdc..1c4e53770b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9332,107 +9332,21 @@ TRANS(UCVTF_vi, do_gvec_op2_fpst,
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
@@ -9759,51 +9673,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10299,7 +10168,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
index 4f832e7a4c..61d519b96a 100644
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


