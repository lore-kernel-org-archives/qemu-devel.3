Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6156E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhA-0006rK-Im; Wed, 11 Dec 2024 11:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgk-0005od-Mm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:51 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgi-00022z-Q2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:50 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d900c27af7so44375476d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934948; x=1734539748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smbyKQCqSEurcIaPfQOlMDEox7tcetGuPWi/Xxn9Tl8=;
 b=boOCxNyX/1YC8bHz5yw08rJkT33TVddYqV3XdeOHdhNtp5T2n2aytHcu9BSbMfINZV
 X1UVQpbULWI5OG8N3ct+GTRHa0cYRNvehyuGMMtIIfvlEId1ur8cpLQB8grlXWHa0He3
 aJDh7Gt7kqKUbIqXDaQ3qqv0cE02LG3m9AU8tDMcK0dyfZtXEh3HJU5plymDvDsGP+Te
 TjqXuy/pprK3etWH8WXgTlmauXeN4ZuMRPpkyBPbAdGd6Cs/MiKyAJLwSspdVbvvgRh9
 XHivEvvbnNSR72aGi8GOljB4lIe020pm409QxAdqItaXoKq0GJJuUBWcax5D4gnQm95H
 elOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934948; x=1734539748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smbyKQCqSEurcIaPfQOlMDEox7tcetGuPWi/Xxn9Tl8=;
 b=U34d5JOVKb2TagMqdMZ452LvQMuAdAJDqNzZIHiPOU9EGQIcAK9/9L1l9OMWsjZfCo
 VIyXgyVij0BzeFTNlC8Me+FeHGv4ZZsC1unNQaR/x5Oa7xrt1k5wglQjnXx7CriRy2NE
 U21aEI+H06QgFfWH7ConfXOYg7VUqkpgOzi4zVHh1fKM6d/s5H/CKIKDUJyqhWqSZOcO
 1/t9q/k1iJT2rJg4uLD50DL1hybp6wvOUqpjNkdthROzdYTdrf4S+O/Jd2D/MbuDDTPN
 uy1VM1Mb0Gg4+JhuBFKcuM1KMVXAk8WT0vrYEFBBL4H5rzcHzxBExva9WuwniroApQqu
 SToA==
X-Gm-Message-State: AOJu0Yy6RwQHCQSml6VKj/lS4WUtXcw+kmQHaUtL7ErHn4ezrSPGh11r
 bO0qW8qbFCXF57OU06gqTUANYlj1Qc4y/8tuz6woxie/eIcYp8hnuYrtMN5rjBIGa7cGlRP5nPZ
 c8j43IIYh
X-Gm-Gg: ASbGncthobbnVDHnni/EuvuRSNANAFw0q5BmGBY0GotY6nrCD08NF66bQvnlUsV7LXm
 sm1cgbXYiE7mZ4+7+PE+vBdMPfJvdEa+fMuyozm3hwDNR5Q2HrmqFE3akq+DsctxpLSq5/FkMQT
 +i+1VeWDr0YyWx7cMqwLFzy83ruS1PdqbkRnx2gMfQa8k708EoDo1Rg/NrmL1pJl0BMhjjDJybc
 klsD77liDObR1GCScTg8iJerVbTzoiBFHSSKGRRUYzRFddH22F/dRgNhXJODA==
X-Google-Smtp-Source: AGHT+IEV1QEffa880c2C/QK4/tGwzmd/zl3KzQwKEObIHC0/TO4DnN8PKrvSB4YEjHsM2VOExWnnwQ==
X-Received: by 2002:ad4:5cc9:0:b0:6d8:9872:adcb with SMTP id
 6a1803df08f44-6dae2ab2c29mr5071956d6.36.1733934947874; 
 Wed, 11 Dec 2024 08:35:47 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:35:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 44/69] target/arm: Move helper_neon_addlp_{s8,
 s16} to neon_helper.c
Date: Wed, 11 Dec 2024 10:30:11 -0600
Message-ID: <20241211163036.2297116-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

Move from helper-a64.c to neon_helper.c so that these
functions are available for arm32 code as well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h          |  2 ++
 target/arm/tcg/helper-a64.h  |  2 --
 target/arm/tcg/helper-a64.c  | 43 ------------------------------------
 target/arm/tcg/neon_helper.c | 43 ++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 167e331a83..57e0ce387b 100644
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
index 203b7b7ac8..f811bb85dc 100644
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
index 3f4d7b9aba..9b3c407be3 100644
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
index 4e501925de..b92ddd4914 100644
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
2.43.0


