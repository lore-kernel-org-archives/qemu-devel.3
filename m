Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62160C25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN5m-00079I-GE; Sun, 26 May 2024 19:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5F-0005xv-Gx; Sun, 26 May 2024 19:15:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN5B-0003pv-Lv; Sun, 26 May 2024 19:15:21 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9978E4E62C0;
 Mon, 27 May 2024 01:13:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GlC0iopRgSqx; Mon, 27 May 2024 01:13:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AE5BD4E610B; Mon, 27 May 2024 01:13:05 +0200 (CEST)
Message-Id: <b4c9ea90656039d93660ae4f6bf0d042e1a1e290.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 29/43] target/ppc/mmu-hash32.c: Move get_pteg_offset32() to
 the header
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:05 +0200 (CEST)
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

This function is a simple shared function, move it to other similar
static inline functions in the header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu-hash32.c | 7 -------
 target/ppc/mmu-hash32.h | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index c4de1647e2..44b16142ab 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -201,13 +201,6 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     return false;
 }
 
-hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
-{
-    target_ulong mask = ppc_hash32_hpt_mask(cpu);
-
-    return (hash * HASH_PTEG_SIZE_32) & mask;
-}
-
 static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
                                      bool secondary, target_ulong ptem,
                                      ppc_hash_pte32_t *pte)
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index bd75f7d647..2838de031c 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -3,7 +3,6 @@
 
 #ifndef CONFIG_USER_ONLY
 
-hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash);
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible);
@@ -102,6 +101,11 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
+static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
+{
+    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
+}
+
 static inline bool ppc_hash32_key(bool pr, target_ulong sr)
 {
     return pr ? (sr & SR32_KP) : (sr & SR32_KS);
-- 
2.30.9


