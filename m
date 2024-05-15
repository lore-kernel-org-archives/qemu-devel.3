Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CAC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vh-00027M-PS; Wed, 15 May 2024 04:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vY-000264-Tn; Wed, 15 May 2024 04:23:58 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vV-00074Z-Nz; Wed, 15 May 2024 04:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761433; x=1747297433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ME8Ccft99hyp80mUdi/tVCtqy8NkyAzb5bwAQgSzodI=;
 b=EJAR7gLn+WcZO/hUb/ny4Cn2jteB94URWP4f4co7xU+9PnYSGitQAE06
 88KPj/fOqglU5Bk6GV81obJMtoIYRmK5rc4DYp9NT3fHQKfIMQrfuBjbM
 6RnrhvfAfcU4FcCRrnhz96UmPxHoS9QOP6yWYiWOJ+vhZJQKEj4FMdbgs
 lUlh5qab4wnaDXTbrvSshV+ArRJ5reFg70x5Uqt6W3qLy4L5hLzRZ7wWc
 Z3w06e5lPJ32HaizQOWEJKaRPEtGR84WXn4CRGK9AE27AJryyqUa6NYMb
 nRy+iOOWd2qiDcR+oQDn4s7nLZx6P0iJ7Qx5SCnuG2nG1PuxIstDds4d5 A==;
X-CSE-ConnectionGUID: 7WuG/o6AQ4mijq1ES0ba3A==
X-CSE-MsgGUID: wpPYXl3tSWGZeoUmtL9n6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961534"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961534"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:51 -0700
X-CSE-ConnectionGUID: ONlcJmBfSkexF3Ho1jW2IQ==
X-CSE-MsgGUID: u/Jal/LhQgG0QBf1nZXEjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396276"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:48 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH 04/16] vfio/helpers: Make vfio_set_irq_signaling() return bool
Date: Wed, 15 May 2024 16:20:29 +0800
Message-Id: <20240515082041.556571-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  4 ++--
 hw/vfio/ap.c                  |  8 +++----
 hw/vfio/ccw.c                 |  8 +++----
 hw/vfio/helpers.c             | 18 ++++++----------
 hw/vfio/pci.c                 | 40 ++++++++++++++++++-----------------
 hw/vfio/platform.c            | 18 +++++++---------
 6 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 2d8da32df4..fdce13f0f2 100644
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
index ba653ef70f..d8a9615fee 100644
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
index 89bb980167..1f578a3c75 100644
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
index 0bb7b40a6a..93e6fef6de 100644
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
index a447013a1d..358da4497b 100644
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
index 2bd16096bb..3233ca8691 100644
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
2.34.1


