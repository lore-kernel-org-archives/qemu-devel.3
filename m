Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3C2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLTD-0007wn-5e; Fri, 22 Aug 2025 02:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTC-0007we-KX
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:50 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTA-0000jU-I6
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844908; x=1787380908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qtFeILwVk/LV3Z164OzSZJ5mhlnK18pSRXjY88VE0O0=;
 b=HH+D+//uGhTM5gUAmNA+ibz1wwkEzrg2kea+k+Aj2CHR4V2t5FfJcEss
 cn2lP9XwMG5dAIeFdVRuUKW98JBQsUs8cz5e4OMF3ntYI6Cpm8osdbpdl
 lGu5ziGMY2vROSXLhwaJTVyiTg9rvvxSWGin4x/KTBcvcpEBTINbmX9Mt
 Dtm6KHgGSkQHsZxPuFMlzhP19P/8I0UTSIE+WeJy6m2VGktlo/3DQr5LZ
 lXOcVqHK96+1UV8Z39JwbAvElQmFaD8ePM1ynKTBpt1+LhQZmxL4AYoGh
 Cco/QnyMP8DzPg4p+sohBblnyX4NTS9qOcCkrRPnRtmoJ+aaF9638BFZ0 w==;
X-CSE-ConnectionGUID: Q1RDtGCRRcy1Z1UcSINaOQ==
X-CSE-MsgGUID: 5raHKSg+Q0itvemN/HyTPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851860"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:47 -0700
X-CSE-ConnectionGUID: iam5zphpQpC469UUusfLrQ==
X-CSE-MsgGUID: 5Puo0PfKTkWJixUIihxjUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244928"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:44 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 06/21] hw/pci: Export pci_device_get_iommu_bus_devfn() and
 return bool
Date: Fri, 22 Aug 2025 02:40:44 -0400
Message-ID: <20250822064101.123526-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/pci/pci.h |  2 ++
 hw/pci/pci.c         | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cde7a54a69..34b4edbf1a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -652,6 +652,8 @@ typedef struct PCIIOMMUOps {
                             bool is_write);
 } PCIIOMMUOps;
 
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index df1fb615a8..151c27088b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2857,20 +2857,21 @@ static void pci_device_class_base_init(ObjectClass *klass, const void *data)
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
2.47.1


