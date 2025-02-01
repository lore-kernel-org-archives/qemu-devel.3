Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B68C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGXv-000641-Oz; Sat, 01 Feb 2025 11:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXi-0005zV-9H
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:26 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXg-00013N-Ko
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:26 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862a921123so2087294f8f.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428023; x=1739032823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hR3/G2BdnpgL0DkgE9KDbKtJdTUbStqQyabHgGIFImE=;
 b=PtLUquyS8c7gxRIVFMhzqoxndWkdZrgMXHDa4NWeiAtk4COmbO3eUHhxKyl/F5SMXR
 LfjT1HshlIvQClvbivqaaqrDNAqr7W+Ea2zG4D4cIUdb1aZRtsPo0f+U7//akItVBIY0
 5GZuJ7/hfw4UDD+HfV8Uqm37QYiO+ODdSskJfhmp2jmeICu6OJMFG+BTP2+1Bh6HXcp/
 sc6LhzYjuy0ybYDi/L4DabT/6/gYmwgCTDYNEpwIY9e0hpKJt39jcf3wveCADCJc/i8/
 DyaKB1UeI9h+ZkGF+l7Zfa98ode0Pn3EyroI/9/8aqadKA5QzuPaGj8pb7KVlw/vPI88
 JA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428023; x=1739032823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hR3/G2BdnpgL0DkgE9KDbKtJdTUbStqQyabHgGIFImE=;
 b=VSMohBjQvD8WxV88Iu5n/w8ucmuumEQ1/rovvMxBk42TJB/hBo5Udz4OH+dMiytA0+
 V2JFNR2DGnF1hf3DZJqZ2zuQL0QxGy+hBqmqUKYB1tH7jh3E6I42BWO6juPbcTryReis
 z01RNdcN5NA0IXURjt8I6VQyLV79Yr6Ei9lM+mF9PgTBMFvwjz3Yyv4zGCmrpeJLq3PM
 feXV7an6uA8MyMB7j59rQWau/1ITBeN3K92NwRcQdD7Oid5Rg3asszlo5tneXKwH7GZE
 j4AF4ZJ/UX32GdO0oCJULRUiWv6FsUNVMP2rbu2Mf3Wm7fckM1jRTDW7ndCZ2J3B0Lfu
 rQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXneiM5t26BO3bhKT3P+NWxT8IH5Agu24XnkvmE1U+Y/OOzkqo8aUdZPHoknKpi2Qliya9hmtwD9Gqy@nongnu.org
X-Gm-Message-State: AOJu0YyTdpMsWjaWc7Yb0wFu7VuV31fD/z0OAVgHc08fAQVKH3qEb4Ww
 uQ52dI90I8KtXOvwmwCSk6kzESu1sr0dtl52viHM6yJM7Sloa0iIxA4OEhJrBHM=
X-Gm-Gg: ASbGnctqRtxNyCuZ/HVgpoH6ub2oYTdS8b/w26/PMcWaAHCcsRdGrZblywg7LeAC5Ty
 FmwN8CTpkiGrX5ct1+qvgAiS8aOpthLWDmcnxkat5M1v+79/O+a56ElRR8RpyYdC1WyWmNh4F5p
 2+tOckiuYcF2ni41rilnw4u2bkQCmfc5oGTAkgXbcPgWA+Mi1nkDe9mHDvxcaReaUI0+bE5bz+P
 KMMA16bKiLdkApRgTshaGNY65uYpI13Uoqgqg4FGWeAIpWAfTWbgKQZA4zo8V03p1SCsK7QHEB5
 qcuAIUH9n1cNGvMLd/FZ
X-Google-Smtp-Source: AGHT+IEeEpSGXGPtZpSWFpzKjwPcBGV5RzJkSVx3Dn1GH6+LqWhHDOxljpA4lw59rXq/71tFsx8jxg==
X-Received: by 2002:a05:6000:1788:b0:386:459f:67e0 with SMTP id
 ffacd0b85a97d-38c5194d438mr15108783f8f.21.1738428023064; 
 Sat, 01 Feb 2025 08:40:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/69] target/arm: Define FPCR AH, FIZ, NEP bits
Date: Sat,  1 Feb 2025 16:39:09 +0000
Message-Id: <20250201164012.1660228-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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

The Armv8.7 FEAT_AFP feature defines three new control bits in
the FPCR:
 * FPCR.AH: "alternate floating point mode"; this changes floating
   point behaviour in a variety of ways, including:
    - the sign of a default NaN is 1, not 0
    - if FPCR.FZ is also 1, denormals detected after rounding
      with an unbounded exponent has been applied are flushed to zero
    - FPCR.FZ does not cause denormalized inputs to be flushed to zero
    - miscellaneous other corner-case behaviour changes
 * FPCR.FIZ: flush denormalized numbers to zero on input for
   most instructions
 * FPCR.NEP: makes scalar SIMD operations merge the result with
   higher vector elements in one of the source registers, instead
   of zeroing the higher elements of the destination

This commit defines the new bits in the FPCR, and allows them to be
read or written when FEAT_AFP is implemented.  Actual behaviour
changes will be implemented in subsequent commits.

Note that these are the first FPCR bits which don't appear in the
AArch32 FPSCR view of the register, and which share bit positions
with FPSR bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  3 +++
 target/arm/vfp_helper.c   | 11 ++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 30302d6c5b4..7bf24c506b3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -802,6 +802,11 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, HCX) != 0;
 }
 
+static inline bool isar_feature_aa64_afp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, AFP) != 0;
+}
+
 static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2213c277348..7ba227ac4c5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1713,6 +1713,9 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
  */
 
 /* FPCR bits */
+#define FPCR_FIZ    (1 << 0)    /* Flush Inputs to Zero (FEAT_AFP) */
+#define FPCR_AH     (1 << 1)    /* Alternate Handling (FEAT_AFP) */
+#define FPCR_NEP    (1 << 2)    /* SIMD scalar ops preserve elts (FEAT_AFP) */
 #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
 #define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
 #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 3c8f3e65887..8c79ab4fc8a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -242,6 +242,9 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
     if (!cpu_isar_feature(any_fp16, cpu)) {
         val &= ~FPCR_FZ16;
     }
+    if (!cpu_isar_feature(aa64_afp, cpu)) {
+        val &= ~(FPCR_FIZ | FPCR_AH | FPCR_NEP);
+    }
 
     if (!cpu_isar_feature(aa64_ebf16, cpu)) {
         val &= ~FPCR_EBF;
@@ -271,12 +274,14 @@ static void vfp_set_fpcr_masked(CPUARMState *env, uint32_t val, uint32_t mask)
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode, EBF
-     * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
+     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode, EBF, FZ16,
+     * FIZ, AH, and NEP.
+     * Len, Stride and LTPSIZE we just handled. Store those bits
      * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
      * bits.
      */
-    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16 | FPCR_EBF;
+    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16 |
+        FPCR_EBF | FPCR_FIZ | FPCR_AH | FPCR_NEP;
     env->vfp.fpcr &= ~mask;
     env->vfp.fpcr |= val;
 }
-- 
2.34.1


