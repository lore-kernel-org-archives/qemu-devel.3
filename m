Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4DDCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNxG-0002SY-42; Sat, 30 Aug 2025 11:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQ7-000781-SH
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:36 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQ5-0004n3-NS
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:35 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2445806df50so22233625ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532792; x=1757137592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XY9uHEs+/yg9KP8B5F1HuhY0y0pvH7Pd4YfxX4PFYC4=;
 b=EzBkBF+GN5kHQb/NBiZ/SqTXi5rzjBzzUmvsEN6Ncq9zge/7lja1Mjg8P/VWD3h69c
 jlKuKrInMPogD284GviW27ldlnux0WH7Wv6es8ZdIVNxNefmqEXCU/zRBYcmQuz9hiOk
 XdxIYDdEl/NBKfdHJKZDu6t5r0D8K/1W0QFmYJbPRdFgiRspNm29x5VLW4HAziF++OE+
 cuJkZ7X7syEQ5SS2Ury1WJR1YHksXiqjqtrE02+okEn+2JP8dbYxGJugiHfpcHuI01b+
 rYoHeNufNmW2AkUp0VLh2p9rpuRhOQndbU8goaIawTFqJcBGb6W1il1o/LLJCKOgycDx
 fkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532792; x=1757137592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XY9uHEs+/yg9KP8B5F1HuhY0y0pvH7Pd4YfxX4PFYC4=;
 b=AZIz+UO53h7lBMhKZhHGLCQGcQzs4/IeO3O1RpFpD7354kmkac3wgvFhDFlla7dwYh
 5SkcPgi2WuAnD37AhwEpzKbNmFwRguRTIq2MOJ+U3BxqSeROvtjfVc4jIKIthnEKjzIF
 bN3dLR4fIzIdbab8aOVUVYJnJzo7tz+QEwJj47m7XWI07oewHl5aTX7bMDvtowewgX07
 YFxqwwQyInPxrJc5yiBptKfONqAQGqYaG6OpsGI4ZBqQSPOhZ8F8lsRqkZAGN+nPBmR7
 NXbpMgakOWGw76pXYoN5Lv646bVYs6lKguwFbfyphrinHb0ChjGTGPt8qfhLdRNyX/HH
 b3Hg==
X-Gm-Message-State: AOJu0Yycdz26C0tZFxfG0Hv0fodDQbkf0KEc5Erlhxd6UAkg8/UXj7k2
 TwKwgnotIR3B6tTfOYg+fwFQz7Lbbn3HsMh/1ZoOVac0ZtEs3SXiw169HWLyEfzlPD35IvnNSMP
 wBdVITNk=
X-Gm-Gg: ASbGncs9kIMr8PP4toArsjKgOemw+JaI44riR2C4hTmik2DEZkOL+ZtPl9azn+GeE0h
 SvCbEJxE8ih2quHZjU3yS/9a7HGCqhjIAs+E2JDmz80v5+A4qCLKWxvhloZMTpFm48NcT3znvjU
 pQrPBRBfAlA+d1zQ6HHRgC2PunRNvfNo6C3QkmBI3h0nP2lrbpg9qStrLWXiNcH66xTyhBIy4Qn
 SaAkyxveyTBezDNzZd633ZrnQROQ4EHYVFmuTIWWJFWXLejBAJbwbWxExqlPfDGbTi+SY3T1Deq
 6PQ2yo9f8vF8r8IXbB1SPIAwTcvHRprxOBPP4Ccx/iTVDEeVMhdyCYbR6M+f7oXyjYfWZi8PLc9
 MXE2BRJ11+mEr1TcDhqGisiOdtw4vgeLYCR1UglOsAuHGHpVKaS/y30pJycQLKIQXsloW1fSHUw
 ==
X-Google-Smtp-Source: AGHT+IFe02smqgeyMwCoLStf1SQtlRow1nJTLP8rgLGNmb/6A620HSkYjuKNkPIGwn51hiJV6xjqVQ==
X-Received: by 2002:a17:903:2288:b0:246:ae6e:e5e4 with SMTP id
 d9443c01a7336-249448ded1amr14470245ad.6.1756532792177; 
 Fri, 29 Aug 2025 22:46:32 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 41/84] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Sat, 30 Aug 2025 15:40:45 +1000
Message-ID: <20250830054128.448363-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/arm/internals.h       | 19 -------------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  7 ++++---
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a2e5ae42a3..68db7559b0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1280,25 +1280,6 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx);
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
-/**
- * arm_mmu_idx_is_stage1_of_2:
- * @mmu_idx: The ARMMMUIdx to test
- *
- * Return true if @mmu_idx is a NOTLB mmu_idx that is the
- * first stage of a two stage regime.
- */
-static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
                                                const ARMISARegisters *id)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 3e51c0f579..55fba4aae2 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -18,6 +18,7 @@ FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
+FIELD(MMUIDXINFO, STAGE1, 9, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -76,4 +77,11 @@ static inline bool regime_is_user(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, USER);
 }
 
+/* Return true if this mmu index is stage 1 of a 2-stage translation. */
+static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE1);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 1c1e062bfe..c5b43a5932 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -13,6 +13,7 @@
 #define R2     R_MMUIDXINFO_2RANGES_MASK
 #define PAN    R_MMUIDXINFO_PAN_MASK
 #define USER   R_MMUIDXINFO_USER_MASK
+#define S1     R_MMUIDXINFO_STAGE1_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -35,9 +36,9 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | USER,
-    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
+    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | S1 | PAN,
 
     /*
      * M-profile.
-- 
2.43.0


