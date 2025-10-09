Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36520CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 04:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6hrQ-0005o2-Cu; Thu, 09 Oct 2025 00:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrN-0005nX-NY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:34 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrA-0002at-6W
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759982540; x=1791518540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=evj+FWN+i7qsqXS7v2uC/zwnpEBYRbN8B5CyZzFZPpE=;
 b=Of3iehMqD8yZE5aC4YlpeB2I8ZY9f+57I6CfikbzQYjMxfbnJqZN3Mv5
 4J6DKAbis3AEZpoJIkTumhPJ31/JTFdFp0tkooJnvW/xIBtX592bo78Xu
 nEbaYY61YcevtOPGJxlBdx4eQMUku9QcrqrhIh/w67AwsFcoSbxVcbqHi
 VpOCYp57ZVE8l5qmCnQ8xWn7iKf7HtnJ4t8dw8NFh7eqnyFmSwHUNmn+Z
 hGfgFEVUBm7pm+efvHpA+fagwiut312KgudfQw1NwL/do7tsQs21wF2zn
 q9bUHfhga3s/EzbXZyInHwGsX6kPqe5AQ0syZz+G7S3WNTcifTCz43tHB w==;
X-CSE-ConnectionGUID: PttsmK2iSXKJbj6ZhKy9Yw==
X-CSE-MsgGUID: 6lRjydUhRz+xQ4Ic7oGa/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="84804130"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="84804130"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:15 -0700
X-CSE-ConnectionGUID: SmsCK5cBRrWfAIDz6N2tuw==
X-CSE-MsgGUID: v4yxI6IcSP6snJtCvpi+2g==
X-ExtLoop1: 1
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 levon@movementarian.org, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/3] vfio/container: Support unmap all in one ioctl()
Date: Thu,  9 Oct 2025 00:01:32 -0400
Message-ID: <20251009040134.334251-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251009040134.334251-1-zhenzhong.duan@intel.com>
References: <20251009040134.334251-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

VFIO type1 kernel uAPI supports unmapping whole address space in one call
since commit c19650995374 ("vfio/type1: implement unmap all"). Use the
unmap_all variant whenever it's supported in kernel.

Opportunistically pass VFIOLegacyContainer pointer in low level function
vfio_legacy_dma_unmap_one().

Co-developed-by: John Levon <levon@movementarian.org>
Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-legacy.h |  1 +
 hw/vfio/container-legacy.c              | 38 ++++++++++++++-----------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index 74a72df018..ffd594e80d 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -30,6 +30,7 @@ struct VFIOLegacyContainer {
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    bool unmap_all_supported;
     QLIST_HEAD(, VFIOGroup) group_list;
     VFIOContainerCPR cpr;
 };
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index a3615d7b5d..8e9639603e 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -121,14 +121,14 @@ unmap_exit:
     return ret;
 }
 
-static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
+static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
                                      hwaddr iova, uint64_t size,
-                                     IOMMUTLBEntry *iotlb)
+                                     uint32_t flags, IOMMUTLBEntry *iotlb)
 {
-    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOContainer *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
-        .flags = 0,
+        .flags = flags,
         .iova = iova,
         .size = size,
     };
@@ -170,25 +170,28 @@ static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
                                  hwaddr iova, uint64_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    uint32_t flags = 0;
     int ret;
 
     if (unmap_all) {
-        /* The unmap ioctl doesn't accept a full 64-bit span. */
-        Int128 llsize = int128_rshift(int128_2_64(), 1);
-
-        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
-                                        iotlb);
+        if (container->unmap_all_supported) {
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
+        } else {
+            /* The unmap ioctl doesn't accept a full 64-bit span. */
+            Int128 llsize = int128_rshift(int128_2_64(), 1);
+            size = int128_get64(llsize);
+
+            ret = vfio_legacy_dma_unmap_one(container, 0, size, flags, iotlb);
+            if (ret) {
+                return ret;
+            }
 
-        if (ret == 0) {
-            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
-                                            int128_get64(llsize), iotlb);
+            iova = size;
         }
-
-    } else {
-        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
     }
 
-    return ret;
+    return vfio_legacy_dma_unmap_one(container, iova, size, flags, iotlb);
 }
 
 static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
@@ -519,6 +522,9 @@ static bool vfio_legacy_setup(VFIOContainer *bcontainer, Error **errp)
 
     vfio_get_info_iova_range(info, bcontainer);
 
+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+    container->unmap_all_supported = !!ret;
+
     vfio_get_iommu_info_migration(container, info);
     return true;
 }
-- 
2.47.1


