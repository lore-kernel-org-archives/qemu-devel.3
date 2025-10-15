Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC86CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91nn-0005Y3-2w; Wed, 15 Oct 2025 09:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1v91ni-0005XM-IO; Wed, 15 Oct 2025 09:44:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1v91nY-0006Qp-Vf; Wed, 15 Oct 2025 09:44:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 171876883A;
 Wed, 15 Oct 2025 15:43:57 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, mst@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, qemu-stable@nongnu.org
Subject: [RFC] hw/scsi: avoid deadlock upon TMF request canceling with VirtIO
Date: Wed, 15 Oct 2025 15:43:50 +0200
Message-ID: <20251015134351.380079-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1760535833555
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When scsi_req_dequeue() is reached via
scsi_req_cancel_async()
virtio_scsi_tmf_cancel_req()
virtio_scsi_do_tmf_aio_context(),
there is a deadlock when trying to acquire the SCSI device's requests
lock, because it was already acquired in
virtio_scsi_do_tmf_aio_context().

In particular, the issue happens with a FreeBSD guest (13, 14, 15,
maybe more), when it cancels SCSI requests, because of timeout.

This is a regression caused by commit da6eebb33b ("virtio-scsi:
perform TMFs in appropriate AioContexts") and the introduction of the
requests_lock earlier.

Keep track of whether the device's requests lock is already being held
and do not re-acquire it in scsi_req_dequeue() to fix the issue. Since
scsi_req_dequeue() removes entries from the queue, it's necessary to
switch to the safe variant when iterating in
virtio_scsi_do_tmf_aio_context().

Originally reported by Proxmox VE users:
https://bugzilla.proxmox.com/show_bug.cgi?id=6810
https://forum.proxmox.com/threads/173914/

Fixes: da6eebb33b ("virtio-scsi: perform TMFs in appropriate AioContexts")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

RFC, because it's a naive approach, maybe somebody has a better idea?

 hw/scsi/mptsas.c       |  4 ++--
 hw/scsi/scsi-bus.c     | 25 +++++++++++++++----------
 hw/scsi/virtio-scsi.c  |  8 ++++++--
 include/hw/scsi/scsi.h |  3 ++-
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 4ada35b7ec..30d773235c 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -466,7 +466,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState *s, MPIMsgSCSITaskMgmt *re
                 notifier->s = s;
                 notifier->reply = reply_async;
                 notifier->notifier.notify = mptsas_cancel_notify;
-                scsi_req_cancel_async(r, &notifier->notifier);
+                scsi_req_cancel_async(r, &notifier->notifier, false);
                 goto reply_maybe_async;
             }
         }
@@ -498,7 +498,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState *s, MPIMsgSCSITaskMgmt *re
                 notifier->s = s;
                 notifier->reply = reply_async;
                 notifier->notifier.notify = mptsas_cancel_notify;
-                scsi_req_cancel_async(r, &notifier->notifier);
+                scsi_req_cancel_async(r, &notifier->notifier, false);
             }
         }
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9b12ee7f1c..827b85a68f 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -19,7 +19,7 @@
 
 static char *scsibus_get_dev_path(DeviceState *dev);
 static char *scsibus_get_fw_dev_path(DeviceState *dev);
-static void scsi_req_dequeue(SCSIRequest *req);
+static void scsi_req_dequeue(SCSIRequest *req, bool holds_requests_lock);
 static uint8_t *scsi_target_alloc_buf(SCSIRequest *req, size_t len);
 static void scsi_target_free_buf(SCSIRequest *req);
 static void scsi_clear_reported_luns_changed(SCSIRequest *req);
@@ -290,7 +290,7 @@ static void scsi_dma_restart_req(SCSIRequest *req, void *opaque)
                 scsi_req_continue(req);
                 break;
             case SCSI_XFER_NONE:
-                scsi_req_dequeue(req);
+                scsi_req_dequeue(req, false);
                 scsi_req_enqueue(req);
                 break;
         }
@@ -1029,13 +1029,17 @@ int32_t scsi_req_enqueue(SCSIRequest *req)
     return rc;
 }
 
-static void scsi_req_dequeue(SCSIRequest *req)
+static void scsi_req_dequeue(SCSIRequest *req, bool holds_requests_lock)
 {
     trace_scsi_req_dequeue(req->dev->id, req->lun, req->tag);
     req->retry = false;
     if (req->enqueued) {
-        WITH_QEMU_LOCK_GUARD(&req->dev->requests_lock) {
+        if (holds_requests_lock) {
             QTAILQ_REMOVE(&req->dev->requests, req, next);
+        } else {
+            WITH_QEMU_LOCK_GUARD(&req->dev->requests_lock) {
+                QTAILQ_REMOVE(&req->dev->requests, req, next);
+            }
         }
         req->enqueued = false;
         scsi_req_unref(req);
@@ -1618,7 +1622,7 @@ void scsi_req_complete_failed(SCSIRequest *req, int host_status)
 
     req->host_status = host_status;
     scsi_req_ref(req);
-    scsi_req_dequeue(req);
+    scsi_req_dequeue(req, false);
     req->bus->info->fail(req);
 
     /* Cancelled requests might end up being completed instead of cancelled */
@@ -1647,7 +1651,7 @@ void scsi_req_complete(SCSIRequest *req, int status)
     }
 
     scsi_req_ref(req);
-    scsi_req_dequeue(req);
+    scsi_req_dequeue(req, false);
     req->bus->info->complete(req, req->residual);
 
     /* Cancelled requests might end up being completed instead of cancelled */
@@ -1670,7 +1674,8 @@ void scsi_req_cancel_complete(SCSIRequest *req)
  * notifier list, the bus will be notified the requests cancellation is
  * completed.
  * */
-void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier)
+void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier,
+                           bool holds_requests_lock)
 {
     trace_scsi_req_cancel(req->dev->id, req->lun, req->tag);
     if (notifier) {
@@ -1686,7 +1691,7 @@ void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier)
     }
     /* Dropped in scsi_req_cancel_complete.  */
     scsi_req_ref(req);
-    scsi_req_dequeue(req);
+    scsi_req_dequeue(req, holds_requests_lock);
     req->io_canceled = true;
     if (req->aiocb) {
         blk_aio_cancel_async(req->aiocb);
@@ -1704,7 +1709,7 @@ void scsi_req_cancel(SCSIRequest *req)
     assert(!req->io_canceled);
     /* Dropped in scsi_req_cancel_complete.  */
     scsi_req_ref(req);
-    scsi_req_dequeue(req);
+    scsi_req_dequeue(req, false);
     req->io_canceled = true;
     if (req->aiocb) {
         blk_aio_cancel(req->aiocb);
@@ -1782,7 +1787,7 @@ void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
 
 static void scsi_device_purge_one_req(SCSIRequest *req, void *opaque)
 {
-    scsi_req_cancel_async(req, NULL);
+    scsi_req_cancel_async(req, NULL, false);
 }
 
 /**
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d817fc42b4..48612f8738 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -315,6 +315,7 @@ static void virtio_scsi_cancel_notify(Notifier *notifier, void *data)
     g_free(n);
 }
 
+/* Must be called with r->dev->requests_lock held. */
 static void virtio_scsi_tmf_cancel_req(VirtIOSCSIReq *tmf, SCSIRequest *r)
 {
     VirtIOSCSICancelNotifier *notifier;
@@ -327,7 +328,7 @@ static void virtio_scsi_tmf_cancel_req(VirtIOSCSIReq *tmf, SCSIRequest *r)
     notifier = g_new(VirtIOSCSICancelNotifier, 1);
     notifier->notifier.notify = virtio_scsi_cancel_notify;
     notifier->tmf_req = tmf;
-    scsi_req_cancel_async(r, &notifier->notifier);
+    scsi_req_cancel_async(r, &notifier->notifier, true);
 }
 
 /* Execute a TMF on the requests in the current AioContext */
@@ -364,7 +365,9 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
     }
 
     WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
-        QTAILQ_FOREACH(r, &d->requests, next) {
+        SCSIRequest *tmp;
+        /* scsi_req_dequeue() removes entries from queue, use safe iteration */
+        QTAILQ_FOREACH_SAFE(r, &d->requests, next, tmp) {
             VirtIOSCSIReq *cmd_req = r->hba_private;
             assert(cmd_req); /* request has hba_private while enqueued */
 
@@ -374,6 +377,7 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
             if (match_tag && cmd_req->req.cmd.tag != tmf->req.tmf.tag) {
                 continue;
             }
+            assert(&d->requests_lock == &r->dev->requests_lock);
             virtio_scsi_tmf_cancel_req(tmf, r);
         }
     }
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 90ee192b4d..49b898e44a 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -226,7 +226,8 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req);
 int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len);
 void scsi_req_cancel_complete(SCSIRequest *req);
 void scsi_req_cancel(SCSIRequest *req);
-void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier);
+void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier,
+                           bool holds_requests_lock);
 void scsi_req_retry(SCSIRequest *req);
 void scsi_device_drained_begin(SCSIDevice *sdev);
 void scsi_device_drained_end(SCSIDevice *sdev);
-- 
2.47.3



