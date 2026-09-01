Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F901C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONZ-0001Dv-FW; Tue, 01 Sep 2026 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONX-0001Ct-0R
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:19 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONV-0007Ju-Df
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:18 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15e592da74so567781866b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268696; x=1788873496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YSrvZ4Rhcw1n3WZsHzE3E0qS5jCZCm+NTt1dWv0DclQ=;
 b=HCfVQebw/G20UYaiS33zcmlY93n5b+7AJZtUNNbaWq+X+2S4t3OZLznTlWxAO8hgmo
 qRBYOcaRoE8DONY+bzdTml3xbm46Q4jcKl6IiXW/aw3BCeJBYs2GccS3jNJMeeRMkKZ/
 k2mKojZw5wlKj7O3Q73lTTFv2GyDBjY3l4+pYy0sKK91blcpM+lQrI6/S+S7Dd1LCX2p
 osnV/7SX8p43nVZ4coIdSTCdp0z9Qw1OVxpzCjDEWickW28p1KF1vDimBtDWCWcbRNVA
 cfABkrsWQeNZnrM3iWgg06FmSCxXJUGwX9g2ZRexEpickXIx1vkM+PgTrI0fL3BqQrrR
 ethA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268696; x=1788873496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YSrvZ4Rhcw1n3WZsHzE3E0qS5jCZCm+NTt1dWv0DclQ=;
 b=DaXSFAeVF59x12Ah5YOy3JpymFUlwlKmo5dIePZMEhLIzY4fTDXWlRvdPzacSOVzYa
 3QpGUMNk/lrv4EvqbKpLgRWpM4EFmblAhlCmUWeEpRRxmgdCW/vcPlt1V5sr411xlR8X
 f2YX4CJj5uLXgTXq/NW7fiTMHrcwkMT8i6n9Pg9fMd33ipnBdLqUMeC/Qa1NG3gRsAO+
 za91z7YwV+m/3gKPX69GX3vx1IkiSbn3Tq4ne0fVqcyJgsWaqHKkLRzv7PO8OZO0lXty
 51Dsad/aEMqVc4/N/dk3hq+WnYsiStBKSiGlvXLoxp2w6hijj4Z88rm8YeHZgChCkuyE
 WOaw==
X-Gm-Message-State: AFuF++lbYXRsEVSFD7BDsnCtmwWAEBYRDAjBn4EgG+tNKZyNxHzt8vcB
 398jO60Oy8hIaIF8R0ZaI9/x9b7jBi/qEBBSTfqvZuRKkCqSmGLXTCTUbyTbjV78WGPc5tMVoYS
 XeUovDb0=
X-Gm-Gg: AR+sD13e6UmvnZGM7zzoklmQYQBiqEQVQRLiF8whls/MhMSkiZxso1xfcDWyV4qBWHR
 cgRYHB6IZ0pSNrWYW3gn5vFy+rmMqSrEPGldMmmvvWCLMVyPsmnc/9jzsnY2ca8lrln0DVlG8sa
 xrnIwhnALMWtdTusE0tK2KqmeEZXHigOBUOXd+IV46osk4UJPmM9Uq7QQTFS4fV7TJJg2qNZhEi
 k8gtX0tp6/MMq44Gx8HrtX1W5Bf67bPEYM4xAkQVHIDcut4YXd0+7njsGKj2glj0BxDHBnbJl4s
 iBl3pvXy7/Nq9w+/y/A2RzF/EXlgJ5os1v2kQZ3cOfQjv5F54ul5LSef/udvkiVCOx/pRwaSh/w
 j4C+1MiIbQzMsWasHsyynuKMkBY7ecAM3xdT8EwPwTFxmoyLsBXC3xbA3rvKtSPkEPWNWIXoJUI
 eS4pmZZ36i/RYg01fhGZ4+xX4RhX0p36yyhl5qn1h/iCp/SwQwI64CTwMG7n5pA2TTSynvZHaxq
 2bjo5+AxnDi3aSB8+1ba4grSGY5Xx2JAfvk9BuLqapxljI3S7l8fo04fNkAl7zIos+06e05mGBW
 uYcs
X-Received: by 2002:a17:907:1b20:b0:c25:89fa:5a8e with SMTP id
 a640c23a62f3a-c2589fa6169mr1219832866b.10.1788268695900; 
 Tue, 01 Sep 2026 06:18:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/58] target/arm: Remove DO_ZPZZ_AH_FP_B16 from translate-sme.c
Date: Tue,  1 Sep 2026 14:17:16 +0100
Message-ID: <20260901131732.2263947-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Merge the two arrays and index by fpcr_ah.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6e984d02f82..f65c2b0af53 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4425,19 +4425,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
  *** SVE Floating Point Arithmetic - Predicated Group
  */
 
-#define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
-        gen_helper_##name##_b16, gen_helper_##name##_h,                 \
-        gen_helper_##name##_s, gen_helper_##name##_d                    \
-    };                                                                  \
-    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
-        gen_helper_##ah_name##_b16, gen_helper_##ah_name##_h,           \
-        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
-    };                                                                  \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
-               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
-               name##_zpzz_fns[a->esz], a)
-
 static gen_helper_gvec_4_ptr * const sve_fadd_zpzz_fns[4] = {
     gen_helper_sve_fadd_b16,
     gen_helper_sve_fadd_h,
@@ -4465,8 +4452,23 @@ static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
 TRANS_FEAT(FMUL_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fmul_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sme_or_sve, sve_fmin, sve_ah_fmin)
-DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
+static gen_helper_gvec_4_ptr * const sve_fmin_fns[4][2] = {
+    { gen_helper_sve_fmin_b16, gen_helper_sve_ah_fmin_b16 },
+    { gen_helper_sve_fmin_h, gen_helper_sve_ah_fmin_h },
+    { gen_helper_sve_fmin_s, gen_helper_sve_ah_fmin_s },
+    { gen_helper_sve_fmin_d, gen_helper_sve_ah_fmin_d },
+};
+TRANS_FEAT(FMIN_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmin_fns[a->esz][s->fpcr_ah], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmax_fns[4][2] = {
+    { gen_helper_sve_fmax_b16, gen_helper_sve_ah_fmax_b16 },
+    { gen_helper_sve_fmax_h, gen_helper_sve_ah_fmax_h },
+    { gen_helper_sve_fmax_s, gen_helper_sve_ah_fmax_s },
+    { gen_helper_sve_fmax_d, gen_helper_sve_ah_fmax_d },
+};
+TRANS_FEAT(FMAX_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmax_fns[a->esz][s->fpcr_ah], a)
 
 static gen_helper_gvec_4_ptr * const sve_fmaxnum_fns[4] = {
     gen_helper_sve_fmaxnum_b16,
-- 
2.43.0


