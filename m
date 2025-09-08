Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD5FCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9A-0007Or-4s; Mon, 08 Sep 2025 12:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8v-00079k-BC
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8s-0001dx-27
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxL649bZ9kgLbkNAweSzp4umnC2umcgzjheXrcb5Kvc=;
 b=EgYl/zM9fjIC6POllRgLfplXotXwsF5FCg+/X9VmCYOgn97MbifrQhqWUXjv8PuBhDGd++
 jHC/Wl2huYvamzccwvFpuKc/ElWUxpK6UETvPvwgzOzcTiPkqXvDNfyu9qmlzJbGk6aXoD
 vChS5VxI/Mo1p+1C76Sp8BCBUGVGOKs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-UfzzD-4jP0-E-iV9DNHPgw-1; Mon,
 08 Sep 2025 12:54:50 -0400
X-MC-Unique: UfzzD-4jP0-E-iV9DNHPgw-1
X-Mimecast-MFC-AGG-ID: UfzzD-4jP0-E-iV9DNHPgw_1757350489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BC1C1800447; Mon,  8 Sep 2025 16:54:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AD28300018D; Mon,  8 Sep 2025 16:54:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 19/31] vfio/container.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:42 +0200
Message-ID: <20250908165354.1731444-20-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOUserContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-10-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d589dd90f501bbb3442c7fdc263529501086510d..3cdbd44c1aac2153dd099139a3956a3a0bb9b48e 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -24,16 +24,14 @@
  */
 static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                                 bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     container->proxy->async_ops = true;
 }
 
 static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                            bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     /* wait here for any async requests sent during the transaction */
     container->proxy->async_ops = false;
@@ -44,8 +42,8 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                            bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
+
     Error *local_err = NULL;
     int ret = 0;
 
@@ -86,8 +84,8 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                                bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
+
     int fd = memory_region_get_fd(mrp);
     Error *local_err = NULL;
     int ret = 0;
@@ -173,8 +171,7 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
-                                                bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
 
     assert(container->proxy->dma_pgsizes != 0);
     bcontainer->pgsizes = container->proxy->dma_pgsizes;
@@ -218,7 +215,7 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
         goto put_space_exit;
     }
 
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
 
     ret = ram_block_uncoordinated_discard_disable(true);
     if (ret) {
@@ -263,7 +260,7 @@ put_space_exit:
 
 static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     VFIOAddressSpace *space = bcontainer->space;
 
@@ -291,7 +288,7 @@ static bool vfio_user_device_get(VFIOUserContainer *container,
 
     vbasedev->fd = -1;
 
-    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+    vfio_device_prepare(vbasedev, VFIO_IOMMU(container), &info);
 
     return true;
 }
@@ -315,8 +312,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 
 static void vfio_user_device_detach(VFIODevice *vbasedev)
 {
-    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
-                                                VFIOUserContainer, bcontainer);
+    VFIOUserContainer *container = VFIO_IOMMU_USER(vbasedev->bcontainer);
 
     vfio_device_unprepare(vbasedev);
 
-- 
2.51.0


