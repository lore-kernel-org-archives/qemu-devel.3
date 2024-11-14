Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E7D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJR-0006DX-GS; Thu, 14 Nov 2024 11:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-00052K-Kt
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:11 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIF-0002I2-JR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:08 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ea09a033e2so583641a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600121; x=1732204921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IURXvWR9Voo5SpXlji5M2ea/nd6IIOVKEQdxMQkSin0=;
 b=A2IqJvA2xpVtZJn3lw34e1h8A9xoVU1I3HH2NV6TTnOxUHQ8Y1ytbpVCAiJBNeN8j4
 AbGRZ1Q8vCgI2nZprhf2ytEP8dFj2Dj28ar4Ij/bZB6eofZng1NixcmA5xbzOA2taAvJ
 Wt53e0/RxGq8srQWiYw9pF/SZgeI18gKfwDbNx9U5DzzleI9yAf2Vt2cnSOvsNgysm6c
 022s1r7h/XHZZRVlZPqd+fjRbtTNmjlsK/QKSFtBtME/IqGPi5qmUWAHrKRaspPjyqkn
 oefxhBaF598EEHHTRmWozKdiVn5AYAO26e+WnYZbVUqYIUbCowqj5SXQg8YES6au69vf
 8Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600121; x=1732204921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IURXvWR9Voo5SpXlji5M2ea/nd6IIOVKEQdxMQkSin0=;
 b=PMuWRtDpY+IxBDj37s5Vguoz92OsLdA+KHY2lm4WJcJzaFR20Urp4q433q4C0HdWqb
 /sytLzkLOSDAT4IQRUAKRWpdG8swFaXa2uYvaAcSzX18jE9ox12riGfq5zE4ZBA0L3VE
 RM8V+OW1FmJpWYm66VJYttMsBFrToxYD0+xTV/Z053PCUzrEHeKh+IQ7HyS2QL2atDGt
 ibzQ+zFfiEQxzYsMM3uRmIMFGp5/VSp012wobsO975SFGyk7r9g4WFaC9Hcv3QSrckoh
 CxE2ShaFROFP2hGNugDdwR1T2XX86HTkpb6BY+KSkKREE5nnFqDbglod7WE982Ru1eWf
 W6Dw==
X-Gm-Message-State: AOJu0YyfD0IeK1LxgdE2vyfx1qKlKzMK2VTLW+A0l41HdlVn/cyUSrql
 XeViVpvMGO+Uc8bLIWKWj6XOuvUxVGSiofS95+ggv6S0PxjyxPg3EiDDDWHlBUwwO0QTOVfBgRa
 a
X-Google-Smtp-Source: AGHT+IEjX+Ulkz2mMI/955PVO4PcTvmrJ75S2hcYlmsqS/eC4gXSvI3ufVaBEIIueRuHWvdVSwHrMg==
X-Received: by 2002:a17:90a:e7c3:b0:2e2:cd79:ec06 with SMTP id
 98e67ed59e1d1-2e9f2c77384mr9130730a91.10.1731600121352; 
 Thu, 14 Nov 2024 08:02:01 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 33/54] accel/tcg: Remove CPUTLBDesc.fulltlb
Date: Thu, 14 Nov 2024 08:01:09 -0800
Message-ID: <20241114160131.48616-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

This array is now write-only, and may be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  1 -
 accel/tcg/cputlb.c    | 34 +++++++---------------------------
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4364ddb1db..5c069f2a00 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -219,7 +219,6 @@ typedef struct CPUTLBDesc {
     /* maximum number of entries observed in the window */
     size_t window_max_entries;
     size_t n_used_entries;
-    CPUTLBEntryFull *fulltlb;
     /* All active tlb entries for this address space. */
     IntervalTreeRoot iroot;
 } CPUTLBDesc;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3282436752..7f63dc3fd8 100644
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
@@ -372,15 +360,9 @@ void tlb_init(CPUState *cpu)
 
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
@@ -1061,7 +1043,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLB *tlb = &cpu->neg.tlb;
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
-    unsigned int index, read_flags, write_flags;
+    unsigned int read_flags, write_flags;
     uintptr_t addend;
     CPUTLBEntry *te;
     CPUTLBEntryTree *node;
@@ -1140,7 +1122,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     wp_flags = cpu_watchpoint_address_matches(cpu, addr_page,
                                               TARGET_PAGE_SIZE);
 
-    index = tlb_index(cpu, mmu_idx, addr_page);
     te = tlb_entry(cpu, mmu_idx, addr_page);
 
     /*
@@ -1179,8 +1160,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      * subtract here is that of the page base, and not the same as the
      * vaddr we add back in io_prepare()/get_page_addr_code().
      */
-    desc->fulltlb[index] = *full;
-    full = &desc->fulltlb[index];
+    node->full = *full;
+    full = &node->full;
     full->xlat_section = iotlb - addr_page;
     full->phys_addr = paddr_page;
 
@@ -1203,7 +1184,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     tlb_set_compare(full, &node->copy, addr_page, write_flags,
                     MMU_DATA_STORE, prot & PAGE_WRITE);
 
-    node->full = *full;
     copy_tlb_helper_locked(te, &node->copy);
     desc->n_used_entries++;
     qemu_spin_unlock(&tlb->c.lock);
-- 
2.43.0


