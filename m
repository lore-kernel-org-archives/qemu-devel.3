Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5517C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhTH-0005R2-P3; Wed, 21 May 2025 07:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTG-0005Qa-26
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:18:50 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTD-0006N1-OT
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826328; x=1779362328;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vfIL30HAQQ5+DPDpCLGFtYH2ORFW/Eo3M2kxoN8TmDc=;
 b=htZEEHkdcijH/W3J9sZEcdYWYzs9JZrHmXiXdVMAkZON8Txvhv8L7etO
 Ncef07GTFgl4+k9W1YZlqoVbQKgK4DNcLWKB/6C5D6IQxV/mjxsqkz2Ym
 Mav/KIjJ4Q0IwzEKc3hRpWhnh+5HLOgbjJn90qsxgF+qTqm2gqMiwekrf
 cA1VUOlQ+iV7RXitZb5ulnGg26qGl/q8iuq9N2uhZm8lBDczo9W+lXas4
 3S4bN6lH+9XbJc9Yq8RXA32weMDKiIsIRS1U27Blvan0HJuhcC80DUp1Q
 9IJbt2u4wEz5hXd/Qc6C9pdoJzK0LGqf7IZpbvitbaygvYBDrnkc/D1kh A==;
X-CSE-ConnectionGUID: 4KCGxYDwS7ud9rwDy2bgvw==
X-CSE-MsgGUID: 8e0HtTHHRCG0XOoafLGzKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894872"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894872"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:47 -0700
X-CSE-ConnectionGUID: nEWXbSUcS7OZw1upa5dm2g==
X-CSE-MsgGUID: WapkNoOBSOql+56Z28Gz3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158308"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv3 02/21] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Date: Wed, 21 May 2025 19:14:32 +0800
Message-Id: <20250521111452.3316354-3-zhenzhong.duan@intel.com>
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

Enhance HostIOMMUDeviceIOMMUFD object with 3 new members, specific
to the iommufd BE + 2 new class functions.

IOMMUFD BE includes IOMMUFD handle, devid and hwpt_id. IOMMUFD handle
and devid are used to allocate/free ioas and hwpt. hwpt_id is used to
re-attach IOMMUFD backed device to its default VFIO sub-system created
hwpt, i.e., when vIOMMU is disabled by guest. These properties will be
initialized after attachment.

2 new class functions are [at|de]tach_hwpt(). They are used to
attach/detach hwpt. VFIO and VDPA can have different implementions,
so implementation will be in sub-class instead of HostIOMMUDeviceIOMMUFD,
e.g., in HostIOMMUDeviceIOMMUFDVFIO.

Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to
wrap the two functions.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h | 50 ++++++++++++++++++++++++++++++++++++++++
 backends/iommufd.c       | 22 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 5399519626..a704575662 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -67,4 +67,54 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
+                    HOST_IOMMU_DEVICE_IOMMUFD)
+
+/* Overload of the host IOMMU device for the iommufd backend */
+struct HostIOMMUDeviceIOMMUFD {
+    HostIOMMUDevice parent_obj;
+
+    IOMMUFDBackend *iommufd;
+    uint32_t devid;
+    uint32_t hwpt_id;
+};
+
+struct HostIOMMUDeviceIOMMUFDClass {
+    HostIOMMUDeviceClass parent_class;
+
+    /**
+     * @attach_hwpt: attach host IOMMU device to IOMMUFD hardware page table.
+     * VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @hwpt_id: ID of IOMMUFD hardware page table.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
+                        Error **errp);
+    /**
+     * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
+     * VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+};
+
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp);
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index c8788a6438..b114fb08e7 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -344,6 +344,26 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
     return !ret;
 }
 
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->attach_hwpt);
+    return idevc->attach_hwpt(idev, hwpt_id, errp);
+}
+
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->detach_hwpt);
+    return idevc->detach_hwpt(idev, errp);
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
@@ -382,6 +402,8 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
+        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
         .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
-- 
2.34.1


