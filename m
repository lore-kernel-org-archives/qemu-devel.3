Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781F0C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD109-0004a7-72; Fri, 31 May 2024 08:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zt-0004Sx-M0
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:37 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zn-0003Vs-Lo
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:36 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e95a883101so25299201fa.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157069; x=1717761869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pPsTv+YeC7VRfKmMRCqf8LgQYwxQJAZ5HBcVXVIxDkw=;
 b=DJW0uy6NLuI00VZZA2LXsQUhYEpzI09Bbycped0qHE3EM+KMKgnJaWFLNTAJX8V9/W
 i2dmkjQ1b2zwaMuTRcXS43I0/IQ/QULxkI81VpfrwbgTPyVLi9L4al6hj/B7+d9Wew34
 7mkmi1O73wFco/ZDvKtUYbQYM1Fc/zhDtTpGzB4PnflIUz/jbbsMgtw6FgoYTRZMcYqf
 8DhnKeDHmP878iSFwE9Rr2dp0IfFZhuXEgYnDn2orN66deEMxPRjkfrj4MLGKJTLdLRu
 dFdtLYQCt8ghbkyGcuIPYaW1LNx872ZpV8Md4/NpARdK0Hx9iM++gZOTGJ/K2KRhtEqh
 Orfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157069; x=1717761869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPsTv+YeC7VRfKmMRCqf8LgQYwxQJAZ5HBcVXVIxDkw=;
 b=U9n7Pi5xNaKmqP9Gt/40ksjKMZZZfYom0rM48WWzgU/RskzWtF7IZIKK7EuTqP85vR
 RS89kcYLv4YnzlwH9101xBPMToGnc0BqTryP4XHzDLC/Ou+Aw4iX0OMgj3xOhzpX4Eml
 ZULICtc+/M5eLNm63HC5tZNSyNfH8CajhbqNcTCVSYah/txWn8SMcEljZHwnllLsgGxF
 tx4wO5GHLlZ0eJ9bTfQqPyBOUCX3UBswctafDXhdU16IBdWDmToSRp9K+4S5CCabqQNW
 T5GKkbRFcV95zjRLfyfYy4yrEPYoeZrJm0blIsiBnE8D0YOuY1P64iSaAXxesDQL0uzk
 6h+A==
X-Gm-Message-State: AOJu0YxPCN+S2zoHodDCysK1MwpIo5mY6k+iYZqOmrDTI94w/qtpqZwv
 VJLNg9STKqdj64RDKXuG1BI5sByU3bMsz0SBXiXmEv4CO2MFaoCd6q77zzkCAiTKuvbEPtnaSvo
 T
X-Google-Smtp-Source: AGHT+IECh6gcIzSZFEpjstb9JA4RqtNdmp09mM6njA4S9K5B3q/RbYscuUwBAeXPeR3olqCZqEKQWw==
X-Received: by 2002:a2e:9d88:0:b0:2e6:cb01:aeee with SMTP id
 38308e7fff4ca-2ea951d4f47mr11335331fa.49.1717157069201; 
 Fri, 31 May 2024 05:04:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/43] target/arm: Convert FMADD, FMSUB, FNMADD,
 FNMSUB to decodetree
Date: Fri, 31 May 2024 13:03:55 +0100
Message-Id: <20240531120401.394550-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are the only instructions in the 3 source scalar class.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240528203044.612851-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  10 ++
 target/arm/tcg/translate-a64.c | 231 ++++++++++++---------------------
 2 files changed, 93 insertions(+), 148 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f7f897f9fcc..6f6cd805b71 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -32,6 +32,7 @@
 &rr_e           rd rn esz
 &rrr_e          rd rn rm esz
 &rrx_e          rd rn rm idx esz
+&rrrr_e         rd rn rm ra esz
 &qrr_e          q rd rn esz
 &qrrr_e         q rd rn rm esz
 &qrrx_e         q rd rn rm idx esz
@@ -998,3 +999,12 @@ SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
 
 SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
 SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
+
+# Floating-point data-processing (3 source)
+
+@rrrr_hsd       .... .... .. . rm:5  . ra:5  rn:5  rd:5     &rrrr_e esz=%esz_hsd
+
+FMADD           0001 1111 .. 0 ..... 0 ..... ..... .....    @rrrr_hsd
+FMSUB           0001 1111 .. 0 ..... 1 ..... ..... .....    @rrrr_hsd
+FNMADD          0001 1111 .. 1 ..... 0 ..... ..... .....    @rrrr_hsd
+FNMSUB          0001 1111 .. 1 ..... 1 ..... ..... .....    @rrrr_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 14226c56cfd..78a2e6d6922 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5866,6 +5866,88 @@ static bool trans_ADDP_s(DisasContext *s, arg_rr_e *a)
     return true;
 }
 
+/*
+ * Floating-point data-processing (3 source)
+ */
+
+static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
+{
+    TCGv_ptr fpst;
+
+    /*
+     * These are fused multiply-add.  Note that doing the negations here
+     * as separate steps is correct: an input NaN should come out with
+     * its sign bit flipped if it is a negated-input.
+     */
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 tn = read_fp_dreg(s, a->rn);
+            TCGv_i64 tm = read_fp_dreg(s, a->rm);
+            TCGv_i64 ta = read_fp_dreg(s, a->ra);
+
+            if (neg_a) {
+                gen_vfp_negd(ta, ta);
+            }
+            if (neg_n) {
+                gen_vfp_negd(tn, tn);
+            }
+            fpst = fpstatus_ptr(FPST_FPCR);
+            gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
+            write_fp_dreg(s, a->rd, ta);
+        }
+        break;
+
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 tn = read_fp_sreg(s, a->rn);
+            TCGv_i32 tm = read_fp_sreg(s, a->rm);
+            TCGv_i32 ta = read_fp_sreg(s, a->ra);
+
+            if (neg_a) {
+                gen_vfp_negs(ta, ta);
+            }
+            if (neg_n) {
+                gen_vfp_negs(tn, tn);
+            }
+            fpst = fpstatus_ptr(FPST_FPCR);
+            gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
+            write_fp_sreg(s, a->rd, ta);
+        }
+        break;
+
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 tn = read_fp_hreg(s, a->rn);
+            TCGv_i32 tm = read_fp_hreg(s, a->rm);
+            TCGv_i32 ta = read_fp_hreg(s, a->ra);
+
+            if (neg_a) {
+                gen_vfp_negh(ta, ta);
+            }
+            if (neg_n) {
+                gen_vfp_negh(tn, tn);
+            }
+            fpst = fpstatus_ptr(FPST_FPCR_F16);
+            gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
+            write_fp_sreg(s, a->rd, ta);
+        }
+        break;
+
+    default:
+        return false;
+    }
+    return true;
+}
+
+TRANS(FMADD, do_fmadd, a, false, false)
+TRANS(FNMADD, do_fmadd, a, true, true)
+TRANS(FMSUB, do_fmadd, a, false, true)
+TRANS(FNMSUB, do_fmadd, a, true, false)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -7665,152 +7747,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating-point data-processing (3 source) - single precision */
-static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
-                                  int rd, int rn, int rm, int ra)
-{
-    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
-    TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-
-    tcg_op1 = read_fp_sreg(s, rn);
-    tcg_op2 = read_fp_sreg(s, rm);
-    tcg_op3 = read_fp_sreg(s, ra);
-
-    /* These are fused multiply-add, and must be done as one
-     * floating point operation with no rounding between the
-     * multiplication and addition steps.
-     * NB that doing the negations here as separate steps is
-     * correct : an input NaN should come out with its sign bit
-     * flipped if it is a negated-input.
-     */
-    if (o1 == true) {
-        gen_vfp_negs(tcg_op3, tcg_op3);
-    }
-
-    if (o0 != o1) {
-        gen_vfp_negs(tcg_op1, tcg_op1);
-    }
-
-    gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (3 source) - double precision */
-static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
-                                  int rd, int rn, int rm, int ra)
-{
-    TCGv_i64 tcg_op1, tcg_op2, tcg_op3;
-    TCGv_i64 tcg_res = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-
-    tcg_op1 = read_fp_dreg(s, rn);
-    tcg_op2 = read_fp_dreg(s, rm);
-    tcg_op3 = read_fp_dreg(s, ra);
-
-    /* These are fused multiply-add, and must be done as one
-     * floating point operation with no rounding between the
-     * multiplication and addition steps.
-     * NB that doing the negations here as separate steps is
-     * correct : an input NaN should come out with its sign bit
-     * flipped if it is a negated-input.
-     */
-    if (o1 == true) {
-        gen_vfp_negd(tcg_op3, tcg_op3);
-    }
-
-    if (o0 != o1) {
-        gen_vfp_negd(tcg_op1, tcg_op1);
-    }
-
-    gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
-
-    write_fp_dreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (3 source) - half precision */
-static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
-                                int rd, int rn, int rm, int ra)
-{
-    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
-    TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_F16);
-
-    tcg_op1 = read_fp_hreg(s, rn);
-    tcg_op2 = read_fp_hreg(s, rm);
-    tcg_op3 = read_fp_hreg(s, ra);
-
-    /* These are fused multiply-add, and must be done as one
-     * floating point operation with no rounding between the
-     * multiplication and addition steps.
-     * NB that doing the negations here as separate steps is
-     * correct : an input NaN should come out with its sign bit
-     * flipped if it is a negated-input.
-     */
-    if (o1 == true) {
-        tcg_gen_xori_i32(tcg_op3, tcg_op3, 0x8000);
-    }
-
-    if (o0 != o1) {
-        tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
-    }
-
-    gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating point data-processing (3 source)
- *   31  30  29 28       24 23  22  21  20  16  15  14  10 9    5 4    0
- * +---+---+---+-----------+------+----+------+----+------+------+------+
- * | M | 0 | S | 1 1 1 1 1 | type | o1 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
- * +---+---+---+-----------+------+----+------+----+------+------+------+
- */
-static void disas_fp_3src(DisasContext *s, uint32_t insn)
-{
-    int mos = extract32(insn, 29, 3);
-    int type = extract32(insn, 22, 2);
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int ra = extract32(insn, 10, 5);
-    int rm = extract32(insn, 16, 5);
-    bool o0 = extract32(insn, 15, 1);
-    bool o1 = extract32(insn, 21, 1);
-
-    if (mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_3src_single(s, o0, o1, rd, rn, rm, ra);
-        break;
-    case 1:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_3src_double(s, o0, o1, rd, rn, rm, ra);
-        break;
-    case 3:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_3src_half(s, o0, o1, rd, rn, rm, ra);
-        break;
-    default:
-        unallocated_encoding(s);
-    }
-}
-
 /* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
@@ -8255,8 +8191,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
 static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
 {
     if (extract32(insn, 24, 1)) {
-        /* Floating point data-processing (3 source) */
-        disas_fp_3src(s, insn);
+        unallocated_encoding(s); /* in decodetree */
     } else if (extract32(insn, 21, 1) == 0) {
         /* Floating point to fixed point conversions */
         disas_fp_fixed_conv(s, insn);
-- 
2.34.1


