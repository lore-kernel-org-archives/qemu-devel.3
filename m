Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECFDC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5AKs-000095-RH; Thu, 09 May 2024 16:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKo-000050-Vy; Thu, 09 May 2024 16:25:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKl-0000zZ-80; Thu, 09 May 2024 16:25:46 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9AE24E64E0;
 Thu, 09 May 2024 22:25:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XQRdMptdwpqP; Thu,  9 May 2024 22:25:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D70084E642D; Thu, 09 May 2024 22:25:36 +0200 (CEST)
Message-Id: <f8f211b3d88d681f4a2f555acb5cc491b058e00c.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 03/32] target/ppc/mmu_common.c: Remove unneeded local
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:36 +0200 (CEST)
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

In mmubooke_check_tlb() and mmubooke206_check_tlb() we can assign the
value of prot2 directly to the destination, no need to have a separate
local variable for it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index f79e390306..09cbeb0052 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -628,8 +628,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
                               hwaddr *raddr, int *prot, target_ulong address,
                               MMUAccessType access_type, int i)
 {
-    int prot2;
-
     if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__);
         return -1;
@@ -644,17 +642,16 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
     }
 
     if (FIELD_EX64(env->msr, MSR, PR)) {
-        prot2 = tlb->prot & 0xF;
+        *prot = tlb->prot & 0xF;
     } else {
-        prot2 = (tlb->prot >> 4) & 0xF;
+        *prot = (tlb->prot >> 4) & 0xF;
     }
-    *prot = prot2;
-    if (prot2 & prot_for_access_type(access_type)) {
+    if (*prot & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot2);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
@@ -795,7 +792,6 @@ static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
                                  target_ulong address,
                                  MMUAccessType access_type, int mmu_idx)
 {
-    int prot2 = 0;
     uint32_t epid;
     bool as, pr;
     bool use_epid = mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
@@ -841,34 +837,34 @@ found_tlb:
         return -1;
     }
 
+    *prot = 0;
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
-            prot2 |= PAGE_READ;
+            *prot |= PAGE_READ;
         }
         if (tlb->mas7_3 & MAS3_UW) {
-            prot2 |= PAGE_WRITE;
+            *prot |= PAGE_WRITE;
         }
         if (tlb->mas7_3 & MAS3_UX) {
-            prot2 |= PAGE_EXEC;
+            *prot |= PAGE_EXEC;
         }
     } else {
         if (tlb->mas7_3 & MAS3_SR) {
-            prot2 |= PAGE_READ;
+            *prot |= PAGE_READ;
         }
         if (tlb->mas7_3 & MAS3_SW) {
-            prot2 |= PAGE_WRITE;
+            *prot |= PAGE_WRITE;
         }
         if (tlb->mas7_3 & MAS3_SX) {
-            prot2 |= PAGE_EXEC;
+            *prot |= PAGE_EXEC;
         }
     }
-    *prot = prot2;
-    if (prot2 & prot_for_access_type(access_type)) {
+    if (*prot & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
         return 0;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot2);
+    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *prot);
     return access_type == MMU_INST_FETCH ? -3 : -2;
 }
 
-- 
2.30.9


