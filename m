Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410E5C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLlX-0001Oc-Ml; Sat, 02 Aug 2025 19:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLit-0002NY-5b
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:33:07 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLiq-0005Il-7m
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:33:06 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ffaa884a44so2081180fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177582; x=1754782382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FtjhMLhMPqBf/akhP4/Q7b8Tx2CMEduly/logXB3Ks=;
 b=MA7Tg9bbF2uiyofQ7352+TFWnYkyRsPCVm8xbF6e0ptnDeyPr+Gy1kzboJTYOHIKQk
 halax0aIdf5PNLCvXbo/b/viHGrsXWOeJDTgm4dKM3fH0DEQ0JVR7s0/mZn+avYPfTJm
 CkkpuN4H1pb2tlLglwk4DtPplNzLu0s2iX6ruvmY2gMeldEs/rMg+EZT1vd5Qohb31f6
 nTCumVTrpVwtb/PBUpb4oVhYVqcfmDgxPu9Kt6yrLcdMRYnVBCaajcXQ+3JVHjCsD7Yf
 Nn/96wOtGrwUV+FT518NQgZYhcxFHpTS1JCprtOYG+uSJUqCZ/j+9kKM8xy5icAXjx4D
 1BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177582; x=1754782382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FtjhMLhMPqBf/akhP4/Q7b8Tx2CMEduly/logXB3Ks=;
 b=LoOGjBUuumoh6tXZPzms4FoVrJmiyssJdzQiiCIQ+pDi7weGneIMstZ3j3mkzCukAy
 uxRfIUH+8sfjKUfFUBqv0BzwBmH1lB6xK9Y+OeJ1NXu8GezNGoy/xTgIuleVcdvIxfOE
 V9zIznMwqmNeoF8lFvyzRGingQB6R1RlZP7jxEDv+otIyyF3rWwN22iCxeno3JzUINeB
 7xtusxxUd/F2J68/QAhdZEJ9C1NB/WcMtqM6lSf2HjKlOtwYBlzikKL//aAem8yz1hfH
 Skmz0p50sONrN94BvyLsRgtgJ0xjEEwh7D693na7pk/adbfsfickphIc/PlW0YsLQqDL
 Phgg==
X-Gm-Message-State: AOJu0YxB6LA7fSnuzdR0gE1Ly0pLwSRHSfI5ymZDAckjzDA8rjTT1Py8
 7NLKZHaes/7JUDtyTnoM8/KzJoIFYyDCy+Ib71PpX/sf5F3oAVz2O6qmW78hzTUjhRcC1SFxD+m
 U+8+AoNQ=
X-Gm-Gg: ASbGnct5S219jzylOrrPbIxsNX5rhQ9QahxC0n255bv0NWdat1ZUVzS9D2gySlF3p48
 yPBTAMdsuykDaewoKIrCGJ1dbxBNA0daNle0FP0UWjpbXOlpGFHZQjowu+mGeg9i/v6oVdC1SYe
 j0LM1uVJIAfmGgSru3jhhK9oFqFSaEOxP2n+iPv5RE7hW+ujMCyqcTLEz6rdhppVbz2Z25LHkZr
 C/gor8k2Hpc4viTxM6KSWTrNsxSmG9FSooFbaqO01Ma8qJs3TqaQZcQPC+Z4F7kh7TKFf6LfMOI
 U0GeGrmOJH/wvKrruYkfG7+x3S3Dorut/5f39bPAEsjW50ppotkEWIgsnEdmJf6LGYoDTAVlBHq
 k4u4l96P6FELEizoUI3SIo+rU7qq3XWtrkGIlHdmqlU8GrV8KA2IT
X-Google-Smtp-Source: AGHT+IFHWK1G/DsWOIrrEvnMh4//0acEeGJFeyNLA7J8ewcVJqBhyyExlozGJzjucIUydrU1ZK7sag==
X-Received: by 2002:a05:6870:d8f:b0:306:e708:c958 with SMTP id
 586e51a60fabf-30b6685aa08mr2847951fac.4.1754177582557; 
 Sat, 02 Aug 2025 16:33:02 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:33:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 38/85] target/arm: Convert regime_is_pan from switch to
 table
Date: Sun,  3 Aug 2025 09:29:06 +1000
Message-ID: <20250802232953.413294-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
 target/arm/internals.h       | 13 -------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  9 +++++----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 962fc423a6..f665971b97 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1029,19 +1029,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_E30_3_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
 {
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index f03a2ab94c..41baf1a003 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -16,6 +16,7 @@ FIELD(MMUIDXINFO, ELVALID, 2, 1)
 FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
+FIELD(MMUIDXINFO, PAN, 7, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -56,4 +57,11 @@ static inline bool regime_has_2_ranges(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, 2RANGES);
 }
 
+/* Return true if Privileged Access Never is enabled for this mmu index. */
+static inline bool regime_is_pan(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, PAN);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index f880d21606..98db02b8e5 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -10,6 +10,7 @@
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 #define R2     R_MMUIDXINFO_2RANGES_MASK
+#define PAN    R_MMUIDXINFO_PAN_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -17,24 +18,24 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
      */
     [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
     [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
-    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2,
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2 | PAN,
 
     [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
     [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
-    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2,
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2 | PAN,
 
     [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
     [ARMMMUIdx_E3]              = EL(3) | REL(3),
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
-    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
 
     /*
      * M-profile.
-- 
2.43.0


