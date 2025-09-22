Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFD7CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lc7-00052h-GB; Mon, 22 Sep 2025 14:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lby-0004xa-9X
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbq-0004C6-GS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f429ea4d5so1018323b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566996; x=1759171796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2qun7bBQurVJmcwvikszJiyDINQVBDa8kuiWrv+8rE=;
 b=syoVAN4+KowWwC1ss2Ffapd8XRohNO+xk3vgR+Mem3lBr2e1Bzrt06qYpXeY0pXP4Q
 C5avmjtL8gqyWEDmR2C10bF5sot3D4kom1fOIzIhAeY5zuSwhnt/lJyfZnNpBnX81odb
 RyL7rgK0CJhmZvlAvp1e9N9jIhtr0rFvzn/mJjdEBg6CILibx6y3v88N9DchqAIGoXlj
 arbpcORF0unqgLhtj09dCjMK0aet5Am1UWoucS34Yk1fZkBgkPlitURIYYoohvcrwORG
 hUh4eQMSHqnSBFZHJbla4+8dAbxGgbGFaCmMmxXU73KaH4x72J/AHWbiRNAuhpMri3hr
 tAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566996; x=1759171796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2qun7bBQurVJmcwvikszJiyDINQVBDa8kuiWrv+8rE=;
 b=c4MydtT8AAxs6HF7UT/XQFO4x8asZtLm5uSprGkwNorCfvEkd8KvwfbKqpatgpe4+r
 nQ0x2q3k3rgkK/rpZZkjMmkbcUeKrGDCKwPgirbj/mMAWD43cdl2/dxft5oxQ0zssEIM
 UX2+I+RTElMgUMXR8pBwKzjP4L6KCybXEtjD/EnScpKuvH3+evi14rEvCum3qsKd2spL
 OmLhaQOhGXXqETqIeQgJu4N8GgXQe355QdovMpo/kranwAfUUDlg/gaUS7AWQ5Zy5OTA
 bbvY/x2EApzZ/a0z/qeHDCv9ZtvpjF+42qlr9UXYDFrAmsvLhOOTp1BYRO2cTeo+RKOo
 yKcA==
X-Gm-Message-State: AOJu0YwmbSG53Oubj0PVi3gNAq1AOmmwT5fvU+H/ZDm98+hJjHqXzmcP
 xMnW6rhxOBdImdtddrWU1/tJnJqI+cTnqC9KDSvi+m09/ZaOSRxV1H+MZIoR1fow7B5e4PyNzzh
 cxiJ/
X-Gm-Gg: ASbGncv200R6QF87hanaFVzGEScNmTYcIv3gqLikpnIQR6kXZUOZOKf8WvSpB4dAZDR
 0Jx5IVLx+KLIbECfCKOIu1zaTsqX/YdNBvt42R3FMNHHzhFStATJsb9DaMcB/eAQqyD4SwztcTB
 yG4+V2p1QJiV3Wq/cvNFdq2e8DYkGhK65rKnZZSbT/GokDm3lLCPCpoomndaFKRJ9QKcP9QGsGE
 iPRpNraYc1TmD/WMKSNa4CEu49UyPv2E+0duy22zOKVrQ31roFWBkokg+o+r4oVFrV3EdRnV51N
 eFVgdzwswRxdFc/w1DYEyNq6s8PfdyQUPE3r4F80nG9L/IrlC/Bki95Wz9rirDrU6DvVakIxQAx
 OlMZo8GYaI0X9XMqJ0cQYxiUDbZid
X-Google-Smtp-Source: AGHT+IHeb06Adqa1vI+d50qulI22ifH9wbWRzWfPbjcpB02mxqM5VIqPc/mosvCFS2LixmrCW+LTMg==
X-Received: by 2002:a05:6a00:1889:b0:776:1482:ef5b with SMTP id
 d2e1a72fcca58-77e4d329cc9mr13506848b3a.10.1758566995687; 
 Mon, 22 Sep 2025 11:49:55 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 22/76] target/arm: Convert regime_el from switch to table
Date: Mon, 22 Sep 2025 11:48:30 -0700
Message-ID: <20250922184924.2754205-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/arm/internals.h       | 35 ----------------------------
 target/arm/mmuidx-internal.h | 13 +++++++++++
 target/arm/mmuidx.c          | 44 +++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 245c60652f..a886282957 100644
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


