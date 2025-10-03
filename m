Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4976CCA472
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jI3-0002C9-0T; Fri, 03 Oct 2025 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHy-00027y-0i
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGh-0006Hr-UB
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2698e4795ebso23798945ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511300; x=1760116100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSTMFZ3bSv7ykqKeMgQXNsnQ4mB7pENj/novtEHzNcs=;
 b=cX/c5rhyEZsPvUX/9Zgkb6OZRudIp8cM69Q2WKNhg0LL8YHW8AmiKshk+e2YDB285z
 VAEj42h9hkc62EdZCIONPO0frrExWXriGoSZyXEx8LNFFPOI7elsAKqsGoSDCzvkl2Pu
 hVvxzBFeldWKxB4e/fhED3fM2AQHutIwZxDHPp3dQQJKihIyZ+kPmB+pzQIZuG2GiG4I
 Wz0lkkXyWXYzLcTy3Y9wCmiEnBQuUgO7X4CaAcqYfppm4JjToE7l/HRnqphgh95Yvxsg
 kdAGDJoVyE+sfa8EU672h4C7E68wHej16lRuJ0de51wS/wchtr+VmERLL0QazPbDCbCi
 6hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511300; x=1760116100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSTMFZ3bSv7ykqKeMgQXNsnQ4mB7pENj/novtEHzNcs=;
 b=S+Htm+qase1GKRJhhqkkzaEC8h/c7TjE/U06sKLsII0sbmtsknXeGaIh2GeKMOAs/5
 8OQHl0mkc/6A77JXZIAUrJlRbq9dDPgILLqYE1oyoi7cmeBZ7M7IaATj7NgHwuFG5doY
 e3Fehfud8k/LbSC0Z9pdEgT76bjYJ8XiKWvtuy31HEY8LiEjgFNsb/j+HS660lRJytfp
 RTOiIZLlB50AybNuNHCs59rjrR9jnYTXajHtKXkXPrUA2YRHJS+y+lOgt+/wrB1gHzQo
 w72FK/UXEXdwVn5WrZsLiAA3h4aoQhK1zWPUrM/HA6j1bINSyKCY9OFJUXnYOqIk2Zjt
 9gMg==
X-Gm-Message-State: AOJu0Yx/FUA+pLmpPLJyaNOs+DCDdyDXntdjtLoQvvLEqdEIMUeYB1h6
 xqHHlJfi995DrD+wJZ+smn46mIiBOx6d4Vzn2v4hibr914uIkinAkiO0O6YCBjsKo6QZ3fNa+pY
 f+O5fVA4=
X-Gm-Gg: ASbGncvfxc4fXWFJ74BTLxxh8tHHQsTci+K+3z0VuClo5WBENJmmrjGya+4plT4NeU6
 2xF+bJoBceasATWKA7MZeNIYwhbI6Dy7RnpuYx5TpkGD5smwlZbDyWroFQXzNO7ccM+dkZuOpow
 WWyewX7shnVqJOvQpufG3BVYYxABIO7Wj2vp+z1Hq1lUkfCxS1gdzmb64quP0RxciQhEwkf/WOp
 FSPLaHaPV49+TWeNglu7UUi1kDEVevgmCACc6VGJ7qwJP0ArdtJpdhuZ3+nFdXI3rYAV0G6DOgt
 cByPiczx0PYtxMutChCKRMAsaTvVP15MP7dAGv74ptgjHTCVEUGUlkmjXOvjdcNrJCnI/h4fU+I
 Lw6PGjf3MDNy7jx82Fhfnan3IIiPx7N76mhOibqc5NSBwPKDe8OtltUAY
X-Google-Smtp-Source: AGHT+IHqKAuGrT1udzEOzeHkOYUCwGdJjqCpUIWTvuE2RMSWvlvFS4MPoZLhoQj5reEW6NZ1UPKh4Q==
X-Received: by 2002:a17:903:3c25:b0:268:db2:b78f with SMTP id
 d9443c01a7336-28e9a6bd375mr41677055ad.44.1759511300059; 
 Fri, 03 Oct 2025 10:08:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 20/73] target/arm: Convert regime_has_2_ranges from switch
 to table
Date: Fri,  3 Oct 2025 10:07:07 -0700
Message-ID: <20251003170800.997167-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/arm/internals.h       | 28 ----------------------------
 target/arm/mmuidx-internal.h | 17 +++++++++++++++++
 target/arm/mmuidx.c          | 19 ++++++++++---------
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 319c39a4ac..061472a943 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,34 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-/*
- * Return true if this address translation regime has two ranges.
- * Note that this will not return the correct answer for AArch32
- * Secure PL1&0 (i.e. mmu indexes E3, E30_0, E30_3_PAN), but it is
- * never called from a context where EL3 can be AArch32. (The
- * correct return value for ARMMMUIdx_E3 would be different for
- * that case, so we can't just make the function return the
- * correct value anyway; we would need an extra "bool e3_is_aarch32"
- * argument which all the current callsites would pass as 'false'.)
- */
-static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index d8d64a14d6..f03a2ab94c 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -15,6 +15,7 @@ FIELD(MMUIDXINFO, EL, 0, 2)
 FIELD(MMUIDXINFO, ELVALID, 2, 1)
 FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
+FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -39,4 +40,20 @@ static inline uint32_t regime_el(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, REL);
 }
 
+/*
+ * Return true if this address translation regime has two ranges.
+ * Note that this will not return the correct answer for AArch32
+ * Secure PL1&0 (i.e. mmu indexes E3, E30_0, E30_3_PAN), but it is
+ * never called from a context where EL3 can be AArch32. (The
+ * correct return value for ARMMMUIdx_E3 would be different for
+ * that case, so we can't just make the function return the
+ * correct value anyway; we would need an extra "bool e3_is_aarch32"
+ * argument which all the current callsites would pass as 'false'.)
+ */
+static inline bool regime_has_2_ranges(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, 2RANGES);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 6dfefa56c2..f880d21606 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -9,18 +9,19 @@
 
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
+#define R2     R_MMUIDXINFO_2RANGES_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
-    [ARMMMUIdx_E10_0]           = EL(0) | REL(1),
-    [ARMMMUIdx_E10_1]           = EL(1) | REL(1),
-    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1),
+    [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
+    [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2,
 
-    [ARMMMUIdx_E20_0]           = EL(0) | REL(2),
-    [ARMMMUIdx_E20_2]           = EL(2) | REL(2),
-    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2),
+    [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
+    [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2,
 
     [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
@@ -31,9 +32,9 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
-    [ARMMMUIdx_Stage1_E0]       = REL(1),
-    [ARMMMUIdx_Stage1_E1]       = REL(1),
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1),
+    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2,
 
     /*
      * M-profile.
-- 
2.43.0


