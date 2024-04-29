Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD5FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QdK-00046t-FY; Mon, 29 Apr 2024 09:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inspurisinspur@126.com>)
 id 1s1Pkw-0008IC-KL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:05:15 -0400
Received: from m16.mail.126.com ([117.135.210.8])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <inspurisinspur@126.com>) id 1s1Pko-0005Ui-0q
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Kr5Aw
 JiRu4XHvmMAClZBlg3SOFLGuN/XLATltf8e3OM=; b=Ezt1QT1cwfcUGatZBCPHl
 aJS6/p235XJMTxK/J1iLeb0qRzEmC9Yu51lJUvquGxdQHKOC8+s9HG2Q3VqfZoev
 Cls+ZawIN/udsEMUJ7tjHlv2FrDue3syKXZrjc3VtMgeFQd0jTxlqzaW2/Yk6LI8
 bL8GhCK7kaFot1ocwTxIko=
Received: from localhost.localdomain (unknown [117.160.246.157])
 by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDnz0jOjC9m6k3iBA--.23008S4;
 Mon, 29 Apr 2024 20:04:31 +0800 (CST)
From: inspurisinspur@126.com
To: qemu-devel@nongnu.org,
	inspurisinspur@126.com
Cc: Rock Li <lihongweizz@inspur.com>
Subject: [RFC] vhost-blk: add a vhost_blk implementation
Date: Mon, 29 Apr 2024 20:04:26 +0800
Message-Id: <20240429120426.163189-1-inspurisinspur@126.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnz0jOjC9m6k3iBA--.23008S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZFWUJF48JF18Xw1xCFyUWrg_yoW8WF43Jo
 ZxCr12van5Jry7ua97Wr18Cr4UXF4vkw1DCw1Uu3y2ga1xX34YkF1rKay3J34fCr4fKryx
 Zr4xG3yfJa18KF93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUZXrUUUUU
X-Originating-IP: [117.160.246.157]
X-CM-SenderInfo: xlqv13pulvx0hvsx2qqrswhudrp/1tbi5hnPQ2VLZem9bAACsC
Received-SPF: pass client-ip=117.135.210.8;
 envelope-from=inspurisinspur@126.com; helo=m16.mail.126.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Apr 2024 09:01:20 -0400
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

From: Rock Li <lihongweizz@inspur.com>

vhost-blk could accelerate io for high-performance devices such as NVME,
or high end SAN backend. The main benefit is that syscall costs are eliminated
because vhost-blk could bypass the qemu io processing. This patch works along
with vhost-blk implementation in kernel.

Signed-off-by: lihongweizz <lihongweizz@inspur.com>
---
 hw/block/virtio-blk.c          | 406 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-blk.h |  20 ++
 2 files changed, 425 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index bb86e65f65..749e6cde48 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -36,6 +36,27 @@
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-blk-common.h"
 #include "qemu/coroutine.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-backend.h"
+#include <linux/vhost.h>
+#include <sys/ioctl.h>
+
+static const int kernel_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_BLK_F_SEG_MAX,
+    VIRTIO_BLK_F_GEOMETRY,
+    VIRTIO_BLK_F_TOPOLOGY,
+    VIRTIO_BLK_F_BLK_SIZE,
+    VIRTIO_BLK_F_MQ,
+    VIRTIO_BLK_F_RO,
+    /* VIRTIO_BLK_F_FLUSH == VIRTIO_BLK_F_WCE  */
+    VIRTIO_BLK_F_FLUSH,
+    VHOST_INVALID_FEATURE_BIT
+};
 
 static void virtio_blk_ioeventfd_attach(VirtIOBlock *s);
 
@@ -1145,7 +1166,8 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBlock *s = (VirtIOBlock *)vdev;
 
-    if (!s->ioeventfd_disabled && !s->ioeventfd_started) {
+    if ((!s->ioeventfd_disabled && !s->ioeventfd_started) ||
+            s->vhost_enabled) {
         /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
          * ioeventfd here instead of waiting for .set_status().
          */
@@ -1236,11 +1258,41 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
     }
 }
 
+static void vhost_blk_set_status(VirtIODevice *vdev, uint8_t status);
+
+static void vhost_blk_reset(VirtIODevice *vdev)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    int i;
+
+    if (!s->vhost_enabled || !s->vhost_acked) {
+        return;
+    }
+
+    /*
+     * clear the acked features, and wait for the
+     * next negotiation.
+     */
+    for (i = 0; i < s->conf.num_queues; i++) {
+        s->vhblk[i].dev.acked_features = 0;
+    }
+
+    vhost_blk_set_status(vdev, 0);
+
+    s->vhost_acked = false;
+}
+
 static void virtio_blk_reset(VirtIODevice *vdev)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
     VirtIOBlockReq *req;
 
+    if (s->vhost_enabled) {
+        vhost_blk_reset(vdev);
+        blk_set_enable_write_cache(s->blk, s->original_wce);
+        return;
+    }
+
     /* Dataplane has stopped... */
     assert(!s->ioeventfd_started);
 
@@ -1367,6 +1419,228 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     blk_set_enable_write_cache(s->blk, blkcfg.wce != 0);
 }
 
+static void vhost_blk_stop_one(VirtIODevice *vdev, unsigned int idx)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    struct vhost_vring_file backend = { .index = 0, .fd = -1 };
+    vhost_blk *blk = &s->vhblk[idx];
+    int ret;
+
+    if (!blk->dev.started) {
+        return;
+    }
+
+    ret = ioctl(blk->vhostfd, VHOST_BLK_SET_BACKEND, &backend);
+    assert(ret >= 0);
+
+    vhost_dev_stop(&blk->dev, vdev);
+    vhost_dev_disable_notifiers(&blk->dev, vdev);
+}
+
+static void vhost_blk_start_one(VirtIODevice *vdev, unsigned int idx)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    struct vhost_vring_file backend = { .index = 0 };
+    vhost_blk *blk = &s->vhblk[idx];
+    int ret;
+
+    blk->dev.nvqs = 1;
+    blk->dev.vqs = blk->vqs;
+
+    ret = vhost_dev_enable_notifiers(&blk->dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        abort();
+    }
+
+    ret = vhost_dev_start(&blk->dev, vdev);
+    if (ret < 0) {
+        error_report("Error starting vhost: %d", -ret);
+        abort();
+    }
+
+    /* set backend file  */
+    backend.fd = s->blkfd;
+    ret = ioctl(blk->vhostfd, VHOST_BLK_SET_BACKEND, &backend);
+    if (ret < 0) {
+        error_report("Error setting up vq %d backend(%d): fd %d, idx %d",
+                     idx, -errno, backend.fd, backend.index);
+        abort();
+    }
+}
+
+static void vhost_blk_start(VirtIODevice *vdev, uint32_t total_queues)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int i, ret;
+
+    if (!k->set_guest_notifiers) {
+        error_report("Binding does not support guest notifiers");
+        abort();
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, total_queues, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        abort();
+    }
+
+    for (i = 0; i < total_queues; i++) {
+        vhost_blk_start_one(vdev, i);
+    }
+}
+
+static void vhost_blk_stop(VirtIODevice *vdev, uint32_t total_queues)
+{
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret, i;
+
+    for (i = 0; i < total_queues; i++) {
+        vhost_blk_stop_one(vdev, i);
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, total_queues, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+    }
+
+    assert(ret >= 0);
+}
+
+static bool vhost_blk_started(VirtIODevice *vdev, uint8_t status)
+{
+    return (status & VIRTIO_CONFIG_S_DRIVER_OK) && vdev->vm_running;
+}
+
+static int vhost_blk_handle_config_change(struct vhost_dev *dev)
+{
+    virtio_notify_config(dev->vdev);
+    return 0;
+}
+
+const VhostDevConfigOps vhost_blk_ops = {
+    .vhost_dev_config_notifier = vhost_blk_handle_config_change,
+};
+
+static void vhost_blk_dataplane_create(VirtIODevice *vdev,
+                                       uint32_t total_queues)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    int i, opened = 0, ret;
+    vhost_blk *blk;
+    Error *local_err = NULL;
+
+    if (!s->vhost_enabled) {
+        return;
+    }
+
+    info_report("create vhost dataplane");
+    for (i = 0; i < total_queues; i++) {
+        blk = &s->vhblk[i];
+        blk->dev.max_queues = 1;
+        blk->dev.nvqs = 1;
+        blk->dev.vqs = blk->vqs;
+        /* vhost-user needs vq_index to initiate a specific queue pair */
+        blk->dev.vq_index = i;
+        blk->dev.acked_features = 0;
+        blk->dev.backend_features = 0;
+        blk->dev.protocol_features = 0;
+
+        /*
+         * this is only used by vhost-user, not used by vhost-kernel,
+         * but we left it here for learning.
+         */
+        vhost_dev_set_config_notifier(&blk->dev, &vhost_blk_ops);
+
+        blk->vhostfd = open("/dev/vhost-blk", O_RDWR);
+        if (blk->vhostfd < 0) {
+            error_report("vhost-blk: open vhost char device failed");
+            goto virtio_err;
+        }
+
+        ret = vhost_dev_init(&blk->dev, (void *)(uintptr_t)blk->vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+        if (ret < 0) {
+            close(blk->vhostfd);
+            error_report_err(local_err);
+            error_report("vhost-blk: vhost initialization failed: %s",
+                         strerror(-ret));
+            goto virtio_err;
+        }
+    }
+    return;
+
+virtio_err:
+    for (i = 0; i < opened; i++) {
+        vhost_dev_cleanup(&s->vhblk[i].dev);
+        /* vhostfd is closed by vhost_dev_cleanup */
+    }
+    abort();
+}
+
+static void vhost_blk_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    int i, total_queues = 0;
+
+    if (!s->vhost_enabled) {
+        return;
+    }
+
+    if (vhost_blk_started(vdev, status) ==
+        !!s->vhost_started) {
+        return;
+    }
+
+    if (!s->vhost_started) {
+        for (i = 0; i < s->conf.num_queues; i++) {
+            if (virtio_queue_get_desc_addr(vdev, i)) {
+                total_queues++;
+           }
+        }
+        info_report("start vhost dataplane, total queues %d", total_queues);
+        s->vhost_started = true;
+        vhost_blk_start(vdev, total_queues);
+    } else {
+        for (i = 0; i < s->conf.num_queues; i++) {
+            if (s->vhblk[i].dev.started) {
+                total_queues++;
+            }
+        }
+        info_report("stop vhost dataplane, total queues %d", total_queues);
+        vhost_blk_stop(vdev, total_queues);
+        s->vhost_started = false;
+    }
+}
+
+static void vhost_blk_ack_features(VirtIODevice *vdev, vhost_blk *blk,
+                                  uint64_t features)
+{
+    blk->dev.acked_features = blk->dev.backend_features;
+    vhost_ack_features(&blk->dev, kernel_feature_bits, features);
+    info_report("acked features %lxh", blk->dev.acked_features);
+}
+
+static void virtio_blk_set_features(VirtIODevice *vdev, uint64_t features)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    int i;
+
+    if (!s->vhost_enabled) {
+        return;
+    }
+
+    for (i = 0;  i < s->conf.num_queues; i++) {
+        vhost_blk_ack_features(vdev, &s->vhblk[i], features);
+    }
+
+    /* restart vhost with the new acked features */
+    vhost_blk_set_status(vdev, 0);
+    s->vhost_acked = true;
+}
+
 static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
                                         Error **errp)
 {
@@ -1401,6 +1675,14 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
     }
 
+    if (s->vhost_enabled) {
+        virtio_clear_feature(&features, VIRTIO_BLK_F_SCSI);
+        /* we are sure thare is one vhost-blk instance at least */
+        features = vhost_get_features(&s->vhblk[0].dev, kernel_feature_bits,
+                                      features);
+        vdev->backend_features = features;
+    }
+
     return features;
 }
 
@@ -1408,6 +1690,11 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
+    /* close vhost backend after saving */
+    if (!vdev->vm_running) {
+        vhost_blk_set_status(vdev, 0);
+    }
+
     if (!(status & (VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK))) {
         assert(!s->ioeventfd_started);
     }
@@ -1782,6 +2069,11 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
     Error *local_err = NULL;
     int r;
 
+    if (s->vhost_enabled && vdev->vm_running) {
+        vhost_blk_set_status(vdev, VIRTIO_CONFIG_S_DRIVER_OK);
+        return 0;
+    }
+
     if (s->ioeventfd_started || s->ioeventfd_starting) {
         return 0;
     }
@@ -1901,6 +2193,10 @@ static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
         return;
     }
 
+    if (!s->vhost_enabled) {
+        virtio_blk_data_plane_stop(vdev);
+    }
+
     /* Better luck next time. */
     if (s->ioeventfd_disabled) {
         s->ioeventfd_disabled = false;
@@ -1959,6 +2255,80 @@ static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
     s->ioeventfd_stopping = false;
 }
 
+static bool virtio_blk_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    vhost_blk *blk = &s->vhblk[idx];
+    assert(s->vhost_started);
+    return vhost_virtqueue_pending(&blk->dev, idx);
+}
+
+static void virtio_blk_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                          bool mask)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    vhost_blk *blk = &s->vhblk[idx];
+    assert(s->vhost_started);
+    vhost_virtqueue_mask(&blk->dev, vdev, idx, mask);
+}
+
+static void vhost_blk_device_unrealize(DeviceState *dev)
+{
+    VirtIOBlock *s = VIRTIO_BLK(dev);
+    vhost_blk *blk;
+    unsigned int i;
+
+    if (!s->vhost_enabled) {
+        return;
+    }
+
+    for (i = 0; i < s->conf.num_queues; i++) {
+        blk = &s->vhblk[i];
+        vhost_dev_cleanup(&blk->dev);
+        /* vhostfd is closed by vhost_dev_cleanup */
+    }
+    close(s->blkfd);
+}
+
+
+static void vhost_blk_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOBlock *s = VIRTIO_BLK(dev);
+    BlockDriverState *bs;
+    int fd, flags = O_RDWR;
+
+    if (!s->vhost_enabled) {
+        return;
+    }
+
+    bs = blk_bs(s->blk);
+
+    if (bs->drv != &bdrv_raw) {
+        error_setg(errp, "vhost-blk only support raw image now");
+        return;
+    }
+
+    if (bs->open_flags & BDRV_O_NOCACHE) {
+        info_report("open backend with direct-io");
+        flags |= O_DIRECT;
+    } else {
+        info_report("open backend with buffer-io");
+    }
+
+    fd = open(bs->filename, flags);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "could not open '%s'", bs->filename);
+        return;
+    }
+
+    s->blkfd = fd;
+    vhost_blk_dataplane_create(vdev, s->conf.num_queues);
+
+    s->vhost_started = false;
+    s->vhost_acked = false;
+}
+
 static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -2050,6 +2420,19 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < conf->num_queues; i++) {
         virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
+    if (s->vhost_enabled) {
+        s->dataplane_disabled = true;
+        vhost_blk_device_realize(dev, &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            for (i = 0; i < conf->num_queues; i++) {
+                virtio_del_queue(vdev, i);
+            }
+            virtio_cleanup(vdev);
+            return;
+        }
+        vdev->use_guest_notifier_mask = true;
+    }
     qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2);
 
     /* Don't start ioeventfd if transport does not support notifiers. */
@@ -2094,6 +2477,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
 
     blk_drain(s->blk);
     del_boot_device_lchs(dev, "/disk@0,0");
+    vhost_blk_device_unrealize(dev);
     virtio_blk_vq_aio_context_cleanup(s);
     for (i = 0; i < conf->num_queues; i++) {
         virtio_del_queue(vdev, i);
@@ -2102,6 +2486,9 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
     qemu_mutex_destroy(&s->rq_lock);
     blk_ram_registrar_destroy(&s->blk_ram_registrar);
     qemu_del_vm_change_state_handler(s->change);
+    if (s->change) {
+        qemu_del_vm_change_state_handler(s->change);
+    }
     blockdev_mark_auto_del(s->blk);
     virtio_cleanup(vdev);
 }
@@ -2115,6 +2502,18 @@ static void virtio_blk_instance_init(Object *obj)
                                   DEVICE(obj));
 }
 
+static int virtio_blk_pre_save(void *opaque)
+{
+    VirtIOBlock *s = opaque;
+
+    /* At this point, backend must be stopped, otherwise
+     * it might keep writing to memory.
+     */
+    assert(!s->vhost_started);
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_blk = {
     .name = "virtio-blk",
     .minimum_version_id = 2,
@@ -2123,6 +2522,7 @@ static const VMStateDescription vmstate_virtio_blk = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .pre_save = virtio_blk_pre_save,
 };
 
 static Property virtio_blk_properties[] = {
@@ -2158,6 +2558,7 @@ static Property virtio_blk_properties[] = {
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
                      conf.x_enable_wce_if_config_wce, true),
+    DEFINE_PROP_BOOL("vhost", VirtIOBlock, vhost_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2174,12 +2575,15 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->set_features = virtio_blk_set_features;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
     vdc->load = virtio_blk_load_device;
     vdc->start_ioeventfd = virtio_blk_start_ioeventfd;
     vdc->stop_ioeventfd = virtio_blk_stop_ioeventfd;
+    vdc->guest_notifier_mask = virtio_blk_guest_notifier_mask;
+    vdc->guest_notifier_pending = virtio_blk_guest_notifier_pending;
 }
 
 static const TypeInfo virtio_blk_info = {
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 5c14110c4b..0edb2d5002 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -50,6 +50,20 @@ struct VirtIOBlkConf
     bool x_enable_wce_if_config_wce;
 };
 
+typedef struct vhost_blk {
+    struct vhost_dev dev;
+    /* vhost-blk only use ONE virtqueue now */
+    struct vhost_virtqueue vqs[1];
+    /* fd for chardev /dev/vhost-blk */
+    int vhostfd;
+} vhost_blk;
+
+/* Attach virtio blk ring to an ocfs2 file with modified dio framework.
+ * Pass fd -1 to unbind from the file and the backend. This can be used
+ * to stop the ring (e.g. for migration). */
+#define VHOST_BLK_SET_BACKEND _IOW(VHOST_VIRTIO, 0x50, struct vhost_vring_file)
+
+
 struct VirtIOBlockReq;
 struct VirtIOBlock {
     VirtIODevice parent_obj;
@@ -71,6 +85,12 @@ struct VirtIOBlock {
      */
     AioContext **vq_aio_context;
 
+    int blkfd;
+    bool vhost_enabled;
+    bool vhost_started;
+    bool vhost_acked;
+    vhost_blk vhblk[VIRTIO_QUEUE_MAX];
+
     uint64_t host_features;
     size_t config_size;
     BlockRAMRegistrar blk_ram_registrar;
-- 
2.34.1


