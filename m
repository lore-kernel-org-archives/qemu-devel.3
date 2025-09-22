Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1ADCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lcA-00056U-Fi; Mon, 22 Sep 2025 14:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc5-00050i-3m
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbw-0004FP-Jj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f2c7ba550so1514780b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567003; x=1759171803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMkbENUvVqZ656cyeBLZAoddv/+9a0gSIGqLUctDUDE=;
 b=fNOvd8d55rFj3tlGmLQ3Otc+MebPgCPQSUWj0KQYyxNWBrjZqCziy4XrDh9r4/+/4B
 TMZTlZhWSTk7uzZP6OvYeUd0yaI+qIQD+vXsw7h5xcQbDWhuZlFGyZ5AqltRZ8iwO5v9
 U8Pmwhs3uxwoo8cGh5Wv+ANMr4PRml0FPRhJd3z40q4Ua+8d7ILxPS90q0ln9Ntc9tbB
 hr55WRfFYdOB9Nkr/OzjpHiBWnMOkxjgoQ3tuFvAvx4yN6d8mJ6ru/dco7jK2sH+AVvi
 +n2HD4xbFGfgZKYfzzNSCdWXlm5qQDg7wmu8cDM5lVfw9B4Sw113VFMsHeCngz3iRkW6
 kgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567003; x=1759171803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMkbENUvVqZ656cyeBLZAoddv/+9a0gSIGqLUctDUDE=;
 b=vzTyDZfkM30n6qUbz/INt0YyIRZ1nTIAd7e6/GD2A0dkXXv8IgYkH1oxFgrlfMMJPR
 NGfuF66Zup39WcTCdqZ95OtV3MztyAONV5rLFv75S+quJlFjnGR54vDx5hDyHcTDqRTF
 J6VQd+UMMyDmlaoL9zliXu7MDpkI8YJRD8Dd+WziCJogKLvC+cb+kPPumLgfZQWU4s4t
 bYsc0gmfPScoA9Gd48MwOjdesWbo65p3QTn7/SHQMpumKrDfnTwR1KRG24UmYMUXF91e
 mD29lRDpbPcb50rjYoAGIo9DejjuTnjzDG7UsWPulk9niAzHfjKRSr0zOl0zXVQm89aP
 RYVQ==
X-Gm-Message-State: AOJu0YytrgmfmNsXYMG6chdAPfHOZLgUSRJatJXKPWCDBssANeOWgWTg
 LFJoKr1+8BXdkR+OKiKtoXoJSNtykypMcz8L7OxvO2gSRw9B5wv+c+44W3AiSa2jgZpWnZdLikM
 C+aBX
X-Gm-Gg: ASbGncucJwRWfnFbKR4bzdsR8ldIjTJ6H9lAm0GpsHJzzUWWaUZ9Llv5DeaaA6ulZyq
 ijGbzgAqLYvioFPue23QRTxVBGJvNA48dfolvdhX1wRLe1fg5ICTEEHoISx66YfBrMlwtiOPZd6
 4iSPvyiOUhLf/xADQKH67k3+WVKHHp88bNDxrWN3lzwIr3ofYyK2RTanoQMiyZW+ga7kvXAteGE
 IwpQQ2E98M72q3J9tU6zvUZ7YXgwDiv4q0wQuhvAGdC+O71KlR5aZJouyExR/l3RyFgP5TyzF6j
 PuzKOCNn4bNNqezULO/APnqTLjFkCN5GicCyAEejwDL5z9580l+XWSINe3RRXtQZQ6pgY9p/K49
 Qy8fPQkxH0UPZz7v1qFjff8z7BgEJdZ1m/jYhr+s=
X-Google-Smtp-Source: AGHT+IHeNJLn1pB27jiZsOuHmfx67iaGLzlbOh3OAZpfubnQcnsyQVhEzsNxYkykGM8GrR5rSvNu2A==
X-Received: by 2002:a05:6a20:6a1f:b0:2ba:103:aa3b with SMTP id
 adf61e73a8af0-2cffe9f51d9mr88061637.53.1758567002778; 
 Mon, 22 Sep 2025 11:50:02 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 29/76] target/arm: Convert regime_is_stage2 to table
Date: Mon, 22 Sep 2025 11:48:37 -0700
Message-ID: <20250922184924.2754205-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This wasn't using a switch, but two comparisons.
Convert it to arm_mmuidx_table for consistency.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 5 -----
 target/arm/mmuidx-internal.h | 8 ++++++++
 target/arm/mmuidx.c          | 5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 771f7748de..dc6bf3548e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,11 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
-{
-    return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 55fba4aae2..1d948aa6f4 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -19,6 +19,7 @@ FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
 FIELD(MMUIDXINFO, STAGE1, 9, 1)
+FIELD(MMUIDXINFO, STAGE2, 10, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -84,4 +85,11 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE1);
 }
 
+/* Return true if this mmu index is stage 2 of a 2-stage translation. */
+static inline bool regime_is_stage2(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE2);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index c5b43a5932..61a682e655 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -14,6 +14,7 @@
 #define PAN    R_MMUIDXINFO_PAN_MASK
 #define USER   R_MMUIDXINFO_USER_MASK
 #define S1     R_MMUIDXINFO_STAGE1_MASK
+#define S2     R_MMUIDXINFO_STAGE2_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -33,8 +34,8 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
     [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
-    [ARMMMUIdx_Stage2_S]        = REL(2),
-    [ARMMMUIdx_Stage2]          = REL(2),
+    [ARMMMUIdx_Stage2_S]        = REL(2) | S2,
+    [ARMMMUIdx_Stage2]          = REL(2) | S2,
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
-- 
2.43.0


