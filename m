Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B8EE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm6-0003Rq-A8; Wed, 11 Sep 2024 22:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlx-0002rw-V9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlv-0004AU-LB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2068acc8b98so4717565ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108886; x=1726713686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+M/vrV0uMNpf4dh4yRfZZht1RPv8tvP+7CoYBlpT8w=;
 b=FzQ21tVoLqGkjfvExo4tMvGgKbdd9QIHSmaMvnAnAUeT6UMM4iRdcPJIK/hrgYA3g8
 cBUEV0xjOBibOHDP2Ar0ujTOOtUEJbvw+ind7L92PX1Mi81memExewy7ka8ZGKZN+tH8
 0CQix/c5ZwMpQ40bcK6efAt6jjQ29rnQSr3hh+zVsgRgOrXOnxTBU/RO/oJ1G/pysuec
 yXGyLLzGCVwrh/weqgqfkNL9/ImQYEUYp5vMfzUC29dSmvxITgswHGvgN4e4/buB698v
 sYzVcT7BAjWyYekNQal1N+nu0rTrgu6qDOj6ndOpKQ1kkVTuuE+QZ0o4nPRcAJ09wjc6
 y6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108886; x=1726713686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+M/vrV0uMNpf4dh4yRfZZht1RPv8tvP+7CoYBlpT8w=;
 b=nUB64IDQxN0665LnX1J0QWQRN05ihouXXY/ol0WV4sbfhVa3fTmpfA09a60dzDt55W
 KTQF4zeX6db6ThCChgEhPS6pc4jFxu4bpwm0/cBIMFwA5Gb9LA05UdZ28S0/DeS0FJKo
 vI8Qf7J1gXATXJ4bZbCE1NPMBfNpiP4TQLXbrrDsJy53pHLldricEyJnCUe+I5kB18Hg
 2Tnj3rW55iFMRaH6CGN9iG+f8U8d6kCtW0z1yICbrawINvTonB4w/7o0+FZePYqcUdfu
 SKnw7w5qGRgo7yE1pn3Pnv9ubQQEqlEGAB0EttdWxIadIdy/MKd1uiUiqRm3GYmLl5T8
 xy3Q==
X-Gm-Message-State: AOJu0YyQMx4KydmYxkN2I0ddBYH1poZ3FsRFKdu0Mku1GW5cNtlN07vI
 D7QJFXCRawRxt7xefOPd9TrPLg8cQqz7O6Bnt31c6zZGUae0If/iG1Z83ZA/e0RyuwI79JowvfT
 G
X-Google-Smtp-Source: AGHT+IEW3y4LiXLwQzICFx9C+st1Z4M/l4aUT6Y2yrNzIJy37NJHvy+caPea6n8dBgKhskF/uGAtnA==
X-Received: by 2002:a17:903:185:b0:205:8425:e9c6 with SMTP id
 d9443c01a7336-2076e43fe94mr15282055ad.52.1726108886228; 
 Wed, 11 Sep 2024 19:41:26 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 11/29] target/arm: Convert FMAXNMV, FMINNMV, FMAXV,
 FMINV to decodetree
Date: Wed, 11 Sep 2024 19:40:56 -0700
Message-ID: <20240912024114.1097832-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 176 ++++++++++-----------------------
 target/arm/tcg/a64.decode      |  14 +++
 2 files changed, 67 insertions(+), 123 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 593a1774d8..aec2f6a542 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6835,6 +6835,59 @@ TRANS(UMAXV, do_int_reduction, a, false, 0, tcg_gen_umax_i64)
 TRANS(SMINV, do_int_reduction, a, false, MO_SIGN, tcg_gen_smin_i64)
 TRANS(UMINV, do_int_reduction, a, false, 0, tcg_gen_umin_i64)
 
+/*
+ * do_fp_reduction helper
+ *
+ * This mirrors the Reduce() pseudocode in the ARM ARM. It is
+ * important for correct NaN propagation that we do these
+ * operations in exactly the order specified by the pseudocode.
+ *
+ * This is a recursive function.
+ */
+static TCGv_i32 do_reduction_op(DisasContext *s, int rn, MemOp esz,
+                                int ebase, int ecount, TCGv_ptr fpst,
+                                NeonGenTwoSingleOpFn *fn)
+{
+    if (ecount == 1) {
+        TCGv_i32 tcg_elem = tcg_temp_new_i32();
+        read_vec_element_i32(s, tcg_elem, rn, ebase, esz);
+        return tcg_elem;
+    } else {
+        int half = ecount >> 1;
+        TCGv_i32 tcg_hi, tcg_lo, tcg_res;
+
+        tcg_hi = do_reduction_op(s, rn, esz, ebase + half, half, fpst, fn);
+        tcg_lo = do_reduction_op(s, rn, esz, ebase, half, fpst, fn);
+        tcg_res = tcg_temp_new_i32();
+
+        fn(tcg_res, tcg_lo, tcg_hi, fpst);
+        return tcg_res;
+    }
+}
+
+static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
+                              NeonGenTwoSingleOpFn *fn)
+{
+    if (fp_access_check(s)) {
+        MemOp esz = a->esz;
+        int elts = (a->q ? 16 : 8) >> esz;
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
+        write_fp_sreg(s, a->rd, res);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_maxnumh)
+TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_minnumh)
+TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_maxh)
+TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_minh)
+
+TRANS(FMAXNMV_s, do_fp_reduction, a, gen_helper_vfp_maxnums)
+TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
+TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs)
+TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9061,128 +9114,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/*
- * do_reduction_op helper
- *
- * This mirrors the Reduce() pseudocode in the ARM ARM. It is
- * important for correct NaN propagation that we do these
- * operations in exactly the order specified by the pseudocode.
- *
- * This is a recursive function.
- */
-static TCGv_i32 do_reduction_op(DisasContext *s, int fpopcode, int rn,
-                                MemOp esz, int ebase, int ecount, TCGv_ptr fpst)
-{
-    if (ecount == 1) {
-        TCGv_i32 tcg_elem = tcg_temp_new_i32();
-        read_vec_element_i32(s, tcg_elem, rn, ebase, esz);
-        return tcg_elem;
-    } else {
-        int half = ecount >> 1;
-        TCGv_i32 tcg_hi, tcg_lo, tcg_res;
-
-        tcg_hi = do_reduction_op(s, fpopcode, rn, esz,
-                                 ebase + half, half, fpst);
-        tcg_lo = do_reduction_op(s, fpopcode, rn, esz,
-                                 ebase, half, fpst);
-        tcg_res = tcg_temp_new_i32();
-
-        switch (fpopcode) {
-        case 0x0c: /* fmaxnmv half-precision */
-            gen_helper_advsimd_maxnumh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x0f: /* fmaxv half-precision */
-            gen_helper_advsimd_maxh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x1c: /* fminnmv half-precision */
-            gen_helper_advsimd_minnumh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x1f: /* fminv half-precision */
-            gen_helper_advsimd_minh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x2c: /* fmaxnmv */
-            gen_helper_vfp_maxnums(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x2f: /* fmaxv */
-            gen_helper_vfp_maxs(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x3c: /* fminnmv */
-            gen_helper_vfp_minnums(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x3f: /* fminv */
-            gen_helper_vfp_mins(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return tcg_res;
-    }
-}
-
-/* AdvSIMD across lanes
- *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
- * +---+---+---+-----------+------+-----------+--------+-----+------+------+
- * | 0 | Q | U | 0 1 1 1 0 | size | 1 1 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+-----------+--------+-----+------+------+
- */
-static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    bool is_q = extract32(insn, 30, 1);
-    bool is_u = extract32(insn, 29, 1);
-    bool is_min = false;
-    int elements;
-
-    switch (opcode) {
-    case 0xc: /* FMAXNMV, FMINNMV */
-    case 0xf: /* FMAXV, FMINV */
-        /* Bit 1 of size field encodes min vs max and the actual size
-         * depends on the encoding of the U bit. If not set (and FP16
-         * enabled) then we do half-precision float instead of single
-         * precision.
-         */
-        is_min = extract32(size, 1, 1);
-        if (!is_u && dc_isar_feature(aa64_fp16, s)) {
-            size = 1;
-        } else if (!is_u || !is_q || extract32(size, 0, 1)) {
-            unallocated_encoding(s);
-            return;
-        } else {
-            size = 2;
-        }
-        break;
-    default:
-    case 0x3: /* SADDLV, UADDLV */
-    case 0xa: /* SMAXV, UMAXV */
-    case 0x1a: /* SMINV, UMINV */
-    case 0x1b: /* ADDV */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    elements = (is_q ? 16 : 8) >> size;
-
-    {
-        /* Floating point vector reduction ops which work across 32
-         * bit (single) or 16 bit (half-precision) intermediates.
-         * Note that correct NaN propagation requires that we do these
-         * operations in exactly the order specified by the pseudocode.
-         */
-        TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
-        int fpopcode = opcode | is_min << 4 | is_u << 5;
-        TCGv_i32 tcg_res = do_reduction_op(s, fpopcode, rn, size,
-                                           0, elements, fpst);
-        write_fp_sreg(s, rd, tcg_res);
-    }
-}
-
 /* AdvSIMD modified immediate
  *  31  30   29  28                 19 18 16 15   12  11  10  9     5 4    0
  * +---+---+----+---------------------+-----+-------+----+---+-------+------+
@@ -11735,7 +11666,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5ab4b11781..c77f9fc987 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -54,11 +54,13 @@
 @rrx_d          ........ .. . rm:5  .... idx:1 . rn:5 rd:5  &rrx_e esz=3
 
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
+@rr_q1e2        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=2
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 @rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1166,3 +1168,15 @@ SMAXV           0.00 1110 .. 11000 01010 10 ..... .....     @qrr_e
 UMAXV           0.10 1110 .. 11000 01010 10 ..... .....     @qrr_e
 SMINV           0.00 1110 .. 11000 11010 10 ..... .....     @qrr_e
 UMINV           0.10 1110 .. 11000 11010 10 ..... .....     @qrr_e
+
+FMAXNMV_h       0.00 1110 00 11000 01100 10 ..... .....     @qrr_h
+FMAXNMV_s       0110 1110 00 11000 01100 10 ..... .....     @rr_q1e2
+
+FMINNMV_h       0.00 1110 10 11000 01100 10 ..... .....     @qrr_h
+FMINNMV_s       0110 1110 10 11000 01100 10 ..... .....     @rr_q1e2
+
+FMAXV_h         0.00 1110 00 11000 01111 10 ..... .....     @qrr_h
+FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
+
+FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
+FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
-- 
2.43.0


