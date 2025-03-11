Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EDAC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzeM-0003Xi-OF; Tue, 11 Mar 2025 09:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdQ-0002Mt-VT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdN-0005Fc-40
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAHz6RB4kDNJyJvHeHywpNJORyXczYHYXtfqU2j/QsE=;
 b=R9ybre5MTKYYMAuN0bGX5ER3QysZtGVeYu1FxHbyeQvthHcOkwCHoWhlJu84PA/aSELzTq
 lhiKvocn7KWtOYHq72XFrHky7FFVnIugmTl121hKY4edU1dDPj0Q2t30dwg1OnwKYWveB4
 RsQZWvZR1UjRvkvE/IAmkDV4xEr3NVM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-WgYToQbmPU2RuJPQmkgq4w-1; Tue,
 11 Mar 2025 09:26:55 -0400
X-MC-Unique: WgYToQbmPU2RuJPQmkgq4w-1
X-Mimecast-MFC-AGG-ID: WgYToQbmPU2RuJPQmkgq4w_1741699614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5CBB18001E1; Tue, 11 Mar 2025 13:26:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 083A81801747; Tue, 11 Mar 2025 13:26:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 pkrempa@redhat.com, Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 07/13] virtio-scsi: perform TMFs in appropriate AioContexts
Date: Tue, 11 Mar 2025 21:26:10 +0800
Message-ID: <20250311132616.1049687-8-stefanha@redhat.com>
In-Reply-To: <20250311132616.1049687-1-stefanha@redhat.com>
References: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

With IOThread Virtqueue Mapping there will be multiple AioContexts
processing SCSI requests. scsi_req_cancel() and other SCSI request
operations must be performed from the AioContext where the request is
running.

Introduce a virtio_scsi_defer_tmf_to_aio_context() function and the
necessary VirtIOSCSIReq->remaining refcount infrastructure to move the
TMF code into the AioContext where the request is running.

For the time being there is still just one AioContext: the main loop or
the IOThread. When the iothread-vq-mapping parameter is added in a later
patch this will be changed to per-virtqueue AioContexts.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/virtio-scsi.c | 266 ++++++++++++++++++++++++++++++++----------
 1 file changed, 204 insertions(+), 62 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 2d796a861b..2045d27289 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -47,7 +47,7 @@ typedef struct VirtIOSCSIReq {
     /* Used for two-stage request submission and TMFs deferred to BH */
     QTAILQ_ENTRY(VirtIOSCSIReq) next;
 
-    /* Used for cancellation of request during TMFs */
+    /* Used for cancellation of request during TMFs. Atomic. */
     int remaining;
 
     SCSIRequest *sreq;
@@ -298,19 +298,23 @@ typedef struct {
     VirtIOSCSIReq  *tmf_req;
 } VirtIOSCSICancelNotifier;
 
+static void virtio_scsi_tmf_dec_remaining(VirtIOSCSIReq *tmf)
+{
+    if (qatomic_fetch_dec(&tmf->remaining) == 1) {
+        trace_virtio_scsi_tmf_resp(virtio_scsi_get_lun(tmf->req.tmf.lun),
+                                   tmf->req.tmf.tag, tmf->resp.tmf.response);
+
+        virtio_scsi_complete_req(tmf, &tmf->dev->ctrl_lock);
+    }
+}
+
 static void virtio_scsi_cancel_notify(Notifier *notifier, void *data)
 {
     VirtIOSCSICancelNotifier *n = container_of(notifier,
                                                VirtIOSCSICancelNotifier,
                                                notifier);
 
-    if (--n->tmf_req->remaining == 0) {
-        VirtIOSCSIReq *req = n->tmf_req;
-
-        trace_virtio_scsi_tmf_resp(virtio_scsi_get_lun(req->req.tmf.lun),
-                                   req->req.tmf.tag, req->resp.tmf.response);
-        virtio_scsi_complete_req(req, &req->dev->ctrl_lock);
-    }
+    virtio_scsi_tmf_dec_remaining(n->tmf_req);
     g_free(n);
 }
 
@@ -416,7 +420,7 @@ static void virtio_scsi_reset_tmf_bh(VirtIOSCSI *s)
     }
 }
 
-static void virtio_scsi_defer_tmf_to_bh(VirtIOSCSIReq *req)
+static void virtio_scsi_defer_tmf_to_main_loop(VirtIOSCSIReq *req)
 {
     VirtIOSCSI *s = req->dev;
 
@@ -430,6 +434,137 @@ static void virtio_scsi_defer_tmf_to_bh(VirtIOSCSIReq *req)
     }
 }
 
+static void virtio_scsi_tmf_cancel_req(VirtIOSCSIReq *tmf, SCSIRequest *r)
+{
+    VirtIOSCSICancelNotifier *notifier;
+
+    assert(r->ctx == qemu_get_current_aio_context());
+
+    /* Decremented in virtio_scsi_cancel_notify() */
+    qatomic_inc(&tmf->remaining);
+
+    notifier = g_new(VirtIOSCSICancelNotifier, 1);
+    notifier->notifier.notify = virtio_scsi_cancel_notify;
+    notifier->tmf_req = tmf;
+    scsi_req_cancel_async(r, &notifier->notifier);
+}
+
+/* Execute a TMF on the requests in the current AioContext */
+static void virtio_scsi_do_tmf_aio_context(void *opaque)
+{
+    AioContext *ctx = qemu_get_current_aio_context();
+    VirtIOSCSIReq *tmf = opaque;
+    VirtIOSCSI *s = tmf->dev;
+    SCSIDevice *d = virtio_scsi_device_get(s, tmf->req.tmf.lun);
+    SCSIRequest *r;
+    bool match_tag;
+
+    if (!d) {
+        tmf->resp.tmf.response = VIRTIO_SCSI_S_BAD_TARGET;
+        virtio_scsi_tmf_dec_remaining(tmf);
+        return;
+    }
+
+    /*
+     * This function could handle other subtypes that need to be processed in
+     * the request's AioContext in the future, but for now only request
+     * cancelation subtypes are performed here.
+     */
+    switch (tmf->req.tmf.subtype) {
+    case VIRTIO_SCSI_T_TMF_ABORT_TASK:
+        match_tag = true;
+        break;
+    case VIRTIO_SCSI_T_TMF_ABORT_TASK_SET:
+    case VIRTIO_SCSI_T_TMF_CLEAR_TASK_SET:
+        match_tag = false;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
+        QTAILQ_FOREACH(r, &d->requests, next) {
+            VirtIOSCSIReq *cmd_req = r->hba_private;
+            assert(cmd_req); /* request has hba_private while enqueued */
+
+            if (r->ctx != ctx) {
+                continue;
+            }
+            if (match_tag && cmd_req->req.cmd.tag != tmf->req.tmf.tag) {
+                continue;
+            }
+            virtio_scsi_tmf_cancel_req(tmf, r);
+        }
+    }
+
+    /* Incremented by virtio_scsi_do_tmf() */
+    virtio_scsi_tmf_dec_remaining(tmf);
+
+    object_unref(d);
+}
+
+static void dummy_bh(void *opaque)
+{
+    /* Do nothing */
+}
+
+/*
+ * Wait for pending virtio_scsi_defer_tmf_to_aio_context() BHs.
+ */
+static void virtio_scsi_flush_defer_tmf_to_aio_context(VirtIOSCSI *s)
+{
+    GLOBAL_STATE_CODE();
+
+    assert(!s->dataplane_started);
+
+    if (s->ctx) {
+        /* Our BH only runs after previously scheduled BHs */
+        aio_wait_bh_oneshot(s->ctx, dummy_bh, NULL);
+    }
+}
+
+/*
+ * Run the TMF in a specific AioContext, handling only requests in that
+ * AioContext. This is necessary because requests can run in different
+ * AioContext and it is only possible to cancel them from the AioContext where
+ * they are running.
+ */
+static void virtio_scsi_defer_tmf_to_aio_context(VirtIOSCSIReq *tmf,
+                                                 AioContext *ctx)
+{
+    /* Decremented in virtio_scsi_do_tmf_aio_context() */
+    qatomic_inc(&tmf->remaining);
+
+    /* See virtio_scsi_flush_defer_tmf_to_aio_context() cleanup during reset */
+    aio_bh_schedule_oneshot(ctx, virtio_scsi_do_tmf_aio_context, tmf);
+}
+
+/*
+ * Returns the AioContext for a given TMF's tag field or NULL. Note that the
+ * request identified by the tag may have completed by the time you can execute
+ * a BH in the AioContext, so don't assume the request still exists in your BH.
+ */
+static AioContext *find_aio_context_for_tmf_tag(SCSIDevice *d,
+                                                VirtIOSCSIReq *tmf)
+{
+    WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
+        SCSIRequest *r;
+        SCSIRequest *next;
+
+        QTAILQ_FOREACH_SAFE(r, &d->requests, next, next) {
+            VirtIOSCSIReq *cmd_req = r->hba_private;
+
+            /* hba_private is non-NULL while the request is enqueued */
+            assert(cmd_req);
+
+            if (cmd_req->req.cmd.tag == tmf->req.tmf.tag) {
+                return r->ctx;
+            }
+        }
+    }
+    return NULL;
+}
+
 /* Return 0 if the request is ready to be completed and return to guest;
  * -EINPROGRESS if the request is submitted and will be completed later, in the
  *  case of async cancellation. */
@@ -437,6 +572,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
 {
     SCSIDevice *d = virtio_scsi_device_get(s, req->req.tmf.lun);
     SCSIRequest *r, *next;
+    AioContext *ctx;
     int ret = 0;
 
     virtio_scsi_ctx_check(s, d);
@@ -454,7 +590,22 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
                               req->req.tmf.tag, req->req.tmf.subtype);
 
     switch (req->req.tmf.subtype) {
-    case VIRTIO_SCSI_T_TMF_ABORT_TASK:
+    case VIRTIO_SCSI_T_TMF_ABORT_TASK: {
+        if (!d) {
+            goto fail;
+        }
+        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
+            goto incorrect_lun;
+        }
+
+        ctx = find_aio_context_for_tmf_tag(d, req);
+        if (ctx) {
+            virtio_scsi_defer_tmf_to_aio_context(req, ctx);
+            ret = -EINPROGRESS;
+        }
+        break;
+    }
+
     case VIRTIO_SCSI_T_TMF_QUERY_TASK:
         if (!d) {
             goto fail;
@@ -462,44 +613,49 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
         if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
             goto incorrect_lun;
         }
-        QTAILQ_FOREACH_SAFE(r, &d->requests, next, next) {
-            VirtIOSCSIReq *cmd_req = r->hba_private;
-            if (cmd_req && cmd_req->req.cmd.tag == req->req.tmf.tag) {
-                break;
-            }
-        }
-        if (r) {
-            /*
-             * Assert that the request has not been completed yet, we
-             * check for it in the loop above.
-             */
-            assert(r->hba_private);
-            if (req->req.tmf.subtype == VIRTIO_SCSI_T_TMF_QUERY_TASK) {
-                /* "If the specified command is present in the task set, then
-                 * return a service response set to FUNCTION SUCCEEDED".
-                 */
-                req->resp.tmf.response = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-            } else {
-                VirtIOSCSICancelNotifier *notifier;
 
-                req->remaining = 1;
-                notifier = g_new(VirtIOSCSICancelNotifier, 1);
-                notifier->tmf_req = req;
-                notifier->notifier.notify = virtio_scsi_cancel_notify;
-                scsi_req_cancel_async(r, &notifier->notifier);
-                ret = -EINPROGRESS;
+        WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
+            QTAILQ_FOREACH(r, &d->requests, next) {
+                VirtIOSCSIReq *cmd_req = r->hba_private;
+                assert(cmd_req); /* request has hba_private while enqueued */
+
+                if (cmd_req->req.cmd.tag == req->req.tmf.tag) {
+                    /*
+                     * "If the specified command is present in the task set,
+                     * then return a service response set to FUNCTION
+                     * SUCCEEDED".
+                     */
+                    req->resp.tmf.response = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
+                }
             }
         }
         break;
 
     case VIRTIO_SCSI_T_TMF_LOGICAL_UNIT_RESET:
     case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
-        virtio_scsi_defer_tmf_to_bh(req);
+        virtio_scsi_defer_tmf_to_main_loop(req);
         ret = -EINPROGRESS;
         break;
 
     case VIRTIO_SCSI_T_TMF_ABORT_TASK_SET:
-    case VIRTIO_SCSI_T_TMF_CLEAR_TASK_SET:
+    case VIRTIO_SCSI_T_TMF_CLEAR_TASK_SET: {
+        if (!d) {
+            goto fail;
+        }
+        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
+            goto incorrect_lun;
+        }
+
+        qatomic_inc(&req->remaining);
+
+        ctx = s->ctx ?: qemu_get_aio_context();
+        virtio_scsi_defer_tmf_to_aio_context(req, ctx);
+
+        virtio_scsi_tmf_dec_remaining(req);
+        ret = -EINPROGRESS;
+        break;
+    }
+
     case VIRTIO_SCSI_T_TMF_QUERY_TASK_SET:
         if (!d) {
             goto fail;
@@ -508,34 +664,19 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
             goto incorrect_lun;
         }
 
-        /* Add 1 to "remaining" until virtio_scsi_do_tmf returns.
-         * This way, if the bus starts calling back to the notifiers
-         * even before we finish the loop, virtio_scsi_cancel_notify
-         * will not complete the TMF too early.
-         */
-        req->remaining = 1;
-        QTAILQ_FOREACH_SAFE(r, &d->requests, next, next) {
-            if (r->hba_private) {
-                if (req->req.tmf.subtype == VIRTIO_SCSI_T_TMF_QUERY_TASK_SET) {
-                    /* "If there is any command present in the task set, then
-                     * return a service response set to FUNCTION SUCCEEDED".
-                     */
-                    req->resp.tmf.response = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-                    break;
-                } else {
-                    VirtIOSCSICancelNotifier *notifier;
+        WITH_QEMU_LOCK_GUARD(&d->requests_lock) {
+            QTAILQ_FOREACH_SAFE(r, &d->requests, next, next) {
+                /* Request has hba_private while enqueued */
+                assert(r->hba_private);
 
-                    req->remaining++;
-                    notifier = g_new(VirtIOSCSICancelNotifier, 1);
-                    notifier->notifier.notify = virtio_scsi_cancel_notify;
-                    notifier->tmf_req = req;
-                    scsi_req_cancel_async(r, &notifier->notifier);
-                }
+                /*
+                 * "If there is any command present in the task set, then
+                 * return a service response set to FUNCTION SUCCEEDED".
+                 */
+                req->resp.tmf.response = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
+                break;
             }
         }
-        if (--req->remaining > 0) {
-            ret = -EINPROGRESS;
-        }
         break;
 
     case VIRTIO_SCSI_T_TMF_CLEAR_ACA:
@@ -941,6 +1082,7 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
     assert(!s->dataplane_started);
 
     virtio_scsi_reset_tmf_bh(s);
+    virtio_scsi_flush_defer_tmf_to_aio_context(s);
 
     qatomic_inc(&s->resetting);
     bus_cold_reset(BUS(&s->bus));
-- 
2.48.1


