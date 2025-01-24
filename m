Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68067C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMbA-00026a-8z; Fri, 24 Jan 2025 11:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYg-0004P2-Do
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYe-0005be-7K
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so24607945e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736162; x=1738340962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2VLdsf7Pn6hVzCCffEPe1bVqQf+9Fb334tfF7e6kw7Y=;
 b=eHMaIdcVHd+fSZeR0iCvT8uDUnM3PYM0dEwUAiucbKXfwfPRcXmiU2/Jg5H00EvWh3
 e+wIZz7whuJpbY1NPv3Ynkfis5n6RlfTYgk8T7PdjZ+Kgkrqtugo+/jppLv+FVX9BSIS
 d28Ab4x7TBelZ5yAOR407KlGTL0Fgk61Fa+yf42t8nnQFEgkj/4tqQNrpW+nPBtHDNMf
 OcOvvq3zbDWhxzKVIKK6q3SgkVzsxTLR7j3MK8om/KWW1k1wQY65mQJ5ZJlYz4Z/Dy0r
 88lh7HDQQocY6hIvxboD7r2+43HGBnYaeQNKw6S1gfFmO3dETr1saxxbAoKy0Gmi//eD
 SNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736162; x=1738340962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VLdsf7Pn6hVzCCffEPe1bVqQf+9Fb334tfF7e6kw7Y=;
 b=CKr7t0wx6YYAwVIMqBc/jqEkHoZqlpKXDQuW+4mS7flSvOdPJaRacXFpGEH9Dkbyoi
 Q0EZUd9/NY7ntixfjEKVGHt7J8zF3SFPgE9pUlVo/h9iX8OyqnmmH6jbymrlyestLHRv
 mjCAqPvMjo9ygXncoi/5RkjT1X7N6cDlieJ/Nc1S23HPJlK8wqDnT/VZNZo1CmV3D4z6
 Z4wGw1QRl1GrwWifq/08wzyNycPGqd0uC3aJun4EoA1akZ2CFsHHACv84+2jAs7l4oAy
 WnX9RkZ8jeZYz7ow7hvxY1+VXOxSgi+0rGwfmF2RURdHp32c7z5N6bCHQZVRvSevMOqU
 o7+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL9YIkMmuVzLVOKf5R/90sGNvcwObwteFaP0kKM9EmKLA6aNhDaEEuSX6vuFMnLkzYXmiUTvdbsOtC@nongnu.org
X-Gm-Message-State: AOJu0YwLDMaMKwXnml6fTAwHtNQXuAtAboRsFRjMkFvY22KdSEL4xcMV
 3lgaiUBp4y+vYz/UzOITvAdaAZRsTCoI8HsRaN2nMMVBPNMXDWbZ3c7ACHcsm/eM8K1PtnD1iBi
 d
X-Gm-Gg: ASbGncu72mfrNfEX8XLbTxgdwaXUgqbiJfxwh2rICyA/0vhG7tZuwOhtsiFHe2Qvr/2
 c9i1w+1l+Tt4NARiYtvecziplXyJcLsO6Q2gdKtgo5Oia6vU8cNJ2l/JNu+xXRQ7kpTUeYgiRDK
 oMxheVWwczBUcjLphgKsKqbOTNdQLmMcEojQr8tO7iLajoGJw/GKnxevCiKnynBv8+kBK4Vy4mX
 qa9stjPyBMtcLgXm9PJzQZmcg7bBctZKAvS00xpc/5W44zP5GkgGCLv7YtYB1uuFEXqcESnvXns
 vM68Acjglyw=
X-Google-Smtp-Source: AGHT+IGGd1H91HPHlXZByyQ0nANLTS9iQ2S7qofhs99/D/72hx9lzN6NzHo7tHjcRwzXPV22exPCTg==
X-Received: by 2002:a05:600c:1c1e:b0:436:6460:e67a with SMTP id
 5b1f17b1804b1-43891452899mr251176375e9.25.1737736161721; 
 Fri, 24 Jan 2025 08:29:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 35/76] target/arm: Use FPST_FPCR_AH for BFMLAL*, BFMLSL* insns
Date: Fri, 24 Jan 2025 16:27:55 +0000
Message-Id: <20250124162836.2332150-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/arm/tcg/translate-a64.c | 20 +++++++++++++-------
 target/arm/tcg/translate-sve.c |  6 ++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d53864ad794..0b3e4ec136d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -765,10 +765,11 @@ static void gen_gvec_op4_env(DisasContext *s, bool is_q, int rd, int rn,
  * an out-of-line helper.
  */
 static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
-                              int rm, int ra, bool is_fp16, int data,
+                              int rm, int ra, ARMFPStatusFlavour fpsttype,
+                              int data,
                               gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm),
@@ -5837,7 +5838,8 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     }
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
-        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, false, a->q,
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
+                          s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64, a->q,
                           gen_helper_gvec_bfmlal);
     }
     return true;
@@ -5870,7 +5872,8 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      a->esz == MO_16, a->rot, fn[a->esz]);
+                      a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                      a->rot, fn[a->esz]);
     return true;
 }
 
@@ -6450,7 +6453,8 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      esz == MO_16, (a->idx << 1) | neg,
+                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                      (a->idx << 1) | neg,
                       fns[esz - 1]);
     return true;
 }
@@ -6585,7 +6589,8 @@ static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
     }
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
-        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, 0,
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
+                          s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64,
                           (a->idx << 1) | a->q,
                           gen_helper_gvec_bfmlal_idx);
     }
@@ -6614,7 +6619,8 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     }
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          a->esz == MO_16, (a->idx << 2) | a->rot, fn);
+                          a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                          (a->idx << 2) | a->rot, fn);
     }
     return true;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4d77b55d545..ad415c43565 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7117,7 +7117,8 @@ TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
 static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal,
-                              a->rd, a->rn, a->rm, a->ra, sel, FPST_FPCR_A64);
+                              a->rd, a->rn, a->rm, a->ra, sel,
+                              s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
@@ -7127,7 +7128,8 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal_idx,
                               a->rd, a->rn, a->rm, a->ra,
-                              (a->index << 1) | sel, FPST_FPCR_A64);
+                              (a->index << 1) | sel,
+                              s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-- 
2.34.1


