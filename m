Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD32CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJV-0001ZV-He; Wed, 09 Oct 2024 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJT-0001Xt-AU
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJR-000800-FE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71df8585a42so3379861b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486556; x=1729091356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C3cDVXu4VfzFCQhmjj/FYugodHrKWNrss8x522Nay9g=;
 b=cYo0yiHg9iXtPNRKENMjRGfyNadnw3WD9nVYSaOcVt+zqaNrDGlZtDn0o7rveHMT/H
 FsOJqTL4zOR6oy1drokRClxQ0PKUTnymtMaWnIhQbW84il8BPdmbaUsCRE5M9euIcSQX
 V8LOwvnJlpqeDvnMypHK5bvSWq6T4UBh4AWcrPjvHI9PtkWzjLjnIIwG0sgJaimairBF
 UCHCdldal5aeqnW7YmY9DEMMkI8MSxYRCo7iBlplHk9+mpsrfcJWreNLdBUF7eN3jNqt
 8Spe8yzFlMmE0HvXpMc4h0rWFEiP8UpCFRADQaaeWdn/NTDpTKkdsL7RB3Wxj3drGb+z
 lkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486556; x=1729091356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3cDVXu4VfzFCQhmjj/FYugodHrKWNrss8x522Nay9g=;
 b=LzWec/sm0MCff07yznxiqiCTaqlbTWoCh0KY71c2X6UqVkQEI78bmMGxEIt2eSd9Oo
 bddV814Gp6GFm91wB4wDD+l1ev2O58rMqLwEyEDGugpqbboqkqorK4U8oqYLhTSrjb9I
 OYLg5/EdAH1Q5DSLsFs6JEuM7EN2dUTwmpNfcK7R9V4mcSgyD3BS5ZA5axhCEOSX2KNN
 LuzFJ6DvibcIsXtK/5ZmoI8Zsoc5J4zvL6S41b4jCgbnrEDN+f79Ykc+M5k7D77Vt8dP
 4s68jYlmYmyskViDRIJTohhuUMPiI78FejVgbykxQmDM/oxZyxPq7oaQWOepzlRNcna0
 lmog==
X-Gm-Message-State: AOJu0YxmssAmempwIkIp8AzWiL0Hg9dg40nXqJusrGHen03Wty6wALrM
 4KeJx1SM/xJCVC4yxcr33k81MfLeuTzmAKnYVOQRWCAYAiu7bqjegiwzcxVP2Z0vDXlrBSoOEYM
 I
X-Google-Smtp-Source: AGHT+IE9ITl34ksIZy9aDp5hrAS5Hbns5+XXr23qjhRcKtmbGNyiOxDllfTeNuAfAGdq5rW9HWVp5A==
X-Received: by 2002:a05:6a00:114a:b0:71e:1722:d037 with SMTP id
 d2e1a72fcca58-71e1dbb561fmr4743119b3a.22.1728486555800; 
 Wed, 09 Oct 2024 08:09:15 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/23] accel/tcg: Remove CPUTLBDesc.fulltlb
Date: Wed,  9 Oct 2024 08:08:53 -0700
Message-ID: <20241009150855.804605-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

This array is now write-only, and may be remove.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  1 -
 accel/tcg/cputlb.c    | 39 ++++++++-------------------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6b1c2bfadd..3022529733 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -216,7 +216,6 @@ typedef struct CPUTLBDesc {
     /* maximum number of entries observed in the window */
     size_t window_max_entries;
     size_t n_used_entries;
-    CPUTLBEntryFull *fulltlb;
     /* All active tlb entries for this address space. */
     IntervalTreeRoot iroot;
 } CPUTLBDesc;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a8d1b4fb2..47b9557bb8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -149,13 +149,6 @@ static inline CPUTLBEntry *tlbfast_entry(CPUTLBDescFast *fast, vaddr addr)
     return fast->table + tlbfast_index(fast, addr);
 }
 
-/* Find the TLB index corresponding to the mmu_idx + address pair.  */
-static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
-                                  vaddr addr)
-{
-    return tlbfast_index(&cpu->neg.tlb.f[mmu_idx], addr);
-}
-
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
                                      vaddr addr)
@@ -270,22 +263,20 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
     }
 
     g_free(fast->table);
-    g_free(desc->fulltlb);
 
     tlb_window_reset(desc, now, 0);
     /* desc->n_used_entries is cleared by the caller */
     fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
     fast->table = g_try_new(CPUTLBEntry, new_size);
-    desc->fulltlb = g_try_new(CPUTLBEntryFull, new_size);
 
     /*
-     * If the allocations fail, try smaller sizes. We just freed some
+     * If the allocation fails, try smaller sizes. We just freed some
      * memory, so going back to half of new_size has a good chance of working.
      * Increased memory pressure elsewhere in the system might cause the
      * allocations to fail though, so we progressively reduce the allocation
      * size, aborting if we cannot even allocate the smallest TLB we support.
      */
-    while (fast->table == NULL || desc->fulltlb == NULL) {
+    while (fast->table == NULL) {
         if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
             error_report("%s: %s", __func__, strerror(errno));
             abort();
@@ -294,9 +285,7 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
         fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
 
         g_free(fast->table);
-        g_free(desc->fulltlb);
         fast->table = g_try_new(CPUTLBEntry, new_size);
-        desc->fulltlb = g_try_new(CPUTLBEntryFull, new_size);
     }
 }
 
@@ -350,7 +339,6 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
     desc->n_used_entries = 0;
     fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
     fast->table = g_new(CPUTLBEntry, n_entries);
-    desc->fulltlb = g_new(CPUTLBEntryFull, n_entries);
     memset(&desc->iroot, 0, sizeof(desc->iroot));
     tlb_mmu_flush_locked(desc, fast);
 }
@@ -382,15 +370,9 @@ void tlb_init(CPUState *cpu)
 
 void tlb_destroy(CPUState *cpu)
 {
-    int i;
-
     qemu_spin_destroy(&cpu->neg.tlb.c.lock);
-    for (i = 0; i < NB_MMU_MODES; i++) {
-        CPUTLBDesc *desc = &cpu->neg.tlb.d[i];
-        CPUTLBDescFast *fast = &cpu->neg.tlb.f[i];
-
-        g_free(fast->table);
-        g_free(desc->fulltlb);
+    for (int i = 0; i < NB_MMU_MODES; i++) {
+        g_free(cpu->neg.tlb.f[i].table);
         interval_tree_free_nodes(&cpu->neg.tlb.d[i].iroot,
                                  offsetof(CPUTLBEntryTree, itree));
     }
@@ -1090,7 +1072,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLB *tlb = &cpu->neg.tlb;
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
-    unsigned int index, read_flags, write_flags;
+    unsigned int read_flags, write_flags;
     uintptr_t addend;
     CPUTLBEntry *te;
     CPUTLBEntryTree *node;
@@ -1169,7 +1151,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
                                               TARGET_PAGE_SIZE);
 
-    index = tlb_index(cpu, mmu_idx, addr_page);
     te = tlb_entry(cpu, mmu_idx, addr_page);
 
     /*
@@ -1208,8 +1189,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * subtract here is that of the page base, and not the same as the
      * vaddr we add back in io_prepare()/get_page_addr_code().
      */
-    desc->fulltlb[index] = *full;
-    full = &desc->fulltlb[index];
+    node->full = *full;
+    full = &node->full;
     full->xlat_section = iotlb - addr_page;
     full->phys_addr = paddr_page;
 
@@ -1232,7 +1213,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     tlb_set_compare(full, &node->copy, addr_page, write_flags,
                     MMU_DATA_STORE, prot & PAGE_WRITE);
 
-    node->full = *full;
     copy_tlb_helper_locked(te, &node->copy);
     tlb_n_used_entries_inc(cpu, mmu_idx);
     qemu_spin_unlock(&tlb->c.lock);
@@ -1343,7 +1323,6 @@ static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
     CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
     CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
     CPUTLBEntryTree *node;
-    size_t index;
 
     assert_cpu_is_self(cpu);
     node = tlbtree_lookup_addr(desc, addr);
@@ -1358,12 +1337,10 @@ static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
     }
 
     /* Install the cached entry. */
-    index = tlbfast_index(fast, addr);
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
-    copy_tlb_helper_locked(&fast->table[index], &node->copy);
+    copy_tlb_helper_locked(tlbfast_entry(fast, addr), &node->copy);
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
 
-    desc->fulltlb[index] = node->full;
     return true;
 }
 
-- 
2.43.0


