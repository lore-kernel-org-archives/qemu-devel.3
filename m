Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BE7EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmx-0008Fw-3D; Wed, 11 Sep 2024 22:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZmC-0003vm-Ci
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm9-0004Ga-Sj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2055136b612so6918215ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108900; x=1726713700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOuzW0tNZ2wOKd58SrIScG+q8wv9fT6ynMl2PosowdE=;
 b=h1KFR61+szUfo+9TPPOcuSI3qFEh4kVycqP1WZ7/EtzifVIDp/Ph8U0BafCKUFg617
 a3VJoiSXuD4hGBl7H88lyo8wXU74DJT0VdZppR9Q1Fs/loJ9gn/a84EEDUAkXlN+4HJ+
 /jH9+cIBFKXz0EHwG7FnJ9CiuLz1sXL2G16nvV2nZFC3qt2J/9gNuA2mt3E7o74BfRSx
 QK/QGgQXt4VWh50IWuMhc7uA/MRpx6UsMWT/SMxFOA2URzmVOLKsIFOKjPlbD4wKUh2c
 w+efWWs9J9ExVCNEHE7C3jG4rUuHyMoZ8GmvVrnjoCs0AWWe4cOUuA6K1/6NnOikB0gL
 2K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108900; x=1726713700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOuzW0tNZ2wOKd58SrIScG+q8wv9fT6ynMl2PosowdE=;
 b=pIPj5tL0tPQybTiWV8g1E/2CFaZQkPepiVFwcks6/3j26S/pI3DHhshoq0e7lti2Lb
 XwnSD8alqjW4+wGl9bMcrYlfU8EcZ/IimqPIMNmyBocfKAJidLkx0LB1riZ8BHw8FpbD
 2hdnhnSg9ETEgpMwuvaBDvEJVNKRmHgwhdXo9zTekrPprqcX+mnbaTZOA/FIwhcs3fOh
 rC6OtfrYRQDhhtRMeFFfkrgxfg4oKp8EJ0D6AEVkhBky7Ufyo3f0/ZqOoY6ewMarK4YS
 IPKibAJCIoU2wGYHeYhestQaUqogFUQnTxTR0ugTuZ9jmr2LZ3ewlV5oQ5nPyA8Pemy3
 qx5g==
X-Gm-Message-State: AOJu0YzcOwTLjRswPVsTCbAwVcz2pn4hg6OddoF61ZSIbE58OXPlHXJw
 UuS6JFM/LwFCW1rPDP6W827ho+sVXJdhhgXJkwBPK1JmXD1LUttLqLcrtfO9AqlGdhabZxdbqBk
 S
X-Google-Smtp-Source: AGHT+IE77ZHk8AsNT8fSx4MSjuVEJoXmvUqI2KW8L6QTNY31RNy8PPde3aXC7dWoFFFvzGE0u+BKCg==
X-Received: by 2002:a17:902:dac1:b0:202:19a0:fcba with SMTP id
 d9443c01a7336-2076e3f51femr23378805ad.41.1726108900501; 
 Wed, 11 Sep 2024 19:41:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 27/29] target/arm: Convert SQSHL, UQSHL,
 SQSHLU (immediate) to decodetree
Date: Wed, 11 Sep 2024 19:41:12 -0700
Message-ID: <20240912024114.1097832-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 223 ++++++++++++++-------------------
 target/arm/tcg/a64.decode      |  36 +++++-
 2 files changed, 128 insertions(+), 131 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7918720d9b..77324e0145 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6982,6 +6982,9 @@ TRANS(URSRA_v, do_vec_shift_imm, a, gen_gvec_ursra)
 TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
 TRANS(SHL_v, do_vec_shift_imm, a, tcg_gen_gvec_shli)
 TRANS(SLI_v, do_vec_shift_imm, a, gen_gvec_sli);
+TRANS(SQSHL_vi, do_vec_shift_imm, a, gen_neon_sqshli)
+TRANS(UQSHL_vi, do_vec_shift_imm, a, gen_neon_uqshli)
+TRANS(SQSHLU_vi, do_vec_shift_imm, a, gen_neon_sqshlui)
 
 static bool do_vec_shift_imm_wide(DisasContext *s, arg_qrri_e *a, bool is_u)
 {
@@ -7209,6 +7212,92 @@ TRANS(SRI_s, do_scalar_shift_imm, a, gen_sri_d, true, 0)
 TRANS(SHL_s, do_scalar_shift_imm, a, tcg_gen_shli_i64, false, 0)
 TRANS(SLI_s, do_scalar_shift_imm, a, gen_sli_d, true, 0)
 
+static void trunc_i64_env_imm(TCGv_i64 d, TCGv_i64 s, int64_t i,
+                              NeonGenTwoOpEnvFn *fn)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(t, s);
+    fn(t, tcg_env, t, tcg_constant_i32(i));
+    tcg_gen_extu_i32_i64(d, t);
+}
+
+static void gen_sqshli_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshl_s8);
+}
+
+static void gen_sqshli_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshl_s16);
+}
+
+static void gen_sqshli_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshl_s32);
+}
+
+static void gen_sqshli_d(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_helper_neon_qshl_s64(d, tcg_env, s, tcg_constant_i64(i));
+}
+
+static void gen_uqshli_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshl_u8);
+}
+
+static void gen_uqshli_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshl_u16);
+}
+
+static void gen_uqshli_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshl_u32);
+}
+
+static void gen_uqshli_d(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_helper_neon_qshl_u64(d, tcg_env, s, tcg_constant_i64(i));
+}
+
+static void gen_sqshlui_b(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshlu_s8);
+}
+
+static void gen_sqshlui_h(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshlu_s16);
+}
+
+static void gen_sqshlui_s(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    trunc_i64_env_imm(d, s, i, gen_helper_neon_qshlu_s32);
+}
+
+static void gen_sqshlui_d(TCGv_i64 d, TCGv_i64 s, int64_t i)
+{
+    gen_helper_neon_qshlu_s64(d, tcg_env, s, tcg_constant_i64(i));
+}
+
+static WideShiftImmFn * const f_scalar_sqshli[] = {
+    gen_sqshli_b, gen_sqshli_h, gen_sqshli_s, gen_sqshli_d
+};
+
+static WideShiftImmFn * const f_scalar_uqshli[] = {
+    gen_uqshli_b, gen_uqshli_h, gen_uqshli_s, gen_uqshli_d
+};
+
+static WideShiftImmFn * const f_scalar_sqshlui[] = {
+    gen_sqshlui_b, gen_sqshlui_h, gen_sqshlui_s, gen_sqshlui_d
+};
+
+/* Note that the helpers sign-extend their inputs, so don't do it here. */
+TRANS(SQSHL_si, do_scalar_shift_imm, a, f_scalar_sqshli[a->esz], false, 0)
+TRANS(UQSHL_si, do_scalar_shift_imm, a, f_scalar_uqshli[a->esz], false, 0)
+TRANS(SQSHLU_si, do_scalar_shift_imm, a, f_scalar_sqshlui[a->esz], false, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9501,116 +9590,6 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
     clear_vec_high(s, is_q, rd);
 }
 
-/* SQSHLU, UQSHL, SQSHL: saturating left shifts */
-static void handle_simd_qshl(DisasContext *s, bool scalar, bool is_q,
-                             bool src_unsigned, bool dst_unsigned,
-                             int immh, int immb, int rn, int rd)
-{
-    int immhb = immh << 3 | immb;
-    int size = 32 - clz32(immh) - 1;
-    int shift = immhb - (8 << size);
-    int pass;
-
-    assert(immh != 0);
-    assert(!(scalar && is_q));
-
-    if (!scalar) {
-        if (!is_q && extract32(immh, 3, 1)) {
-            unallocated_encoding(s);
-            return;
-        }
-
-        /* Since we use the variable-shift helpers we must
-         * replicate the shift count into each element of
-         * the tcg_shift value.
-         */
-        switch (size) {
-        case 0:
-            shift |= shift << 8;
-            /* fall through */
-        case 1:
-            shift |= shift << 16;
-            break;
-        case 2:
-        case 3:
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 3) {
-        TCGv_i64 tcg_shift = tcg_constant_i64(shift);
-        static NeonGenTwo64OpEnvFn * const fns[2][2] = {
-            { gen_helper_neon_qshl_s64, gen_helper_neon_qshlu_s64 },
-            { NULL, gen_helper_neon_qshl_u64 },
-        };
-        NeonGenTwo64OpEnvFn *genfn = fns[src_unsigned][dst_unsigned];
-        int maxpass = is_q ? 2 : 1;
-
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i64 tcg_op = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-            genfn(tcg_op, tcg_env, tcg_op, tcg_shift);
-            write_vec_element(s, tcg_op, rd, pass, MO_64);
-        }
-        clear_vec_high(s, is_q, rd);
-    } else {
-        TCGv_i32 tcg_shift = tcg_constant_i32(shift);
-        static NeonGenTwoOpEnvFn * const fns[2][2][3] = {
-            {
-                { gen_helper_neon_qshl_s8,
-                  gen_helper_neon_qshl_s16,
-                  gen_helper_neon_qshl_s32 },
-                { gen_helper_neon_qshlu_s8,
-                  gen_helper_neon_qshlu_s16,
-                  gen_helper_neon_qshlu_s32 }
-            }, {
-                { NULL, NULL, NULL },
-                { gen_helper_neon_qshl_u8,
-                  gen_helper_neon_qshl_u16,
-                  gen_helper_neon_qshl_u32 }
-            }
-        };
-        NeonGenTwoOpEnvFn *genfn = fns[src_unsigned][dst_unsigned][size];
-        MemOp memop = scalar ? size : MO_32;
-        int maxpass = scalar ? 1 : is_q ? 4 : 2;
-
-        for (pass = 0; pass < maxpass; pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op, rn, pass, memop);
-            genfn(tcg_op, tcg_env, tcg_op, tcg_shift);
-            if (scalar) {
-                switch (size) {
-                case 0:
-                    tcg_gen_ext8u_i32(tcg_op, tcg_op);
-                    break;
-                case 1:
-                    tcg_gen_ext16u_i32(tcg_op, tcg_op);
-                    break;
-                case 2:
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                write_fp_sreg(s, rd, tcg_op);
-            } else {
-                write_vec_element_i32(s, tcg_op, rd, pass, MO_32);
-            }
-        }
-
-        if (!scalar) {
-            clear_vec_high(s, is_q, rd);
-        }
-    }
-}
-
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9890,16 +9869,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
         handle_vec_simd_sqshrn(s, true, false, is_u, is_u,
                                immh, immb, opcode, rn, rd);
         break;
-    case 0xc: /* SQSHLU */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        handle_simd_qshl(s, true, false, false, true, immh, immb, rn, rd);
-        break;
-    case 0xe: /* SQSHL, UQSHL */
-        handle_simd_qshl(s, true, false, is_u, is_u, immh, immb, rn, rd);
-        break;
     case 0x1f: /* FCVTZS, FCVTZU */
         handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
         break;
@@ -9910,6 +9879,8 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x06: /* SRSRA / URSRA */
     case 0x08: /* SRI */
     case 0x0a: /* SHL / SLI */
+    case 0x0c: /* SQSHLU */
+    case 0x0e: /* SQSHL, UQSHL */
         unallocated_encoding(s);
         break;
     }
@@ -10561,16 +10532,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_intfp_conv(s, false, is_q, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
-    case 0xc: /* SQSHLU */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        handle_simd_qshl(s, false, is_q, false, true, immh, immb, rn, rd);
-        break;
-    case 0xe: /* SQSHL, UQSHL */
-        handle_simd_qshl(s, false, is_q, is_u, is_u, immh, immb, rn, rd);
-        break;
     case 0x1f: /* FCVTZS/ FCVTZU */
         handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
         return;
@@ -10581,6 +10542,8 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
     case 0x08: /* SRI */
     case 0x0a: /* SHL / SLI */
+    case 0x0c: /* SQSHLU */
+    case 0x0e: /* SQSHL, UQSHL */
     case 0x14: /* SSHLL / USHLL */
         unallocated_encoding(s);
         return;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 96803fe6e4..63e04ddfcd 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1287,11 +1287,30 @@ RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_b
 RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_h
 RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
 
+SQSHL_vi        0.00 11110 .... ... 01110 1 ..... .....     @q_shli_b
+SQSHL_vi        0.00 11110 .... ... 01110 1 ..... .....     @q_shli_h
+SQSHL_vi        0.00 11110 .... ... 01110 1 ..... .....     @q_shli_s
+SQSHL_vi        0.00 11110 .... ... 01110 1 ..... .....     @q_shli_d
+
+UQSHL_vi        0.10 11110 .... ... 01110 1 ..... .....     @q_shli_b
+UQSHL_vi        0.10 11110 .... ... 01110 1 ..... .....     @q_shli_h
+UQSHL_vi        0.10 11110 .... ... 01110 1 ..... .....     @q_shli_s
+UQSHL_vi        0.10 11110 .... ... 01110 1 ..... .....     @q_shli_d
+
+SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_b
+SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_h
+SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_s
+SQSHLU_vi       0.10 11110 .... ... 01100 1 ..... .....     @q_shli_d
+
 # Advanced SIMD scalar shift by immediate
 
 @shri_d         .... ..... 1 ...... ..... . rn:5 rd:5   \
                 &rri_e esz=3 imm=%neon_rshift_i6
-@shli_d         .... ..... 1 imm:6  ..... . rn:5 rd:5   &rri_e esz=3 
+
+@shli_b         .... ..... 0001 imm:3  ..... . rn:5 rd:5    &rri_e esz=0
+@shli_h         .... ..... 001  imm:4  ..... . rn:5 rd:5    &rri_e esz=1
+@shli_s         .... ..... 01   imm:5  ..... . rn:5 rd:5    &rri_e esz=2
+@shli_d         .... ..... 1    imm:6  ..... . rn:5 rd:5    &rri_e esz=3
 
 SSHR_s          0101 11110 .... ... 00000 1 ..... .....     @shri_d
 USHR_s          0111 11110 .... ... 00000 1 ..... .....     @shri_d
@@ -1305,3 +1324,18 @@ SRI_s           0111 11110 .... ... 01000 1 ..... .....     @shri_d
 
 SHL_s           0101 11110 .... ... 01010 1 ..... .....     @shli_d
 SLI_s           0111 11110 .... ... 01010 1 ..... .....     @shli_d
+
+SQSHL_si        0101 11110 .... ... 01110 1 ..... .....     @shli_b
+SQSHL_si        0101 11110 .... ... 01110 1 ..... .....     @shli_h
+SQSHL_si        0101 11110 .... ... 01110 1 ..... .....     @shli_s
+SQSHL_si        0101 11110 .... ... 01110 1 ..... .....     @shli_d
+
+UQSHL_si        0111 11110 .... ... 01110 1 ..... .....     @shli_b
+UQSHL_si        0111 11110 .... ... 01110 1 ..... .....     @shli_h
+UQSHL_si        0111 11110 .... ... 01110 1 ..... .....     @shli_s
+UQSHL_si        0111 11110 .... ... 01110 1 ..... .....     @shli_d
+
+SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_b
+SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_h
+SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_s
+SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_d
-- 
2.43.0


