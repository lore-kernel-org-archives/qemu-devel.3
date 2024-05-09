Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCBFC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5AKq-000060-2k; Thu, 09 May 2024 16:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKn-0008WF-Je; Thu, 09 May 2024 16:25:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AKl-0000yT-8A; Thu, 09 May 2024 16:25:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C1AA44E646F;
 Thu, 09 May 2024 22:25:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YFiQF8NAHSEJ; Thu,  9 May 2024 22:25:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CC6534E6106; Thu, 09 May 2024 22:25:35 +0200 (CEST)
Message-Id: <9a0b54cedae03047a65ca2329a75b6970ade59a4.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 02/32] target/ppc/mmu_common.c: Move calculation of a value
 closer to its usage
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:35 +0200 (CEST)
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

In mmubooke_check_tlb() and mmubooke206_check_tlb() prot2 is
calculated first but only used after an unrelated check that can
return before tha value is used. Move the calculation after the check,
closer to where it is used, to keep them together and avoid computing
it when not needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviwed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 4fde7fd3bf..f79e390306 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -635,12 +635,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
         return -1;
     }
 
-    if (FIELD_EX64(env->msr, MSR, PR)) {
-        prot2 = tlb->prot & 0xF;
-    } else {
-        prot2 = (tlb->prot >> 4) & 0xF;
-    }
-
     /* Check the address space */
     if ((access_type == MMU_INST_FETCH ?
         FIELD_EX64(env->msr, MSR, IR) :
@@ -649,6 +643,11 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
         return -1;
     }
 
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        prot2 = tlb->prot & 0xF;
+    } else {
+        prot2 = (tlb->prot >> 4) & 0xF;
+    }
     *prot = prot2;
     if (prot2 & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
@@ -830,6 +829,18 @@ static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
 
 found_tlb:
 
+    /* Check the address space and permissions */
+    if (access_type == MMU_INST_FETCH) {
+        /* There is no way to fetch code using epid load */
+        assert(!use_epid);
+        as = FIELD_EX64(env->msr, MSR, IR);
+    }
+
+    if (as != ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
+        return -1;
+    }
+
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
             prot2 |= PAGE_READ;
@@ -851,19 +862,6 @@ found_tlb:
             prot2 |= PAGE_EXEC;
         }
     }
-
-    /* Check the address space and permissions */
-    if (access_type == MMU_INST_FETCH) {
-        /* There is no way to fetch code using epid load */
-        assert(!use_epid);
-        as = FIELD_EX64(env->msr, MSR, IR);
-    }
-
-    if (as != ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
-        return -1;
-    }
-
     *prot = prot2;
     if (prot2 & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
-- 
2.30.9


