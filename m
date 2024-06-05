Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F30C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5Y-0001Gg-8M; Wed, 05 Jun 2024 04:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5X-0001GY-Ld
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:43 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5V-000630-Uw
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576422; x=1749112422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ousgHI+YEtUBdC68U5LlOUWWhjsopPIRJoJcDe1y5H4=;
 b=dAJNBFCxW3YJEQx9l9KxjDYwGLbT/4/B7Fr1844zGPH9mTrl2ZmFv4E5
 aV1AdbJQVMEfS0Ey8rXPyFJ1atWiz/UMstTmFPnR6bapSdPm34rJRSxV1
 cNU+qfsTyqTz8tWcsRCV2UWI7Q82pkBs+QvusBXyEg+jH3QRjDpbO76Qk
 RudmIBmyMZD1iLP9pljcLfe8UuVarRPhMW6bpOp2qUAhLc95/mvbG+yAh
 quQqOyZ+asx1m6dvYVcF1iJhNXXJHYOpEvSK9pMxaotDyGoLsTaDSItod
 iySbcvA3FKEpBkHXON97xpiai0KqLc4z/UAfZptgqAei3DqjRhu/r4p+/ A==;
X-CSE-ConnectionGUID: ZEENami9RDGjQ25MMgerIw==
X-CSE-MsgGUID: WsTYNrjmR0y1MufkvxlxnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575341"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575341"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:39 -0700
X-CSE-ConnectionGUID: fx6gk+4hR6+Rrsf/AjRPrQ==
X-CSE-MsgGUID: 2gcEJWK9SmeoLPDeI2MlVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954793"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 06/17] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Wed,  5 Jun 2024 16:30:32 +0800
Message-Id: <20240605083043.317831-7-zhenzhong.duan@intel.com>
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

The realize function populates the capabilities. For now only the
aw_bits caps is computed for legacy backend.

Introduce a helper function vfio_device_get_aw_bits() which calls
range_get_last_bit() to get host aw_bits and package it in
HostIOMMUDeviceCaps for query with .get_cap(). This helper will
also be used by iommufd backend.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/container.c           | 19 +++++++++++++++++++
 hw/vfio/helpers.c             | 17 +++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 56d1717211..105b8b7e80 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -289,4 +289,5 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
+int vfio_device_get_aw_bits(VFIODevice *vdev);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c4fca2dfca..2f62c13214 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1136,6 +1136,24 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                     Error **errp)
+{
+    VFIODevice *vdev = opaque;
+
+    hiod->name = g_strdup(vdev->name);
+    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
+
+    return true;
+}
+
+static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->realize = hiod_legacy_vfio_realize;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
@@ -1144,6 +1162,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_legacy_vfio_class_init,
     }
 };
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 27ea26aa48..b14edd46ed 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -658,3 +658,20 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
 
     vbasedev->ram_block_discard_allowed = ram_discard;
 }
+
+int vfio_device_get_aw_bits(VFIODevice *vdev)
+{
+    /*
+     * iova_ranges is a sorted list. For old kernels that support
+     * VFIO but not support query of iova ranges, iova_ranges is NULL,
+     * in this case HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX(64) is returned.
+     */
+    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
+
+    if (l) {
+        Range *range = l->data;
+        return range_get_last_bit(range) + 1;
+    }
+
+    return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
+}
-- 
2.34.1


