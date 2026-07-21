Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD11C44537
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFW8-0001UH-P1; Tue, 21 Jul 2026 14:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUm-00011C-Gg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUj-0006bx-Ke
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so1865823a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659625; x=1785264425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0NJwAVc7J/ldMukqkr5NkrL3BAWAUHUp5mV0fIXSfV4=;
 b=Tbcsw8zf00jzZ1e5q01namxOgwxSocyPaWTU8o+VBxBq7cyTXgO4Pyw7zEfTYe5bBQ
 eq1WP1DxsBtNdchh5Hmy6/ZhmaTcxjG+tLVNAC8cbaGOgZzR+pWL3qHNUZF7Q6QZkGNo
 YM7qUb1oxMeqUIg/RfF7M+Cdl5l0RNfhJIWN1n1go6wbICll1weOL7UtZpC+azRnwW01
 KVYHdQ9WTSQOlPlQMeZCLtMArTFCqM3bYLQIgLOyZK/HnfkFMyoPHwx1xGM0TVToervi
 cX87DDigL9BHU/BomK79eQUXhLDUzodYnn5PK3E42fhq61XfsE+NadEtAdk9VU+odxtk
 MNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659625; x=1785264425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0NJwAVc7J/ldMukqkr5NkrL3BAWAUHUp5mV0fIXSfV4=;
 b=pP5RtbT8PaqXCpofZd6efAIgkZe0wX0FRVUyqFF21SUadknDgqBYLgOrUX5UGXnuWP
 n+10xQLHFseYvsCvzwuBSY205EO/FcHCfMy1amwfKYncS2tIwn3fZto5ynOVT/hHzOTd
 gINpnehOe3Iar2GfUI2aJivfVK3X+tHlBmVQVBa830pAZvfsniZrdnsDUNurhm3PyIAF
 3RHybABRg3Exf/SlfGp4q0oHyFoCEG8g5hazlQu0V9dVC18jWjiwDbPHS1GA3LxmXX+j
 warwcjAOF8x7kXSm+UwRzMhJyancbJL8TOXL1mVROphvdFg/IAnrhBi96vTEcFVXSK2A
 AbCw==
X-Gm-Message-State: AOJu0YxtGGpAYjHNTCBMszBlaTKwgQU4Jky+yWsjf1U9CjFRCaLuZjSr
 J0Q1lX3Nwny2mEXN2sOy8z37kyRN18NBXrYLNJIdctwHRO9svR0R5QGI7cyLlXDPszZ0cx7DTm7
 bd65G
X-Gm-Gg: AR+sD12Ad8zMMXBcl3I0Px0zQneL02cR6oZ1kiQRp0DsZ0urEdl9oFhfbGtZJ39+mo6
 t5ekFRuPKcEKK+SokxL/5OA2xoO14WOHAMB7qKqapzRIxa26ZxvV/HgqUpe5v1YUg1pCk2wQn55
 m9FjNEr/L2EnbMJzwZmXzZZZksxyOn4TR7JygVLeOpabv34I7E/CkPbGuHOk9N0C+DAYN3YYpZu
 pTxmtxKZByTpfPXqtSEZ1c+Isy7MD4Zq81ca1M77gbUvVdMx00BcUqlv7pFN+1F7IjCwreucn5e
 miyjZ3vO7jeuoupBgwIBnDmXxMTYXTef9E5PwAQqL+PkZ6TILyhnyH9IzWl8U7GIHAR/nbQntwX
 Tw+3TpIEyHyggPdxMBnDzamvVQSUpe88WPXUk8poZQ+ClFu7dRVuIhqWFa6cRopEDQxGqJPipl3
 6T+oaEN4Y=
X-Received: by 2002:a17:90b:562f:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-38e4b41fb4cmr19885942a91.8.1784659624773; 
 Tue, 21 Jul 2026 11:47:04 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/20] target/arm: Remove DO_ZPZZ_AH_FP_B16 from
 translate-sme.c
Date: Tue, 21 Jul 2026 11:46:40 -0700
Message-ID: <20260721184656.530230-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Expand the macro at each use site.
Merge the two arrays and index by fpcr_ah.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 59a4f9a59b..62610e0394 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4415,19 +4415,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
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
@@ -4455,8 +4442,23 @@ static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
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


