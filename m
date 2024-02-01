Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6043EC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRXB-0005Wi-Nd; Thu, 01 Feb 2024 02:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRX9-0005VA-MK
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:51 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRX7-0001dL-U6
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772649; x=1738308649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L1Ps1z7JR0EkT48WfCZvtyE+oHYsvw5z4u4xqJeBqVQ=;
 b=hyLcv/bF3JGtS/L1BoYxR7le4NuzLY5oezXOFlEO+Zge7xilS4VnhaNi
 PMEwXR4/E/eNslAZFFxKp2vTvEh5Nq4GZWwg/OxTc1rvQeRI924oQXd6f
 loEE0iy7JiZ0aPTLCsu1h4uux25+4qhjgh2EQKUHTiTD6lk06YQES+D+6
 XF/Fnj7oWNUhiKYdRsYTaPAfKvEFwHjdiivM5bfdM0jTGRHjrp4NVRJ11
 ngdMOW3E80BrsdRJc8ROIfe21aOTVWpJG4qGdPw2xUioaAoqgwbPy5dw+
 lxIsNsXAYEK+sUg9lm7hHGadkuIUMlB+cm9VkFeiARmvUMbFOD4v3Uk62 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676700"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676700"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443242"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:43 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 06/18] vfio: Introduce host_iommu_device_init callback
Date: Thu,  1 Feb 2024 15:28:06 +0800
Message-Id: <20240201072818.327930-7-zhenzhong.duan@intel.com>
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

Introduce host_iommu_device_init callback and a wrapper for it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 1 +
 include/hw/vfio/vfio-container-base.h | 1 +
 hw/vfio/common.c                      | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 24e3eaaf3d..9c4b60c906 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -216,6 +216,7 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_attach_device(char *name, VFIODevice *vbasedev,
                        AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
+void host_iommu_device_init(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b2813b0c11..c71f4abb2d 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -120,6 +120,7 @@ struct VFIOIOMMUClass {
     int (*attach_device)(const char *name, VFIODevice *vbasedev,
                          AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
+    void (*host_iommu_device_init)(VFIODevice *vbasedev);
     /* migration feature */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
                                    bool start);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8b3b575c9d..f7f85160be 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1521,3 +1521,11 @@ void vfio_detach_device(VFIODevice *vbasedev)
     }
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
+
+void host_iommu_device_init(VFIODevice *vbasedev)
+{
+    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
+
+    assert(ops->host_iommu_device_init);
+    ops->host_iommu_device_init(vbasedev);
+}
-- 
2.34.1


