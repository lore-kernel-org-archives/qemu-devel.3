Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FA0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBF-00051X-BO; Wed, 08 Oct 2025 17:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAJ-0004Nm-Tk
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9D-0006iA-1m
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2698d47e776so2192655ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960591; x=1760565391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0p1hanRYc7NHYEvNwoMomn9iSUP620JiV2mzUBtwmTE=;
 b=IlBygRYMSzb03axvVSukFYu40XqLsp7/0d2zLePxRmPkVQHV0YQ13vx1QATOM/QnDK
 4f88c2bydr/OIyoMqvqCBnfZxLDHK8FdEeZdvPyKvJX3/MDovcv8ohSRNh8pjahhKXDH
 iEaI6cD+epJGWvdt2/J5KGm8biPbSF+FZqq703AtsAwAmCQ21+rn2vM00IS1aplBhEmb
 yMUzbvsaFHAgwhiySF4Gv5u85kc5uwj3W1GPhkW6NRXvrPsjEylA0PjpDDVsp/G5CzUP
 3+gQbQrdXO3WqgvM//TI10MKXQIyfyp5+Z9YZcpnaCueDHvG1z/hJu6Iyi2WGOstgdVv
 9zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960591; x=1760565391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0p1hanRYc7NHYEvNwoMomn9iSUP620JiV2mzUBtwmTE=;
 b=uUPIsahJ2j6QoNb2+3jRi2p0vOl6Q9dqEWaxaNE6zfYSThVfjRpLD1ONQYP52mdUIP
 cQFxlZNdQAHqRJdDyAs7lHMbyy6n6xFKu7sC2FDdRXgjxlxF5Ld+XzpJO3ok9FbQA9lg
 ZXJ5SL9RfigIbwpo+6PG5Izd6pnrscAAuJuFrIWtnZ6wZUwcGgHd4NcpDArJIlccEVVU
 yLgqyyjwRYfUqm3dvxtHNBCKpgI0DwT97o1ecHY04AZx1UJ7QdVva3s7hUprX9YDmHsz
 hheZhxv5AfoKgITs+1CxiR9j8CnVTncvtQcFGqwlDyvsfWDcwEooPUUODo/Npg2itYX1
 S99Q==
X-Gm-Message-State: AOJu0YxgBu74TKvg1LvXY/SrhwQiDXjl1e4FWUb2cXfTddjJO2D94yA7
 1w+f9TFszANd6ojdL2PFcZ9tw81BbxMhaKIV1b58uJ92a8u10zEHiVrmOcayMK0+V1Ljp1zg9Xi
 y7U1g0Io=
X-Gm-Gg: ASbGncvDslc/NsADF2fD51U/sW+GDcJgP4ZTT9N6Jv+loagTL0Qy3cIQ/cA/sv0ZLgs
 AO6iUmlImovr0BPI60Z+Mts32zOZV71ibtDxAnEC0JcOEGqKCIdRL4FEhpNB5fRIH21g1VoxpcF
 tbSINNHuyaRUfwsiwxoUrqkwEKSVNKhsoD/D1yKA+dEt26nkfw5YFnsKEIqZKw/vO9Z8WjEYiaa
 yLrE6gtii/yhs/ulDDTSlvpvW432s237gDnjkQlSLPuXszQrP0nNXkoWTol1nIkmKnbYQsAOOT2
 PrSLTStcR00NVf47qlE0CFImREdv8D8xiyJlfBydNHZCwNtpLMEYCRkG1fy2Wr65laUMDxs7cSH
 Q/HpBy1BrmEGK8jfAqBOtMMo7Cl3ubptjN22ap+/SErYfPrH0TyK6i8PU
X-Google-Smtp-Source: AGHT+IFdgi3ixpkizOpFkWQ+9yDJStVBoCH4MhRsh/sHS4Gab3vehLQ10fsGcWMeKuHRb2olFh/iDg==
X-Received: by 2002:a17:903:1107:b0:275:f932:8636 with SMTP id
 d9443c01a7336-29027344a2amr72268775ad.38.1759960590960; 
 Wed, 08 Oct 2025 14:56:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 25/73] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Wed,  8 Oct 2025 14:55:25 -0700
Message-ID: <20251008215613.300150-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 19 -------------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  7 ++++---
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4aef8b50e..92883b6c0e 100644
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


