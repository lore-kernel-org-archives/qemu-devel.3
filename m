Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D992BC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrsh7-0001r4-Ja; Thu, 06 Aug 2026 03:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wrsh1-0001qL-9x; Thu, 06 Aug 2026 03:39:07 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wrsgy-0001fK-JZ; Thu, 06 Aug 2026 03:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786001945; x=1817537945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=djt+udsFNCQ7XOrAXypuLFNgTqrtaXEmtxR9D05tdJk=;
 b=b0+/PhMdOF7H8eNGaf5fYAUxc9KLhtSSCGp9689kfuGPws6BJqzRk5DQ
 X7yz0SyO7sHoa5eoHqnEw6FbhIwql7M7wVhahtjc59aM7mly6aFSMoHzr
 OnKH4Js5YmgtA6zcU7E9flgp2Y3Z5C1trXm/5AUAolz5bS8pH4YjDudCO
 +XKmt4FAg0ROLkhwyez3PuoCISjPZWosJrzah8WqkSvDYlKfl3EAwH8gq
 a9RzSSMV9I8lY52+jcGShKDuJKFbcKU3Hgn542KzVMKNu5MjpnogdC2iL
 xaOQZFpJvF2keszqOeXPPqzB46BRX+HclzrJHdgiSIyp3OD0iSapUF4i/ w==;
X-CSE-ConnectionGUID: MaanLKGGRMe22x8NKhbeGg==
X-CSE-MsgGUID: BqKF53S3T2SfZUooXVbqMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86662716"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86662716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:39:02 -0700
X-CSE-ConnectionGUID: GKE8Re1IRvucGXEQ79RuDw==
X-CSE-MsgGUID: sLc6gmNMTzCtETpHiR2udA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="265506987"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:38:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v3 3/6] backends/iommufd: Extend iommufd_backend_alloc_hwpt()
 with fault_id
Date: Thu,  6 Aug 2026 03:38:21 -0400
Message-ID: <20260806073825.363468-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260806073825.363468-1-zhenzhong.duan@intel.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We should set flags IOMMU_HWPT_FAULT_ID_VALID when pass in a fault
object id in the caller.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
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
index c287767b11..924129d7f9 100644
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
index fccd4e660c..6051c57cac 100644
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
index c03435f8a2..d2f41f18f1 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -94,7 +94,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
     return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
                                       hiodi->hwpt_id, flags,
                                       IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
-                                      fs_hwpt_id, errp);
+                                      0, fs_hwpt_id, errp);
 }
 
 static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6ff668d259..0dc7929ad9 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -476,7 +476,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
-                                    &hwpt_id, errp)) {
+                                    0, &hwpt_id, errp)) {
         return false;
     }
 
diff --git a/backends/trace-events b/backends/trace-events
index dbbc8ea7cd..83d5923198 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -16,7 +16,7 @@ iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
-iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t fault_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" fault_id=%u out_hwpt=%u (%d)"
 iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, int fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-- 
2.52.0


