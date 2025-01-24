Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B300C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYq-00055P-Em; Fri, 24 Jan 2025 11:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYV-0003zD-L5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:16 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYT-0005YR-MB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:15 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so2349381f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736152; x=1738340952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hR3/G2BdnpgL0DkgE9KDbKtJdTUbStqQyabHgGIFImE=;
 b=BqawQewJmdoUjvBTmDvtAcP7m+0MOpg0+JmaDt7gkO0F6NggdJlf6ylyS63+/0p73s
 Y5MHsj6k5TrSPG6xl/NdSpLeVTu50DdmD7Mj2LbYl9Nf/RGNWZYXgMxtA1471HFPjryQ
 Rz+yJ0EDSn6wcSZfYb/4o3sV2bYLoE61JIogx3kFO+sVwzLm6+mmZ9zSTNhidF9pq1i4
 c6eJTOFy3qw3tRq64XLe908hAgHTSozo9tfBNovl6gu5W6CMM2pjdJOmyLqS6GyWag6g
 byja2lGqUNHpS2uE5iyKUYss/koA6wFUSYJolDueVqg6QF42ZOLgvlWU3xklLiPztVIS
 GW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736152; x=1738340952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hR3/G2BdnpgL0DkgE9KDbKtJdTUbStqQyabHgGIFImE=;
 b=SCQqvwGwzOtkmuPm6DB+pglueSeDlF1SROGtdjsFsV95j7Zlp8gjdzvyJ5Juu6Grho
 2YwyAH5ztr1DzpG9cxPuyez3hkSlSJh0NMASop/8FlhaWOT8u/L3ZRDwAFpxLMgBg7AF
 /SFin06Dpelvkmb4gIVN97zUhhRvYn7aI3AywCVHgysNDFoO3Hwhrg/VzK/2EqoSfD5+
 DuEVU0t1nf8iNm7Wm5HzOvUDrp0DFAsP8ANW/uacoBgxHbnwV6ERtYzDjKdNTof8qKqi
 N0URO8bvR2hNVJITPT8tBhg8vZOTDKj1YhD25ADvOVthZuU8mtFXla2CEd6SSTJ7OPHP
 znYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlG7cHT/gcIpNEH2BHmEji7xXOoTy/YYZYEtcXY+Jsyc5t6jxiIjEm8tNOW6+zjEzgdfEzjQQkBJIU@nongnu.org
X-Gm-Message-State: AOJu0Yxf2SV3zS3nJCcb8jtbjK6eHiwKOGb5oVlYBDraVjPFN/A/Mel4
 hKU36tkR//EBp48AQGgSAfDstp6Kv/1qEng+B4bVxYRf8Lb1jWGoI98cqZ6Wf3zU2CO35oQK3ka
 O
X-Gm-Gg: ASbGncvqrXdzGQs4IUp62SKhryxYrwKVZoBxwHHQFh6M3h0KcxBgnvVQ/EjcAwcKH0n
 76Tj9lkXFIKCgAIKTLS1U8/Akb/0EbpsFv6KF4RqneJciKWTdU0lHf6LbbvRyfVZrODzcnDF9F8
 UIXPqyUUvVp7bqVreoCnAe7R3awa0cZUbQOujv7kQzR+61dfiE1HDK2e8hWujR4X4F6sPd8n5qe
 wQsF/5pqoj9mQiMjlrWXafzm61aR0rWkU6pbPWAJA6Xk/TeKPIyETP8BjdhmhrvIgVXk1rme3jc
 fcfWkA1oNmI=
X-Google-Smtp-Source: AGHT+IEi7EsarqB86fa3x3R1mNHWNH2b6yjG+vtgJL65/zdiQ7g6jyJ4UpBor+r6oabWUKibFjH0WA==
X-Received: by 2002:a05:6000:2a3:b0:38a:906e:16d0 with SMTP id
 ffacd0b85a97d-38c2b7c17bbmr4053814f8f.21.1737736152082; 
 Fri, 24 Jan 2025 08:29:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 27/76] target/arm: Define FPCR AH, FIZ, NEP bits
Date: Fri, 24 Jan 2025 16:27:47 +0000
Message-Id: <20250124162836.2332150-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


