Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE573CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV8N-0007lA-Ls; Sat, 13 Jun 2026 16:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV8L-0007jK-Bg; Sat, 13 Jun 2026 16:39:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV8J-0003un-L8; Sat, 13 Jun 2026 16:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382964; bh=jdO06w1bx/0mcHC/4q+Ne5w93oHOj/sR1DdBi8Mfk7I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KWCBLAPbWwUnUTEbwTetVuWthx1y6HLF+wn6hapvyj4Ad52JFcVlhIWAcAYqXLYWm
 FQQDlgWZ1W/+35U121GUrmvkqZ234Lpn7ajy6pW4lcr7MR2Gr/N0cSj/bYerCBnKcW
 1SSpd35xbBV+JhGK2XWj9HcAkJ7ri/4wNBX3SYlAaeedtWt9PlXAAYBvLOvId3IC+r
 jVbpwx9bwldWV3rpuULph8ADI1dmN/WHD+mK+retEuIkcpjziZ/xudDD08zm3vqdTc
 MccE0Z7Q16Y590MS/VCddJJzSLv5h+OJpJ3EpR89JDHecB/kjvIw28TzYFd+q1E5Ry
 q28Pptp1+yocw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A70A1B6EFB;
 Sat, 13 Jun 2026 23:36:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C0FCC3CE94C;
 Sat, 13 Jun 2026 23:36:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 32/72] vfio/container: Restrict dma_map_file() to
 shared RAM or RAM devices
Date: Sat, 13 Jun 2026 23:34:58 +0300
Message-ID: <20260613203542.1809153-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit e6c47bebdf8628e635e1ba970919ca96d572dbbe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4c2816b574..56bd9ac009 100644
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
2.47.3


