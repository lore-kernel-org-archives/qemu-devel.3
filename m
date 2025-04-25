Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAADC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EjV-0003gV-9h; Fri, 25 Apr 2025 04:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjI-0003SD-GK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjF-0003Gl-AB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQVWhSfaqWAu3DCFHgrvYVX+zy0oRE6ifscy5BtoQ4w=;
 b=Og3aStNlcqur4P/ASJaYqCymF5NX3Os6yHJPLuadG2EIklgiJW3fnXmkPXUQmLA2Lw4U2C
 reaBb/Kuif9In+ag4MyiKx9ME2QT9D8JJ/gHom0hwzMVRnoUwecwf5JFNTL2QJMVbar8tE
 yzbBpUhkoGJkJ2tRWVTKmLyOsQVgfOA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-KXVbt05CN9qTUkzfyq6g8Q-1; Fri,
 25 Apr 2025 04:48:09 -0400
X-MC-Unique: KXVbt05CN9qTUkzfyq6g8Q-1
X-Mimecast-MFC-AGG-ID: KXVbt05CN9qTUkzfyq6g8Q_1745570888
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A5EC180034E; Fri, 25 Apr 2025 08:48:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B68130001A2; Fri, 25 Apr 2025 08:48:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 23/50] vfio: Move vfio_get_device_info() to helpers.c
Date: Fri, 25 Apr 2025 10:46:16 +0200
Message-ID: <20250425084644.102196-24-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

vfio_get_device_info() is a low level routine. Move it with the other
helpers.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-19-clg@redhat.com
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-20-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h        |  1 +
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/common.c              | 24 ------------------------
 hw/vfio/helpers.c             | 24 ++++++++++++++++++++++++
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index 5d91e33d27be1bdd8eb9b3ce74c39a4ac1991adc..dbcb68bbb0e12607f5ccf15f114530966c2cbcb2 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -25,6 +25,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 #endif
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
+struct vfio_device_info *vfio_get_device_info(int fd);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 442ec287d799538e1d3669a6c470960cce5459a0..dca7a6a4b3dcc583eb430b8cf9380a007623ec26 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -122,7 +122,6 @@ bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
 
 void vfio_reset_handler(void *opaque);
-struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2b3af051cc46118799b882a9a8e3ae96e556952b..f80c0ef229c867070593f6a6f53e7ea1a701cf41 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1333,30 +1333,6 @@ void vfio_reset_handler(void *opaque)
     }
 }
 
-struct vfio_device_info *vfio_get_device_info(int fd)
-{
-    struct vfio_device_info *info;
-    uint32_t argsz = sizeof(*info);
-
-    info = g_malloc0(argsz);
-
-retry:
-    info->argsz = argsz;
-
-    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
-        g_free(info);
-        return NULL;
-    }
-
-    if (info->argsz > argsz) {
-        argsz = info->argsz;
-        info = g_realloc(info, argsz);
-        goto retry;
-    }
-
-    return info;
-}
-
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp)
 {
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index e6b75baa805241b4df28769338b15a6fe9b99501..b7f75b47af3a5d066eb518903831214df6c3755a 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -312,6 +312,30 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
     return 0;
 }
 
+struct vfio_device_info *vfio_get_device_info(int fd)
+{
+    struct vfio_device_info *info;
+    uint32_t argsz = sizeof(*info);
+
+    info = g_malloc0(argsz);
+
+retry:
+    info->argsz = argsz;
+
+    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
+        g_free(info);
+        return NULL;
+    }
+
+    if (info->argsz > argsz) {
+        argsz = info->argsz;
+        info = g_realloc(info, argsz);
+        goto retry;
+    }
+
+    return info;
+}
+
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info)
 {
-- 
2.49.0


