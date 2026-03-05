Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73383F3D333
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBks-0006Pk-37; Thu, 05 Mar 2026 11:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkU-0006BT-WD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkL-0000nl-Ew
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R59MarovWlomdxjs+pZRDxzIg0jc11eLmA5EOn5Ublw=;
 b=IzBc5IoWXQeM6DYYtAKLxvfOigJUrKRZ8iygGSd5IVB5oGjLz5EzZbaa28m9DivL+xuwde
 foszlBNT1tt7ghFHg6GxDiuu/th5nZSQdXCrxAT1J8e/f6tV2EC+aXJW5xqj+NVbu8zNzq
 PtSmKS3gQLluxi8742ZRvzkIG6AuYAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-9NETlDK9MpWS2KZ7Ncu7kg-1; Thu,
 05 Mar 2026 11:40:14 -0500
X-MC-Unique: 9NETlDK9MpWS2KZ7Ncu7kg-1
X-Mimecast-MFC-AGG-ID: 9NETlDK9MpWS2KZ7Ncu7kg_1772728813
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18C8D180061D; Thu,  5 Mar 2026 16:40:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AACBD1958DC5; Thu,  5 Mar 2026 16:40:09 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 8/8] tests: vhost-vdpa: add VIRTIO_F_IN_ORDER feature tests
Date: Thu,  5 Mar 2026 17:39:38 +0100
Message-ID: <20260305163938.3200787-9-eperezma@redhat.com>
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

The test verifies SVQ correctly handles batched pushes where multiple
elements are filled before flushing the used ring.

With this test, gcov reported coverage is:
                   Total  Hit
Lines:     83.9 %    347  291
Functions: 90.3 %     31   28
Branches:  59.2 %    157   93

Apart from impossible banches like scoped cleanups, the missing blocks
are:
* Event idx.
* All SVQ CVQ handling.
* Hard to reproduce casuistics like a linear buffer in GPA that is
  split into more than one buffer in HVA, and then SVQ is saturated.
* Buggy input (no descriptors, used descriptors that are not available,
  moving indexes more than vq size).
* Unbinding device call notifier from QEMU vhost system.

RFC: I think the tx_packets_inorder struct is also better than the async
queue for previous tests.  But I'd like to know other people opinions
too.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 183 ++++++++++++++++++++++++++++++++--
 1 file changed, 173 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 0192b00748d5..99a4df4433e3 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -44,6 +44,7 @@ static int NUM_RX_BUFS = 2;
 
 typedef struct TestParameters {
     const VduseOps *ops;
+    uint64_t features;
 } TestParameters;
 
 typedef struct VdpaThread {
@@ -56,6 +57,9 @@ typedef struct VdpaThread {
 
     /* Guest memory that must be free at the end of the test */
     uint64_t qemu_mem_to_free;
+
+    /* Expected avail_idx in in_order */
+    uint16_t expected_avail_idx;
 } VdpaThread;
 
 static void *vhost_vdpa_thread_function(void *data)
@@ -163,8 +167,19 @@ static void vhost_vdpa_kick_tx_desc(VdpaThread *t, QVirtioNet *net,
     qvirtqueue_kick(qts, net->vdev, net->queues[1], kick_id);
 }
 
+/**
+ * Get the next used element of the tx queue and check properties of it. If
+ * wait is true, wait until an element is available, otherwise just check if
+ * it's already available.
+ *
+ * Note that waiting clean the ISR, so if you call this function with
+ * wait=true, another thread must call the VQ so this call returns. If you
+ * expect to fetch many descs you need to get subsequent elements with
+ * wait=false.
+ */
 static void vhost_vdpa_get_tx_pkt(QGuestAllocator *alloc, QVirtioNet *net,
-                                  uint32_t desc_idx, VdpaThread *t)
+                                  uint32_t desc_idx, VdpaThread *t,
+                                  bool wait)
 {
     g_autofree struct VduseVirtqElement *elem = NULL;
     int64_t timeout = 5 * G_TIME_SPAN_SECOND;
@@ -174,8 +189,17 @@ static void vhost_vdpa_get_tx_pkt(QGuestAllocator *alloc, QVirtioNet *net,
     uint32_t len;
 
     end_time_us = g_get_monotonic_time() + timeout;
-    qvirtio_wait_used_elem(qts, net->vdev, net->queues[1], desc_idx, &len,
-                           timeout);
+    if (wait) {
+        qvirtio_wait_used_elem(qts, net->vdev, net->queues[1], desc_idx, &len,
+                               timeout);
+    } else {
+        uint32_t got_desc_idx;
+
+        if (!qvirtqueue_get_buf(qts, net->queues[1], &got_desc_idx, &len)) {
+            g_test_fail();
+        }
+        g_assert_cmpint(got_desc_idx, ==, desc_idx);
+    }
     g_assert_cmpint(g_get_monotonic_time(), <, end_time_us);
     g_assert_cmpint(len, ==, 0);
 
@@ -190,6 +214,7 @@ typedef struct TestServer {
     gchar *vdpa_dev_path;
     gchar *tmpfs;
     int vq_read_num;
+    size_t test_cursor;
     VduseDev *vdev;
     VdpaThread vdpa_thread;
     QemuMutex data_mutex;
@@ -330,6 +355,93 @@ static const TestParameters rxtx_params = {
     .ops = &vduse_rxtx_ops,
 };
 
+static const struct  {
+    uint16_t out_num;
+    bool push;
+} tx_packets_inorder[] = {
+    /* One buffer first */
+    { .out_num = 1, .push = true },
+
+    /* Then two buffers chained */
+    { .out_num = 2, .push = true },
+
+    /* Then one buffer, but batch it with the next one */
+    { .out_num = 1, .push = false },
+    { .out_num = 1, .push = true },
+
+    /* Finally, two buffers chained again, but batch them together */
+    { .out_num = 2, .push = false },
+    { .out_num = 2, .push = true },
+};
+
+static gboolean vhost_vdpa_rxtx_inorder_handle_tx(int fd,
+                                                  GIOCondition condition,
+                                                  void *data)
+{
+    VduseVirtq *vq = data;
+    VduseDev *dev = vduse_queue_get_dev(vq);
+    TestServer *s = vduse_dev_get_priv(dev);
+
+    eventfd_read(fd, (eventfd_t[]){0});
+    do {
+        g_autofree VduseVirtqElement *elem = NULL;
+        size_t batch_size = 1;
+        elem = vduse_queue_pop(vq, sizeof(*elem));
+        if (!elem) {
+            break;
+        }
+
+        g_assert_cmpint(s->test_cursor, <, G_N_ELEMENTS(tx_packets_inorder));
+        g_assert_cmpint(elem->out_num, ==,
+                        tx_packets_inorder[s->test_cursor].out_num);
+        g_assert_cmpint(elem->in_num, ==, 0);
+
+        if (tx_packets_inorder[s->test_cursor].push) {
+            for (ssize_t i = s->test_cursor - 1;
+                 i >= 0 && !tx_packets_inorder[i].push; i--) {
+                batch_size++;
+            }
+            vduse_queue_fill(vq, elem, /* len */ 0, /* offset */ 0);
+            vduse_queue_flush(vq, batch_size);
+            vduse_queue_notify(vq);
+        }
+        s->test_cursor++;
+    } while (true);
+
+    return G_SOURCE_CONTINUE;
+}
+
+static void vduse_rxtx_inorder_enable_queue(VduseDev *dev, VduseVirtq *vq)
+{
+    TestServer *s = vduse_dev_get_priv(dev);
+
+    g_test_message("Enabling queue %d", vq->index);
+
+    if (vq->index == 1) {
+        g_assert(dev->features & (1ULL << VIRTIO_F_IN_ORDER));
+
+        /* This is the tx queue, add a source to handle it */
+        vhost_vdpa_thread_add_source_fd(&s->vdpa_thread,
+                                        vduse_queue_get_fd(vq),
+                                        vhost_vdpa_rxtx_inorder_handle_tx, vq);
+    }
+}
+
+static void vduse_rxtx_inorder_disable_queue(VduseDev *dev, VduseVirtq *vq)
+{
+    /* Queue disabled */
+}
+
+static const VduseOps vduse_rxtx_inorder_ops = {
+    .enable_queue = vduse_rxtx_inorder_enable_queue,
+    .disable_queue = vduse_rxtx_inorder_disable_queue,
+};
+
+static const TestParameters rxtx_inorder_params = {
+    .ops = &vduse_rxtx_inorder_ops,
+    .features = (1ULL << VIRTIO_F_IN_ORDER),
+};
+
 static gboolean vduse_dev_handler_source_fd(int fd, GIOCondition condition,
                                             void *data)
 {
@@ -462,7 +574,7 @@ static TestServer *test_server_new(const gchar *name,
 
     /* Disabling NOTIFY_ON_EMPTY as SVQ does not support it */
     features = (vduse_get_virtio_features() & ~(1ULL << VIRTIO_F_NOTIFY_ON_EMPTY)) |
-               (1ULL << VIRTIO_NET_F_MAC);
+               (1ULL << VIRTIO_NET_F_MAC) | params->features;
 
     server->vdev = vduse_dev_create(server->vduse_name,
                                     VIRTIO_ID_NET,
@@ -561,7 +673,7 @@ static void vhost_vdpa_test_cleanup(void *s)
     test_server_free(server);
 }
 
-static void *vhost_vdpa_test_setup(GString *cmd_line, void *arg)
+static void *vhost_vdpa_test_setup0(GString *cmd_line, void *arg)
 {
     TestServer *server = test_server_new("vdpa-memfile", arg);
 
@@ -580,6 +692,17 @@ static void *vhost_vdpa_test_setup(GString *cmd_line, void *arg)
     return server;
 }
 
+static void *vhost_vdpa_test_setup_inorder(GString *cmd_line, void *arg)
+{
+    const char *device = g_strstr_len(cmd_line->str, -1,
+                                      "-device virtio-net-pci");
+    g_assert_nonnull(device);
+    device += strlen("-device virtio-net-pci");
+    g_string_insert(cmd_line, device - cmd_line->str, ",in_order=on");
+
+    return vhost_vdpa_test_setup0(cmd_line, arg);
+}
+
 static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *server = arg;
@@ -593,13 +716,13 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
     free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
                                             1);
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 1);
-    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread, true);
 
     /* Simple chain */
     free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
                                             2);
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 2);
-    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread, true);
 
     /* Out of order descriptors */
     free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
@@ -609,8 +732,8 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head2, 1);
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 1);
 
-    vhost_vdpa_get_tx_pkt(alloc, net, free_head2, &server->vdpa_thread);
-    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head2, &server->vdpa_thread, true);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread, true);
 
     /* Out of order chains */
     free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread,
@@ -621,11 +744,45 @@ static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
     vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head, 2);
 }
 
+static void vhost_vdpa_tx_inorder_test(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    uint32_t free_head[G_N_ELEMENTS(tx_packets_inorder)];
+    TestServer *server = arg;
+    QVirtioNet *net = obj;
+    size_t free_head_idx = 0;
+
+    for (size_t i = 0; i < G_N_ELEMENTS(tx_packets_inorder); i++) {
+        uint32_t chain_len = tx_packets_inorder[i].out_num;
+        bool wait = true;
+
+        free_head[i] = vhost_vdpa_add_tx_pkt_descs(alloc, net,
+                                                   &server->vdpa_thread,
+                                                   chain_len);
+        vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head[i], chain_len);
+        if (!tx_packets_inorder[i].push) {
+            continue;
+        }
+
+        /*
+         * TODO: SVQ uses the emulated VirtIO device underneath so it does not
+         * support to batch many used elements in order.  This is fragile and
+         * could change in the future, and the right solution is to add proper
+         * support in vhost_vdpa_get_tx_pkt -> qvirtio_wait_used_elem.  Let's
+         * just code the current behavior here for now.
+         */
+        for (; free_head_idx <= i; free_head_idx++) {
+            vhost_vdpa_get_tx_pkt(alloc, net, free_head[free_head_idx],
+                                  &server->vdpa_thread, wait);
+            wait = false;
+        }
+    }
+}
+
 static void register_vhost_vdpa_test(void)
 {
     /* TODO: void * discards const qualifier */
     QOSGraphTestOptions opts = {
-        .before = vhost_vdpa_test_setup,
+        .before = vhost_vdpa_test_setup0,
         .subprocess = true,
         .arg = (void *)&mem_read_params,
     };
@@ -638,5 +795,11 @@ static void register_vhost_vdpa_test(void)
     qos_add_test("vhost-vdpa/rxtx",
                  "virtio-net",
                  vhost_vdpa_tx_test, &opts);
+
+    opts.before = vhost_vdpa_test_setup_inorder;
+    opts.arg = (void *)&rxtx_inorder_params;
+    qos_add_test("vhost-vdpa/rxtx-inorder",
+                 "virtio-net",
+                 vhost_vdpa_tx_inorder_test, &opts);
 }
 libqos_init(register_vhost_vdpa_test);
-- 
2.53.0


