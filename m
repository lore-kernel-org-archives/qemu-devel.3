Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC1CCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXZz-0004dG-FA; Thu, 14 Aug 2025 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXZL-0003ym-CH
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:35 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYx-0004Uh-1Y
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:35 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b47174c3b3fso521310a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176405; x=1755781205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FtjhMLhMPqBf/akhP4/Q7b8Tx2CMEduly/logXB3Ks=;
 b=MhrZGxs4UbHUpY+6FKdxTjZtIO1MxnY6o6jBCmhLxfKRCmbGPE61Etzxn/W0etlkH/
 eeHJUvbPzOG0Ej6bU+EGPq4cS8KRkN7hjlKYBxQ1zV44RQ/OjbrpOHs/78JO4zqVELNl
 0VldC44RJKhZn1I5vWFoFsY97ifyH3Llb902XtOfg+lYzcCiPXHAoHfe39e5IiMYZowy
 wccAo6oeDlyuC27P16wUEc+S2mSpu5j4iCkavmqftwcXN65vqV810W1YBEIFfdHABSLv
 jTtKlNqucpRKN7GzXrhVlo5LELzdryi+eWM5LVMkELWFX1ciBA13jSzzyT+ANhh+IOZC
 La/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176405; x=1755781205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FtjhMLhMPqBf/akhP4/Q7b8Tx2CMEduly/logXB3Ks=;
 b=u6RqJm7q8cxGCbRZaMOE74oxX3av5DjuaJkXAA0c7Gj414MrxeJNYvuutTFdEUs5Qv
 LacYgRSnGWJ+WJNTddE11FIDUbTQX+Bgj5heJGCo6TTLN9OoC2TudmbEQpgewb2N/KJ6
 QUSB0TgDqv1rqkZ+KjLfXjPojABXRnkzGK6k0amxbp64/VQB8hhWrCsAAS53yWoriNLP
 bHJ2RZCH7/6UyIyrg+LWL1BOGC/ySAR4ktjVza93mpNYvLLRaQ9Cciah6sIj+5+hofYS
 MgdkVd3dGOs8drmg49pTyCY9Cs9GkicJAMOLdBmKWJVg9k4kIn8nVsjMHL6q/M7fBwqb
 qOhQ==
X-Gm-Message-State: AOJu0Yx2yJ2Jw8ditQHrCxobQUrHArEIIF1kaKCW2tgrHCGYrrFQNXMv
 5YrLAqisvlnngWJPPWyOJOb4mQEBXwzdO33xtizmKIB7NuwXDRd3ooaMCC+2U9XEw74YIBkYHUl
 byjQ9Ax4=
X-Gm-Gg: ASbGncveINQrK5wDUaanmKN36O45S3W/VngdurVeR6dk47isKOpGZeC6sjq2lm186Rh
 MQSW1dqkNZH67lU3ysQWNnVPvdWhLCTDQBrxkSGC9NMkmwnCCJa+DF+c9UtxVf/fpWNKK4SJzTF
 2LwzqkGm44gmXdwVEkAgzNLTq3h/Id4KQQDmROyKNyVLc3//6dGNqIkePXxpngNEIRUaA7rRGmk
 fLJzfITwHCSElF+r7/oyVKkn+kIBo1tlNQs2S/SCsJWgdUSTRtrDE/w0o5Icnfco7fc18k+Jsqw
 tKJ/lf3iXaMZDlTkfLHsT5P/sJzBXNHU9ajXa8deG0ozYCmolIRpe/dI1Q0CuXv0E6I6FXXLhpY
 fm98cEIsCyY6oMZ2gXDovXx4kOdyX9TMZ3oAHY0Mp1nJMtAM=
X-Google-Smtp-Source: AGHT+IF1feypvFahF1ADfsXFSA/M8KBqervXiIV62lURlMYRe0V0X8puestAwBQep2iWCTihDh45hQ==
X-Received: by 2002:a17:903:a90:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-244584d6ccbmr42660365ad.13.1755176405274; 
 Thu, 14 Aug 2025 06:00:05 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.06.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 38/85] target/arm: Convert regime_is_pan from switch to
 table
Date: Thu, 14 Aug 2025 22:57:05 +1000
Message-ID: <20250814125752.164107-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


