Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A21C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVJx-0005fS-22; Thu, 01 May 2025 10:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJv-0005dn-4S
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJt-0005Qa-6u
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227a8cdd241so13920345ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111323; x=1746716123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t1ed0CklYTiiIBRCtnbFvThtHt7Lv/qKME8bcfHr1lI=;
 b=Z72Nvt/G7PCG5zuDRyFGBQAeSQY8+Aa5Be11fktAlTCCKo5amRSg2QLDyuz3kdE5go
 W2gAFdvPy7ex4BUTse74nKW4Kiz7D9CJtJVgFR2ib2FLQGPg7+obEPmNvOQINgY2uujC
 8LgSRa3kGQ73GXzxOYjK3YJmr1JFZzDRsABiru/DTn9ramZ1lZpmZC5E1DdGjGYrCOgs
 lbK56wOzH4cPg689SzgqYtUNfTEpisBzPSNIHPH5z3hONK/0T7231rdXRNxx136s7L9v
 zF75tifvuCKWc5IIaJwOYYvIZwBM0RjTBg+OXra1fNxgtFS4VcsH8LaUtYiSyEWibvUb
 CE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111323; x=1746716123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1ed0CklYTiiIBRCtnbFvThtHt7Lv/qKME8bcfHr1lI=;
 b=gotLjv+XclRsAVG/pah6ZAZ+ZsQmtkBwcpc/UPWlD2qK09qjDVeBvfLIvyD1T2AmP2
 J/jQQalqHOKbMQomM7VAbJM7qSI60BUJaB58RaVcuAou9EfBHXYAupfQp3aqNs/B4W8V
 wgfLhFUlpDoc2Rx25toFsWelAtubc/3gcfcNI0WQur92KqA4HtZsWsdp9V8wzygNy5zF
 RIu0TuCc2J8OoQuIUpPjLgXfeAJvI29PyH8ZAm7Cj9fZsGpNlKiK5gAXkuFwlagBhT+Z
 SXUEupqzaZITvDvvDpz1834ioPqJKAl1zpOKFBZXaaD2ZYjuZaTQc34A1ewQPmh587mq
 xN3g==
X-Gm-Message-State: AOJu0YxRTq3z53cnM1/BsA7kyIswQqE8xVjHsBfRJqzi9DUo7JOutUI7
 ZLT6uTOZg/H5+3Gv+MVaK/Jn5VGdS2ZE5GUmgOerbphTcxD3vyWDnbmKvsBIwP/kS/PpQWAdN8q
 Z
X-Gm-Gg: ASbGnct2aOcisetqcAAidVuvsfd6Fok9mzpDeflBlfQK7OGb+qfFkDRCdWjqzLV8XTt
 /twC1/W3t7PJE+dlRCmmk1WHaDdTzc90TOg47YjmRg24uc+JVfq8r1B2nxZJG6Kgj7aIyGgdQIo
 7H/V5xVuF8xiw/b14qOcrwFDKAHSau/eb8NKzWdQlq3AeVyV7vfMnN1aHLQnYnBkiargaAFiCD5
 yprzAhBFqqnFkzb9NGs+ByylZ/qvW3XVaDQ4bBB3YdcPPIKxPBZtCz3RRLgQG3O0bq2ZlTmegqH
 zUiaMFExmm0DcT1iQ6DwDL9u+pZBRetrWA+oBLeLbUnzp3GhAfWq1gHRM1bOnSVTyy9l/kqbb78
 =
X-Google-Smtp-Source: AGHT+IFAZr1nRLjFRm+Du31v9A0hLanFc7xrzO724XcBCYk1WESkJrZV55HKddAl2TYwC/Emgi1bjA==
X-Received: by 2002:a17:903:22cc:b0:21f:52e:939e with SMTP id
 d9443c01a7336-22e040c7c97mr54534005ad.28.1746111323356; 
 Thu, 01 May 2025 07:55:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] accel/tcg: Use target_long_bits() in cputlb.c
Date: Thu,  1 May 2025 07:55:11 -0700
Message-ID: <20250501145520.2695073-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5b6d6f7975..35c467aace 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/iommu.h"
 #include "accel/tcg/probe.h"
@@ -771,19 +772,19 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 
     assert_cpu_is_self(cpu);
 
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx(cpu, idxmap);
+        return;
+    }
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (len <= TARGET_PAGE_SIZE && bits >= target_long_bits()) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx(cpu, idxmap);
-        return;
-    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
@@ -809,19 +810,19 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     TLBFlushRangeData d, *p;
     CPUState *dst_cpu;
 
+    /* If no page bits are significant, this devolves to tlb_flush. */
+    if (bits < TARGET_PAGE_BITS) {
+        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
+        return;
+    }
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (len <= TARGET_PAGE_SIZE && bits >= target_long_bits()) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
-        return;
-    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
-- 
2.43.0


