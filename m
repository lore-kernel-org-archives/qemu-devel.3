Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4033C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8z6o-0000XR-BZ; Tue, 22 Sep 2026 07:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8z6l-0000XD-Aa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 07:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8z6j-0003Mb-8p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 07:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790078179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pVCgw0wPygjBTIaqMmVrSbeA8amhWhBeh4imNY++Sng=;
 b=Nena1Sj4V4SwfC4bAP67rYN6PhslaoQU4D4cK9TeszsrUy3wwjnd788fA7clRFDNRkkSQW
 eaelkam4sDEe/74Gh7kFLzxOuRvV1x//JUXSiQqhM8q2CY1K0wI4pwhdsD9B5niwQi5IPO
 OPKbrq9G1p88MtXlZDkwVMzFY6VvAS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-y08WbYFYOvWBzItFMoX9lA-1; Tue,
 22 Sep 2026 07:56:17 -0400
X-MC-Unique: y08WbYFYOvWBzItFMoX9lA-1
X-Mimecast-MFC-AGG-ID: y08WbYFYOvWBzItFMoX9lA_1790078176
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 952C4195395D
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:56:16 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CE92300106A; Tue, 22 Sep 2026 11:56:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/pci-bridge: honour CONFIG_CXL in PXB
Date: Tue, 22 Sep 2026 12:56:13 +0100
Message-ID: <20260922115613.1926083-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If CONFIG_CXL=n is added to the Kconfig, the build fails to link
the PXB device:

/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'

Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e082..8977243a804 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -123,12 +123,14 @@ static const TypeInfo pxb_pcie_bus_info = {
     .class_init    = pxb_bus_class_init,
 };
 
+#ifdef CONFIG_CXL
 static const TypeInfo pxb_cxl_bus_info = {
     .name          = TYPE_PXB_CXL_BUS,
     .parent        = TYPE_CXL_BUS,
     .instance_size = sizeof(PXBBus),
     .class_init    = pxb_bus_class_init,
 };
+#endif /* CONFIG_CXL */
 
 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
                                           PCIBus *rootbus)
@@ -192,6 +194,7 @@ static const TypeInfo pxb_host_info = {
     .class_init    = pxb_host_class_init,
 };
 
+#ifdef CONFIG_CXL
 static void pxb_cxl_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -250,6 +253,7 @@ static const TypeInfo cxl_host_info = {
     .instance_size = sizeof(CXLHost),
     .class_init    = pxb_cxl_host_class_init,
 };
+#endif /* CONFIG_CXL */
 
 /*
  * Registers the PXB bus as a child of pci host root bus.
@@ -297,6 +301,7 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
+#ifdef CONFIG_CXL
 static void pxb_cxl_dev_reset(DeviceState *dev)
 {
     CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
@@ -324,6 +329,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
                          8);
     }
 }
+#endif /* CONFIG_CXL */
 
 static gint pxb_compare(gconstpointer a, gconstpointer b)
 {
@@ -496,6 +502,7 @@ static const TypeInfo pxb_pcie_dev_info = {
     },
 };
 
+#ifdef CONFIG_CXL
 static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
 {
     /* A CXL PXB's parent bus is still PCIe */
@@ -546,17 +553,20 @@ static const TypeInfo pxb_cxl_dev_info = {
             {},
         },
 };
+#endif /* CONFIG_CXL */
 
 static void pxb_register_types(void)
 {
     type_register_static(&pxb_bus_info);
     type_register_static(&pxb_pcie_bus_info);
-    type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
+#ifdef CONFIG_CXL
+    type_register_static(&pxb_cxl_bus_info);
+    type_register_static(&cxl_host_info);
     type_register_static(&pxb_cxl_dev_info);
+#endif /* CONFIG_CXL */
 }
 
 type_init(pxb_register_types)
-- 
2.55.0


