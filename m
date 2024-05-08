Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F35C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dHR-0000ZV-O0; Wed, 08 May 2024 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGx-0000A6-LZ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:35 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGq-0005QH-SV
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159249; x=1746695249;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MjIaxja7ZxYGI0e28fQ6Z2a0sW+X9+K6isij7W/S8uA=;
 b=RMTZmIrnTfg8lX5KUMY6SD6WphGcbH2VwsPO64syApXFgglo1+cbY6od
 6rarS6faGHNQzFLpmRNHX+EfqZmfZtOfi5Pywi+lAysTqX00QEaicSGIf
 i94hZKIislZ6RzHAwXLqvtf4d45h+3R3BROh2vD2QY7mNdc6zm/RXPiwI
 J82s4GhlDddBMRn+518UcsB2aCTEVxg9VVxpAAJd+rcogJhfuu7xr0+CO
 r+WatI0HjJZiM+kvRCxNMh6irG6cP60G5zc9eRBEgBhLYkCElNilYjZs6
 scOkjSEswjLVRECQRG3BqGOtHmvjg8qkOtRU/vF+5Sm/E9ELMXcXOUdIt g==;
X-CSE-ConnectionGUID: hKBHO9etQAaR5yqWnV3P4Q==
X-CSE-MsgGUID: BuCXyB+iQua0X+Fm1z8JlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11160980"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11160980"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:29 -0700
X-CSE-ConnectionGUID: P4IpsjssSUCBd+EsUibvDw==
X-CSE-MsgGUID: QgjF/ZowQcuE8RKxw9INGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226493"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Wed,  8 May 2024 17:03:42 +0800
Message-Id: <20240508090354.1815561-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Utilize range_get_last_bit() to get host IOMMU address width and
package it in HostIOMMUDeviceCaps for query with .get_cap().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1b4fc2f3e8..b872f6f201 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1134,6 +1134,31 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                     Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    /* iova_ranges is a sorted list */
+    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
+
+    /* Only support query HOST_IOMMU_DEVICE_CAP_AW_BITS with legacy backend */
+    if (l) {
+        Range *range = l->data;
+        hiod->caps.aw_bits = range_get_last_bit(range) + 1;
+    } else {
+        hiod->caps.aw_bits = 0xff;
+    }
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
@@ -1142,6 +1167,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_legacy_vfio_class_init,
     }
 };
 
-- 
2.34.1


