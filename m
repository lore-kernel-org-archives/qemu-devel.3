Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ED7C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRXG-0005ag-BI; Thu, 01 Feb 2024 02:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXE-0005XG-TX
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:56 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXD-0001fn-3H
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772655; x=1738308655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D4cTHuJ5P52PDk7zGzN3Kqt39x1mp1P+J3KDpszCppQ=;
 b=OL6vd2qSfvTRzigpy0IV2B3xNCkoVDo5d87uW1rIn+bIMZCJlhAfDU8L
 JKXKRA9Cj9L2GcWmd14XzUyb2+BsU+cugx/YS+DZO4o0qW0zcoBa4+8yo
 e/b/PRv2+IAA3nsUDjRAUKMfJcVYsjSWnieZjO1ZcuMx2YJ6ytXvBZvpQ
 s1Tk7x35MUPvORYRdcoh/V95YvgzRf4GU9n3/w5yckYZnWd1XHDgynY9A
 +4X3OBOj1u0UjMCqo3R4Be059442kv4vg+Tw1sQVrmEhftWzI2OBUnrMG
 X9eYeJb06gNsitQgQ2eRBPgPV2NK3mkk1AeyduObxtGBUevsmtlHn0YY2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676716"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676716"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443256"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:48 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 07/18] vfio/container: Implement host_iommu_device_init
 callback in legacy mode
Date: Thu,  1 Feb 2024 15:28:07 +0800
Message-Id: <20240201072818.327930-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

This callback will be used to initialize base and public elements
in IOMMULegacyDevice.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9fbad..8fafd4b4e5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1120,6 +1120,12 @@ out_single:
     return ret;
 }
 
+static void vfio_legacy_host_iommu_device_init(VFIODevice *vbasedev)
+{
+    host_iommu_base_device_init(&vbasedev->base_hdev, HID_LEGACY,
+                                sizeof(IOMMULegacyDevice));
+}
+
 static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
@@ -1132,6 +1138,7 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
     vioc->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
+    vioc->host_iommu_device_init = vfio_legacy_host_iommu_device_init;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


