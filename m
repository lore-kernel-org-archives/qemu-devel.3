Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C115C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg84h-0000a1-KW; Thu, 06 Feb 2025 15:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Y-0007ou-5k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:07 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83P-00017X-1u
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:54 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fa1c093d6eso821773a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872049; x=1739476849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/toXYQQTwyLUhEJnA3NYfc7FMNLpiiC/353/n0l4F2U=;
 b=gjqOMZsxQC5V3KUxtuo+1Rd6ATMebHc/qP5swdT+aLb8dDD3mSu0+8V8e4uhJtaW4J
 ydl4uLNcceEiDEEvfpIiykgxQKulIrCWruGN7zfcPGXGxgzw+BooDhfG4yLCjSXfpKWC
 I0X+CH0Hxxw6ebFSrVFOOpFhqodkjYd41Ttkemd6o6lGfiy/s0kOtntl9wCQpmRB51TP
 vv5Hy918DQ35Zq1bmm9QHO4Ed/fuywsSmqNyFN8DKyYoz5moh/Y1TfzyAZUi8C3p949x
 n1ee0EXXQaWlUHj5o+l0QErH19UARVybXWjdIFw0rs0ZvefrcOT8wF3SC4+kVSHsmuR2
 lkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872049; x=1739476849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/toXYQQTwyLUhEJnA3NYfc7FMNLpiiC/353/n0l4F2U=;
 b=NfZ91kDCAZc7K2IOxrH/qecbRQd/Kq2Ikz0aYup4j08waDFmzUEvx2z5SanHnTSop9
 FQ15hmtgvx9KOg9fqaWQ+8Pe3FWFw88/AnIGRIejCN4Kqpsfn2xEoMUk3V+mXpP4lNnK
 QVni4+WUJ34ZzUEY4ZxIksj/xfWe5sdzOINJQ1RgpAzDqLe3RqVIMoiMm/EmfqUBuaSC
 EM7jhFHFcXbI+J3gIndYqQG912RTGae53Em/mKXP9id0pk2NDqeamlQ1RAXy08tfWR/N
 strf3JCtuoCqWKnYX2zKkoy1F933Cixgu39Jp1uK5EKT938yU4nuZ26xOkdCaJmcV8Po
 LWVQ==
X-Gm-Message-State: AOJu0YwxPU4kccn3l+pUA/ka19jvHyUiXL1ePuF2RerPpfon98bO1RgV
 e+QxGCOWSCPORe2oyCX7moik+dWSxPUsVK543JpExTk66dhgSttn5pSMimW2m/kjw18ENBMK4bd
 k
X-Gm-Gg: ASbGncuWc241QTMOg8i1NVJ40R/P1JchV2BEHHcB6oxMoHc25OgJjk7JQxT7U2JMfYS
 vaFl4H0Apmk0zcbzESeDMSmGqHG/4VFMcfyjS+3z40brDYLVkfY8MxnG2Fx5Z2FsuZdBeB8MsrQ
 kmNkgOMHhYRcGgngLDYLjLSWKhRO6qx12WwtnRAYLdrLERmB+to8OSxMKe+MucPmj6HudEgfkOP
 XUns+51/0N4c6ASlKdHBWyQWtUPCTSbh9cUsjTSJg4LIavo6YFEHDIgDUiSN3aPWSS632mjc2p1
 zvLQT/4rG9m0gwgILaH8h2EnXxvXvsJ4+syXFZPDGh/1msA=
X-Google-Smtp-Source: AGHT+IHdVEBVpMvvz8BOom9+wyuA3Z4bCHi1HGwfgcWMmjbc6ouEST2kDCi5SsYnYVSSO1uUEI6Fpg==
X-Received: by 2002:a17:90b:3588:b0:2ee:c04a:4281 with SMTP id
 98e67ed59e1d1-2fa23f55e36mr477281a91.6.1738872049303; 
 Thu, 06 Feb 2025 12:00:49 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 43/61] target/arm: Implement SME2 BFMLA, BFMLS
Date: Thu,  6 Feb 2025 11:56:57 -0800
Message-ID: <20250206195715.2150758-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 target/arm/helper.h            |  9 +++++++++
 target/arm/tcg/translate-sme.c | 14 ++++++++++++++
 target/arm/tcg/vec_helper.c    | 26 ++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 18 ++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b00b79c12c..ac2372bbe7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -785,14 +785,17 @@ DEF_HELPER_FLAGS_5(gvec_fmls_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i
 DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfmla, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfmls, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ah_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ah_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ah_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_bfmls, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
@@ -824,6 +827,8 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmla_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_fmls_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
@@ -831,6 +836,8 @@ DEF_HELPER_FLAGS_6(gvec_fmls_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmls_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
@@ -838,6 +845,8 @@ DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmls_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1989dedab5..5dce2dfd15 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -971,6 +971,15 @@ TRANS_FEAT(FMLA_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
 TRANS_FEAT(FMLS_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_vfms_d : gen_helper_gvec_vfms_d)
 
+TRANS_FEAT(BFMLA_n1, aa64_sme2_b16b16, do_fmla, a, false, FPST_ZA,
+           gen_helper_gvec_bfmla)
+TRANS_FEAT(BFMLS_n1, aa64_sme2_b16b16, do_fmla, a, false, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls : gen_helper_gvec_bfmls)
+TRANS_FEAT(BFMLA_nn, aa64_sme2_b16b16, do_fmla, a, true, FPST_ZA,
+           gen_helper_gvec_bfmla)
+TRANS_FEAT(BFMLS_nn, aa64_sme2_b16b16, do_fmla, a, true, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls : gen_helper_gvec_bfmls)
+
 static bool do_fmla_nx(DisasContext *s, arg_azx_n *a,
                        ARMFPStatusFlavour fpst, gen_helper_gvec_4_ptr *fn)
 {
@@ -991,6 +1000,11 @@ TRANS_FEAT(FMLA_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
 TRANS_FEAT(FMLS_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_fmls_idx_d : gen_helper_gvec_fmls_idx_d)
 
+TRANS_FEAT(BFMLA_nx, aa64_sme2_b16b16, do_fmla_nx, a, FPST_ZA,
+           gen_helper_gvec_bfmla_idx)
+TRANS_FEAT(BFMLS_nx, aa64_sme2_b16b16, do_fmla_nx, a, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls_idx : gen_helper_gvec_bfmls_idx)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 2d2a000a4a..e5a4f56ef7 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1607,6 +1607,12 @@ static float16 float16_muladd_f(float16 dest, float16 op1, float16 op2,
     return float16_muladd(op1, op2, dest, 0, stat);
 }
 
+static bfloat16 bfloat16_muladd_f(bfloat16 dest, bfloat16 op1, bfloat16 op2,
+                                  float_status *stat)
+{
+    return bfloat16_muladd(op1, op2, dest, 0, stat);
+}
+
 static float32 float32_muladd_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
@@ -1625,6 +1631,12 @@ static float16 float16_mulsub_f(float16 dest, float16 op1, float16 op2,
     return float16_muladd(float16_chs(op1), op2, dest, 0, stat);
 }
 
+static bfloat16 bfloat16_mulsub_f(bfloat16 dest, bfloat16 op1, bfloat16 op2,
+                                  float_status *stat)
+{
+    return bfloat16_muladd(bfloat16_chs(op1), op2, dest, 0, stat);
+}
+
 static float32 float32_mulsub_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
@@ -1643,6 +1655,12 @@ static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
     return float16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
 }
 
+static bfloat16 bfloat16_ah_mulsub_f(bfloat16 dest, bfloat16 op1, bfloat16 op2,
+                                     float_status *stat)
+{
+    return bfloat16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
 static float32 float32_ah_mulsub_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
@@ -1676,14 +1694,19 @@ DO_MULADD(gvec_fmls_nf_s, float32_mulsub_nf, float32)
 DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
 DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
 DO_MULADD(gvec_vfma_d, float64_muladd_f, float64)
+DO_MULADD(gvec_bfmla, bfloat16_muladd_f, bfloat16)
 
 DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
 DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
+DO_MULADD(gvec_bfmls, bfloat16_mulsub_f, bfloat16)
 
 DO_MULADD(gvec_ah_vfms_h, float16_ah_mulsub_f, float16)
 DO_MULADD(gvec_ah_vfms_s, float32_ah_mulsub_f, float32)
 DO_MULADD(gvec_ah_vfms_d, float64_ah_mulsub_f, float64)
+DO_MULADD(gvec_ah_bfmls, bfloat16_ah_mulsub_f, bfloat16)
+
+#undef DO_MULADD
 
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
@@ -1802,14 +1825,17 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2, 0, 0)
 DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4, 0, 0)
 DO_FMLA_IDX(gvec_fmla_idx_d, float64, H8, 0, 0)
+DO_FMLA_IDX(gvec_bfmla_idx, bfloat16, H2, 0, 0)
 
 DO_FMLA_IDX(gvec_fmls_idx_h, float16, H2, INT16_MIN, 0)
 DO_FMLA_IDX(gvec_fmls_idx_s, float32, H4, INT32_MIN, 0)
 DO_FMLA_IDX(gvec_fmls_idx_d, float64, H8, INT64_MIN, 0)
+DO_FMLA_IDX(gvec_bfmls_idx, bfloat16, H2, INT16_MIN, 0)
 
 DO_FMLA_IDX(gvec_ah_fmls_idx_h, float16, H2, 0, float_muladd_negate_product)
 DO_FMLA_IDX(gvec_ah_fmls_idx_s, float32, H4, 0, float_muladd_negate_product)
 DO_FMLA_IDX(gvec_ah_fmls_idx_d, float64, H8, 0, float_muladd_negate_product)
+DO_FMLA_IDX(gvec_ah_bfmls_idx, bfloat16, H2, 0, float_muladd_negate_product)
 
 #undef DO_FMLA_IDX
 
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 30fa60f9a0..0d592bb467 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -373,16 +373,22 @@ SUMLALL_n1_d    11000001 011 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
 SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 SUMLALL_n1_d    11000001 011 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 
+BFMLA_n1        11000001 011 0 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=2
 FMLA_n1_h       11000001 001 0 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=2
 FMLA_n1_s       11000001 001 0 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=2
 FMLA_n1_d       11000001 011 0 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=2
+
+BFMLA_n1        11000001 011 1 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=4
 FMLA_n1_h       11000001 001 1 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=4
 FMLA_n1_s       11000001 001 1 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=4
 FMLA_n1_d       11000001 011 1 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=4
 
+BFMLS_n1        11000001 011 0 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=2
 FMLS_n1_h       11000001 001 0 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=2
 FMLS_n1_s       11000001 001 0 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=2
 FMLS_n1_d       11000001 011 0 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=2
+
+BFMLS_n1        11000001 011 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_h       11000001 001 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_s       11000001 001 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_d       11000001 011 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
@@ -489,16 +495,22 @@ USMLALL_nn_d    11000001 111 ....0 0 .. 000 ....0 1010 .    @azz_2x2_o1x4
 USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
 USMLALL_nn_d    11000001 111 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
 
+BFMLA_nn        11000001 111 ....0 0 .. 100 ....0 01 ...    @azz_2x2_o3
 FMLA_nn_h       11000001 101 ....0 0 .. 100 ....0 01 ...    @azz_2x2_o3
 FMLA_nn_s       11000001 101 ....0 0 .. 110 ....0 00 ...    @azz_2x2_o3
 FMLA_nn_d       11000001 111 ....0 0 .. 110 ....0 00 ...    @azz_2x2_o3
+
+BFMLA_nn        11000001 111 ...01 0 .. 100 ...00 01 ...    @azz_4x4_o3
 FMLA_nn_h       11000001 101 ...01 0 .. 100 ...00 01 ...    @azz_4x4_o3
 FMLA_nn_s       11000001 101 ...01 0 .. 110 ...00 00 ...    @azz_4x4_o3
 FMLA_nn_d       11000001 111 ...01 0 .. 110 ...00 00 ...    @azz_4x4_o3
 
+BFMLS_nn        11000001 111 ....0 0 .. 100 ....0 11 ...    @azz_2x2_o3
 FMLS_nn_h       11000001 101 ....0 0 .. 100 ....0 11 ...    @azz_2x2_o3
 FMLS_nn_s       11000001 101 ....0 0 .. 110 ....0 01 ...    @azz_2x2_o3
 FMLS_nn_d       11000001 111 ....0 0 .. 110 ....0 01 ...    @azz_2x2_o3
+
+BFMLS_nn        11000001 111 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
@@ -663,16 +675,22 @@ SUMLALL_nx_d    11000001 1001 .... 1 .. 00. ...01 10 ...    @azx_4x1_i3_o1
 @azx_4x1_i3_o3  ........ .... zm:4 . .. ... ..... .. off:3  \
                 &azx_n n=4 rv=%mova_rv zn=%zn_ax4 idx=%idx3_10_3
 
+BFMLA_nx        11000001 0001 .... 0 .. 1.. ....1 0 ....    @azx_2x1_i3_o3
 FMLA_nx_h       11000001 0001 .... 0 .. 1.. ....0 0 ....    @azx_2x1_i3_o3
 FMLA_nx_s       11000001 0101 .... 0 .. 0.. ....0 00 ...    @azx_2x1_i2_o3
 FMLA_nx_d       11000001 1101 .... 0 .. 00. ....0 00 ...    @azx_2x1_i1_o3
+
+BFMLA_nx        11000001 0001 .... 1 .. 1.. ...01 0 ....    @azx_4x1_i3_o3
 FMLA_nx_h       11000001 0001 .... 1 .. 1.. ...00 0 ....    @azx_4x1_i3_o3
 FMLA_nx_s       11000001 0101 .... 1 .. 0.. ...00 00 ...    @azx_4x1_i2_o3
 FMLA_nx_d       11000001 1101 .... 1 .. 00. ...00 00 ...    @azx_4x1_i1_o3
 
+BFMLS_nx        11000001 0001 .... 0 .. 1.. ....1 1 ....    @azx_2x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 0 .. 1.. ....0 1 ....    @azx_2x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 0 .. 0.. ....0 10 ...    @azx_2x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 0 .. 00. ....0 10 ...    @azx_2x1_i1_o3
+
+BFMLS_nx        11000001 0001 .... 1 .. 1.. ...01 1 ....    @azx_4x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
-- 
2.43.0


