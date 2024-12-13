Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BB2E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YE-0000MA-Fi; Fri, 13 Dec 2024 12:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xb-0007Rc-OC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:27 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XV-0001d0-7c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1544283f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111199; x=1734715999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NSpguoVKHkEY8yFMot0pfTmRRiiKpZjSQlyw+H/MBlc=;
 b=M683dYCo2qCy23JGyH6xoUGwuvOTRi0hGqM6GuF7Zt3bOlyip/tdCnGTmtJfDb5WfI
 e70hiK/GcyLpJ/QRcFQRWFktmYbDzHcpg6uYHn/cxppbu8ofN2jAzP4PW/BpEqbzI6NH
 71qiw2ln0xNiQeRisr/ooUff8mDoUCZFpAdOQQvVgUpB17LhljMAf3BRaYH9CPAvrGc2
 vnzzQHMDUN/dyssyscrGSNp67/jpm4xX1t64g9rcc4MV7kqpZNUBhG/X+qbe7NVY/FAq
 dCEK34azGYilqMNNlB5sr684kgmJUl1NuJTWLQLVzTqoOpgN71hAWTap801d8ZIu8W1W
 fiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111199; x=1734715999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSpguoVKHkEY8yFMot0pfTmRRiiKpZjSQlyw+H/MBlc=;
 b=dWpg7T5d4hArrGSZI7nd0xh/y2SX2PkFWJau5FgE+QW0LtBXV1ZEK/evEWF1jr8PSJ
 yTZPGZBcGx/Qw/pz0doUjTu/X66KM/buKHK8lGjWnqhkqihNP4DuRqD1KJaYBHWNwWTn
 OMIwHE9kVls+KLLcFcBwERqm4Gu5xC8jGVnl76xtEc6fCjlkBaunAvKMhpTYAoGmbrqA
 JfacCWysG5uZkqXkEXmk4Phpm/k/lZoY0vOXw+1ky+MxHO8bb8a8HqITMCcXH1bqqA9H
 7aE5pEEZO9LZeigybdkf6TqqV7vT3DJMXqOUt8KOOkcKvgD6ZBjRntbzlAUE1yoGV2nd
 22EA==
X-Gm-Message-State: AOJu0YxuujQeNf527fsp5gzGgSRg4Yj2sbMH7fgQmKpFBq7iEUXHrqYC
 oQ9okHpTszll4rohEVR8JRc8k44BGeYv+dLFyg8yVBd6VhtABrN2lH28VioKsBR4fkRzu5DUZ7e
 W
X-Gm-Gg: ASbGncukGxkLsFuvwgxQcrbFYZJLOZ44NS/rYboPd8CPS7cIukdHBfQz19fgWqrPo3v
 c8lChcq0Nz1y44fXL0QodE9SDIGFJSvAB9wwtMi1SS0f6ogUxdLfGhV3z+fZobftdwmTZHA/YKU
 jHbtG5AoJKv9Du5YfSs0ZszTWOUtlhe5DJw1uFHvYRfPMgb/Y9UeW+xNKOn4DEvzG02gsi2d6+X
 RX4WCZWP8SinXsNlXAs7vKYWLvf5709sLlm5PgB99ITuplaVomskmRhWIUhKw==
X-Google-Smtp-Source: AGHT+IHyIkcNwLq1yawyh1UAzf1t4zwsQgMmK8qVmsIu+tXKxlX890zQJaTIWatyOLFkHtt2qyXgAA==
X-Received: by 2002:a05:6000:4b12:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-3886c725060mr3508365f8f.0.1734111199342; 
 Fri, 13 Dec 2024 09:33:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/85] target/arm: Move helper_neon_addlp_{s8,
 s16} to neon_helper.c
Date: Fri, 13 Dec 2024 17:31:48 +0000
Message-Id: <20241213173229.3308926-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Move from helper-a64.c to neon_helper.c so that these
functions are available for arm32 code as well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-45-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h          |  2 ++
 target/arm/tcg/helper-a64.h  |  2 --
 target/arm/tcg/helper-a64.c  | 43 ------------------------------------
 target/arm/tcg/neon_helper.c | 43 ++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 167e331a83e..57e0ce387bb 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -399,6 +399,8 @@ DEF_HELPER_2(neon_addl_u16, i64, i64, i64)
 DEF_HELPER_2(neon_addl_u32, i64, i64, i64)
 DEF_HELPER_2(neon_paddl_u16, i64, i64, i64)
 DEF_HELPER_2(neon_paddl_u32, i64, i64, i64)
+DEF_HELPER_FLAGS_1(neon_addlp_s8, TCG_CALL_NO_RWG_SE, i64, i64)
+DEF_HELPER_FLAGS_1(neon_addlp_s16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(neon_subl_u16, i64, i64, i64)
 DEF_HELPER_2(neon_subl_u32, i64, i64, i64)
 DEF_HELPER_3(neon_addl_saturate_s32, i64, env, i64, i64)
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 203b7b7ac82..f811bb85dcb 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -41,9 +41,7 @@ DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
-DEF_HELPER_FLAGS_1(neon_addlp_s8, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_u8, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(neon_addlp_s16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_u16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 3f4d7b9aba6..9b3c407be3c 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -306,39 +306,6 @@ float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, void *fpstp)
     return float64_muladd(a, b, float64_three, float_muladd_halve_result, fpst);
 }
 
-/* Pairwise long add: add pairs of adjacent elements into
- * double-width elements in the result (eg _s8 is an 8x8->16 op)
- */
-uint64_t HELPER(neon_addlp_s8)(uint64_t a)
-{
-    uint64_t nsignmask = 0x0080008000800080ULL;
-    uint64_t wsignmask = 0x8000800080008000ULL;
-    uint64_t elementmask = 0x00ff00ff00ff00ffULL;
-    uint64_t tmp1, tmp2;
-    uint64_t res, signres;
-
-    /* Extract odd elements, sign extend each to a 16 bit field */
-    tmp1 = a & elementmask;
-    tmp1 ^= nsignmask;
-    tmp1 |= wsignmask;
-    tmp1 = (tmp1 - nsignmask) ^ wsignmask;
-    /* Ditto for the even elements */
-    tmp2 = (a >> 8) & elementmask;
-    tmp2 ^= nsignmask;
-    tmp2 |= wsignmask;
-    tmp2 = (tmp2 - nsignmask) ^ wsignmask;
-
-    /* calculate the result by summing bits 0..14, 16..22, etc,
-     * and then adjusting the sign bits 15, 23, etc manually.
-     * This ensures the addition can't overflow the 16 bit field.
-     */
-    signres = (tmp1 ^ tmp2) & wsignmask;
-    res = (tmp1 & ~wsignmask) + (tmp2 & ~wsignmask);
-    res ^= signres;
-
-    return res;
-}
-
 uint64_t HELPER(neon_addlp_u8)(uint64_t a)
 {
     uint64_t tmp;
@@ -348,16 +315,6 @@ uint64_t HELPER(neon_addlp_u8)(uint64_t a)
     return tmp;
 }
 
-uint64_t HELPER(neon_addlp_s16)(uint64_t a)
-{
-    int32_t reslo, reshi;
-
-    reslo = (int32_t)(int16_t)a + (int32_t)(int16_t)(a >> 16);
-    reshi = (int32_t)(int16_t)(a >> 32) + (int32_t)(int16_t)(a >> 48);
-
-    return (uint32_t)reslo | (((uint64_t)reshi) << 32);
-}
-
 uint64_t HELPER(neon_addlp_u16)(uint64_t a)
 {
     uint64_t tmp;
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 4e501925dec..b92ddd4914d 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -866,6 +866,49 @@ uint64_t HELPER(neon_paddl_u32)(uint64_t a, uint64_t b)
     return low + ((uint64_t)high << 32);
 }
 
+/* Pairwise long add: add pairs of adjacent elements into
+ * double-width elements in the result (eg _s8 is an 8x8->16 op)
+ */
+uint64_t HELPER(neon_addlp_s8)(uint64_t a)
+{
+    uint64_t nsignmask = 0x0080008000800080ULL;
+    uint64_t wsignmask = 0x8000800080008000ULL;
+    uint64_t elementmask = 0x00ff00ff00ff00ffULL;
+    uint64_t tmp1, tmp2;
+    uint64_t res, signres;
+
+    /* Extract odd elements, sign extend each to a 16 bit field */
+    tmp1 = a & elementmask;
+    tmp1 ^= nsignmask;
+    tmp1 |= wsignmask;
+    tmp1 = (tmp1 - nsignmask) ^ wsignmask;
+    /* Ditto for the even elements */
+    tmp2 = (a >> 8) & elementmask;
+    tmp2 ^= nsignmask;
+    tmp2 |= wsignmask;
+    tmp2 = (tmp2 - nsignmask) ^ wsignmask;
+
+    /* calculate the result by summing bits 0..14, 16..22, etc,
+     * and then adjusting the sign bits 15, 23, etc manually.
+     * This ensures the addition can't overflow the 16 bit field.
+     */
+    signres = (tmp1 ^ tmp2) & wsignmask;
+    res = (tmp1 & ~wsignmask) + (tmp2 & ~wsignmask);
+    res ^= signres;
+
+    return res;
+}
+
+uint64_t HELPER(neon_addlp_s16)(uint64_t a)
+{
+    int32_t reslo, reshi;
+
+    reslo = (int32_t)(int16_t)a + (int32_t)(int16_t)(a >> 16);
+    reshi = (int32_t)(int16_t)(a >> 32) + (int32_t)(int16_t)(a >> 48);
+
+    return (uint32_t)reslo | (((uint64_t)reshi) << 32);
+}
+
 uint64_t HELPER(neon_subl_u16)(uint64_t a, uint64_t b)
 {
     uint64_t mask;
-- 
2.34.1


