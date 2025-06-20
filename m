Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B77C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW4y-0004Z0-3M; Fri, 20 Jun 2025 03:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW4v-0004Yj-04
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:25 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW4p-0008FB-9q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404139; x=1781940139;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JL9CLBJX8nnHDI6v27343igxliBeYes2mrdVS1QU33g=;
 b=UrghDAIts8AphfI8lfjV6Xwb6DWAuSoaygmhzRPIkoZcrJg1YjMgOuvT
 xwYAaGiyi8Cv/jWfqZAksk4l1LftcpaLmVXg3ch851CCjDcfBk3/oufa1
 knXbN4KrivV9VmqMcgeEbo7tMrdMZSOmGHN31wp88HC2dMMJxJsZtreyT
 RU56UTOVMfeczBSviBhCaUDNKFB/1BCbTsuLlZzydzepe+mvw4uULxLRX
 3pJELTTDh7BHn/uKnCg2DAtcF0wFwXVI5B8nTld/Mt6uFw8yXjuBvYdIR
 MPMChjPe+frW2HmyKtZ3CYDliekvIjZlhzP8QA9uT63uuqFuyIfebmXWq w==;
X-CSE-ConnectionGUID: 0UUyiQB9TACbgssqkjGopA==
X-CSE-MsgGUID: fWNLUBV3S++PBacU66aRIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532265"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:19 -0700
X-CSE-ConnectionGUID: gr8yW0rXQv6A63KToe1nYA==
X-CSE-MsgGUID: d1nWaVJRSiqvVG6FmpO2Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863056"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap()
Date: Fri, 20 Jun 2025 15:17:56 +0800
Message-Id: <20250620071813.55571-3-zhenzhong.duan@intel.com>
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

pci_device_get_viommu_cap() call pci_device_get_iommu_bus_devfn()
to get iommu_bus->iommu_ops and call get_viommu_cap() callback to
get a bitmap with each bit represents a vIOMMU exposed capability.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/pci/pci.h | 22 ++++++++++++++++++++++
 hw/pci/pci.c         | 11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index df3cc7b875..829757b2c2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -453,6 +453,18 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_viommu_cap: get vIOMMU capabilities
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't
+     * support exposing capabilities to other subsystem, e.g., VFIO.
+     * vIOMMU can choose which capabilities to expose.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * Returns: 64bit bitmap with each bit represents a capability.
+     */
+    uint64_t (*get_viommu_cap)(void *opaque);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -633,6 +645,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
 
+/**
+ * pci_device_get_viommu_cap: get vIOMMU capabilities.
+ *
+ * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
+ * capability, 0 if vIOMMU doesn't support esposing capabilities.
+ *
+ * @dev: PCI device pointer.
+ */
+uint64_t pci_device_get_viommu_cap(PCIDevice *dev);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..df1fb615a8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2992,6 +2992,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+uint64_t pci_device_get_viommu_cap(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_cap) {
+        return iommu_bus->iommu_ops->get_viommu_cap(iommu_bus->iommu_opaque);
+    }
+    return 0;
+}
+
 int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
                          bool exec_req, hwaddr addr, bool lpig,
                          uint16_t prgi, bool is_read, bool is_write)
-- 
2.34.1


