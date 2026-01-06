Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA46CD043B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0K2-00032Q-3e; Tue, 06 Jan 2026 01:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0K0-00030c-DH
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:13:36 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0Jy-0007G3-O3
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680014; x=1799216014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=37OITpaDJCFglH/UCTj6iw8w3zVLe4F31Y4eOLysJHo=;
 b=UXBMkLoFHQUPm6VOJXCNCWlYVpHC8WUM2T6XBwHZ/VKf7l6vEvGhVyMd
 YgLcqkKs+W5Jg6A6n9cQGNpxh4Uor99qy9GBK5qjDy8gg2EhNwmG/rD5e
 WOpPIq0aY4rvfJHBUcFV0qEQf/EoUx9whDRH6c4vUyWpLl/eDWOBExu/D
 zWf6MO8ocPOmWg7FQAZATqK57lzAGOKgExVvbPUkAU0TwX8U4Bx0ebWAW
 Om3q/wgqZA06WoJJjVeyKJCEdZyxZxZetYcZ5+iwq+o+WnDutgnnsbqcL
 h5jQDbXdZ50LwKQNCUXXSIEDW3I5bRHNt+Y5iSr59rZKhVKw30D6htAbE Q==;
X-CSE-ConnectionGUID: 92d2o/faQEieuDF3chwK0w==
X-CSE-MsgGUID: UHTOovsoSX2c/F77AjSSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69087576"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69087576"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:13:33 -0800
X-CSE-ConnectionGUID: jXRoJt60T1qvelmjp58S1w==
X-CSE-MsgGUID: 7RYMNMV4Tt+VD9qp5SR60Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588714"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:13:30 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 04/19] hw/pci: Export pci_device_get_iommu_bus_devfn() and
 return bool
Date: Tue,  6 Jan 2026 01:12:46 -0500
Message-ID: <20260106061304.314546-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/hw/pci/pci.h |  2 ++
 hw/pci/pci.c         | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b72e484500..b22d350ba2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -637,6 +637,8 @@ typedef struct PCIIOMMUOps {
                             bool is_write);
 } PCIIOMMUOps;
 
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5996229c81..0d4cf906f0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2869,20 +2869,21 @@ static void pci_device_class_base_init(ObjectClass *klass, const void *data)
  * For call sites which don't need aliased BDF, passing NULL to
  * aliased_[bus|devfn] is allowed.
  *
+ * Returns true if PCI device RID is aliased or false otherwise.
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
@@ -2919,6 +2920,7 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
                 devfn = parent->devfn;
                 bus = parent_bus;
             }
+            aliased = true;
         }
 
         /*
@@ -2953,6 +2955,8 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
     if (aliased_devfn) {
         *aliased_devfn = devfn;
     }
+
+    return aliased;
 }
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
-- 
2.47.1


