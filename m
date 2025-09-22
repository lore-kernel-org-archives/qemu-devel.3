Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lcH-0005Dw-BY; Mon, 22 Sep 2025 14:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc3-00050P-EB
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbv-0004EL-FA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77f0efd84abso2135852b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567002; x=1759171802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXEhGs2c7sX9UNzM1Em26qJHq6E+l20XSVscjZYvVl8=;
 b=JIyKxGh+Ti63Lk4m6pCiamqy+UH/7Yf7iGUaJuP6vkR0li1mRL41nNRKTpwce5ag5c
 h6zfIOpyQOc+MQ1RBLjG+bh9mp5kGPpuCJcQAE1RUkiTqPdeHIePeZFjqWgAYoLDb1/t
 SGHz+FcpHfTK8eH3aTYd/oGzoFx+aaxo+xjrC9Zva8pInjUWeEIX8geCjPwwduk8NBV7
 WpS3eZGrB2R3vZ792Ch5qZbkvWpGuyx0k5V/CR4J91VBu+LXmLbmLRzL5CSe/9SISgoE
 SZTsSkim+d/vG4fk7YkwhQOfUbc26J84JI+W1kAe7mBYtIHDYSsmEIrcd5sh/+WzIXjq
 88HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567002; x=1759171802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXEhGs2c7sX9UNzM1Em26qJHq6E+l20XSVscjZYvVl8=;
 b=t4fZu0hN4Po0FO7uhuYFZRNoR+zBhziZmbscXbeRjGXs5h8vefCZBC2GKlEIp5xEZK
 69k/l3TQlNv8pXglPCgtMtWwXsnf6Gd5LmjA3RL9QW7kqk6qU+07Xsa8WZbM1//SN8Lo
 MnEnibAYRUlfQNk3S+f2EnYn443vbelqeO47qetztsKrZ9zXnRJcmlOZ0tPe/+rywvo1
 NOAFngdXZLQFx9n8mFzXxX91rM9byJtdtGDKOeibnBiCyWdmcGC4koQafpFLdaJiR37+
 GG338lKVKogRQ1wQ6Q7n6wKieHMPZJUvWnZx2/ekoljSYZyzq2G9TRCZAXMB2vxHGBL9
 dYMA==
X-Gm-Message-State: AOJu0YwjsJFo8lZTwJr/PK1C6y4wBL6JLjTXuPBfINo3Xlbln7b6deas
 4R7uCh0At0/V+mVOOIoqwFX38NJuDcNPo3Tm1v7g8Yjfy87ON43bnuAnRKJvkFRVhwCfqjACJ02
 /8v+k
X-Gm-Gg: ASbGncvJewMIIgI+WknvuD0uz9wmfkGIOIgbZ0BZcMZc8SwiDeboWJJ2jVdTh1VjOZN
 i8XC/QVz8lbHGUAGWjuhvv2Atz8RFZ+pKCK6153nQboaWixERHl1tNBAzWFla92v24dSansEUy4
 mErf5TpYZkGDdxsV/hwmEXfQ/VJtRkjwRsjoZxZ9OVWPA+nwhvq7LMdJ13c5n6BC+lPdAJ6pTEF
 hyUk5PylvbfVHe8jt/if5djauheGyUTTzXhMy+4+s5/KyCy3SQ5GiSSu+0kAoIvUSxY3xm5Klfm
 VaUHlPha2dH55u/4NJgrgy5N5oMQ10CirRNBkk8ZE/eCmPG+IWngbtPbFsKTdUFmQ1oQE0pv7b5
 q24Gy1FsApjc1ScLcvXk8bwxjAT0Q
X-Google-Smtp-Source: AGHT+IGyJcjpSg9dEAZ6WxG9bnfJKkiMS4GH21i4I+L6ZQur2in73nvU+R236wQZYquUiAS+OH+jxQ==
X-Received: by 2002:a05:6a00:3e0a:b0:776:4fb5:bfc6 with SMTP id
 d2e1a72fcca58-77e4e8bd90bmr16339504b3a.21.1758567001664; 
 Mon, 22 Sep 2025 11:50:01 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 28/76] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Mon, 22 Sep 2025 11:48:36 -0700
Message-ID: <20250922184924.2754205-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index afdc5a92ae..771f7748de 100644
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


