Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57159CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JXA-0005t9-N6; Wed, 24 Sep 2025 03:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JX1-0005sN-LV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:17 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1JWx-0001S7-5T
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758697391; x=1790233391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dNcmfdsvuX6aE7sSUXiD+CERBr4qGcYNFF6mFluxEvg=;
 b=FgrZJ59qx+CtO4yTF8UJm85XTTls/T8wPVaQGVd7TvOoOJ96A2rVK1gQ
 SRa1CPlWeeu9H3Re2eieDr1JZroBPeLPXTGK/yRzoR0BcPH3zPONpdQHf
 r3QaemXo44N3aaEK/wWMkuAg+0h3CA0w8KMj/Q+LcYnzMYDU6cMMrgtEJ
 p4a8gbjHzNhSmPogrQQE5bJF9GYxbW4sypqZuEmxo8NjKpxmIMbmiPER6
 OcVMDBlwF/JK3ntPzYbc9LwLGzHPougWrAvaAgWwAKrVAOdHwBSvTJDTw
 0yxFcphPSfYEoigkn7AhqLT61Jd1qa5MZn+lwEw/NvKIBVnVC1rOe5qX9 A==;
X-CSE-ConnectionGUID: gv2svaqES9+dUSjSMXtiMQ==
X-CSE-MsgGUID: OO37tzm1Tq6p7lL6HhI8MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86429768"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="86429768"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:03:05 -0700
X-CSE-ConnectionGUID: YNarnhuqTG2F/qkmiNqcQA==
X-CSE-MsgGUID: 2yjNTUDLRVOJ0rY7/5SwcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="180975709"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 00:03:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Date: Wed, 24 Sep 2025 03:02:53 -0400
Message-ID: <20250924070254.1550014-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

VFIO type1 kernel uAPI supports unmapping whole address space in one call
since commit c19650995374 ("vfio/type1: implement unmap all"). use the
unmap_all variant whenever it's supported in kernel.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3f89..2e13f04803 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -122,12 +122,12 @@ unmap_exit:
 
 static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
                                      hwaddr iova, ram_addr_t size,
-                                     IOMMUTLBEntry *iotlb)
+                                     uint32_t flags, IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
-        .flags = 0,
+        .flags = flags,
         .iova = iova,
         .size = size,
     };
@@ -187,25 +187,32 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
+    uint32_t flags = 0;
     int ret;
 
     if (unmap_all) {
-        /* The unmap ioctl doesn't accept a full 64-bit span. */
-        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
 
-        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
-                                        iotlb);
+        assert(!iova && !size);
 
-        if (ret == 0) {
-            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
-                                            int128_get64(llsize), iotlb);
-        }
+        ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+        if (ret) {
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
+        } else {
+            /* The unmap ioctl doesn't accept a full 64-bit span. */
+            Int128 llsize = int128_rshift(int128_2_64(), 1);
+            size = int128_get64(llsize);
+
+            ret = vfio_legacy_dma_unmap_one(bcontainer, 0, size, flags, iotlb);
+            if (ret) {
+                return ret;
+            }
 
-    } else {
-        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
+            iova = size;
+        }
     }
 
-    return ret;
+    return vfio_legacy_dma_unmap_one(bcontainer, iova, size, flags, iotlb);
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-- 
2.47.1


