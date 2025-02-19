Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA0C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPf-0005Tp-E2; Wed, 19 Feb 2025 03:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPb-0005Sw-VM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:32 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPY-0004aU-Jt
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953589; x=1771489589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DwB7fnwqRjP31Cbn8rb1uxbObLpHT+AdggbslqZmPsU=;
 b=nBsJXM1L0IVCzgBXFISNKdtwpuV3zVdenXeKBg0xbq/IzKSE9mNuO16x
 c1t+VUR1gcueakh+pUu/jVJMJv4Mt83Ry5oxz+NBXgJ/Tw/MFnJU5mtMp
 hB8TBWZd03NpXpQIVKk+LSTMlJKVSmMjbqij/aquRtKZ26Nyiu8xiIMqj
 xn5rtDwrIPgdjCUUOeNbVGYlLdIaYjvziQaUe2ao7B9F6wJL3CFB/K6kM
 4AJCSOwZ4/FHRp+wi+SbhSKzC0Rh3/gn5cw7dVqR+uEYOpQbsTW9bbBQu
 ejw65CERcUoB+LiLwPuQdTdY1tCDiUoqa1WQOpjPw44a8hkWIyy99TRvd g==;
X-CSE-ConnectionGUID: qrZancl4TtKo7JIiI6KoOg==
X-CSE-MsgGUID: luorRDEZRRmF4NbjF/mKiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544098"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544098"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:27 -0800
X-CSE-ConnectionGUID: /PW0ZOciRkmss4EAucLceA==
X-CSE-MsgGUID: iXWbtxWUTN6qeovslgMyog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851023"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:23 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Date: Wed, 19 Feb 2025 16:22:13 +0800
Message-Id: <20250219082228.3303163-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
utilizes them to attach to or detach from hwpt on host side.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 53639bf88b..175c4fe1f4 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -802,6 +802,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
 };
 
+static bool
+host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+
+    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+}
+
+static bool
+host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+
+    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
+}
+
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
@@ -863,11 +881,15 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
     hiodc->realize_late = hiod_iommufd_vfio_realize_late;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
+
+    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
+    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


