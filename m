Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8ADC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5d-0001Hu-OZ; Wed, 05 Jun 2024 04:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5c-0001Hm-Hf
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:48 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5a-00062T-Ru
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576427; x=1749112427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8BJz9IwTcQPPECmR9FaEYT0aO+hddDR604LTsSbQfTI=;
 b=M/bQuPEASBJh8R6eyXXG6nBkxOdGrJFzsfh6zex/8R00h+Z9erjYkfze
 eux07PntW5ZPz2LxuZl9t84JG2BvB4ZPtWuFemt6AeZ8ZsFMj6XjW4Ysn
 bqfPRhCc1nS+8b9wAbwk9O81flGEEOZiizDA7yxQC+LDrwCtJp1kAgjR5
 vjPnMXvXT4eYQvzcrCM9Bt1tLQtUc8r+VK2oJTaSr2Azf2SCsNP/QPVzx
 E+2FbMXFOlxeWh2FMMxSGYOnI5o7gskS2uy5Nhfx/rLnZqn6XEs3L90gI
 2SHoBklMnlWaJ0ZylzB3xF5LNUraUoJhJQC6nGpveJn4DHeO3av1ZjqWH w==;
X-CSE-ConnectionGUID: rAOTl8LXTWa1bPdMCJiJVg==
X-CSE-MsgGUID: vdkLYmyOT6ixIVQ/PaybsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575363"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575363"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:47 -0700
X-CSE-ConnectionGUID: rH7WaLGXSIWuexO2RncnIg==
X-CSE-MsgGUID: l0YBg2ZVSWGrLxgbTIMpAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954809"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 08/17] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Wed,  5 Jun 2024 16:30:34 +0800
Message-Id: <20240605083043.317831-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It calls iommufd_backend_get_device_info() to get host IOMMU
related information and translate it into HostIOMMUDeviceCaps
for query with .get_cap().

For aw_bits, use the same way as legacy backend by calling
vfio_device_get_aw_bits() which is common for different vendor
IOMMU.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e4a507d55c..1674c61227 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -619,6 +619,35 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
 };
 
+static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                      Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+    enum iommu_hw_info_type type;
+    union {
+        struct iommu_hw_info_vtd vtd;
+    } data;
+
+    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
+                                         &type, &data, sizeof(data), errp)) {
+        return false;
+    }
+
+    hiod->name = g_strdup(vdev->name);
+    caps->type = type;
+    caps->aw_bits = vfio_device_get_aw_bits(vdev);
+
+    return true;
+}
+
+static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hiodc->realize = hiod_iommufd_vfio_realize;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
@@ -627,6 +656,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
+        .class_init = hiod_iommufd_vfio_class_init,
     }
 };
 
-- 
2.34.1


