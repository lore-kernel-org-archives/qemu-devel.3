Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D555EC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwUW-000561-MM; Wed, 02 Jul 2025 08:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwUB-0004zO-3n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:48 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTu-0007El-7Y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:45 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so2837203fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458945; x=1752063745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJq8Ct14ZkJ7UIbuFZO9txkdxmDUbAj15XGDsXarXQw=;
 b=UqHYRTSEfCmn/L4BqmtKW1WznntwfGQODf/6W0H58JdvrYI4pxYsnCHEqefcVaUneH
 pElzn6NaeJavEIRDasJ02FcggcTs4Yol45aDApEGuGeh2RVyPQo3BU2RBV2342k0L/8y
 9TTOC6hbWjMgD52qCaC5aip1rlyuS5O+iaqrG7JFm3P4P4LX4g2/xxv6R7zQFKn77AVS
 FO7ck4S6jOyYTHOjoZA01gW9WpTVYOyYCAAZ3O+JI5kYyqbi7GLSjIJYlsvGT/aOf5Xw
 xuy6sd15f3pXcaKzuS0xYqL97rxVjsl5QgXwno+O+UYrGUg7TYOWLnTWypesBkoioRsz
 HruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458945; x=1752063745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJq8Ct14ZkJ7UIbuFZO9txkdxmDUbAj15XGDsXarXQw=;
 b=FPV8/x26B2ZEmLOIniXfYvV/sUoNX6IsoBRRvjxMgvDk52SsOWIvNlAmhXLpCTlYH0
 buZMbtsdz/8hpzhQw+i62FqrzJiXI+rxfUJ8JREqFnGvYziKMDoQVymxS9LOzjXYSYpp
 16HydEpMiaTE1vjjniWEB/ieR4IIXBBO/Ssqbv7hqL7O9qbJl5cY5YdE5dCFnNsbuae5
 TmBfy1zLBvY8aBHg0Waz0FlX5fVam/sGU0UsTEUgzPAMxo3As8hZBtQbxLU0JxaTJDnf
 5UAb9ZKaFDowPxmfqhEA70JIkTrNGbs/Qy6Rd3LmIv9ETXVydRnc57Q2dml/VCr+zVpZ
 0akQ==
X-Gm-Message-State: AOJu0YyUEnjDA6WPjatQzLfvs2EsclwlGTP3AFKZihdkLAebIiBAL9Mu
 S7UXtBte7gTB3Wp9QBHva7U/c32l1nFfhdJAQp4J5IkBEBkI8ph7dN7YfMNzMcoKMEgl6yPjVtz
 1ZJi4wUw=
X-Gm-Gg: ASbGncsTQWm0WMOM9EWeipKQITKtCZi/2B26Cp/3W36WVqsrQRBxaFsjorbp6pq8u+1
 8qsqSt/fO/mPmna0oPyv3ztp/bH8oyucSCUtZIqDQgHsXQXS2jRsmpLMjJPUjRPRA0zgRMYxheQ
 j0h5u6ASirhVD7z0B4dKlddz7Uqzqg9kX2HIn7EITXKcFZ80DukGBId5vJY0E6Zp6FTMJFVvN5o
 Gkr1pbJmvdomRzQa+hcSl1nuobYz2xxx4NilmWZshm2L/ct5UOcP/foqUULFkZKPFL5nyS7sXi7
 6Xp1HhOOn+xrnB7c99dNgXpts1e006wpYyevQ280dwJmip/5Qt0Kr5DHkpVXr8JrYZS2Yg==
X-Google-Smtp-Source: AGHT+IEIRUPE3usqCxNJwLC4aKA79SIrXOgCq4MUPCYQyjfqvVHamPQvUVsplWIzLvq9zFG3zO4WiA==
X-Received: by 2002:a05:6871:440f:b0:2c2:561c:47e3 with SMTP id
 586e51a60fabf-2f5a8c977eamr1585633fac.21.1751458945558; 
 Wed, 02 Jul 2025 05:22:25 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 08/10] target/arm: Fix f16_dotadd vs nan selection
Date: Wed,  2 Jul 2025 06:22:11 -0600
Message-ID: <20250702122213.758588-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Implement FPProcessNaNs4 within f16_dotadd, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 62 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index de0c6e54d4..8f33387e4b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1005,25 +1005,55 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
      *  - we have pre-set-up copy of s_std which is set to round-to-odd,
      *    for the multiply (see below)
      */
-    float64 e1r = float16_to_float64(e1 & 0xffff, true, s_f16);
-    float64 e1c = float16_to_float64(e1 >> 16, true, s_f16);
-    float64 e2r = float16_to_float64(e2 & 0xffff, true, s_f16);
-    float64 e2c = float16_to_float64(e2 >> 16, true, s_f16);
-    float64 t64;
+    float16 h1r = e1 & 0xffff;
+    float16 h1c = e1 >> 16;
+    float16 h2r = e2 & 0xffff;
+    float16 h2c = e2 >> 16;
     float32 t32;
 
-    /*
-     * The ARM pseudocode function FPDot performs both multiplies
-     * and the add with a single rounding operation.  Emulate this
-     * by performing the first multiply in round-to-odd, then doing
-     * the second multiply as fused multiply-add, and rounding to
-     * float32 all in one step.
-     */
-    t64 = float64_mul(e1r, e2r, s_odd);
-    t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+    /* C.f. FPProcessNaNs4 */
+    if (float16_is_any_nan(h1r) || float16_is_any_nan(h1c) ||
+        float16_is_any_nan(h2r) || float16_is_any_nan(h2c)) {
+        float16 t16;
 
-    /* This conversion is exact, because we've already rounded. */
-    t32 = float64_to_float32(t64, s_std);
+        if (float16_is_signaling_nan(h1r, s_f16)) {
+            t16 = h1r;
+        } else if (float16_is_signaling_nan(h1c, s_f16)) {
+            t16 = h1c;
+        } else if (float16_is_signaling_nan(h2r, s_f16)) {
+            t16 = h2r;
+        } else if (float16_is_signaling_nan(h2c, s_f16)) {
+            t16 = h2c;
+        } else if (float16_is_any_nan(h1r)) {
+            t16 = h1r;
+        } else if (float16_is_any_nan(h1c)) {
+            t16 = h1c;
+        } else if (float16_is_any_nan(h2r)) {
+            t16 = h2r;
+        } else {
+            t16 = h2c;
+        }
+        t32 = float16_to_float32(t16, true, s_f16);
+    } else {
+        float64 e1r = float16_to_float64(h1r, true, s_f16);
+        float64 e1c = float16_to_float64(h1c, true, s_f16);
+        float64 e2r = float16_to_float64(h2r, true, s_f16);
+        float64 e2c = float16_to_float64(h2c, true, s_f16);
+        float64 t64;
+
+        /*
+         * The ARM pseudocode function FPDot performs both multiplies
+         * and the add with a single rounding operation.  Emulate this
+         * by performing the first multiply in round-to-odd, then doing
+         * the second multiply as fused multiply-add, and rounding to
+         * float32 all in one step.
+         */
+        t64 = float64_mul(e1r, e2r, s_odd);
+        t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+
+        /* This conversion is exact, because we've already rounded. */
+        t32 = float64_to_float32(t64, s_std);
+    }
 
     /* The final accumulation step is not fused. */
     return float32_add(sum, t32, s_std);
-- 
2.43.0


