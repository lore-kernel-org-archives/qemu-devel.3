Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47342C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrC2-0002zl-Dr; Mon, 24 Jun 2024 17:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrC1-0002yw-AP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBz-0006f8-Qh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vvgeQA7GHo7n8HIawznw4YrKPJAz9vDAQ+YPWM/A/g=;
 b=OAVOPQYMMVuXBAosqqvrhxnK67QlQjFKnh25pfd90rsgSyQsE3ezafeo3iU1DRxxz2Mw/T
 rpPPCJLREYMNvRBnFFSYqWOYLBp1111cKRw1byiVwWCaAx9j80Qmv9w5Cl8zrUWunxFddk
 O64oqOFGvsxZeYvogZs7jQLKFZD10JQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-4wHQSsCdMa-nvdwzjDSDPw-1; Mon,
 24 Jun 2024 17:25:34 -0400
X-MC-Unique: 4wHQSsCdMa-nvdwzjDSDPw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49AC119560AF; Mon, 24 Jun 2024 21:25:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85A131956053; Mon, 24 Jun 2024 21:25:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 12/42] hw/pci: Introduce helper function
 pci_device_get_iommu_bus_devfn()
Date: Mon, 24 Jun 2024 23:24:26 +0200
Message-ID: <20240624212456.350919-13-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Extract out pci_device_get_iommu_bus_devfn() from
pci_device_iommu_address_space() to facilitate
implementation of pci_device_[set|unset]_iommu_device()
in following patch.

No functional change intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d25f89c716d2fff06b3cd59471881a4f..02a4bb2af63feabd954ce23e9b02dd931c81ae9a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2648,11 +2648,27 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
     }
 }
 
-AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+/*
+ * Get IOMMU root bus, aliased bus and devfn of a PCI device
+ *
+ * IOMMU root bus is needed by all call sites to call into iommu_ops.
+ * For call sites which don't need aliased BDF, passing NULL to
+ * aliased_[bus|devfn] is allowed.
+ *
+ * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
+ *
+ * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
+ *
+ * @aliased_devfn: return aliased devfn of the PCI device, optional.
+ */
+static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
+                                           PCIBus **piommu_bus,
+                                           PCIBus **aliased_bus,
+                                           int *aliased_devfn)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
-    uint8_t devfn = dev->devfn;
+    int devfn = dev->devfn;
 
     while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
@@ -2693,7 +2709,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 
         iommu_bus = parent_bus;
     }
-    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+    assert(iommu_bus);
+
+    if (pci_bus_bypass_iommu(bus) || !iommu_bus->iommu_ops) {
+        iommu_bus = NULL;
+    }
+
+    *piommu_bus = iommu_bus;
+
+    if (aliased_bus) {
+        *aliased_bus = bus;
+    }
+
+    if (aliased_devfn) {
+        *aliased_devfn = devfn;
+    }
+}
+
+AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
         return iommu_bus->iommu_ops->get_address_space(bus,
                                  iommu_bus->iommu_opaque, devfn);
     }
-- 
2.45.2


