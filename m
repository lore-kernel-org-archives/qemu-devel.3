Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356FFCD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFK-0006A1-0s; Tue, 16 Jun 2026 15:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Q-0004dj-1A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8K-0001Aa-Vt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-461a15bb819so939451f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636854; x=1782241654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JXl9aM3YjYB0IaDfx/Jq49OoS0qkx8Ry7BVlhdhFJ5k=;
 b=x6TH0RjTXW5yNJ5O0mRns8SusjeUzDgZxlU+vjnud/39kLCXxFtdWOvQW6OtJuaZdm
 pl/HUsock7sva5GhrTpmn9yFxrW7oFFPmBjK4TuSmrBj5dnZ3GKzyjTWQZ+26nJkDYER
 IsMpg8VJFFDtWKbOvkkqsfVl2hl7vy/kX9UURm4aWccRTOKpm9vrkAt/TEU9mK3mO8My
 HrPGic47hryU3DdDa4XtBqqzYvbYcsTYs+y6P+sPANxzyDjGIefY5DKB+IYHcISXhTh/
 u8rjfjSBfWZZd/qj8IA9SQGl2s5wHEf9Y6Wr9dHWo6NNZ6kx3PUbMOW0jb3W6BC9WK34
 eq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636854; x=1782241654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JXl9aM3YjYB0IaDfx/Jq49OoS0qkx8Ry7BVlhdhFJ5k=;
 b=IfnsUICn3SbdmKriA1s8b0Q7OExLGghb/Yq7QSQobEhYuWYPtRYbd3rNYsCbktm1mh
 nfgZooqffWq+XhG2Rc0cpLNHXhXnaPWYkdIteN7wRMx1wVdIPAgVCX7smlE8VHO5Tu/a
 5tLuoDL3j2QbacWpq0UpTLlB67gTcrDxuKw5dyIxTG7aCQH72KA2yDT7VdicplfMU3Hy
 chxCCqGuln1FBCvWGChVa6nrOLFfr+FrKpEE2aeseCnfFFJwwZedmnvSgmG1pHXQjOXp
 c7cwsNQUtg18ASmxaYES6PNI2eETSpOVLdl6dXEnuMa//FLZg+8uCaZDWMPVSxpU99cp
 szsA==
X-Gm-Message-State: AOJu0YxXph/r1utQGbNTRD42FWpSnOxy52d8aOb4IQNQ0eC/Cix8V4Z/
 RbAa7ZL5pRzmALRG+CSvm0FRMZULx8YBAhwbDmvpniQ63ZTPevqGM41C4+ZN4Wm2CA7rjlcNUf7
 pNLKr
X-Gm-Gg: Acq92OGWzEvNvuxDDr27sqvrZEsYAQoI1QVXcedHQ+035AGMXfVRlpDf2Zj/ZlMCG1b
 pDCFDPtiVXwOl9d4NRmIVYykPbMvPrwTI/EMtpdvcXeUOLjhMKQ0xIaP1e5qYKU0xELH9uTo1yQ
 A7YZYEiixe9ufzYo31bvzyujwcgow4jxalYuQgj+yZTdiAoChtqqOWmcB/rKf478CpHc0H7wJLn
 s7F5yF63flC7Xy0fox4DeSeRqkD9VhkjUVe9yk66E2uIIOrkQ209krI/lr5vozAz/VNj+GthFRu
 mb7ahY+kUpCvJsV3uYa10MzraXlxkK9rEU9lpadU9+ctswZkpWC/UtJS/ERVWFDBrZi4mabTxyU
 /3DLpyxK7LD285OaoPOVYkjJscy01GBsDWMmR0Rb0+Kxow6ANFfBl7qPQKPrHkO5R+k7mJROl0Q
 FvMzDtILLGWuMzHBxef6Mg0kw6k4tzOQg15xIiWjzXF8RcBA61mAEjfrySA9h0hC4KBiEFVCTaq
 cY/HeacmIreKZCnGJaxkZV0xl6uqz7e
X-Received: by 2002:a05:6000:22c4:b0:45e:fb69:f02b with SMTP id
 ffacd0b85a97d-4623f2e7641mr943955f8f.1.1781636854169; 
 Tue, 16 Jun 2026 12:07:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/61] target/arm: Expand DO_ZPZ in translate-sve.c
Date: Tue, 16 Jun 2026 20:06:24 +0100
Message-ID: <20260616190639.3462006-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Prepare for adding zeroing instructions for some of these.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 84 +++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4fd17905d5..8ab4526468 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -776,24 +776,74 @@ TRANS_FEAT(SEL_zpzz, aa64_sme_or_sve, do_sel_z, a->rd, a->rn, a->rm, a->pg, a->e
  *** SVE Integer Arithmetic - Unary Predicated Group
  */
 
-#define DO_ZPZ(NAME, FEAT, name) \
-    static gen_helper_gvec_3 * const name##_fns[4] = {              \
-        gen_helper_##name##_b, gen_helper_##name##_h,               \
-        gen_helper_##name##_s, gen_helper_##name##_d,               \
-    };                                                              \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_ool_arg_zpz, name##_fns[a->esz], a, 0)
+static gen_helper_gvec_3 * const sve_cls_fns[4] = {
+    gen_helper_sve_cls_b, gen_helper_sve_cls_h,
+    gen_helper_sve_cls_s, gen_helper_sve_cls_d,
+};
+TRANS_FEAT(CLS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cls_fns[a->esz], a, 0)
 
-DO_ZPZ(CLS_m, aa64_sme_or_sve, sve_cls)
-DO_ZPZ(CLZ_m, aa64_sme_or_sve, sve_clz)
-DO_ZPZ(CNT_zpz_m, aa64_sme_or_sve, sve_cnt_zpz)
-DO_ZPZ(CNOT_m, aa64_sme_or_sve, sve_cnot)
-DO_ZPZ(NOT_zpz_m, aa64_sme_or_sve, sve_not_zpz)
-DO_ZPZ(ABS_m, aa64_sme_or_sve, sve_abs)
-DO_ZPZ(NEG_m, aa64_sme_or_sve, sve_neg)
-DO_ZPZ(RBIT_m, aa64_sme_or_sve, sve_rbit)
-DO_ZPZ(ORQV, aa64_sme2p1_or_sve2p1, sve2p1_orqv)
-DO_ZPZ(EORQV, aa64_sme2p1_or_sve2p1, sve2p1_eorqv)
-DO_ZPZ(ANDQV, aa64_sme2p1_or_sve2p1, sve2p1_andqv)
+static gen_helper_gvec_3 * const sve_clz_fns[4] = {
+    gen_helper_sve_clz_b, gen_helper_sve_clz_h,
+    gen_helper_sve_clz_s, gen_helper_sve_clz_d,
+};
+TRANS_FEAT(CLZ_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_clz_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve_cnt_zpz_fns[4] = {
+    gen_helper_sve_cnt_zpz_b, gen_helper_sve_cnt_zpz_h,
+    gen_helper_sve_cnt_zpz_s, gen_helper_sve_cnt_zpz_d,
+};
+TRANS_FEAT(CNT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cnt_zpz_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve_cnot_fns[4] = {
+    gen_helper_sve_cnot_b, gen_helper_sve_cnot_h,
+    gen_helper_sve_cnot_s, gen_helper_sve_cnot_d,
+};
+TRANS_FEAT(CNOT_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cnot_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve_not_zpz_fns[4] = {
+    gen_helper_sve_not_zpz_b, gen_helper_sve_not_zpz_h,
+    gen_helper_sve_not_zpz_s, gen_helper_sve_not_zpz_d,
+};
+TRANS_FEAT(NOT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_not_zpz_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve_abs_fns[4] = {
+    gen_helper_sve_abs_b, gen_helper_sve_abs_h,
+    gen_helper_sve_abs_s, gen_helper_sve_abs_d,
+};
+TRANS_FEAT(ABS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_abs_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve_neg_fns[4] = {
+    gen_helper_sve_neg_b, gen_helper_sve_neg_h,
+    gen_helper_sve_neg_s, gen_helper_sve_neg_d,
+};
+TRANS_FEAT(NEG_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_neg_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve_rbit_fns[4] = {
+    gen_helper_sve_rbit_b, gen_helper_sve_rbit_h,
+    gen_helper_sve_rbit_s, gen_helper_sve_rbit_d,
+};
+TRANS_FEAT(RBIT_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_rbit_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve2p1_orqv_fns[4] = {
+    gen_helper_sve2p1_orqv_b, gen_helper_sve2p1_orqv_h,
+    gen_helper_sve2p1_orqv_s, gen_helper_sve2p1_orqv_d,
+};
+TRANS_FEAT(ORQV, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zpz,
+           sve2p1_orqv_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve2p1_eorqv_fns[4] = {
+    gen_helper_sve2p1_eorqv_b, gen_helper_sve2p1_eorqv_h,
+    gen_helper_sve2p1_eorqv_s, gen_helper_sve2p1_eorqv_d,
+};
+TRANS_FEAT(EORQV, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zpz,
+           sve2p1_eorqv_fns[a->esz], a, 0)
+
+static gen_helper_gvec_3 * const sve2p1_andqv_fns[4] = {
+    gen_helper_sve2p1_andqv_b, gen_helper_sve2p1_andqv_h,
+    gen_helper_sve2p1_andqv_s, gen_helper_sve2p1_andqv_d,
+};
+TRANS_FEAT(ANDQV, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zpz,
+           sve2p1_andqv_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const fabs_fns[4] = {
     NULL,                  gen_helper_sve_fabs_h,
-- 
2.43.0


