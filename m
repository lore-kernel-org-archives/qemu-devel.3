Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791BBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qps-0003Um-9l; Wed, 08 May 2024 19:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpr-0003UD-0t; Wed, 08 May 2024 19:36:31 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpp-0002c4-D0; Wed, 08 May 2024 19:36:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F1B8B4E65D4;
 Thu, 09 May 2024 01:36:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 5RzRLly0TKCY; Thu,  9 May 2024 01:36:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0AA494E65D6; Thu, 09 May 2024 01:36:26 +0200 (CEST)
Message-Id: <398c274f9759cf2587088b6e2b0f45e560e2e3c9.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 22/33] target/ppc/mmu_common.c: Make
 get_physical_address_wtlb() static
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:26 +0200 (CEST)
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

This function is not used from any other files so make it static and
fix the maybe used uninitialised warnings this has uncovered. Also
remove mmu_ctx_t definition from internal.h as this type is only used
within this file.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h   | 17 +----------------
 target/ppc/mmu_common.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 98b41a970c..4a90dd2584 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -257,28 +257,13 @@ static inline int prot_for_access_type(MMUAccessType access_type)
 
 /* PowerPC MMU emulation */
 
-typedef struct mmu_ctx_t mmu_ctx_t;
-
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
-                                     target_ulong eaddr,
-                                     MMUAccessType access_type, int type,
-                                     int mmu_idx);
+
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
-/* Context used internally during MMU translations */
-struct mmu_ctx_t {
-    hwaddr raddr;      /* Real address              */
-    hwaddr eaddr;      /* Effective address         */
-    int prot;                      /* Protection bits           */
-    hwaddr hash[2];    /* Pagetable hash values     */
-    target_ulong ptem;             /* Virtual segment ID | API  */
-    int key;                       /* Access key                */
-    int nx;                        /* Non-execute area          */
-};
 
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index bffa06455d..2a7b4a275c 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -36,6 +36,17 @@
 
 /* #define DUMP_PAGE_TABLES */
 
+/* Context used internally during MMU translations */
+typedef struct {
+    hwaddr raddr;      /* Real address             */
+    hwaddr eaddr;      /* Effective address        */
+    int prot;          /* Protection bits          */
+    hwaddr hash[2];    /* Pagetable hash values    */
+    target_ulong ptem; /* Virtual segment ID | API */
+    int key;           /* Access key               */
+    int nx;            /* Non-execute area         */
+} mmu_ctx_t;
+
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -653,7 +664,7 @@ static int mmubooke_get_physical_address(CPUPPCState *env, hwaddr *raddr,
     qemu_log_mask(CPU_LOG_MMU,
                   "%s: access %s " TARGET_FMT_lx " => " HWADDR_FMT_plx
                   " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
-                  address, ret < 0 ? -1 : *raddr, *prot, ret);
+                  address, ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
     return ret;
 }
 
@@ -865,7 +876,7 @@ found_tlb:
     qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " => "
                   HWADDR_FMT_plx " %d %d\n", __func__,
                   ret < 0 ? "refused" : "granted", address,
-                  ret < 0 ? -1 : *raddr, *prot, ret);
+                  ret < 0 ? -1 : *raddr, ret == -1 ? 0 : *prot, ret);
     return ret;
 }
 
@@ -1113,7 +1124,7 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
+static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      target_ulong eaddr,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
-- 
2.30.9


