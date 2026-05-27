Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1395FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDMO-0002eD-Eq; Wed, 27 May 2026 08:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDMD-0002ct-60
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDM7-0001K1-DG
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779884843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fbwVE+8juyVYFcBW4+SIMpTSD+/jrX8QwDFkuJe/ug=;
 b=NsC9kb70sO2aBFjwEMWQIF36w3xWI23edyJ5CVSg0sBVwjDdtQ/0wm6XNY+wbNbE8ibBrd
 irUKquAc1u5Y8JWBuNZ407tFjyJjKHMZHQ0lDEzz5fR6SSDIkghphKKvhsQ6rCa5dmbYh0
 QCTeX/gJOfiN8owm6xyeOYCp7p7/GUg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-2g2N_ChhPLiJNNFTmVCNeA-1; Wed,
 27 May 2026 08:27:22 -0400
X-MC-Unique: 2g2N_ChhPLiJNNFTmVCNeA-1
X-Mimecast-MFC-AGG-ID: 2g2N_ChhPLiJNNFTmVCNeA_1779884841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 337E21956095; Wed, 27 May 2026 12:27:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CF6F30001BB; Wed, 27 May 2026 12:27:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 7/7] vfio/container: Restrict dma_map_file() to shared RAM or
 RAM devices
Date: Wed, 27 May 2026 14:27:00 +0200
Message-ID: <20260527122700.1589764-8-clg@redhat.com>
In-Reply-To: <20260527122700.1589764-1-clg@redhat.com>
References: <20260527122700.1589764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
not correct for private file-backed guest RAM.

dma_map_file() resolves PFNs from the backing file, but private guest
RAM mappings (MAP_PRIVATE) can run on different PFNs than the file
because they are subject to copy-on-write (COW) anomalies. As a result,
using dma_map_file() on a privately mapped RAMBlock can program DMA
against pages that do not back QEMU's actual guest memory.

Fix this by using dma_map_file() only for shared mapped RAMBlocks
(MAP_SHARED) or RAM device regions.

Fixes: fb32965b6dd8 ("vfio/iommufd: use IOMMU_IOAS_MAP_FILE")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220776
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260527101109.71781-1-chenyi.qiang@intel.com
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4c2816b5741fa5232f104fb16fe919f7642f2a36..56bd9ac0095df7b0f4da85f1d8dcb8d571fa9f2a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -74,15 +74,43 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
     bcontainer->space = space;
 }
 
+static bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer,
+                                            MemoryRegion *mr, int *fd)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    RAMBlock *rb = mr->ram_block;
+
+    if (!vioc->dma_map_file || !rb) {
+        return false;
+    }
+
+    *fd = qemu_ram_get_fd(rb);
+    if (*fd < 0) {
+        return false;
+    }
+
+    /*
+     * We can use IOMMU DMA mapping (IOMMU_IOAS_MAP_FILE) for :
+     *
+     * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
+     * 2) RAM device sub-regions (MMIO BARs)
+     *
+     * Private RAM mappings (MAP_PRIVATE) are strictly excluded. Because
+     * they are subject to copy-on-write (COW) anomalies, their underlying
+     * PFNs can permanently diverge from the backing file
+     */
+    return qemu_ram_is_shared(rb) || memory_region_is_ram_device(mr);
+}
+
 int vfio_container_dma_map(VFIOContainer *bcontainer,
                            hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-    RAMBlock *rb = mr->ram_block;
-    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
+    int mfd;
 
-    if (mfd >= 0 && vioc->dma_map_file) {
+    if (vfio_container_can_dma_map_file(bcontainer, mr, &mfd)) {
+        RAMBlock *rb = mr->ram_block;
         unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
         unsigned long offset = qemu_ram_get_fd_offset(rb);
 
-- 
2.54.0


