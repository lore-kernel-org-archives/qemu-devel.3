Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D30C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 06:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9xd-0007Xr-Em; Wed, 28 May 2025 02:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xW-0007Vj-Ka
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:15 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xT-0000mi-Mk
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748412492; x=1779948492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zo69rdRFcH7jyNGc0gnvUNf+sZ1XBR3BBsROGKmPTrc=;
 b=VzkvHixVmxTn9Z0+soJTGUdggOAws8vIqKEtAG7RwiM4691jy9NPIQFe
 uc0gTQ01tb8HauJ7/3vutWdm64zBj4tX5N5EKYIZ4NqXdAzBCTyYJcwMT
 JeP78H79VsU7FIwUy6IY2qOGuhnoFj9RYVsDUSo4GRes6tTjRmfrVSnR7
 +Kn+OJpIkYcfyRBnNOQNo4zB6CY2vnUW0+jc9fESluCzfFHI6fzwCVDO3
 mpy/1v74uBgMCS8wiQUn94sNLvyz5AMXaK7rEQ3ddbQl6TE9a1hrUfdR9
 5WnxLhk7FdWXfwU59UeeHLqatBO1nDu7KHeGWmVTu5gQ6vPH0QsexKfuO A==;
X-CSE-ConnectionGUID: R9tYFotAR369WWeHB5mDSg==
X-CSE-MsgGUID: /nFE6iSXQMuh6oojd3CUEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60678984"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="60678984"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:08:11 -0700
X-CSE-ConnectionGUID: hTBMEcqvRG+yQI0j2gSR6A==
X-CSE-MsgGUID: Mr5h2FvGQsC5ZRIt/SSqYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143165143"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:08:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 3/6] vfio/iommufd: Initialize iommufd specific members in
 HostIOMMUDeviceIOMMUFD
Date: Wed, 28 May 2025 14:04:06 +0800
Message-Id: <20250528060409.3710008-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There are three iommufd specific members in HostIOMMUDeviceIOMMUFD
that need to be initialized after attachment, they will all be used
by vIOMMU.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..5fde2b633a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -814,6 +814,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
     VFIODevice *vdev = opaque;
+    HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     enum iommu_hw_info_type type;
     union {
@@ -833,6 +834,11 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     caps->type = type;
     caps->hw_caps = hw_caps;
 
+    idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    idev->iommufd = vdev->iommufd;
+    idev->devid = vdev->devid;
+    idev->hwpt_id = vdev->hwpt->hwpt_id;
+
     return true;
 }
 
-- 
2.34.1


