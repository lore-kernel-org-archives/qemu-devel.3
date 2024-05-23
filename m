Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ABDC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHXq-0007Fp-1A; Thu, 23 May 2024 19:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXk-0007D0-8L; Thu, 23 May 2024 19:08:18 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXg-0005ef-TX; Thu, 23 May 2024 19:08:16 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2bde007cc57so1099457a91.2; 
 Thu, 23 May 2024 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505691; x=1717110491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHk6dKWo4NShSVZCXVAxmcusMhLjRq8D/R7B8KT+ML0=;
 b=RxY/4b3Ete6bGV+ZMBMq9S5QMLGl9QXF28tdKUVZCLXQq9btcZhyVa0xzGsT/lLArp
 asXTFaD0gTreYhjK0WJavBdyllcWnktX4+PZfQvnE0MCe3P5a022h3PFHBOpyKUzKyyN
 qfxpQoI9zopXMGtCp/dNgYS669SCyEYVaUJCQGH5nrpVB1Ac8rslVkaJaoDh4acYYUij
 laANPG2UYMDT8y2z7WaPV2vEBWT/pGzNZrk9CRba0nVINYUGQCWn3QdCcRwEU6byrs6o
 Hi1eJgI0Uegd4vYQNf8UYHNZdI2gDBti31r6aAFKznJhh2NbJaOX715xE9yI1smcWksx
 9l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505691; x=1717110491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHk6dKWo4NShSVZCXVAxmcusMhLjRq8D/R7B8KT+ML0=;
 b=rr3fxd7yMIBWYDoeeBO5FGBYTKi/a/00NVytAGxpgkY9BecguxAKyDiQY/H+Os9H54
 AAsNDMxBwmTmGgMl0gMfmiV3eXRKQiu0zscjG6YYZ/VqBfYbcEFcONpM07oZYIiRt2ct
 0IXnZyqIEEro4KD14918WSjW7FGBYKBbBoDHBX3HEASrwVqAzLS+Tu1z6/Bl96DxeIv5
 cHJnhORwL8YOoZewyMr5DYmLSNriY67GJn/rzHmxJf3lFKmlEyFnlhdShyGk/2JNVSxh
 YNmv+kb/ngvqvgoiFjx1sIOpbtEasz1LHzfpiFA1+Wubkx2LWRUgk2cs84tCFWQc1yuG
 vokA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNYW0VMTtqlLlySq59xwKr5XcRSecpAUfgzSbBcvjOqmTpSD78Jh1CqlE5IBUEUm2mFEgeHTTJeEF4pHXepMJeuiSQ
X-Gm-Message-State: AOJu0Yy1jDiCLWEo3zwCZVSqHN4qNy7FM8b/VxJ3cbSFVZ9ttKGVNtf1
 bVjb/Qq2FMu5ZURCirhpqkoLGLZAvSMs7Wlfb06UgGx5BX7/QWImiOWczA==
X-Google-Smtp-Source: AGHT+IFpBu6ytRs9L7NKDQobgak2bvdzmyesbkqu27J7lgNII+yzug6UnW3mtxIDvvqgf8V5bHlV3g==
X-Received: by 2002:a17:90a:c903:b0:2bd:92e6:99ac with SMTP id
 98e67ed59e1d1-2bf5f7512e9mr590619a91.40.1716505690685; 
 Thu, 23 May 2024 16:08:10 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/72] tcg/cputlb: Remove non-synced variants of global TLB
 flushes
Date: Fri, 24 May 2024 09:06:37 +1000
Message-ID: <20240523230747.45703-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These are no longer used.

  tlb_flush_all_cpus: removed by previous commit.
  tlb_flush_page_all_cpus: removed by previous commit.

  tlb_flush_page_bits_by_mmuidx_all_cpus: never used.
  tlb_flush_page_by_mmuidx_all_cpus: never used.
  tlb_flush_page_bits_by_mmuidx_all_cpus: never used, thus:
    tlb_flush_range_by_mmuidx_all_cpus: never used.
    tlb_flush_by_mmuidx_all_cpus: never used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 accel/tcg/cputlb.c              | 103 --------------------------------
 docs/devel/multi-thread-tcg.rst |  13 ++--
 include/exec/exec-all.h         |  97 +++++-------------------------
 3 files changed, 19 insertions(+), 194 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdb3e12dfb..45799869eb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -431,21 +431,6 @@ void tlb_flush(CPUState *cpu)
     tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
 }
 
-void tlb_flush_by_mmuidx_all_cpus(CPUState *src_cpu, uint16_t idxmap)
-{
-    const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
-
-    tlb_debug("mmu_idx: 0x%"PRIx16"\n", idxmap);
-
-    flush_all_helper(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
-    fn(src_cpu, RUN_ON_CPU_HOST_INT(idxmap));
-}
-
-void tlb_flush_all_cpus(CPUState *src_cpu)
-{
-    tlb_flush_by_mmuidx_all_cpus(src_cpu, ALL_MMUIDX_BITS);
-}
-
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
@@ -656,46 +641,6 @@ void tlb_flush_page(CPUState *cpu, vaddr addr)
     tlb_flush_page_by_mmuidx(cpu, addr, ALL_MMUIDX_BITS);
 }
 
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *src_cpu, vaddr addr,
-                                       uint16_t idxmap)
-{
-    tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
-
-    /* This should already be page aligned */
-    addr &= TARGET_PAGE_MASK;
-
-    /*
-     * Allocate memory to hold addr+idxmap only when needed.
-     * See tlb_flush_page_by_mmuidx for details.
-     */
-    if (idxmap < TARGET_PAGE_SIZE) {
-        flush_all_helper(src_cpu, tlb_flush_page_by_mmuidx_async_1,
-                         RUN_ON_CPU_TARGET_PTR(addr | idxmap));
-    } else {
-        CPUState *dst_cpu;
-
-        /* Allocate a separate data block for each destination cpu.  */
-        CPU_FOREACH(dst_cpu) {
-            if (dst_cpu != src_cpu) {
-                TLBFlushPageByMMUIdxData *d
-                    = g_new(TLBFlushPageByMMUIdxData, 1);
-
-                d->addr = addr;
-                d->idxmap = idxmap;
-                async_run_on_cpu(dst_cpu, tlb_flush_page_by_mmuidx_async_2,
-                                 RUN_ON_CPU_HOST_PTR(d));
-            }
-        }
-    }
-
-    tlb_flush_page_by_mmuidx_async_0(src_cpu, addr, idxmap);
-}
-
-void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
-{
-    tlb_flush_page_by_mmuidx_all_cpus(src, addr, ALL_MMUIDX_BITS);
-}
-
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               vaddr addr,
                                               uint16_t idxmap)
@@ -887,54 +832,6 @@ void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
     tlb_flush_range_by_mmuidx(cpu, addr, TARGET_PAGE_SIZE, idxmap, bits);
 }
 
-void tlb_flush_range_by_mmuidx_all_cpus(CPUState *src_cpu,
-                                        vaddr addr, vaddr len,
-                                        uint16_t idxmap, unsigned bits)
-{
-    TLBFlushRangeData d;
-    CPUState *dst_cpu;
-
-    /*
-     * If all bits are significant, and len is small,
-     * this devolves to tlb_flush_page.
-     */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
-        tlb_flush_page_by_mmuidx_all_cpus(src_cpu, addr, idxmap);
-        return;
-    }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx_all_cpus(src_cpu, idxmap);
-        return;
-    }
-
-    /* This should already be page aligned */
-    d.addr = addr & TARGET_PAGE_MASK;
-    d.len = len;
-    d.idxmap = idxmap;
-    d.bits = bits;
-
-    /* Allocate a separate data block for each destination cpu.  */
-    CPU_FOREACH(dst_cpu) {
-        if (dst_cpu != src_cpu) {
-            TLBFlushRangeData *p = g_memdup(&d, sizeof(d));
-            async_run_on_cpu(dst_cpu,
-                             tlb_flush_range_by_mmuidx_async_1,
-                             RUN_ON_CPU_HOST_PTR(p));
-        }
-    }
-
-    tlb_flush_range_by_mmuidx_async_0(src_cpu, d);
-}
-
-void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *src_cpu,
-                                            vaddr addr, uint16_t idxmap,
-                                            unsigned bits)
-{
-    tlb_flush_range_by_mmuidx_all_cpus(src_cpu, addr, TARGET_PAGE_SIZE,
-                                       idxmap, bits);
-}
-
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                                vaddr addr,
                                                vaddr len,
diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 1420789fff..d706c27ea7 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -205,15 +205,10 @@ DESIGN REQUIREMENTS:
 
 (Current solution)
 
-We have updated cputlb.c to defer operations when a cross-vCPU
-operation with async_run_on_cpu() which ensures each vCPU sees a
-coherent state when it next runs its work (in a few instructions
-time).
-
-A new set up operations (tlb_flush_*_all_cpus) take an additional flag
-which when set will force synchronisation by setting the source vCPUs
-work as "safe work" and exiting the cpu run loop. This ensure by the
-time execution restarts all flush operations have completed.
+A new set of tlb flush operations (tlb_flush_*_all_cpus_synced) force
+synchronisation by setting the source vCPUs work as "safe work" and
+exiting the cpu run loop. This ensures that by the time execution
+restarts all flush operations have completed.
 
 TLB flag updates are all done atomically and are also protected by the
 corresponding page lock.
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2cd7b8f61b..b6b46ad13c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -68,24 +68,15 @@ void tlb_destroy(CPUState *cpu);
  */
 void tlb_flush_page(CPUState *cpu, vaddr addr);
 /**
- * tlb_flush_page_all_cpus:
+ * tlb_flush_page_all_cpus_synced:
  * @cpu: src CPU of the flush
  * @addr: virtual address of page to be flushed
  *
- * Flush one page from the TLB of the specified CPU, for all
+ * Flush one page from the TLB of all CPUs, for all
  * MMU indexes.
- */
-void tlb_flush_page_all_cpus(CPUState *src, vaddr addr);
-/**
- * tlb_flush_page_all_cpus_synced:
- * @cpu: src CPU of the flush
- * @addr: virtual address of page to be flushed
  *
- * Flush one page from the TLB of the specified CPU, for all MMU
- * indexes like tlb_flush_page_all_cpus except the source vCPUs work
- * is scheduled as safe work meaning all flushes will be complete once
- * the source vCPUs safe work is complete. This will depend on when
- * the guests translation ends the TB.
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
 /**
@@ -98,19 +89,14 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
  * use one of the other functions for efficiency.
  */
 void tlb_flush(CPUState *cpu);
-/**
- * tlb_flush_all_cpus:
- * @cpu: src CPU of the flush
- */
-void tlb_flush_all_cpus(CPUState *src_cpu);
 /**
  * tlb_flush_all_cpus_synced:
  * @cpu: src CPU of the flush
  *
- * Like tlb_flush_all_cpus except this except the source vCPUs work is
- * scheduled as safe work meaning all flushes will be complete once
- * the source vCPUs safe work is complete. This will depend on when
- * the guests translation ends the TB.
+ * Flush the entire TLB for all CPUs, for all MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_all_cpus_synced(CPUState *src_cpu);
 /**
@@ -125,27 +111,16 @@ void tlb_flush_all_cpus_synced(CPUState *src_cpu);
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
                               uint16_t idxmap);
 /**
- * tlb_flush_page_by_mmuidx_all_cpus:
+ * tlb_flush_page_by_mmuidx_all_cpus_synced:
  * @cpu: Originating CPU of the flush
  * @addr: virtual address of page to be flushed
  * @idxmap: bitmap of MMU indexes to flush
  *
  * Flush one page from the TLB of all CPUs, for the specified
  * MMU indexes.
- */
-void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                       uint16_t idxmap);
-/**
- * tlb_flush_page_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
  *
- * Flush one page from the TLB of all CPUs, for the specified MMU
- * indexes like tlb_flush_page_by_mmuidx_all_cpus except the source
- * vCPUs work is scheduled as safe work meaning all flushes will be
- * complete once  the source vCPUs safe work is complete. This will
- * depend on when the guests translation ends the TB.
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
                                               uint16_t idxmap);
@@ -160,24 +135,15 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
  */
 void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
 /**
- * tlb_flush_by_mmuidx_all_cpus:
+ * tlb_flush_by_mmuidx_all_cpus_synced:
  * @cpu: Originating CPU of the flush
  * @idxmap: bitmap of MMU indexes to flush
  *
- * Flush all entries from all TLBs of all CPUs, for the specified
+ * Flush all entries from the TLB of all CPUs, for the specified
  * MMU indexes.
- */
-void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @idxmap: bitmap of MMU indexes to flush
  *
- * Flush all entries from all TLBs of all CPUs, for the specified
- * MMU indexes like tlb_flush_by_mmuidx_all_cpus except except the source
- * vCPUs work is scheduled as safe work meaning all flushes will be
- * complete once  the source vCPUs safe work is complete. This will
- * depend on when the guests translation ends the TB.
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
  */
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
 
@@ -194,8 +160,6 @@ void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
                                    uint16_t idxmap, unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
-void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                            uint16_t idxmap, unsigned bits);
 void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
     (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
 
@@ -215,9 +179,6 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
                                unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
-void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu, vaddr addr,
-                                        vaddr len, uint16_t idxmap,
-                                        unsigned bits);
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                vaddr addr,
                                                vaddr len,
@@ -290,18 +251,12 @@ static inline void tlb_destroy(CPUState *cpu)
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
 }
-static inline void tlb_flush_page_all_cpus(CPUState *src, vaddr addr)
-{
-}
 static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
 {
 }
 static inline void tlb_flush(CPUState *cpu)
 {
 }
-static inline void tlb_flush_all_cpus(CPUState *src_cpu)
-{
-}
 static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 {
 }
@@ -313,20 +268,11 @@ static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
 static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
 }
-static inline void tlb_flush_page_by_mmuidx_all_cpus(CPUState *cpu,
-                                                     vaddr addr,
-                                                     uint16_t idxmap)
-{
-}
 static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                             vaddr addr,
                                                             uint16_t idxmap)
 {
 }
-static inline void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap)
-{
-}
-
 static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
@@ -337,12 +283,6 @@ static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
                                                  unsigned bits)
 {
 }
-static inline void tlb_flush_page_bits_by_mmuidx_all_cpus(CPUState *cpu,
-                                                          vaddr addr,
-                                                          uint16_t idxmap,
-                                                          unsigned bits)
-{
-}
 static inline void
 tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
                                               uint16_t idxmap, unsigned bits)
@@ -353,13 +293,6 @@ static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
                                              unsigned bits)
 {
 }
-static inline void tlb_flush_range_by_mmuidx_all_cpus(CPUState *cpu,
-                                                      vaddr addr,
-                                                      vaddr len,
-                                                      uint16_t idxmap,
-                                                      unsigned bits)
-{
-}
 static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                              vaddr addr,
                                                              vaddr len,
-- 
2.43.0


