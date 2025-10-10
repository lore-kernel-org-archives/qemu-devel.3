Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBDACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpQ-0006NM-5L; Fri, 10 Oct 2025 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpN-0006MK-5S
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cop-0003rh-Aj
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso1839137f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101552; x=1760706352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Q885zFVInnnyenmxn7nFwJp4DJDPyybiDmu6p+wpaY=;
 b=MrSnwClTgTEJiCxjxgRvcve/FuafzRTuaYfasqCVSMpIPXxk4JsjrHQMBRCvaXUDN9
 SeMOh4CCdIlPiIoVtmL0WfRKoJ6YkTMZxYisAS8KQOO5ei6quIdHFWSJALNMNXyycOw1
 4suXC2uHZw6Ohi1yEPHuLckjlNU+9pA5opA1tbRHohus2eaCBCZNoHNT2+UqzCQjf3EI
 qbhl2MDmD/WRhPCZuO0gP1oM4ZBQUuLLDFfPwWvu+g+jpDqxpAD5qztE3H2MaYwfqLzH
 m0pCZBIA6C8mFLpbCCkZRakBstWMtb/cjOEoTGGtYlR/MRbbkMDRJ291zIas9v3UUeBT
 q93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101552; x=1760706352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Q885zFVInnnyenmxn7nFwJp4DJDPyybiDmu6p+wpaY=;
 b=Ii5mS42h9sCitW+HE9FMG3YUOAk9lWDHKNzMYr2ZEZNHOJddE26q6DEQvqnGrs+ykL
 cmy4bCK0qdrwrWV6nNPIKWHP0b6POJQppNYs5v+z4jiLx40ul2JUvNtNkUzfrEEb1NEb
 1m8Dqmkz5XvBuf2bWKBcTzqmHRRzKjxBJDDIlio/OCU3aETuaFjpv+Mj8ZN8h7ob+qNe
 //hsidVR6DXmM8DShiWv1joRfB9xtNdfJ8AHlvxBGv0cjAKRzgbcXaiXlz9JpItKHkPs
 FNvzA8yUU4pEloW2xpprlh9ZtjDrWS5EaflSVC6Wp64EPXy6cufahZeS0pLV5YTGR2f3
 VWqg==
X-Gm-Message-State: AOJu0YznQJ4MGWy5UVPQRFTpDQG2NRZbKhPRu9bwWV2pjzQkqDwowW6A
 dkE9f23x1B/60f5y/CYwcZ/u+R/Dxaq+irVLJXldcvLyLS3+v7f/zeXdx1Q4/GfVX4b41OQndA/
 mNm1b
X-Gm-Gg: ASbGncvMnmktFcqXw3K0SS2Ww35OYmSgu/1ah+pCeEX32v30+lORy8nHuq5lZYkPTH5
 OCOi/17F5ETPe36lYIRnTskA++l5gMOBczknUVL9chwDU9WSROt9uYluALa5bt4XxorsacxNHW+
 4WRt6owtOYE+nDEm02eNpyGDfna5srpm+/oWnsWn6zCWdbCjFxIkeSJzTeAeNHi/SSIgsQLbY6f
 zReGeZ6uWXH8nZCdGAXsaL5ZWllveBM4admHxyrr9T22rsFJHCS1FkJQf9X4u/WaHvqEdaN1Ob7
 W3A3MFMlWeYngv5RWP+TeYJ64VM0D8+cYrjqlpR6u8XEsXauZTwrShJEqjufD/68A8L8XnA9En9
 FaEQ++gEa4pnPvzumrPycsqmfa7P6xjkA4oAjSgCOmVwN5X+mT8k=
X-Google-Smtp-Source: AGHT+IFzC4trG+wROLWK0ye2WjrUO3dV8VCaJGDqu8h+DJeJBbtqQe+VhADdOzWn2d2jUcIO41qSVg==
X-Received: by 2002:a05:6000:186c:b0:3ed:e1d8:bd68 with SMTP id
 ffacd0b85a97d-42666ac6107mr6071102f8f.7.1760101552260; 
 Fri, 10 Oct 2025 06:05:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/76] target/arm: Convert regime_el from switch to table
Date: Fri, 10 Oct 2025 14:04:30 +0100
Message-ID: <20251010130527.3921602-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 35 ----------------------------
 target/arm/mmuidx-internal.h | 13 +++++++++++
 target/arm/mmuidx.c          | 44 +++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index bd7ea820674..319c39a4ac5 100644
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
index 29bba4ecb54..d8d64a14d62 100644
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
index 309b1d68df5..6dfefa56c24 100644
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


