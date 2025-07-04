Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5F6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE8-0008Ow-It; Fri, 04 Jul 2025 12:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE4-0008MA-TT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE3-00068X-2p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso11808805e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646321; x=1752251121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZzBhsK295U+QrtJeMulwQMRMjYmffakd1q/LVwjhdAQ=;
 b=h2WMMofP5NjQYQHtGjeprZVljZ/zlbWWOmiR9J0q11OOcHC4c6Knd7XoRFsre6eAUJ
 9rD/NBG52OyeiSz+LW/2+vQTSEXwDEdLnxfjzhlbQyBSioqQQFDYJN0OqcKKeDMYDQuj
 MG9tafh0nUO6dq/+wJ8ag8xPqD+7fY64it8Z/cMgaUfPpyZRaJ5VXqxtgcadg1wICJ4v
 jIzPYI3dTtmp4V1Fc0iOk+O1D2WnutElBjTMPPnoCBFeqLIFE8/IyHu4YTTBeybpBnjV
 XM9ef7iAw7gFW2N9XoYB0rmBxuK/vW1Fs9T7jioAJIUxkSU4AQcKe+yOdPjZty2Jas9a
 qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646321; x=1752251121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzBhsK295U+QrtJeMulwQMRMjYmffakd1q/LVwjhdAQ=;
 b=OEDk5ofJs6PHzIcNDND+rPGe+SEAbtG6jOsKwbjd0JGQBfk++XcUz1V8OfOP9DJ2gG
 L72G1gR0fKnLFKqfXUX0jKXfFszTAei5kEb9HyFu0ALn+HxLJZOqON52ueQBYyW7O0qN
 z3pfmj27o7SNolE9np2GIAaGaDUY3a9r00SRti/z7H0OQoeK5ZF41SoLLjGX6RF0OLJF
 BAfJCVnrc6gE0O4P3U8akwmubuaHBAuQ0WF7/HPkp7rJ+tGmPgKQEszB6MUpJensmn1P
 1VU6izCFPm0Qu76KwYDpsYBNaIVCGrObnKOj0r4AyWP0oaHHARcLOl+3bWKW6blcCP04
 GI8w==
X-Gm-Message-State: AOJu0Yyfu+j6CLdKxdffgXQrusdfFqjQ404KPA+xA6OKX3t5dYNtDkoi
 fLl0hLY4Pw/wx+EgV/mgQyK5x3J6QmnISSwwy5SmQ8hrVvMsT2QCCGk/hI4pcgybGhso9+wGlMf
 mU/qs
X-Gm-Gg: ASbGncvKdUdzU3WpCTbQjIFbUiCUfJ2NDQV2KOqetx3j08VVldeuedi0gt2ivo0bimg
 ypUgXpqnyVyQ1LOJ1fgZJy2EdrdkxdfkscNflccxtuFs5gjuYcAhuk/F3G4uWIcBp6AEEBX/eaG
 KjOdMjjlCTZzocWmkt0ta2jMdRRmt2hIkBMAWrfylnKZ6O+kCiKdaoNp7+Y4J52ZgPPeXJCvJ0F
 R54/Ey2M7mrZuZidliMoQ03sguJ17ghUsgHG8mE26lSM2RVfXJN2A47WsO3bli2T+pzl9EOFPjM
 3RHFCvLfCRazH0P8vMztJkSR3mQTNMu/jwLQAYViAJ2KR/EOeQs8Dx+KqQWqts/T9sn5
X-Google-Smtp-Source: AGHT+IH19NFgdKVeWxiKF3q0+XaBnOQJ/99B0bkV6A+HVtTmeNSQZiKQeT1JK4HJok2PFFrxut498g==
X-Received: by 2002:a05:600c:3b10:b0:441:a715:664a with SMTP id
 5b1f17b1804b1-454b91597d9mr9365025e9.20.1751646321561; 
 Fri, 04 Jul 2025 09:25:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 020/119] target/arm: Fix f16_dotadd vs nan selection
Date: Fri,  4 Jul 2025 17:23:20 +0100
Message-ID: <20250704162501.249138-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Implement FPProcessNaNs4 within f16_dotadd, rather than
simply letting NaNs propagate through the function.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c | 62 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index de0c6e54d4b..8f33387e4bd 100644
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


