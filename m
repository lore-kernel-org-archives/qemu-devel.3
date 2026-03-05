Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E933F3D330
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBkQ-0006As-O7; Thu, 05 Mar 2026 11:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkG-0006AY-41
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBk9-0000mF-LN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOd8J2I5KMMxkHVOYgfkIXRl2cZ0hslmMulWEOLM6Hs=;
 b=bRIVQ9VT7BpCF8Mlkkf36Gyol0nvIAjwuC1MyYXqHiQzRR6NsN7NzsvWM8nXElgYli2zBz
 SBVLINDbgWjYEJIbyKSbQXEpBHIeGsXrPyHqz0GEy+avLlrYJ3pygsj/Pr56vwYsiCW2g8
 7BG3VaXruRzR5NZMLDaZHcaaMLI4x3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-SbIkhCTaOCijS-_ocvTJlA-1; Thu,
 05 Mar 2026 11:40:03 -0500
X-MC-Unique: SbIkhCTaOCijS-_ocvTJlA-1
X-Mimecast-MFC-AGG-ID: SbIkhCTaOCijS-_ocvTJlA_1772728802
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D49D418005BD; Thu,  5 Mar 2026 16:40:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D7751958DC5; Thu,  5 Mar 2026 16:39:58 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 5/8] tests: vhost-vdpa: add descriptor chain tests
Date: Thu,  5 Mar 2026 17:39:35 +0100
Message-ID: <20260305163938.3200787-6-eperezma@redhat.com>
In-Reply-To: <20260305163938.3200787-1-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extend TX tests to support multi-descriptor chains:
- Add chain_len parameter to control chain length
- Use GAsyncQueue to validate expected vs actual chain lengths
- Test single descriptors, 2-descriptor chains, and out-of-order chains

Chain descriptors all point to the same guest memory buffer to
simplify allocation tracking while still testing chain traversal logic.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 53 ++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 8dde7d95b167..433e5d71ca7a 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -47,6 +47,9 @@ typedef struct VdpaThread {
     GMainLoop *loop;
     GMainContext *context;
 
+    /* Expected elements queue to compare properties */
+    GAsyncQueue *elem_queue;
+
     /* Guest memory that must be free at the end of the test */
     uint64_t qemu_mem_to_free;
 } VdpaThread;
@@ -60,6 +63,7 @@ static void *vhost_vdpa_thread_function(void *data)
 
 static void vhost_vdpa_thread_init(VdpaThread *t)
 {
+    t->elem_queue = g_async_queue_new();
     t->context = g_main_context_new();
     t->loop = g_main_loop_new(t->context, FALSE);
     t->thread = g_thread_new("vdpa-thread", vhost_vdpa_thread_function, t->loop);
@@ -76,6 +80,7 @@ static void vhost_vdpa_thread_cleanup(VdpaThread *t)
 
     g_main_loop_unref(t->loop);
     g_main_context_unref(t->context);
+    g_async_queue_unref(t->elem_queue);
 }
 
 static void vhost_vdpa_thread_add_source_fd(VdpaThread *t, int fd,
@@ -109,29 +114,48 @@ static void vhost_vdpa_add_rx_pkts(QGuestAllocator *alloc, QVirtioNet *net,
  * @alloc: the guest allocator to allocate memory for the descriptors
  * @net: the virtio net device
  * @t: the vdpa thread to push the expected chain length if kick is true
+ * @chain_len: the number of descriptors in the chain to add
  *
  * Returns the kick_id you can use to kick the device in a later call to this
  * function.
  */
 static uint32_t vhost_vdpa_add_tx_pkt_descs(QGuestAllocator *alloc,
-                                            QVirtioNet *net, VdpaThread *t)
+                                            QVirtioNet *net, VdpaThread *t,
+                                            uint32_t chain_len)
 {
     QTestState *qts = global_qtest;
-    uint32_t req_addr;
+    uint32_t req_addr, kick_id = UINT32_MAX;
 
+    assert(chain_len > 0);
     /* TODO: Actually free this. RFC, is actually needed? */
     req_addr = guest_alloc(alloc, 64);
     g_assert_cmpint(req_addr, >, 0);
 
-    return qvirtqueue_add(qts, net->queues[1], req_addr, 64, /* write */ false,
-                          /* next */ false);
+    /*
+    * We set up the descriptors in a way that each of them points to the same
+    * buffer. This simplifies guest's memory management while still exercising
+    * chain traversal in SVQ.
+    */
+    for (uint32_t i = 0; i < chain_len; i++) {
+        uint32_t head;
+        bool next = i != chain_len - 1;
+
+        head = qvirtqueue_add(qts, net->queues[1], req_addr, 64,
+                              /* write */ false, next);
+        if (i == 0) {
+            kick_id = head;
+        }
+    }
+
+    return kick_id;
 }
 
 static void vhost_vdpa_kick_tx_desc(VdpaThread *t, QVirtioNet *net,
-                                    uint32_t kick_id)
+                                    uint32_t kick_id, uint32_t chain_len)
 {
     QTestState *qts = global_qtest;
 
+    g_async_queue_push(t->elem_queue, (void *)(intptr_t)chain_len);
     qvirtqueue_kick(qts, net->vdev, net->queues[1], kick_id);
 }
 
@@ -244,9 +268,12 @@ static gboolean vhost_vdpa_rxtx_handle_tx(int fd, GIOCondition condition,
                                           void *data)
 {
     VduseVirtq *vq = data;
+    VduseDev *dev = vduse_queue_get_dev(vq);
+    TestServer *s = vduse_dev_get_priv(dev);
 
     eventfd_read(fd, (eventfd_t[]){0});
     do {
+        intptr_t expected_elems;
         g_autofree VduseVirtqElement *elem = NULL;
 
         elem = vduse_queue_pop(vq, sizeof(*elem));
@@ -254,7 +281,10 @@ static gboolean vhost_vdpa_rxtx_handle_tx(int fd, GIOCondition condition,
             break;
         }
 
+        expected_elems = (intptr_t)g_async_queue_try_pop(s->vdpa_thread.elem_queue);
+        g_assert_cmpint(expected_elems, >, 0);
         g_test_message("Got element with %d buffers", elem->out_num);
+        g_assert_cmpint(elem->out_num, ==, expected_elems);
         g_assert_cmpint(elem->in_num, ==, 0);
 
         vduse_queue_push(vq, elem, 0);
@@ -546,9 +576,18 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
     /* Add some rx packets so SVQ must clean them at the end of QEMU run */
     vhost_vdpa_add_rx_pkts(alloc, net, &server->vdpa_thread);
 
-    free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread);
-    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head);
+    /* Simple packet */
+    free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
+                                            1);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 1);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
+
+    /* Simple chain */
+    free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
+                                            2);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 2);
     vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
+
 }
 
 static void register_vhost_vdpa_test(void)
-- 
2.53.0


