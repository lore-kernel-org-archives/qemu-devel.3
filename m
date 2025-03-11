Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D90CC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2Bv-0006if-Ui; Tue, 11 Mar 2025 12:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22p-0004X2-93
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22h-0005oc-SO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQ0xCHnasOhoHWvSQCCdtyFzo2H0y014rFFzhhMEOKc=;
 b=dHNh6RWdbz9JcS9hvuoI0+TYvJV0uL2wx3HDBQU9E8KzZkxzCHILhpViUXr+BasxfjUfoI
 bosE+q6wI/XfUK26nxYAgsNyGKB/bRIxV91nb4qeVucHFCxYe65lrKD+ZAHelek6hX/Lak
 All4rweuGmW5FsLs+l1Jb94KPLPjOUE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-De5gOT-HMGS202r4gvqS2A-1; Tue,
 11 Mar 2025 12:01:09 -0400
X-MC-Unique: De5gOT-HMGS202r4gvqS2A-1
X-Mimecast-MFC-AGG-ID: De5gOT-HMGS202r4gvqS2A_1741708868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7057A195608F; Tue, 11 Mar 2025 16:01:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A100718001E9; Tue, 11 Mar 2025 16:01:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 20/22] virtio-scsi: add iothread-vq-mapping parameter
Date: Tue, 11 Mar 2025 17:00:19 +0100
Message-ID: <20250311160021.349761-21-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Allow virtio-scsi virtqueues to be assigned to different IOThreads. This
makes it possible to take advantage of host multi-queue block layer
scalability by assigning virtqueues that have affinity with vCPUs to
different IOThreads that have affinity with host CPUs. The same feature
was introduced for virtio-blk in the past:
https://developers.redhat.com/articles/2024/09/05/scaling-virtio-blk-disk-io-iothread-virtqueue-mapping

Here are fio randread 4k iodepth=64 results from a 4 vCPU guest with an
Intel P4800X SSD:
iothreads IOPS
------------------------------
1         189576
2         312698
4         346744

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250311132616.1049687-12-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |  5 +-
 hw/scsi/virtio-scsi-dataplane.c | 90 ++++++++++++++++++++++++---------
 hw/scsi/virtio-scsi.c           | 63 ++++++++++++++---------
 3 files changed, 107 insertions(+), 51 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 7b7e3ced7a..086201efa2 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/scsi/scsi.h"
 #include "chardev/char-fe.h"
+#include "qapi/qapi-types-virtio.h"
 #include "system/iothread.h"
 
 #define TYPE_VIRTIO_SCSI_COMMON "virtio-scsi-common"
@@ -60,6 +61,7 @@ struct VirtIOSCSIConf {
     CharBackend chardev;
     uint32_t boot_tpgt;
     IOThread *iothread;
+    IOThreadVirtQueueMappingList *iothread_vq_mapping_list;
 };
 
 struct VirtIOSCSI;
@@ -97,7 +99,7 @@ struct VirtIOSCSI {
     QTAILQ_HEAD(, VirtIOSCSIReq) tmf_bh_list;
 
     /* Fields for dataplane below */
-    AioContext *ctx; /* one iothread per virtio-scsi-pci for now */
+    AioContext **vq_aio_context; /* per-virtqueue AioContext pointer */
 
     bool dataplane_started;
     bool dataplane_starting;
@@ -115,6 +117,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
 void virtio_scsi_common_unrealize(DeviceState *dev);
 
 void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp);
+void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s);
 int virtio_scsi_dataplane_start(VirtIODevice *s);
 void virtio_scsi_dataplane_stop(VirtIODevice *s);
 
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index f49ab98ecc..6bb368c8a5 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -18,6 +18,7 @@
 #include "system/block-backend.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
+#include "hw/virtio/iothread-vq-mapping.h"
 #include "hw/virtio/virtio-bus.h"
 
 /* Context: BQL held */
@@ -27,8 +28,16 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    uint16_t num_vqs = vs->conf.num_queues + VIRTIO_SCSI_VQ_NUM_FIXED;
 
-    if (vs->conf.iothread) {
+    if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
+        error_setg(errp,
+                   "iothread and iothread-vq-mapping properties cannot be set "
+                   "at the same time");
+        return;
+    }
+
+    if (vs->conf.iothread || vs->conf.iothread_vq_mapping_list) {
         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
             error_setg(errp,
                        "device is incompatible with iothread "
@@ -39,13 +48,48 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             error_setg(errp, "ioeventfd is required for iothread");
             return;
         }
-        s->ctx = iothread_get_aio_context(vs->conf.iothread);
-    } else {
-        if (!virtio_device_ioeventfd_enabled(vdev)) {
+    }
+
+    s->vq_aio_context = g_new(AioContext *, num_vqs);
+
+    if (vs->conf.iothread_vq_mapping_list) {
+        if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
+                                       s->vq_aio_context, num_vqs, errp)) {
+            g_free(s->vq_aio_context);
+            s->vq_aio_context = NULL;
             return;
         }
-        s->ctx = qemu_get_aio_context();
+    } else if (vs->conf.iothread) {
+        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
+        for (uint16_t i = 0; i < num_vqs; i++) {
+            s->vq_aio_context[i] = ctx;
+        }
+
+        /* Released in virtio_scsi_dataplane_cleanup() */
+        object_ref(OBJECT(vs->conf.iothread));
+    } else {
+        AioContext *ctx = qemu_get_aio_context();
+        for (unsigned i = 0; i < num_vqs; i++) {
+            s->vq_aio_context[i] = ctx;
+        }
+    }
+}
+
+/* Context: BQL held */
+void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
+{
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+
+    if (vs->conf.iothread_vq_mapping_list) {
+        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list);
     }
+
+    if (vs->conf.iothread) {
+        object_unref(OBJECT(vs->conf.iothread));
+    }
+
+    g_free(s->vq_aio_context);
+    s->vq_aio_context = NULL;
 }
 
 static int virtio_scsi_set_host_notifier(VirtIOSCSI *s, VirtQueue *vq, int n)
@@ -66,31 +110,20 @@ static int virtio_scsi_set_host_notifier(VirtIOSCSI *s, VirtQueue *vq, int n)
 }
 
 /* Context: BH in IOThread */
-static void virtio_scsi_dataplane_stop_bh(void *opaque)
+static void virtio_scsi_dataplane_stop_vq_bh(void *opaque)
 {
-    VirtIOSCSI *s = opaque;
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    AioContext *ctx = qemu_get_current_aio_context();
+    VirtQueue *vq = opaque;
     EventNotifier *host_notifier;
-    int i;
 
-    virtio_queue_aio_detach_host_notifier(vs->ctrl_vq, s->ctx);
-    host_notifier = virtio_queue_get_host_notifier(vs->ctrl_vq);
+    virtio_queue_aio_detach_host_notifier(vq, ctx);
+    host_notifier = virtio_queue_get_host_notifier(vq);
 
     /*
      * Test and clear notifier after disabling event, in case poll callback
      * didn't have time to run.
      */
     virtio_queue_host_notifier_read(host_notifier);
-
-    virtio_queue_aio_detach_host_notifier(vs->event_vq, s->ctx);
-    host_notifier = virtio_queue_get_host_notifier(vs->event_vq);
-    virtio_queue_host_notifier_read(host_notifier);
-
-    for (i = 0; i < vs->conf.num_queues; i++) {
-        virtio_queue_aio_detach_host_notifier(vs->cmd_vqs[i], s->ctx);
-        host_notifier = virtio_queue_get_host_notifier(vs->cmd_vqs[i]);
-        virtio_queue_host_notifier_read(host_notifier);
-    }
 }
 
 /* Context: BQL held */
@@ -154,11 +187,14 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
     smp_wmb(); /* paired with aio_notify_accept() */
 
     if (s->bus.drain_count == 0) {
-        virtio_queue_aio_attach_host_notifier(vs->ctrl_vq, s->ctx);
-        virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq, s->ctx);
+        virtio_queue_aio_attach_host_notifier(vs->ctrl_vq,
+                                              s->vq_aio_context[0]);
+        virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq,
+                                                      s->vq_aio_context[1]);
 
         for (i = 0; i < vs->conf.num_queues; i++) {
-            virtio_queue_aio_attach_host_notifier(vs->cmd_vqs[i], s->ctx);
+            AioContext *ctx = s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i];
+            virtio_queue_aio_attach_host_notifier(vs->cmd_vqs[i], ctx);
         }
     }
     return 0;
@@ -207,7 +243,11 @@ void virtio_scsi_dataplane_stop(VirtIODevice *vdev)
     s->dataplane_stopping = true;
 
     if (s->bus.drain_count == 0) {
-        aio_wait_bh_oneshot(s->ctx, virtio_scsi_dataplane_stop_bh, s);
+        for (i = 0; i < vs->conf.num_queues + VIRTIO_SCSI_VQ_NUM_FIXED; i++) {
+            VirtQueue *vq = virtio_get_queue(&vs->parent_obj, i);
+            AioContext *ctx = s->vq_aio_context[i];
+            aio_wait_bh_oneshot(ctx, virtio_scsi_dataplane_stop_vq_bh, vq);
+        }
     }
 
     blk_drain_all(); /* ensure there are no in-flight requests */
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 2045d27289..9f61eb97db 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
+#include "hw/virtio/iothread-vq-mapping.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "trace.h"
@@ -318,13 +319,6 @@ static void virtio_scsi_cancel_notify(Notifier *notifier, void *data)
     g_free(n);
 }
 
-static inline void virtio_scsi_ctx_check(VirtIOSCSI *s, SCSIDevice *d)
-{
-    if (s->dataplane_started && d && blk_is_available(d->conf.blk)) {
-        assert(blk_get_aio_context(d->conf.blk) == s->ctx);
-    }
-}
-
 static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
 {
     VirtIOSCSI *s = req->dev;
@@ -517,9 +511,11 @@ static void virtio_scsi_flush_defer_tmf_to_aio_context(VirtIOSCSI *s)
 
     assert(!s->dataplane_started);
 
-    if (s->ctx) {
+    for (uint32_t i = 0; i < s->parent_obj.conf.num_queues; i++) {
+        AioContext *ctx = s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i];
+
         /* Our BH only runs after previously scheduled BHs */
-        aio_wait_bh_oneshot(s->ctx, dummy_bh, NULL);
+        aio_wait_bh_oneshot(ctx, dummy_bh, NULL);
     }
 }
 
@@ -575,7 +571,6 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
     AioContext *ctx;
     int ret = 0;
 
-    virtio_scsi_ctx_check(s, d);
     /* Here VIRTIO_SCSI_S_OK means "FUNCTION COMPLETE".  */
     req->resp.tmf.response = VIRTIO_SCSI_S_OK;
 
@@ -639,6 +634,8 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
 
     case VIRTIO_SCSI_T_TMF_ABORT_TASK_SET:
     case VIRTIO_SCSI_T_TMF_CLEAR_TASK_SET: {
+        g_autoptr(GHashTable) aio_contexts = g_hash_table_new(NULL, NULL);
+
         if (!d) {
             goto fail;
         }
@@ -648,8 +645,15 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
 
         qatomic_inc(&req->remaining);
 
-        ctx = s->ctx ?: qemu_get_aio_context();
-        virtio_scsi_defer_tmf_to_aio_context(req, ctx);
+        for (uint32_t i = 0; i < s->parent_obj.conf.num_queues; i++) {
+            ctx = s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i];
+
+            if (!g_hash_table_add(aio_contexts, ctx)) {
+                continue; /* skip previously added AioContext */
+            }
+
+            virtio_scsi_defer_tmf_to_aio_context(req, ctx);
+        }
 
         virtio_scsi_tmf_dec_remaining(req);
         ret = -EINPROGRESS;
@@ -770,9 +774,12 @@ static void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
  */
 static bool virtio_scsi_defer_to_dataplane(VirtIOSCSI *s)
 {
-    if (!s->ctx || s->dataplane_started) {
+    if (s->dataplane_started) {
         return false;
     }
+    if (s->vq_aio_context[0] == qemu_get_aio_context()) {
+        return false; /* not using IOThreads */
+    }
 
     virtio_device_start_ioeventfd(&s->parent_obj.parent_obj);
     return !s->dataplane_fenced;
@@ -946,7 +953,6 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
         virtio_scsi_complete_cmd_req(req);
         return -ENOENT;
     }
-    virtio_scsi_ctx_check(s, d);
     req->sreq = scsi_req_new(d, req->req.cmd.tag,
                              virtio_scsi_get_lun(req->req.cmd.lun),
                              req->req.cmd.cdb, vs->cdb_size, req);
@@ -1218,14 +1224,16 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
+    AioContext *ctx = s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED];
     SCSIDevice *sd = SCSI_DEVICE(dev);
-    int ret;
 
-    if (s->ctx && !s->dataplane_fenced) {
-        ret = blk_set_aio_context(sd->conf.blk, s->ctx, errp);
-        if (ret < 0) {
-            return;
-        }
+    if (ctx != qemu_get_aio_context() && !s->dataplane_fenced) {
+        /*
+         * Try to make the BlockBackend's AioContext match ours. Ignore failure
+         * because I/O will still work although block jobs and other users
+         * might be slower when multiple AioContexts use a BlockBackend.
+         */
+        blk_set_aio_context(sd->conf.blk, ctx, errp);
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
@@ -1260,7 +1268,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 
-    if (s->ctx) {
+    if (s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED] != qemu_get_aio_context()) {
         /* If other users keep the BlockBackend in the iothread, that's ok */
         blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
     }
@@ -1294,7 +1302,7 @@ static void virtio_scsi_drained_begin(SCSIBus *bus)
 
     for (uint32_t i = 0; i < total_queues; i++) {
         VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_detach_host_notifier(vq, s->ctx);
+        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
     }
 }
 
@@ -1320,10 +1328,12 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
 
     for (uint32_t i = 0; i < total_queues; i++) {
         VirtQueue *vq = virtio_get_queue(vdev, i);
+        AioContext *ctx = s->vq_aio_context[i];
+
         if (vq == vs->event_vq) {
-            virtio_queue_aio_attach_host_notifier_no_poll(vq, s->ctx);
+            virtio_queue_aio_attach_host_notifier_no_poll(vq, ctx);
         } else {
-            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+            virtio_queue_aio_attach_host_notifier(vq, ctx);
         }
     }
 }
@@ -1430,12 +1440,13 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
+/* main loop */
 static void virtio_scsi_device_unrealize(DeviceState *dev)
 {
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
 
     virtio_scsi_reset_tmf_bh(s);
-
+    virtio_scsi_dataplane_cleanup(s);
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
     virtio_scsi_common_unrealize(dev);
     qemu_mutex_destroy(&s->tmf_bh_lock);
@@ -1460,6 +1471,8 @@ static const Property virtio_scsi_properties[] = {
                                                 VIRTIO_SCSI_F_CHANGE, true),
     DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
                      TYPE_IOTHREAD, IOThread *),
+    DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST("iothread-vq-mapping", VirtIOSCSI,
+            parent_obj.conf.iothread_vq_mapping_list),
 };
 
 static const VMStateDescription vmstate_virtio_scsi = {
-- 
2.48.1


