Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DD9E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 14:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsi6y-00041d-P0; Wed, 18 Feb 2026 09:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6M-0003xX-Jr
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6J-0007Af-H0
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771423222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+FmMN620Ef1QiHzVSuMnoiNS27P80CU44pJ5h3ooyU=;
 b=Bmq7X/8K+rCqygZLEGecPMB7LqBB9VdzyX6bkWouQ7MOA7b6rGayUXJC12bPCnNGPLe5eU
 hl7wMQG2ySUxKD98nJVtkyLxvQaBHqefeT818mUFajlCOJ9oB9R/0Y5wNsi2AyoE4MnJzJ
 hvBX6G49yhyQpErL18/fndL7/XdXeBA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-rl99xc6eOnGevHOj0iG1Bw-1; Wed,
 18 Feb 2026 09:00:18 -0500
X-MC-Unique: rl99xc6eOnGevHOj0iG1Bw-1
X-Mimecast-MFC-AGG-ID: rl99xc6eOnGevHOj0iG1Bw_1771423217
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31CB7195FDC3; Wed, 18 Feb 2026 14:00:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44CF01956095; Wed, 18 Feb 2026 14:00:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/5] hw/vfio: align mmap to power-of-2 of region size for
 hugepfnmap
Date: Wed, 18 Feb 2026 15:00:02 +0100
Message-ID: <20260218140003.1554502-5-clg@redhat.com>
In-Reply-To: <20260218140003.1554502-1-clg@redhat.com>
References: <20260218140003.1554502-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ankit Agrawal <ankita@nvidia.com>

On Grace-based systems such as GB200, device memory is exposed as a
BAR but the actual mappable size is not power-of-2 aligned. The
previous algorithm aligned each sparse mmap area based on its
individual size using ctz64() which prevented efficient huge page
usage by the kernel.

Adjust VFIO region mapping alignment to use the next power-of-2 of
the total region size and place the sparse subregions at their
appropriate offset. This provides better opportunities to get huge
alignment allowing the kernel to use larger page sizes for the VMA.

This enables the use of PMD-level huge pages which can significantly
improve memory access performance and reduce TLB pressure for large
device memory regions.

With this change:
- Create a single aligned base mapping for the entire region
- Change Alignment to be based on pow2ceil(region->size), capped at 1GiB
- Unmap gaps between sparse regions
- Use MAP_FIXED to overlay sparse mmap areas at their offsets

Example VMA for device memory of size 0x2F00F00000 on GB200:

Before (misaligned, no hugepfnmap):
ff88ff000000-ffb7fff00000 rw-s 400000000000 00:06 727                    /dev/vfio/devices/vfio1

After (aligned to 1GiB boundary, hugepfnmap enabled):
ff8ac0000000-ffb9c0f00000 rw-s 400000000000 00:06 727                    /dev/vfio/devices/vfio1

Requires sparse regions to be sorted by offset (done in previous
patch) to correctly identify and handle gaps.

cc: Alex Williamson <alex@shazbot.org>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260217153010.408739-4-ankita@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/region.c | 86 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index d464eadf9c048e29981da8af48f8f86933a98ad5..47fdc2df349b65c6be6c9605b7a38a4e367f0475 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -344,8 +344,11 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
 
 int vfio_region_mmap(VFIORegion *region)
 {
-    int i, ret, prot = 0;
+    void *map_base, *map_align;
     Error *local_err = NULL;
+    int i, ret, prot = 0;
+    off_t map_offset = 0;
+    size_t align;
     char *name;
     int fd;
 
@@ -356,41 +359,61 @@ int vfio_region_mmap(VFIORegion *region)
     prot |= region->flags & VFIO_REGION_INFO_FLAG_READ ? PROT_READ : 0;
     prot |= region->flags & VFIO_REGION_INFO_FLAG_WRITE ? PROT_WRITE : 0;
 
-    for (i = 0; i < region->nr_mmaps; i++) {
-        size_t align = MIN(1ULL << ctz64(region->mmaps[i].size), 1 * GiB);
-        void *map_base, *map_align;
+    /*
+     * Align the mmap for more efficient mapping in the kernel. Ideally
+     * we'd know the PMD and PUD mapping sizes to use as discrete alignment
+     * intervals, but we don't. As of Linux v6.19, the largest PUD size
+     * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
+     * on x86_64).
+     *
+     * Align by power-of-two of the size of the entire region - capped
+     * by 1G - and place the sparse subregions at their appropriate offset.
+     * This will get maximum alignment.
+     *
+     * NB. qemu_memalign() and friends actually allocate memory, whereas
+     * the region size here can exceed host memory, therefore we manually
+     * create an oversized anonymous mapping and clean it up for alignment.
+     */
 
-        /*
-         * Align the mmap for more efficient mapping in the kernel.  Ideally
-         * we'd know the PMD and PUD mapping sizes to use as discrete alignment
-         * intervals, but we don't.  As of Linux v6.12, the largest PUD size
-         * supporting huge pfnmap is 1GiB (ARCH_SUPPORTS_PUD_PFNMAP is only set
-         * on x86_64).  Align by power-of-two size, capped at 1GiB.
-         *
-         * NB. qemu_memalign() and friends actually allocate memory, whereas
-         * the region size here can exceed host memory, therefore we manually
-         * create an oversized anonymous mapping and clean it up for alignment.
-         */
-        map_base = mmap(0, region->mmaps[i].size + align, PROT_NONE,
-                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-        if (map_base == MAP_FAILED) {
-            ret = -errno;
-            goto no_mmap;
-        }
+    align = MIN(pow2ceil(region->size), 1 * GiB);
 
-        fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
+    map_base = mmap(0, region->size + align, PROT_NONE,
+                    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (map_base == MAP_FAILED) {
+        ret = -errno;
+        trace_vfio_region_mmap_fault(memory_region_name(region->mem), -1,
+                                     region->fd_offset,
+                                     region->fd_offset + region->size - 1, ret);
+        return ret;
+    }
+
+    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
 
-        map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
-        munmap(map_base, map_align - map_base);
-        munmap(map_align + region->mmaps[i].size,
-               align - (map_align - map_base));
+    map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
+    munmap(map_base, map_align - map_base);
+    munmap(map_align + region->size,
+           align - (map_align - map_base));
 
-        region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
+    /*
+     * Regions should already be sorted by vfio_setup_region_sparse_mmaps().
+     * This is critical for the following algorithm which relies on range
+     * offsets being in ascending order.
+     */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
+        region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
+                                     region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED, fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
             ret = -errno;
+            /*
+             * Only unmap the rest of the region. Any mmaps that were successful
+             * will be unmapped in no_mmap.
+             */
+            munmap(map_align + region->mmaps[i].offset,
+                   region->size - region->mmaps[i].offset);
             goto no_mmap;
         }
 
@@ -408,6 +431,15 @@ int vfio_region_mmap(VFIORegion *region)
                                region->mmaps[i].offset,
                                region->mmaps[i].offset +
                                region->mmaps[i].size - 1);
+
+        map_offset = region->mmaps[i].offset + region->mmaps[i].size;
+    }
+
+    /*
+     * Unmap the rest of the region not covered by sparse mmap.
+     */
+    if (map_offset < region->size) {
+        munmap(map_align + map_offset, region->size - map_offset);
     }
 
     if (!vfio_region_create_dma_buf(region, &local_err)) {
-- 
2.53.0


