Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10260C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTg4-00054b-0w; Tue, 18 Mar 2025 05:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfl-0004ia-VN
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfk-0002Lz-08
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isao5RStDq0J0psK6QlGDO/v8zRRffum+0iVpBuQs2w=;
 b=KNqY5ljGvMQ1D/GFscXGZHiv0zn0gbcIpnWcTsZMM4mQVy5FOT0ira4jdPKufxBU/ujfRK
 vLUIPjrm5cgM5h/qk+35wP3N763Pw8EzMRQt0HCkEtYlKmIfWoR8R4FqvE36xX1UczobqJ
 oxbU8ElzHPyKI+93+K4osbEb1cx9koQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-ey3SEpAmPH6yObQeOG0DGA-1; Tue,
 18 Mar 2025 05:55:41 -0400
X-MC-Unique: ey3SEpAmPH6yObQeOG0DGA-1
X-Mimecast-MFC-AGG-ID: ey3SEpAmPH6yObQeOG0DGA_1742291740
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E3FC1956048; Tue, 18 Mar 2025 09:55:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3D841828A80; Tue, 18 Mar 2025 09:55:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 18/32] vfio: Move vfio_get_device_info() to helpers.c
Date: Tue, 18 Mar 2025 10:54:01 +0100
Message-ID: <20250318095415.670319-19-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

vfio_get_device_info() is a low level routine. Move it with the other
helpers.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.h             |  1 +
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/common.c              | 24 ------------------------
 hw/vfio/helpers.c             | 24 ++++++++++++++++++++++++
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/helpers.h b/hw/vfio/helpers.h
index 397908735c6b285d3d9e012f30488589408235ae..8ac1f13c6e2a51983f69f81072cb134ff8969c70 100644
--- a/hw/vfio/helpers.h
+++ b/hw/vfio/helpers.h
@@ -25,6 +25,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 #endif
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
+struct vfio_device_info *vfio_get_device_info(int fd);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 35b765357f85346ecfabfae782f3aa8d83d9e7ae..848412ea53ccd903313855fd30490d897c8681c0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -121,7 +121,6 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
 bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
 
-struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9c1b635a813ffff97426d2c3beec84de1b9afe63..e70e4c077ca27ce0d2f990d684196f2f74f6f07a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1302,30 +1302,6 @@ const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
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
index cec9e2008ba146c15e54a2865d5a40984e7dfc8c..e9ad0c6792558a00f316baab40bf857c3306faaa 100644
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
2.48.1


