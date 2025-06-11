Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62067C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2W-0004TJ-6X; Wed, 11 Jun 2025 11:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2T-0004St-K3
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2R-00076d-TA
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLHEBL9BNaXvqHw39biK7DZfHGB227mG2Q5arGi0+/8=;
 b=deazTqnewX1RwsN4DiRGsKbGvL43sSqmtTMrYv2n6sk257UY4xMmu7EuoK63y9EMIn4cAP
 qSBcnqxeaLfAuA1ffR9lMYwqIMFY8E0/+tK4ROSxI/5+zNhM1NXZkCFT9J8XFr5LK47LxP
 /hMPdMbAuPPGv5Z5/0sJK0peCykYKO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-uhvcrUSgN62LsAPCqw7NYA-1; Wed,
 11 Jun 2025 11:06:49 -0400
X-MC-Unique: uhvcrUSgN62LsAPCqw7NYA-1
X-Mimecast-MFC-AGG-ID: uhvcrUSgN62LsAPCqw7NYA_1749654408
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E9C3195608E; Wed, 11 Jun 2025 15:06:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87A16180045B; Wed, 11 Jun 2025 15:06:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/27] vfio: mark posted writes in region write callbacks
Date: Wed, 11 Jun 2025 17:06:01 +0200
Message-ID: <20250611150620.701903-10-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

For vfio-user, the region write implementation needs to know if the
write is posted; add the necessary plumbing to support this.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250607001056.335310-5-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 4 ++--
 include/hw/vfio/vfio-region.h | 1 +
 hw/vfio/device.c              | 3 ++-
 hw/vfio/pci.c                 | 5 ++++-
 hw/vfio/region.c              | 3 ++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index bf54fc69205a713263a666b480b2399e2a91f552..9793b2dba0ced9e87b1641ae783867ce1b41e71a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -205,10 +205,10 @@ struct VFIODeviceIOOps {
      * @region_write
      *
      * Write @size bytes to the region @nr at offset @off from the buffer
-     * @data.
+     * @data; if @post, the write is posted.
      */
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
-                        void *data);
+                        void *data, bool post);
 };
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
index cbffb269628cc89fbbdb060ce3ce6e45bd701bad..ede6e0c8f992caa3292d280474c90ddef27eb3dd 100644
--- a/include/hw/vfio/vfio-region.h
+++ b/include/hw/vfio/vfio-region.h
@@ -29,6 +29,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    bool post_wr; /* writes can be posted */
 } VFIORegion;
 
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index a4bdde8e8bd49c82923d0d29a44f18fd71a44204..d32600eda1a282adaa4c58cfeb80c19c6489ee92 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -543,7 +543,8 @@ static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
 }
 
 static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
-                                       off_t off, uint32_t size, void *data)
+                                       off_t off, uint32_t size, void *data,
+                                       bool post)
 {
     struct vfio_region_info *info;
     int ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2901cedf6f3e4e1283cb59a1ff6c8ddb99a41b56..89f9246416a700ecbfb21ec3921b5a71cadf9981 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -989,7 +989,7 @@ static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
 {
     return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
                                                VFIO_PCI_CONFIG_REGION_INDEX,
-                                               offset, size, data);
+                                               offset, size, data, false);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
@@ -1793,6 +1793,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
                                          ~PCI_BASE_ADDRESS_MEM_MASK);
     bar->size = bar->region.size;
+
+    /* IO regions are sync, memory can be async */
+    bar->region.post_wr = (bar->ioport == 0);
 }
 
 static void vfio_bars_prepare(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index cb172f2136dab7d5e649e588bda16b0e4821079d..f5b8e3cbf100f4f1b9fb916075653d3a6e1ca8d4 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -66,7 +66,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
     }
 
     ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
-                                         addr, size, &buf);
+                                         addr, size, &buf, region->post_wr);
     if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
                      ",%d) failed: %s",
@@ -200,6 +200,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    region->post_wr = false;
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
-- 
2.49.0


