Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53865C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc41-0008Ej-6w; Fri, 04 Jul 2025 04:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3y-00087L-Rx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3w-0000wN-Tc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FATOxFjlqOdGSfi9TLGXPwRXGcPggsJ2RP2fosVbyPQ=;
 b=cJus7HoLYn9y4v+k87w1bIq+gQ9szLFTQFdievW9FAPolFBJsm/oIAoZNUlWKjfxzbzxzE
 z3He6AL+vR+G57bjibx/9m6M9YYpAYwzWM8kY7feGkD9gzb9rJkJIFFhOEZFIn885VB1ev
 lXteEfu1GovKi9oM6WRav0TqSRHlIc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-eoX-xCADNA-_dIGSZ3Ff5g-1; Fri,
 04 Jul 2025 04:46:20 -0400
X-MC-Unique: eoX-xCADNA-_dIGSZ3Ff5g-1
X-Mimecast-MFC-AGG-ID: eoX-xCADNA-_dIGSZ3Ff5g_1751618779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26F5F1809C81; Fri,  4 Jul 2025 08:46:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59C8319560A7; Fri,  4 Jul 2025 08:46:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 16/27] vfio/iommufd: add vfio_device_free_name
Date: Fri,  4 Jul 2025 10:45:17 +0200
Message-ID: <20250704084528.1412959-17-clg@redhat.com>
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

Define vfio_device_free_name to free the name created by
vfio_device_get_name.  A subsequent patch will do more there.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-11-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 1 +
 hw/vfio/ap.c                  | 4 ++--
 hw/vfio/ccw.c                 | 4 ++--
 hw/vfio/device.c              | 5 +++++
 hw/vfio/pci.c                 | 2 +-
 hw/vfio/platform.c            | 2 +-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index f503837ccc6936b730a7752ca092da5acba1806f..1901a35aa90214c36369f8ac0b0cfef36acbbaa8 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -279,6 +279,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
 
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
+void vfio_device_free_name(VFIODevice *vbasedev);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 1df4438149d2a06ef176e03e358336381bfa4caa..7719f245797ef45b6392270741c7dd0a36527fd2 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -265,7 +265,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-    g_free(vbasedev->name);
+    vfio_device_free_name(vbasedev);
 }
 
 static void vfio_ap_unrealize(DeviceState *dev)
@@ -275,7 +275,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX);
     vfio_device_detach(&vapdev->vdev);
-    g_free(vapdev->vdev.name);
+    vfio_device_free_name(&vapdev->vdev);
 }
 
 static const Property vfio_ap_properties[] = {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index cea9d6e00562c241832184cafe862005fcdc992b..9560b8d851b6b25e647476c51efe845ebff10410 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -619,7 +619,7 @@ out_io_notifier_err:
 out_region_err:
     vfio_device_detach(vbasedev);
 out_attach_dev_err:
-    g_free(vbasedev->name);
+    vfio_device_free_name(vbasedev);
 out_unrealize:
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
@@ -637,7 +637,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_device_detach(&vcdev->vdev);
-    g_free(vcdev->vdev.name);
+    vfio_device_free_name(&vcdev->vdev);
 
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 3cd365fb8b10a180c454d07efb4b7d4e6f403046..97eddd04f5756a0e9e4763c4fef84c9829272053 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -333,6 +333,11 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+void vfio_device_free_name(VFIODevice *vbasedev)
+{
+    g_clear_pointer(&vbasedev->name, g_free);
+}
+
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 {
     ERRP_GUARD();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dd0b2a0b947d4f9c788c6cd8b41e8ac916098724..1093b28df7c3f5f37e622e6d76a99ad8d2b7e01e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2996,7 +2996,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 
     vfio_device_detach(&vdev->vbasedev);
 
-    g_free(vdev->vbasedev.name);
+    vfio_device_free_name(&vdev->vbasedev);
     g_free(vdev->msix);
 }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 9a21f2e50a2945a6658b9be4fdec1bc1c98d0f20..5c1795a26fe79b98a9886e15f365fa7a921409a4 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -530,7 +530,7 @@ static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 {
     /* @fd takes precedence over @sysfsdev which takes precedence over @host */
     if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
-        g_free(vbasedev->name);
+        vfio_device_free_name(vbasedev);
         vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
     } else if (vbasedev->fd < 0) {
         if (!vbasedev->name || strchr(vbasedev->name, '/')) {
-- 
2.50.0


