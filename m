Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B950CAC5AD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lcF-0005Bq-Qk; Mon, 22 Sep 2025 14:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc1-0004xv-RR
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbs-0004CA-0R
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f1f8a114bso1622251b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566997; x=1759171797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HfYM97rkS2HFXVpmImKidouR7djYhqCiCCIkuQ4XIE=;
 b=acdsw12H8WYCCf/JNS78C7xPFL1ADS+inhZYrO/PZPah1oddlDsIKKGilBPx9vYzQ+
 N0oo5HjObQTRyUXj/d5hbclpT0npOu+/K7Jb5i4SuAdUJidj573qLif5hu7Qaik/KxF+
 epBtXEPBLdCqlIsgfDmcCES4MrEf9wDK9Oqb/tP1MesEui1fU0IEkEWKtGZmEBaU2j/y
 fw/bKX7viR1IqKtFSWueelDHixOjhUNnOL68etUSdzX31peW6wM3G/CXvW6Hp2bFixOb
 C/WvamJBYHZZ0OFgkaA0hFcTw4LtCNOnyYDdhxxh0Lq/kWJLsabHl3J5tBIZd3yjKrKP
 sK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566997; x=1759171797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HfYM97rkS2HFXVpmImKidouR7djYhqCiCCIkuQ4XIE=;
 b=b24Ge7WtHzD9VbinP6dGDqfkGlbLXfDm4ZfM8gRF9P4DCjKPN3ENHSgnMFRVmXIZLw
 LZbPDB1rKxpTSKCyGXKDQmK6d07OTYU937783T+OiOS+PCDQpwapmz/fgSQRvm7FOYU+
 QzrkT0wnY4Zp64xvvnE3IMUOcoBSCYfo6Z3hYcp5lKD+6wl08V+nruxDIGxMiFwLR3TF
 Nld2/gZRNYFBf0/vHXuNmIsSSfP/rnZPk+2n+WZclsSSS39gj2GruZxtb4QqtRKOT4dB
 RUHDNGC9HI3C4o8PbuZglIhBrFAk33L5fMwWw1Aq39xCF+mwux71ZqJg/IrsDHId7Zo3
 1EoQ==
X-Gm-Message-State: AOJu0YxngRJrc77qzeHpAZJYsjSc+uVXCEHa8Ra5fr6nsckxYRQd6k1u
 5UHusjwcLqGQ3azLS/H/R/nxMyRe595kmnknM66X9MXgvR/UJ/wQ8excu56Aiq38z4U4cJWwkGi
 Zjk1W
X-Gm-Gg: ASbGncsvq9k+FI9UuuJXJqrLWmCTyKOxufzpo64KJXINjZQKwDKHlqYb+mh+RW4QFKG
 vHDAnL+ijVbyAyqjNJah/hE7VM7Z0U7MqA0AuzJR0AxFmnAgeEJQHzJs9n9TF0z8Qjww9lTk/ZV
 HRlMcjMFYbkvTotQVuBAJYBdAvpu7r3pTDUPcPoFLzXczrsANs6WjC3PnAXLGoR70o/S24j+i7i
 Gw/gUwsT9nNQhmlBFSb9xvGyb6nmNjMT1Or3wbtbh1ja+MzJUuuT1ZR4ihsaMV3TwYPewBjDvDY
 Qm1qcQ8CpAcrM+DkhLUybvLQyJvt/VHRTY54us+wDa73Aqp6SWbujB6RryKTFc7vQFyCRYd+omU
 hTCismR9Xocf452dRq43JHMoKCYTfLKCqeioDNis=
X-Google-Smtp-Source: AGHT+IG73M0BaDKpuRN3SiaqIjL34X10Tl5tV5q2m747yXhQZmk01oflbfQx3dtdaBE88yo7CvbfDg==
X-Received: by 2002:a05:6a20:1595:b0:263:4717:559 with SMTP id
 adf61e73a8af0-292188e67a3mr15919813637.20.1758566996778; 
 Mon, 22 Sep 2025 11:49:56 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 23/76] target/arm: Convert regime_has_2_ranges from switch
 to table
Date: Mon, 22 Sep 2025 11:48:31 -0700
Message-ID: <20250922184924.2754205-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 28 ----------------------------
 target/arm/mmuidx-internal.h | 17 +++++++++++++++++
 target/arm/mmuidx.c          | 19 ++++++++++---------
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a886282957..a25ef90c4c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,34 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-/*
- * Return true if this address translation regime has two ranges.
- * Note that this will not return the correct answer for AArch32
- * Secure PL1&0 (i.e. mmu indexes E3, E30_0, E30_3_PAN), but it is
- * never called from a context where EL3 can be AArch32. (The
- * correct return value for ARMMMUIdx_E3 would be different for
- * that case, so we can't just make the function return the
- * correct value anyway; we would need an extra "bool e3_is_aarch32"
- * argument which all the current callsites would pass as 'false'.)
- */
-static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index d8d64a14d6..f03a2ab94c 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -15,6 +15,7 @@ FIELD(MMUIDXINFO, EL, 0, 2)
 FIELD(MMUIDXINFO, ELVALID, 2, 1)
 FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
+FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -39,4 +40,20 @@ static inline uint32_t regime_el(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, REL);
 }
 
+/*
+ * Return true if this address translation regime has two ranges.
+ * Note that this will not return the correct answer for AArch32
+ * Secure PL1&0 (i.e. mmu indexes E3, E30_0, E30_3_PAN), but it is
+ * never called from a context where EL3 can be AArch32. (The
+ * correct return value for ARMMMUIdx_E3 would be different for
+ * that case, so we can't just make the function return the
+ * correct value anyway; we would need an extra "bool e3_is_aarch32"
+ * argument which all the current callsites would pass as 'false'.)
+ */
+static inline bool regime_has_2_ranges(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, 2RANGES);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 6dfefa56c2..f880d21606 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -9,18 +9,19 @@
 
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
+#define R2     R_MMUIDXINFO_2RANGES_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
-    [ARMMMUIdx_E10_0]           = EL(0) | REL(1),
-    [ARMMMUIdx_E10_1]           = EL(1) | REL(1),
-    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1),
+    [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
+    [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2,
 
-    [ARMMMUIdx_E20_0]           = EL(0) | REL(2),
-    [ARMMMUIdx_E20_2]           = EL(2) | REL(2),
-    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2),
+    [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
+    [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2,
 
     [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
@@ -31,9 +32,9 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1),
-    [ARMMMUIdx_Stage1_E1]       = REL(1),
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1),
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2,
 
     /*
      * M-profile.
-- 
2.43.0


