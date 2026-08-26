Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE4C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdv-00005L-Oe; Wed, 26 Aug 2026 13:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdq-0008Sd-BE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:27 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdo-0004lR-M8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:26 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc1c73645a1so669801a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766143; x=1788370943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6RKI9uFJ05lDYLSjj8F230jbHzkZiA11i7bWoN467Vw=;
 b=qVfOj5Zz0wYVFdcWG3z1/REjAMJ+4pPOJM9mD+5d2jZQG07p64JjGEsoFkGSWKJ07e
 iwwLJMWjbo7zbK6NLQZUeKulM+GuxI+HBHqB+9fKoLj8GwUf3gJEh+PFKmtbRdOGQ7R1
 DLb9PlN8y0MUlraBDxKh01txe6vBN+beZ/BuaG5W4diGbG7SHyNGSRocolby8DJ0jFIp
 UZ7mVZcMaGWwb887wRnAbZfOFGsfk+8dR3lhrHBc/yO3qrTEquogqRi7lC/TJuglRWIn
 Ow92upf58q/CU2eJTZWjQL2EOsjlz4ITGEjlR1MHGcZpU3cgtEHCUO4HyjaqHzbqpqUz
 lO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766143; x=1788370943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6RKI9uFJ05lDYLSjj8F230jbHzkZiA11i7bWoN467Vw=;
 b=eBS/gvh4sDCVYGn/8NIjKaB03MP2cKQSXdlLVf9k+FG2mMqBZLpLVlfVmdeTUEo4Jv
 eY0P+xiScrLhIr3p5jL8i8ItEtJSM0xxgy/CyxsJLqntOPiezxN02Bm7/FtAVGwQ1f9y
 h1d448bFyoLiznvU/7eJCumyii9Y0FD6slPEKQgTrOsnRKlF4bxxDFv3+khvVlnsIeZz
 0JmYXyLSINzUJo0+rmG3++mF4ivQIbmD2ta5XMmg6gBnhz12cUye91NatplodiTmb7oc
 kKE7Bsl8wl8EB8Zb6MTOFBshwQxV4TUk54bkeYSn9CHBEo7SEXxrK4b/5c3PaynLtpcp
 pKwA==
X-Gm-Message-State: AFuF++npx9B9RUK6068fZJKbhBeGi3d9aQvdiLVqq2a/Au0a10VQZ5nv
 1GYo0Uw7Wq0y5LepFh7RyeIFy2Z8KEOVSDJY0d54m3kWyaZVJa5/VUDkMlx4a/uxHpPL8FXiONw
 CY8wk1Xs=
X-Gm-Gg: AR+sD11tNruHh0Ms72UfBrUZ61Kyzs7YmlszUTocNZZ917EMCR+mBvIJGOwdhDPmI7K
 cJxurcZNZ7cqzmTwqSvNmGEP4IJ1d8Z2PZOlCs9G0hhd0m9+/JYq2JeqDIgrddkWv/CfKKa/fbR
 32ETOzRIBsGVxwOwSbdqCNORQ1nb3J+jHaBjv4qpfzwTQnwbyO2UMwsycz89dy4c0pjGfHLbW6+
 2hvXuPtKW3qRfSCT4sx4v8+mb77NMCdu4JL5vjUMWoqbGyuUlGL8AI1KEbcfX3tlHdd+W9FGvKH
 IgD8qQF8T5Uw/r/Dl6jgQ3/TCeLXHXPSxgDrOOEt3rR96rtsq6t32VVITT27/TxzU8niIr+1Jpc
 0s7byTB9RCBvK56Sw1ShxPkT5nmwsRvc2tahoszRxju8rdtUQ1UTOs6VXAaEd927oFMCnHQbYIC
 p4SPD1VcriSX42BcE/Nsnm7MnVZeMhOakPrrbPZuH5Woh4zJF1LdHK2iYEr3IuMvl0i0ilWeq9G
 5xaBsYSkzlqx19OVA==
X-Received: by 2002:a05:6a21:1193:b0:3cb:e8b4:f03b with SMTP id
 adf61e73a8af0-3cf84b4f9b8mr20047685637.17.1787766143026; 
 Wed, 26 Aug 2026 10:42:23 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/25] target/arm: Remove DO_ZPZZ_FP from translate-sme.c
Date: Wed, 26 Aug 2026 10:41:53 -0700
Message-ID: <20260826174213.614571-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.53.0


