Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B42C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFF9-0001gp-BN; Tue, 08 Jul 2025 16:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDrQ-000889-EE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:16 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDrI-00082f-Or
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002405; x=1783538405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KsOnCsI5jC90DeVaUlcU5vLyuj8uWYtnJUXix5a5El0=;
 b=GgTuu5wIKeo/QciHxHhZsDLjd2N/r8azj+83WWEq2LdrVvjl2ioudmJ7
 HVU+hpVyFyzX6JBR7tAPkXjYVzO27eHxrv33iPZDpQ4YKHAC1F9O/yY2e
 hAwXpz5/pGnGCig8cL/iUhmgShoKAFj0eN6x3M29DsE3fx2Oj43ba5x4x
 /Q6gg4uCcuxnfvpcJb/Fs5iAb99PmbItmE5gM+heuAWXiq2yYlNMmPj2W
 FOrieVQfTtUwMr5MF+pyjkj2V7vX2oq/3cuCw/ilSt+yJ3DpuoN6TQL4c
 bWTCKGrm8qEGQoWdKSdSDxaljlks8BXzG3rLKse7pyXtN1mgSjF3+C2Rl A==;
X-CSE-ConnectionGUID: t6fLUWEoQ9KJJW/dBCX+TQ==
X-CSE-MsgGUID: nE2SzAB+T5SoqZiBiJM1kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57973945"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57973945"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:06:33 -0700
X-CSE-ConnectionGUID: 6WJx2Jt/Szyfu7BoEiw2EQ==
X-CSE-MsgGUID: TtnH6KeAR8mwIngJoR3ypA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192647946"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:06:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 05/20] hw/pci: Export pci_device_get_iommu_bus_devfn() and
 return bool
Date: Tue,  8 Jul 2025 07:05:46 -0400
Message-ID: <20250708110601.633308-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Returns true if PCI device is aliased or false otherwise. This will be
used in following patch to determine if a PCI device is under a PCI
bridge.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/pci/pci.c         | 12 ++++++++----
 include/hw/pci/pci.h |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index df1fb615a8..87f7c942b3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2857,20 +2857,21 @@ static void pci_device_class_base_init(ObjectClass *klass, const void *data)
  * For call sites which don't need aliased BDF, passing NULL to
  * aliased_[bus|devfn] is allowed.
  *
+ * Returns true if PCI device is aliased or false otherwise.
+ *
  * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
  *
  * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
  *
  * @aliased_devfn: return aliased devfn of the PCI device, optional.
  */
-static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
-                                           PCIBus **piommu_bus,
-                                           PCIBus **aliased_bus,
-                                           int *aliased_devfn)
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
     int devfn = dev->devfn;
+    bool aliased = false;
 
     while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
@@ -2907,6 +2908,7 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
                 devfn = parent->devfn;
                 bus = parent_bus;
             }
+            aliased = true;
         }
 
         iommu_bus = parent_bus;
@@ -2928,6 +2930,8 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
     if (aliased_devfn) {
         *aliased_devfn = devfn;
     }
+
+    return aliased;
 }
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a11ab14bdc..8795808155 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -641,6 +641,8 @@ typedef struct PCIIOMMUOps {
                             bool is_write);
 } PCIIOMMUOps;
 
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
-- 
2.47.1


