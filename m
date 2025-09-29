Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E848ACAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 03:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v34nX-0001XE-C5; Sun, 28 Sep 2025 23:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34nT-0001Wq-CO
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:31 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34nB-0007dc-05
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759117393; x=1790653393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EG8msmH7phOa7M5JXnVMbYp5jPcD7mOflbwaeYFqvrk=;
 b=n3qsgkQhT+U755hJoFqfOwLQCXXiegmBeAVw3qmcIvAgEZXw7czDPZYP
 brptQpdkerBmUtTgA/nXuv3HlvnAvSBIdCaTzUR2OOTrnQhVcHdPiNV5t
 xz2d0D52Ka990ntiyYwRn5RPlZBw0QqKeY74YUSwsPGr+21/V5Imdj3yb
 RvQBnUXpfx0xNBA7XD6TIQvRMqCRRrYzj1n7AiKgRoRCmIhxihkvkQXNK
 RnJgoirvVbgFzlZJ5UtUI3xM5PQbVXgz0Z9DCNk4XvLTTtHQ0KMbdOAtV
 28lIZB9OmfIQ1ogp268w7xQid4bC1QLgZj/HwmM99gkr/6VuDEob+3jHD Q==;
X-CSE-ConnectionGUID: pzFn16nmTcSg3D6MCeVBjg==
X-CSE-MsgGUID: 5Wew7m9WSoqfEgeN+8vYcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="64989301"
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="64989301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:55 -0700
X-CSE-ConnectionGUID: M1pJv+n8Rxq4GyhlJguxEA==
X-CSE-MsgGUID: qLv4dmIhQ4O96iNMu1ykAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="178865073"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Date: Sun, 28 Sep 2025 23:42:06 -0400
Message-ID: <20250929034206.439266-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250929034206.439266-1-zhenzhong.duan@intel.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The 2nd parameter of pci_device_get_iommu_bus_devfn() about root PCIBus
backed by an IOMMU for the PCI device, the 3rd is about aliased PCIBus
of the PCI device.

Meanwhile the 3rd and 4th parameters are optional, pass NULL if they
are not needed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/pci/pci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c3df9d6656..d5ed89aab7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2967,7 +2967,7 @@ int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
     PCIBus *iommu_bus;
     int devfn;
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->init_iotlb_notifier) {
         iommu_bus->iommu_ops->init_iotlb_notifier(bus, iommu_bus->iommu_opaque,
                                                   devfn, n, fn, opaque);
@@ -3025,7 +3025,7 @@ int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->pri_request_page) {
         return iommu_bus->iommu_ops->pri_request_page(bus,
                                                      iommu_bus->iommu_opaque,
@@ -3049,7 +3049,7 @@ int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->pri_register_notifier) {
         iommu_bus->iommu_ops->pri_register_notifier(bus,
                                                     iommu_bus->iommu_opaque,
@@ -3066,7 +3066,7 @@ void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid)
     PCIBus *iommu_bus;
     int devfn;
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->pri_unregister_notifier) {
         iommu_bus->iommu_ops->pri_unregister_notifier(bus,
                                                       iommu_bus->iommu_opaque,
@@ -3098,7 +3098,7 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
         return iommu_bus->iommu_ops->ats_request_translation(bus,
                                                      iommu_bus->iommu_opaque,
@@ -3122,7 +3122,7 @@ int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->register_iotlb_notifier) {
         iommu_bus->iommu_ops->register_iotlb_notifier(bus,
                                            iommu_bus->iommu_opaque, devfn,
@@ -3144,7 +3144,7 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->unregister_iotlb_notifier) {
         iommu_bus->iommu_ops->unregister_iotlb_notifier(bus,
                                                         iommu_bus->iommu_opaque,
@@ -3158,11 +3158,9 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
 int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
                              uint32_t *min_page_size)
 {
-    PCIBus *bus;
     PCIBus *iommu_bus;
-    int devfn;
 
-    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
     if (iommu_bus && iommu_bus->iommu_ops->get_iotlb_info) {
         iommu_bus->iommu_ops->get_iotlb_info(iommu_bus->iommu_opaque,
                                              addr_width, min_page_size);
-- 
2.47.1


