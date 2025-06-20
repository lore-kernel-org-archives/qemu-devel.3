Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34867C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5D-0004bh-RK; Fri, 20 Jun 2025 03:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW55-0004ak-5H
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:36 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW53-0008HF-AY
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404153; x=1781940153;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gyXkorc2YEb9t/HgYoa8r3CEUGrRW5Har2jZsB4EE1E=;
 b=IoyPO81I7uEqIT6bdoPbQI1bEnE9jZmQwrdqeW1OlHVr7VwhmN9Ifvju
 iq9YZWVi9EE9w+V7npk3gV5Xyy8KTYa6OrcquTLWwxpDzm82hSRRkcmYK
 alJvFtWQsBnlx0IK7n4NarIROvkXm0a/S9JIFhQARBaNFeIIrWjKP9GoQ
 1vHsBpuKJL8xdQ556kJsuKva6Z2fB6RyGdlOnkUZAcVHmAuhj1Kx6CZ9y
 QxsPcfEQmazdgsIUqcFZA+MIatVjqDJdDS/xn3e2nHUaSyo3ZNR0EXD+w
 vYqJxC5y0RSlv6LKCXKK8hH/NxdmSI5AKCSAhToS/WFJnIDduftXX7fwP Q==;
X-CSE-ConnectionGUID: Mcu7iPlBTB2hTzQOixBN9g==
X-CSE-MsgGUID: jpkQ/BG9RjaCJoDpY4GO/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532312"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532312"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:32 -0700
X-CSE-ConnectionGUID: 6lanxiBTQ4qw3lws8WSthQ==
X-CSE-MsgGUID: LknnLN3rR8K/3aHTGMgmTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863085"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 05/19] hw/pci: Export pci_device_get_iommu_bus_devfn() and
 return bool
Date: Fri, 20 Jun 2025 15:17:59 +0800
Message-Id: <20250620071813.55571-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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
---
 include/hw/pci/pci.h |  2 ++
 hw/pci/pci.c         | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 829757b2c2..3029cdf26f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -640,6 +640,8 @@ typedef struct PCIIOMMUOps {
                             bool is_write);
 } PCIIOMMUOps;
 
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
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
-- 
2.34.1


