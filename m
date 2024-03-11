Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049EDC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjm2b-00036P-51; Mon, 11 Mar 2024 16:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rjm2Y-000367-Gh
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rjm2W-0002n2-SM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710188068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CxbUj45j6OBbK84DYQr+Vlwswmv1YhAcnb7SBLzJrGU=;
 b=aj5tVklXxN6Ck4t0eb2Nyav7N4Lpl7t/t7RmDVd7PHEH3GQVS6CDAx/+j1m7lcbseqGWU3
 Ilrhhm7UX7HdibKH/ywCuhds/kzt7ANKN+Kc02YSHrMEHHUI1KbO1EKJvVEAHjDC51zM+z
 Q7B/n4uDpu88V+RTIfMm/chSS2BrAI8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-etlbvJVHPOKcHyErc2oEFw-1; Mon,
 11 Mar 2024 16:14:26 -0400
X-MC-Unique: etlbvJVHPOKcHyErc2oEFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA76383CD63;
 Mon, 11 Mar 2024 20:14:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4326B10E49;
 Mon, 11 Mar 2024 20:14:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Sanjay Rao <srao@redhat.com>,
 Boaz Ben Shabat <bbenshab@redhat.com>
Subject: [PATCH] virtio-blk: iothread-vq-mapping coroutine pool sizing
Date: Mon, 11 Mar 2024 16:14:23 -0400
Message-ID: <20240311201423.387622-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Coroutine pool sizing is simple when there is only one AioContext: sum
up all I/O requests across all virtqueues.

When the iothread-vq-mapping option is used we should calculate tighter
bounds: take the maximum number of the number of I/O requests across all
virtqueues. This number is lower than simply summing all virtqueues when
only a subset of the virtqueues is handled by each AioContext.

This is not a solution to hitting vm.max_map_count, but it helps. A
guest with 64 vCPUs (hence 64 virtqueues) across 4 IOThreads with one
iothread-vq-mapping virtio-blk device and a root disk without goes from
pool_max_size 16,448 to 10,304.

Reported-by: Sanjay Rao <srao@redhat.com>
Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
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


