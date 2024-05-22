Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE346C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihK-0004Af-UZ; Wed, 22 May 2024 05:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihC-0003fm-Tx
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihA-0001lG-Sj
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkFlQMtohJj8//vP37dXhvJksj+4U+xOpp45FX5Unf8=;
 b=Tn1TFW8pWMM9tI0pismlb281Eg5i1RCqoabo7pYo14Ibs//0quIYktcUkbHjhVvw+lbDqK
 aa+PVivtgrjPc27TQINX6dBSWSnIyBor06EN9kHu1P2ELz61Ujbb56VLOKD89B0GcBbFFB
 b4NNV9q9gtb74XfQtbcOvJ1I/mGJhyQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-agmYHbl_M9K6Xkr9r8Q_1g-1; Wed,
 22 May 2024 05:55:37 -0400
X-MC-Unique: agmYHbl_M9K6Xkr9r8Q_1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E31B3380673C;
 Wed, 22 May 2024 09:55:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1ED028E2;
 Wed, 22 May 2024 09:55:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/47] vfio/helpers: Make vfio_set_irq_signaling() return bool
Date: Wed, 22 May 2024 11:54:28 +0200
Message-ID: <20240522095442.195243-34-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 ++--
 hw/vfio/ap.c                  |  8 +++----
 hw/vfio/ccw.c                 |  8 +++----
 hw/vfio/helpers.c             | 18 ++++++----------
 hw/vfio/pci.c                 | 40 ++++++++++++++++++-----------------
 hw/vfio/platform.c            | 18 +++++++---------
 6 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b7bb4f5304addcdb03c971f27f99e5350ad0940a..b712799caffdc950b593a87d569d7f5281976e2f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -207,8 +207,8 @@ void vfio_spapr_container_deinit(VFIOContainer *container);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
-int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
-                           int action, int fd, Error **errp);
+bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
+                            int action, int fd, Error **errp);
 void vfio_region_write(void *opaque, hwaddr addr,
                            uint64_t data, unsigned size);
 uint64_t vfio_region_read(void *opaque,
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index ba653ef70f08ebdf482009baafc62eb33ebda9a8..d8a9615feec065e98f53831912087d9878fdff9c 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -117,8 +117,8 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
     fd = event_notifier_get_fd(notifier);
     qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
 
-    if (vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                               errp)) {
+    if (!vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
+                                errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vapdev);
         event_notifier_cleanup(notifier);
     }
@@ -141,8 +141,8 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
         return;
     }
 
-    if (vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 89bb98016764e65cf826183d7a38c59d429f6eeb..1f578a3c75d975e12bbac52b3683e6fd193801cb 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -434,8 +434,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
     fd = event_notifier_get_fd(notifier);
     qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
 
-    if (vfio_set_irq_signaling(vdev, irq, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
+    if (!vfio_set_irq_signaling(vdev, irq, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
         event_notifier_cleanup(notifier);
     }
@@ -464,8 +464,8 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
         return;
     }
 
-    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
     }
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 1f3bdd9bf059beec186d87ba4772f2f6e34bc7d4..9edbc966884de12e7248af8d50d87f26c8cd2764 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -107,12 +107,12 @@ static const char *index_to_str(VFIODevice *vbasedev, int index)
     }
 }
 
-int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
-                           int action, int fd, Error **errp)
+bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
+                            int action, int fd, Error **errp)
 {
     ERRP_GUARD();
     g_autofree struct vfio_irq_set *irq_set = NULL;
-    int argsz, ret = 0;
+    int argsz;
     const char *name;
     int32_t *pfd;
 
@@ -127,15 +127,11 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        ret = -errno;
+    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+        return true;
     }
 
-    if (!ret) {
-        return 0;
-    }
-
-    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
+    error_setg_errno(errp, errno, "VFIO_DEVICE_SET_IRQS failure");
 
     name = index_to_str(vbasedev, index);
     if (name) {
@@ -146,7 +142,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     error_prepend(errp,
                   "Failed to %s %s eventfd signaling for interrupt ",
                   fd < 0 ? "tear down" : "set up", action_to_str(action));
-    return ret;
+    return false;
 }
 
 /*
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a447013a1da90f534ab07409c6ca39263f7f6f88..358da4497b8ab9b58b4f36252d1857279efbe521 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -147,10 +147,10 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         goto fail_irqfd;
     }
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_UNMASK,
-                               event_notifier_get_fd(&vdev->intx.unmask),
-                               errp)) {
+    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
+                                VFIO_IRQ_SET_ACTION_UNMASK,
+                                event_notifier_get_fd(&vdev->intx.unmask),
+                                errp)) {
         goto fail_vfio;
     }
 
@@ -295,8 +295,8 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
+    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
         return -errno;
@@ -590,9 +590,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 fd = event_notifier_get_fd(&vector->interrupt);
             }
 
-            if (vfio_set_irq_signaling(&vdev->vbasedev,
-                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+            if (!vfio_set_irq_signaling(&vdev->vbasedev,
+                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
+                                        &err)) {
                 error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
             }
         }
@@ -634,8 +635,9 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
         int32_t fd = event_notifier_get_fd(&vector->interrupt);
         Error *err = NULL;
 
-        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                    nr, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
+                                    &err)) {
             error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         }
     }
@@ -2873,8 +2875,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->err_notifier);
@@ -2890,8 +2892,8 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
@@ -2938,8 +2940,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
-                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->req_notifier);
@@ -2956,8 +2958,8 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 2bd16096bbd1b4a1da579448e931cb0803d54bb6..3233ca86918a22b69265b83a1a9dec8b6b59380f 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -115,18 +115,17 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
     VFIODevice *vbasedev = &intp->vdev->vbasedev;
     int32_t fd = event_notifier_get_fd(intp->interrupt);
     Error *err = NULL;
-    int ret;
 
     qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
 
-    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
-                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err);
-    if (ret) {
+    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
+                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
         qemu_set_fd_handler(fd, NULL, NULL, NULL);
+        return -EINVAL;
     }
 
-    return ret;
+    return 0;
 }
 
 /*
@@ -355,15 +354,14 @@ static int vfio_set_resample_eventfd(VFIOINTp *intp)
     int32_t fd = event_notifier_get_fd(intp->unmask);
     VFIODevice *vbasedev = &intp->vdev->vbasedev;
     Error *err = NULL;
-    int ret;
 
     qemu_set_fd_handler(fd, NULL, NULL, NULL);
-    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
-                                 VFIO_IRQ_SET_ACTION_UNMASK, fd, &err);
-    if (ret) {
+    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
+                                VFIO_IRQ_SET_ACTION_UNMASK, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+        return -EINVAL;
     }
-    return ret;
+    return 0;
 }
 
 /**
-- 
2.45.1


