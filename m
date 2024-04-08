Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BC7CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkA2-0003B0-B0; Mon, 08 Apr 2024 04:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkA0-0003AR-4y
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:24 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9y-00089q-FC
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564122; x=1744100122;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C4MsvBvx9B64HLRW4B7bTMYTxjVlbMxQElKE/nS9Vhc=;
 b=mzP+eHlcZpmLyNUd3jJHzPOQ1AX+zLpt9kLawSFPa7kJwNEaPpxkgqv0
 hpWPdtuFYJ5+xni+DDLcz16NS8YfEjTUHpIYzrx1n/ejDl1ZBwkNDqyUK
 dOF+ExfFT0MawfKiT3sA0k8tuAG4gGe4wsKwi70s+HdVlROOjjxt0CG6V
 85VPtSeUCNgljIQCHLcpqtnd+2cm9xAhcO7iokORdWp2pC4EG9QViVboq
 Ugulyv+hJdV1DCipeyw6GdkDdBzby4IDfnG9p8LCIktCjptEqL4bZS+0s
 6Us5OjtBaxNf2FY+MFH4pbV2zw637plh8kRliZKypmrPTDdqGXCBp5dNU A==;
X-CSE-ConnectionGUID: 3ge72sZrQ6i70Ao7v1HpPg==
X-CSE-MsgGUID: dbqPhMitSJuAbFdDQwh0OQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199712"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:22 -0700
X-CSE-ConnectionGUID: CjhSjub6RROLMU6Ty4M7XQ==
X-CSE-MsgGUID: wSi5G0lYQ7a3sz9JvvB0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845206"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 05/10] vfio: Implement get_host_iommu_info() callback
Date: Mon,  8 Apr 2024 16:12:25 +0800
Message-Id: <20240408081230.1030078-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Utilize iova_ranges to calculate host IOMMU address width and
package it in HIOD_LEGACY_INFO for vIOMMU usage.

HIOD_LEGACY_INFO will be used by both VFIO and VDPA so declare
it in host_iommu_device.h.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/host_iommu_device.h | 10 ++++++++++
 hw/vfio/container.c                | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 22ccbe3a5d..beb8be8231 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -16,4 +16,14 @@ struct HostIOMMUDeviceClass {
     int (*get_host_iommu_info)(HostIOMMUDevice *hiod, void *data, uint32_t len,
                                Error **errp);
 };
+
+/*
+ * Define the format of host IOMMU related info that current VFIO
+ * or VDPA can privode to vIOMMU.
+ *
+ * @aw_bits: Host IOMMU address width. 0xff if no limitation.
+ */
+typedef struct HIOD_LEGACY_INFO {
+    uint8_t aw_bits;
+} HIOD_LEGACY_INFO;
 #endif
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 44018ef085..ba0ad4a41b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1143,8 +1143,32 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static int hiod_legacy_vfio_get_host_iommu_info(HostIOMMUDevice *hiod,
+                                                void *data, uint32_t len,
+                                                Error **errp)
+{
+    VFIODevice *vbasedev = HIOD_LEGACY_VFIO(hiod)->vdev;
+    /* iova_ranges is a sorted list */
+    GList *l = g_list_last(vbasedev->bcontainer->iova_ranges);
+    HIOD_LEGACY_INFO *info = data;
+
+    assert(sizeof(HIOD_LEGACY_INFO) <= len);
+
+    if (l) {
+        Range *range = l->data;
+        info->aw_bits = find_last_bit(&range->upb, BITS_PER_LONG) + 1;
+    } else {
+        info->aw_bits = 0xff;
+    }
+
+    return 0;
+}
+
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
 {
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->get_host_iommu_info = hiod_legacy_vfio_get_host_iommu_info;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


