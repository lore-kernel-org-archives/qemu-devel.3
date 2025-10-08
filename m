Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A12CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cAI-0004GN-Dj; Wed, 08 Oct 2025 17:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9y-0004EC-Oj
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9A-0006hs-Qo
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:22 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-330631e534eso436635a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960590; x=1760565390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufbIAsiBDfbdyvsFouOClRyF47XEv9v24R99qbCOlJw=;
 b=Gg9DuAMMhvjP0gHEO9PiqqsMXTXlbh7qq0iKepi8Z+KFzZoppvvFgMvBS93SW0rpU0
 pZAloLEA1IAh4I0tCEMRl0vo7jD4jfNYb0xeOtlZ/DrMksk8NI3WUS54nvJJhWy5sB7+
 6wgNZKBTOA00nyKEpXbKTpdLDILDsY9lFDxG0ZD4/vwPP5/+igyVADU3/8DwFSTSm2RD
 f1fNo+lFl4vUequwb/RCXrR4kmVRGBo6NRlVTtNFVSyKc2T5yZTSbC6e1UyhJKv8U5P8
 8ukYOIFu9Ogqk4L4Vs0TAfEHzFE3sXAWKPfqOtlF1ExL0EUdsJnonSLLjAFtoKaSPyrH
 0++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960590; x=1760565390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufbIAsiBDfbdyvsFouOClRyF47XEv9v24R99qbCOlJw=;
 b=bgvdKCh53S8iMKEyLlKuI6wUeC9DLu86v6cppAAZqlmh+w48EbsPKiPUuUhghPtXeu
 Bx18lLPDGAmxs5LAQTqNXi8HwUYsG5pLmij8dP7n0Zpjb7bTgHcFOGjlLJbhGmXmP0Ma
 lAdwU+49DyExahoewgBFRirC18Zs4Iynu2YjR7Mi02ipvUg5fVqI1urxtvdc1WSvo53C
 RkLAx04IaCerIaWCRNjMWeOkpKBs4F5gX6TtNPiqcjw79CQ3NKriWlgTavJiYghwfshN
 LElQsd6kWh200EVM2SH1DfLTRr/9b04sl3zpuAbYFOEWxHgVrksUNdQdaIMEI3DYuPrV
 YPKg==
X-Gm-Message-State: AOJu0Yyxgne3e+lw+M7P+jfIDcjRhRPmdPWHslH/1FC++5L0aClCu0DS
 cd7WAs5jsofrUkZdm0EpsgHW7oNAT3LJ1Dl97yNONNQtzNiu3WIg24f7pU+qiQaSI4oyLGuoeSu
 RmU9xCTY=
X-Gm-Gg: ASbGncvsJeVoLwHMlU7efiSzuyzEzX5iEoxIkPyR1OYjAbNzEpVLD5XVA/41g3mCSb8
 B/S7HUp/YRqn4AeEtkhPzFuwNTimtceguRwPMkInq64mjEDx18NWuJWZhaqe7V084RCMwTixgfF
 b4Z6OAIBqvgWmgr7ciV56gNM2+dfejAmXhMVP2WFmX3bUHz+Yk188ykJKNF403GvAGXakvtijTH
 CMBwkboBW4sNIEI5T0u1hjJ+3oXzsptG00ysIULhV+jeUZhS7J8Kl4q21lBQOilp8ApfCQspPCg
 2gJ2VhUAfJQ45T8oluJ7iC3taAOQf+YhpAua7hYkr3dGeuGaiRVwrfnLa+HOlXYcMWYJvgmtISL
 AmZkbuTPmJbP1DsMzxIM1Lr3yIf5bCZpKg9xgz13Qb3cylO3WBIrzfbcg
X-Google-Smtp-Source: AGHT+IGvP1goTOTfBy8gabTXv88eAl2t67KKNYtu0TZTvBYwL2CLNi1dfGzU4AOsUcC3sBdBRGLDFA==
X-Received: by 2002:a17:902:fc4c:b0:273:ab5f:a507 with SMTP id
 d9443c01a7336-290273799aemr70991105ad.21.1759960590321; 
 Wed, 08 Oct 2025 14:56:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 24/73] target/arm: Convert regime_is_user from switch to
 table
Date: Wed,  8 Oct 2025 14:55:24 -0700
Message-ID: <20251008215613.300150-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 17 -----------------
 target/arm/mmuidx-internal.h | 12 ++++++++++++
 target/arm/mmuidx.c          |  6 ++++--
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d0d976cbb0..c4aef8b50e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1032,23 +1032,6 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-static inline bool regime_is_user(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E30_0:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSUser:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-        return true;
-    default:
-        return false;
-    }
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 41baf1a003..3e51c0f579 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -17,6 +17,7 @@ FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
+FIELD(MMUIDXINFO, USER, 8, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -64,4 +65,15 @@ static inline bool regime_is_pan(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, PAN);
 }
 
+/*
+ * Return true if the exception level associated with this mmu index is 0.
+ * Differs from arm_mmu_idx_to_el(idx) == 0 in that this allows querying
+ * Stage1 and Stage2 mmu indexes.
+ */
+static inline bool regime_is_user(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, USER);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 98db02b8e5..1c1e062bfe 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -7,10 +7,12 @@
 #include "mmuidx-internal.h"
 
 
-#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
+#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK | \
+                ((X == 0) << R_MMUIDXINFO_USER_SHIFT))
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 #define R2     R_MMUIDXINFO_2RANGES_MASK
 #define PAN    R_MMUIDXINFO_PAN_MASK
+#define USER   R_MMUIDXINFO_USER_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -33,7 +35,7 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | USER,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
     [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
 
-- 
2.43.0


