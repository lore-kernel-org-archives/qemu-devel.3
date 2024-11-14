Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15ACD68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHv-0004wK-1W; Thu, 14 Nov 2024 11:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHt-0004ue-0f
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:41 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHr-0002BM-3l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:40 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7f45ab88e7fso619465a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600096; x=1732204896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xBjb7ecHDPeo10d84Jo9N+bY5e+BwxfICVTefAKQV3o=;
 b=YKXEDKgYQAzfyWxXvedlBz+JpAG/hHBVVgcHoZH/I58mOtDblQFkV8YoER1OCQk+Ug
 lEcpPC0113eq8uPjzqv41ppeGpfA/SQhgOOvpBzbJth8mxY2l05PKEvDhdxEdKmBmZG9
 EaFc6AqcWuVPXLt7s6o4x6yZgL8V4LCfDTONeY1nvE8uAZfXox+huPqp1qWAlHpnj+SL
 iJilmLyYOZtv0F4l4tMiNP15hI/ZjzRjcYYDcUvxkG3pbehjManxuzxQpSZw10F5Xkcq
 +Pk3xSv9PFzcibjKuZ/sJyP14ZcNHOLl4Ie9QCWzKi8EZF4J3IUoOiuhvRg1pM6Np4DU
 j6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600096; x=1732204896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBjb7ecHDPeo10d84Jo9N+bY5e+BwxfICVTefAKQV3o=;
 b=OsaPvOVIMGRvLhYkR7peqkD8xWe5dZiX/qFWkBO3CqYDYNOsN3417CKveHd5XKuW4/
 qwsGg11dTc2HV+qalkWz+hEG+Siu6gmcfGkTHTdY1QoPjZ6t1wnXXHVDtUVg2I+nv8HD
 SYFtOz2twtWAfjMQbAsw6wfspkdq+MAszt5KppKlkmOiaEU/xYFnosSurFxItYOuN8yZ
 39kqzdOyj/VPuO5s/90ZdNWMVSBbL4g9qZf7VfiQzZBVpUYGZkczs0P7fxw1B2WHkSjZ
 j3KcbUdogIEwd6dqR8Cjmi1EYFWvEUjqf8TVc+08Mal3g/7GAwhYLXP5WUD3Gde0pmgd
 ozWw==
X-Gm-Message-State: AOJu0YyAkftRFylzmZki62qFMcLoSIi66i218xXsQuDo1H+/9dd3ROt1
 ZjQjD5NSgm6rvsG2sykacuEgVtpwXu5KXZR56ZdcojpEwNxe6VkD4Sgz3kFSZQyAqtTKI0GZkyx
 z
X-Google-Smtp-Source: AGHT+IEnl0PgJGqLTR9i+8vRxjxCxE5d9vm4HYUQA/i/q9UpyST7qJtzTTkwC0BS/NulzX2uNFBPxw==
X-Received: by 2002:a17:90b:3883:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e9b171e360mr33852391a91.12.1731600096298; 
 Thu, 14 Nov 2024 08:01:36 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/54] accel/tcg: Fix flags usage in mmu_lookup1,
 atomic_mmu_lookup
Date: Thu, 14 Nov 2024 08:00:41 -0800
Message-ID: <20241114160131.48616-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
index 46fa0ae802..77b972fd93 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1652,7 +1652,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     bool maybe_resized = false;
     CPUTLBEntryFull *full;
-    int flags;
+    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
@@ -1663,8 +1663,14 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
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
@@ -1814,10 +1820,10 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     MemOp mop = get_memop(oi);
     uintptr_t index;
     CPUTLBEntry *tlbe;
-    vaddr tlb_addr;
     void *hostaddr;
     CPUTLBEntryFull *full;
     bool did_tlb_fill = false;
+    int flags;
 
     tcg_debug_assert(mmu_idx < NB_MMU_MODES);
 
@@ -1828,8 +1834,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     tlbe = tlb_entry(cpu, mmu_idx, addr);
 
     /* Check TLB entry and enforce page permissions.  */
-    tlb_addr = tlb_addr_write(tlbe);
-    if (!tlb_hit(tlb_addr, addr)) {
+    flags = TLB_FLAGS_MASK;
+    if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
@@ -1837,8 +1843,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
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
@@ -1874,11 +1885,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
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
@@ -1887,11 +1898,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
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


