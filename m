Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5263AC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwid-0003Kd-DT; Wed, 02 Jul 2025 08:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgS-0008Qz-OV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:28 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg9-00019w-UR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:28 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so106111fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459700; x=1752064500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+s+ZlTZSdx2IsV1Mw0k5FpzYl0Ci7LN/Z5bZQkKSq0=;
 b=J+QfY4bDqKLBP1SB4yZ2Q61/xdisbrKEKZFC8XDyd/yhnGp1h+c2advbsDayqY+MOw
 0CQaQPxRUPpky5PmB9CwujVjJzj9uZNtl7kuL2kzz7BkF3cx4xTp/ufswver1/g1IBxd
 ZtEFE6bLNJ+Q2dwxtl6cSAPvzLU62MHv7kfm7m/Rl2eYGCgcteosrzDz23FxGzblPMt3
 KMrjD5ipGrNzurefUdzqEUS8THSzhrIvljZf6RlDAchyqy8I4iUjnkM3EnoYi5ZIyMCm
 7WxVveoFQZYVu71uGZrX4MiffKv6yrHcSSaoDWCUIlm58LquI+EXgQKQb722jOdPgr3b
 84Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459700; x=1752064500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+s+ZlTZSdx2IsV1Mw0k5FpzYl0Ci7LN/Z5bZQkKSq0=;
 b=rYPSlXQIF2QDFuK3DbZCpksDNHyRs8z8WOoaap0f+xy5gXhye8QvKs4OAOrnwE57jc
 7N60B+Ct1qk1sZ+ZKqIQTvMxJlr5uciv0bcTuXr4r0Rs6NbxZM0Ve8FeYqSNLJPYath1
 YN4ryU7wQ5VNMrYlZuDM+5uiHk0zc9LITgAFnDxVrR7Ik7e3p/FOt4pLX7Pt29LqqeDC
 rQwaIyTxn3u12EVZOADJIH+64T5ahrYZDIjzxmcSqfhIpsNLwiUpSsUii3jIgXka+igV
 wFLAV3Wh4ha5YR8sHp5MOmONRvmoj8/yAWScXI3rTY/txpb7yIWen8p2SGJ604bFb+BH
 VEnw==
X-Gm-Message-State: AOJu0Ywjp/ubgyOWCMLXXIVRDz+pwTOfPVoZZs5oeRITOow0mVo87I/i
 oxgIHkTimIv3NM+03ztL6pmHMjrlT59LCwFdwaOwb0QaleK8nIDzi4D/3nDP2tJAcPxyUhdCdwQ
 IHFXLJI8=
X-Gm-Gg: ASbGncv7HJpSXH/Z9euRYUPXkM0UDkkNLXAKJeKoOAVRfsB59X9MM4tSuNBzIK5kBm1
 GojvE7b5r7av1tCutaop5HTDTmBxcqLEGJntqasG4o5TrZv5LpMgloaxUOJt6E8eABq6Gfqloiw
 Ect4Ovy/R3Nv0GpL+6YR4pQwLaXONgtKOb/tf26FYh374dLyEPbzs4cKl/aOi70s2Xp3f0C9u5L
 V0DRzMbpvmJt/TWXqqeVzNrofpjcFsdLWFR7xnsdfGoblDTRlay0qznYArxF9br1qJLheXibM2y
 +4u3M1Ke/xZQamLw6qJB7cF1R4jUaP1AsBjtvGpeHa2Az0ZnkMrj1mokdREmIY3HI3AgCT+FX/M
 mO5PA
X-Google-Smtp-Source: AGHT+IGaj8nXzl3MbYlHav8rUyXlFR7FgDL01BghVqrYap90x0h0BseUphFgBSeqnf4lysPp6XAobg==
X-Received: by 2002:a05:6870:5d87:b0:2ef:e245:c65a with SMTP id
 586e51a60fabf-2f5c7a44f1bmr1913017fac.38.1751459700579; 
 Wed, 02 Jul 2025 05:35:00 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:35:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 39/97] target/arm: Implement SME2 BFMLA, BFMLS
Date: Wed,  2 Jul 2025 06:33:12 -0600
Message-ID: <20250702123410.761208-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h        |  9 +++++++++
 target/arm/tcg/translate-sme.c | 14 ++++++++++++++
 target/arm/tcg/vec_helper.c    | 26 ++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 18 ++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index b741470b51..37dd384659 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -799,14 +799,17 @@ DEF_HELPER_FLAGS_5(gvec_fmls_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i
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
@@ -838,6 +841,8 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmla_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_fmls_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
@@ -845,6 +850,8 @@ DEF_HELPER_FLAGS_6(gvec_fmls_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmls_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
@@ -852,6 +859,8 @@ DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmls_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 5f51369609..3f9a80248a 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1038,6 +1038,15 @@ TRANS_FEAT(FMLA_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
 TRANS_FEAT(FMLS_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_vfms_d : gen_helper_gvec_vfms_d)
 
+TRANS_FEAT(BFMLA_n1, aa64_sme_b16b16, do_fmla, a, false, FPST_ZA,
+           gen_helper_gvec_bfmla)
+TRANS_FEAT(BFMLS_n1, aa64_sme_b16b16, do_fmla, a, false, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls : gen_helper_gvec_bfmls)
+TRANS_FEAT(BFMLA_nn, aa64_sme_b16b16, do_fmla, a, true, FPST_ZA,
+           gen_helper_gvec_bfmla)
+TRANS_FEAT(BFMLS_nn, aa64_sme_b16b16, do_fmla, a, true, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls : gen_helper_gvec_bfmls)
+
 static bool do_fmla_nx(DisasContext *s, arg_azx_n *a,
                        ARMFPStatusFlavour fpst, gen_helper_gvec_4_ptr *fn)
 {
@@ -1058,6 +1067,11 @@ TRANS_FEAT(FMLA_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
 TRANS_FEAT(FMLS_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_fmls_idx_d : gen_helper_gvec_fmls_idx_d)
 
+TRANS_FEAT(BFMLA_nx, aa64_sme_b16b16, do_fmla_nx, a, FPST_ZA,
+           gen_helper_gvec_bfmla_idx)
+TRANS_FEAT(BFMLS_nx, aa64_sme_b16b16, do_fmla_nx, a, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls_idx : gen_helper_gvec_bfmls_idx)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e03db47ef7..f4373dd4bf 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1608,6 +1608,12 @@ static float16 float16_muladd_f(float16 dest, float16 op1, float16 op2,
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
@@ -1626,6 +1632,12 @@ static float16 float16_mulsub_f(float16 dest, float16 op1, float16 op2,
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
@@ -1644,6 +1656,12 @@ static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
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
@@ -1677,14 +1695,19 @@ DO_MULADD(gvec_fmls_nf_s, float32_mulsub_nf, float32)
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
@@ -1803,14 +1826,17 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
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
index 962ffae3d6..b3dd3bffc3 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -370,16 +370,22 @@ USMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
 SUMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
 SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 
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
@@ -484,16 +490,22 @@ UMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
 USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 0010 .    @azz_2x2_o1x4
 USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 0010 .    @azz_4x4_o1x4
 
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
@@ -652,16 +664,22 @@ SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
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


