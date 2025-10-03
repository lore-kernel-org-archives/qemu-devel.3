Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2C5CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHc-0001vE-T7; Fri, 03 Oct 2025 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHa-0001tV-43
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGa-0006HS-55
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-26e68904f0eso26052925ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511299; x=1760116099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gN3TW4VhQzzFlOW6UC1TsHCE40S2BpskX9OHncDp0PQ=;
 b=ebLfdKdDSS7xEuSoqjVKqKUJU4aJJu0sSfsKF7v6EqUk7oCxoQW61lQ+aWE3iQGjyu
 IR/wF3IFkPvoHi97lGNcj0TCs+D86pzltGbEJugceqE+MMwR9bkRz2wMkmy64wuvDa8j
 SPJJV+G1i6N2isxEWAZL9uPu+euOKRIRsGJSmF7Tgy4cSuNbzopvC+2KDbQui32Rypld
 hy9payU0THPVZ5K9KiaOx3IZusCgD6jTA1RPYlQC628BcTcyzmoDFytmnuZD/rrSuyFP
 SQ61rXCGvKeUXR6m5fMwBoatisP9mKLeLelrnUJYwLsty0OmTdUPXFq5W8ZsPGd5Or1D
 d+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511299; x=1760116099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gN3TW4VhQzzFlOW6UC1TsHCE40S2BpskX9OHncDp0PQ=;
 b=hQMyZG81xvMgI1bjKhVLTJeVIvy+ndh5AAa/cuEARcSBaO+e+uJH9D1TUTO9a2KwEU
 L+5Dh+I5hatv/OU6Tj2CYQtbzVBt/V9/UPKCPuKaEo/QP7f2CKlOLEigIkJBxVigyXVA
 8FfDRo4VTqBsix6bPL1HZUNALuqUy+f3szA60KfJYrnCiqu4G/Majr7KxsjFDXa/QhXc
 cYzAKXQtSXzxYcjiekpVw/fWEV/jGVqCs+oDCCHh7fkAlIf4JeZH7NclZyqEzykBuBmd
 vAzfAl1ViLhrAKa8JIJJQNU90KeT0M7goPMXfLhdzApFFdIuxZ5nfDw/vOmCaKbJ60Jc
 vBKw==
X-Gm-Message-State: AOJu0YwKy3zPHz7yBXZ2vGXcsFMVFLS9OhR5750tDNoY15y4Y736Oik6
 HDLRARp+RIyZL+Y69wTlnJnZXO4rLUQvrKyfJeyYrkQwUDj3OB3SH9OmCAUBNOYRFsr+glzVooL
 72Q121yA=
X-Gm-Gg: ASbGnct+pPkAzM7mbumGnJoJhyGllF0WwbDdKFP7fL9tEAPnSCaKAyhUwpOYXpthxLm
 R1Fezgoops67GiPV4JSy3FGoqEXLGb7iNUBAwG5Ds3qe2DSKrR2oKO6MyCBS5euSgbansQ5ASBD
 dMhjYbyqOZqsg8Gwgqw4ndJFT15h/eD83FPA5ytsBN4rM10TnjIEPqDGQFAcKQ5WjIXb1pGUsgo
 q92s6lJHmLyxEWStm3JGY7rCoP17v91Pka0pMD6pkzc6JqfiQcjberM5CbPGjgdzpMQEfKitPYs
 BKn+oKGlIcCa3+hyxj9IJy3QuOA8+EZVyhUofeG2ZgDYiPBRBz2NHv+gAvcz9+HmyyQliFPOQgG
 0imah4Yi1aox88gjj5SCILBrOz2luYWQM7pY80XqL6dfpRlCghevKp3YD
X-Google-Smtp-Source: AGHT+IHE5HblfYtmEMnxHkWyKa92wu1KiGtGrbAwKXy3vgk7jSLh3tfA0oU4uoBiGEUL9r25yWWFDQ==
X-Received: by 2002:a17:903:33ce:b0:26e:e6ab:66fe with SMTP id
 d9443c01a7336-28e9a543b20mr32128485ad.5.1759511299155; 
 Fri, 03 Oct 2025 10:08:19 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 19/73] target/arm: Convert regime_el from switch to table
Date: Fri,  3 Oct 2025 10:07:06 -0700
Message-ID: <20251003170800.997167-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 35 ----------------------------
 target/arm/mmuidx-internal.h | 13 +++++++++++
 target/arm/mmuidx.c          | 44 +++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index bd7ea82067..319c39a4ac 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1073,41 +1073,6 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-/* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_Stage2_S:
-    case ARMMMUIdx_E2:
-        return 2;
-    case ARMMMUIdx_E3:
-    case ARMMMUIdx_E30_0:
-    case ARMMMUIdx_E30_3_PAN:
-        return 3;
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSPrivNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSUser:
-        return 1;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 29bba4ecb5..d8d64a14d6 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -13,6 +13,8 @@
 
 FIELD(MMUIDXINFO, EL, 0, 2)
 FIELD(MMUIDXINFO, ELVALID, 2, 1)
+FIELD(MMUIDXINFO, REL, 3, 2)
+FIELD(MMUIDXINFO, RELVALID, 5, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -26,4 +28,15 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, EL);
 }
 
+/*
+ * Return the exception level for the address translation regime
+ * associated with this mmu index.
+ */
+static inline uint32_t regime_el(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    tcg_debug_assert(FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, RELVALID));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, REL);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 309b1d68df..6dfefa56c2 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -8,34 +8,42 @@
 
 
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
+#define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
-    [ARMMMUIdx_E10_0]           = EL(0),
-    [ARMMMUIdx_E10_1]           = EL(1),
-    [ARMMMUIdx_E10_1_PAN]       = EL(1),
+    [ARMMMUIdx_E10_0]           = EL(0) | REL(1),
+    [ARMMMUIdx_E10_1]           = EL(1) | REL(1),
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1),
 
-    [ARMMMUIdx_E20_0]           = EL(0),
-    [ARMMMUIdx_E20_2]           = EL(2),
-    [ARMMMUIdx_E20_2_PAN]       = EL(2),
+    [ARMMMUIdx_E20_0]           = EL(0) | REL(2),
+    [ARMMMUIdx_E20_2]           = EL(2) | REL(2),
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2),
 
-    [ARMMMUIdx_E2]              = EL(2),
+    [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
-    [ARMMMUIdx_E3]              = EL(3),
-    [ARMMMUIdx_E30_0]           = EL(0),
-    [ARMMMUIdx_E30_3_PAN]       = EL(3),
+    [ARMMMUIdx_E3]              = EL(3) | REL(3),
+    [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3),
+
+    [ARMMMUIdx_Stage2_S]        = REL(2),
+    [ARMMMUIdx_Stage2]          = REL(2),
+
+    [ARMMMUIdx_Stage1_E0]       = REL(1),
+    [ARMMMUIdx_Stage1_E1]       = REL(1),
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1),
 
     /*
      * M-profile.
      */
-    [ARMMMUIdx_MUser]           = EL(0),
-    [ARMMMUIdx_MPriv]           = EL(1),
-    [ARMMMUIdx_MUserNegPri]     = EL(0),
-    [ARMMMUIdx_MPrivNegPri]     = EL(1),
-    [ARMMMUIdx_MSUser]          = EL(0),
-    [ARMMMUIdx_MSPriv]          = EL(1),
-    [ARMMMUIdx_MSUserNegPri]    = EL(0),
-    [ARMMMUIdx_MSPrivNegPri]    = EL(1),
+    [ARMMMUIdx_MUser]           = EL(0) | REL(1),
+    [ARMMMUIdx_MPriv]           = EL(1) | REL(1),
+    [ARMMMUIdx_MUserNegPri]     = EL(0) | REL(1),
+    [ARMMMUIdx_MPrivNegPri]     = EL(1) | REL(1),
+    [ARMMMUIdx_MSUser]          = EL(0) | REL(1),
+    [ARMMMUIdx_MSPriv]          = EL(1) | REL(1),
+    [ARMMMUIdx_MSUserNegPri]    = EL(0) | REL(1),
+    [ARMMMUIdx_MSPrivNegPri]    = EL(1) | REL(1),
 };
-- 
2.43.0


