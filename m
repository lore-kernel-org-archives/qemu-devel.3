Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A162AC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GAv-0005cI-1O; Tue, 22 Apr 2025 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6t-0000xI-7v
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6p-0005Ax-Mc
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Lz6eAxAIRUx4pWmhwnEBF3UCRDTtOpuJujqppHSUi0=;
 b=LMmp6S6GLpKIxMwHhYbf6+q3v5hqSPDKJNYz+kCzjnsy9gBzqBRjBoGAXHIuD5MiwC4TlS
 JnG4ZaPlCWolcz8biMb/CXfYexff28wf8caXtCXGZ/YbdW0aPZYRU6lFrN7Kl1LfufTUbw
 hdCRrUINl2CFDigSgkwzNje9W+GZTOQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-inl1zmUiMb2RfS9cuRVnmw-1; Tue,
 22 Apr 2025 12:04:20 -0400
X-MC-Unique: inl1zmUiMb2RfS9cuRVnmw-1
X-Mimecast-MFC-AGG-ID: inl1zmUiMb2RfS9cuRVnmw_1745337859
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DED3C180056F; Tue, 22 Apr 2025 16:04:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4875018001DA; Tue, 22 Apr 2025 16:04:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 31/37] vfio: Rename vfio_get_dirty_bitmap()
Date: Tue, 22 Apr 2025 18:02:18 +0200
Message-ID: <20250422160224.199714-32-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Rename to vfio_container_query_dirty_bitmap() to be consistent with
the VFIO container routine naming scheme.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-32-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 4 ++--
 hw/vfio/common.c                      | 6 +++---
 hw/vfio/container-base.c              | 5 +++--
 hw/vfio/container.c                   | 2 +-
 hw/vfio/trace-events                  | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 163d9b3c30b3093d2f40bb3d3ffc0314519ac285..a441932be779e5c6740da78f005ed2c8320e7cb2 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -93,8 +93,8 @@ bool vfio_container_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer);
 bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainerBase *bcontainer);
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp);
+int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d063ea03c1cb4f475d421e626c703875fecd97a8..26ced6d4fb04b0dedf399686db40acaca5d85552 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1003,7 +1003,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         goto out_unlock;
     }
 
-    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
+    ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
     if (ret) {
         error_prepend(&local_err,
@@ -1040,7 +1040,7 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
                                 &local_err);
     if (ret) {
         error_report_err(local_err);
@@ -1134,7 +1134,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
     ram_addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
-    return vfio_get_dirty_bitmap(bcontainer,
+    return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
                                  int128_get64(section->size), ram_addr, errp);
 }
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index a094872fe44e90f345328f65795b0b64a090c1b1..4c39b6645464445255bd27342f2e2c2b8c16a6ce 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -237,7 +237,7 @@ static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
     return 0;
 }
 
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
@@ -275,7 +275,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
     dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
                                                          vbmap.pages);
 
-    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
+                                            dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ea03ed618f6aefe35f966c644cbbc127ce7bf06..c74e08e531a501313cab27c57728a8c940d975be 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -169,7 +169,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr, &local_err);
         if (ret) {
             error_report_err(local_err);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index d4cd09cb0f93485fe06984346f6ac927603c5745..aa0ba695fa38f7767bf506ec604046101186e7d4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -109,7 +109,7 @@ vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container-base.c
-vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 
 # region.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
-- 
2.49.0


