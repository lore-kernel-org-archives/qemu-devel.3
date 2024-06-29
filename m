Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC26C3065A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 20:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNeGo-0000Dj-49; Sat, 29 Jun 2024 16:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sNeGm-0000BV-5t
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 16:02:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sNeGk-0004fo-2t
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 16:01:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1B2614E600F;
 Sat, 29 Jun 2024 22:01:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Dbt-uUYqderj; Sat, 29 Jun 2024 22:01:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 24F7A4E6005; Sat, 29 Jun 2024 22:01:54 +0200 (CEST)
Message-Id: <b70b9e72063b4dd4005bf4bc040b84f2bb617bf4.1719690591.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1719690591.git.balaton@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/2] hw/isa/vt82c686.c: Embed i8259 irq in device state
 instead of allocating
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jun 2024 22:01:54 +0200 (CEST)
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

To avoid a warning about unfreed qemu_irq embed the i8259 irq in the
device state instead of allocating it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/vt82c686.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8582ac0322..834051abeb 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -592,6 +592,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaISAState, VIA_ISA)
 
 struct ViaISAState {
     PCIDevice dev;
+
+    IRQState i8259_irq;
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
     uint16_t irq_state[ISA_NUM_IRQS];
@@ -715,13 +717,12 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     ViaISAState *s = VIA_ISA(d);
     DeviceState *dev = DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
-    qemu_irq *isa_irq;
     ISABus *isa_bus;
     int i;
 
     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
-    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
+    qemu_init_irq(&s->i8259_irq, via_isa_request_i8259_irq, s, 0);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
 
@@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
+    s->isa_irqs_in = i8259_init(isa_bus, &s->i8259_irq);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);
-- 
2.30.9


