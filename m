Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077D8C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONV-0001CM-Mw; Tue, 01 Sep 2026 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONU-0001Bm-9y
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:16 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONS-0007IX-FV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:16 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c1677c91969so461814266b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268693; x=1788873493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+xAOqROp7PfX4sYNT3aosDIIOAoBBxMX9Ys5U97vtnY=;
 b=ohqdXoFJxxd7wolJJ1BfTdk2ZUGzoghirSHU91F1e+5e4lWbZsvnkNrHAcloZ2DOyM
 oiJCq75MV+F6Gs7kUzDi47iU9WYFR72jr7oQ4ahmM2iRfrJjIERLpknMkalZBYYtt5PU
 PVIdxtf/Szck4RRk6XtAXvEi8eMD6clEWYHfoiJD0t/4P4FoyxtU6U6RZSlEy9CDfniC
 yc8Ui/tgAVV2m011P0OOy8s07LUWvybAxWXxqaQtyP9mvQErkYP8zC5BaKFuB5dMw4LK
 G1EYTvGGZvewe/gLbYxVYXPm7NcQFmGfRuqqcCUZ0NDWxKkf/z+xzCQ/W5jRfd10aW4D
 kZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268693; x=1788873493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+xAOqROp7PfX4sYNT3aosDIIOAoBBxMX9Ys5U97vtnY=;
 b=tWSkGh9enmW+R8czGZuLY+dHRLGbfMW4a0ndMR5uEMVSFGx1xuaeAS3LuBSJnYyMpr
 35JMZeMQa83CLPU04frtCwDLvtxCML1uI634Npvqg58gVEmvcdlJzGWA2c6guqNrVWyH
 7TW/0veVViM6ntb56p+KBX+NkVKkCh1QyVtaLuSn48ZpJTNcSItl3wUOwb0aN5JLtP0t
 n8SHhj/7Wf6bY00JTJ/cr9rRKxBzFyaDa0GZXMp4BtbDpZc3vsEsB5daE0lQ6KojWiuU
 t+dYo8iQkrqDWyUx2zCnLnNWJE/RUttqiS+Lo5af1+PNZjO0w+puwdT5UkBfDi4Lpwh2
 b+ow==
X-Gm-Message-State: AFuF++ngeFnHQmLL+vtwpVuy9juQVa1hDsWLt02ZSbb0F8LfhMr2daaS
 JfZA2fOMDjRCKj0NxSbnjp8c0/+vRHL0rbheNEKxqixNN/+s7UTV9TRRMOnHqjey5rqPSzRofQa
 HCfXiiXA=
X-Gm-Gg: AR+sD121Tn9g+XvEoOFJaPJIMuGZabuAxcXgxrDC4BqHMKk1QXu9AMLP1GUemW1KG25
 AjuapHG16/4cpHCzED6ovt7gVdEkE+vA9gktjIwBeVVmfffUd/S5NWHZXVOfUq3MfAh1drek1BN
 jr/23uId1EnMb1flIG8v0WceWZ/ZQU7azkFZghKrkkpMRpmZbbbZGoCKGEdTgfcTuu4Zeim8qOQ
 uUHzl//QdrfiaCSn+9haytSd4lhiyGfzSvT7wMDsdeMcqMjEFeg/eXEaxBJvlmXaA5gYMdZOV/G
 3ZU8g4+gICjX2Y45PfPmTrOAJHpAV83HmxPwPFn3dJcf2UDbX+Qohu/iShmXPgJEtC0ZWUWaCll
 ez+T5ZJXRXhbYorYiRgTf8cEpr3x2PT2aYYyI2I5vRMJLXikHAh/6tlgOCgc9ujaITXfqvrzuOd
 jOJzf7whSGmw9mxq4un7+deeaTNmI+oycFG+fbVqYCg2p7Zij176lShiwF5QQSwcnYTEcxc6ouY
 HadaQI3eFjDIjEVGIdfcT2lkL5i4JXJmeJTep3z99lUGUP/4VK/E4EkDMcEfjZd0+j3eQ==
X-Received: by 2002:a17:907:3e8d:b0:c21:601:6501 with SMTP id
 a640c23a62f3a-c25571d06f7mr2010440466b.20.1788268693069; 
 Tue, 01 Sep 2026 06:18:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/58] target/arm: Remove DO_ZPZZ_FP from translate-sme.c
Date: Tue,  1 Sep 2026 14:17:13 +0100
Message-ID: <20260901131732.2263947-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

Expand the macro at each use site.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 67 +++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0becef16a94..7e0b47412ba 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4425,13 +4425,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
  *** SVE Floating Point Arithmetic - Predicated Group
  */
 
-#define DO_ZPZZ_FP(NAME, FEAT, name) \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
-        NULL,                  gen_helper_##name##_h,           \
-        gen_helper_##name##_s, gen_helper_##name##_d            \
-    };                                                          \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
-
 #define DO_ZPZZ_AH_FP(NAME, FEAT, name, ah_name)                        \
     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
         NULL,                  gen_helper_##name##_h,                   \
@@ -4474,9 +4467,33 @@ DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
 DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sme_or_sve, sve_fminnum)
 DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sme_or_sve, sve_fmaxnum)
 DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
-DO_ZPZZ_FP(FSCALE, aa64_sme_or_sve, sve_fscalbn)
-DO_ZPZZ_FP(FDIV, aa64_sme_or_sve, sve_fdiv)
-DO_ZPZZ_FP(FMULX, aa64_sme_or_sve, sve_fmulx)
+
+static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve_fscalbn_h,
+    gen_helper_sve_fscalbn_s,
+    gen_helper_sve_fscalbn_d,
+};
+TRANS_FEAT(FSCALE, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fscalbn_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fdiv_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve_fdiv_h,
+    gen_helper_sve_fdiv_s,
+    gen_helper_sve_fdiv_d,
+};
+TRANS_FEAT(FDIV, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fdiv_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmulx_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve_fmulx_h,
+    gen_helper_sve_fmulx_s,
+    gen_helper_sve_fmulx_d,
+};
+TRANS_FEAT(FMULX, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmulx_zpzz_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve2_famax_zpzz_fns[4] = {
     NULL,
@@ -8067,9 +8084,33 @@ TRANS_FEAT_NONSTREAMING(HISTCNT, aa64_sve2, gen_gvec_ool_arg_zpzz,
 TRANS_FEAT_NONSTREAMING(HISTSEG, aa64_sve2, gen_gvec_ool_arg_zzz,
                         a->esz == 0 ? gen_helper_sve2_histseg : NULL, a, 0)
 
-DO_ZPZZ_FP(FADDP, aa64_sme_or_sve2, sve2_faddp_zpzz)
-DO_ZPZZ_FP(FMAXNMP, aa64_sme_or_sve2, sve2_fmaxnmp_zpzz)
-DO_ZPZZ_FP(FMINNMP, aa64_sme_or_sve2, sve2_fminnmp_zpzz)
+static gen_helper_gvec_4_ptr * const sve_faddp_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve2_faddp_zpzz_h,
+    gen_helper_sve2_faddp_zpzz_s,
+    gen_helper_sve2_faddp_zpzz_d,
+};
+TRANS_FEAT(FADDP, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpzz,
+           sve_faddp_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmaxnmp_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve2_fmaxnmp_zpzz_h,
+    gen_helper_sve2_fmaxnmp_zpzz_s,
+    gen_helper_sve2_fmaxnmp_zpzz_d,
+};
+TRANS_FEAT(FMAXNMP, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpzz,
+           sve_fmaxnmp_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fminnmp_zpzz_fns[4] = {
+    NULL,
+    gen_helper_sve2_fminnmp_zpzz_h,
+    gen_helper_sve2_fminnmp_zpzz_s,
+    gen_helper_sve2_fminnmp_zpzz_d,
+};
+TRANS_FEAT(FMINNMP, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpzz,
+           sve_fminnmp_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz, sve2_ah_fmaxp_zpzz)
 DO_ZPZZ_AH_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz, sve2_ah_fminp_zpzz)
 
-- 
2.43.0


