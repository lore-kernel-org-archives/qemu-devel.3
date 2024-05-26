Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED7DC25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5x-0000Ca-Ah; Sun, 26 May 2024 19:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5F-0005vP-4I; Sun, 26 May 2024 19:15:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN59-0003p7-QZ; Sun, 26 May 2024 19:15:20 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 214744E65BB;
 Mon, 27 May 2024 01:13:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Dt0MGdRpJTOr; Mon, 27 May 2024 01:13:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3626B4E6553; Mon, 27 May 2024 01:13:19 +0200 (CEST)
Message-Id: <3d172d929eb90042d9afb18096a7300759a70b8f.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 42/43] target/ppc/mmu-hash32.c: Change parameter type of
 ppc_hash32_set_[rc]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:19 +0200 (CEST)
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

These functions need AddressSpace from CPUState but take PowerPCCPU
instead and cast that. We have the right type in the caller so change
the parameter type and pass the needed value to avoid casting.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 82a02881c2..0f9c61bf89 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -228,16 +228,18 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pte_addr,
     return -1;
 }
 
-static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_addr, uint32_t pte1)
+static void ppc_hash32_set_r(AddressSpace *cpu_as, hwaddr pte_addr,
+                             uint32_t pte1)
 {
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, pte_addr + 6, ((pte1 >> 8) & 0xff) | 0x01);
+    stb_phys(cpu_as, pte_addr + 6, ((pte1 >> 8) & 0xff) | 0x01);
 }
 
-static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_addr, uint64_t pte1)
+static void ppc_hash32_set_c(AddressSpace *cpu_as, hwaddr pte_addr,
+                             uint64_t pte1)
 {
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, pte_addr + 7, (pte1 & 0xff) | 0x80);
+    stb_phys(cpu_as, pte_addr + 7, (pte1 & 0xff) | 0x80);
 }
 
 static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
@@ -399,11 +401,11 @@ bool ppc_hash32_xlate(CPUState *cs, vaddr eaddr, MMUAccessType access_type,
 
     /* 8. Update PTE referenced and changed bits if necessary */
     if (!(pte.pte1 & HPTE32_R_R)) {
-        ppc_hash32_set_r(cpu, pte_addr, pte.pte1);
+        ppc_hash32_set_r(cs->as, pte_addr, pte.pte1);
     }
     if (!(pte.pte1 & HPTE32_R_C)) {
         if (access_type == MMU_DATA_STORE) {
-            ppc_hash32_set_c(cpu, pte_addr, pte.pte1);
+            ppc_hash32_set_c(cs->as, pte_addr, pte.pte1);
         } else {
             /*
              * Treat the page as read-only for now, so that a later write
-- 
2.30.9


