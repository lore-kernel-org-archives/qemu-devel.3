Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8D4C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLnY-0004gs-3d; Sat, 02 Aug 2025 19:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLm5-0002YY-4k
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:25 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLm3-0005hq-FP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:24 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-741b1fe0d43so15243a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177782; x=1754782582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YP9JcYf4nGEn4oQobQeHHEIsb6i/+ENAm1xO75l8c8=;
 b=hhk0urn+lP0ynU2cFxgA17aRCgAP/TtpUYWaeneu9HL4bz7AgTiVWZ2Pbs0ZaZznL/
 l6xRKr7xK/rSWRNTrNvcxVYKlOTJf4cUq363WQeLXza4x/ZlMpx1lOyfpHfW1G/0YKZD
 4XZVKAQrK1/q2pgupyGIzXQRQ3i8UeidMi6w7IaiaIj1VYXlDfZdyd9Cg6Pevnj1SyQM
 bflpx6B5OapqRrkqlKEA1kCxDIKDkkPgaaAvq/8m87fzgwdjnRZ/em53idmz0RBCWjCQ
 h2zNSguTTIshBZHuOr9u/bUJ3ZYJZzOibv1/DNAIY7l1DbhcODny4eg4RooDetTuS6cX
 iTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177782; x=1754782582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YP9JcYf4nGEn4oQobQeHHEIsb6i/+ENAm1xO75l8c8=;
 b=c6XNuollH/wGign0uuxPZjk3XwU8ikDIvdkRfYMGQ8GwyHd1fVaINmV1uMLsb+B5oj
 eqD735pGDPUJ5y/wIwB2SvPeHimhWpxXSOAKSOGTdRdFrDSPvwM7OBydjsITQej43hah
 myMN7A1asm3zwaCitT9tpk349x7Rbe2ztcWWNVD0op5XMEoNjzt6b/FetR+iikT5iFx4
 UBAQxovDyRSAbqbgK1OHLKvHGaV3+b2EOnwPc1zLFjxXSt7ZY4hd9XyfQmCami3B5oI3
 9KcMqeCgQ5iSp770XGe7XWSLnd8mPps2dI0V49Zd9qnjnw2+Ou0wq8MtBpMKhfVaRaFD
 Ey9A==
X-Gm-Message-State: AOJu0YyQjtYnD1pnO52dxbVc67jvMutgcX624sKUmq1/OewvCeX3AfvH
 z8C8Jc+lcky1oKzAbBuih2QOHG0gLl3SIeHop86Qy4FXOx9+6RR5yVr+uuKjxx6dervHPlWZ4bO
 dAPwcdlA=
X-Gm-Gg: ASbGncvuoeRiC5ABEtYwW0JATorGDMcTZz0mTVdnlx1rVYTB4ObaNyUaUmOPlGw6njh
 v1fissrRXtJ5bvehpCo0CfmGXbcvS+pg8FtmQNK2uRb3PcBmeKXq6JU8yuxjWKOmc9sMZJiypFs
 XYbg8R8NqbZa1LqYUWosjutrt07GcBnBjJA/OhpEa8FLxrVyyC6Txd9tdsg2WEbymYv/drl2/v7
 W/1X7eSHPqAdutKTvENxPsF54mcpN9moOzdNBa5Md/XSQdWB2+d0qqAcO5fwfAHGNmZtnggeSuq
 4WkikGh6XnOLOQkFclXVucMtIGclpRFn8M9cyvS+KZTXOXDwE8AGi+HEjUadqkvIAlWA5U6+3CF
 3xfdDjcIk8MdxuzzkwYEPQJqCmaDMUmMNv+qkjGuwFe0zMJ07GS/a
X-Google-Smtp-Source: AGHT+IEOx2n/IRBEkjcjuum2Xwgas/fTk5h345aZBSxQxrYHWzY3VSZ2PKgawbSawrCbV39En+T9pA==
X-Received: by 2002:a05:6808:5092:b0:40b:3390:397a with SMTP id
 5614622812f47-433f0216500mr2999396b6e.7.1754177782224; 
 Sat, 02 Aug 2025 16:36:22 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:36:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 41/85] target/arm: Convert arm_mmu_idx_is_stage1_of_2 from
 switch to table
Date: Sun,  3 Aug 2025 09:29:09 +1000
Message-ID: <20250802232953.413294-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
 target/arm/internals.h       | 19 -------------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  7 ++++---
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c6f3ae470b..4f99ec69f8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1282,25 +1282,6 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx);
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


