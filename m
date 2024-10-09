Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D23ECF0430
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCS-0004If-8Y; Tue, 08 Oct 2024 20:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCP-0004GM-Gd
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCN-0002g3-5A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20bb610be6aso68588525ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432301; x=1729037101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dFojoXE4+jjskAlQVsQMp2S+E0WFZ4r9iQmpRIn1e0=;
 b=iAL7m1sBK0N70WzMaB1IB1mvtCJpbirxIHr5B/ntk7nUztdpUtX3LD2zALB7pD/08r
 O9i0A1O8nugtY+qW1WKZdviGktCElrf7MJrmLd7N0glKb7ImYrgp9jGkqirbn7jXW5k0
 tFEkAxfGnba0yWfzLMz+8q8zbhKpPIB/JWdnWwCyaM+NCGT6Cjd8S9XukYo5hGv/ZSw8
 2hksjJD+D8YDYuB/xQny0cFbxKXdnnsGdpDI18jxTytPNyBg3zbe7ZkBNtNr+2aEWim7
 XuSi6LGLepbq7n+A2b41SC7vFZRnTXXGyLnxGC1AfNkc3al577WM0ivyXKM5nhlnKBkh
 HJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432301; x=1729037101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dFojoXE4+jjskAlQVsQMp2S+E0WFZ4r9iQmpRIn1e0=;
 b=jN7ALLvC75QeklQv7cC3LBVAWB05FNZJNZSCFoZ+e1yKRnY+Cs1CwSbu3KYYWWuYUD
 7iZ9SeGyaRbh+p89DseUauwxs2HFPV38xK05DmxWJV0mNutrxVdL8Xgvu10BlexWSHxK
 01x6PU7huSwg14CETnTLKEd0H+OeRyWS5/RuF/NcW/A7YoxpMCKgjq/N9kskPrPJKdNY
 /Dd+WSam5dcrZrJAl8CB7CX7Wxs5Q76NwgcWlLgcsRl1Jo/MMEsmVax1W6h3XKF0knKK
 0JjYeWarmgTWdFXX7aFHbnOHIzsibRnjDoGNiMWxF7hU4rgb2E64acoeu3Oj/qPWHM+L
 bPUQ==
X-Gm-Message-State: AOJu0YwtN6rJFRlXBG+HQBOx+0e0Xt4NLwonus1i6QQnk40WLByN8J2P
 hJ0lyTwrNR1wl6Zwaukd9DMT9rY9Jl/BwP73pxBfUCeOJdAknICWJLxGdT3MmKaUFdFLuzYUcQM
 y
X-Google-Smtp-Source: AGHT+IEqHXg8mWURHcAfVqAuEFw3SPebibRlwH8KpqMvpctboOYhLIxxyQyaRkxFDrswJJ24vV5qqA==
X-Received: by 2002:a17:903:32d0:b0:205:810a:190a with SMTP id
 d9443c01a7336-20c636f44famr10016545ad.2.1728432301297; 
 Tue, 08 Oct 2024 17:05:01 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v3 06/20] accel/tcg: Use the alignment test in tlb_fill_align
Date: Tue,  8 Oct 2024 17:04:39 -0700
Message-ID: <20241009000453.315652-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

When we have a tlb miss, defer the alignment check to
the new tlb_fill_align hook.  Move the existing alignment
check so that we only perform it with a tlb hit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 88 ++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d72f454e9e..b76a4eac4e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1620,6 +1620,7 @@ typedef struct MMULookupLocals {
  * mmu_lookup1: translate one page
  * @cpu: generic cpu state
  * @data: lookup parameters
+ * @memop: memory operation for the access, or 0
  * @mmu_idx: virtual address context
  * @access_type: load/store/code
  * @ra: return address into tcg generated code, or 0
@@ -1629,7 +1630,7 @@ typedef struct MMULookupLocals {
  * tlb_fill_align will longjmp out.  Return true if the softmmu tlb for
  * @mmu_idx may have resized.
  */
-static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
+static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
     vaddr addr = data->addr;
@@ -1645,7 +1646,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill_align(cpu, addr, access_type, mmu_idx,
-                           0, data->size, false, ra);
+                           memop, data->size, false, ra);
             maybe_resized = true;
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
@@ -1657,6 +1658,25 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];
 
+    if (likely(!maybe_resized)) {
+        /* Alignment has not been checked by tlb_fill_align. */
+        int a_bits = memop_alignment_bits(memop);
+
+        /*
+         * This alignment check differs from the one above, in that this is
+         * based on the atomicity of the operation. The intended use case is
+         * the ARM memory type field of each PTE, where access to pages with
+         * Device memory type require alignment.
+         */
+        if (unlikely(flags & TLB_CHECK_ALIGNED)) {
+            int at_bits = memop_atomicity_bits(memop);
+            a_bits = MAX(a_bits, at_bits);
+        }
+        if (unlikely(addr & ((1 << a_bits) - 1))) {
+            cpu_unaligned_access(cpu, addr, access_type, mmu_idx, ra);
+        }
+    }
+
     data->full = full;
     data->flags = flags;
     /* Compute haddr speculatively; depending on flags it might be invalid. */
@@ -1713,7 +1733,6 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
 static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
-    unsigned a_bits;
     bool crosspage;
     int flags;
 
@@ -1722,12 +1741,6 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 
     tcg_debug_assert(l->mmu_idx < NB_MMU_MODES);
 
-    /* Handle CPU specific unaligned behaviour */
-    a_bits = memop_alignment_bits(l->memop);
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
-    }
-
     l->page[0].addr = addr;
     l->page[0].size = memop_size(l->memop);
     l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
@@ -1735,7 +1748,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
     if (likely(!crosspage)) {
-        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
+        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
 
         flags = l->page[0].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
@@ -1754,8 +1767,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
          * Lookup both pages, recognizing exceptions from either.  If the
          * second lookup potentially resized, refresh first CPUTLBEntryFull.
          */
-        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
-        if (mmu_lookup1(cpu, &l->page[1], l->mmu_idx, type, ra)) {
+        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
+        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
         }
@@ -1774,19 +1787,6 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         tcg_debug_assert((flags & TLB_BSWAP) == 0);
     }
 
-    /*
-     * This alignment check differs from the one above, in that this is
-     * based on the atomicity of the operation. The intended use case is
-     * the ARM memory type field of each PTE, where access to pages with
-     * Device memory type require alignment.
-     */
-    if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-        a_bits = memop_atomicity_bits(l->memop);
-        if (addr & ((1 << a_bits) - 1)) {
-            cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
-        }
-    }
-
     return crosspage;
 }
 
@@ -1799,34 +1799,18 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
-    int a_bits = memop_alignment_bits(mop);
     uintptr_t index;
     CPUTLBEntry *tlbe;
     vaddr tlb_addr;
     void *hostaddr;
     CPUTLBEntryFull *full;
+    bool did_tlb_fill = false;
 
     tcg_debug_assert(mmu_idx < NB_MMU_MODES);
 
     /* Adjust the given return address.  */
     retaddr -= GETPC_ADJ;
 
-    /* Enforce guest required alignment.  */
-    if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
-        /* ??? Maybe indicate atomic op to cpu_unaligned_access */
-        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
-    }
-
-    /* Enforce qemu required alignment.  */
-    if (unlikely(addr & (size - 1))) {
-        /* We get here if guest alignment was not requested,
-           or was not enforced by cpu_unaligned_access above.
-           We might widen the access and emulate, but for now
-           mark an exception and exit the cpu loop.  */
-        goto stop_the_world;
-    }
-
     index = tlb_index(cpu, mmu_idx, addr);
     tlbe = tlb_entry(cpu, mmu_idx, addr);
 
@@ -1836,7 +1820,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
-                           0, size, false, retaddr);
+                           mop, size, false, retaddr);
+            did_tlb_fill = true;
             index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
         }
@@ -1859,6 +1844,23 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
          */
         g_assert_not_reached();
     }
+
+    /* Enforce guest required alignment, if not handled by tlb_fill_align. */
+    if (!did_tlb_fill && (addr & ((1 << memop_alignment_bits(mop)) - 1))) {
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, mmu_idx, retaddr);
+    }
+
+    /* Enforce qemu required alignment.  */
+    if (unlikely(addr & (size - 1))) {
+        /*
+         * We get here if guest alignment was not requested, or was not
+         * enforced by cpu_unaligned_access or tlb_fill_align above.
+         * We might widen the access and emulate, but for now
+         * mark an exception and exit the cpu loop.
+         */
+        goto stop_the_world;
+    }
+
     /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
 
-- 
2.43.0


