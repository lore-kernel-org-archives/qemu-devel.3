Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599F606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4Kd/Jfu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ61H-0006d9-Et; Tue, 20 Oct 2026 05:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xJ61E-0006ca-PL; Tue, 20 Oct 2026 05:20:28 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xJ61C-0005a1-U3; Tue, 20 Oct 2026 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792488027; x=1824024027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TAgvGLOWI9Chkci17NS5yDTUXJK9XtNPNA6AGF5v4NY=;
 b=L4Kd/JfuRk4gYdRqVpZN6YoFOQRyhm+sxGdyS1dqpU6YvzF0HS8Ks2Tf
 QHPwiyBYwHTZ7iogssDFPJpEVvqdBMPA2iEnqjgR3EjBJ9lbKkfdTBtzI
 c1JJfM0hI9d2+6T9syHg4n4REzB93nUiqsEKU2BnSNbugcsNpGY3An+dN
 l023WraG9wslvtU2ziiBL2scBMzTZsig2v0nar1FReF5ZznbOm+PX+qc+
 RWJ95qMZ6coLdqzPL4ZxqEaiwXVhvJHRMOj4Z4JT6UFEnqrHwSCvErTZU
 8nLWBY0hb2C+wV9AkRjt+q0g8cK+4SF21pC7RK61G+O+DrqJxXtDcymoi g==;
X-CSE-ConnectionGUID: UMMgsVRBRAuJbXa0xT0zSQ==
X-CSE-MsgGUID: PnBFq4goQuW89oy/jmvRTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1080654"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1080654"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:20:25 -0700
X-CSE-ConnectionGUID: xjf60/YDR0egiDZuUwm9rg==
X-CSE-MsgGUID: MgW6ErWES0CfpjfY+5iGIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3138335"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:20:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, qemu-arm@nongnu.org
Subject: [PATCH v9 3/6] backends/iommufd: Extend iommufd_backend_alloc_hwpt()
 with fault_id
Date: Tue, 20 Oct 2026 17:19:51 +0800
Message-ID: <20261020091955.1607161-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261020091955.1607161-1-zhenzhong.duan@intel.com>
References: <20261020091955.1607161-1-zhenzhong.duan@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We should set flags IOMMU_HWPT_FAULT_ID_VALID when pass in a fault
object id in the caller.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/system/iommufd.h    | 4 ++--
 backends/iommufd.c          | 7 ++++---
 hw/arm/smmuv3-accel.c       | 6 +++---
 hw/i386/intel_iommu_accel.c | 2 +-
 hw/vfio/iommufd.c           | 2 +-
 backends/trace-events       | 2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 36b34b4899..79b8dabfb6 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -90,8 +90,8 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-                                void *data_ptr, uint32_t *out_hwpt,
-                                Error **errp);
+                                void *data_ptr, uint32_t fault_id,
+                                uint32_t *out_hwpt, Error **errp);
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
                                   void *data_ptr, uint32_t data_len,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2775eef741..f46b3bfa7e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -315,8 +315,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
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
@@ -327,11 +327,12 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
         .data_type = data_type,
         .data_len = data_len,
         .data_uptr = (uintptr_t)data_ptr,
+        .fault_id = fault_id,
     };
 
     ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
     trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
-                                     data_len, (uintptr_t)data_ptr,
+                                     data_len, (uintptr_t)data_ptr, fault_id,
                                      alloc_hwpt.out_hwpt_id, ret);
     if (ret) {
         error_setg_errno(errp, errno, "Failed to allocate hwpt");
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 91aca1aa14..66e6a5011a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -268,7 +268,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
                                     accel->viommu->viommu_id, flags,
                                     IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(nested_data), &nested_data,
-                                    &hwpt_id, errp)) {
+                                    0, &hwpt_id, errp)) {
             return NULL;
     }
 
@@ -632,14 +632,14 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
     if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
                                     0, IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(abort_data), &abort_data,
-                                    &accel->abort_hwpt_id, errp)) {
+                                    0, &accel->abort_hwpt_id, errp)) {
         goto free_viommu;
     }
 
     if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
                                     0, IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(bypass_data), &bypass_data,
-                                    &accel->bypass_hwpt_id, errp)) {
+                                    0, &accel->bypass_hwpt_id, errp)) {
         goto free_abort_hwpt;
     }
 
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index c3677775e9..c8f2835204 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -100,7 +100,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
     return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
                                       hiodi->hwpt_id, flags,
                                       IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
-                                      fs_hwpt_id, errp);
+                                      0, fs_hwpt_id, errp);
 }
 
 static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index de482128bf..90ddb54f4c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -486,7 +486,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
-                                    &hwpt_id, errp)) {
+                                    0, &hwpt_id, errp)) {
         return false;
     }
 
diff --git a/backends/trace-events b/backends/trace-events
index b1c1d89dd8..2f242feb78 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -16,7 +16,7 @@ iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
-iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t fault_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" fault_id=%u out_hwpt=%u (%d)"
 iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-- 
2.52.0


