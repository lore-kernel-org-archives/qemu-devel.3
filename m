Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E390FCEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJI-0001M5-Bp; Wed, 09 Oct 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJH-0001Kz-83
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJE-0007wa-9E
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71df67c67fcso3023880b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486541; x=1729091341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XLhOzO66foHF9LZBZKhFihKXvAHnKRfv3WrPUxhL4d8=;
 b=EivM19r7dvUcMt9yVWOMtAJHb45PVkQ/yUYWUvVHum2MO+B+OPZIEVNziBDUGK0rCE
 se9crc2XkbH85KcqvTpB8lTjRpYGytDy6q2BRI1NOXF0KQkVEilE8rqFJrm7ckzKc40H
 fuQEkeIfN8wgWqzBb1qVxmCBaE51NTv4Jutg4oplDxXjMDb0Mxy5gJgFgoW7sE915/jJ
 lXOOcBgHwfvBoOh6YlX3MxO2NWndrGVR+6VpeVoyY40kTSYaOjLKpFHZQD96Xa7aWAtd
 b2og9eaTnRRMK/B6KWkwvBtVJ2rK+uSTIn/8aH/C5U+Rua3SlSJu2TRZnQBQD9spgNtc
 Pguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486541; x=1729091341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLhOzO66foHF9LZBZKhFihKXvAHnKRfv3WrPUxhL4d8=;
 b=iccnrokBdMf+FlbJj7Fiz59bdpykfllB3DB3RHkuw/ix0kNNy9LxUzvvQNToGBaAN7
 tmHG5KwDP/+tCoJ1mjRhzb/PaSjkr4kbeMBENOgFmihjuURj40mnlnmu5L3qdMRtdZ7N
 nZK24+pMFdT+9AGH6EyrKJglaKneHlgvP4lsFfSbdTu0neF31kQI570MrfARY/6uYT1L
 Z7VSqZILkjfKyYq5iNvp7Mn7TBvR5k9crDmxiSTKk9fRyZPlAAfitTHJ9sKjQHdtFyFO
 eOcCwYFNn57PXdsE9SzGj5w/BHbWA/6Ako7ScGzmTroVM61oRrX/tlG458tKB9QbZdL6
 jSWA==
X-Gm-Message-State: AOJu0YwNnvVhOYXLKqTJTjh1Lym4t+1LsIWnO4/e2cDP0GQ+urZRT7F8
 VaSCMwhj8ACG605IN1feZrftWSS5+myPlmYytqdRtJTuCNaog7zxfqKOb3f2u33nXJVnrqocZJC
 o
X-Google-Smtp-Source: AGHT+IGXvtVa1wxYAWZSwmgpm4UiLLJAnQCtHJ1bTABNK6BkFDyFGXHr2g2zO1ht6bTgtorwAdmT1g==
X-Received: by 2002:a05:6a00:4616:b0:71d:fe5b:5eb9 with SMTP id
 d2e1a72fcca58-71e1db75452mr4558056b3a.10.1728486541448; 
 Wed, 09 Oct 2024 08:09:01 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/23] accel/tcg: Fix flags usage in mmu_lookup1,
 atomic_mmu_lookup
Date: Wed,  9 Oct 2024 08:08:37 -0700
Message-ID: <20241009150855.804605-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The INVALID bit should only be auto-cleared when we have
just called tlb_fill, not along the victim_tlb_hit path.

In atomic_mmu_lookup, rename tlb_addr to flags, as that
is what we're actually carrying around.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6773874f2d..fd8da8586f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1657,7 +1657,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
     CPUTLBEntryFull *full;
-    int flags;
+    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
@@ -1668,8 +1668,14 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
             maybe_resized = true;
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
+            /*
+             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
+             * to force the next access through tlb_fill.  We've just
+             * called tlb_fill, so we know that this entry *is* valid.
+             */
+            flags &= ~TLB_INVALID_MASK;
         }
-        tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
+        tlb_addr = tlb_read_idx(entry, access_type);
     }
 
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
@@ -1819,10 +1825,10 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     MemOp mop = get_memop(oi);
     uintptr_t index;
     CPUTLBEntry *tlbe;
-    vaddr tlb_addr;
     void *hostaddr;
     CPUTLBEntryFull *full;
     bool did_tlb_fill = false;
+    int flags;
 
     tcg_debug_assert(mmu_idx < NB_MMU_MODES);
 
@@ -1833,8 +1839,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     tlbe = tlb_entry(cpu, mmu_idx, addr);
 
     /* Check TLB entry and enforce page permissions.  */
-    tlb_addr = tlb_addr_write(tlbe);
-    if (!tlb_hit(tlb_addr, addr)) {
+    flags = TLB_FLAGS_MASK;
+    if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
@@ -1842,8 +1848,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
             did_tlb_fill = true;
             index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
+            /*
+             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
+             * to force the next access through tlb_fill.  We've just
+             * called tlb_fill, so we know that this entry *is* valid.
+             */
+            flags &= ~TLB_INVALID_MASK;
         }
-        tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
 
     /*
@@ -1879,11 +1890,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         goto stop_the_world;
     }
 
-    /* Collect tlb flags for read. */
-    tlb_addr |= tlbe->addr_read;
+    /* Collect tlb flags for read and write. */
+    flags &= tlbe->addr_read | tlb_addr_write(tlbe);
 
     /* Notice an IO access or a needs-MMU-lookup access */
-    if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
+    if (unlikely(flags & (TLB_MMIO | TLB_DISCARD_WRITE))) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
         goto stop_the_world;
@@ -1892,11 +1903,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
-    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
+    if (unlikely(flags & TLB_NOTDIRTY)) {
         notdirty_write(cpu, addr, size, full, retaddr);
     }
 
-    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
+    if (unlikely(flags & TLB_FORCE_SLOW)) {
         int wp_flags = 0;
 
         if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
-- 
2.43.0


