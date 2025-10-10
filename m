Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D305CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cph-0006R0-Uf; Fri, 10 Oct 2025 09:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpV-0006OH-RG
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coz-0003uH-Lc
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so2384639f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101562; x=1760706362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=60mif/8MwhiJJJmqgo8olqmhs50uYNKWIxL0Oe5uBc4=;
 b=BxzKUL7q9XF4UOlq2vDBWm5x70VcuKkpIt89Rd79HiCISeZx1AiMne/I2C4z8w4B0v
 DFM799oWRryJ17cM5bkHdXsvYMeQyr1QG4wcbZw4cKizo5ymZogkRE33RkTwEwwsNnBd
 suP2LcS7+0NvDPVsH8i7WBK2uRXH7lftWmxCDtyheOIOKw7kvDgIWRoBJAgPLxqqF67Y
 xQXvA0Iua6+aTYEQx+AOztFA+XWWVc9DCIbMQwxj41dP15E6EvNbfJMDK5/Qs6zqYLcX
 K01ezrSxIxERvyyUl7asSrH3SY88TtBAOLVINApNzPp15aVGNV0Ax9qxNWB6wxyBghvx
 P8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101562; x=1760706362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60mif/8MwhiJJJmqgo8olqmhs50uYNKWIxL0Oe5uBc4=;
 b=gcF6UydJ0CWGscn2XwQVyEGPB1HpqnWfi+g0GQ3kivU5qs1BO7y796McfZIHwDoR3D
 htoJkp+Lm40yqdYiNJbbieBeEurbvSSeHVkhXQu6xlf11mEuZb1G1sUrR1Y7CkDZFe0y
 oVOZPSmtPg1xPRLcybv8dlAkcBtd5z/Dl6zc6L/K7hiT1dXFLJV9CCqOjdswuyz5UXcG
 UbvLDCgCCx95LByb2AKtMu503vNwuEJlttrD8j3REe5nLfPdo0+C8StFqPGfYT/9+Vn3
 jNScgKvAEDCz58o3JqCMRKbCzgz3wq5DkjQDY0z9bMemg+/vacoorG/qszRNAU0LvZgS
 LKfQ==
X-Gm-Message-State: AOJu0Ywh5/DgDjPRdT+NstmAdEn0YHdlOUNrxsLpqSBMIs8jeJ42qGyD
 5JJg2rstKqvEbGEnE7B9rCyx3EzpGMuMivApfKIoIJezOGGzt97AtCVeLIfFWKAJTlYKKFa0boq
 u4UeW
X-Gm-Gg: ASbGncvdyjyBbLJp/OhNUYMNiYm5N8Mw0Jo26VggP+rCNQkfePOWefHIM07Q5EhIbQf
 7X9ltW0Usi4gPHFLM4A6jTpBN9FMnajKBqJdvk7RW6MX5K3hpcoc90YjrNbMUJzHtWMusreZENT
 7Z7d+ycBAZ1Jur0SB8368eTwVk1rnBbOGBEMv5dzSPn2m6a1xHG2tJHa6xmgCEBbPM227n3b2vh
 wYeqrkqNLAgXrdEh00BKO6V2oV6DdqTBEatnc4wxCJTcJbN6GCP7SjQsTJKyvuejXVQlS4qK6me
 xs5jquA5W34j5WmZpbtSWHWyABSDmJt5fqEwTiFNIordQ3AcnyBojPgKuTvKoF+LdzK64vim1Zz
 hnujzNdYrddN640xv/1lL6/RMU5vR3ZMXJHV0Nr8H0bEHECfr/P1YGXvphMg+tQ==
X-Google-Smtp-Source: AGHT+IH1j4psnixOwklT48VUw07bYwkabZwhOYudc62NkxKbriYJxRJ7FPpMHZOAPQsl2xz/Td37vA==
X-Received: by 2002:a5d:5f47:0:b0:3ec:df5a:90d with SMTP id
 ffacd0b85a97d-4266e8e4dbdmr8105717f8f.60.1760101562025; 
 Fri, 10 Oct 2025 06:06:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/76] target/arm: Introduce regime_to_gcs
Date: Fri, 10 Oct 2025 14:04:39 +0100
Message-ID: <20251010130527.3921602-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Add a lookup from any a64 mmu index to the gcs mmu index
within the same translation regime.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/mmuidx-internal.h | 10 ++++++++++
 target/arm/mmuidx.c          | 24 +++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index f494ec348d6..962b0538526 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -21,6 +21,7 @@ FIELD(MMUIDXINFO, USER, 8, 1)
 FIELD(MMUIDXINFO, STAGE1, 9, 1)
 FIELD(MMUIDXINFO, STAGE2, 10, 1)
 FIELD(MMUIDXINFO, GCS, 11, 1)
+FIELD(MMUIDXINFO, TG, 12, 5)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -100,4 +101,13 @@ static inline bool regime_is_gcs(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, GCS);
 }
 
+/* Return the GCS MMUIdx for a given regime. */
+static inline ARMMMUIdx regime_to_gcs(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    uint32_t core = FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, TG);
+    tcg_debug_assert(core != 0); /* core 0 is E10_0, not a GCS index */
+    return core | ARM_MMU_IDX_A;
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 42b003db9cb..a4663c8d872 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -16,27 +16,29 @@
 #define S1     R_MMUIDXINFO_STAGE1_MASK
 #define S2     R_MMUIDXINFO_STAGE2_MASK
 #define GCS    R_MMUIDXINFO_GCS_MASK
+#define TG(X)  \
+    ((ARMMMUIdx_##X##_GCS & ARM_MMU_IDX_COREIDX_MASK) << R_MMUIDXINFO_TG_SHIFT)
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
-    [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
+    [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2 | TG(E10_0),
     [ARMMMUIdx_E10_0_GCS]       = EL(0) | REL(1) | R2 | GCS,
-    [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
-    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2 | PAN,
+    [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2 | TG(E10_1),
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2 | TG(E10_1) | PAN,
     [ARMMMUIdx_E10_1_GCS]       = EL(1) | REL(1) | R2 | GCS,
 
-    [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
+    [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2 | TG(E20_0),
     [ARMMMUIdx_E20_0_GCS]       = EL(0) | REL(2) | R2 | GCS,
-    [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
-    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2 | PAN,
+    [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2 | TG(E20_2),
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2 | TG(E20_2) | PAN,
     [ARMMMUIdx_E20_2_GCS]       = EL(2) | REL(2) | R2 | GCS,
 
-    [ARMMMUIdx_E2]              = EL(2) | REL(2),
+    [ARMMMUIdx_E2]              = EL(2) | REL(2) | TG(E2),
     [ARMMMUIdx_E2_GCS]          = EL(2) | REL(2) | GCS,
 
-    [ARMMMUIdx_E3]              = EL(3) | REL(3),
+    [ARMMMUIdx_E3]              = EL(3) | REL(3) | TG(E3),
     [ARMMMUIdx_E3_GCS]          = EL(3) | REL(3) | GCS,
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
     [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
@@ -44,10 +46,10 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2) | S2,
     [ARMMMUIdx_Stage2]          = REL(2) | S2,
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER | TG(Stage1_E0),
     [ARMMMUIdx_Stage1_E0_GCS]   = REL(1) | R2 | S1 | USER | GCS,
-    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | S1 | PAN,
+    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1 | TG(Stage1_E1),
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | S1 | TG(Stage1_E1) | PAN,
     [ARMMMUIdx_Stage1_E1_GCS]   = REL(1) | R2 | S1 | GCS,
 
     /*
-- 
2.43.0


