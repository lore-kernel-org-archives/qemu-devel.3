Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DA9C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwNx-0004T1-VG; Sun, 27 Jul 2025 04:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwM7-0006OG-9s
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwM4-0004Bj-Ru
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-234f17910d8so29660265ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603415; x=1754208215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDl4qI49SpWW8VIqpAekGv5IcctWpYAVkinX7OmWaPs=;
 b=ZpRA7VjWwdeAaSsroG/7OzTHGfcs69V7c8HQdz+HvZZZUkXXwvOYzlTaFJFAaQj61o
 sF8Fa9/SkwkmtP3n9uT6apSqemhoksrjHq7Vt6DaVef9pYbUfK6rVUul/kBIMvHoVowa
 1e9jX+skXq6edjj2dCLGDB85gMUgWHFopmQlMk+dxfgfKL/LWRZ7XFp3879sKH8O9OAf
 hxM1ZINtU+Uk10py98bTgwpaLwWI0HtqAg7mBivA5a0OG+/vF1AS49kbGllT9rlC4vQR
 iRLgOGZyPUc+pDr9bXnN+ezSAkMtf844yyTRZ3qp5KeZvzlc0XgOXt7YrHg4Mq8h55hk
 HXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603415; x=1754208215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDl4qI49SpWW8VIqpAekGv5IcctWpYAVkinX7OmWaPs=;
 b=VZVXUSdwBwrmutqDWevjmPmXsxJbuu/XFI1zeyLxQXCoGbq2YNSzyf+Zo3HTG95+Ez
 dotVoFjPJ8Nn7D0CnmSLMXpM1yap0tontX1LFzYCGhofolyEZlgf3u7Om9sHNaacfORV
 BI7anFq+heDk8LztxbYhAQntw9DJWwTpITvd0OeqrIn42KOSApkK0hfJId6/sv8az1mi
 oRI7ue/ZypIA047DIEwWztMYV5EsBjlR3VM45o8dqwNViTaCnmLNiS48L4/1m/AFUAfF
 r6OECn3moI2nbHc/bTBBG9jQBVOJEsNb2zy2/BuPSqIWusxtp5mgiWfZSSBMRkQaDl/A
 iIgA==
X-Gm-Message-State: AOJu0YwBGyJ2hCJQ/4mNFMwU2+jJy/KYOUOZmHU/BSIr8kZR80Y/LE0r
 oyNrk4iPssziRDEJlCwOezV4kx0gUEm5rpyu+l9j/Nl3nXXtYCvq0kYi5AXzLNxF18/aowvA8mk
 pOWMz
X-Gm-Gg: ASbGncukrRY+V6fS6yE99S5H9W+XZQXiHfpaN+mEAdkR4zkYUNXs95+FseshfwE+EJY
 diUG/aZGNssjBKGXJAtcVbzJ1xu8VvZeCs23jRuhoCiRLpOaJNNp8aOLP+4Aoq+Zc/dlxrYDrcE
 T6nKpxOAriz4O/Xn23SvVHIVUUfbCdTKkh0Frm14qG/Qr/XH/vjMbhPo2tAZTw5ADqmDddXf9Sl
 vCz6sTpMFg0NGdNNCWw0lAUnbkzq0O3na5/G9Q4ROJg7Od9RK0gERVnmCAffnTM+yBSiKlOXSaA
 /e7udwBWZn9AnLDkvxAMV1xP7wk9wXpj+DDQeSNi6xQ+c8M9CefBKi2x8TbIUMg2EaPI3IyM4I8
 pziz+qrkG4ZG4Isbn2JtP+ShOtMq4oRRMeYzlwNqrzSxQHY3D8ziNAgD5fM9EJSxZnifDpfFgBk
 wwhs2L7arQKQ==
X-Google-Smtp-Source: AGHT+IEq9Sso7I8W7nFVKNYO4frvKDHjD3yDWtrK3/CJA6b/4nRE+hD6AdliFPD5BDnezu3zrn2h9g==
X-Received: by 2002:a17:903:2346:b0:240:2145:e526 with SMTP id
 d9443c01a7336-2402145e8d5mr428105ad.6.1753603415594; 
 Sun, 27 Jul 2025 01:03:35 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 32/82] target/arm: Convert regime_el from switch to table
Date: Sat, 26 Jul 2025 22:02:04 -1000
Message-ID: <20250727080254.83840-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 35 ----------------------------
 target/arm/mmuidx-internal.h | 13 +++++++++++
 target/arm/mmuidx.c          | 44 +++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4991d6ab7f..3b730a5d81 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1075,41 +1075,6 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-/* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_Stage2_S:
-    case ARMMMUIdx_E2:
-        return 2;
-    case ARMMMUIdx_E3:
-    case ARMMMUIdx_E30_0:
-    case ARMMMUIdx_E30_3_PAN:
-        return 3;
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSPrivNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSUser:
-        return 1;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 35d41495cd..1a4770401b 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -13,6 +13,8 @@
 
 FIELD(MMUIDXINFO, EL, 0, 2)
 FIELD(MMUIDXINFO, ELVALID, 2, 1)
+FIELD(MMUIDXINFO, REL, 3, 2)
+FIELD(MMUIDXINFO, RELVALID, 5, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -24,4 +26,15 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, EL);
 }
 
+/*
+ * Return the exception level for the address translation regime
+ * associated with this mmu index.
+ */
+static inline uint32_t regime_el(ARMMMUIdx idx)
+{
+    tcg_debug_assert((unsigned)idx < ARRAY_SIZE(arm_mmuidx_table));
+    tcg_debug_assert(FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, RELVALID));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, REL);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 309b1d68df..6dfefa56c2 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -8,34 +8,42 @@
 
 
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
+#define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
-    [ARMMMUIdx_E10_0]           = EL(0),
-    [ARMMMUIdx_E10_1]           = EL(1),
-    [ARMMMUIdx_E10_1_PAN]       = EL(1),
+    [ARMMMUIdx_E10_0]           = EL(0) | REL(1),
+    [ARMMMUIdx_E10_1]           = EL(1) | REL(1),
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1),
 
-    [ARMMMUIdx_E20_0]           = EL(0),
-    [ARMMMUIdx_E20_2]           = EL(2),
-    [ARMMMUIdx_E20_2_PAN]       = EL(2),
+    [ARMMMUIdx_E20_0]           = EL(0) | REL(2),
+    [ARMMMUIdx_E20_2]           = EL(2) | REL(2),
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2),
 
-    [ARMMMUIdx_E2]              = EL(2),
+    [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
-    [ARMMMUIdx_E3]              = EL(3),
-    [ARMMMUIdx_E30_0]           = EL(0),
-    [ARMMMUIdx_E30_3_PAN]       = EL(3),
+    [ARMMMUIdx_E3]              = EL(3) | REL(3),
+    [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3),
+
+    [ARMMMUIdx_Stage2_S]        = REL(2),
+    [ARMMMUIdx_Stage2]          = REL(2),
+
+    [ARMMMUIdx_Stage1_E0]       = REL(1),
+    [ARMMMUIdx_Stage1_E1]       = REL(1),
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1),
 
     /*
      * M-profile.
      */
-    [ARMMMUIdx_MUser]           = EL(0),
-    [ARMMMUIdx_MPriv]           = EL(1),
-    [ARMMMUIdx_MUserNegPri]     = EL(0),
-    [ARMMMUIdx_MPrivNegPri]     = EL(1),
-    [ARMMMUIdx_MSUser]          = EL(0),
-    [ARMMMUIdx_MSPriv]          = EL(1),
-    [ARMMMUIdx_MSUserNegPri]    = EL(0),
-    [ARMMMUIdx_MSPrivNegPri]    = EL(1),
+    [ARMMMUIdx_MUser]           = EL(0) | REL(1),
+    [ARMMMUIdx_MPriv]           = EL(1) | REL(1),
+    [ARMMMUIdx_MUserNegPri]     = EL(0) | REL(1),
+    [ARMMMUIdx_MPrivNegPri]     = EL(1) | REL(1),
+    [ARMMMUIdx_MSUser]          = EL(0) | REL(1),
+    [ARMMMUIdx_MSPriv]          = EL(1) | REL(1),
+    [ARMMMUIdx_MSUserNegPri]    = EL(0) | REL(1),
+    [ARMMMUIdx_MSPrivNegPri]    = EL(1) | REL(1),
 };
-- 
2.43.0


