Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C09C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMcn-0006CB-A0; Fri, 24 Jan 2025 11:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ9-0005p2-M9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ7-0005lU-AN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436341f575fso24727565e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736191; x=1738340991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KLPz/10dFXxgiRkXTl1JPzUTaxJlkEW7KOCXlSsN4J0=;
 b=bttdBvxi8seEXyDMAO6Q7OxNvHQrQaTDXo0w71qHbJlNqM1VKrA0B36RsDvfgkxUlU
 mjVvz9HMiIa3T9tcDYJ0cQn2jY32xhzim47zwkeRSqHdd9kgWzw3WuEdGqmuCJiYs28K
 FwzOx7KxtvNLX3d3RIOu5ltKH/hlAwEITZm+pt/TY5t9z1YwD96KndkQYxNg/jfZBRmN
 h/8RZG/9b5oXOD1KJLAWp5tn/8+Ys/TUkGdIlOVpGzj3orByiDNatkw/IxFn8sv253z0
 Gv5aOQyxMXxEmTekqt3Q2mhuRJ7iCa73/yNKBcLcRYLW5w6oYPbjzTiL0cRYNB2btE7x
 1lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736191; x=1738340991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLPz/10dFXxgiRkXTl1JPzUTaxJlkEW7KOCXlSsN4J0=;
 b=d9SvLbTwlrPswkkVaKmi3ofoBl7fAmTKOpROi/YKCNQhgAlQ4YQwBy/vNxMBUKE4o/
 Z3d98I7uOdnpvg1Gt+MXiQxuMkNU5HN0mV3WUX32v9psSV8Wh6pTUvB7wPqD/lCir4DZ
 1LNri52DRomCzdZZGa/pmD3j8Z/hqVTBiIRqI+K0964Q+i0OzgvEc/A3MskDaXmxnCFa
 WrQgxdwqAcwY4dhdJezH5qifWxEC7aPmKnoef3aS1+8s6STSqGdXp/wA+ml+u7674E+K
 C9U9RxymOYzVHuiI83GmqbtKO338sXZ5LHRemacjfUnA2Jj5+PhL+VhKiRW1v8Yv8LqI
 aViQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuMHFnYNwGR4U/GRWLo9bVk+u2O/yolf1PWFhZT6gJdVhAfff6izEHCTzGxTV6zYGAFu6Bg+6ZPEsQ@nongnu.org
X-Gm-Message-State: AOJu0YyVE0MvX1be0WORq4JwKqlNIKaul8KJi/FpiGtf9hBesu10PYSt
 Hle3/k0qjzi7FnV5jivsVXXo67ijcPMqPiXZOhclxOOSOV7/zfW3xuYOCwjPdNs=
X-Gm-Gg: ASbGnct784CKXa+fUgadfnYuYAG+kXF70NKCnzTNHbFgiG8DUDJrb8eqaEGlgLpkIw8
 iP6xc1ZK1l4TNAEA07SpDx4lMsGAqZVjp4XBHbHHhQ5Ln6Sp2jUqVJOgtH3MMARlIUbg1hhcQun
 YMMt3PtJLsVI0uvW8urOuJ2k1YTpA3im/Ja9gE/EbJ5r3czTamxDtcjIDMSbWCU+bxqN1fV8qI0
 gwh8X4eRXUBPQNLo0rPEeh0XMG5cFzldE5z0X60l+9dkmKJ3SnIvWX/W3J3rW0/Acm2NBtWRfJ9
 UTYCndZzdfI=
X-Google-Smtp-Source: AGHT+IHHSPd2MCyIQxLZxrVud1Uei+egNrXY7YyfNCkItJSFzGy1JnbuA1ZjYt3sAJcOheP/ktOMwQ==
X-Received: by 2002:a05:600c:348c:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-438912d7c1bmr325724575e9.0.1737736190070; 
 Fri, 24 Jan 2025 08:29:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 57/76] target/arm: Handle FPCR.AH in SVE FABD
Date: Fri, 24 Jan 2025 16:28:17 +0000
Message-Id: <20250124162836.2332150-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Make the SVE FABD insn honour the FPCR.AH "don't negate the sign
of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index c234a4910dd..9200f7f8a49 100644
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


