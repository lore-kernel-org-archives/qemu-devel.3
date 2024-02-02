Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B73C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvX1-0003yi-69; Fri, 02 Feb 2024 10:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvWz-0003yK-0f
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvWw-0000F1-0S
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706887957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J/XT2q0+tN1KTieI5xFfr6GKiPUigJi8ApxjJJNq4E=;
 b=P9tNhMjCXYkJdQkadrdS81PYvK7oEa6ojTDNDY54RQ8WJtizdGtWkmx2PXNzAMc/7cX6LB
 Z6satAXngtHbGgmazV8luGKoIsadusiobRmSv/BUdQCu9eUPTIK1LEr4A+d0/IpadrzQjA
 I7QaM1QnNDJjVi9Q9BkXgJcnfUyaClE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-lG8C56gdN4m2ObcyZQgOaQ-1; Fri,
 02 Feb 2024 10:32:31 -0500
X-MC-Unique: lG8C56gdN4m2ObcyZQgOaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B45B4383D747;
 Fri,  2 Feb 2024 15:32:30 +0000 (UTC)
Received: from localhost (unknown [10.39.194.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EFE62166B33;
 Fri,  2 Feb 2024 15:32:30 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 2/3] virtio: Re-enable notifications after drain
Date: Fri,  2 Feb 2024 16:31:57 +0100
Message-ID: <20240202153158.788922-3-hreitz@redhat.com>
In-Reply-To: <20240202153158.788922-1-hreitz@redhat.com>
References: <20240202153158.788922-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

During drain, we do not care about virtqueue notifications, which is why
we remove the handlers on it.  When removing those handlers, whether vq
notifications are enabled or not depends on whether we were in polling
mode or not; if not, they are enabled (by default); if so, they have
been disabled by the io_poll_start callback.

Because we do not care about those notifications after removing the
handlers, this is fine.  However, we have to explicitly ensure they are
enabled when re-attaching the handlers, so we will resume receiving
notifications.  We do this in virtio_queue_aio_attach_host_notifier*().
If such a function is called while we are in a polling section,
attaching the notifiers will then invoke the io_poll_start callback,
re-disabling notifications.

Because we will always miss virtqueue updates in the drained section, we
also need to poll the virtqueue once after attaching the notifiers.

Buglink: https://issues.redhat.com/browse/RHEL-3934
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/aio.h |  7 ++++++-
 hw/virtio/virtio.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 5d0a114988..8378553eb9 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -480,9 +480,14 @@ void aio_set_event_notifier(AioContext *ctx,
                             AioPollFn *io_poll,
                             EventNotifierHandler *io_poll_ready);
 
-/* Set polling begin/end callbacks for an event notifier that has already been
+/*
+ * Set polling begin/end callbacks for an event notifier that has already been
  * registered with aio_set_event_notifier.  Do nothing if the event notifier is
  * not registered.
+ *
+ * Note that if the io_poll_end() callback (or the entire notifier) is removed
+ * during polling, it will not be called, so an io_poll_begin() is not
+ * necessarily always followed by an io_poll_end().
  */
 void aio_set_event_notifier_poll(AioContext *ctx,
                                  EventNotifier *notifier,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7549094154..d229755eae 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3556,6 +3556,17 @@ static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
 
 void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
 {
+    /*
+     * virtio_queue_aio_detach_host_notifier() can leave notifications disabled.
+     * Re-enable them.  (And if detach has not been used before, notifications
+     * being enabled is still the default state while a notifier is attached;
+     * see virtio_queue_host_notifier_aio_poll_end(), which will always leave
+     * notifications enabled once the polling section is left.)
+     */
+    if (!virtio_queue_get_notification(vq)) {
+        virtio_queue_set_notification(vq, 1);
+    }
+
     aio_set_event_notifier(ctx, &vq->host_notifier,
                            virtio_queue_host_notifier_read,
                            virtio_queue_host_notifier_aio_poll,
@@ -3563,6 +3574,13 @@ void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
     aio_set_event_notifier_poll(ctx, &vq->host_notifier,
                                 virtio_queue_host_notifier_aio_poll_begin,
                                 virtio_queue_host_notifier_aio_poll_end);
+
+    /*
+     * We will have ignored notifications about new requests from the guest
+     * while no notifiers were attached, so "kick" the virt queue to process
+     * those requests now.
+     */
+    event_notifier_set(&vq->host_notifier);
 }
 
 /*
@@ -3573,14 +3591,38 @@ void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx)
  */
 void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioContext *ctx)
 {
+    /* See virtio_queue_aio_attach_host_notifier() */
+    if (!virtio_queue_get_notification(vq)) {
+        virtio_queue_set_notification(vq, 1);
+    }
+
     aio_set_event_notifier(ctx, &vq->host_notifier,
                            virtio_queue_host_notifier_read,
                            NULL, NULL);
+
+    /*
+     * See virtio_queue_aio_attach_host_notifier().
+     * Note that this may be unnecessary for the type of virtqueues this
+     * function is used for.  Still, it will not hurt to have a quick look into
+     * whether we can/should process any of the virtqueue elements.
+     */
+    event_notifier_set(&vq->host_notifier);
 }
 
 void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx)
 {
     aio_set_event_notifier(ctx, &vq->host_notifier, NULL, NULL, NULL);
+
+    /*
+     * aio_set_event_notifier_poll() does not guarantee whether io_poll_end()
+     * will run after io_poll_begin(), so by removing the notifier, we do not
+     * know whether virtio_queue_host_notifier_aio_poll_end() has run after a
+     * previous virtio_queue_host_notifier_aio_poll_begin(), i.e. whether
+     * notifications are enabled or disabled.  It does not really matter anyway;
+     * we just removed the notifier, so we do not care about notifications until
+     * we potentially re-attach it.  The attach_host_notifier functions will
+     * ensure that notifications are enabled again when they are needed.
+     */
 }
 
 void virtio_queue_host_notifier_read(EventNotifier *n)
-- 
2.43.0


