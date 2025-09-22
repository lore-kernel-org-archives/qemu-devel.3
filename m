Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162F6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lc9-00055A-7r; Mon, 22 Sep 2025 14:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc4-00050a-GG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:13 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbv-0004EX-TK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:12 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33292adb180so745470a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567001; x=1759171801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4QHixNLRruVL1+s5ZPspsPklSaQIRNXFJF3fprFyCk=;
 b=Xw0f45DBGNtRZ2uo4rb6ADF96MxGT82lUFzNY1snsXnGMfCwWAnGcHvL4lUwBEDXEu
 0TDF0+YKAYAXMKzRU6jZTpFjwg7+HVVFfPqf2HLfOrWs2UYPryGxqWKVTCEzuAyZnXKM
 4RGCTxsaHEG2qAIruuWIGow/60jUiHHfkKGtiu46a1L66+f9HSJfQinscKCDFCcaigLJ
 JaMW9YdUKBOeOfh0dhmqHm5FucmPKr79Y4+uCwtHDiInALLBamZ+Kq0Xr1mwvywH8xHy
 m4iueeEWE21x/TiZx9hIy9tkorOGxaTEF9LehCiqmAz+q7QRf3UT6pZZzbLjQTj/V92I
 n30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567001; x=1759171801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4QHixNLRruVL1+s5ZPspsPklSaQIRNXFJF3fprFyCk=;
 b=Hi3FKtkG0KpVSBFp1H3vLmT3AvZDNHcbZA8Mj8L0DPK3sqfLGqgM5RhrgTKlC+vqP2
 sI4ta4PllN6Q1/UlPsoSrXyHsyXhZZBpKga9XFD7bIoa7Bk6VHsC2NiyHg/k2fteHkRE
 Q6oBHcFFIh2OvtSjSVnSG3DJ0eHhjDmzJrb+H7ytCu+LRRQXEP+cRNgpTuzVGSX9yNdV
 GclKe7mj73arrIFkhnRyyhu62pDU91hEVgLLzOjGGp/Mao8i9dXtTyw6OKqqfalFcHF4
 SWBFGms1DTsW3Ef3ufPCS1cYWkHwp1wqyFBRT6D7tyIoYYHMHKXwRIfrVACMtk1FkHzl
 KigQ==
X-Gm-Message-State: AOJu0YwMTaZtiVgBaQY9hkhDX0SiVF4mU5eLnznjg96foki6PWmzqqYP
 rUbFSpeMoChrzJUErPXqXfvzZtCEpVmrjtMMCgY0/mnXT1LHbEbH2xkeSaAju/cWhhMp1Hu4VEX
 lU3eW
X-Gm-Gg: ASbGncvIRzFilUDYXa2G66N2ceZoQCx51VG+RWThHt7bT37fbzxIQF3reilNrRTQs6Q
 p/qp86jX+U+3OBMdxibE3nZADjV9nY++qb2V7y1Zuvg4ZMFgwbwI/jOqCvmYNeuL6ZDdcaGXSPl
 2QTKCQH64njbnO0MgXQU9wng/nSIssoaPhUaSVZTn864xKkCBcDOZyMG53KmEhfcD4OY/OByk7m
 t1JpdapE2wXrb38sqBgasYcDXIw/aW7zl3LxvlUSCGAIcDQq8+JMRMD4pHAqRZJY8Kn8sq3EDyj
 N8KLlC2InwDpCJ71sreYdVsRJSOFvItsJGen1x2JOutTbmrTAuKAKYzkRl0Qbuwn6PgtrbtqvGg
 uye0mObK2SPtDd3OZyoAxSbrBAhvHHygunLT9XMlJcX8SE2u3g1VsH5A9nQ==
X-Google-Smtp-Source: AGHT+IG4cQu/DuBITF8RlmuqqjZeGZOYNYazEgIbDfLyUFXvZQ1JZI+aNpoF28G95YzTRU66Fz1VdA==
X-Received: by 2002:a17:90b:28cc:b0:32d:a0f7:fa19 with SMTP id
 98e67ed59e1d1-330983417e1mr18170817a91.17.1758567000342; 
 Mon, 22 Sep 2025 11:50:00 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 27/76] target/arm: Convert regime_is_user from switch to
 table
Date: Mon, 22 Sep 2025 11:48:35 -0700
Message-ID: <20250922184924.2754205-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 17 -----------------
 target/arm/mmuidx-internal.h | 12 ++++++++++++
 target/arm/mmuidx.c          |  6 ++++--
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ad5584eb0b..afdc5a92ae 100644
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


