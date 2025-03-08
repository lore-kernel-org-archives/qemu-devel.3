Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FABCC28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38y-0004qP-LO; Sat, 08 Mar 2025 17:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38T-0004a3-R0
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38S-0005MA-6q
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2243803b776so34770855ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474751; x=1742079551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdNSdlVsW8pmir+q1TpDvW924tsDK1wZFdH64G2NXCE=;
 b=d4S+ySGd0IIZNnvc5XiO2CZby5ZRfyJUDM59XkVXDJcFDG54Q1XyBukfdYfkE1RfUO
 NJyVicBw4bi1Kl6J2gvNAgjEZtl+1RNpzbDM1pDvNMNLEkmOHLHfPJfpDk8mc9UAwRs6
 0SwxFGbFhFX7BTFllSt9XpRCfHvyUsjzwDrVOPTrRzglnGCXcXrtMow+8UT0PHDTubuJ
 J0xBRea9+A0KGykE8j5K+D09VF/TBxrwKofBCK86j19cPgSBi3bI5xUHFC7mSr/K7CqU
 ATOX0z4Jx3u3RRklX/W1/fB1stJkyF/lsLk8b3HK62w9UvtOtJVIuL02CJ2dG3TAGycJ
 BFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474751; x=1742079551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdNSdlVsW8pmir+q1TpDvW924tsDK1wZFdH64G2NXCE=;
 b=tCDZd3/NFysQDvC0xnOSZlPIAyvrO/4jm9AteMqmnQrys4aZ/MQ7xwktZuTEVAMH5i
 5uUsxsAW2EBp0CX5pUi9tmoDt8EfjaI9SKlvjoB9eanxZKcPQBqjGkYQK+CoiMPb92qO
 F1AVt92CsrIcqJyye+vDkg6ah8XqOiRP7k6MnElN9ZlfQvmLpVOQCTEuXBqD/ku0EIPG
 QOP7yFMhBX8i4lY+XvdCqCT4LKnTMEpDEbpkYZfCwb7snY/X1wmvbtfp0LjRh7KrGlRn
 AFfsUZJ75jaaV6lSQZQmDcrmmQOUmSVatxeBNwwPFDLLdMly+m7aK355yLn5kuZ+ffru
 8jNQ==
X-Gm-Message-State: AOJu0YzS7CSFPWiINOxjtFNlxypkPXej7P0tAuNal2iTq1VXDXPntjW7
 TobbtMy5gAoso7VUDKMGJuktCZZLfNyjKI4BHuEg31gP8qE71X+C5JmyaPlK5gQsdg2xqlCFSgP
 i
X-Gm-Gg: ASbGncuJdVJ2U9OJ7pClYdn9Qqi6fTi88waDZW0rzxmKufgt0Nnv/XmGyygo3W3zxMy
 +TkD0uKCTg8wWf3FezIT8gIfSKMqN0uPSqpabljnBny4b2E0zyHlrOciolfYMC9B42XqJ6H5QyR
 VX8pFLH9u1GezM0P1iwMcz/KiVk/DIfQkFP1VrxRvsg/H/qcejhsWdpXRm8Vjzot9kvD0wtsK/9
 f80o1O2/qEbflczrbmFfIvfOrA2Pv6WIeT5Zex4UvQCAigLaXgiYT9KAm+1dOeILq76pD/BWmav
 oUEvbqi1r+a9AWN6gzQ4ys375bTH2rruYmHZdhwzK0EWZuLRXCkOzuOsFYo/Ts2Fgml4MNrOpSH
 x
X-Google-Smtp-Source: AGHT+IHhy4jEVwuJlmpZuyZuoPdNKKBIr6KZn7wc7+YqKBw1r1U/G7vyF8b/EQrKzoGymgN54ytUrg==
X-Received: by 2002:a17:903:1ca:b0:21b:d105:26b8 with SMTP id
 d9443c01a7336-2242887b209mr100900225ad.7.1741474750725; 
 Sat, 08 Mar 2025 14:59:10 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/23] exec: Declare tlb_hit*() in 'exec/cputlb.h'
Date: Sat,  8 Mar 2025 14:58:49 -0800
Message-ID: <20250308225902.1208237-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241114011310.3615-20-philmd@linaro.org>
---
 include/exec/cpu-all.h | 23 -----------------------
 accel/tcg/cputlb.c     | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 9e6724097c..8cd6c00cf8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -179,29 +179,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
-/**
- * tlb_hit_page: return true if page aligned @addr is a hit against the
- * TLB entry @tlb_addr
- *
- * @addr: virtual address to test (must be page aligned)
- * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
- */
-static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
-{
-    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
-}
-
-/**
- * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
- *
- * @addr: virtual address to test (need not be page aligned)
- * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
- */
-static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
-{
-    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
-}
-
 #endif /* !CONFIG_USER_ONLY */
 
 /* Validate correct placement of CPUArchState. */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c8761683a0..fb22048876 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1201,6 +1201,29 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                             prot, mmu_idx, size);
 }
 
+/**
+ * tlb_hit_page: return true if page aligned @addr is a hit against the
+ * TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (must be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
+{
+    return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
+}
+
+/**
+ * tlb_hit: return true if @addr is a hit against the TLB entry @tlb_addr
+ *
+ * @addr: virtual address to test (need not be page aligned)
+ * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
+ */
+static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
+{
+    return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
+}
+
 /*
  * Note: tlb_fill_align() can trigger a resize of the TLB.
  * This means that all of the caller's prior references to the TLB table
-- 
2.43.0


