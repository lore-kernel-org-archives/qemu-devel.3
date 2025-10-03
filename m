Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDA8CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4d6v-0006S3-Ms; Fri, 03 Oct 2025 06:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6p-0006Iz-JS
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6b-0004ha-D5
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759487617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drSaV2nEN3V2QE7nAk4YSznY/BiUAQ8JU0mtLWv0LIg=;
 b=DpP8uUGCE1zSd+siYCVSYgicmw7L8nfwkK61x/lquphlSC7CUsS03CzGZaLoWcUhbKHngc
 LnbBpN8ilaf8iuFFU6XlKRpGuVNi7NNNt0T81ugJBobA0xKVgpDVKW4GzkVl8TWqMwn4a1
 TfcwdRzBAOSgf6y6hJQJvJRTjhJzBQg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-skVUKRxlOB6n9P68i5SP1A-1; Fri,
 03 Oct 2025 06:33:36 -0400
X-MC-Unique: skVUKRxlOB6n9P68i5SP1A-1
X-Mimecast-MFC-AGG-ID: skVUKRxlOB6n9P68i5SP1A_1759487615
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18991180028E; Fri,  3 Oct 2025 10:33:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C68330002C8; Fri,  3 Oct 2025 10:33:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 1/5] vfio: Remove workaround for kernel DMA unmap overflow bug
Date: Fri,  3 Oct 2025 12:33:24 +0200
Message-ID: <20251003103328.1864910-2-clg@redhat.com>
In-Reply-To: <20251003103328.1864910-1-clg@redhat.com>
References: <20251003103328.1864910-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A kernel bug was introduced in Linux v4.15 via commit 71a7d3d78e3c
("vfio/type1: Check for address space wrap-around on unmap"), which
added a test for address space wrap-around in the vfio DMA unmap path.
Unfortunately, due to an integer overflow, the kernel would
incorrectly detect an unmap of the last page in the 64-bit address
space as a wrap-around, causing the unmap to fail with -EINVAL.

A QEMU workaround was introduced in commit 567d7d3e6be5 ("vfio/common:
Work around kernel overflow bug in DMA unmap") to retry the unmap,
excluding the final page of the range.

The kernel bug was then fixed in Linux v5.0 via commit 58fec830fc19
("vfio/type1: Fix dma_unmap wrap-around check"). Since the oldest
supported LTS kernel is now v5.4, kernels affected by this bug are
considered deprecated, and the workaround is no longer necessary.

This change reverts 567d7d3e6be5, removing the workaround.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250926085423.375547-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container-legacy.c | 20 +-------------------
 hw/vfio/trace-events       |  1 -
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index c0f87f774a00805cab4a8f3b3386ddd99c3d9111..25a15ea8674c159b7e624425c52953240b8c1179 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -147,25 +147,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
         need_dirty_sync = true;
     }
 
-    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
-        /*
-         * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
-         * v4.15) where an overflow in its wrap-around check prevents us from
-         * unmapping the last page of the address space.  Test for the error
-         * condition and re-try the unmap excluding the last page.  The
-         * expectation is that we've never mapped the last page anyway and this
-         * unmap request comes via vIOMMU support which also makes it unlikely
-         * that this page is used.  This bug was introduced well after type1 v2
-         * support was introduced, so we shouldn't need to test for v1.  A fix
-         * is queued for kernel v5.0 so this workaround can be removed once
-         * affected kernels are sufficiently deprecated.
-         */
-        if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
-            container->iommu_type == VFIO_TYPE1v2_IOMMU) {
-            trace_vfio_legacy_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
-            continue;
-        }
+    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         return -errno;
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e3d571f8c845dad85de5738f8ca768bdfc336252..7496e1b64b5de0168974a251eab698399a6a1d54 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -112,7 +112,6 @@ vfio_container_disconnect(int fd) "close container->fd=%d"
 vfio_group_put(int fd) "close group->fd=%d"
 vfio_device_get(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_device_put(int fd) "close vdev->fd=%d"
-vfio_legacy_dma_unmap_overflow_workaround(void) ""
 
 # region.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
-- 
2.51.0


