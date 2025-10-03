Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jI5-0002Gd-5y; Fri, 03 Oct 2025 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHu-000264-Dn
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:46 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGg-0006Ij-OR
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b5565f0488bso1615392a12.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511304; x=1760116104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0p1hanRYc7NHYEvNwoMomn9iSUP620JiV2mzUBtwmTE=;
 b=mpzz7QA/1DsQhESFujen1Ua7URx+zC/2NOic7o+4nXWVoFB5SeAZjttMbsy2zcbiHz
 T/srLiFqOWo+g3r/dIzOrjxiZve/dZe45HWYhsppaKrU/fOBYDFyCGbyXxpkgkpf9KmC
 lwbrcQ0CX0cieawhih6m1chYmUMSdgSh78qFuTyZv0+RTHO3azJgksl5otP0oHCI5MIP
 EuG4ziknd5H6EmnUkqpf4mFusHgP3gCSZOV3ozL867d7Gs2Xg1CQXaJH/KNK39pxFHxO
 CGg7NHEVUIdKkU8datMp/7EjAyrzFRfpKvrUfTEsrWYmwrcc9ZNmk1HSFMU1+tMacZDI
 7Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511304; x=1760116104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0p1hanRYc7NHYEvNwoMomn9iSUP620JiV2mzUBtwmTE=;
 b=QXyU59fZmbHF9S+x5kHVZCdhIuDnVBQzCVjldyZ2/IWd/GPHd64a88yR8S9t1aUgL4
 713t4CYEg8hkFKlr8kFWwsSbsT6x/4G7mbpWOM4TGrp4WZWccM2+xBqmQBohZetB9Qen
 bqukhjNXMks5UCS6q5VMc2lam8atdZV4MSsie7eNogKNp5qUdoNJLgpr81UF4mS7yd5C
 AXqEEY/DdXyLVqf3H14CZvnObgugELisP+iYBu4vtNhzqz5XJoFGwwrhU5jriyAsQM71
 ZeeijkE6U8ll1IGO/garJncvVKViuJm03PwGsfXZbGV40/P2FWmltd4jNt6dypxu2ypw
 9OVg==
X-Gm-Message-State: AOJu0YyJxi7/CeRshkdwJEwWT8xnmbGs8fTr7uPy/ZaCE5+jFdNa+Wex
 C9/MFL1dfVJUperPPL+JbJyd8PSSTy9U0NCKZDAYDj3xvbrJdgVZs+Cd1DRIMSPZ7JWKcFg6ivk
 w4Ze3AK0=
X-Gm-Gg: ASbGnct7D8+tCCsJUANMLmqVtAVWckVuyEDzualTydeKp1/fTTbMQMriU629PzkSZ+S
 MlVqxB2QAtK1ZQWknUAoxZS3T5JLac3KZJWrSo2fV2kCOzTP3CYI2NwTAyWkAVXAUg2/jQgmcyZ
 0ow06Lmg5wceYiAZDLoxNPBZqG/PBe3GN3QWYDYq5Sh65BZ7q0jp3I/67Wi6tndydmTh7w0mltO
 0u7Z/UAuZLOtQ4MLzMc9JnS0Rnzxu8WFxaeyh/oX4pOyLbtyBPGWTj01U8GBtP54kz/lwF8gmeG
 JNRzFavs0XjHZQE/ubwIwsovrM5oWIreci0Uo69sMIaZ4vfbm2PqvGV/HgNsHffLiBHXPcUujSU
 QXBTdbOgEyITg+dSn4WSiF+z/jgWwrjeG6i+Mf/umFV4r7H37U1zlekqv
X-Google-Smtp-Source: AGHT+IFY4YvdZSwhjTlDB1c1N7dQcNVfFPp3EtK4vqK/hV/OCZ3fJ2SzuTklfSHAG4U5TxO6Cl2FWA==
X-Received: by 2002:a17:902:f609:b0:25f:fe5f:c927 with SMTP id
 d9443c01a7336-28e9a61a7a1mr43482985ad.31.1759511304280; 
 Fri, 03 Oct 2025 10:08:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 25/73] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Fri,  3 Oct 2025 10:07:12 -0700
Message-ID: <20251003170800.997167-26-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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


