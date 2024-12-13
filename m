Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7D0E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YV-0002WZ-2i; Fri, 13 Dec 2024 12:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y0-0008Gx-Be
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xu-0001jG-Hm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:51 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-382610c7116so986770f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111225; x=1734716025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bg/iiVpN9EKFWgvja0txYOWPIgkXQ6VVFL3VOyL0qzI=;
 b=T71OSNdRTnY6aP62Pf2GZ4I+04sJslF7gN/Wtv5xSNTbFKW2PdsiaiS8QshnHUn1My
 lvnzEoUqsZQCMSFbh8FiRbtbQ8S5fj71XX5XldkwGbYTHjyGhy06We3mCJCQJJcstrT6
 3rfZ9M43qnuJklzOEfeill36CGi3yKhtkY1n34/n/3gTmH5CyI9B2ARe5XIazuKkR8qm
 tPXhuM8I7oYfbpR+H4ZwsVYkgTkhsyefiUNOn7F4ElzCO7/meePWDRrfBygo2p08CZg9
 cSaQvVuX6PQWT6WV901vXg+vqKljmIXVExFckz8liS1OqzZjYtfNDVQe+7twdo0ZiLJI
 r14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111225; x=1734716025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bg/iiVpN9EKFWgvja0txYOWPIgkXQ6VVFL3VOyL0qzI=;
 b=xUsvatDTgxZAAKiRh+nY66JdWZJiWFvMSFASHyFx+DsDw8u05deplXRnRQGfoIkJc0
 7l2JfldOJeqv2LfiMA/Zv8dsvi1gIyiHEyYQ8N+m2ZQnTWtpR+Dt/8ea//AaJJA4C2lx
 YVDoabrsf7cTPspHNjPodH5dKFn3q+m6qDgHb9o5pxHjJ+9ZfquqKLNcCHcWUSNeIBZ2
 fX6xWu5OgdRTIGix2aIkaw4x3q3WecbwOdVnWezeJ7vYe1um4AO+9EWuS3IoX7fYHmsF
 rMLGkJFXPDoS+ZjvVH469teGI6PeakEyB1/Gen23daGs25TSuFsO9gR9TwPs5I4A2j2W
 JaHQ==
X-Gm-Message-State: AOJu0YwxUMuILN5tOb5Cb0FTDWwOxWzw69/GYgmhOo27uTRzV8D71c64
 BxmuhM1HpTw7J+YrlAV7FsWtuxQrGNbZV6vUW1TZwdH2jUS9/4C9qbg06mQhWzAxC0I53UUzhhc
 K
X-Gm-Gg: ASbGnctafcy9UX63oNIIO3Idmo2Adel4DVSJxl326MtPIjKzSU5i3eDDw5dG4hPHinH
 BamvGPUT8iYzIGoxK76+0GGr4ZzNRnHKTG5U84MVhAAcVuiXNRf1aLLk9BOF3m2zoUwotnyEMmj
 7dV0EYgSMLDhyOkEvfzdAi38h1bBaNn3Vj0TjN7ScZxAn9tO2AGa/SX1QRREmH7/9TUxQ80pZjx
 h0LqIOvfGOb3HPLWyYSEd2cVAa7pwMFD581SN+JKemOd1ZoAhRy/43Agd2A/g==
X-Google-Smtp-Source: AGHT+IG1n9CkTjkFCpdAFPE9pPLJIXqHvCUEtDU0oPaNSYrWBLvxDvV+95PciQcSZ0Ile+vushidGQ==
X-Received: by 2002:a5d:6daa:0:b0:385:e38f:8dd with SMTP id
 ffacd0b85a97d-3888e0b8e56mr2845091f8f.46.1734111225119; 
 Fri, 13 Dec 2024 09:33:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/85] target/arm: Convert FCVTL to decodetree
Date: Fri, 13 Dec 2024 17:32:13 +0000
Message-Id: <20241213173229.3308926-70-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Remove lookup_disas_fn, handle_2misc_widening,
disas_simd_two_reg_misc, disas_data_proc_simd,
disas_data_proc_simd_fp, disas_a64_legacy, as
this is the final insn to be converted.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-70-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   2 +
 target/arm/tcg/translate-a64.c | 202 +++------------------------------
 2 files changed, 18 insertions(+), 186 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f35d123821c..7aa10f51471 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fa3170da860..3e57b98c27f 100644
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
-- 
2.34.1


