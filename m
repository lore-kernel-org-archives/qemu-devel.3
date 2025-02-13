Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8680DC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidYa-0000yy-Nz; Thu, 13 Feb 2025 13:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWj-0008Ca-D4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWd-0006Ui-1b
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739469681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysjZtiv0kFv1HpIj+DJDioAPcKuoXNzhJc9DSCZURe8=;
 b=NlGMV9itFBOoXIQKB0rHgfBBvIOl9smivxoQDFGgam+Fn4T/aMSfNr8A6s2zUsI79wQXYR
 PIgBavn8vp8u5lhMQjRATETy/hrpHJy/QNeGesWoG54eTiMmpZurshBQALBpfZkcjFIinp
 aQDTCoqRiKNzW3rzUHPKjdadXECkLtU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-bmUuIEs3MpO5nfsI3yl3SA-1; Thu,
 13 Feb 2025 13:01:20 -0500
X-MC-Unique: bmUuIEs3MpO5nfsI3yl3SA-1
X-Mimecast-MFC-AGG-ID: bmUuIEs3MpO5nfsI3yl3SA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B0401800875; Thu, 13 Feb 2025 18:01:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 617471955DCE; Thu, 13 Feb 2025 18:01:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 12/12] virtio-scsi: handle ctrl virtqueue in main loop
Date: Thu, 13 Feb 2025 13:00:43 -0500
Message-ID: <20250213180043.713434-13-stefanha@redhat.com>
In-Reply-To: <20250213180043.713434-1-stefanha@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

Previously the ctrl virtqueue was handled in the AioContext where SCSI
requests are processed. When IOThread Virtqueue Mapping was added things
become more complicated because SCSI requests could run in other
AioContexts.

Simplify by handling the ctrl virtqueue in the main loop where reset
operations can be performed. Note that BHs are still used canceling SCSI
requests in their AioContexts but at least the mean loop activity
doesn't need BHs anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |   8 --
 hw/scsi/virtio-scsi-dataplane.c |   6 ++
 hw/scsi/virtio-scsi.c           | 144 ++++++--------------------------
 3 files changed, 33 insertions(+), 125 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 086201efa2..31e852ed6c 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -90,14 +90,6 @@ struct VirtIOSCSI {
 
     QemuMutex ctrl_lock; /* protects ctrl_vq */
 
-    /*
-     * TMFs deferred to main loop BH. These fields are protected by
-     * tmf_bh_lock.
-     */
-    QemuMutex tmf_bh_lock;
-    QEMUBH *tmf_bh;
-    QTAILQ_HEAD(, VirtIOSCSIReq) tmf_bh_list;
-
     /* Fields for dataplane below */
     AioContext **vq_aio_context; /* per-virtqueue AioContext pointer */
 
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 6bb368c8a5..2d37fa6712 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -73,6 +73,12 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             s->vq_aio_context[i] = ctx;
         }
     }
+
+    /*
+     * Always handle the ctrl virtqueue in the main loop thread where device
+     * resets can be performed.
+     */
+    s->vq_aio_context[0] = qemu_get_aio_context();
 }
 
 /* Context: BQL held */
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index dabf8ace23..1d97f8c5f4 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -319,115 +319,6 @@ static void virtio_scsi_cancel_notify(Notifier *notifier, void *data)
     g_free(n);
 }
 
-static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
-{
-    VirtIOSCSI *s = req->dev;
-    SCSIDevice *d = virtio_scsi_device_get(s, req->req.tmf.lun);
-    BusChild *kid;
-    int target;
-
-    switch (req->req.tmf.subtype) {
-    case VIRTIO_SCSI_T_TMF_LOGICAL_UNIT_RESET:
-        if (!d) {
-            req->resp.tmf.response = VIRTIO_SCSI_S_BAD_TARGET;
-            goto out;
-        }
-        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
-            req->resp.tmf.response = VIRTIO_SCSI_S_INCORRECT_LUN;
-            goto out;
-        }
-        qatomic_inc(&s->resetting);
-        device_cold_reset(&d->qdev);
-        qatomic_dec(&s->resetting);
-        break;
-
-    case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
-        target = req->req.tmf.lun[1];
-        qatomic_inc(&s->resetting);
-
-        rcu_read_lock();
-        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
-            SCSIDevice *d1 = SCSI_DEVICE(kid->child);
-            if (d1->channel == 0 && d1->id == target) {
-                device_cold_reset(&d1->qdev);
-            }
-        }
-        rcu_read_unlock();
-
-        qatomic_dec(&s->resetting);
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-out:
-    object_unref(OBJECT(d));
-    virtio_scsi_complete_req(req, &s->ctrl_lock);
-}
-
-/* Some TMFs must be processed from the main loop thread */
-static void virtio_scsi_do_tmf_bh(void *opaque)
-{
-    VirtIOSCSI *s = opaque;
-    QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
-    VirtIOSCSIReq *req;
-    VirtIOSCSIReq *tmp;
-
-    GLOBAL_STATE_CODE();
-
-    WITH_QEMU_LOCK_GUARD(&s->tmf_bh_lock) {
-        QTAILQ_FOREACH_SAFE(req, &s->tmf_bh_list, next, tmp) {
-            QTAILQ_REMOVE(&s->tmf_bh_list, req, next);
-            QTAILQ_INSERT_TAIL(&reqs, req, next);
-        }
-
-        qemu_bh_delete(s->tmf_bh);
-        s->tmf_bh = NULL;
-    }
-
-    QTAILQ_FOREACH_SAFE(req, &reqs, next, tmp) {
-        QTAILQ_REMOVE(&reqs, req, next);
-        virtio_scsi_do_one_tmf_bh(req);
-    }
-}
-
-static void virtio_scsi_reset_tmf_bh(VirtIOSCSI *s)
-{
-    VirtIOSCSIReq *req;
-    VirtIOSCSIReq *tmp;
-
-    GLOBAL_STATE_CODE();
-
-    /* Called after ioeventfd has been stopped, so tmf_bh_lock is not needed */
-    if (s->tmf_bh) {
-        qemu_bh_delete(s->tmf_bh);
-        s->tmf_bh = NULL;
-    }
-
-    QTAILQ_FOREACH_SAFE(req, &s->tmf_bh_list, next, tmp) {
-        QTAILQ_REMOVE(&s->tmf_bh_list, req, next);
-
-        /* SAM-6 6.3.2 Hard reset */
-        req->resp.tmf.response = VIRTIO_SCSI_S_TARGET_FAILURE;
-        virtio_scsi_complete_req(req, &req->dev->ctrl_lock);
-    }
-}
-
-static void virtio_scsi_defer_tmf_to_main_loop(VirtIOSCSIReq *req)
-{
-    VirtIOSCSI *s = req->dev;
-
-    WITH_QEMU_LOCK_GUARD(&s->tmf_bh_lock) {
-        QTAILQ_INSERT_TAIL(&s->tmf_bh_list, req, next);
-
-        if (!s->tmf_bh) {
-            s->tmf_bh = qemu_bh_new(virtio_scsi_do_tmf_bh, s);
-            qemu_bh_schedule(s->tmf_bh);
-        }
-    }
-}
-
 static void virtio_scsi_tmf_cancel_req(VirtIOSCSIReq *tmf, SCSIRequest *r)
 {
     VirtIOSCSICancelNotifier *notifier;
@@ -627,11 +518,35 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
         break;
 
     case VIRTIO_SCSI_T_TMF_LOGICAL_UNIT_RESET:
-    case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
-        virtio_scsi_defer_tmf_to_main_loop(req);
-        ret = -EINPROGRESS;
+        if (!d) {
+            goto fail;
+        }
+        if (d->lun != virtio_scsi_get_lun(req->req.tmf.lun)) {
+            goto incorrect_lun;
+        }
+        qatomic_inc(&s->resetting);
+        device_cold_reset(&d->qdev);
+        qatomic_dec(&s->resetting);
         break;
 
+    case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET: {
+        BusChild *kid;
+        int target = req->req.tmf.lun[1];
+        qatomic_inc(&s->resetting);
+
+        rcu_read_lock();
+        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
+            SCSIDevice *d1 = SCSI_DEVICE(kid->child);
+            if (d1->channel == 0 && d1->id == target) {
+                device_cold_reset(&d1->qdev);
+            }
+        }
+        rcu_read_unlock();
+
+        qatomic_dec(&s->resetting);
+        break;
+    }
+
     case VIRTIO_SCSI_T_TMF_ABORT_TASK_SET:
     case VIRTIO_SCSI_T_TMF_CLEAR_TASK_SET: {
         g_autoptr(GHashTable) aio_contexts = g_hash_table_new(NULL, NULL);
@@ -1087,7 +1002,6 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
 
     assert(!s->dataplane_started);
 
-    virtio_scsi_reset_tmf_bh(s);
     virtio_scsi_flush_defer_tmf_to_aio_context(s);
 
     qatomic_inc(&s->resetting);
@@ -1402,10 +1316,8 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
     Error *err = NULL;
 
-    QTAILQ_INIT(&s->tmf_bh_list);
     qemu_mutex_init(&s->ctrl_lock);
     qemu_mutex_init(&s->event_lock);
-    qemu_mutex_init(&s->tmf_bh_lock);
 
     virtio_scsi_common_realize(dev,
                                virtio_scsi_handle_ctrl,
@@ -1445,11 +1357,9 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
 {
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
 
-    virtio_scsi_reset_tmf_bh(s);
     virtio_scsi_dataplane_cleanup(s);
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
     virtio_scsi_common_unrealize(dev);
-    qemu_mutex_destroy(&s->tmf_bh_lock);
     qemu_mutex_destroy(&s->event_lock);
     qemu_mutex_destroy(&s->ctrl_lock);
 }
-- 
2.48.1


