Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F80CAC582
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 02:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAib-00070g-RK; Tue, 09 Sep 2025 22:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAiZ-0006zr-N4
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:37:55 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAiO-0005fl-Pc
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757471864; x=1789007864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IDytYjxDTRyFHmWdI60FpD+xs5DrtvuV9RPonrF1C40=;
 b=P1qni6c1J0HA+zTmVqgw3W/ZMADQIaZx5tiMjL+epPcpQI4epCdSTb7s
 a3aGIEielW4tjVQkvEgxxVKMHvGRhIDVFO59Vnd/sMV8PyCxk/WY1ifvm
 IWbIQ4o0ZXEpJ3GGRyO7InrHGDJxm0z3/9hU/N4/0naXEbwX9skRhg0+e
 Ho5RNXyjZgIiEkBadgu761/ijsFbAhrUyBADib9fSfPbGxXasf2qnoJgK
 65SCYYu9fjrk8tTkbqui5o7C5wVmvrJnBNUj1IREjfqcM/NVpWjrgHACF
 HHul58p+m0ix3abbk7nMBGMFt51Zsj2LfFkaKhgjQHqikA6JPFOCPRL2B w==;
X-CSE-ConnectionGUID: is8t5F9WTQ2GOt19ufdP8Q==
X-CSE-MsgGUID: OJSPUJ4RQCmvzozuYMsYXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62402788"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="62402788"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:34 -0700
X-CSE-ConnectionGUID: emAKSSdbRiuTZK0Mr0FSkQ==
X-CSE-MsgGUID: Pgv23ujORpGp4heygaemaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="196930557"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/5] vfio/iommufd: Add framework code to support getting dirty
 bitmap before unmap
Date: Tue,  9 Sep 2025 22:36:57 -0400
Message-ID: <20250910023701.244356-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250910023701.244356-1-zhenzhong.duan@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
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

Currently we support device and iommu dirty tracking, device dirty
tracking is preferred.

Add the framework code in iommufd_cdev_unmap_one() to choose either
device or iommu dirty tracking, just like vfio_legacy_dma_unmap_one().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
---
 hw/vfio/iommufd.c | 56 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48c590b6a9..b5d6e54c45 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -58,33 +58,67 @@ static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
                                         iova, size, fd, start, readonly);
 }
 
-static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
-                              hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb, bool unmap_all)
+static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
+                                  hwaddr iova, ram_addr_t size,
+                                  IOMMUTLBEntry *iotlb)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    bool need_dirty_sync = false;
+    Error *local_err = NULL;
+    IOMMUFDBackend *be = container->be;
+    uint32_t ioas_id = container->ioas_id;
+    int ret;
+
+    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
+        if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
+            bcontainer->dirty_pages_supported) {
+            /* TODO: query dirty bitmap before DMA unmap */
+            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+        }
+
+        need_dirty_sync = true;
+    }
+
+    ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+    if (ret) {
+        return ret;
+    }
 
+    if (need_dirty_sync) {
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                iotlb->translated_addr,
+                                                &local_err);
+        if (ret) {
+            error_report_err(local_err);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
+                              hwaddr iova, ram_addr_t size,
+                              IOMMUTLBEntry *iotlb, bool unmap_all)
+{
     /* unmap in halves */
     if (unmap_all) {
         Int128 llsize = int128_rshift(int128_2_64(), 1);
         int ret;
 
-        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
-                                        0, int128_get64(llsize));
+        ret = iommufd_cdev_unmap_one(bcontainer, 0, int128_get64(llsize),
+                                     iotlb);
 
         if (ret == 0) {
-            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
-                                            int128_get64(llsize),
-                                            int128_get64(llsize));
+            ret = iommufd_cdev_unmap_one(bcontainer, int128_get64(llsize),
+                                         int128_get64(llsize), iotlb);
         }
 
         return ret;
     }
 
-    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-    return iommufd_backend_unmap_dma(container->be,
-                                     container->ioas_id, iova, size);
+    return iommufd_cdev_unmap_one(bcontainer, iova, size, iotlb);
 }
 
 static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
-- 
2.47.1


