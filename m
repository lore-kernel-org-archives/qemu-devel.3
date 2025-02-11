Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179B3C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6e-0008OK-9C; Tue, 11 Feb 2025 11:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5S-0006RK-VS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5Q-00035V-FL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439307d83f0so21625745e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291171; x=1739895971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D/eP+ryEDrLuhmGTZqkuQ3Gk2vsXpeVl4GK2HAEDsP4=;
 b=b4MKrQk6klqKAiDvM3WEwHL7R+SXbForzv5PBzFJ/uzHPudL/60aO/6J4NKHl0d/Wf
 sqDbV8iGQ+c0oaksPDRgbvOseW4z9ZAxEB9PAT5FWlxJ2IMEtbJk6243Pu/9IRWLEgjZ
 vgzarHQ6MryCwv7nUhUtAO7LHRvuHwGs22tmAdpNnQj7hj6oz0SKcjXci9yOlguq2f9K
 7uo0yyQwSKiAyVP04kSVVzUbXtKV1mt9kr03F167wujhja+Bm2skDMWHM5mii7EC+jOO
 5/jfZgAINcNCEEakvQfPHdcTqRuxOMlXlN7nnf+IxrEfEL3Uxpi0V635Ol2UOcNM6OGt
 hvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291171; x=1739895971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/eP+ryEDrLuhmGTZqkuQ3Gk2vsXpeVl4GK2HAEDsP4=;
 b=M5ucXT5YWRnZuyvGjxLJBBf93vdfgpDUodvwgGO1TtEWSdexo2kdoPE0QJfocbv+1t
 FzZ6KhsUHoxNB0fGB6xQ44VxQ5CBuBRgRu8hXbuPckHTL2x3bED541mM1iA8Znr12u23
 aWln/E1wjkYTME0GGN4EqpAfLKl7JBrqrCC32heEOxsoarim9j5WKUVXc8+ScSsCd4R2
 lB4xWg+RAs7fIeD5l2qB3HVtf9Zj6TPq4wpzoEgMrwd5WDDGsR9ds1sveVL3/OCEo+T+
 fIt8sRnBoJoQ/B4IDXQ8mi3yv5Zp4RrPWSFfUN6xZeC32M3T3LFRe9Dtn6OxyTXlpdG4
 bt8Q==
X-Gm-Message-State: AOJu0YxPxLN9YGeOmqd7LKIH/cqXc0Qc6EVw8956ZE0Fu0q7swNotAmQ
 789rpMtb+XETKoXVyt+m2EvOeP9CPUdJRfXGmmRsXIifKAOpvG3i8VFH+X2/OdwSCcbSHFZ+t2i
 B
X-Gm-Gg: ASbGnctjDHgpdh7mVUwmR6NVakNQUxtHgEXWl/GZ2Pd2L0Ow5Nl/xuC+xfUkxRpdMV0
 Dw4SDC2Njw33SgALqryfKFUdEsIOeDLF9qvFYpngSsgzhio1wHXCQEI5YPaELaI03B8aGB+8Rry
 ZGF8ZW30t0ngP3JeplXie1KoC/ZTpTW1WHueCld3h5bNrfZFkI4cugJ31uF2i+hvHf1IoUQYrvV
 TneZFuvbxt6oSgKpyOO3D5iVm5d3bN70NcQuD4eHs2C8G46+ee7yzLNA4zgSkkkbYUcBW9UpaZN
 zfRAGIXYM0PoRRfLODRQ
X-Google-Smtp-Source: AGHT+IF8yTI91Q10tsGq3UFEuTgp+T/Dl5mP661VKqjdfSGQblyHLU5Q8qu6JIrjF2uz1DctPH/5Cg==
X-Received: by 2002:a05:600c:1c07:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4392497db5fmr156168075e9.3.1739291170908; 
 Tue, 11 Feb 2025 08:26:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/68] target/arm: Use FPST_FPCR_AH for BFMLAL*, BFMLSL* insns
Date: Tue, 11 Feb 2025 16:24:59 +0000
Message-Id: <20250211162554.4135349-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

When FPCR.AH is 1, use FPST_FPCR_AH for:
 * AdvSIMD BFMLALB, BFMLALT
 * SVE BFMLALB, BFMLALT, BFMLSLB, BFMLSLT

so that they get the required behaviour changes.

We do this by making gen_gvec_op4_fpst() take an ARMFPStatusFlavour
rather than a bool is_fp16; existing callsites now select
FPST_FPCR_F16_A64 vs FPST_FPCR_A64 themselves rather than passing in
the boolean.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 20 +++++++++++++-------
 target/arm/tcg/translate-sve.c |  6 ++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f3028463e36..f9b62a2c4fd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -754,10 +754,11 @@ static void gen_gvec_op4_env(DisasContext *s, bool is_q, int rd, int rn,
  * an out-of-line helper.
  */
 static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
-                              int rm, int ra, bool is_fp16, int data,
+                              int rm, int ra, ARMFPStatusFlavour fpsttype,
+                              int data,
                               gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm),
@@ -5826,7 +5827,8 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     }
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
-        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, false, a->q,
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
+                          s->fpcr_ah ? FPST_AH : FPST_A64, a->q,
                           gen_helper_gvec_bfmlal);
     }
     return true;
@@ -5859,7 +5861,8 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      a->esz == MO_16, a->rot, fn[a->esz]);
+                      a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                      a->rot, fn[a->esz]);
     return true;
 }
 
@@ -6439,7 +6442,8 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      esz == MO_16, (a->idx << 1) | neg,
+                      esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                      (a->idx << 1) | neg,
                       fns[esz - 1]);
     return true;
 }
@@ -6574,7 +6578,8 @@ static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
     }
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
-        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, 0,
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
+                          s->fpcr_ah ? FPST_AH : FPST_A64,
                           (a->idx << 1) | a->q,
                           gen_helper_gvec_bfmlal_idx);
     }
@@ -6603,7 +6608,8 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     }
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          a->esz == MO_16, (a->idx << 2) | a->rot, fn);
+                          a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                          (a->idx << 2) | a->rot, fn);
     }
     return true;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index be2b5528ba0..e38a49dd31c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7117,7 +7117,8 @@ TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
 static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal,
-                              a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
+                              a->rd, a->rn, a->rm, a->ra, sel,
+                              s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
@@ -7127,7 +7128,8 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal_idx,
                               a->rd, a->rn, a->rm, a->ra,
-                              (a->index << 1) | sel, FPST_A64);
+                              (a->index << 1) | sel,
+                              s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-- 
2.34.1


