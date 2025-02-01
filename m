Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61920C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYO-0006dj-BX; Sat, 01 Feb 2025 11:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYN-0006cK-2t
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:07 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYL-0001Dw-6l
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso20905795e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428063; x=1739032863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ryV1Ue0br35R/rD6LQ3aXcrygp6/qiCCF2NgOcEO2tA=;
 b=uLfaD99ua/2557VvSRd5fgJIk2jlwzVbHh+Y4qWVlibBrkrERPMKbbCmUf2L/kgRu9
 7srY7Ags5pX2weP3EtQQoWrJ4uM5MZy3fWxOfadzPphpWBY2fu0nY3Sn+xCSjizF+OKl
 HcPFwx5b9AS4qbu1cKnpJCL9fpm+g/TfmJ+uG+YWVcyOVRvPq5b/rodmKnrofPsXEw4A
 sUiOh9o3dxoc7Nm60pH6ZTmLkoUTECa6RhgY+7ReHMFHZ40fTQjiSaxx93v/qQYwO3bs
 ABCL3RZ7OghXCauwzM2OQmrC8xsgXUTF3eJogCbY2ZGhN15YlEIcYni2ieaRWDA52+vs
 bzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428063; x=1739032863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryV1Ue0br35R/rD6LQ3aXcrygp6/qiCCF2NgOcEO2tA=;
 b=RlMpc+GkN7yy8psr8od1TVke/xua+DyJ90TXxx+1cIEw4hmOGDbx48Zx/yo0k41eBE
 qpq0616rMhMnvHvTQJpuO2w8j8YOd7TSjgTTMCH8i21Sa6MnZQHuzdgaaLy0rCcgFY+H
 haJQycvWLs73GvlQFcI49y7EXc3VhT6lBGZylG27L+8lAHF2wBnWbk8dlh0pms9Ron+H
 8bcKiklbjStE61nGYAVxIqY3hg/t1PYKE86vCOLLsDEvVborx8aF8m3PwXeDka0dSK5u
 yUg9wr+ARQjqlukjCNEzYTMRS0s++QhwKc6ewStHXse2ll+rk9RqYtOtlQiUMcFs4Y0t
 KzOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTuYjkp4SRO70kru4/Nb8x8ga/O0Dq5W/DazGO0j5TvI/Yfa0Kn/ZjVaDB4SZCe33grEM9CmejeAK/@nongnu.org
X-Gm-Message-State: AOJu0Yx6wOdjHxZxiYZeB2qxNURqEIZSLxBeeJbANvKDRS6d7fXga5W9
 7TlK7ffwinwySGEZ0BEIQpcTwrJwCAFv94uw3CVeuHgMgWNLC4GJOpT7ToehDehZhtmtBuPPOQE
 B
X-Gm-Gg: ASbGnculFVRC0YY/L9+2Kfxw37NkD4/fOZmp8vADF165yF+HfAUCBMUgmmcP1mUVuIy
 /uqcK8DIQ322hgTg2jtIuoTYBi5P4baM0frldiPmQ6h+Ek3rTBUQX5dk8+H4EKnbA+6OD9zB6ww
 0O9gDO+/AalAHpVNRt7OiM2nohREvztu4RjLhhrP53YD7fAf5Cm/FS4ZO0dppNMtYIVWt7KpHMc
 hbjP0l8YTWlp18+IokJHT0FKetLnlVWoohShRXHMMvet2lEZ0Iwe3lSzVBbRzonEPP//3RXV+PG
 L8YrbjYOMjU+0xExMTBr
X-Google-Smtp-Source: AGHT+IGOZMw/hG0ahAQ48uS6wI+1tEYuMgAYQCAB8I0zCWhj7DQL6s7u/8KuDZXb5irgzwdRCpKRbw==
X-Received: by 2002:a05:600c:4fc1:b0:434:9d62:aa23 with SMTP id
 5b1f17b1804b1-438dc40d296mr121435295e9.20.1738428063285; 
 Sat, 01 Feb 2025 08:41:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 36/69] target/arm: Handle FPCR.AH in SVE FABD
Date: Sat,  1 Feb 2025 16:39:39 +0000
Message-Id: <20250201164012.1660228-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Make the SVE FABD insn honour the FPCR.AH "don't negate the sign
of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  7 +++++++
 target/arm/tcg/sve_helper.c    | 22 ++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ff12f650c87..29c70f054af 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1183,6 +1183,13 @@ DEF_HELPER_FLAGS_6(sve_fabd_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fabd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fabd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fabd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fabd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_6(sve_fscalbn_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5ce7d736475..8527a7495a6 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4394,9 +4394,31 @@ static inline float64 abd_d(float64 a, float64 b, float_status *s)
     return float64_abs(float64_sub(a, b, s));
 }
 
+/* ABD when FPCR.AH = 1: avoid flipping sign bit of a NaN result */
+static float16 ah_abd_h(float16 op1, float16 op2, float_status *stat)
+{
+    float16 r = float16_sub(op1, op2, stat);
+    return float16_is_any_nan(r) ? r : float16_abs(r);
+}
+
+static float32 ah_abd_s(float32 op1, float32 op2, float_status *stat)
+{
+    float32 r = float32_sub(op1, op2, stat);
+    return float32_is_any_nan(r) ? r : float32_abs(r);
+}
+
+static float64 ah_abd_d(float64 op1, float64 op2, float_status *stat)
+{
+    float64 r = float64_sub(op1, op2, stat);
+    return float64_is_any_nan(r) ? r : float64_abs(r);
+}
+
 DO_ZPZZ_FP(sve_fabd_h, uint16_t, H1_2, abd_h)
 DO_ZPZZ_FP(sve_fabd_s, uint32_t, H1_4, abd_s)
 DO_ZPZZ_FP(sve_fabd_d, uint64_t, H1_8, abd_d)
+DO_ZPZZ_FP(sve_ah_fabd_h, uint16_t, H1_2, ah_abd_h)
+DO_ZPZZ_FP(sve_ah_fabd_s, uint32_t, H1_4, ah_abd_s)
+DO_ZPZZ_FP(sve_ah_fabd_d, uint64_t, H1_8, ah_abd_d)
 
 static inline float64 scalbn_d(float64 a, int64_t b, float_status *s)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 646d0171d99..0d8bd1a49c4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3789,7 +3789,7 @@ DO_ZPZZ_AH_FP(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
 DO_ZPZZ_AH_FP(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
 DO_ZPZZ_FP(FMINNM_zpzz, aa64_sve, sve_fminnum)
 DO_ZPZZ_FP(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
-DO_ZPZZ_FP(FABD, aa64_sve, sve_fabd)
+DO_ZPZZ_AH_FP(FABD, aa64_sve, sve_fabd, sve_ah_fabd)
 DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
 DO_ZPZZ_FP(FDIV, aa64_sve, sve_fdiv)
 DO_ZPZZ_FP(FMULX, aa64_sve, sve_fmulx)
-- 
2.34.1


