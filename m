Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD206C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5r-0007qo-W5; Sun, 26 May 2024 19:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5d-0006vJ-DC; Sun, 26 May 2024 19:15:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5Z-00045j-OL; Sun, 26 May 2024 19:15:44 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F08934E654E;
 Mon, 27 May 2024 01:13:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RrLNxIXFc22e; Mon, 27 May 2024 01:13:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0F2B94E654F; Mon, 27 May 2024 01:13:15 +0200 (CEST)
Message-Id: <c2365f41612f7898ab57a4a85e1028eba3a5244b.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 38/43] target/ppc/mmu-hash32.c: Use pte address as parameter
 instead of offset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:15 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of getting base and adding an offset to it pass pte address to
ppc_hash32_pteg_search() that the only caller of this function already
has and can easily pass it. Also add a local variable in the caller to
avoid getting base multiple times.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index cc1e790d0e..6d0adf3357 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -200,11 +200,10 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     return false;
 }
 
-static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
+static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pte_addr,
                                      bool secondary, target_ulong ptem,
                                      ppc_hash_pte32_t *pte)
 {
-    hwaddr pte_addr = ppc_hash32_hpt_base(cpu) + pteg_off;
     target_ulong pte0, pte1;
     int i;
 
@@ -245,37 +244,35 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
                                      target_ulong sr, target_ulong eaddr,
                                      ppc_hash_pte32_t *pte)
 {
-    hwaddr pteg_off, pte_addr;
-    hwaddr hash;
+    hwaddr hpt_base, pteg_off, pte_addr, hash;
     uint32_t vsid, pgidx, ptem;
 
+    hpt_base = ppc_hash32_hpt_base(cpu);
     vsid = sr & SR32_VSID;
     pgidx = (eaddr & ~SEGMENT_MASK_256M) >> TARGET_PAGE_BITS;
     hash = vsid ^ pgidx;
     ptem = (vsid << 7) | (pgidx >> 10);
 
     /* Page address translation */
-    qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx
-            " htab_mask " HWADDR_FMT_plx
-            " hash " HWADDR_FMT_plx "\n",
-            ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
+    qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
+                  HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
+                  hpt_base, ppc_hash32_hpt_mask(cpu), hash);
 
     /* Primary PTEG lookup */
     qemu_log_mask(CPU_LOG_MMU, "0 htab=" HWADDR_FMT_plx "/" HWADDR_FMT_plx
-            " vsid=%" PRIx32 " ptem=%" PRIx32
-            " hash=" HWADDR_FMT_plx "\n",
-            ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu),
-            vsid, ptem, hash);
+                  " vsid=%" PRIx32 " ptem=%" PRIx32 " hash=" HWADDR_FMT_plx
+                  "\n", hpt_base, ppc_hash32_hpt_mask(cpu), vsid, ptem, hash);
     pteg_off = get_pteg_offset32(cpu, hash);
-    pte_addr = ppc_hash32_pteg_search(cpu, pteg_off, 0, ptem, pte);
+    pte_addr = ppc_hash32_pteg_search(cpu, hpt_base + pteg_off, 0, ptem, pte);
     if (pte_addr == -1) {
         /* Secondary PTEG lookup */
         qemu_log_mask(CPU_LOG_MMU, "1 htab=" HWADDR_FMT_plx "/" HWADDR_FMT_plx
-                " vsid=%" PRIx32 " api=%" PRIx32
-                " hash=" HWADDR_FMT_plx "\n", ppc_hash32_hpt_base(cpu),
-                ppc_hash32_hpt_mask(cpu), vsid, ptem, ~hash);
+                      " vsid=%" PRIx32 " api=%" PRIx32 " hash=" HWADDR_FMT_plx
+                      "\n", hpt_base, ppc_hash32_hpt_mask(cpu), vsid, ptem,
+                      ~hash);
         pteg_off = get_pteg_offset32(cpu, ~hash);
-        pte_addr = ppc_hash32_pteg_search(cpu, pteg_off, 1, ptem, pte);
+        pte_addr = ppc_hash32_pteg_search(cpu, hpt_base + pteg_off, 1, ptem,
+                                          pte);
     }
 
     return pte_addr;
-- 
2.30.9


