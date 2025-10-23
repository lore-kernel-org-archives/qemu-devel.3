Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E6DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxD2-0005ro-UX; Thu, 23 Oct 2025 11:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxCw-0005o6-JW; Thu, 23 Oct 2025 11:26:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBxCt-00018c-TH; Thu, 23 Oct 2025 11:26:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B00355972E1;
 Thu, 23 Oct 2025 17:26:24 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4zbIEp4x2pqS; Thu, 23 Oct 2025 17:26:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AF2E65972ED; Thu, 23 Oct 2025 17:26:22 +0200 (CEST)
Message-ID: <3c4cb144c24a2a729669549c4c0e6e47d230e68e.1761232472.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 02/13] hw/pci-host/raven: Simplify PCI facing part
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 23 Oct 2025 17:26:22 +0200 (CEST)
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

The raven PCI device does not need a state struct as it has no data to
store there any more, so we can remove that to simplify code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c0492d1456..fa76e5170c 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -31,7 +31,6 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
 #include "hw/or-irq.h"
@@ -40,12 +39,6 @@
 #define TYPE_RAVEN_PCI_DEVICE "raven"
 #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
 
-OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
-
-struct RavenPCIState {
-    PCIDevice dev;
-};
-
 typedef struct PRePPCIState PREPPCIState;
 DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
                          TYPE_RAVEN_PCI_HOST_BRIDGE)
@@ -312,16 +305,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[PCI_CAPABILITY_LIST] = 0x00;
 }
 
-static const VMStateDescription vmstate_raven = {
-    .name = "raven",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, RavenPCIState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
 static void raven_class_init(ObjectClass *klass, const void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -333,7 +316,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
     k->revision = 0x00;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
     dc->desc = "PReP Host Bridge - Motorola Raven";
-    dc->vmsd = &vmstate_raven;
     /*
      * Reason: PCI-facing part of the host bridge, not usable without
      * the host-facing part, which can't be device_add'ed, yet.
@@ -344,7 +326,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo raven_info = {
     .name = TYPE_RAVEN_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(RavenPCIState),
     .class_init = raven_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.41.3


