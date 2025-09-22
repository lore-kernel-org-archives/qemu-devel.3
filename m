Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3625CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0obp-0005n6-2j; Mon, 22 Sep 2025 18:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obj-0005hj-KS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obg-0001sr-VK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758578520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4f/lDoSl2tEdm0Pamz1TmV3fUjMmmFhYe5iOa04hOPg=;
 b=RGb+M0+f3y3O25QkQuJujJQlVyS3imNckoymD/u9ETb5x36U3ra29SQjynlDvsVuNYEHPO
 cIhzvdbIRDgE0MAvrrouUfzE3IdRl/tXDtJmQRBv//c6i1wimOULG3b35G2+c225aA2oT7
 szYZeei2cHiVUtvF/J47KZK/cN6Razc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-uu8aiVpGOwWuYfGSkUtXkw-1; Mon,
 22 Sep 2025 18:01:58 -0400
X-MC-Unique: uu8aiVpGOwWuYfGSkUtXkw-1
X-Mimecast-MFC-AGG-ID: uu8aiVpGOwWuYfGSkUtXkw_1758578517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C63A19560B4; Mon, 22 Sep 2025 22:01:57 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3994A19560BB; Mon, 22 Sep 2025 22:01:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/5] virtio: unify virtio_notify_irqfd() and virtio_notify()
Date: Mon, 22 Sep 2025 18:01:46 -0400
Message-ID: <20250922220149.498967-3-stefanha@redhat.com>
In-Reply-To: <20250922220149.498967-1-stefanha@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The difference between these two functions:
- virtio_notify() uses the interrupt code path (MSI or classic IRQs)
- virtio_notify_irqfd() uses guest notifiers (irqfds)

virtio_notify() can only be called with the BQL held because the
interrupt code path requires the BQL. Device models use
virtio_notify_irqfd() from IOThreads since the BQL is not held.

The two functions can be unified by pushing down the if
(qemu_in_iothread()) check from virtio-blk and virtio-scsi into core
virtio code. This is in preparation for the next commit that will add
irqfd support to virtio_notify_config() and where it's unattractive to
introduce another irqfd-only API for device model callers.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h |  1 -
 hw/block/virtio-blk.c      |  6 +-----
 hw/scsi/virtio-scsi.c      |  6 +-----
 hw/virtio/virtio.c         | 28 +++++++++++++---------------
 hw/virtio/trace-events     |  1 -
 5 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..8435f5e8fc 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -290,7 +290,6 @@ int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                               unsigned int *out_bytes, unsigned max_in_bytes,
                               unsigned max_out_bytes);
 
-void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 int virtio_save(VirtIODevice *vdev, QEMUFile *f);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9bab2716c1..64efce4846 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -62,11 +62,7 @@ void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->inhdr_undo);
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
-    if (qemu_in_iothread()) {
-        virtio_notify_irqfd(vdev, req->vq);
-    } else {
-        virtio_notify(vdev, req->vq);
-    }
+    virtio_notify(vdev, req->vq);
 }
 
 static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 34ae14f7bf..d817fc42b4 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -116,11 +116,7 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req, QemuMutex *vq_lock)
     }
 
     virtqueue_push(vq, &req->elem, req->qsgl.size + req->resp_iov.size);
-    if (s->dataplane_started && !s->dataplane_fenced) {
-        virtio_notify_irqfd(vdev, vq);
-    } else {
-        virtio_notify(vdev, vq);
-    }
+    virtio_notify(vdev, vq);
 
     if (vq_lock) {
         qemu_mutex_unlock(vq_lock);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..13830debfd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
+#include "system/iothread.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -2654,16 +2655,8 @@ static void virtio_notify_irqfd_deferred_fn(void *opaque)
     event_notifier_set(notifier);
 }
 
-void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_irq(VirtQueue *vq)
 {
-    WITH_RCU_READ_LOCK_GUARD() {
-        if (!virtio_should_notify(vdev, vq)) {
-            return;
-        }
-    }
-
-    trace_virtio_notify_irqfd(vdev, vq);
-
     /*
      * virtio spec 1.0 says ISR bit 0 should be ignored with MSI, but
      * windows drivers included in virtio-win 1.8.0 (circa 2015) are
@@ -2680,13 +2673,18 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
      * to an atomic operation.
      */
     virtio_set_isr(vq->vdev, 0x1);
-    defer_call(virtio_notify_irqfd_deferred_fn, &vq->guest_notifier);
-}
 
-static void virtio_irq(VirtQueue *vq)
-{
-    virtio_set_isr(vq->vdev, 0x1);
-    virtio_notify_vector(vq->vdev, vq->vector);
+    /*
+     * The interrupt code path requires the Big QEMU Lock (BQL), so use the
+     * notifier instead when in an IOThread. This assumes that device models
+     * have already called ->set_guest_notifiers() sometime before calling this
+     * function.
+     */
+    if (qemu_in_iothread()) {
+        defer_call(virtio_notify_irqfd_deferred_fn, &vq->guest_notifier);
+    } else {
+        virtio_notify_vector(vq->vdev, vq->vector);
+    }
 }
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 76f0d458b2..658cc365e7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -75,7 +75,6 @@ virtqueue_flush(void *vq, unsigned int count) "vq %p count %u"
 virtqueue_pop(void *vq, void *elem, unsigned int in_num, unsigned int out_num) "vq %p elem %p in_num %u out_num %u"
 virtio_queue_notify(void *vdev, int n, void *vq) "vdev %p n %d vq %p"
 virtio_notify_irqfd_deferred_fn(void *vdev, void *vq) "vdev %p vq %p"
-virtio_notify_irqfd(void *vdev, void *vq) "vdev %p vq %p"
 virtio_notify(void *vdev, void *vq) "vdev %p vq %p"
 virtio_set_status(void *vdev, uint8_t val) "vdev %p val %u"
 
-- 
2.51.0


