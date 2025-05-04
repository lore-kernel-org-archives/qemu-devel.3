Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF7C3ABB6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbmc-0004p8-9p; Sun, 04 May 2025 12:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbma-0004oH-5R; Sun, 04 May 2025 12:01:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmY-0004AH-0K; Sun, 04 May 2025 12:01:35 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F72055D235;
 Sun, 04 May 2025 18:01:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pWIEvT65vKHl; Sun,  4 May 2025 18:01:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A5E8E55D233; Sun, 04 May 2025 18:01:27 +0200 (CEST)
Message-ID: <0d41c18a8831bd4c8b0948eda3ef8f60f5a311f3.1746374076.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746374076.git.balaton@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 01/16] hw/pci-host/raven: Remove is-legacy-prep property
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 04 May 2025 18:01:27 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This was a workaround for the prep machine that was removed 5 years
ago so this is no longer needed.

Fixes: b2ce76a073 (hw/ppc/prep: Remove the deprecated "prep" machine
       and the OpenHackware BIOS)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 21f7ca65e0..b78a8f32d3 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -75,7 +75,6 @@ struct PRePPCIState {
     RavenPCIState pci_dev;
 
     int contiguous_map;
-    bool is_legacy_prep;
 };
 
 #define BIOS_SIZE (1 * MiB)
@@ -243,22 +242,18 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     MemoryRegion *address_space_mem = get_system_memory();
     int i;
 
-    if (s->is_legacy_prep) {
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            sysbus_init_irq(dev, &s->pci_irqs[i]);
-        }
-    } else {
-        /* According to PReP specification section 6.1.6 "System Interrupt
-         * Assignments", all PCI interrupts are routed via IRQ 15 */
-        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
-        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
-                                &error_fatal);
-        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
-        sysbus_init_irq(dev, &s->or_irq->out_irq);
-
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
-        }
+    /*
+     * According to PReP specification section 6.1.6 "System Interrupt
+     * Assignments", all PCI interrupts are routed via IRQ 15
+     */
+    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
+    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
+                            &error_fatal);
+    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
+    sysbus_init_irq(dev, &s->or_irq->out_irq);
+
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
     }
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
@@ -426,9 +421,6 @@ static const Property raven_pcihost_properties[] = {
     DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
                        EM_NONE),
     DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
-    /* Temporary workaround until legacy prep machine is removed */
-    DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
-                     false),
 };
 
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-- 
2.41.3


