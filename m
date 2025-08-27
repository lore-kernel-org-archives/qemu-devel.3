Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D88CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHgj-0002fs-Il; Wed, 27 Aug 2025 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgg-0002dy-78; Wed, 27 Aug 2025 11:03:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHge-0004oT-6s; Wed, 27 Aug 2025 11:03:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE4E414C531;
 Wed, 27 Aug 2025 18:02:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CBE46269839;
 Wed, 27 Aug 2025 18:03:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Stable-10.0.4 09/59] system/physmem: fix use-after-free with dispatch
Date: Wed, 27 Aug 2025 18:02:14 +0300
Message-ID: <20250827150323.2694101-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

A use-after-free bug was reported when booting a Linux kernel during the
pci setup phase. It's quite hard to reproduce (needs smp, and favored by
having several pci devices with BAR and specific Linux config, which
is Debian default one in this case).

After investigation (see the associated bug ticket), it appears that,
under specific conditions, we might access a cached AddressSpaceDispatch
that was reclaimed by RCU thread meanwhile.
In the Linux boot scenario, during the pci phase, memory region are
destroyed/recreated, resulting in exposition of the bug.

The core of the issue is that we cache the dispatch associated to
current cpu in cpu->cpu_ases[asidx].memory_dispatch. It is updated with
tcg_commit, which runs asynchronously on a given cpu.
At some point, we leave the rcu critial section, and the RCU thread
starts reclaiming it, but tcg_commit is not yet invoked, resulting in
the use-after-free.

It's not the first problem around this area, and commit 0d58c660689 [1]
("softmmu: Use async_run_on_cpu in tcg_commit") already tried to
address it. It did a good job, but it seems that we found a specific
situation where it's not enough.

This patch takes a simple approach: remove the cached value creating the
issue, and make sure we always get the current mapping for address
space, using address_space_to_dispatch(cpu->cpu_ases[asidx].as).
It's equivalent to qatomic_rcu_read(&as->current_map)->dispatch;
This is not really costly, we just need two dereferences,
including one atomic (rcu) read, which is negligible considering we are
already on mmu slow path anyway.

Note that tcg_commit is still needed, as it's taking care of flushing
TLB, removing previously mapped entries.

Another solution would be to cache directly values under the dispatch
(dispatch themselves are not ref counted), keep an active reference on
associated memory section, and release it when appropriate (tricky).
Given the time already spent debugging this area now and previously, I
strongly prefer eliminating the root of the issue, instead of adding
more complexity for a hypothetical performance gain. RCU is precisely
used to ensure good performance when reading data, so caching is not as
beneficial as it might seem IMHO.

[1] https://gitlab.com/qemu-project/qemu/-/commit/0d58c660689f6da1e3feff8a997014003d928b3b

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3040
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250724161142.2803091-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2865bf1c5795371ef441e9029bc22566ccff8299)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/physmem.c b/system/physmem.c
index 333a5eb94d..32f5895b80 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -164,13 +164,11 @@ static bool ram_is_cpr_compatible(RAMBlock *rb);
  * CPUAddressSpace: all the information a CPU needs about an AddressSpace
  * @cpu: the CPU whose AddressSpace this is
  * @as: the AddressSpace itself
- * @memory_dispatch: its dispatch pointer (cached, RCU protected)
  * @tcg_as_listener: listener for tracking changes to the AddressSpace
  */
 typedef struct CPUAddressSpace {
     CPUState *cpu;
     AddressSpace *as;
-    struct AddressSpaceDispatch *memory_dispatch;
     MemoryListener tcg_as_listener;
 } CPUAddressSpace;
 
@@ -689,7 +687,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
     IOMMUTLBEntry iotlb;
     int iommu_idx;
     hwaddr addr = orig_addr;
-    AddressSpaceDispatch *d = cpu->cpu_ases[asidx].memory_dispatch;
+    AddressSpaceDispatch *d = address_space_to_dispatch(cpu->cpu_ases[asidx].as);
 
     for (;;) {
         section = address_space_translate_internal(d, addr, &addr, plen, false);
@@ -2673,7 +2671,7 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
 {
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = cpuas->memory_dispatch;
+    AddressSpaceDispatch *d = address_space_to_dispatch(cpuas->as);
     int section_index = index & ~TARGET_PAGE_MASK;
     MemoryRegionSection *ret;
 
@@ -2750,9 +2748,6 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
 
 static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
 {
-    CPUAddressSpace *cpuas = data.host_ptr;
-
-    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
     tlb_flush(cpu);
 }
 
@@ -2768,11 +2763,7 @@ static void tcg_commit(MemoryListener *listener)
     cpu = cpuas->cpu;
 
     /*
-     * Defer changes to as->memory_dispatch until the cpu is quiescent.
-     * Otherwise we race between (1) other cpu threads and (2) ongoing
-     * i/o for the current cpu thread, with data cached by mmu_lookup().
-     *
-     * In addition, queueing the work function will kick the cpu back to
+     * Queueing the work function will kick the cpu back to
      * the main loop, which will end the RCU critical section and reclaim
      * the memory data structures.
      *
-- 
2.47.2


