Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AA4CCD18F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpl-0006TL-Ji; Fri, 10 Oct 2025 09:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpY-0006Ob-8B
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cou-0003t9-TJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so13082445e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101558; x=1760706358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KxyTOiNMZt6zIm8TmF6tcPi8+k+LcYsPvCM7+rmLozo=;
 b=JxNospwZD4O7tZ2bJ8v4tNjv3M+E99G4FnUY8GQ31fHWbXSGlImeEVhYEa4k54Tt6K
 YbQ1eMTei9xZdHIOdCRWsSrHWYm43x6Dlikuri2ksrMd+/SKivhb3u+HwQ2qvlEyUp8t
 BtxsLD9ep3THTQi2plKjNHkk9CJUr01LI9bx1mOJUEdyoqsFBm/nwz9ESNKk1UtfQnLy
 AAIS+CLEzz2B78V9n7Z5cs8+X2CxT1RKpgT48h9dZ9rL2NCUy9to1m7UKKBgZ79rCxHl
 bmhwkKBRL/oiMy+kiQOvewhxfL/heZ8L9llJnPFzKq+qYGi/0IIOiN68OPvQfR1OgtrG
 Rdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101558; x=1760706358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxyTOiNMZt6zIm8TmF6tcPi8+k+LcYsPvCM7+rmLozo=;
 b=PobP+Qb/69k1hHWFo1L9d4MJF3s0z1e7+M8LrrfK6GaauMZlPhUR/vWbAuNVk4yc+k
 +SUXBAFMCktYjuNbA1RbNoSwVFkMAvmKlRRyZiBHyAbULu1pZTw2/36wCTvbuLCWn6uB
 HaDMoRJPnlb8UfFHalKlomLHXf0r/HCwQW+gQ8oSx4nIkC/imLzgeAHu6nnD5j+U+YE2
 fNHPV/JSylKAoA8ATBqSh9mNwPORMD2tIfOOzHVwtEsrqtF12SurpvWbMe0rj2pG7r3c
 2MlSTR28jNqRh0VWo44HFcL69mkqjCiRnaHtTyLHr3Eb7N8KFmZ2I7tOlCvBJL5CEsM3
 FUjg==
X-Gm-Message-State: AOJu0YyHvCskA1oc/or28CzioiZ+2totzOGjRtcVsX46Bx5hSUSt2jnj
 AJigfMVA1u6ofNVReyAh2n3LYz7xQuCcnQW54ZcDVUx/xgpfhOgaWIqaGpiMF2P+fK+N/qWndZe
 yKBoJ
X-Gm-Gg: ASbGncupTQM+QZElmxEh2aXzNAR7cb5dA0Ai0hfhJYHQIR6NIBuz3hMGtgWpyuvphu9
 zfvt+9owiyTYpLx8hDcGW5H8ryzbOVo3ZEKA0Zy+aC8d6Fu9ORHChxJXjGBA8wYowMNPa/DeLJC
 UQQnbmksYX9n1C6UuuXnaTyXrNxeeXo5uTorY/Fjq3luDxZhfH5wcEtJqnh6SrKOaBO6eea1IKN
 ogqxdjEB+gKBtUyiVvbtpoAWo2bo7kg8TJRalQUzPNgOKklIOTrK2jPhwbUrw4ksOT5Z8K+NiY2
 pEOsEnTgGcL3uDL2SwPHgcGy0d80t/Mf8oI6iGo+27wB3nBmebL1VI8f5WcMkPUte8stHrBurMV
 CLtK1DC57/zZ230/psM+UNl2H2R0DDzUw3i/w2CjK6J2VP7XaEEi4gdnpXgTPSA==
X-Google-Smtp-Source: AGHT+IGKNSKThK07QiSnLYc3drp+4sCrf7JHQxMyDWY5XVPWIyoOvidR/oqIxN9o6VqC/RzioeAulA==
X-Received: by 2002:a05:6000:604:b0:424:2275:63b4 with SMTP id
 ffacd0b85a97d-4266e8e4cd7mr7612745f8f.61.1760101558372; 
 Fri, 10 Oct 2025 06:05:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/76] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Fri, 10 Oct 2025 14:04:36 +0100
Message-ID: <20251010130527.3921602-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 19 -------------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  7 ++++---
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4aef8b50e5..92883b6c0e4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1285,25 +1285,6 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx);
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
index 3e51c0f5790..55fba4aae26 100644
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
index 1c1e062bfef..c5b43a59327 100644
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


