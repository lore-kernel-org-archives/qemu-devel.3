Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4347CC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5r-0007zf-Uu; Sun, 26 May 2024 19:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5M-0006Ne-FV; Sun, 26 May 2024 19:15:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN54-0003oE-R7; Sun, 26 May 2024 19:15:26 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E788F4E654D;
 Mon, 27 May 2024 01:13:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YMI36CiXv3rD; Mon, 27 May 2024 01:13:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 071B24E654E; Mon, 27 May 2024 01:13:14 +0200 (CEST)
Message-Id: <4aaf949d46cae9fa8e1a20b29492262d874897af.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 37/43] target/ppc/mmu-hash32.c: Return and use pte address
 instead of base + offset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:14 +0200 (CEST)
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

Change ppc_hash32_pteg_search() to return pte address instead of an
offset to avoid needing to get the base and add offset to it when we
already have the address we need.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 51 ++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 7a6a674f8a..cc1e790d0e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -204,58 +204,48 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
                                      bool secondary, target_ulong ptem,
                                      ppc_hash_pte32_t *pte)
 {
-    hwaddr pte_offset = pteg_off;
+    hwaddr pte_addr = ppc_hash32_hpt_base(cpu) + pteg_off;
     target_ulong pte0, pte1;
-    hwaddr base = ppc_hash32_hpt_base(cpu);
     int i;
 
-    for (i = 0; i < HPTES_PER_GROUP; i++) {
-        pte0 = ldl_phys(CPU(cpu)->as, base + pte_offset);
+    for (i = 0; i < HPTES_PER_GROUP; i++, pte_addr += HASH_PTE_SIZE_32) {
+        pte0 = ldl_phys(CPU(cpu)->as, pte_addr);
         /*
          * pte0 contains the valid bit and must be read before pte1,
          * otherwise we might see an old pte1 with a new valid bit and
          * thus an inconsistent hpte value
          */
         smp_rmb();
-        pte1 = ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
+        pte1 = ldl_phys(CPU(cpu)->as, pte_addr + HASH_PTE_SIZE_32 / 2);
 
         if ((pte0 & HPTE32_V_VALID)
             && (secondary == !!(pte0 & HPTE32_V_SECONDARY))
             && HPTE32_V_COMPARE(pte0, ptem)) {
             pte->pte0 = pte0;
             pte->pte1 = pte1;
-            return pte_offset;
+            return pte_addr;
         }
-
-        pte_offset += HASH_PTE_SIZE_32;
     }
-
     return -1;
 }
 
-static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_t pte1)
+static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_addr, uint32_t pte1)
 {
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-    hwaddr offset = pte_offset + 6;
-
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
+    stb_phys(CPU(cpu)->as, pte_addr + 6, ((pte1 >> 8) & 0xff) | 0x01);
 }
 
-static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_t pte1)
+static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_addr, uint64_t pte1)
 {
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-    hwaddr offset = pte_offset + 7;
-
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
+    stb_phys(CPU(cpu)->as, pte_addr + 7, (pte1 & 0xff) | 0x80);
 }
 
 static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
                                      target_ulong sr, target_ulong eaddr,
                                      ppc_hash_pte32_t *pte)
 {
-    hwaddr pteg_off, pte_offset;
+    hwaddr pteg_off, pte_addr;
     hwaddr hash;
     uint32_t vsid, pgidx, ptem;
 
@@ -277,18 +267,18 @@ static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
             ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu),
             vsid, ptem, hash);
     pteg_off = get_pteg_offset32(cpu, hash);
-    pte_offset = ppc_hash32_pteg_search(cpu, pteg_off, 0, ptem, pte);
-    if (pte_offset == -1) {
+    pte_addr = ppc_hash32_pteg_search(cpu, pteg_off, 0, ptem, pte);
+    if (pte_addr == -1) {
         /* Secondary PTEG lookup */
         qemu_log_mask(CPU_LOG_MMU, "1 htab=" HWADDR_FMT_plx "/" HWADDR_FMT_plx
                 " vsid=%" PRIx32 " api=%" PRIx32
                 " hash=" HWADDR_FMT_plx "\n", ppc_hash32_hpt_base(cpu),
                 ppc_hash32_hpt_mask(cpu), vsid, ptem, ~hash);
         pteg_off = get_pteg_offset32(cpu, ~hash);
-        pte_offset = ppc_hash32_pteg_search(cpu, pteg_off, 1, ptem, pte);
+        pte_addr = ppc_hash32_pteg_search(cpu, pteg_off, 1, ptem, pte);
     }
 
-    return pte_offset;
+    return pte_addr;
 }
 
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
@@ -298,7 +288,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong sr;
-    hwaddr pte_offset, raddr;
+    hwaddr pte_addr, raddr;
     ppc_hash_pte32_t pte;
     bool key;
     int prot;
@@ -360,8 +350,8 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     }
 
     /* 6. Locate the PTE in the hash table */
-    pte_offset = ppc_hash32_htab_lookup(cpu, sr, eaddr, &pte);
-    if (pte_offset == -1) {
+    pte_addr = ppc_hash32_htab_lookup(cpu, sr, eaddr, &pte);
+    if (pte_addr == -1) {
         if (guest_visible) {
             if (access_type == MMU_INST_FETCH) {
                 cs->exception_index = POWERPC_EXCP_ISI;
@@ -380,7 +370,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
         return false;
     }
     qemu_log_mask(CPU_LOG_MMU,
-                "found PTE at offset %08" HWADDR_PRIx "\n", pte_offset);
+                  "found PTE at address %08" HWADDR_PRIx "\n", pte_addr);
 
     /* 7. Check access permissions */
     key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
@@ -410,13 +400,12 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
 
     /* 8. Update PTE referenced and changed bits if necessary */
-
     if (!(pte.pte1 & HPTE32_R_R)) {
-        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
+        ppc_hash32_set_r(cpu, pte_addr, pte.pte1);
     }
     if (!(pte.pte1 & HPTE32_R_C)) {
         if (access_type == MMU_DATA_STORE) {
-            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
+            ppc_hash32_set_c(cpu, pte_addr, pte.pte1);
         } else {
             /*
              * Treat the page as read-only for now, so that a later write
-- 
2.30.9


