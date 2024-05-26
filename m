Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F77C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN61-0000f3-0D; Sun, 26 May 2024 19:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5c-0006vH-Ui; Sun, 26 May 2024 19:15:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5Z-00044q-OP; Sun, 26 May 2024 19:15:44 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DB7C54E650C;
 Mon, 27 May 2024 01:13:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id j-v2DiMr42Eg; Mon, 27 May 2024 01:13:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F1FEA4E654D; Mon, 27 May 2024 01:13:12 +0200 (CEST)
Message-Id: <3b3cce4a39e0debbf6fa29d4a2ead3014898cb93.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 36/43] target/ppc/mmu-hash32: Remove some static inlines from
 header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:12 +0200 (CEST)
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

Two of these are not used anywhere and the other two are used only
once and can be inlined and removed from the header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c |  5 +++--
 target/ppc/mmu-hash32.h | 32 --------------------------------
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index a2c0ac05d2..7a6a674f8a 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -206,17 +206,18 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
 {
     hwaddr pte_offset = pteg_off;
     target_ulong pte0, pte1;
+    hwaddr base = ppc_hash32_hpt_base(cpu);
     int i;
 
     for (i = 0; i < HPTES_PER_GROUP; i++) {
-        pte0 = ppc_hash32_load_hpte0(cpu, pte_offset);
+        pte0 = ldl_phys(CPU(cpu)->as, base + pte_offset);
         /*
          * pte0 contains the valid bit and must be read before pte1,
          * otherwise we might see an old pte1 with a new valid bit and
          * thus an inconsistent hpte value
          */
         smp_rmb();
-        pte1 = ppc_hash32_load_hpte1(cpu, pte_offset);
+        pte1 = ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
 
         if ((pte0 & HPTE32_V_VALID)
             && (secondary == !!(pte0 & HPTE32_V_SECONDARY))
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 2838de031c..4db55fb0a0 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -69,38 +69,6 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
     return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
 }
 
-static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
-                                                 hwaddr pte_offset)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    return ldl_phys(CPU(cpu)->as, base + pte_offset);
-}
-
-static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
-                                                 hwaddr pte_offset)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
-}
-
-static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte0)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
-}
-
-static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte1)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
-}
-
 static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
 {
     return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
-- 
2.30.9


