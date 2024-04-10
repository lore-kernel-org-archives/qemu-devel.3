Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CC2CD1284
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 22:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rugOB-0007oM-9p; Wed, 10 Apr 2024 18:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rugO8-0007o0-0I; Wed, 10 Apr 2024 18:25:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rugO5-0005Ng-Tg; Wed, 10 Apr 2024 18:25:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 012B14E601C;
 Thu, 11 Apr 2024 00:25:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BVpgzSltNPMx; Thu, 11 Apr 2024 00:25:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0EA534E6005; Thu, 11 Apr 2024 00:25:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
Message-Id: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Date: Thu, 11 Apr 2024 00:25:43 +0200 (CEST)
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

Move calculation of mask after the switch which sets the function
number for PIRQ/PINT pins to make sure the state of these pins are
kept track of separately and IRQ is raised if any of them is active.

Fixes: 7e01bd80c1 hw/isa/vt82c686: Bring back via_isa_set_irq()
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Preferably for 9.0 if there will be another RC.

 hw/isa/vt82c686.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index aa91942745..8582ac0322 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -658,7 +658,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     ViaISAState *s = VIA_ISA(pci_get_function_0(d));
     uint8_t irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
     int f = PCI_FUNC(d->devfn);
-    uint16_t mask = BIT(f);
+    uint16_t mask;
 
     switch (f) {
     case 0: /* PIRQ/PINT inputs */
@@ -673,6 +673,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     }
 
     /* Keep track of the state of all sources */
+    mask = BIT(f);
     if (level) {
         s->irq_state[0] |= mask;
     } else {
-- 
2.30.9


