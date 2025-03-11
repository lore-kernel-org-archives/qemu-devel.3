Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB3CC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trwb5-0006TT-C3; Tue, 11 Mar 2025 06:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trwb3-0006SR-0w
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trwav-0005em-U8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741687937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+CBBHVFHYNuPG5khaRJmuyKUdSakM0KMD2Bj8O8nm4=;
 b=QBCvCMqJ8ymxuY+ZV0/YRDStpKpzEWDKRAXKD7y77X8rpeCcheYOX/Delv8CvWFv+xAYJp
 xyC5Ouh6X0ejnmKB/fmRD4PXivQlOVlKsmSkrOxvuBJQ+jZhwmlrRqOm/ZFBCcLXOT2XhG
 q4uaMrpnwQdYm1IZRw7yQ+UIsb9gIAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-CTsJjIUOMNSNVXos_ds6Xg-1; Tue,
 11 Mar 2025 06:12:15 -0400
X-MC-Unique: CTsJjIUOMNSNVXos_ds6Xg-1
X-Mimecast-MFC-AGG-ID: CTsJjIUOMNSNVXos_ds6Xg_1741687934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89E18180AF6E; Tue, 11 Mar 2025 10:12:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 776851828A93; Tue, 11 Mar 2025 10:12:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 <qemu-block@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 pkrempa@redhat.com, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 05/13] virtio-scsi: introduce event and ctrl virtqueue locks
Date: Tue, 11 Mar 2025 18:11:37 +0800
Message-ID: <20250311101145.1037388-6-stefanha@redhat.com>
In-Reply-To: <20250311101145.1037388-1-stefanha@redhat.com>
References: <20250311101145.1037388-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

Virtqueues are not thread-safe. Until now this was not a major issue
since all virtqueue processing happened in the same thread. The ctrl
queue's Task Management Function (TMF) requests sometimes need the main
loop, so a BH was used to schedule the virtqueue completion back in the
thread that has virtqueue access.

When IOThread Virtqueue Mapping is introduced in later commits, event
and ctrl virtqueue accesses from other threads will become necessary.
Introduce an optional per-virtqueue lock so the event and ctrl
virtqueues can be protected in the commits that follow.

The addition of the ctrl virtqueue lock makes
virtio_scsi_complete_req_from_main_loop() and its BH unnecessary.
Instead, take the ctrl virtqueue lock from the main loop thread.

The cmd virtqueue does not have a lock because the entirety of SCSI
command processing happens in one thread. Only one thread accesses the
cmd virtqueue and a lock is unnecessary.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |  3 ++
 hw/scsi/virtio-scsi.c           | 90 ++++++++++++++++++---------------
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index be230cd4bf..4ee98ebf63 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -84,6 +84,9 @@ struct VirtIOSCSI {
     int resetting; /* written from main loop thread, read from any thread */
     bool events_dropped;
 
+    QemuMutex ctrl_lock; /* protects ctrl_vq */
+    QemuMutex event_lock; /* protects event_vq */
+
     /*
      * TMFs deferred to main loop BH. These fields are protected by
      * tmf_bh_lock.
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 7d094e1881..073ccd3d5b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -102,13 +102,18 @@ static void virtio_scsi_free_req(VirtIOSCSIReq *req)
     g_free(req);
 }
 
-static void virtio_scsi_complete_req(VirtIOSCSIReq *req)
+static void virtio_scsi_complete_req(VirtIOSCSIReq *req, QemuMutex *vq_lock)
 {
     VirtIOSCSI *s = req->dev;
     VirtQueue *vq = req->vq;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
     qemu_iovec_from_buf(&req->resp_iov, 0, &req->resp, req->resp_size);
+
+    if (vq_lock) {
+        qemu_mutex_lock(vq_lock);
+    }
+
     virtqueue_push(vq, &req->elem, req->qsgl.size + req->resp_iov.size);
     if (s->dataplane_started && !s->dataplane_fenced) {
         virtio_notify_irqfd(vdev, vq);
@@ -116,6 +121,10 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req)
         virtio_notify(vdev, vq);
     }
 
+    if (vq_lock) {
+        qemu_mutex_unlock(vq_lock);
+    }
+
     if (req->sreq) {
         req->sreq->hba_private = NULL;
         scsi_req_unref(req->sreq);
@@ -123,34 +132,20 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req)
     virtio_scsi_free_req(req);
 }
 
-static void virtio_scsi_complete_req_bh(void *opaque)
-{
-    VirtIOSCSIReq *req = opaque;
-
-    virtio_scsi_complete_req(req);
-}
-
-/*
- * Called from virtio_scsi_do_one_tmf_bh() in main loop thread. The main loop
- * thread cannot touch the virtqueue since that could race with an IOThread.
- */
-static void virtio_scsi_complete_req_from_main_loop(VirtIOSCSIReq *req)
-{
-    VirtIOSCSI *s = req->dev;
-
-    if (!s->ctx || s->ctx == qemu_get_aio_context()) {
-        /* No need to schedule a BH when there is no IOThread */
-        virtio_scsi_complete_req(req);
-    } else {
-        /* Run request completion in the IOThread */
-        aio_wait_bh_oneshot(s->ctx, virtio_scsi_complete_req_bh, req);
-    }
-}
-
-static void virtio_scsi_bad_req(VirtIOSCSIReq *req)
+static void virtio_scsi_bad_req(VirtIOSCSIReq *req, QemuMutex *vq_lock)
 {
     virtio_error(VIRTIO_DEVICE(req->dev), "wrong size for virtio-scsi headers");
+
+    if (vq_lock) {
+        qemu_mutex_lock(vq_lock);
+    }
+
     virtqueue_detach_element(req->vq, &req->elem, 0);
+
+    if (vq_lock) {
+        qemu_mutex_unlock(vq_lock);
+    }
+
     virtio_scsi_free_req(req);
 }
 
@@ -235,12 +230,21 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
     return 0;
 }
 
-static VirtIOSCSIReq *virtio_scsi_pop_req(VirtIOSCSI *s, VirtQueue *vq)
+static VirtIOSCSIReq *virtio_scsi_pop_req(VirtIOSCSI *s, VirtQueue *vq, QemuMutex *vq_lock)
 {
     VirtIOSCSICommon *vs = (VirtIOSCSICommon *)s;
     VirtIOSCSIReq *req;
 
+    if (vq_lock) {
+        qemu_mutex_lock(vq_lock);
+    }
+
     req = virtqueue_pop(vq, sizeof(VirtIOSCSIReq) + vs->cdb_size);
+
+    if (vq_lock) {
+        qemu_mutex_unlock(vq_lock);
+    }
+
     if (!req) {
         return NULL;
     }
@@ -305,7 +309,7 @@ static void virtio_scsi_cancel_notify(Notifier *notifier, void *data)
 
         trace_virtio_scsi_tmf_resp(virtio_scsi_get_lun(req->req.tmf.lun),
                                    req->req.tmf.tag, req->resp.tmf.response);
-        virtio_scsi_complete_req(req);
+        virtio_scsi_complete_req(req, &req->dev->ctrl_lock);
     }
     g_free(n);
 }
@@ -361,7 +365,7 @@ static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
 
 out:
     object_unref(OBJECT(d));
-    virtio_scsi_complete_req_from_main_loop(req);
+    virtio_scsi_complete_req(req, &s->ctrl_lock);
 }
 
 /* Some TMFs must be processed from the main loop thread */
@@ -408,7 +412,7 @@ static void virtio_scsi_reset_tmf_bh(VirtIOSCSI *s)
 
         /* SAM-6 6.3.2 Hard reset */
         req->resp.tmf.response = VIRTIO_SCSI_S_TARGET_FAILURE;
-        virtio_scsi_complete_req(req);
+        virtio_scsi_complete_req(req, &req->dev->ctrl_lock);
     }
 }
 
@@ -562,7 +566,7 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
 
     if (iov_to_buf(req->elem.out_sg, req->elem.out_num, 0,
                 &type, sizeof(type)) < sizeof(type)) {
-        virtio_scsi_bad_req(req);
+        virtio_scsi_bad_req(req, &s->ctrl_lock);
         return;
     }
 
@@ -570,7 +574,7 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
     if (type == VIRTIO_SCSI_T_TMF) {
         if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICtrlTMFReq),
                     sizeof(VirtIOSCSICtrlTMFResp)) < 0) {
-            virtio_scsi_bad_req(req);
+            virtio_scsi_bad_req(req, &s->ctrl_lock);
             return;
         } else {
             r = virtio_scsi_do_tmf(s, req);
@@ -580,7 +584,7 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
                type == VIRTIO_SCSI_T_AN_SUBSCRIBE) {
         if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICtrlANReq),
                     sizeof(VirtIOSCSICtrlANResp)) < 0) {
-            virtio_scsi_bad_req(req);
+            virtio_scsi_bad_req(req, &s->ctrl_lock);
             return;
         } else {
             req->req.an.event_requested =
@@ -600,7 +604,7 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
                  type == VIRTIO_SCSI_T_AN_SUBSCRIBE)
             trace_virtio_scsi_an_resp(virtio_scsi_get_lun(req->req.an.lun),
                                       req->resp.an.response);
-        virtio_scsi_complete_req(req);
+        virtio_scsi_complete_req(req, &s->ctrl_lock);
     } else {
         assert(r == -EINPROGRESS);
     }
@@ -610,7 +614,7 @@ static void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
 
-    while ((req = virtio_scsi_pop_req(s, vq))) {
+    while ((req = virtio_scsi_pop_req(s, vq, &s->ctrl_lock))) {
         virtio_scsi_handle_ctrl_req(s, req);
     }
 }
@@ -654,7 +658,7 @@ static void virtio_scsi_complete_cmd_req(VirtIOSCSIReq *req)
      * in virtio_scsi_command_complete.
      */
     req->resp_size = sizeof(VirtIOSCSICmdResp);
-    virtio_scsi_complete_req(req);
+    virtio_scsi_complete_req(req, NULL);
 }
 
 static void virtio_scsi_command_failed(SCSIRequest *r)
@@ -788,7 +792,7 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
             virtio_scsi_fail_cmd_req(req);
             return -ENOTSUP;
         } else {
-            virtio_scsi_bad_req(req);
+            virtio_scsi_bad_req(req, NULL);
             return -EINVAL;
         }
     }
@@ -843,7 +847,7 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
             virtio_queue_set_notification(vq, 0);
         }
 
-        while ((req = virtio_scsi_pop_req(s, vq))) {
+        while ((req = virtio_scsi_pop_req(s, vq, NULL))) {
             ret = virtio_scsi_handle_cmd_req_prepare(s, req);
             if (!ret) {
                 QTAILQ_INSERT_TAIL(&reqs, req, next);
@@ -973,7 +977,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
         return;
     }
 
-    req = virtio_scsi_pop_req(s, vs->event_vq);
+    req = virtio_scsi_pop_req(s, vs->event_vq, &s->event_lock);
     if (!req) {
         s->events_dropped = true;
         return;
@@ -985,7 +989,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
     }
 
     if (virtio_scsi_parse_req(req, 0, sizeof(VirtIOSCSIEvent))) {
-        virtio_scsi_bad_req(req);
+        virtio_scsi_bad_req(req, &s->event_lock);
         return;
     }
 
@@ -1005,7 +1009,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
     }
     trace_virtio_scsi_event(virtio_scsi_get_lun(evt->lun), event, reason);
 
-    virtio_scsi_complete_req(req);
+    virtio_scsi_complete_req(req, &s->event_lock);
 }
 
 static void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
@@ -1236,6 +1240,8 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
 
     QTAILQ_INIT(&s->tmf_bh_list);
+    qemu_mutex_init(&s->ctrl_lock);
+    qemu_mutex_init(&s->event_lock);
     qemu_mutex_init(&s->tmf_bh_lock);
 
     virtio_scsi_common_realize(dev,
@@ -1280,6 +1286,8 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
     virtio_scsi_common_unrealize(dev);
     qemu_mutex_destroy(&s->tmf_bh_lock);
+    qemu_mutex_destroy(&s->event_lock);
+    qemu_mutex_destroy(&s->ctrl_lock);
 }
 
 static const Property virtio_scsi_properties[] = {
-- 
2.48.1


