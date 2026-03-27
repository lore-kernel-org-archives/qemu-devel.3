Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7101C10A88E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xJb-0005Yq-2J; Thu, 26 Mar 2026 22:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJZ-0005Xk-GY; Thu, 26 Mar 2026 22:52:49 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJX-00083n-Kg; Thu, 26 Mar 2026 22:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774579968; x=1806115968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9of5pivnPhQUXMSB+06b0S6dhtFK7zmVDYOCgP/18KA=;
 b=RXHcKMo5KoMDqLTPjzQZTqNtdNjfPjFMfzwuoubwLXeS1IdcEdOQEtsi
 etuz3kobSKXifO8fLwyplB859MQ1R3vc9t4Y0AklOCGxJ51rBkM9EsI1O
 3kn8WOtr1Oh2m61zCe0GEaBfr215V+YmQN4KaJNOdnzGTDy4+j4gp63s6
 vKkGDTwdl2o0mb8RK6DPALfWL2SIrNKXu5Vjcj8iMhTma5FzyOD6eA3rM
 FCDkQ9BVxhpiRCc6vJ6v2m9Fa3JUu+qXdZajizYMLLv6mqMOZQnJzxptI
 7mNrZAKUiB5q77OwzkbFhNUour+7sT4FGHl6Q+YTptnvcQptzqGt4ODb6 A==;
X-CSE-ConnectionGUID: lAqDTJLIQI+MKZjBxHPnLQ==
X-CSE-MsgGUID: MjayH4rXTi+CA7C3vg1MKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75719887"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75719887"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:45 -0700
X-CSE-ConnectionGUID: 1T5l6teDQhOXaTgXMGB6xQ==
X-CSE-MsgGUID: 1aLT35MvQT+jNqkaSBk2Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221874383"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 2/5] backends/iommufd: Extend iommufd_backend_alloc_hwpt()
 with fault_id
Date: Thu, 26 Mar 2026 22:52:24 -0400
Message-ID: <20260327025228.474257-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327025228.474257-1-zhenzhong.duan@intel.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
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

No need to force caller to set IOMMU_HWPT_FAULT_ID_VALID, we take it
by checking fault_id nonzero.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h    |  4 ++--
 backends/iommufd.c          | 13 +++++++++----
 hw/arm/smmuv3-accel.c       |  6 +++---
 hw/i386/intel_iommu_accel.c |  2 +-
 hw/vfio/iommufd.c           |  2 +-
 backends/trace-events       |  2 +-
 6 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index d4ba8434a5..f753bfaf69 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -85,8 +85,8 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-                                void *data_ptr, uint32_t *out_hwpt,
-                                Error **errp);
+                                void *data_ptr, uint32_t fault_id,
+                                uint32_t *out_hwpt, Error **errp);
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
                                   uint32_t *out_hwpt, Error **errp);
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 9496377a25..fe64badea0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -310,23 +310,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-                                void *data_ptr, uint32_t *out_hwpt,
-                                Error **errp)
+                                void *data_ptr, uint32_t fault_id,
+                                uint32_t *out_hwpt, Error **errp)
 {
     int ret, fd = be->fd;
     struct iommu_hwpt_alloc alloc_hwpt = {
         .size = sizeof(struct iommu_hwpt_alloc),
-        .flags = flags,
         .dev_id = dev_id,
         .pt_id = pt_id,
         .data_type = data_type,
         .data_len = data_len,
         .data_uptr = (uintptr_t)data_ptr,
+        .fault_id = fault_id,
     };
 
+    if (fault_id) {
+        flags |= IOMMU_HWPT_FAULT_ID_VALID;
+    }
+    alloc_hwpt.flags = flags;
+
     ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
     trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
-                                     data_len, (uintptr_t)data_ptr,
+                                     data_len, (uintptr_t)data_ptr, fault_id,
                                      alloc_hwpt.out_hwpt_id, ret);
     if (ret) {
         error_setg_errno(errp, errno, "Failed to allocate hwpt");
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 0af6b3296d..1e2fb1e748 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -224,7 +224,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
                                     accel->viommu->viommu_id, flags,
                                     IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(nested_data), &nested_data,
-                                    &hwpt_id, errp)) {
+                                    0, &hwpt_id, errp)) {
             return NULL;
     }
 
@@ -558,14 +558,14 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
                                     0, IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(abort_data), &abort_data,
-                                    &accel->abort_hwpt_id, errp)) {
+                                    0, &accel->abort_hwpt_id, errp)) {
         goto free_viommu;
     }
 
     if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
                                     0, IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(bypass_data), &bypass_data,
-                                    &accel->bypass_hwpt_id, errp)) {
+                                    0, &accel->bypass_hwpt_id, errp)) {
         goto free_abort_hwpt;
     }
 
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index e73695ff83..32cca7672a 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -115,7 +115,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
 
     return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
                                       flags, IOMMU_HWPT_DATA_VTD_S1,
-                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
+                                      sizeof(vtd), &vtd, 0, fs_hwpt_id, errp);
 }
 
 static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index dce4e4ce72..e4e8b266ab 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -444,7 +444,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
-                                    &hwpt_id, errp)) {
+                                    0, &hwpt_id, errp)) {
         return false;
     }
 
diff --git a/backends/trace-events b/backends/trace-events
index 6820a9939e..8a204fcb73 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -16,7 +16,7 @@ iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
-iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t fault_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" fault_id=%u out_hwpt=%u (%d)"
 iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%d fault_fd=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-- 
2.47.3


