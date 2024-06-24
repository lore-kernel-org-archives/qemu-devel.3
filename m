Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F01FC30658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrC4-00032B-6W; Mon, 24 Jun 2024 17:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrC2-0002zs-HV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrC0-0006fD-Ur
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWREW9FmfrC7UYeGFhQZ5Z//ePFR/7o62T1LZUA6geE=;
 b=FBb/EIhMDheCJ4McYWF8Gb4E83frgkzEdCog/uXsPVYyDtxFEjfy0A2S+KgqokHy4sPIAa
 NgkfeYNAugBjuOWAQy1WxPc1Mif1HLXiKKyjkcE3SBwucEM8YybfNOcgkPEzrhPlDr7M4q
 39U4IV8bfE8hwx2a0yGkX9JYonq4rFU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-spjZxaOQN4ay5xlSiUl7NA-1; Mon,
 24 Jun 2024 17:25:38 -0400
X-MC-Unique: spjZxaOQN4ay5xlSiUl7NA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D6BF1956094; Mon, 24 Jun 2024 21:25:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5EA51956053; Mon, 24 Jun 2024 21:25:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 13/42] hw/pci: Introduce pci_device_[set|unset]_iommu_device()
Date: Mon, 24 Jun 2024 23:24:27 +0200
Message-ID: <20240624212456.350919-14-clg@redhat.com>
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

From: Yi Liu <yi.l.liu@intel.com>

pci_device_[set|unset]_iommu_device() call pci_device_get_iommu_bus_devfn()
to get iommu_bus->iommu_ops and call [set|unset]_iommu_device callback to
set/unset HostIOMMUDevice for a given PCI device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 38 +++++++++++++++++++++++++++++++++++++-
 hw/pci/pci.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d8844d2c92d62194a86cd4f6be2f141f..eb26cac810981e00aa47bf9d9c0a7bf3de7ef456 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -3,6 +3,7 @@
 
 #include "exec/memory.h"
 #include "sysemu/dma.h"
+#include "sysemu/host_iommu_device.h"
 
 /* PCI includes legacy ISA access.  */
 #include "hw/isa/isa.h"
@@ -383,10 +384,45 @@ typedef struct PCIIOMMUOps {
      *
      * @devfn: device and function number
      */
-   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
+     *
+     * Optional callback, if not implemented in vIOMMU, then vIOMMU can't
+     * retrieve host information from the associated HostIOMMUDevice.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     *
+     * @dev: the #HostIOMMUDevice to attach.
+     *
+     * @errp: pass an Error out only when return false
+     *
+     * Returns: true if HostIOMMUDevice is attached or else false with errp set.
+     */
+    bool (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
+                             HostIOMMUDevice *dev, Error **errp);
+    /**
+     * @unset_iommu_device: detach a HostIOMMUDevice from a vIOMMU
+     *
+     * Optional callback.
+     *
+     * @bus: the #PCIBus of the PCI device.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number of the PCI device.
+     */
+    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
 } PCIIOMMUOps;
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
+bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
+                                 Error **errp);
+void pci_device_unset_iommu_device(PCIDevice *dev);
 
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 02a4bb2af63feabd954ce23e9b02dd931c81ae9a..c8a8aab30646c5e37816f49f6ef9d1bdf8be241f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2742,6 +2742,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
+                                 Error **errp)
+{
+    PCIBus *iommu_bus;
+
+    /* set_iommu_device requires device's direct BDF instead of aliased BDF */
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
+        return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
+                                                      iommu_bus->iommu_opaque,
+                                                      dev->devfn, hiod, errp);
+    }
+    return true;
+}
+
+void pci_device_unset_iommu_device(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->unset_iommu_device) {
+        return iommu_bus->iommu_ops->unset_iommu_device(pci_get_bus(dev),
+                                                        iommu_bus->iommu_opaque,
+                                                        dev->devfn);
+    }
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
-- 
2.45.2


