Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEBAC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYB-0006JS-M8; Sat, 01 Feb 2025 11:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY4-0006Cq-Rt
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY3-000196-45
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso20784955e9.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428046; x=1739032846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lnrlxlkexAFB0yjw1Az81X/GgE8fg4btWQPlqgMIhKE=;
 b=ScBK0usv0RVGFHDd8Ko2hFGq4Gv3FXW+ZgVo6/MKEeHCNEd739DH6XaOl1YnbMv+Mu
 oKeukHwDadjPAK0oyYPnqa1BQ1Okfo2Y+h4OeTejWj3Het9NUZ6QlwtZNOZBW0eYudwq
 BWR1rYdixSLJEghtJHOOMNsve6G6PsowWaE4nM8Ui8laQnqGuK1pp7C38TW3juMXiuWt
 2xJsBUaeyidf40eRnMl8SdDsz2BjwzNLPwp4DIwBiDmH10QolT1ht4HlW9joG4Zfvzbr
 Bb1gFLFeDmJbaACYSmAAMqyh+GukSbWbP7PFL/fQbZLiz/YdTsl/dNiqsY9kr28yrLUu
 Mv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428046; x=1739032846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnrlxlkexAFB0yjw1Az81X/GgE8fg4btWQPlqgMIhKE=;
 b=JG3JctYLZBCR4sqbuk8uIcY0LmLsAgF36W1tq8Qr3b/0uW/F7WGfFyBzfCBOaxT14h
 vU9b9drA47SsCbCtDMjuaAh326+U3RXkkNPedW/NS29BBBJkBBidPYA1q8D4QYlpzpGF
 5GiJhaGdoOLiVFjoPlBkaWqicjkNkukJvH3tg2ZdpvDFDKchxpkxZ80402hEuTCgqR02
 3lTPFM3mQL/se+WySSANm3F6PPKlkA1fTJWWSpybYbwsOmbPbWCD+B/pNsfplMl4XOea
 S4L+bzv8yEfpgSln0vmBQUIBAyNqISjUQ33+zO7y3ol7fsPdrY18bi69TiNvAnJmP5Z5
 /Kcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVspP/HQO8Xat+UyfMAxA0U7OSq1bsdGiZPZQ14V5R2CE/4csJivc35oASrtaeZ5eIiBrtgMdz3n+i@nongnu.org
X-Gm-Message-State: AOJu0Yz9OsCf/9fRuHTKAQCAShjCJf25mBJFvtUobGHYKmCNREtr9I2P
 h/7niOsPUXS3Fif+R91JtAebxOtCUE114t8FQxDBrxB0vW56fUsan096tBjCfnc=
X-Gm-Gg: ASbGncuRm4h6XInZa7nzN4YIX5G0qXCNW0C+HVlxu4L+KCYLUKAY3jtBQWewzw0zRHz
 jdVKr8Cqst8aa5DHrqIPaYqvnEp/Auz3rzg2nYWECCGzmizTF43xJbcZrhdrj38I28vbtahuiOi
 C9vLszceaKR9WoSrk4Ll2NGpI2OVndkDAu7I3Cbws5oCfyqtGYQuezBCjzM+cS2del6aJa+72MV
 O5shGaP9lLsoAcp7hXxVdiYZJu8GGN9cDGrtlUGt9jieE/eUBSaW4pVH7UY8jjzZLbCEDgEAD33
 UaPQKiZzs+bcuwMuKRiN
X-Google-Smtp-Source: AGHT+IGtCbrcj0H2S6OQ/SwWeTt2za9+zcM+lUuGuSKD9m3LcippyHXqMMQLPey1xk4xtURiqX2MFw==
X-Received: by 2002:a05:600c:1c97:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-438dc3caac1mr130179635e9.13.1738428045748; 
 Sat, 01 Feb 2025 08:40:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 22/69] target/arm: Handle FPCR.NEP for FCVTXN (scalar)
Date: Sat,  1 Feb 2025 16:39:25 +0000
Message-Id: <20250201164012.1660228-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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

Unlike the other users of do_2misc_narrow_scalar(), FCVTXN (scalar)
is always double-to-single and must honour FPCR.NEP.  Implement this
directly in a trans function rather than using
do_2misc_narrow_scalar().

We still need gen_fcvtxn_sd() and the f_scalar_fcvtxn[] array for
the FCVTXN (vector) insn, so we move those down in the file to
where they are used.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 35db806d0b7..73054b6137f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9258,24 +9258,21 @@ static ArithOneOp * const f_scalar_uqxtn[] = {
 };
 TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
 
-static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+static bool trans_FCVTXN_s(DisasContext *s, arg_rr_e *a)
 {
-    /*
-     * 64 bit to 32 bit float conversion
-     * with von Neumann rounding (round to odd)
-     */
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_A64));
-    tcg_gen_extu_i32_i64(d, tmp);
+    if (fp_access_check(s)) {
+        /*
+         * 64 bit to 32 bit float conversion
+         * with von Neumann rounding (round to odd)
+         */
+        TCGv_i64 src = read_fp_dreg(s, a->rn);
+        TCGv_i32 dst = tcg_temp_new_i32();
+        gen_helper_fcvtx_f64_to_f32(dst, src, fpstatus_ptr(FPST_A64));
+        write_fp_sreg_merging(s, a->rd, a->rd, dst);
+    }
+    return true;
 }
 
-static ArithOneOp * const f_scalar_fcvtxn[] = {
-    NULL,
-    NULL,
-    gen_fcvtxn_sd,
-};
-TRANS(FCVTXN_s, do_2misc_narrow_scalar, a, f_scalar_fcvtxn)
-
 #undef WRAP_ENV
 
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
@@ -9377,11 +9374,27 @@ static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
+static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    /*
+     * 64 bit to 32 bit float conversion
+     * with von Neumann rounding (round to odd)
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_A64));
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
 static ArithOneOp * const f_vector_fcvtn[] = {
     NULL,
     gen_fcvtn_hs,
     gen_fcvtn_sd,
 };
+static ArithOneOp * const f_scalar_fcvtxn[] = {
+    NULL,
+    NULL,
+    gen_fcvtxn_sd,
+};
 TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
 TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
-- 
2.34.1


