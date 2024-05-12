Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD78C25B74
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Id7-0002p0-9W; Sun, 12 May 2024 19:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icf-00021D-2k; Sun, 12 May 2024 19:28:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icd-0000Ri-A4; Sun, 12 May 2024 19:28:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 17B764E678C;
 Mon, 13 May 2024 01:28:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id jAeRcyTP1tBo; Mon, 13 May 2024 01:28:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2A86C4E678D; Mon, 13 May 2024 01:28:27 +0200 (CEST)
Message-Id: <d57adbc137f68713cc34a2982ed414f82c6ffaa0.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 52/61] target/ppc/mmu-hash32.c: Inline and remove
 ppc_hash32_pte_prot()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:27 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This is used only once and can be inlined.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8e5e83f46a..9de42713b3 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -37,17 +37,6 @@
 #  define LOG_BATS(...) do { } while (0)
 #endif
 
-static int ppc_hash32_pte_prot(int mmu_idx,
-                               target_ulong sr, ppc_hash_pte32_t pte)
-{
-    unsigned pp, key;
-
-    key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
-    pp = pte.pte1 & HPTE32_R_PP;
-
-    return ppc_hash32_pp_prot(key, pp, !!(sr & SR32_NX));
-}
-
 static target_ulong hash32_bat_size(int mmu_idx,
                                     target_ulong batu, target_ulong batl)
 {
@@ -341,10 +330,10 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong sr;
-    hwaddr pte_offset;
+    hwaddr pte_offset, raddr;
     ppc_hash_pte32_t pte;
+    bool key;
     int prot;
-    hwaddr raddr;
 
     /* There are no hash32 large pages. */
     *psizep = TARGET_PAGE_BITS;
@@ -426,8 +415,8 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                 "found PTE at offset %08" HWADDR_PRIx "\n", pte_offset);
 
     /* 7. Check access permissions */
-
-    prot = ppc_hash32_pte_prot(mmu_idx, sr, pte);
+    key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
+    prot = ppc_hash32_pp_prot(key, pte.pte1 & HPTE32_R_PP, sr & SR32_NX);
 
     if (!check_prot_access_type(prot, access_type)) {
         /* Access right violation */
-- 
2.30.9


