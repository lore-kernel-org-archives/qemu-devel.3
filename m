Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A280FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3v-000814-1M; Fri, 04 Jul 2025 04:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3m-0007tX-3X
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3k-0000Xe-6R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9ByR+nusummn7w7/LyYZYoD8r4c90VPIODzS0/Fy8g=;
 b=e42SipCYBtXIsqzTNttKMnUcK48/iCx00frT2ebc1VXzTJD4yvEKAH5wxa7v3WSo/20ggo
 Mp43dY43wvIpdhwLVQJD/y3h6mtoe8aI/hxur1MoYXupoaZPVU+NC07Q0WCYSCAkZhQein
 JFsx1Ra7qt5SZpe6p0ZkL2K3Dcmhn70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-EVrEYhTWMQ2CbYRHnO94Zw-1; Fri,
 04 Jul 2025 04:46:12 -0400
X-MC-Unique: EVrEYhTWMQ2CbYRHnO94Zw-1
X-Mimecast-MFC-AGG-ID: EVrEYhTWMQ2CbYRHnO94Zw_1751618771
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C288418089B4; Fri,  4 Jul 2025 08:46:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB3A1195E74A; Fri,  4 Jul 2025 08:46:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/27] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Date: Fri,  4 Jul 2025 10:45:15 +0200
Message-ID: <20250704084528.1412959-15-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
Such a mapping can be preserved without modification during CPR,
because it depends on the file's address space, which does not change,
rather than on the process's address space, which does change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-9-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 15 +++++++++++++++
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/iommufd.c                     | 13 +++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3cd86ec59e1a4605dea92fadeca5816145ae409b..bded6e993ffd34910f5583bf8e94c81c41f4885f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -167,6 +167,21 @@ struct VFIOIOMMUClass {
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
+    /**
+     * @dma_map_file
+     *
+     * Map a file range for the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use for map
+     * @iova: start address to map
+     * @size: size of the range to map
+     * @fd: descriptor of the file to map
+     * @start: starting file offset of the range to map
+     * @readonly: map read only if true
+     */
+    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
+                        hwaddr iova, ram_addr_t size,
+                        int fd, unsigned long start, bool readonly);
     /**
      * @dma_unmap
      *
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index d834bd482290a8b195f94c07832b7f8020504c3a..56304978e1e8ec456e0eb5f13e8bddc091e76208 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -78,7 +78,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    RAMBlock *rb = mr->ram_block;
+    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
 
+    if (mfd >= 0 && vioc->dma_map_file) {
+        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
+        unsigned long offset = qemu_ram_get_fd_offset(rb);
+
+        return vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
+                                  readonly);
+    }
     g_assert(vioc->dma_map);
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d3efef71afd4fd9e68455cefe7666c9f70e8c61e..962a1e2b1f28b297cc876fffa2677bd525479c8c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -45,6 +45,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
+static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 int fd, unsigned long start, bool readonly)
+{
+    const VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    return iommufd_backend_map_file_dma(container->be,
+                                        container->ioas_id,
+                                        iova, size, fd, start, readonly);
+}
+
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
@@ -807,6 +819,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->dma_map = iommufd_cdev_map;
+    vioc->dma_map_file = iommufd_cdev_map_file;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
-- 
2.50.0


