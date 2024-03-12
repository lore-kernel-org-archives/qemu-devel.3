Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4E7C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3ne-0003ur-Uh; Tue, 12 Mar 2024 11:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk3na-0003u0-8u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk3nY-0005il-LK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710256331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rHsWgkK5Lt6DYRaJ2K/heKcWkjZjaerSlBAVnmFwty0=;
 b=hHu3WEzbK0MCW9KE5XkulJSKJ0AzB3h0bhVqvUTAHb2/3fkEqhCpwF/FeIGHHGlH2lP4WZ
 7Mx8t9kaEWwC9F9F3MSPuMN7UpqFB6N0abqCdpCRGRkpzqqYvluqJ+xhdEgll7I2UyPUx7
 MD2Qy+B/iKCpYMzM5bTbs9qnc9E6sCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-seUo3u2KNe-pJXAop3ad-Q-1; Tue,
 12 Mar 2024 11:12:08 -0400
X-MC-Unique: seUo3u2KNe-pJXAop3ad-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 065AB386A0C2;
 Tue, 12 Mar 2024 15:12:08 +0000 (UTC)
Received: from localhost (unknown [10.39.194.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70D191121337;
 Tue, 12 Mar 2024 15:12:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sanjay Rao <srao@redhat.com>,
 Boaz Ben Shabat <bbenshab@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: [PATCH v2] virtio-blk: iothread-vq-mapping coroutine pool sizing
Date: Tue, 12 Mar 2024 11:12:04 -0400
Message-ID: <20240312151204.412624-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is possible to hit the sysctl vm.max_map_count limit when the
coroutine pool size becomes large. Each coroutine requires two mappings
(one for the stack and one for the guard page). QEMU can crash with
"failed to set up stack guard page" or "failed to allocate memory for
stack" when this happens.

Coroutine pool sizing is simple when there is only thread: sum up all
I/O requests across all virtqueues.

When the iothread-vq-mapping option is used we should calculate tighter
bounds because thread may serve a subset of the device's virtqueues:
take the maximum number of the number of I/O requests across all
virtqueues. A thread does not need coroutine pool space for I/O requests
that are handled by other threads.

This is not a solution to hitting vm.max_map_count, but it helps. A
guest with 64 vCPUs (hence 64 virtqueues) across 4 IOThreads with one
iothread-vq-mapping virtio-blk device and a root disk without goes from
pool_max_size 16,448 to 10,304.

Reported-by: Sanjay Rao <srao@redhat.com>
Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
Reported-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
- State the the tighter bounds reflect the fact that threads may only
  process a subset of the total I/O requests from a device [Kevin]
- Add Reported-by: Joe Mario, he has been investigating this issue.

 include/hw/virtio/virtio-blk.h |  2 ++
 hw/block/virtio-blk.c          | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 5c14110c4b..ac29700ad4 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -74,6 +74,8 @@ struct VirtIOBlock {
     uint64_t host_features;
     size_t config_size;
     BlockRAMRegistrar blk_ram_registrar;
+
+    unsigned coroutine_pool_size;
 };
 
 typedef struct VirtIOBlockReq {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 738cb2ac36..0a14b2b175 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1957,6 +1957,35 @@ static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
     s->ioeventfd_stopping = false;
 }
 
+/* Increase the coroutine pool size to include our I/O requests */
+static void virtio_blk_inc_coroutine_pool_size(VirtIOBlock *s)
+{
+    VirtIOBlkConf *conf = &s->conf;
+    unsigned max_requests = 0;
+
+    /* Tracks the total number of requests for AioContext */
+    g_autoptr(GHashTable) counters = g_hash_table_new(NULL, NULL);
+
+    /* Call this function after setting up vq_aio_context[] */
+    assert(s->vq_aio_context);
+
+    for (unsigned i = 0; i < conf->num_queues; i++) {
+        AioContext *ctx = s->vq_aio_context[i];
+        unsigned n = GPOINTER_TO_UINT(g_hash_table_lookup(counters, ctx));
+
+        n += conf->queue_size / 2; /* this is a heuristic */
+
+        g_hash_table_insert(counters, ctx, GUINT_TO_POINTER(n));
+
+        if (n > max_requests) {
+            max_requests = n;
+        }
+    }
+
+    qemu_coroutine_inc_pool_size(max_requests);
+    s->coroutine_pool_size = max_requests; /* stash it for ->unrealize() */
+}
+
 static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -2048,7 +2077,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < conf->num_queues; i++) {
         virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
-    qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2);
 
     /* Don't start ioeventfd if transport does not support notifiers. */
     if (!virtio_device_ioeventfd_enabled(vdev)) {
@@ -2065,6 +2093,8 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    virtio_blk_inc_coroutine_pool_size(s);
+
     /*
      * This must be after virtio_init() so virtio_blk_dma_restart_cb() gets
      * called after ->start_ioeventfd() has already set blk's AioContext.
@@ -2096,7 +2126,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
     for (i = 0; i < conf->num_queues; i++) {
         virtio_del_queue(vdev, i);
     }
-    qemu_coroutine_dec_pool_size(conf->num_queues * conf->queue_size / 2);
+    qemu_coroutine_dec_pool_size(s->coroutine_pool_size);
     qemu_mutex_destroy(&s->rq_lock);
     blk_ram_registrar_destroy(&s->blk_ram_registrar);
     qemu_del_vm_change_state_handler(s->change);
-- 
2.44.0


