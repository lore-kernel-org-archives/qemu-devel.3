Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0E7F3D32A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBkA-00069m-Ee; Thu, 05 Mar 2026 11:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBk3-000638-2J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBk1-0000ZZ-CG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RClAoV8vJf1LhMdcHj1oXtKPcFd7BMQhS6kyWqEjlYg=;
 b=YOnupyjXct+qv/p6TIUTaX5IZJNq2YOSraCCAs7beUjSjWArq4rSlj4g6hrg8fONxznv04
 lfJE6bnFICVKLZLGN2CVk2iyldGzCqb5Il844chQqyR9Tdmln0EThQH+eY+TSc5skb5k5N
 ec9w/7UossTtTiKLkCbQ7Nb8PgjR1m8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-BMts5VgUNO6HFA1jUBFRXA-1; Thu,
 05 Mar 2026 11:39:58 -0500
X-MC-Unique: BMts5VgUNO6HFA1jUBFRXA-1
X-Mimecast-MFC-AGG-ID: BMts5VgUNO6HFA1jUBFRXA_1772728794
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56CE11956096; Thu,  5 Mar 2026 16:39:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 265201958DCA; Thu,  5 Mar 2026 16:39:50 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 3/8] tests: vhost-vdpa: add TX packet transmission test
Date: Thu,  5 Mar 2026 17:39:33 +0100
Message-ID: <20260305163938.3200787-4-eperezma@redhat.com>
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

Add test infrastructure for sending packets through TX virtqueue.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 141 +++++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 1c7d8540bd19..7b1c34aa415e 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -17,6 +17,7 @@
 #include "libqtest-single.h"
 #include "qapi/error.h"
 #include "libqos/qgraph.h"
+#include "libqos/virtio-net.h"
 #include "hw/virtio/virtio-net.h"
 
 #include "standard-headers/linux/virtio_ids.h"
@@ -25,6 +26,7 @@
 #include "subprojects/libvduse/linux-headers/linux/vduse.h"
 #include "subprojects/libvduse/libvduse.h"
 
+#include <endian.h>
 #include <poll.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -35,7 +37,7 @@
 
 #define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM," \
                         "mem-path=%s,share=on -numa node,memdev=mem"
-#define QEMU_CMD_VDPA   " -netdev type=vhost-vdpa,vhostdev=%s,id=hs0"
+#define QEMU_CMD_VDPA   " -netdev type=vhost-vdpa,x-svq=on,vhostdev=%s,id=hs0"
 #define VDUSE_RECONNECT_LOG "vduse_reconnect.log"
 
 typedef struct VdpaThread {
@@ -80,6 +82,61 @@ static void vhost_vdpa_thread_add_source_fd(VdpaThread *t, int fd,
     g_source_unref(src);
 }
 
+/**
+ * Send a descriptor or a chain of descriptors to the device, and optionally
+ * and / or update the avail ring and avail_idx of the driver ring.
+ *
+ * @alloc: the guest allocator to allocate memory for the descriptors
+ * @net: the virtio net device
+ * @t: the vdpa thread to push the expected chain length if kick is true
+ *
+ * Returns the kick_id you can use to kick the device in a later call to this
+ * function.
+ */
+static uint32_t vhost_vdpa_add_tx_pkt_descs(QGuestAllocator *alloc,
+                                            QVirtioNet *net, VdpaThread *t)
+{
+    QTestState *qts = global_qtest;
+    uint32_t req_addr;
+
+    /* TODO: Actually free this. RFC, is actually needed? */
+    req_addr = guest_alloc(alloc, 64);
+    g_assert_cmpint(req_addr, >, 0);
+
+    return qvirtqueue_add(qts, net->queues[1], req_addr, 64, /* write */ false,
+                          /* next */ false);
+}
+
+static void vhost_vdpa_kick_tx_desc(VdpaThread *t, QVirtioNet *net,
+                                    uint32_t kick_id)
+{
+    QTestState *qts = global_qtest;
+
+    qvirtqueue_kick(qts, net->vdev, net->queues[1], kick_id);
+}
+
+static void vhost_vdpa_get_tx_pkt(QGuestAllocator *alloc, QVirtioNet *net,
+                                  uint32_t desc_idx, VdpaThread *t)
+{
+    g_autofree struct VduseVirtqElement *elem = NULL;
+    int64_t timeout = 5 * G_TIME_SPAN_SECOND;
+    QTestState *qts = global_qtest;
+    vring_desc_t desc;
+    int64_t end_time_us;
+    uint32_t len;
+
+    end_time_us = g_get_monotonic_time() + timeout;
+    qvirtio_wait_used_elem(qts, net->vdev, net->queues[1], desc_idx, &len,
+                           timeout);
+    g_assert_cmpint(g_get_monotonic_time(), <, end_time_us);
+    g_assert_cmpint(len, ==, 0);
+
+    qtest_memread(qts, net->queues[1]->desc + sizeof(desc)*desc_idx, &desc,
+                  sizeof(desc));
+    /* We know we're version 1 so always little endian */
+    guest_free(alloc, le64toh(desc.addr));
+}
+
 typedef struct TestServer {
     gchar *vduse_name;
     gchar *vdpa_dev_path;
@@ -163,6 +220,54 @@ static const VduseOps vduse_read_guest_mem_ops = {
     .disable_queue = vduse_read_guest_mem_disable_queue,
 };
 
+static gboolean vhost_vdpa_rxtx_handle_tx(int fd, GIOCondition condition,
+                                          void *data)
+{
+    VduseVirtq *vq = data;
+
+    eventfd_read(fd, (eventfd_t[]){0});
+    do {
+        g_autofree VduseVirtqElement *elem = NULL;
+
+        elem = vduse_queue_pop(vq, sizeof(*elem));
+        if (!elem) {
+            break;
+        }
+
+        g_test_message("Got element with %d buffers", elem->out_num);
+        g_assert_cmpint(elem->in_num, ==, 0);
+
+        vduse_queue_push(vq, elem, 0);
+        vduse_queue_notify(vq);
+    } while (true);
+
+    return G_SOURCE_CONTINUE;
+}
+
+static void vduse_rxtx_enable_queue(VduseDev *dev, VduseVirtq *vq)
+{
+    TestServer *s = vduse_dev_get_priv(dev);
+
+    g_test_message("Enabling queue %d", vq->index);
+
+    if (vq->index == 1) {
+        /* This is the tx queue, add a source to handle it */
+        vhost_vdpa_thread_add_source_fd(&s->vdpa_thread,
+                                        vduse_queue_get_fd(vq),
+                                        vhost_vdpa_rxtx_handle_tx, vq);
+    }
+}
+
+static void vduse_rxtx_disable_queue(VduseDev *dev, VduseVirtq *vq)
+{
+    /* Queue disabled */
+}
+
+static const VduseOps vduse_rxtx_ops = {
+    .enable_queue = vduse_rxtx_enable_queue,
+    .disable_queue = vduse_rxtx_disable_queue,
+};
+
 static gboolean vduse_dev_handler_source_fd(int fd, GIOCondition condition,
                                             void *data)
 {
@@ -292,7 +397,8 @@ static TestServer *test_server_new(const gchar *name, const VduseOps *ops)
     qemu_mutex_init(&server->data_mutex);
     qemu_cond_init(&server->data_cond);
 
-    features = vduse_get_virtio_features() |
+    /* Disabling NOTIFY_ON_EMPTY as SVQ does not support it */
+    features = (vduse_get_virtio_features() & ~(1ULL << VIRTIO_F_NOTIFY_ON_EMPTY)) |
                (1ULL << VIRTIO_NET_F_MAC);
 
     server->vdev = vduse_dev_create(server->vduse_name,
@@ -376,6 +482,13 @@ static void wait_for_vqs(TestServer *s)
     }
 }
 
+static void test_wait(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    TestServer *server = arg;
+
+    wait_for_vqs(server);
+}
+
 static void vhost_vdpa_test_cleanup(void *s)
 {
     TestServer *server = s;
@@ -385,9 +498,9 @@ static void vhost_vdpa_test_cleanup(void *s)
     test_server_free(server);
 }
 
-static void *vhost_vdpa_test_setup_memfile(GString *cmd_line, void *arg)
+static void *vhost_vdpa_test_setup(GString *cmd_line, void *arg)
 {
-    TestServer *server = test_server_new("vdpa-memfile", &vduse_read_guest_mem_ops);
+    TestServer *server = test_server_new("vdpa-memfile", arg);
 
     if (!server->ready) {
         g_test_skip("Failed to create VDUSE device");
@@ -404,23 +517,33 @@ static void *vhost_vdpa_test_setup_memfile(GString *cmd_line, void *arg)
     return server;
 }
 
-static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
+static void vhost_vdpa_tx_test(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *server = arg;
+    QVirtioNet *net = obj;
+    uint32_t free_head;
 
-    wait_for_vqs(server);
+    free_head = vhost_vdpa_add_tx_pkt_descs(alloc, net, &server->vdpa_thread);
+    vhost_vdpa_kick_tx_desc(&server->vdpa_thread, net, free_head);
+    vhost_vdpa_get_tx_pkt(alloc, net, free_head, &server->vdpa_thread);
 }
 
 static void register_vhost_vdpa_test(void)
 {
+    /* TODO: void * discards const qualifier */
     QOSGraphTestOptions opts = {
-        .before = vhost_vdpa_test_setup_memfile,
+        .before = vhost_vdpa_test_setup,
         .subprocess = true,
-        .arg = NULL,
+        .arg = (void *)&vduse_read_guest_mem_ops,
     };
 
     qos_add_test("vhost-vdpa/read-guest-mem/memfile",
                  "virtio-net",
-                 test_read_guest_mem, &opts);
+                 test_wait, &opts);
+
+    opts.arg = (void *)&vduse_rxtx_ops;
+    qos_add_test("vhost-vdpa/rxtx",
+                 "virtio-net",
+                 vhost_vdpa_tx_test, &opts);
 }
 libqos_init(register_vhost_vdpa_test);
-- 
2.53.0


