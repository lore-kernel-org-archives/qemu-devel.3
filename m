Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDCCD6E7B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoD-0006lJ-G2; Thu, 04 Jun 2026 19:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoA-0006hA-9H
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo7-0007tT-9y
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso12274295ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616941; x=1781221741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVdxUuVXoVTJSAA6YhnuFT2CqG+OhK5lpSAh/HDbipo=;
 b=p4gDVhLYcX8jKTzd4fd+Aw6iarO3RdLgM2FSVIkXWNb2bJChVA0XXwYPm6Zc9yeaGN
 fY+v0AtHJarbDzgKE6MMC/tXRUNFvZcmp55Y7HUQQ8tdSfafSY6poAXY4t/pQKO6MtdN
 Cbp/A1SQjPado79/vRUAtb50s3552+SBSE8TjysrIB68dMBduBUyXNQ2Z6+zTbKXFFxX
 8y8RXVNHdqfJcqnR3+rSAMGPJgSWCQmaRZdx5xXasaLGehVZqsvD3RkTZFwMlUNyf/d4
 fRLka5K4w4paFy8UeukegAILzMo1nCFf1L0tNaHeeRV8l0c9xi0bvcRi6G4AI5x9OxC1
 FVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616941; x=1781221741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVdxUuVXoVTJSAA6YhnuFT2CqG+OhK5lpSAh/HDbipo=;
 b=eMIae+kFevxLqnb+fvFOGHRQuAFSfCUnhtewAyTnLQaW/mNwrG97hzmRxIKDIImfT7
 l8ayG17STP1GVMt0UG5iRk0makrtptCVi/iTn/v9pnsMI1J2xGtYp8IMhWtHY/j8OOTh
 0cJQ99eiITnW6MvXCZ69WCAF1cgcsrg9a00/7ZhGkYy/wg0yxwKriXxw3fdaTMaPFy5I
 ihqhXx40T05ibSCy1HJ6u+gnySsrzbELJE39lRg/Ach/7Xd4ASgE6E4hCep+Pym1zkvb
 TMVaqfvDGKZR/f/sTJTR5XThvI472ax7Ro9jZQpy1JuMYoCuXI9O23YMZZPEGj4EbNLc
 K90w==
X-Gm-Message-State: AOJu0YyZWQ92Pnl0Ast5rlqPafkQPmptq46h6poA48w8PQCnYwjlBV8a
 FemK1arpMleOOWZ+wBvk1osAXCzFVWDOZauO8/WDGB1rLeHv8N4nTEI7iYRvJpJQXjt3IIL3Gsw
 c4MO3H1Q=
X-Gm-Gg: Acq92OEZRuwAeU0+DM1hSHJgKuIRnbmU66iT6I3FGvrcjczVOyQDF8CaBO2tgvq72uk
 xhBTmQp2jRRpJPdp+G1cmq6XPddF+XdfXck8GlOPbi52wb+d+AkTZKr7kIZ0Xy7jvvEfVp0DG5g
 Xg+fgh/zhpe8qWIBDd5VGpysqPntNCUW9SLraeYKmVeHhXzRpEkdr63n+vpkgunzHlpjIlIFeQQ
 yc9lc2lCAU7e3hzyFA1x+g4ABRiazwDl8vKIBjeZ/cuhpXhv7hQYtskfLZ86SNLn6T+Pwf1vrf+
 sboYhJ9gH9f/wDyRZEAPUAz53jlpGjrCy6cJlFBvc2JZ5bkx1VDvFIxHEmA6IIKJ+R6IE0UcVMr
 BtrRIhFuEwFw78aPnval6itM7x3C7hh0+Q9KEqK06/g/y4dktz9rwX4cNgcAdLJLPEn5k7rQvk/
 eieQ6+FuznbR1dmf73dNsnV397FtFpO/94wkfqanNSMlaGc1CBgA==
X-Received: by 2002:a17:903:1205:b0:2c0:b6c7:2271 with SMTP id
 d9443c01a7336-2c1e80e3bc0mr7674155ad.4.1780616941330; 
 Thu, 04 Jun 2026 16:49:01 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/25] target/arm: Add data argument to do_frint_mode
Date: Thu,  4 Jun 2026 16:48:37 -0700
Message-ID: <20260604234852.573178-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Prepare for needing a non-zero value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 083b70b487..e9c0a73e90 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4656,7 +4656,8 @@ TRANS_FEAT(FRINTX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
-                          ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
+                          ARMFPRounding mode, int data,
+                          gen_helper_gvec_3_ptr *fn)
 {
     unsigned vsz;
     TCGv_i32 tmode;
@@ -4676,22 +4677,22 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                        vec_full_reg_offset(s, a->rn),
                        pred_full_reg_offset(s, a->pg),
-                       status, vsz, vsz, 0, fn);
+                       status, vsz, vsz, data, fn);
 
     gen_restore_rmode(tmode, status);
     return true;
 }
 
 TRANS_FEAT(FRINTN_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_TIEEVEN, frint_fns[a->esz])
+           FPROUNDING_TIEEVEN, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTP_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_POSINF, frint_fns[a->esz])
+           FPROUNDING_POSINF, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTM_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_NEGINF, frint_fns[a->esz])
+           FPROUNDING_NEGINF, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTZ_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_ZERO, frint_fns[a->esz])
+           FPROUNDING_ZERO, 0, frint_fns[a->esz])
 TRANS_FEAT(FRINTA_m, aa64_sme_or_sve, do_frint_mode, a,
-           FPROUNDING_TIEAWAY, frint_fns[a->esz])
+           FPROUNDING_TIEAWAY, 0, frint_fns[a->esz])
 
 static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     NULL,                    gen_helper_sve_frecpx_h,
@@ -7998,9 +7999,9 @@ TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
-           FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
+           FPROUNDING_ODD, 0, gen_helper_sve_fcvt_ds)
 TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
-           FPROUNDING_ODD, gen_helper_sve2_fcvtnt_ds)
+           FPROUNDING_ODD, 0, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
-- 
2.43.0


