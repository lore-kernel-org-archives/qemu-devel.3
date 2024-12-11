Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFFBE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPia-0005iN-8w; Wed, 11 Dec 2024 11:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPi6-0002ka-5k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:15 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPi3-0002Q5-AS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:13 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8adbda583so77413596d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733935030; x=1734539830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgMoUG1TjCgvuCMS0XzFgGW8rdp5HC+s8kCN2kuLaCY=;
 b=tcB8k/QRM3I+w4R3hIFKnpRJPBFM4Rlixvb03btL6fIDLNOPh9IQ5dyQRIc/nGrIhw
 rRnOXL+oEpZMGzsQlswNI7/IUSJOtVywgFb5WyhSD4loOqWoEnrOoC2qcOUf+vhVx6iT
 eUuSKLgEVQABGyag1dXEfls8XT+Ly+BY6CgRy2yz+ELd07Inexr6/nN+RPD00ulYDOlM
 CEykS0CEezM538opyRrRzr61xEp6qLc5F1PXP4hIGp+RIgsOUN4nRq6HjpkoaJv4xHJD
 EuccsWMrIpBqw+6+a6O8zrJayeJ1eO2za3aopLdW8Z4K4A/dTqs0FGiGAdFNVMBpsmRp
 LRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733935030; x=1734539830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgMoUG1TjCgvuCMS0XzFgGW8rdp5HC+s8kCN2kuLaCY=;
 b=nzwpfycAcZy0os9tXLrLaHRhxz9BofusvRcCfbn9WWbfzR5zEym+hBK33G93oOsE+R
 qXLyNv+2+zw7R6Kd9r6tGppfnbb3M00ohvo6lmdtV+whO3APSQVGlw6DteHHp+o5C0ti
 1nMuccnYx12xgYdcHXhy2iqyKiY9yCUeeYZibZynPV8d5f2F5L5LjVJpBpzO+Zz5xMna
 osPyqrN8PqdGYJAyngb2NNi89IitjR1QqV0kfMh5JyJbi+dJvnyIi/hSFcLxgY0iEFUI
 AhLMYPzLmsqC6c5tcpoxXYXcv1K0MaGMjno0i7XBehxgC1PLhnhUzphFqgD2IejgZjDr
 V53w==
X-Gm-Message-State: AOJu0YwptPurT6ZKBtnM+Uoi5hWNz8RHkoAVlHddPFM7FePPWBxb1KIi
 u1YVwWyVnS/E2RK+ZocAbpEyEdfhjjm/k902Sk8CakoEop4lvj0dS6l/Tu7RnrvM2GHG3vaq0nu
 j9zg8Fl5D
X-Gm-Gg: ASbGncvgj/MEsqhH5mYZ7D2OtbDYXmPWUQDDXjW7ZmyT1BHfsptxv3+3YsC3JxIapZJ
 BjnNoKk6iaHiOUAz2JsY1uCxVo8/LaB+yUJzcJ2SzVbZ1OVhRzDDATBpGvkxpOpU2oO5Fef4Mio
 6Ok0rgdUXhVHtNE1ywXTW5PUlKOusr5V1fXrViQNN5zuTqLtILL6whip7fNug58HS9G1yKde6eR
 5Z3cu5g1SFA48UY77gUlECfqZXYRIffjAb64LHPjqGHiFiMEGfTFNzoBD+vvw==
X-Google-Smtp-Source: AGHT+IH3T37nNUpxnuJ7c5oLQ51LPWpIJ2pQJZ2CXtR3/XSu5NB45UI71JqNcUXDsYqY6GBxKPVo3Q==
X-Received: by 2002:a05:6214:2684:b0:6d8:821d:736e with SMTP id
 6a1803df08f44-6d934be4f1cmr55457646d6.36.1733935030131; 
 Wed, 11 Dec 2024 08:37:10 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:37:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 69/69] target/arm: Convert FCVTL to decodetree
Date: Wed, 11 Dec 2024 10:30:36 -0600
Message-ID: <20241211163036.2297116-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf31.google.com
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

Remove lookup_disas_fn, handle_2misc_widening,
disas_simd_two_reg_misc, disas_data_proc_simd,
disas_data_proc_simd_fp, disas_a64_legacy, as
this is the final insn to be converted.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 202 +++------------------------------
 target/arm/tcg/a64.decode      |   2 +
 2 files changed, 18 insertions(+), 186 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fa3170da86..3e57b98c27 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1465,31 +1465,6 @@ static inline void gen_check_sp_alignment(DisasContext *s)
      */
 }
 
-/*
- * This provides a simple table based table lookup decoder. It is
- * intended to be used when the relevant bits for decode are too
- * awkwardly placed and switch/if based logic would be confusing and
- * deeply nested. Since it's a linear search through the table, tables
- * should be kept small.
- *
- * It returns the first handler where insn & mask == pattern, or
- * NULL if there is no match.
- * The table is terminated by an empty mask (i.e. 0)
- */
-static inline AArch64DecodeFn *lookup_disas_fn(const AArch64DecodeTable *table,
-                                               uint32_t insn)
-{
-    const AArch64DecodeTable *tptr = table;
-
-    while (tptr->mask) {
-        if ((insn & tptr->mask) == tptr->pattern) {
-            return tptr->disas_fn;
-        }
-        tptr++;
-    }
-    return NULL;
-}
-
 /*
  * The instruction disassembly implemented here matches
  * the instruction encoding classifications in chapter C4
@@ -9508,8 +9483,7 @@ static gen_helper_gvec_2_ptr * const f_frsqrte[] = {
 };
 TRANS(FRSQRTE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
 
-static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
-                                  int size, int rn, int rd)
+static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
 {
     /* Handle 2-reg-misc ops which are widening (so each size element
      * in the source becomes a 2*size element in the destination.
@@ -9517,173 +9491,43 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
      */
     int pass;
 
-    if (size == 3) {
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    if (a->esz == MO_64) {
         /* 32 -> 64 bit fp conversion */
         TCGv_i64 tcg_res[2];
-        int srcelt = is_q ? 2 : 0;
+        TCGv_i32 tcg_op = tcg_temp_new_i32();
+        int srcelt = a->q ? 2 : 0;
 
         for (pass = 0; pass < 2; pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
             tcg_res[pass] = tcg_temp_new_i64();
-
-            read_vec_element_i32(s, tcg_op, rn, srcelt + pass, MO_32);
+            read_vec_element_i32(s, tcg_op, a->rn, srcelt + pass, MO_32);
             gen_helper_vfp_fcvtds(tcg_res[pass], tcg_op, tcg_env);
         }
         for (pass = 0; pass < 2; pass++) {
-            write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
+            write_vec_element(s, tcg_res[pass], a->rd, pass, MO_64);
         }
     } else {
         /* 16 -> 32 bit fp conversion */
-        int srcelt = is_q ? 4 : 0;
+        int srcelt = a->q ? 4 : 0;
         TCGv_i32 tcg_res[4];
         TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
         TCGv_i32 ahp = get_ahp_flag();
 
         for (pass = 0; pass < 4; pass++) {
             tcg_res[pass] = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_res[pass], rn, srcelt + pass, MO_16);
+            read_vec_element_i32(s, tcg_res[pass], a->rn, srcelt + pass, MO_16);
             gen_helper_vfp_fcvt_f16_to_f32(tcg_res[pass], tcg_res[pass],
                                            fpst, ahp);
         }
         for (pass = 0; pass < 4; pass++) {
-            write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
+            write_vec_element_i32(s, tcg_res[pass], a->rd, pass, MO_32);
         }
     }
-}
-
-/* AdvSIMD two reg misc
- *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
- * +---+---+---+-----------+------+-----------+--------+-----+------+------+
- * | 0 | Q | U | 0 1 1 1 0 | size | 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+-----------+--------+-----+------+------+
- */
-static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
-{
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    bool u = extract32(insn, 29, 1);
-    bool is_q = extract32(insn, 30, 1);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    switch (opcode) {
-    case 0xc ... 0xf:
-    case 0x16 ... 0x1f:
-    {
-        /* Floating point: U, size[1] and opcode indicate operation;
-         * size[0] indicates single or double precision.
-         */
-        int is_double = extract32(size, 0, 1);
-        opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
-        size = is_double ? 3 : 2;
-        switch (opcode) {
-        case 0x17: /* FCVTL, FCVTL2 */
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_widening(s, opcode, is_q, size, rn, rd);
-            return;
-        default:
-        case 0x16: /* FCVTN, FCVTN2 */
-        case 0x36: /* BFCVTN, BFCVTN2 */
-        case 0x56: /* FCVTXN, FCVTXN2 */
-        case 0x2f: /* FABS */
-        case 0x6f: /* FNEG */
-        case 0x7f: /* FSQRT */
-        case 0x18: /* FRINTN */
-        case 0x19: /* FRINTM */
-        case 0x38: /* FRINTP */
-        case 0x39: /* FRINTZ */
-        case 0x59: /* FRINTX */
-        case 0x79: /* FRINTI */
-        case 0x58: /* FRINTA */
-        case 0x1e: /* FRINT32Z */
-        case 0x1f: /* FRINT64Z */
-        case 0x5e: /* FRINT32X */
-        case 0x5f: /* FRINT64X */
-        case 0x1d: /* SCVTF */
-        case 0x5d: /* UCVTF */
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-        case 0x5a: /* FCVTNU */
-        case 0x5b: /* FCVTMU */
-        case 0x7a: /* FCVTPU */
-        case 0x7b: /* FCVTZU */
-        case 0x5c: /* FCVTAU */
-        case 0x1c: /* FCVTAS */
-        case 0x2c: /* FCMGT (zero) */
-        case 0x2d: /* FCMEQ (zero) */
-        case 0x2e: /* FCMLT (zero) */
-        case 0x6c: /* FCMGE (zero) */
-        case 0x6d: /* FCMLE (zero) */
-        case 0x3d: /* FRECPE */
-        case 0x7d: /* FRSQRTE */
-        case 0x3c: /* URECPE */
-        case 0x7c: /* URSQRTE */
-            unallocated_encoding(s);
-            return;
-        }
-        break;
-    }
-    default:
-    case 0x0: /* REV64, REV32 */
-    case 0x1: /* REV16 */
-    case 0x2: /* SADDLP, UADDLP */
-    case 0x3: /* SUQADD, USQADD */
-    case 0x4: /* CLS, CLZ */
-    case 0x5: /* CNT, NOT, RBIT */
-    case 0x6: /* SADALP, UADALP */
-    case 0x7: /* SQABS, SQNEG */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-    case 0xa: /* CMLT */
-    case 0xb: /* ABS, NEG */
-    case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
-    case 0x13: /* SHLL, SHLL2 */
-    case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
-        unallocated_encoding(s);
-        return;
-    }
-    g_assert_not_reached();
-}
-
-/* C3.6 Data processing - SIMD, inc Crypto
- *
- * As the decode gets a little complex we are using a table based
- * approach for this part of the decode.
- */
-static const AArch64DecodeTable data_proc_simd[] = {
-    /* pattern  ,  mask     ,  fn                        */
-    { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    { 0x00000000, 0x00000000, NULL }
-};
-
-static void disas_data_proc_simd(DisasContext *s, uint32_t insn)
-{
-    /* Note that this is called with all non-FP cases from
-     * table C3-6 so it must UNDEF for entries not specifically
-     * allocated to instructions in that table.
-     */
-    AArch64DecodeFn *fn = lookup_disas_fn(&data_proc_simd[0], insn);
-    if (fn) {
-        fn(s, insn);
-    } else {
-        unallocated_encoding(s);
-    }
-}
-
-/* C3.6 Data processing - SIMD and floating point */
-static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
-{
-    if (extract32(insn, 28, 1) == 1 && extract32(insn, 30, 1) == 0) {
-        unallocated_encoding(s); /* in decodetree */
-    } else {
-        /* SIMD, including crypto */
-        disas_data_proc_simd(s, insn);
-    }
+    clear_vec_high(s, true, a->rd);
+    return true;
 }
 
 static bool trans_OK(DisasContext *s, arg_OK *a)
@@ -9749,20 +9593,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
     return false;
 }
 
-/* C3.1 A64 instruction index by encoding */
-static void disas_a64_legacy(DisasContext *s, uint32_t insn)
-{
-    switch (extract32(insn, 25, 4)) {
-    case 0x7:
-    case 0xf:      /* Data processing - SIMD and floating point */
-        disas_data_proc_simd_fp(s, insn);
-        break;
-    default:
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
                                           CPUState *cpu)
 {
@@ -9965,7 +9795,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (!disas_a64(s, insn) &&
         !disas_sme(s, insn) &&
         !disas_sve(s, insn)) {
-        disas_a64_legacy(s, insn);
+        unallocated_encoding(s);
     }
 
     /*
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f35d123821..7aa10f5147 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1866,6 +1866,8 @@ FRSQRTE_v       0.10 1110 1.1 00001 11011 0 ..... .....     @qrr_sd
 URECPE_v        0.00 1110 101 00001 11001 0 ..... .....     @qrr_s
 URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
+FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
-- 
2.43.0


