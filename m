Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A0EC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ALA-0000Je-DU; Thu, 09 May 2024 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AL8-0000HU-5n; Thu, 09 May 2024 16:26:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AL4-000175-CJ; Thu, 09 May 2024 16:26:05 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CEED24E65D6;
 Thu, 09 May 2024 22:25:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 6teW5-2nb_Jm; Thu,  9 May 2024 22:25:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DF8CF4E65CE; Thu, 09 May 2024 22:25:57 +0200 (CEST)
Message-Id: <f08537bb9beeb07d8017adc9ec34f7d54848dbc5.1715285340.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715285340.git.balaton@eik.bme.hu>
References: <cover.1715285340.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 23/32] target/ppc/mmu_common.c: Move mmu_ctx_t type to
 mmu_common.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 22:25:57 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

Remove mmu_ctx_t definition from internal.h as this type is only used
within mmu_common.c.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/internal.h   | 12 ------------
 target/ppc/mmu_common.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 5b28e8f3b0..46176c4711 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -292,8 +292,6 @@ static inline int ppc_hash32_pp_prot(int key, int pp, int nx)
     return nx ? prot : prot | PAGE_EXEC;
 }
 
-typedef struct mmu_ctx_t mmu_ctx_t;
-
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
@@ -301,16 +299,6 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
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
index d7e4baa9cf..1ff2afdea7 100644
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
-- 
2.30.9


