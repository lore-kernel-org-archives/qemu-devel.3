Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D7D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqo-0002sq-Td; Tue, 13 Jan 2026 04:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaql-0002hV-Q0
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqj-0003Rl-5K
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8gk1bCnKu8Te7ra5bmjoWf+dUR7+QJGGaFv+IG328A=;
 b=Cafh9F2ifJzlXM9WRuNyKdXTPjg/y8i48rLUt+6+cjPH2edz2ajh1DgkBjXx82n56/8/nz
 ky/u2MBU/wwUs2pxj0IG5hoq+Q87j71v/UkQk86OVzhKgHCd/hOdQLM1JIT+V+rHWkYoo3
 SHmZGwhzntcvqIqcbxu2jmGr5nEuU1k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-ng4U8bwcO6inJuzuB5pOvA-1; Tue,
 13 Jan 2026 04:38:00 -0500
X-MC-Unique: ng4U8bwcO6inJuzuB5pOvA-1
X-Mimecast-MFC-AGG-ID: ng4U8bwcO6inJuzuB5pOvA_1768297079
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FAAE1955DD1; Tue, 13 Jan 2026 09:37:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F3DD30001A8; Tue, 13 Jan 2026 09:37:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>
Subject: [PULL 26/41] vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
 flag support
Date: Tue, 13 Jan 2026 10:36:22 +0100
Message-ID: <20260113093637.1549214-27-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

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
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-6-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/iommufd.h | 2 +-
 backends/iommufd.c       | 5 +++--
 hw/vfio/iommufd.c        | 5 +++--
 backends/trace-events    | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 9f5eb872454a8d09d1b9e8c6d5dd50fa2a832068..1392706b83ae38501f543a7c65ebc3528e3d295f 100644
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
index fdfb7c9d67197da11d35290ba2f44e0b005c2690..086bd67aeacbf6d2ae56031f7d39e2951956c2b2 100644
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
index a3fb674f50eea549d0aaaaa7138e8981d343697d..0bf68620d2c9a7a5e21553b9cc275e627b73327f 100644
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
index 56132d3fd22b5a217b07349c74f17e50d553a799..e1992ba12f0409f020b5456831c16919b55e9c32 100644
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
2.52.0


