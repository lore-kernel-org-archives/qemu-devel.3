Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655DBC25B74
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Icj-00027k-6x; Sun, 12 May 2024 19:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6IcX-0001sp-EF; Sun, 12 May 2024 19:28:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6IcU-0000Pb-QL; Sun, 12 May 2024 19:28:44 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8156B4E6785;
 Mon, 13 May 2024 01:28:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GCPtUcavqjUj; Mon, 13 May 2024 01:28:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 91F0B4E6780; Mon, 13 May 2024 01:28:15 +0200 (CEST)
Message-Id: <ea7f9d436177b324b36554fc1e96238b3d93bc22.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 41/61] target/ppc/mmu_common.c: Return directly in
 ppc6xx_tlb_pte_check()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:15 +0200 (CEST)
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

Instead of using a local ret variable return directly and remove the
local.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 0c7cbab2bc..a035cefcad 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,9 +98,6 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int pteh,
                                 MMUAccessType access_type)
 {
-    int ret;
-
-    ret = -1;
     /* Check validity and table match */
     if (pte_is_valid(pte0) && ((pte0 >> 6) & 1) == pteh) {
         /* Check vsid & api */
@@ -119,16 +116,15 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
             if (check_prot_access_type(ctx->prot, access_type)) {
                 /* Access granted */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
-                ret = 0;
+                return 0;
             } else {
                 /* Access right violation */
                 qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
-                ret = -2;
+                return -2;
             }
         }
     }
-
-    return ret;
+    return -1;
 }
 
 /* Software driven TLB helpers */
-- 
2.30.9


