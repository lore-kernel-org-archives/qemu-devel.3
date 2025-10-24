Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3872CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7Fq-0004io-Km; Thu, 23 Oct 2025 22:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fn-0004i5-7J
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:07 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fl-0006Ox-9O
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761271805; x=1792807805;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OMRpVOoiVE3Dm3Nr2INaBpvRrtJigy0sE2j643DhDEE=;
 b=Sw2clFbB+5n8Thc8RudsjHBxqnv6I1X4LRY89vZcDkm9j1rR9SOjtron
 qx83kPA0QidIF+T/3yhHG7e9waS8+BiwkBh9djGy6Jv8vDiyokZdlRHrZ
 ALsI8owaK8Zq8Q8u4If0LOYQ3mUNI5wWVJLXF2nf04LLtAucMm1ZSHUj8
 Dtr1zqhc+iF+xQU+DqCwTlFFOnmTMDWBgdO0dlb4K90OxafF+l24x/hTU
 3Jfg9Ijaki1n4YtPD8Fwz9oDeodigREyNHoUSs4lxOD1sf7Uyqr2wRuMT
 6QZzld+1wTqHVpzBGCLbax1ah+xncXyN3XA+MHO+NvqJid8Vh8sWJ9Qrr w==;
X-CSE-ConnectionGUID: g4z5HD7xRfOWoPcieR69ig==
X-CSE-MsgGUID: XkeYTnkFTD2tBD4X9nSWVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62662153"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62662153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:04 -0700
X-CSE-ConnectionGUID: cNKOW2NJRl+G6mtFPI1wyw==
X-CSE-MsgGUID: 1tjqu2K/QeuEEgTIKsI3HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="189440783"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 5/8] vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
 flag support
Date: Thu, 23 Oct 2025 22:09:19 -0400
Message-ID: <20251024020922.13053-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024020922.13053-1-zhenzhong.duan@intel.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
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

Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last dirty
bitmap query right before unmap, no PTEs flushes. This accelerates the
query without issue because unmap will tear down the mapping anyway.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 include/system/iommufd.h | 2 +-
 backends/iommufd.c       | 5 +++--
 hw/vfio/iommufd.c        | 5 +++--
 backends/trace-events    | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index a659f36a20..767a8e4cb6 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -64,7 +64,7 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
-                                      Error **errp);
+                                      uint64_t flags, Error **errp);
 bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       uint32_t data_type, uint32_t entry_len,
                                       uint32_t *entry_num, void *data,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index fdfb7c9d67..086bd67aea 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -361,7 +361,7 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
                                       uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
-                                      Error **errp)
+                                      uint64_t flags, Error **errp)
 {
     int ret;
     struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
@@ -371,11 +371,12 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
         .length = size,
         .page_size = page_size,
         .data = (uintptr_t)data,
+        .flags = flags,
     };
 
     ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
     trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
-                                           page_size, ret ? errno : 0);
+                                           flags, page_size, ret ? errno : 0);
     if (ret) {
         error_setg_errno(errp, errno,
                          "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index b59a8639c6..ba5c6b6586 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -74,7 +74,8 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
+            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                    IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR,
                                                     iotlb->translated_addr,
                                                     &local_err);
             if (ret) {
@@ -231,7 +232,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
         if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
                                               iova, size, page_size,
                                               (uint64_t *)vbmap->bitmap,
-                                              errp)) {
+                                              backend_flag, errp)) {
             return -EINVAL;
         }
     }
diff --git a/backends/trace-events b/backends/trace-events
index 56132d3fd2..e1992ba12f 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -19,5 +19,5 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
+iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-- 
2.47.1


