Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE063C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIK6-000285-5B; Fri, 10 Jul 2026 16:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIN-0000w6-CC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:05 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIC-0001wA-Os
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:03 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1934160a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717071; x=1784321871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JmjdcWDm3mF1YdNNpgp9aZdazz5VacQFjad94vdrfZs=;
 b=w7myDxbY0j/pKAPQCAtHPY+3cs14SMqB5k9lZ37eup9GINqoPB7+0cQV4pkqhlrgsF
 /qUs7oeD1y/tVWh6/mQGhgbBryAtd3F0E/4d5KaxdwR/sd5wGCVV8L78xtZNBDWdeS3x
 0g5mpfwezF6WQRpmd/Yxq/jzvJN/jUffeDJTe7ql1sSLGijuTAjsBC51Bv/FZjLfaU91
 ZScEZawT9tqhjYFK+6zNBHK3ugoYDZOeO86q7qeSAtLB+1zenigw8rzWkb82Wd+eMRMt
 B3t8h5WhdYVSvbsMF2dSli22oBuy2lSM7YOKNCRQue9yv/QydjgPd8Qig6D35pJxEC1N
 kmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717071; x=1784321871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JmjdcWDm3mF1YdNNpgp9aZdazz5VacQFjad94vdrfZs=;
 b=O61/2VHUZ74Qcv0HHU1QmHzMlU2MXHV5167lXdE4tYa0rSLX26Jo+v45KInqezUTSa
 LZQXgUiYk/CbB+E1nIOchwNFg8RJaC8fo18+kBXLdvd4RSsOdsHS6P59y3McodQ/AdRv
 Jf4Ejo86LDkYaHX9EVar06+k9Fsx1jrwfyh4D0VnxiUQ85e6vO7vGhIy9jCZPGj6JBs+
 /6FHfqDqCeRQcUxujT0+pCNKfZFwXYMfpYEr0c7GkwzMpfIg9PsH3Db4wOd9mDbW8j79
 NZh4cN2DRjh6d2RifwNCf3vf9QIHWDmdwhcu/1nmntn1IbkovKMZ5xRCDktVFMEi9y0S
 xfyQ==
X-Gm-Message-State: AOJu0YySu6AXokZRFAOOikS1s2qPKpkOeUkCuxpWmcMcDj18Ao1PoFT3
 /BXVm6xQ2RSYJC6wSFhLrKeUBS4ujVSqAjYqLIo2d1dNm1S70/eEj7AGNi4esPwHd/PyvoV1cic
 0Gaxq
X-Gm-Gg: AfdE7ck5sg/0AE4yKyEIrBTwO/OQn+CMCv7o+9IA9LgJ4qnaE4WVEn4pYt9ZMF2Un/+
 zEFbWVjLmYBTTTw4+F6W4uZxFxYYfO1tZzMD52Hj0ucJ93QjD6Ge8dkuEpYpkv3+5cBU6On0Anb
 U5P7vwBYWNvg1fbbkwgzDFp1YjqLywJwLJaMU+NF+2JSadxczEeWzhUR86HFkZjkNV+/zO0heDq
 AuRIa2oupGCaVNFibwgkwa3P/q4nrFZGVPB7nLa+2bKXjc+4b7o9R8hD7H0d4hFthv7hr0eWFg9
 xCJDAC0NoXZZFlgRanlGt+TNBzBg52qlXxycHFPqkCKsxEPcwQly0sAot1l5qQrJHBDHcQDVnG5
 HX091dWc+u4FasES1Y0p1lDsp0oTqtmGLIiLLj4r5mrdV/P5gA4KARtxN8wXkI7C5fspUTYkPSn
 4GCc5TZ/0Fr8GUg7D2WA==
X-Received: by 2002:a17:90a:da87:b0:37f:caeb:69df with SMTP id
 98e67ed59e1d1-38dc77381f2mr529130a91.22.1783717070836; 
 Fri, 10 Jul 2026 13:57:50 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 47/51] accel/tcg: Use addr/last in tlb_flush_range_locked
Date: Fri, 10 Jul 2026 13:53:57 -0700
Message-ID: <20260710205401.836304-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Change from addr/len to addr/last in the implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 71 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c8ba727859..2c0f7bed52 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -655,7 +655,7 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
 }
 
 static void tlb_flush_range_locked(CPUState *cpu, int midx,
-                                   vaddr addr, vaddr len,
+                                   vaddr addr, vaddr last,
                                    unsigned bits)
 {
     CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
@@ -669,13 +669,13 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      * TODO: Perhaps allow bits to be a few bits less than the size.
      * For now, just flush the entire TLB.
      *
-     * If @len is larger than the tlb size, then it will take longer to
+     * If [addr:last] is larger than the tlb size, then it will take longer to
      * test all of the entries in the TLB than it will to flush it all.
      */
-    if (mask < f->mask || len > f->mask) {
+    if (mask < f->mask || ((addr ^ last) & ~f->mask) != 0) {
         tlb_debug("forcing full flush midx %d ("
-                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
-                  midx, addr, mask, len);
+                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "-%016" VADDR_PRIx ")\n",
+                  midx, addr, mask, last);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
         return;
     }
@@ -685,7 +685,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      * Because large_page_mask contains all 1's from the msb,
      * we only need to test the end of the range.
      */
-    if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
+    if ((last & d->large_page_mask) == d->large_page_addr) {
         tlb_debug("forcing full flush midx %d ("
                   "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
@@ -693,20 +693,23 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
         return;
     }
 
-    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
-        vaddr page = addr + i;
+    for (vaddr page = addr; ; page += TARGET_PAGE_SIZE) {
         CPUTLBEntry *entry = tlb_entry(cpu, midx, page);
 
         if (tlb_flush_entry_mask_locked(entry, page, mask)) {
             tlb_n_used_entries_dec(cpu, midx);
         }
         tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
+
+        if (page == last) {
+            break;
+        }
     }
 }
 
 typedef struct {
     vaddr addr;
-    vaddr len;
+    vaddr last;
     MMUIdxMap idxmap;
     unsigned bits;
 } TLBFlushRangeData;
@@ -718,13 +721,13 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
 
     assert_cpu_is_self(cpu);
 
-    tlb_debug("range: %016" VADDR_PRIx "/%u+%016" VADDR_PRIx " mmu_map:0x%x\n",
-              d.addr, d.bits, d.len, d.idxmap);
+    tlb_debug("range: %016" VADDR_PRIx "/%u-%016" VADDR_PRIx " mmu_map:0x%x\n",
+              d.addr, d.bits, d.last, d.idxmap);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if ((d.idxmap >> mmu_idx) & 1) {
-            tlb_flush_range_locked(cpu, mmu_idx, d.addr, d.len, d.bits);
+            tlb_flush_range_locked(cpu, mmu_idx, d.addr, d.last, d.bits);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
@@ -733,7 +736,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
      * If the length is larger than the jump cache size, then it will take
      * longer to clear each entry individually than it will to clear it all.
      */
-    if (d.len >= (TARGET_PAGE_SIZE * TB_JMP_CACHE_SIZE)) {
+    if (((d.last - d.addr) >> TARGET_PAGE_SIZE) + 1 >= TB_JMP_CACHE_SIZE) {
         tcg_flush_jmp_cache(cpu);
         return;
     }
@@ -742,10 +745,11 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
      * Discard jump cache entries for any tb which might potentially
      * overlap the flushed pages, which includes the previous.
      */
-    d.addr -= TARGET_PAGE_SIZE;
-    for (vaddr i = 0, n = d.len / TARGET_PAGE_SIZE + 1; i < n; i++) {
-        tb_jmp_cache_clear_page(cpu, d.addr);
-        d.addr += TARGET_PAGE_SIZE;
+    tb_jmp_cache_clear_page(cpu, d.addr - TARGET_PAGE_SIZE);
+    for (vaddr page = d.addr; ; page += TARGET_PAGE_SIZE) {
+        if (page == d.last) {
+            break;
+        }
     }
 }
 
@@ -761,7 +765,12 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
                                vaddr len, MMUIdxMap idxmap,
                                unsigned bits)
 {
-    TLBFlushRangeData d;
+    TLBFlushRangeData d = {
+        .addr = addr & TARGET_PAGE_MASK,
+        .last = (addr + len - 1) & TARGET_PAGE_MASK,
+        .idxmap = idxmap,
+        .bits = bits,
+    };
 
     assert_cpu_is_self(cpu);
 
@@ -770,21 +779,16 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
         tlb_flush_by_mmuidx(cpu, idxmap);
         return;
     }
+
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (len <= TARGET_PAGE_SIZE && bits >= target_long_bits()) {
+    if (d.addr == d.last && bits >= target_long_bits()) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
 
-    /* This should already be page aligned */
-    d.addr = addr & TARGET_PAGE_MASK;
-    d.len = len;
-    d.idxmap = idxmap;
-    d.bits = bits;
-
     tlb_flush_range_by_mmuidx_async_0(cpu, d);
 }
 
@@ -800,7 +804,13 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                                MMUIdxMap idxmap,
                                                unsigned bits)
 {
-    TLBFlushRangeData d, *p;
+    TLBFlushRangeData d = {
+        .addr = addr & TARGET_PAGE_MASK,
+        .last = (addr + len - 1) & TARGET_PAGE_MASK,
+        .idxmap = idxmap,
+        .bits = bits,
+    };
+    TLBFlushRangeData *p;
     CPUState *dst_cpu;
 
     /* If no page bits are significant, this devolves to tlb_flush. */
@@ -808,21 +818,16 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
         tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
         return;
     }
+
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (len <= TARGET_PAGE_SIZE && bits >= target_long_bits()) {
+    if (d.addr == d.last && bits >= target_long_bits()) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
 
-    /* This should already be page aligned */
-    d.addr = addr & TARGET_PAGE_MASK;
-    d.len = len;
-    d.idxmap = idxmap;
-    d.bits = bits;
-
     /* Allocate a separate data block for each destination cpu.  */
     CPU_FOREACH(dst_cpu) {
         if (dst_cpu != src_cpu) {
-- 
2.43.0


