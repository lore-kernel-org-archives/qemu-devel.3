Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD089C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IdM-0003l8-Bq; Sun, 12 May 2024 19:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icu-0002Gs-6D; Sun, 12 May 2024 19:29:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ics-0000W0-Ks; Sun, 12 May 2024 19:29:07 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86C6E4E65C8;
 Mon, 13 May 2024 01:28:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KIZAJznwpzQx; Mon, 13 May 2024 01:28:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 968814E65C6; Mon, 13 May 2024 01:28:36 +0200 (CEST)
Message-Id: <7b7f74372f1e8fd9dbe9ebac95f68bc79191f851.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 61/61] target/ppc/mmu_common.c: Remove a local variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:36 +0200 (CEST)
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

In mmu6xx_get_physical_address() the cpu variable is only used for
debug logging which is normally disabled. Inline the value and remove
local variable to avoid computing it when not needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 51ef59cdf1..5d944ced07 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -263,7 +263,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
                                        hwaddr *hashp, bool *keyp,
                                        MMUAccessType access_type, int type)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
     hwaddr hash;
     target_ulong vsid, sr, pgidx, ptem;
     bool key, ds, nx;
@@ -305,7 +304,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
         /* Page address translation */
         qemu_log_mask(CPU_LOG_MMU, "htab_base " HWADDR_FMT_plx " htab_mask "
                       HWADDR_FMT_plx " hash " HWADDR_FMT_plx "\n",
-                      ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
+                      ppc_hash32_hpt_base(env_archcpu(env)),
+                      ppc_hash32_hpt_mask(env_archcpu(env)), hash);
         *hashp = hash;
 
         /* Software TLB search */
-- 
2.30.9


