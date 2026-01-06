Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDDACD043F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0Ya-0007Db-7b; Tue, 06 Jan 2026 01:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0YN-000756-A2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:28:28 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0YK-00035b-Ub
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680905; x=1799216905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8ydPNtiHPPIK4sls1idtaAM8NYnKKaTPn4tEYgzOSQs=;
 b=c/VEpQFbCqmci3xJ/5hTdBdLTomU4kcii9/KjJTo1/JhtkEKgTeIsZwH
 VxnwA5qLShkdGkge8qtwvUxkWrpncCDOZEP2rY42M/Bk8T266wsMP3sFQ
 PlfC6oIt/42rs6JoXS3puGiN8sFhQ6GMSYvHxHs6qYAv84Uce0HVHvVBC
 lWGoLZ8BqoI1Jr72Et7ulOBUMq82DxygnANl3Qy2MR+sllSRACJy6rxyl
 N9nBu1yHxALlJsFQnLt0dW00c/AgrLEMjHKZjJUUAHuu6bdz8zQQ2rIp7
 5429zcGI1d9foxv6eCb3IlQPPC1Syd0Gm2onXgfHEV80S4wEKuH8OitUP Q==;
X-CSE-ConnectionGUID: IcpCdRysTKekXXOF7X2oZQ==
X-CSE-MsgGUID: Ww89S1AcQXuVrQ2NjsNbGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69025406"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69025406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:28:23 -0800
X-CSE-ConnectionGUID: 61Xge1bBTyemFkGxvNIwuQ==
X-CSE-MsgGUID: zzwyS9Z0QHa2h/ehrWGztg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202346085"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:28:19 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 1/4] hw/pci: Introduce pci_device_get_host_iommu_quirks()
Date: Tue,  6 Jan 2026 01:28:03 -0500
Message-ID: <20260106062808.316574-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106062808.316574-1-zhenzhong.duan@intel.com>
References: <20260106062808.316574-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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

In VFIO core, we call iommufd_backend_get_device_info() to return vendor
specific hardware information data, but it's not good to retrieve this raw
data in VFIO core.

Introduce a new PCIIOMMUOps optional callback, get_host_iommu_quirk() which
allows to retrieve the vendor specific hardware information data and convert
it into bitmaps defined with enum host_iommu_quirks.

pci_device_get_host_iommu_quirks() is a wrapper that can be called on a PCI
device potentially protected by a vIOMMU.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/core/iommu.h |  5 +++++
 include/hw/pci/pci.h    | 31 +++++++++++++++++++++++++++++++
 hw/pci/pci.c            | 12 ++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 9b8bb94fc2..6d61410703 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -22,4 +22,9 @@ enum viommu_flags {
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
 };
 
+/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
+enum host_iommu_quirks {
+    HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
+};
+
 #endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 868817cc05..6fd8984c99 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -474,6 +474,23 @@ typedef struct PCIIOMMUOps {
      * enum viommu_flags.
      */
     uint64_t (*get_viommu_flags)(void *opaque);
+    /**
+     * @get_host_iommu_quirks: get host IOMMU quirks
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't support
+     * converting @type specific hardware information data into a standard
+     * bitmap format.
+     *
+     * @type: IOMMU hardware info type
+     *
+     * @caps: IOMMU @type specific hardware information data
+     *
+     * @size: size of @caps
+     *
+     * Returns: bitmap with each bit representing a host IOMMU quirk defined in
+     * enum host_iommu_quirks
+     */
+    uint64_t (*get_host_iommu_quirks)(uint32_t type, void *caps, uint32_t size);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -666,6 +683,20 @@ void pci_device_unset_iommu_device(PCIDevice *dev);
  */
 uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
 
+/**
+ * pci_device_get_host_iommu_quirks: get host IOMMU quirks.
+ *
+ * Returns: bitmap with each bit representing a host IOMMU quirk defined in
+ * enum host_iommu_quirks. Or 0 if vIOMMU doesn't convert any.
+ *
+ * @dev: PCI device pointer.
+ * @type: IOMMU hardware info type
+ * @caps: IOMMU @type specific hardware information data
+ * @size: size of @caps
+ */
+uint64_t pci_device_get_host_iommu_quirks(PCIDevice *dev, uint32_t type,
+                                          void *caps, uint32_t size);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a136e772a3..8cbf5f5d70 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3032,6 +3032,18 @@ uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
     return 0;
 }
 
+uint64_t pci_device_get_host_iommu_quirks(PCIDevice *dev, uint32_t type,
+                                          void *caps, uint32_t size)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->get_host_iommu_quirks) {
+        return iommu_bus->iommu_ops->get_host_iommu_quirks(type, caps, size);
+    }
+    return 0;
+}
+
 int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
                          bool exec_req, hwaddr addr, bool lpig,
                          uint16_t prgi, bool is_read, bool is_write)
-- 
2.47.1


