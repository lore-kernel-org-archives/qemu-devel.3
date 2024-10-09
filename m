Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2200CEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJO-0001VW-Uu; Wed, 09 Oct 2024 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJN-0001V8-P1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJL-0007yY-SF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71def715ebdso3601982b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486550; x=1729091350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ORHeYVe4iZoRiXmNScxIZEQWJj516Vk6OjgxA97UeGU=;
 b=D7Y1nobLswka6lcLLAeHIPi92RwnnRr6EvJyYh1yV9tKHzkllpcWrrxnXtMOD4vZ27
 rxbL4I0UWgEFueTwDi4yztQoD+xenkK3Ma2hF4KKwTOTyQx9RcAHMzndaydrqzrH39Vx
 nCcVjEp2071PAOMr7MbkY6V9dqVeSkLah8jwdUyy4v0f0Rq9bnOezVIzZuOf72YGoSJj
 KMBX1YcHEWGYc5CGPy1OXEp1s0pSzlNmnpT4EKZNI18uCqXYIGVGSdNvnYCzYQGJNOk4
 QSxH9FNi9mIpWGR8rcWMup0AipugkEEsXklYC3peFJZKUzwNZF/BkVIBbSktIMrrrUcT
 gcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486550; x=1729091350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORHeYVe4iZoRiXmNScxIZEQWJj516Vk6OjgxA97UeGU=;
 b=NOK0Y/BJC4oRHHRSN4PyNmdfVKBApWob9YxqlCGfpr7j2JV5x5EC2smZzVux2Kr2sF
 bAAqMl039skeHtxhGDNnGW2TCtrJGl5Z92W1uMFdJ65NKX3ukPofqrfH8FsyXqTZK3/m
 Pc4mTw3lf8mHKHS9DMXt7SI7W+mPu9weHRr8AWo2yx8cskfO1wmRxnV6/i2fIcvBpCWr
 Gvz/wzgGuhsTzlhg2P0jojAK7g9+U5gMUfpiL+zzDbPI+A45MVSH6/opOl8Cg8RyeYtp
 wltEOsLqzlBpxXNC2sw3RLcYcMdrS2FJaOQkW8QA15rhN90yHKuZkHRYzYR9VZ1Cl16K
 +Aag==
X-Gm-Message-State: AOJu0YyNud5fxZaa9Zdx7AQfS0KRbDrmKftO57R6d/rx8ketRzQ1izWz
 2kCuQxPBsALbzDOozUqfk3cKq0w0Ctg9+hu0o23io5jEAH4OjBvLOFI2Bjj7Fz3MtyyPrGYV/qv
 a
X-Google-Smtp-Source: AGHT+IGRfyvjUUTQW5hOt1aaof9W9iC27riiWVSa+dVzqAcXieD0RNImwpKk+cy+tfxNzQvb8xhLVg==
X-Received: by 2002:a05:6a20:9e4c:b0:1d2:e8d8:dd46 with SMTP id
 adf61e73a8af0-1d8a3c005a2mr4284483637.15.1728486550037; 
 Wed, 09 Oct 2024 08:09:10 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/23] accel/tcg: Remove the victim tlb
Date: Wed,  9 Oct 2024 08:08:47 -0700
Message-ID: <20241009150855.804605-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

This has been functionally replaced by the IntervalTree.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  8 ------
 accel/tcg/cputlb.c    | 64 -------------------------------------------
 2 files changed, 72 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b567abe3e2..87b864f5c4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -198,9 +198,6 @@ struct CPUClass {
  */
 #define NB_MMU_MODES 16
 
-/* Use a fully associative victim tlb of 8 entries. */
-#define CPU_VTLB_SIZE 8
-
 /*
  * The full TLB entry, which is not accessed by generated TCG code,
  * so the layout is not as critical as that of CPUTLBEntry. This is
@@ -282,11 +279,6 @@ typedef struct CPUTLBDesc {
     /* maximum number of entries observed in the window */
     size_t window_max_entries;
     size_t n_used_entries;
-    /* The next index to use in the tlb victim table.  */
-    size_t vindex;
-    /* The tlb victim table, in two parts.  */
-    CPUTLBEntry vtable[CPU_VTLB_SIZE];
-    CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
     CPUTLBEntryFull *fulltlb;
     /* All active tlb entries for this address space. */
     IntervalTreeRoot iroot;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b10b0a357c..561f66c723 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -328,8 +328,6 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     tlbfast_flush_locked(desc, fast);
     desc->large_page_addr = -1;
     desc->large_page_mask = -1;
-    desc->vindex = 0;
-    memset(desc->vtable, -1, sizeof(desc->vtable));
     interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
 }
 
@@ -501,15 +499,6 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
     return tlb_hit_page_mask_anyprot(tlb_entry, page, -1);
 }
 
-/**
- * tlb_entry_is_empty - return true if the entry is not in use
- * @te: pointer to CPUTLBEntry
- */
-static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
-{
-    return te->addr_read == -1 && te->addr_write == -1 && te->addr_code == -1;
-}
-
 /* Called with tlb_c.lock held */
 static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
                                         vaddr page,
@@ -527,28 +516,6 @@ static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry, vaddr page)
     return tlb_flush_entry_mask_locked(tlb_entry, page, -1);
 }
 
-/* Called with tlb_c.lock held */
-static void tlb_flush_vtlb_page_mask_locked(CPUState *cpu, int mmu_idx,
-                                            vaddr page,
-                                            vaddr mask)
-{
-    CPUTLBDesc *d = &cpu->neg.tlb.d[mmu_idx];
-    int k;
-
-    assert_cpu_is_self(cpu);
-    for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        if (tlb_flush_entry_mask_locked(&d->vtable[k], page, mask)) {
-            tlb_n_used_entries_dec(cpu, mmu_idx);
-        }
-    }
-}
-
-static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
-                                              vaddr page)
-{
-    tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
-}
-
 static void tlbfast_flush_range_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
                                        vaddr addr, vaddr len, vaddr mask)
 {
@@ -593,7 +560,6 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 
     tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
                                page, TARGET_PAGE_SIZE, -1);
-    tlb_flush_vtlb_page_locked(cpu, midx, page);
 
     node = tlbtree_lookup_addr(desc, page);
     if (node) {
@@ -769,11 +735,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
 
     tlbfast_flush_range_locked(d, f, addr, len, mask);
 
-    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
-        vaddr page = addr + i;
-        tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
-    }
-
     addr_mask = addr & mask;
     last_mask = addr_mask + len - 1;
     last_imask = last_mask | ~mask;
@@ -1031,10 +992,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
             tlb_reset_dirty_range_locked(&fast->table[i], start1, length);
         }
 
-        for (size_t i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&desc->vtable[i], start1, length);
-        }
-
         for (CPUTLBEntryTree *t = tlbtree_lookup_range(desc, 0, -1); t;
              t = tlbtree_lookup_range_next(t, 0, -1)) {
             tlb_reset_dirty_range_locked(&t->copy, start1, length);
@@ -1068,10 +1025,6 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
 
         tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
 
-        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&desc->vtable[k], addr);
-        }
-
         node = tlbtree_lookup_addr(desc, addr);
         if (node) {
             tlb_set_dirty1_locked(&node->copy, addr);
@@ -1230,23 +1183,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     /* Note that the tlb is no longer clean.  */
     tlb->c.dirty |= 1 << mmu_idx;
 
-    /* Make sure there's no cached translation for the new page.  */
-    tlb_flush_vtlb_page_locked(cpu, mmu_idx, addr_page);
-
-    /*
-     * Only evict the old entry to the victim tlb if it's for a
-     * different page; otherwise just overwrite the stale data.
-     */
-    if (!tlb_hit_page_anyprot(te, addr_page) && !tlb_entry_is_empty(te)) {
-        unsigned vidx = desc->vindex++ % CPU_VTLB_SIZE;
-        CPUTLBEntry *tv = &desc->vtable[vidx];
-
-        /* Evict the old entry into the victim tlb.  */
-        copy_tlb_helper_locked(tv, te);
-        desc->vfulltlb[vidx] = desc->fulltlb[index];
-        tlb_n_used_entries_dec(cpu, mmu_idx);
-    }
-
     /* Replace an old IntervalTree entry, or create a new one. */
     node = tlbtree_lookup_addr(desc, addr_page);
     if (!node) {
-- 
2.43.0


