Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB68C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONY-0001Cw-1p; Tue, 01 Sep 2026 09:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONW-0001CX-5H
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:18 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONU-0007JY-D5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:17 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso164200666b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268695; x=1788873495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1ImiUh1kTDR8eHJXplIXTJFDbp7qOBySF2XtCDZMRgM=;
 b=E4eADEtkYhutztpsRP2M5nI6YEGBIFFWGzEe7/49BUwzJr8p7K7bmtNihUvMjU9dxd
 tWEiJtPARyjmE8PPzLRiBmp3AYdPhPELN1E4XKt0odhOKLzVx7A5awaETj6RTFWNiQiV
 /wxUTTGVEl6y1zjxqOIVEmvPgFw3L9o1PYDmdLT+gy009z+KVZ4ruHXT6A8T8hKsVLYI
 947pVHgPhbMaCHFd/LSmtCqRCesClrMWsq+c4TxEPUWqP06cwovvSs+/ABWnPMMHHV7B
 d5502rasTGO3zVli0t7ClDGqjRntmcB6DKe/PSu1jNxGt334btdGcDpS++skLYRif5au
 Nnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268695; x=1788873495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1ImiUh1kTDR8eHJXplIXTJFDbp7qOBySF2XtCDZMRgM=;
 b=FHZXjTwJvzWXGbiPeG5s8LGSGdl2U6N61+sTem8WNHwQFefrbp42jUdjMUYt5rrHiB
 x1UhgHrH9O3Sd/pddxOyNmkTPa9RiSRbcf+EkPOoojTcJBR0Tc3fOFrRw0WDQ23QGLXc
 rWTcIIjUy+fS6lwgxwqHM66wx3ku0X0iAD/wt+3smZ0To+LTKW5Wn9QDepOYdXhLqcMC
 wyfkjupufFo62P5omMhyZq521scZwKRDICbs3ZKS+XfgWSbRcZCG38rZeJ0jyphAJ4AP
 yytv1B1QCVU9XDxM0wIl3dUemdhy+LmLGbmOld1ypL75twlRaErHDU5fS2K0N3bFthdk
 CY9g==
X-Gm-Message-State: AFuF++lDrD7DXSoG527RXXRfY0240zWp+H1upcaZd0bVn7Z9MSRfJGjP
 6ECxVG+Lwwi6fN64FwgJs8xzJRd89FccUiiJOSEvyi3mDXGMEfJ9WG30PBokLVcX+m0ftKKO0pS
 +WsvWiQg=
X-Gm-Gg: AR+sD11488OSBbGcAQmG7iDh9SdyzSG28T5Qw2IIt6nEnX9FyUFqQKJevL3QzeprlJy
 bfChj9WU0QYfOWhNMgK8l+Bf7tbuQsoQsMwuq5lW2SLEYxsWOjqNaw2LdwvMujlEAX9NlfeyNq4
 2dTY4ju/2gPRTZsO/CM70tJu02JJ+eJ1Muf1+CZz7UrshPSIdK+k7I6SfMxRcINT/ZsGaHL4LF7
 fc8F97A6TEy4T6NC703ERVCBlxh2REJ3hBk8UX+sj0V1jH6cyaCej9AWi8yHOFra67ukgNmPfuL
 Ra7RMT/R+6nwbSKwKZdzE0gdKOtNSfGVga7YbKRtRznO2zCbJVbL+4dnzYMGudkcpBmFgPjuhVp
 tpzIv7Vujbs25eFihHL11KgO1MBpVJDWbF0TcFqnsZnpPafwlN/iSGeEr1qn9v5I69Tm+UeCu8t
 rC1g9QZrSGctwW3aDD1nOVL0QZSUPM2hOvBHrS+2OE66sa4lvK9Ow68Uy1rYr/xyB9JYjg/ha5x
 QqOjDZDl1pT3laLfgHkO3CjSsSe/XBx+pFZlYydcRMehwX/7hsChG7m64vWrkxDA0ltDw==
X-Received: by 2002:a17:907:c02:b0:c25:4612:2efd with SMTP id
 a640c23a62f3a-c2557167f51mr2170655266b.9.1788268694879; 
 Tue, 01 Sep 2026 06:18:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/58] target/arm: Remove DO_ZPZZ_AH_FP from translate-sme.c
Date: Tue,  1 Sep 2026 14:17:15 +0100
Message-ID: <20260901131732.2263947-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Message-id: 20260826174213.614571-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 41 +++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 347eeb4602e..6e984d02f82 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4425,19 +4425,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
  *** SVE Floating Point Arithmetic - Predicated Group
  */
 
-#define DO_ZPZZ_AH_FP(NAME, FEAT, name, ah_name)                        \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
-        NULL,                  gen_helper_##name##_h,                   \
-        gen_helper_##name##_s, gen_helper_##name##_d                    \
-    };                                                                  \
-    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
-        NULL,                  gen_helper_##ah_name##_h,                \
-        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
-    };                                                                  \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
-               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
-               name##_zpzz_fns[a->esz], a)
-
 #define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
         gen_helper_##name##_b16, gen_helper_##name##_h,                 \
@@ -4499,7 +4486,14 @@ static gen_helper_gvec_4_ptr * const sve_fminnum_fns[4] = {
 TRANS_FEAT(FMINNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fminnum_fns[a->esz], a)
 
-DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
+static gen_helper_gvec_4_ptr * const sve_fabd_zpzz_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_sve_fabd_h, gen_helper_sve_ah_fabd_h },
+    { gen_helper_sve_fabd_s, gen_helper_sve_ah_fabd_s },
+    { gen_helper_sve_fabd_d, gen_helper_sve_ah_fabd_d },
+};
+TRANS_FEAT(FABD, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fabd_zpzz_fns[a->esz][s->fpcr_ah], a)
 
 static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
     NULL,
@@ -8144,8 +8138,23 @@ static gen_helper_gvec_4_ptr * const sve_fminnmp_zpzz_fns[4] = {
 TRANS_FEAT(FMINNMP, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpzz,
            sve_fminnmp_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_AH_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz, sve2_ah_fmaxp_zpzz)
-DO_ZPZZ_AH_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz, sve2_ah_fminp_zpzz)
+static gen_helper_gvec_4_ptr * const sve_fmaxp_zpzz_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_sve2_fmaxp_zpzz_h, gen_helper_sve2_ah_fmaxp_zpzz_h },
+    { gen_helper_sve2_fmaxp_zpzz_s, gen_helper_sve2_ah_fmaxp_zpzz_s },
+    { gen_helper_sve2_fmaxp_zpzz_d, gen_helper_sve2_ah_fmaxp_zpzz_d },
+};
+TRANS_FEAT(FMAXP, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmaxp_zpzz_fns[a->esz][s->fpcr_ah], a)
+
+static gen_helper_gvec_4_ptr * const sve_fminp_zpzz_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_sve2_fminp_zpzz_h, gen_helper_sve2_ah_fminp_zpzz_h },
+    { gen_helper_sve2_fminp_zpzz_s, gen_helper_sve2_ah_fminp_zpzz_s },
+    { gen_helper_sve2_fminp_zpzz_d, gen_helper_sve2_ah_fminp_zpzz_d },
+};
+TRANS_FEAT(FMINP, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fminp_zpzz_fns[a->esz][s->fpcr_ah], a)
 
 static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
                      gen_helper_gvec_4_ptr *fn)
-- 
2.43.0


