Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F0ED68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7Ty-0003Kx-LW; Thu, 18 Dec 2025 01:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7Tx-0003KW-6A
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:25 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7Tu-00015T-Ld
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766039242; x=1797575242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QdZ1ubBQIL/oXabO9On2Or1ttJr/IWvuDU6xXkUi2/c=;
 b=fakLYqLJ6McWm7+Zvj3vJAGoRJOkzFUNrIoniKyT7cG8ALoir6oNTGNI
 sNK2YlXs6BnfBqEKstHkgfwPPXgnNx7VhdOaLQrHddG/n3aw8hEl3SCr+
 UppmLldpgWDCXYbBw6ma6Zpt0F4sJlGMlDmdhpqaLP/6gF9BUL2Q+FxT3
 Tp176jR8g9IOGbytztnwC00nuviJg1+BfSl5cEmj0BOadxqmsFRgxiZKM
 XYYBfmvdw5lk5ikORctUjhY2l4HEbuL/qQ3ASlo6OppnHcwbK9Yumvbhr
 nsATVJb0zMzQ+f2VNaYDd78jEBrqvgbIrgpYkoTmKXMgfnURL0SA4Hqu+ Q==;
X-CSE-ConnectionGUID: i9aX1W84SzSJTbEQy+a9ug==
X-CSE-MsgGUID: ZsqwsqvnT9ypMw+5mPZHKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68028499"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="68028499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:19 -0800
X-CSE-ConnectionGUID: cXArXbc+SiC75uqlxnMlpg==
X-CSE-MsgGUID: /C2ySSYGSJ2hfn6gDv+L7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203569840"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:17 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 1/9] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Date: Thu, 18 Dec 2025 01:26:22 -0500
Message-ID: <20251218062643.624796-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251218062643.624796-1-zhenzhong.duan@intel.com>
References: <20251218062643.624796-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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

Currently we support device and iommu dirty tracking, device dirty tracking
is preferred.

Add the framework code in iommufd_cdev_unmap() to choose either device or
iommu dirty tracking, just like vfio_legacy_dma_unmap_one().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 hw/vfio/iommufd.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ca8a6b7029..b527c7d1eb 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -61,14 +61,42 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+    IOMMUFDBackend *be = container->be;
+    uint32_t ioas_id = container->ioas_id;
+    bool need_dirty_sync = false;
+    Error *local_err = NULL;
+    int ret;
 
     if (unmap_all) {
         size = UINT64_MAX;
     }
 
-    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
-    return iommufd_backend_unmap_dma(container->be,
-                                     container->ioas_id, iova, size);
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
+
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
 }
 
 static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
-- 
2.47.1


