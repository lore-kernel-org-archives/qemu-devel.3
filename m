Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021FCEA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpn9-00054J-Pf; Wed, 04 Feb 2026 22:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpn8-000546-GL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:26 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpn6-0001uy-Py
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770261145; x=1801797145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nG/Q1hP9oWffW3oHIIiKle9Emle1I2v65QDhot0QVng=;
 b=ByxnYGPLW0MYfKmJ8hvgL3+HSY/zfJE58/pj3mAvkzy2BAiytgnnaDTq
 uOQLRzs5HfQdwOK43sbGgilHDe9hJHDvjKzv5F2Z/PXjUV/o5bRf2ADnV
 xbF3dyfMwWjhKk72l2D6ZVGCurn3Z42KSpd0kKujjsEERJUmUPcx9nTFW
 2+wqKp5O2Y3TXnMSFxUER0mIyT6gD5ulCWxDUG/ITq4UpvYzof0IKyttb
 YL0zmjs0qt+BUoq869T3FpQHIG/zswpqVKQuxCVXn5xejeV0F9oBZEAit
 fbYMd/xb8NeTzdqzVbNlujOVsqNb9Yq+EPWiksjXm+8GCQI4BKa8uVSK1 Q==;
X-CSE-ConnectionGUID: J3zfWqTRQGi/keiAgUGq1g==
X-CSE-MsgGUID: q5T0L0c0S064NgKFhRF1aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96910426"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="96910426"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:23 -0800
X-CSE-ConnectionGUID: LCZ6MSW3ROyx3YQaXlRQNA==
X-CSE-MsgGUID: Gi1ZDFPpTbucWHssQQTHEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="209651982"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:20 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 02/14] vfio/iommufd: Implement pasid attach/detach
 callbacks in TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO
Date: Wed,  4 Feb 2026 22:11:20 -0500
Message-ID: <20260205031133.74357-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205031133.74357-1-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

2 new class functions are pasid_[at|de]tach_hwpt(). They are used to
attach/detach pasid to/from hwpt. VFIO and VDPA can have different
implementions, so implementation will be in sub-class instead of
HostIOMMUDeviceIOMMUFD, e.g., in HostIOMMUDeviceIOMMUFDVFIO.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c    | 47 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb83..96735f1fc8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -931,6 +931,51 @@ host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
 }
 
+static bool
+host_iommu_device_iommufd_vfio_pasid_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                                 uint32_t pasid,
+                                                 uint32_t hwpt_id,
+                                                 Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+    struct vfio_device_attach_iommufd_pt attach = {
+        .argsz = sizeof(attach),
+        .flags = VFIO_DEVICE_ATTACH_PASID,
+        .pasid = pasid,
+        .pt_id = hwpt_id,
+    };
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach)) {
+        error_setg_errno(errp, errno, "error attach %s pasid %d to id=%d",
+                         vbasedev->name, pasid, hwpt_id);
+        return false;
+    }
+
+    trace_hiod_iommufd_vfio_pasid_attach_hwpt(vbasedev->name, pasid, hwpt_id);
+    return true;
+}
+
+static bool
+host_iommu_device_iommufd_vfio_pasid_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                                 uint32_t pasid, Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+    struct vfio_device_detach_iommufd_pt detach = {
+        .argsz = sizeof(detach),
+        .pasid = pasid,
+        .flags = VFIO_DEVICE_DETACH_PASID,
+    };
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach)) {
+        error_setg_errno(errp, errno, "detach %s pasid %d failed",
+                         vbasedev->name, pasid);
+        return false;
+    }
+
+    trace_hiod_iommufd_vfio_pasid_detach_hwpt(vbasedev->name, pasid);
+    return true;
+}
+
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
@@ -993,6 +1038,8 @@ static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
 
     idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
     idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
+    idevc->pasid_attach_hwpt = host_iommu_device_iommufd_vfio_pasid_attach_hwpt;
+    idevc->pasid_detach_hwpt = host_iommu_device_iommufd_vfio_pasid_detach_hwpt;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 846e3625c5..2af6f46014 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -188,6 +188,8 @@ iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
 iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
+hiod_iommufd_vfio_pasid_attach_hwpt(const char *name, uint32_t paisd, uint32_t hwpt_id) " Successfully attached device %s pasid %d to id=%d"
+hiod_iommufd_vfio_pasid_detach_hwpt(const char *name, uint32_t paisd) " Successfully detached device %s pasid %d"
 
 # cpr-iommufd.c
 vfio_cpr_find_device(uint32_t ioas_id, int devid, uint32_t hwpt_id) "ioas_id %u, devid %d, hwpt_id %u"
-- 
2.47.3


