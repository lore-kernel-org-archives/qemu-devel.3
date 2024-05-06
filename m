Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DCDC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnM-0000nT-To; Sun, 05 May 2024 21:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmv-0008Og-Sa
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmQ-0002Xz-8l
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f44b5e7f07so899924b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957473; x=1715562273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ4QWsv6ojEOV5qtz6ssdoc0GL1SICQsYslmR6Fp+aA=;
 b=qcNzruGnwcMhyYtR/DN6lXiVCVEKugpnUrBwFjGY7qjDW9acBOCqlmmQuGtFS+FNk2
 JY2G6LmNxTSaZzGsdPRXQkIwlmOiks6WRGP3jZJO2TMmx9PQqX7PCmqg7wTdPUIvqw+0
 wrcJD3S2dof/o9Y8Si+PBn7R1u5GpdkYrEawDESr+sbw84CyQShFq3Y/bPYc4ivaJglQ
 uSEn/bUH2TWWFLSbyYBs0MzvZCmkERCHEtX6mla8JQ4qBRnfyua07zWl6VMNJYkguhas
 zHEo86FBDqRqfQuN3cTCdqGEood1Y8WhOAK3M00LdpXWQgjt2agE3h5hg4Zh7+x8/lsE
 NKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957473; x=1715562273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJ4QWsv6ojEOV5qtz6ssdoc0GL1SICQsYslmR6Fp+aA=;
 b=shustgs4I37J0P4v1iOAoEHYPRYG7nsgZGQ1Sf7vfZCufqBVhaOtILZKZTQUOUvb5w
 2GeqlIDEzF6cVcJke67IJ4wLadqb1SjbrKDY/ThSJvzT8me6CppUibkI05BDdFplyG2y
 aaZon5mjUtuF34zh/Uy7kTirWvpxLtD60iOTDlDgSY7OfGZJiEZ12hnnBZfPTfyriKxo
 KEDaei1hCyzjOVtehBH8nBo2g0BeKn2H7LxhFGK/T26weciULJI4V9TeJKgoqcaFhT4D
 uW07n7UP2mNnd6MsG5pJ6f3mJ+CVBX+HlTmqKD1BcFSXkqPy03zJ+SldU8C6XXR5ze56
 GrQw==
X-Gm-Message-State: AOJu0YxWsHXDiuwoNpje2Q5btgn7KV2awukeDNA5CXibXEh7F37/S9by
 Rv/q0MR4XXYLLLcLITEGSXSVNAwP1U88HCyyzLIlMSHkUsmNtWkfesM+wcT0V22uVF2SF0gzoyu
 t
X-Google-Smtp-Source: AGHT+IGJMH2Dx7SRLnroVvtt+bXQHWx1l+E/HV8GLQWwAmD1xg10s6CB5X4YrR71m2zql9UY67JS+g==
X-Received: by 2002:a05:6a20:438e:b0:1aa:5fb4:87ff with SMTP id
 i14-20020a056a20438e00b001aa5fb487ffmr10043305pzl.14.1714957472901; 
 Sun, 05 May 2024 18:04:32 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 34/57] target/arm: Convert SQADD, SQSUB, UQADD,
 UQSUB to decodetree
Date: Sun,  5 May 2024 18:03:40 -0700
Message-Id: <20240506010403.6204-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  11 ++++
 target/arm/tcg/translate-a64.c | 100 +++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d0618ca794..5eced906a9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -44,6 +44,7 @@
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
+@rrr_e          ........ esz:2 . rm:5 ...... rn:5 rd:5  &rrr_e
 
 @rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
 @rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
@@ -744,6 +745,11 @@ FRECPS_s        0101 1110 0.1 ..... 11111 1 ..... ..... @rrr_sd
 FRSQRTS_s       0101 1110 110 ..... 00111 1 ..... ..... @rrr_h
 FRSQRTS_s       0101 1110 1.1 ..... 11111 1 ..... ..... @rrr_sd
 
+SQADD_s         0101 1110 ..1 ..... 00001 1 ..... ..... @rrr_e
+UQADD_s         0111 1110 ..1 ..... 00001 1 ..... ..... @rrr_e
+SQSUB_s         0101 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
+UQSUB_s         0111 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -857,6 +863,11 @@ BSL_v           0.10 1110 011 ..... 00011 1 ..... ..... @qrrr_b
 BIT_v           0.10 1110 101 ..... 00011 1 ..... ..... @qrrr_b
 BIF_v           0.10 1110 111 ..... 00011 1 ..... ..... @qrrr_b
 
+SQADD_v         0.00 1110 ..1 ..... 00001 1 ..... ..... @qrrr_e
+UQADD_v         0.10 1110 ..1 ..... 00001 1 ..... ..... @qrrr_e
+SQSUB_v         0.00 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
+UQSUB_v         0.10 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 12235e06d8..5d91263ebb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5061,6 +5061,43 @@ static const FPScalar f_scalar_frsqrts = {
 };
 TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
 
+static bool do_satacc_s(DisasContext *s, arg_rrr_e *a,
+                MemOp sgn_n, MemOp sgn_m,
+                void (*gen_bhs)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp),
+                void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0, t1, t2, qc;
+    MemOp esz = a->esz;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    qc = tcg_temp_new_i64();
+    read_vec_element(s, t1, a->rn, 0, esz | sgn_n);
+    read_vec_element(s, t2, a->rm, 0, esz | sgn_m);
+    tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
+
+    if (esz == MO_64) {
+        gen_d(t0, qc, t1, t2);
+    } else {
+        gen_bhs(t0, qc, t1, t2, esz);
+        tcg_gen_ext_i64(t0, t0, esz);
+    }
+
+    write_fp_dreg(s, a->rd, t0);
+    tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
+    return true;
+}
+
+TRANS(SQADD_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqadd_bhs, gen_sqadd_d)
+TRANS(SQSUB_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqsub_bhs, gen_sqsub_d)
+TRANS(UQADD_s, do_satacc_s, a, 0, 0, gen_uqadd_bhs, gen_uqadd_d)
+TRANS(UQSUB_s, do_satacc_s, a, 0, 0, gen_uqsub_bhs, gen_uqsub_d)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5299,6 +5336,11 @@ TRANS(BSL_v, do_bitsel, a->q, a->rd, a->rd, a->rn, a->rm)
 TRANS(BIT_v, do_bitsel, a->q, a->rd, a->rm, a->rn, a->rd)
 TRANS(BIF_v, do_bitsel, a->q, a->rd, a->rm, a->rd, a->rn)
 
+TRANS(SQADD_v, do_gvec_fn3, a, gen_gvec_sqadd_qc)
+TRANS(UQADD_v, do_gvec_fn3, a, gen_gvec_uqadd_qc)
+TRANS(SQSUB_v, do_gvec_fn3, a, gen_gvec_sqsub_qc)
+TRANS(UQSUB_v, do_gvec_fn3, a, gen_gvec_uqsub_qc)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9285,29 +9327,8 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
      * or scalar-three-reg-same groups.
      */
     TCGCond cond;
-    TCGv_i64 qc;
 
     switch (opcode) {
-    case 0x1: /* SQADD */
-        qc = tcg_temp_new_i64();
-        tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        if (u) {
-            gen_uqadd_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        } else {
-            gen_sqadd_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        }
-        tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        break;
-    case 0x5: /* SQSUB */
-        qc = tcg_temp_new_i64();
-        tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        if (u) {
-            gen_uqsub_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        } else {
-            gen_sqsub_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        }
-        tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        break;
     case 0x6: /* CMGT, CMHI */
         cond = u ? TCG_COND_GTU : TCG_COND_GT;
     do_cmop:
@@ -9360,6 +9381,8 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         break;
     default:
+    case 0x1: /* SQADD / UQADD */
+    case 0x5: /* SQSUB / UQSUB */
         g_assert_not_reached();
     }
 }
@@ -9381,8 +9404,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd;
 
     switch (opcode) {
-    case 0x1: /* SQADD, UQADD */
-    case 0x5: /* SQSUB, UQSUB */
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
@@ -9404,6 +9425,8 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x1: /* SQADD, UQADD */
+    case 0x5: /* SQSUB, UQSUB */
         unallocated_encoding(s);
         return;
     }
@@ -9430,12 +9453,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
 
         switch (opcode) {
-        case 0x1: /* SQADD, UQADD */
-            genfn = u ? gen_uqadd_bhs : gen_sqadd_bhs;
-            break;
-        case 0x5: /* SQSUB, UQSUB */
-            genfn = u ? gen_uqsub_bhs : gen_sqsub_bhs;
-            break;
         case 0x9: /* SQSHL, UQSHL */
         {
             static NeonGenTwoOpEnvFn * const fns[3][2] = {
@@ -9467,6 +9484,8 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
             break;
         }
         default:
+        case 0x1: /* SQADD, UQADD */
+        case 0x5: /* SQSUB, UQSUB */
             g_assert_not_reached();
         }
 
@@ -10927,6 +10946,11 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+
+    case 0x01: /* SQADD, UQADD */
+    case 0x05: /* SQSUB, UQSUB */
+        unallocated_encoding(s);
+        return;
     }
 
     if (!fp_access_check(s)) {
@@ -10934,20 +10958,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x01: /* SQADD, UQADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqadd_qc, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqadd_qc, size);
-        }
-        return;
-    case 0x05: /* SQSUB, UQSUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqsub_qc, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqsub_qc, size);
-        }
-        return;
     case 0x08: /* SSHL, USHL */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_ushl, size);
@@ -11032,6 +11042,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                          vec_full_reg_offset(s, rm),
                          is_q ? 16 : 8, vec_full_reg_size(s));
         return;
+
+    case 0x01: /* SQADD, UQADD */
+    case 0x05: /* SQSUB, UQSUB */
+        g_assert_not_reached();
     }
 
     if (size == 3) {
-- 
2.34.1


