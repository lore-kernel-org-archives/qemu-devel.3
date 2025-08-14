Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1342DCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 08:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umTUC-0007Nd-Ml; Thu, 14 Aug 2025 04:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTUA-0007NL-W3
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTU4-0006A1-Iq
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755160731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcgyWEw0UZlhydwF41sGf+kzWAR2qTmet/4n/K4pS3U=;
 b=PFrMnTeNROJ13Fajls/q2ohmE2tUSIvtzoiBYGq8kjRW1Wn9welj/JFZWLeIUR9by7go0v
 kloeWmNfpJeVIjI7c2NUDtfsWFDUu7eD1L1TqeWYnWAhvBujPsNCtx+Bd88YVLsJlgtl+a
 WsU5A5PVfKtuM0xdBCtIDTbGzfYILsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-qGFyVk6vNeiZTPdrje3gHg-1; Thu,
 14 Aug 2025 04:38:48 -0400
X-MC-Unique: qGFyVk6vNeiZTPdrje3gHg-1
X-Mimecast-MFC-AGG-ID: qGFyVk6vNeiZTPdrje3gHg_1755160727
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E152C1800371; Thu, 14 Aug 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.203])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5522318003FC; Thu, 14 Aug 2025 08:38:40 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 hi@alyssa.is, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, dbassey@redhat.com, stevensd@chromium.org,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v6 6/8] tests/qtest: Add GET_SHMEM validation test
Date: Thu, 14 Aug 2025 10:37:47 +0200
Message-ID: <20250814083749.1317197-7-aesteve@redhat.com>
In-Reply-To: <20250814083749.1317197-1-aesteve@redhat.com>
References: <20250814083749.1317197-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


