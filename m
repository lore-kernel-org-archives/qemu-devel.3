Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F3BC678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2a-0004Vb-3U; Wed, 11 Jun 2025 11:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2T-0004Sj-9a
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2R-00076P-9C
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUGT0dF9kElz2HxdD/WmTDEZEkfwDZyixh8VsmslCw8=;
 b=VbFE09E6e1N3BB2acuTVA/mIbsEO3mPVzr7hdZSQRlG03/F0sGMGnqiXm81TWmupOMpJx5
 UqMpU4F0gKLSERdWmqPsySTsOGfqty4E1WBx0MX37JpnFKxKTYtBlNTxItqymYP5jBJhpj
 blFdjHoRU78fXl5n6l/qo+4si8fTkYI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-FblJkeDENpS7nJjZ5via5A-1; Wed,
 11 Jun 2025 11:06:45 -0400
X-MC-Unique: FblJkeDENpS7nJjZ5via5A-1
X-Mimecast-MFC-AGG-ID: FblJkeDENpS7nJjZ5via5A_1749654405
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B750195608B; Wed, 11 Jun 2025 15:06:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A0CC180045C; Wed, 11 Jun 2025 15:06:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/27] vfio: add per-region fd support
Date: Wed, 11 Jun 2025 17:06:00 +0200
Message-ID: <20250611150620.701903-9-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

For vfio-user, each region has its own fd rather than sharing
vbasedev's. Add the necessary plumbing to support this, and use the
correct fd in vfio_region_mmap().

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250607001056.335310-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  7 +++++--
 hw/vfio/device.c              | 29 +++++++++++++++++++++++++----
 hw/vfio/region.c              |  9 +++++++--
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8bcb3c19f62b5a47c835e10149c04a9bd7536520..bf54fc69205a713263a666b480b2399e2a91f552 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -66,6 +66,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
+    bool use_region_fds;
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
@@ -84,6 +85,7 @@ typedef struct VFIODevice {
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
+    int *region_fds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -170,10 +172,11 @@ struct VFIODeviceIOOps {
     /**
      * @get_region_info
      *
-     * Fill in @info with information on the region given by @info->index.
+     * Fill in @info (and optionally @fd) with information on the region given
+     * by @info->index.
      */
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
 
     /**
      * @get_irq_info
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9fba2c7272f207f2fe870fc97b46c342bd57dc0a..a4bdde8e8bd49c82923d0d29a44f18fd71a44204 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -200,6 +200,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* check cache */
@@ -214,7 +215,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
@@ -225,11 +226,19 @@ retry:
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
 
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
+
         goto retry;
     }
 
     /* fill cache */
     vbasedev->reginfo[index] = *info;
+    if (vbasedev->region_fds != NULL) {
+        vbasedev->region_fds[index] = fd;
+    }
 
     return 0;
 }
@@ -334,6 +343,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
     vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
+    vbasedev->use_region_fds = false;
 
     vbasedev->ram_block_discard_allowed = ram_discard;
 }
@@ -444,6 +454,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
                                vbasedev->num_regions);
+    if (vbasedev->use_region_fds) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+    }
 }
 
 void vfio_device_unprepare(VFIODevice *vbasedev)
@@ -452,9 +465,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 
     for (i = 0; i < vbasedev->num_regions; i++) {
         g_free(vbasedev->reginfo[i]);
+        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
+            close(vbasedev->region_fds[i]);
+        }
+
     }
-    g_free(vbasedev->reginfo);
-    vbasedev->reginfo = NULL;
+
+    g_clear_pointer(&vbasedev->reginfo, g_free);
+    g_clear_pointer(&vbasedev->region_fds, g_free);
 
     QLIST_REMOVE(vbasedev, container_next);
     QLIST_REMOVE(vbasedev, global_next);
@@ -476,10 +494,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
-                                          struct vfio_region_info *info)
+                                          struct vfio_region_info *info,
+                                          int *fd)
 {
     int ret;
 
+    *fd = -1;
+
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 34752c3f65c4b43fc961754657b18f5269c01ef1..cb172f2136dab7d5e649e588bda16b0e4821079d 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -241,6 +241,7 @@ int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
     char *name;
+    int fd;
 
     if (!region->mem) {
         return 0;
@@ -271,14 +272,18 @@ int vfio_region_mmap(VFIORegion *region)
             goto no_mmap;
         }
 
+        /* Use the per-region fd if set, or the shared fd. */
+        fd = region->vbasedev->region_fds ?
+             region->vbasedev->region_fds[region->nr] :
+             region->vbasedev->fd,
+
         map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
         munmap(map_base, map_align - map_base);
         munmap(map_align + region->mmaps[i].size,
                align - (map_align - map_base));
 
         region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
-                                     MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
+                                     MAP_SHARED | MAP_FIXED, fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
-- 
2.49.0


