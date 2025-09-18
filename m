Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6C9CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJi9-0001uR-8S; Thu, 18 Sep 2025 14:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi5-0001sK-5X; Thu, 18 Sep 2025 14:50:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJhr-0003GH-Dx; Thu, 18 Sep 2025 14:50:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7541656F326;
 Thu, 18 Sep 2025 20:50:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id xJawOFEBwgGo; Thu, 18 Sep 2025 20:50:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7E48256F325; Thu, 18 Sep 2025 20:50:07 +0200 (CEST)
Message-ID: <967c2416f25efd0162df32f43f8b2d048fe28b8d.1758219840.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1758219840.git.balaton@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 03/14] hw/pci-host/raven: Use DEFINE_TYPES macro
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 18 Sep 2025 20:50:07 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Convert to using DEFINE_TYPES macro and move raven_pcihost_class_init
so methods of each object are grouped together.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 878c915de5..e0f98afebf 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -304,6 +304,15 @@ static void raven_pcihost_initfn(Object *obj)
     h->bus = &s->pci_bus;
 }
 
+static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->realize = raven_pcihost_realizefn;
+    dc->fw_name = "pci";
+}
+
 static void raven_realize(PCIDevice *d, Error **errp)
 {
     d->config[PCI_CACHE_LINE_SIZE] = 0x08;
@@ -329,37 +338,23 @@ static void raven_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo raven_info = {
-    .name = TYPE_RAVEN_PCI_DEVICE,
-    .parent = TYPE_PCI_DEVICE,
-    .class_init = raven_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
+static const TypeInfo raven_types[] = {
+    {
+        .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
+        .parent = TYPE_PCI_HOST_BRIDGE,
+        .instance_size = sizeof(PREPPCIState),
+        .instance_init = raven_pcihost_initfn,
+        .class_init = raven_pcihost_class_init,
+    },
+    {
+        .name = TYPE_RAVEN_PCI_DEVICE,
+        .parent = TYPE_PCI_DEVICE,
+        .class_init = raven_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
     },
 };
 
-static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->realize = raven_pcihost_realizefn;
-    dc->fw_name = "pci";
-}
-
-static const TypeInfo raven_pcihost_info = {
-    .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
-    .parent = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(PREPPCIState),
-    .instance_init = raven_pcihost_initfn,
-    .class_init = raven_pcihost_class_init,
-};
-
-static void raven_register_types(void)
-{
-    type_register_static(&raven_pcihost_info);
-    type_register_static(&raven_info);
-}
-
-type_init(raven_register_types)
+DEFINE_TYPES(raven_types)
-- 
2.41.3


