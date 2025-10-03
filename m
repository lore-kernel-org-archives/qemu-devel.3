Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACE1CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jJl-0004At-J2; Fri, 03 Oct 2025 13:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jIB-0002Ny-2S
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGl-0006IT-9o
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:02 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b58445361e8so3181213a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511303; x=1760116103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufbIAsiBDfbdyvsFouOClRyF47XEv9v24R99qbCOlJw=;
 b=mFMXkZe1obcUCpBaC3NVa7ad/S6MBJ7jc8/bQtGY0eTWk7/ZfhKyCrcdkz+YBMhOI0
 ZPp4jbiVcKcMfTR09uMSyhB1+Dj4KXPu7nXNMO7koN8UGHsM/G0XqGBcJxiT9OJLdk0O
 yii+lwoFHIuMfEgQ7BsBi37ZUMw+DjHNQf5WrttNfay15/BimNmKxoU94RYQ2+srC7wE
 UyEAdUjxR408gm5dkzBlj0PzczakgMSSKX330vxnxPbblx2FCfer2tuEMF83oEdOT65i
 IHY7N4LQ4uByUOxHx30/R2Cl/Bk+aDUyPoLfJQWHtLfzZAhuK26GKNDtdhykPq08/NK3
 Jffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511303; x=1760116103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufbIAsiBDfbdyvsFouOClRyF47XEv9v24R99qbCOlJw=;
 b=G/hzaSVgbxUF45TTAD1wpLPGDO88guXoWaoroxp6ozT9czqwooHUnYGRkNqY0qNc6B
 a+shbvyjuFUeirmwBSQKykDvFNYvJgdYp1Pr2lsCJuF3CjtloUulq+kIeinLPzbZ1IWe
 a/kaWVKCAX45dLPUf5WcH2Ob18bCcDdIFCp4aefxnOy/fM0Z9hN0EwBAGJQ+Ouo6sCyG
 WbjqCupZ1radC48KkRy3A1dfL0C9U/xCU0QNBFB2XMzW30CK8vaEoMDq0LJ6R1FXpiAH
 mIkfSVjKb6vkTe9+ek/WGxLWs7S3zRmw8wyUT4TpHrVTvLqjdntEbVDoiiEXAWJpXUQ3
 RTZw==
X-Gm-Message-State: AOJu0YyTx/krHNfcWXFZp61ghVK0wps3ztLO1gsm9Y/4b8v/pKClhSqz
 elEkciFaAta05bnK+O6rSiU21XgzrbDn1Bd0LZQv1uprLjQeemNFVDE3g8gkDYx0C3GOkBpeq+c
 o2wtPgRE=
X-Gm-Gg: ASbGnctIJtAmG8bJ/XksJL1ZU2gP8GzznzLNfG40NusH04lPwjTbN4NzRIvI1PDWGPA
 h7lhYCenBP5YaeRppdF9Sv8bNKM8GrQ090NEIRJ7osd4G+q5qmsW9AcFsO/j/bhflI4Gh8H+vOG
 wQA30hO/qpaEjlYI7pd7iPSgUDFqv9Nl5q7IMl/ssCDDrEEeBqTA5VZzVakZy8S+fiE0GJRm7V3
 JHGqLYzEjW/Y41fcNHpKCYIJTbEEV2GIn9lfsJ5Gjk8/ucR9m4ePuuZPX9CE5dZOt04/7Uaae0t
 FD3sF0Q8c43T8E7XbH6fMg7Or9cHpO4UUD8nNxLmz0UmShTxG5HICChjr+JoyIL2jff5mX7nVs8
 KCUEd638miYl5Ywy9EBiYf5KxJnJN7Ymvvgf6VmuwFwc1I0S2i7g9ZaA4
X-Google-Smtp-Source: AGHT+IHpurz7hA0kfG1xy7x3YKfQemf9khC0RS6zpUKQYv3fbbxdCPtZyyIAuNHvPrBdYYLvxRKZeQ==
X-Received: by 2002:a17:903:190:b0:271:9b0e:54ca with SMTP id
 d9443c01a7336-28e8d04f303mr106268585ad.13.1759511303313; 
 Fri, 03 Oct 2025 10:08:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 24/73] target/arm: Convert regime_is_user from switch to
 table
Date: Fri,  3 Oct 2025 10:07:11 -0700
Message-ID: <20251003170800.997167-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index d0d976cbb0..c4aef8b50e 100644
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


