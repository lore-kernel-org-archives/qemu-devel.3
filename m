Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08041C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwPY-0002Tq-Hg; Sun, 27 Jul 2025 04:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwMD-0006bd-US
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwMA-0004D7-Us
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so8011105ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603421; x=1754208221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YV6leE4fgOKq8LWFBEf7PmSadRs+8Mz0dVJVLCLswgQ=;
 b=iGwuU1mUCEK+dSv19rrLCnNXcl+oDLMQHgGNed1iwD+mxLVeRSEUBqZDe4CH9bBv84
 6V+QcNFBHPrq66I8Er532d2uPZ8tL9QaOzJBrgBN7LS6oQHmFYFMO9ayDcqQeLAw465T
 I4SjQtUnxGUpkewcBwRVvmVOwkEQSlo7pCst31IPZlEXSQu79xzmFeDqk934+MigWbSl
 e2ap+r9Ttkbi7oEuwjlu/nXmNBIdZYquW/R4w4L4lWyx1TH7yQSN2DHt36UCzfirfjNi
 jqkPmbQj+SlCDokBGnLf7/nLaweWsX5RIjMFb7bHA6FQR0FN12KT/YQCuUBDm06q937F
 EDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603421; x=1754208221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YV6leE4fgOKq8LWFBEf7PmSadRs+8Mz0dVJVLCLswgQ=;
 b=S+mD1EbLTyPsuv4D9ncmRdCQq7iA3tfqoeezO+W6bpiOQuO4FNsNns4Ff/l1CmAF24
 ax1W1vSYqsOIduEGNnxrxlfcRkrmGfISaz1eKWURYWW6fSP+N1XKuYe6osMoMFCal5BI
 9AQZ6WuVc2MB+NSd5WLweydMdxAoEt1pDP9TJi8YPzwp3N+yGDFufuPUfBu9PSofczBH
 0zGXihXITY8AOIk3bdxahwwSbZwYLkxOLABUXVRgh2p0xA/++oUxWs5IZnyaJ+I86Ge3
 7J4y0KeWYNKM2JA7wpVTNdNi+mau8SJXFe0c3/1svVSUHsmg304/L4cJLuUoO9oot0T8
 86Pg==
X-Gm-Message-State: AOJu0YzG2NRP8p6pnxIY2CyehMxO5rsL2k7oyMjA05vJTk25lBkCyw8b
 cI4r7+FnoOqmMpIPHQjY4pS3T/dj07eVqZRFtZJbahctrd/J4SwXKHPr0BAQkrISQUagV8Y/bic
 wI2Do
X-Gm-Gg: ASbGncuFfQDA/WnMGV5gyFL6qTnV5po99Ub0G7No+jR+boXWqKHWOAHMJOfkCnLNENb
 3LjrFSSmf/1YJVy2RKxWRbbqrF5BFmPyLXxTLSiaCZwxUEFw9hqIXHLJOdTrvhR6R2uK+YVS3w1
 ZteU+Rca4rktyJxsq+KZy7WbuSki2XSRmU+VWVEcXV0ku64zaArhn3k18hAoxkimtbQvuDZKpz3
 w/3Q2lTGajfHLM6WwXlDAAqmuK10wpgL6yfNCcvwOOnz5DDkxZIrXFr/aygGdw0WUGUkkPO5OrJ
 EnO9vjJb/nf4m/o0lEy+K/b6F0Nu6ZNtqoBK4m36/oi9OdEksiC5H13bw7qxMATMUK/06aCNUjT
 +6WLLdWMqiuDOydbropF0cZe5YcZlhOCZDo3V5J0xkpXMLXQPkWwCgoMmSyLF7+GuD97BWbnPqV
 6IitD7T4hYnw==
X-Google-Smtp-Source: AGHT+IEHRISwR3dMbs8ZHoA+Q5EJ/5dJ4grfCKxnBfPlukxzoLno1A4Ku6l5AUE3W/+Hz2Mv+dcvGA==
X-Received: by 2002:a17:902:d585:b0:23f:b0f5:b73c with SMTP id
 d9443c01a7336-23fb30e81c9mr115784245ad.44.1753603421595; 
 Sun, 27 Jul 2025 01:03:41 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 37/82] target/arm: Convert regime_is_user from switch to table
Date: Sat, 26 Jul 2025 22:02:09 -1000
Message-ID: <20250727080254.83840-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/internals.h       | 17 -----------------
 target/arm/mmuidx-internal.h | 12 ++++++++++++
 target/arm/mmuidx.c          |  6 ++++--
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ea210c7179..c6f3ae470b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1034,23 +1034,6 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
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
index 5a7259a557..ef1f94a23f 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -17,6 +17,7 @@ FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
+FIELD(MMUIDXINFO, USER, 8, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -62,4 +63,15 @@ static inline bool regime_is_pan(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, PAN);
 }
 
+/*
+ * Return true if the exception level associated with this mmu index is 0.
+ * Differs from arm_mmu_idx_to_el(idx) == 0 in that this allows querying
+ * Stage1 and Stage2 mmu indexes.
+ */
+static inline bool regime_is_user(ARMMMUIdx idx)
+{
+    tcg_debug_assert((unsigned)idx < ARRAY_SIZE(arm_mmuidx_table));
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


