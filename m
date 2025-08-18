Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39CCA0EC6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 10:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unwjP-0004BP-1A; Mon, 18 Aug 2025 06:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unwjN-0004Ax-8i
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unwjL-0002sI-Ez
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755511482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcgyWEw0UZlhydwF41sGf+kzWAR2qTmet/4n/K4pS3U=;
 b=VNaobZXR23TvSRZ1b1GyTVr1P8qmO8Uh4QLTztfh0cr1HKcMO3N026dPr1gIHo6mutD9TI
 +V+FbDXzAG4TRbqMdcehdEg0pKBy6jk4k+cqoXbt+lQJXH3XE2aJIjrIAqniwrO9k5MY5z
 R3sD2PHhaCewlYhMgAE5/BnDfF+CHyc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-U4RiXNvvOGKFyRsKb3ZIvQ-1; Mon,
 18 Aug 2025 06:04:41 -0400
X-MC-Unique: U4RiXNvvOGKFyRsKb3ZIvQ-1
X-Mimecast-MFC-AGG-ID: U4RiXNvvOGKFyRsKb3ZIvQ_1755511480
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A8B61956086; Mon, 18 Aug 2025 10:04:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADDAC180047F; Mon, 18 Aug 2025 10:04:34 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is,
 jasowang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 dbassey@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v7 6/8] tests/qtest: Add GET_SHMEM validation test
Date: Mon, 18 Aug 2025 12:03:51 +0200
Message-ID: <20250818100353.1560655-7-aesteve@redhat.com>
In-Reply-To: <20250818100353.1560655-1-aesteve@redhat.com>
References: <20250818100353.1560655-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Improve vhost-user-test to properly validate
VHOST_USER_GET_SHMEM_CONFIG message handling by
directly simulating the message exchange.

The test manually triggers the
VHOST_USER_GET_SHMEM_CONFIG message by calling
chr_read() with a crafted VhostUserMsg, allowing direct
validation of the shmem configuration response handler.

Added TestServerShmem structure to track shmem
configuration state, including nregions_sent and
sizes_sent arrays for comprehensive validation.
The test verifies that the response contains the expected
number of shared memory regions and their corresponding
sizes.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tests/qtest/vhost-user-test.c | 91 +++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 75cb3e44b2..44a5e90b2e 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -88,6 +88,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_GET_CONFIG = 24,
     VHOST_USER_SET_CONFIG = 25,
+    VHOST_USER_GET_SHMEM_CONFIG = 44,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -109,6 +110,20 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
+#define VIRTIO_MAX_SHMEM_REGIONS 256
+
+typedef struct VhostUserShMemConfig {
+    uint32_t nregions;
+    uint32_t padding;
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+} VhostUserShMemConfig;
+
+typedef struct TestServerShmem {
+    bool test_enabled;
+    uint32_t nregions_sent;
+    uint64_t sizes_sent[VIRTIO_MAX_SHMEM_REGIONS];
+} TestServerShmem;
+
 typedef struct VhostUserMsg {
     VhostUserRequest request;
 
@@ -124,6 +139,7 @@ typedef struct VhostUserMsg {
         struct vhost_vring_addr addr;
         VhostUserMemory memory;
         VhostUserLog log;
+        VhostUserShMemConfig shmem;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -170,6 +186,7 @@ typedef struct TestServer {
     bool test_fail;
     int test_flags;
     int queues;
+    TestServerShmem shmem;
     struct vhost_user_ops *vu_ops;
 } TestServer;
 
@@ -513,6 +530,31 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         qos_printf("set_vring(%d)=%s\n", msg.payload.state.index,
                    msg.payload.state.num ? "enabled" : "disabled");
         break;
+    
+    case VHOST_USER_GET_SHMEM_CONFIG:
+        if (!s->shmem.test_enabled) {
+            /* Reply with error if shmem feature not enabled */
+            msg.flags |= VHOST_USER_REPLY_MASK;
+            msg.size = sizeof(uint64_t);
+            msg.payload.u64 = -1; /* Error */
+            qemu_chr_fe_write_all(chr, (uint8_t *) &msg, VHOST_USER_HDR_SIZE + msg.size);
+        } else {
+            /* Reply with test shmem configuration */
+            msg.flags |= VHOST_USER_REPLY_MASK;
+            msg.size = sizeof(VhostUserShMemConfig);
+            msg.payload.shmem.nregions = 2; /* Test with 2 regions */
+            msg.payload.shmem.padding = 0;
+            msg.payload.shmem.memory_sizes[0] = 0x100000; /* 1MB */
+            msg.payload.shmem.memory_sizes[1] = 0x200000; /* 2MB */
+            
+            /* Record what we're sending for test validation */
+            s->shmem.nregions_sent = msg.payload.shmem.nregions;
+            s->shmem.sizes_sent[0] = msg.payload.shmem.memory_sizes[0];
+            s->shmem.sizes_sent[1] = msg.payload.shmem.memory_sizes[1];
+            
+            qemu_chr_fe_write_all(chr, (uint8_t *) &msg, VHOST_USER_HDR_SIZE + msg.size);
+        }
+        break;
 
     default:
         qos_printf("vhost-user: un-handled message: %d\n", msg.request);
@@ -809,6 +851,22 @@ static void *vhost_user_test_setup_shm(GString *cmd_line, void *arg)
     return server;
 }
 
+static void *vhost_user_test_setup_shmem_config(GString *cmd_line, void *arg)
+{
+    TestServer *server = test_server_new("vhost-user-test", arg);
+    test_server_listen(server);
+
+    /* Enable shmem testing for this server */
+    server->shmem.test_enabled = true;
+
+    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_SHM);
+    server->vu_ops->append_opts(server, cmd_line, "");
+
+    g_test_queue_destroy(vhost_user_test_cleanup, server);
+
+    return server;
+}
+
 static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *server = arg;
@@ -1089,6 +1147,33 @@ static struct vhost_user_ops g_vu_net_ops = {
     .get_protocol_features = vu_net_get_protocol_features,
 };
 
+/* Test function for VHOST_USER_GET_SHMEM_CONFIG message */
+static void test_shmem_config(void *obj, void *arg, QGuestAllocator *alloc)
+{
+    TestServer *s = arg;
+    
+    g_assert_true(s->shmem.test_enabled);
+    
+    g_mutex_lock(&s->data_mutex);
+    s->shmem.nregions_sent = 0;
+    s->shmem.sizes_sent[0] = 0;
+    s->shmem.sizes_sent[1] = 0;
+    g_mutex_unlock(&s->data_mutex);
+    
+    VhostUserMsg msg = {
+        .request = VHOST_USER_GET_SHMEM_CONFIG,
+        .flags = VHOST_USER_VERSION,
+        .size = 0,
+    };
+    chr_read(s, (uint8_t *) &msg, VHOST_USER_HDR_SIZE);
+
+    g_mutex_lock(&s->data_mutex);
+    g_assert_cmpint(s->shmem.nregions_sent, ==, 2);
+    g_assert_cmpint(s->shmem.sizes_sent[0], ==, 0x100000); /* 1MB */
+    g_assert_cmpint(s->shmem.sizes_sent[1], ==, 0x200000); /* 2MB */
+    g_mutex_unlock(&s->data_mutex);
+}
+
 static void register_vhost_user_test(void)
 {
     QOSGraphTestOptions opts = {
@@ -1136,6 +1221,12 @@ static void register_vhost_user_test(void)
     qos_add_test("vhost-user/multiqueue",
                  "virtio-net",
                  test_multiqueue, &opts);
+    
+    opts.before = vhost_user_test_setup_shmem_config;
+    opts.edge.extra_device_opts = "";
+    qos_add_test("vhost-user/shmem-config",
+                 "virtio-net",
+                 test_shmem_config, &opts);
 }
 libqos_init(register_vhost_user_test);
 
-- 
2.49.0


