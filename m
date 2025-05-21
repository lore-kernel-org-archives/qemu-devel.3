Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EE9C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhTU-0005U9-U4; Wed, 21 May 2025 07:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTS-0005Sx-Ml
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:02 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTM-0006OF-7R
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826336; x=1779362336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qms8gWgZTbPWCsNrXc1g5v9D9gqBsNbzKGKEj46mU3I=;
 b=aFTPqwYKEEyMyHnc/u5W6EP2r6Zd3Oi1GkNX8Lm+WIWBDkVGpMA5VNjq
 oiCYWdLfNxvtrWbe3YMt2SGHZ7C6iFIlj8uqjvqVzi79iHtJx7PyyMtZ/
 au586mjPc4CnSTEc8cpiVMo3P7tfupdud0MS+1b+UTivdWqFLTr08kp6+
 M4PnAhr1Z5OTEqeq19xzsjbKCRW6ACeduMWudeg5u6lrEzXKhZUt8Feu9
 fNyJHM16cgJGOZwR3cZFhI1Hcjb68Yh39VXnbxJon5OeSubWTLDigoxpZ
 FXYXMW13zhoivImB6TMwPuxvyrPAXkykjBDi9hUv/natNWvPN5uvA2qMs g==;
X-CSE-ConnectionGUID: NoFkXc8lTbCFxSQxhSc+Xw==
X-CSE-MsgGUID: qJkBmtp2T9aq2XgzlgVMsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894898"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894898"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:56 -0700
X-CSE-ConnectionGUID: NvHU85HRQwO4bXuS07LAoA==
X-CSE-MsgGUID: PdRy/4DSTdeVCbbx+fYatw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158317"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv3 04/21] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Date: Wed, 21 May 2025 19:14:34 +0800
Message-Id: <20250521111452.3316354-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 5fde2b633a..d661737c17 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -810,6 +810,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
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
@@ -864,10 +882,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
+
+    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
+    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


