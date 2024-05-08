Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E49C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dHS-0000g9-Es; Wed, 08 May 2024 05:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHG-0000E6-B3
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:55 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHD-0005S1-PA
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159272; x=1746695272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5t166Nmcv4MTvQcqwSqlR73fJYwil6Adj9OK9wDutUg=;
 b=BkchdB1WC/8AZ2P7R3EfRjn9Gr1Jn6GLL7PRqZFePCWObpQsb5WyxBuK
 A+5ON1wjxKq7pLxdu6/Z1t6leOoJ6J9it3RZ2cR3pKbvR3ZOxH/E0hdk7
 u6gTpSTa+pw7y9SY+Qu3HiJO7eDceCjtsTpcyZHf9/pLgtrkB5r3iATx7
 kBHqSPHK9JTxzo02tE6BLyWqSsze21APcCr73gOiMAl0AYUMXnLKCbh+c
 cKcOE8oRwZEPwLdTglPtax2go+sLgonVckJZ/aGKN/6eE7Ux+3UiHLwAK
 NUoqHdQFg1tT7QRcqrW/L8zl1cFWnyb4aZgwn9WC8M99UO+qIkOc5FOSK Q==;
X-CSE-ConnectionGUID: xMLAuDR/S9ewf9KA9eI3ng==
X-CSE-MsgGUID: GQEnOpOdTn6vBbipiLSSyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11161029"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11161029"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:50 -0700
X-CSE-ConnectionGUID: HPLKAHefQVWLkMUg49d5tw==
X-CSE-MsgGUID: 9YB35r0bR6Oran/Tovec6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226613"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 12/19] vfio: Introduce VFIOIOMMUClass::hiod_typename
 attribute
Date: Wed,  8 May 2024 17:03:47 +0800
Message-Id: <20240508090354.1815561-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Initialize attribute VFIOIOMMUClass::hiod_typename based on
VFIO backend type.

This attribute will facilitate HostIOMMUDevice creation in
vfio_attach_device().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 3 +++
 hw/vfio/container.c                   | 2 ++
 hw/vfio/iommufd.c                     | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index e96cda78c8..da00d6497f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -110,6 +110,9 @@ DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
 struct VFIOIOMMUClass {
     InterfaceClass parent_class;
 
+    /* Properties */
+    const char *hiod_typename;
+
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c9c5347da9..f9708f94da 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1124,6 +1124,8 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO;
+
     vioc->setup = vfio_legacy_setup;
     vioc->dma_map = vfio_legacy_dma_map;
     vioc->dma_unmap = vfio_legacy_dma_unmap;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9d2e95e20e..8fd8d52bc2 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -613,6 +613,8 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
+
     vioc->dma_map = iommufd_cdev_map;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
-- 
2.34.1


