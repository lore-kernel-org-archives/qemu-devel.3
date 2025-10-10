Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106CCCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpa-0006OJ-2C; Fri, 10 Oct 2025 09:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpO-0006NA-T3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cos-0003s5-O1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1829276f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101553; x=1760706353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6Fr4akqg+k/eUh/idaiUuxsZEJtFwaOFQyKEOHQeJw=;
 b=Fsq0anltnrqRia0UFpJLDL/WOBNbpDVWGGyDToWc8pEEEX/kLECB+w2cnInoZJL263
 o4q/eAV9ydyMHcXaEfbiI0SHst5PTsGaGBL7ZlSK9mhAoJTmK/QuYJitfagk7u9ugilp
 E81OK0zYG7VgkBy8lsPRiEb2ZVDdA4EoBNta+9Iff/sArnF5mr74irMy63XELctPiUCg
 jCkfnbVdBdNIwXrKlClJV3aRCDPvf0xQzhmp4FqIDkW9wY7mEQ8WOCO/j8tXkFA4kk/P
 c+GtdyPT7LVukFpfYJmfxwZF6zOdNBfbsI2eNZ0Vqg/F9+K6fknia91+AAzZlNzz2Z9k
 AFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101553; x=1760706353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6Fr4akqg+k/eUh/idaiUuxsZEJtFwaOFQyKEOHQeJw=;
 b=vrP+xDNH6ewBL3HZkWxNYi6i7DbGcApV8uvG7pF0oweAwuxkK/n1qAglp9twq23OAf
 ijvgX0uvdL7kOiwg5W89pAJ77ZYtYfXjwaHCLT+5r2sl1JKVlbEkISvAe2BIKxjzn962
 6eUKjMQ84/6Mt92bfEBcx2RgsOwosqciNyjlPtdqu2D90WCiFFufYwvUlPFTokqWlzWu
 MLfMx8hIV4d6GnrCzt7Z9CVFKr+REMDjanyAhnxQJbqZJP7DqPhdMF6aBn3QCZGByF2u
 6GMAiM2I/CEPRm4FdI9zuhzKkGzYuESv5xjEg5DGlTz6vQs9axQ1Aije9qSBD7W59S3F
 d9jA==
X-Gm-Message-State: AOJu0Yzt0mVETX7rc+7wOl5MSiUxQHVnrm96ooYcr3BQtUmSezKCqG54
 hsiSto2/SoeA/lO7vSbSbH47qfQG1H+OMshGVRTQf9O6wU3UGHvbv2w1SZrzEkuyXWFdzPPIomd
 f5uhB
X-Gm-Gg: ASbGnctYWQH8UCk3bjSKkxpKXT5ImuxbMmk0ljcEbsnrLaAdwZV3mGwF+vvvjonUdJk
 wkoL3vdZbwRi5aEVjxUOfrk/n23o/QIRjdoDUyTc1cy7RPlE666Piyoo12+Sv5k+Z4VCrWYA314
 s4JiWxsAnwbowbNGHy5v4U8KDJ2DBQhPN3HdGB5NK7vzhL3cu/7YUGh98gKgqURu4IhTHrdFjVt
 t8Bw2i4PHpbaycOQ1z1ZoNO49IVOjNmsT5zX0boQXLKIXCqz6WOLEiKrW3vlkK9JK+DELgMYwkt
 ZekTS5Jr0rzt20CwD+7LVrhvX4mPz5qY3Q37AZGrAZBxMmO5pX1o3R79ejAcMKK3mzlDHaWue98
 sLlla6JCOOkapNjQvHUIWZzv+eRgXWnequN5LNX0g83I7O2rI3HvTwXdRqKPUVA==
X-Google-Smtp-Source: AGHT+IGz0QL0CqOlgO6f1QerLgtPcZUXgurDrAwFFrYcVBIJE3TAoYvxvSG+qkVLMq7DgfmDIl5aYQ==
X-Received: by 2002:a05:6000:4284:b0:426:d30a:88b0 with SMTP id
 ffacd0b85a97d-426d30a8fc8mr743380f8f.22.1760101553334; 
 Fri, 10 Oct 2025 06:05:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/76] target/arm: Convert regime_has_2_ranges from switch to
 table
Date: Fri, 10 Oct 2025 14:04:31 +0100
Message-ID: <20251010130527.3921602-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-id: 20251008215613.300150-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h       | 28 ----------------------------
 target/arm/mmuidx-internal.h | 17 +++++++++++++++++
 target/arm/mmuidx.c          | 19 ++++++++++---------
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 319c39a4ac5..061472a9439 100644
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
index d8d64a14d62..f03a2ab94c2 100644
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
index 6dfefa56c24..f880d216067 100644
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


