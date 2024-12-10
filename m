Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E66E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL33P-0003Sl-8i; Tue, 10 Dec 2024 11:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL331-0001QS-HX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:25:22 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32z-0007hp-4K
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:25:19 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-540218726d5so1896685e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847915; x=1734452715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgMoUG1TjCgvuCMS0XzFgGW8rdp5HC+s8kCN2kuLaCY=;
 b=OZeBZbpWnT2ebZAiOo8wUVNGO5tysu2V4udlSpPt7cM0n+9MXgGTfD9RkvuUbzEjqR
 mY1f6TgPapAJPVP8TuTE4T1rkrRPoMkQ0oUCI8J0G5OD+zjw7qFE4MxqHY+90f4+hVix
 iMASj7cx+9IDXVCLjwjRbAmTA8JpTt9m1vKGrj8GmgYUYwEqmXVYo2jHET2GDTm2fQwp
 BX5yxpGRLzRMMEGql0kkCsash633wryRC85hKo5qYLZFEKCviZmG9nMSxU5R4E9BjQRq
 Dbg+nD8IrDqUFYP276ji6CdgqttLV2Q6OB0lixsUINeVossWrrsTaQrCefxgOrnnvHMQ
 Koow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847915; x=1734452715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgMoUG1TjCgvuCMS0XzFgGW8rdp5HC+s8kCN2kuLaCY=;
 b=q4NwpkOtpwNQCF1eAznITsUVINHLgKMVkT24y+idGQwL+OJH7ACBzwc94LWlFPaAC/
 6CJm+oLW8K7nfUpP1s2vrivOdf16fR2nRK0gcgp/UzMpxoc3jiY7z+hyABBAUPmob3nW
 29QkCAeJo9gWmPZ52Z0mY/rC4y1NFx0B6C+0gfjF8qaU8SjLW1Dv2vWz0GV5kQ9FySo8
 1oKd9pxdxZp1ozutcRg44viVANMdsymEeLRFIRIbdy+503yeM93NmSbXcdcWHaLVo9JR
 NVDBVudnszXwbKT3wV4TGlCvTLatlndrKaqM1p0xSn73Y7iWrLYpFZsoAUZKb5sikFNn
 0MnQ==
X-Gm-Message-State: AOJu0YzTnMWLSrCULKM7rX0iqVzlWG5y/TjvDwKfwtz+MkfAGoLFysJ6
 xKynwNzyrz7ASISvUS4GPq4fcnt8RX8DNdhn/La2zWxjj3OPbgLk5bINFpuZMFfl6oPUWrQq4y9
 D/KKte70U
X-Gm-Gg: ASbGncsrKnduh+3mWEuSxHNV8j35Zi2dIHAQthS92K3dz5afXLpDGh/+i4LCtAnQPyH
 Dm7vvtjW3jjYvnOk0eIa3tLtjHAsb4ftqkcDx/rNdlUfHN7boDc1sG1ze/9T+KCiSCHdrXczesc
 UIwB+TVqC9GCZni5f9tjW9uZ93vnVhpXJQa/TGH0YLQsQFCY72oX8p2BvZRAuqi+TLACGjr/1tU
 axeglbB7ksu1aFmHwBEWG1cipX6SKJD+DKFH9KU09+EWZcJ2aQQqhur17Q=
X-Google-Smtp-Source: AGHT+IFuPyejxbDtu/HQBgz+lxeGECLJXkV1/hscJxeyfIH8K4AkRfl8xqoJeBwZWxiYkemyg3dXIA==
X-Received: by 2002:a05:6512:2205:b0:540:788:d6d8 with SMTP id
 2adb3069b0e04-540240bd722mr2014064e87.18.1733847915117; 
 Tue, 10 Dec 2024 08:25:15 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:25:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 69/69] target/arm: Convert FCVTL to decodetree
Date: Tue, 10 Dec 2024 10:17:33 -0600
Message-ID: <20241210161733.1830573-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
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


