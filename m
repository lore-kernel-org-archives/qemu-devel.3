Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719E2CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDRp-0007E4-2d; Fri, 24 Oct 2025 04:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDR6-0006PF-1T
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:12 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDR1-0006Vx-3n
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295567; x=1792831567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sQ4rQABjPT4FizzJIvKbATx14Hbt5+8x/jbVvdDB6Rk=;
 b=Fpesn2QSJEzPxZZX6VXA2hgu9IjFxn5wkYtLyK4bZJmhUf0lCa5jsldb
 S9MLKdzpcR77Q0hmZT2Qzna1toswmZlfRqTC+PhAIOG25qVI3N4mUKo/f
 3ibfLAFy1M9SyH0eqzI4DomZEyNN1ekTY5+WMbuYu8G4o1A2sE2qQHBDJ
 SNz9pxZf3Ny8z1qMek/tAtOqUoTqoDjt4nrXlPxtQtLWzUzUoxiqLMxkM
 HIp1JCnk5Z6WlK9gt8DLRc0hOPggia9YxcEsrBjmdyR3Utj1+IUCLecm5
 xWVr/2xBJYzNEG8uQFHw5whaDi18AiPjxTEcJXyUNRo5ndh0SkV7iXFTa w==;
X-CSE-ConnectionGUID: 9NN3qBWpQe6H7VpiosvFeQ==
X-CSE-MsgGUID: YqvzpCOKQeiTiOB3TFDs3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504903"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504903"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:55 -0700
X-CSE-ConnectionGUID: 4QGJJ0xORQS3ewrLu3G/xQ==
X-CSE-MsgGUID: 3MlgoxSSRaO4FUIAzD8Nrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183986069"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
Date: Fri, 24 Oct 2025 04:43:44 -0400
Message-ID: <20251024084349.102322-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When doing ditry tracking or calculating dirty tracking range, readonly
regions can be bypassed, because corresponding DMA mappings are readonly
and never become dirty.

This can optimize dirty tracking a bit for passthrough device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/listener.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 0862b2b834..cbd86c79af 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -828,7 +828,8 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
         container_of(listener, VFIODirtyRangesListener, listener);
     hwaddr iova, end;
 
-    if (!vfio_listener_valid_section(section, false, "tracking_update") ||
+    /* Bypass readonly section as it never become dirty */
+    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
         !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
@@ -1087,6 +1088,12 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if (!mr) {
         goto out_unlock;
     }
+
+    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {
+        rcu_read_unlock();
+        return;
+    }
+
     translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
@@ -1222,7 +1229,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     int ret;
     Error *local_err = NULL;
 
-    if (vfio_listener_skipped_section(section, false)) {
+    if (vfio_listener_skipped_section(section, true)) {
         return;
     }
 
-- 
2.47.1


