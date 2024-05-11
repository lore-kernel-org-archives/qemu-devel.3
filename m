Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFED3C25B4F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 01:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bpn-00082K-Pc; Fri, 10 May 2024 21:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boz-0005DR-9k; Fri, 10 May 2024 21:46:46 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5bow-0003dl-OS; Fri, 10 May 2024 21:46:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D37004E6780;
 Sat, 11 May 2024 03:46:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 8QrpoOPaeAb5; Sat, 11 May 2024 03:46:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E747C4E6787; Sat, 11 May 2024 03:46:18 +0200 (CEST)
Message-Id: <7a2474d0ece64754262aa08652ef2f32f76166c2.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 38/48] target/ppc/mmu_common.c: Remove single use local
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:46:18 +0200 (CEST)
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

The ptev variable in ppc6xx_tlb_pte_check() is used only once and just
obfuscates an otherwise clear value. Get rid of it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 4ca700e31b..b25c77c618 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -98,13 +98,12 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, target_ulong pte0,
                                 target_ulong pte1, int h,
                                 MMUAccessType access_type)
 {
-    int ret, pteh, ptev, pp;
+    int ret, pteh, pp;
 
     ret = -1;
     /* Check validity and table match */
-    ptev = pte_is_valid(pte0);
     pteh = (pte0 >> 6) & 1;
-    if (ptev && h == pteh) {
+    if (pte_is_valid(pte0) && h == pteh) {
         /* Check vsid & api */
         pp = pte1 & 0x00000003;
         if ((pte0 & PTE_PTEM_MASK) == ctx->ptem) {
-- 
2.30.9


