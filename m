Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6083CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 19:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v57ri-0002jr-Pd; Sat, 04 Oct 2025 15:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v57rg-0002j3-Ti
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 15:24:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v57re-0001xw-Bm
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 15:24:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so137530b3a.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759605856; x=1760210656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lt9CXeINDO1davLN3ff4kfwC4euBhUKckNctzpEobVQ=;
 b=oBt5MTPldvbXngUe5D7pC9/CjsKZYAIl1k+igAAXX5rM/SGTaAafS5NL0+cfsEvrfW
 1yr/xULYcayA9ACmfRawfpepgutwk47EJ55CVhRdyAakk06wnEWqHjMcAzWzBdkE/5iX
 R/vNnVYb36AFG9nzUspk+tYILgAUs+4dsQU1DJVPzl7rSYMrlGZcjkzl4nyWGao4e1cC
 cQWqdGrKCQWmzC1XY3HXz1SAH4Zl3fD8kMJARnz/WkYQe7FxHjgEnZwceQ9AhQOZwI6e
 HyWjeuZ3QqfuXaQFGq4GWaRCd2hAe7kc1FkRp3R+AXbQ6Reb5ZYygjqZqCDpRok2fjOp
 mjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759605856; x=1760210656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lt9CXeINDO1davLN3ff4kfwC4euBhUKckNctzpEobVQ=;
 b=mpSQ8T011vymCx4NqA5iArqarxOHWEpu37sQy5tH82EyTxy/n8X2TXU+90KDUydgKa
 GejM8hVLLbLb7pcq6Gd8iqLgjYdY40K2OPfPHVzMFCwcSs9FLq8GqBni8ufuzk9x/DA7
 YgksPQ6ZR7G/NPcBv+l3v7jO9f6IbigDGmxwaXE9QLhZ772s3Ksgbv35YBT9vMxNibMd
 oZCM7H9E9RkQnpycnBOo6ZEt4yrCx9xlUpkNDUZvYX/69PimPLlksvxouDJtg4gYYCj9
 kY4EE3CZtfQNOOQoqGmNGsbhNfzWHX2BBHA3IrDyalDMllqv1kP7aVwOy7Q2XvMQkUEq
 6fZQ==
X-Gm-Message-State: AOJu0YwP9uORIgZvuTLk+ArKcILbpP+wEo5oaHeb4GhpcBrj0X9JdNy5
 y308GlkvO3dVlLMrmSU4akcvIXSz8u+W7KsyDH+jijEbT/DRETanq3bHYRpZdDm/LCVbR9NLxjK
 GmftVvng=
X-Gm-Gg: ASbGncsYNVbrsXMSrSpjdW4Zac+tlw1rHji8Fhl+i6a2b+JJ5Zsl0hvpNTo+c2VAgu6
 wM0XrZtw3Tz13T4N18k1+ReXMcehj6i/OZTSa0XBU5n+IMNBNN8zwAEZULDA2r+/WRsyCoSIMtO
 WBbbxnhPB3/3CeKmj9FM5rGaIOUZZwytYSfgjcQ2bP9L9PEOMmwGWjw7tPc2WTXkuedOwbkDw++
 nZxHPqAAnPKXTvGv4m1zHPz7Bx17498e/1gMcDkZkSPM7VN4XoKHTDjcGMDDYYKPMv7QpDtRYO2
 mpyCOYt1nkW3qwNRtJij35rPBBLCKtJn3uqpyrxr1VxSD6EQwlTtpQNJOM4rpmAIxObCXxGTyaH
 /DR60F6vz5pVEurpFidTRfyszxXh4DykCpQ+6Vr5jvjiT+sts22TifUQF
X-Google-Smtp-Source: AGHT+IHxTaqDULHJxiNZHU7KXbFzddvnuI0D+i0Rz70D+pGzwlT8Imz171YBCAntb6L1sq+/HObhWA==
X-Received: by 2002:a05:6a21:33a5:b0:319:b5a9:1601 with SMTP id
 adf61e73a8af0-32b61e6b530mr9343646637.19.1759605855796; 
 Sat, 04 Oct 2025 12:24:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099f3b041sm7878362a12.24.2025.10.04.12.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 12:24:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	qemu-stable@nongnu.org
Subject: [PATCH] accel/tcg: Hoist first page lookup above pointer_wrap
Date: Sat,  4 Oct 2025 12:24:14 -0700
Message-ID: <20251004192414.1404950-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

For strict alignment targets we registered cpu_pointer_wrap_notreached,
but generic code used it before recognizing the alignment exception.
Hoist the first page lookup, so that the alignment exception happens first.

Cc: qemu-stable@nongnu.org
Buglink: https://bugs.debian.org/1112285
Fixes: a4027ed7d4be ("target: Use cpu_pointer_wrap_notreached for strict align targets")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57..a09c2ed857 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1744,6 +1744,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
     bool crosspage;
+    vaddr last;
     int flags;
 
     l->memop = get_memop(oi);
@@ -1753,13 +1754,15 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 
     l->page[0].addr = addr;
     l->page[0].size = memop_size(l->memop);
-    l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
+    l->page[1].addr = 0;
     l->page[1].size = 0;
-    crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
+    /* Lookup and recognize exceptions from the first page. */
+    mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
+
+    last = addr + l->page[0].size - 1;
+    crosspage = (addr ^ last) & TARGET_PAGE_MASK;
     if (likely(!crosspage)) {
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
-
         flags = l->page[0].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
             mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
@@ -1769,18 +1772,18 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         }
     } else {
         /* Finish compute of page crossing. */
-        int size0 = l->page[1].addr - addr;
+        vaddr addr1 = last & TARGET_PAGE_MASK;
+        int size0 = addr1 - addr;
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
-
         l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
-                                                         l->page[1].addr, addr);
+                                                         addr1, addr);
 
         /*
-         * Lookup both pages, recognizing exceptions from either.  If the
-         * second lookup potentially resized, refresh first CPUTLBEntryFull.
+         * Lookup and recognize exceptions from the second page.
+         * If the lookup potentially resized the table, refresh the
+         * first CPUTLBEntryFull pointer.
          */
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
         if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
-- 
2.43.0


