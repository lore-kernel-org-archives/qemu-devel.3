Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CBCCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOCF-0000u1-69; Sat, 30 Aug 2025 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQ4-00077e-P0
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:33 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQ2-0004mb-PB
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:32 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b49cf21320aso3042397a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532789; x=1757137589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVPUEePgDMkssZ7MFBYpdcgxo2UwneCHfZVtrhGEyek=;
 b=aV4iY0vBZ4yhz4ZlF5kpjhz4zHBHipM482iPbAoYYQKgEMfRJZFkjR58ytouRetiB9
 fLXHCLFztA5BFko4EajvdLRnoBzBqWtmV8x25Uy0EWrmgdeAX9bCu0uFS293Z+/tzW57
 2h1x3gw9PRs1lDKR/yaeVSu6nty6cbT3ZD2TGKhC9EtVeEKE1dsYkrYtt23bbfG3KG6S
 xglUJDe2dIwQ0gS3lKkHM7+Y9iXILNu3e27LqMBngUoLLn06KI1zTxpvgGqjA8gj3miL
 o7RP2qwyhjbSQX6e0Ogkt1Uf561X0AHpZ4ovAWcDljzTCI9ApiyKWdut7hh7i6AzYbWH
 tbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532789; x=1757137589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVPUEePgDMkssZ7MFBYpdcgxo2UwneCHfZVtrhGEyek=;
 b=OF3EMnwApfrAs2lw7PK+c4Jz/256DOlfYS7ZIk1jKzgqLML5ywxfB9ee8JY0LzXRr0
 2QqOcTtxmC/2MDYd235oFiYqm+5PN6Ile8onVQjEl2KkPIJkWRrgtjcBYdNLj+HN2uue
 x0klJD+hpufFMwUy9flcyoIDn1W0xI/cUmBocWT5o7WL1BLs9mSiojPzouNc3JBlbzaG
 cM6YvswKxRGfZCSSTRkzAmcxOzRB8r5/py4vhp2YCmrPMFRc8TVFUdtKhSWnIHMSChvS
 +zRmf9ueDbt8vTgZ0Epbc63kbcCYGA7bHeds7/pTimAwcF3k6Lx5Z3ujKrkkq5wg+HUv
 3reA==
X-Gm-Message-State: AOJu0YzqWUsS4i0AeNEbFqsrJDjsjz9LMlrb3LGnTUFLcSr+ubOy99fv
 TLm3YUR2+2ItWfIbLUAhMEc7CwrrqESc4KhAaMlkYXK8od4+oJv3cjEGwcA6NGV8Aqx/eiqkaZJ
 Z0fYklnQ=
X-Gm-Gg: ASbGncsm+TXAGIR+Q1u/j+h7HRmNrtos7kbDpGxRzrJBxRVZ/uByo3iFV5mfy/nHtEH
 B5c3xqfnO4Lj6bDIs8RyK+rc7SqCy7tAHo5+4lBT5aEzSVkRleJvcLb03Czo261CKWpuJdaw/2m
 SCe1kGPriwo2bbgGF9E/3TSfQVQ6ZsFzrC0BCudtsb6IyAYgadb3vtoYssk+ZeBxu9ipBEC7zqu
 2GM50BfjTSkJq0KB7lJP/IrqEKh3bdFsvHeYWeFm1bOgu2/SNUGHSBhJ3tiqI2DBveNC9nQOpAa
 WuRtlAhqZ8avtNPvNbm81JjR08nhD2jn4gpACHPkw2E7ewL+LWhvncQvNjAx9Z1cHb6ptPgKlKO
 KO+w6Gu0PzPHPiWGPnumnLuXHrEkUMa7kXyXg5CeHJYhk0V7Zpp6WTYQ6NsFwkCU=
X-Google-Smtp-Source: AGHT+IHpvxLSN/pnVLsXefGO7Lw7ipeFwAgHNQIzP0Q2aoVEaubFuIhliDNN7VoA2ZzBB/GwGAZCsQ==
X-Received: by 2002:a17:903:2309:b0:249:3781:38e3 with SMTP id
 d9443c01a7336-2494486f48fmr12995325ad.10.1756532789354; 
 Fri, 29 Aug 2025 22:46:29 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 40/84] target/arm: Convert regime_is_user from switch to
 table
Date: Sat, 30 Aug 2025 15:40:44 +1000
Message-ID: <20250830054128.448363-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index 1704ee8dbb..a2e5ae42a3 100644
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


