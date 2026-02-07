Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72633EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voifU-000322-VV; Sat, 07 Feb 2026 08:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifH-00030I-5B
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifD-0003Cz-Uq
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9BUF9iLC/0WaAbCVNT/90vV7XGl20ndC7+Sq52C3rWQ=;
 b=Lk7ChEJOqRXluJxkKCQVFUMaEIMjc2QzNLNw/CL/pFSQu1XfOm9d0zrk2KrcXZjzlQI1vq
 Nq34TxPqn6YOPZ7BM8WGNKm20yyl9KBXefKdcfaWuAx9sjv73KmK41zJdVdT64yIELKVdR
 oyxkMlEk1SAHmjVYznLEtQXAuW8l/Wg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-wAzO-Ss-O8CnEKWLz-o4NA-1; Sat,
 07 Feb 2026 08:47:51 -0500
X-MC-Unique: wAzO-Ss-O8CnEKWLz-o4NA-1
X-Mimecast-MFC-AGG-ID: wAzO-Ss-O8CnEKWLz-o4NA_1770472070
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD8841956088; Sat,  7 Feb 2026 13:47:49 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D11618004BB; Sat,  7 Feb 2026 13:47:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 02/12] net/filter-mirror: add enable_when_stopped option for
 filter-redirector
Date: Sat,  7 Feb 2026 21:47:18 +0800
Message-ID: <20260207134728.1495932-2-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jason Wang <jasowang@redhat.com>

Add a QAPI option 'enable_when_stopped' for filter-redirector that
allows it to continue receiving data from netdev when VM is stopped.

When enabled, a VM state change handler activates the netdev's
read_poll() when VM stops, allowing the netdev to continue reading
data and passing it through filter-redirector to the chardev output.

This is useful for scenarios where filter-redirector needs to
process network traffic even when the VM is paused.

Usage:
  -object filter-redirector,id=f0,netdev=net0,queue=tx,\
          outdev=chardev0,enable_when_stopped=true

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c                  |  38 ++++++++++
 qapi/qom.json                        |   7 +-
 tests/qtest/test-filter-redirector.c | 106 +++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index aa2ab452fd..e1a0650abd 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -21,6 +21,7 @@
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "block/aio-wait.h"
+#include "system/runstate.h"
 
 #define TYPE_FILTER_MIRROR "filter-mirror"
 typedef struct MirrorState MirrorState;
@@ -41,6 +42,8 @@ struct MirrorState {
     CharFrontend chr_out;
     SocketReadState rs;
     bool vnet_hdr;
+    bool enable_when_stopped;
+    VMChangeStateEntry *vmsentry;
 };
 
 typedef struct FilterSendCo {
@@ -251,6 +254,7 @@ static void filter_redirector_cleanup(NetFilterState *nf)
 
     qemu_chr_fe_deinit(&s->chr_in, false);
     qemu_chr_fe_deinit(&s->chr_out, false);
+    qemu_del_vm_change_state_handler(s->vmsentry);
 }
 
 static void filter_mirror_setup(NetFilterState *nf, Error **errp)
@@ -282,6 +286,18 @@ static void redirector_rs_finalize(SocketReadState *rs)
     redirector_to_filter(nf, rs->buf, rs->packet_len);
 }
 
+static void filter_redirector_vm_state_change(void *opaque, bool running,
+                                              RunState state)
+{
+    NetFilterState *nf = opaque;
+    MirrorState *s = FILTER_REDIRECTOR(nf);
+    NetClientState *nc = nf->netdev;
+
+    if (!running && s->enable_when_stopped && nc->info->read_poll) {
+        nc->info->read_poll(nc, true);
+    }
+}
+
 static void filter_redirector_setup(NetFilterState *nf, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(nf);
@@ -331,6 +347,9 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
             return;
         }
     }
+
+    s->vmsentry = qemu_add_vm_change_state_handler(
+        filter_redirector_vm_state_change, nf);
 }
 
 static void filter_redirector_status_changed(NetFilterState *nf, Error **errp)
@@ -437,6 +456,22 @@ static void filter_redirector_set_vnet_hdr(Object *obj,
     s->vnet_hdr = value;
 }
 
+static bool filter_redirector_get_enable_when_stopped(Object *obj, Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    return s->enable_when_stopped;
+}
+
+static void filter_redirector_set_enable_when_stopped(Object *obj,
+                                                      bool value,
+                                                      Error **errp)
+{
+    MirrorState *s = FILTER_REDIRECTOR(obj);
+
+    s->enable_when_stopped = value;
+}
+
 static void filter_mirror_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
@@ -463,6 +498,9 @@ static void filter_redirector_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "vnet_hdr_support",
                                    filter_redirector_get_vnet_hdr,
                                    filter_redirector_set_vnet_hdr);
+    object_class_property_add_bool(oc, "enable_when_stopped",
+                                   filter_redirector_get_enable_when_stopped,
+                                   filter_redirector_set_enable_when_stopped);
 
     nfc->setup = filter_redirector_setup;
     nfc->cleanup = filter_redirector_cleanup;
diff --git a/qapi/qom.json b/qapi/qom.json
index 6f5c9de0f0..b1fe55944c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -488,13 +488,18 @@
 # @vnet_hdr_support: if true, vnet header support is enabled
 #     (default: false)
 #
+# @enable_when_stopped: if true, activate netdev's read poll when VM
+#     stops to allow filter-redirector to continue receiving data
+#     (default: false)
+#
 # Since: 2.6
 ##
 { 'struct': 'FilterRedirectorProperties',
   'base': 'NetfilterProperties',
   'data': { '*indev': 'str',
             '*outdev': 'str',
-            '*vnet_hdr_support': 'bool' } }
+            '*vnet_hdr_support': 'bool',
+            '*enable_when_stopped': 'bool' } }
 
 ##
 # @FilterRewriterProperties:
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index 5540c232c0..fa958bb0a5 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -385,6 +385,110 @@ static void test_redirector_init_status_off(void)
     qtest_quit(qts);
 }
 
+/*
+ * Test filter-redirector works when VM is stopped (TX direction).
+ *
+ * This test verifies that when VM is stopped, the filter-redirector
+ * can still receive data from the netdev because the VM state change
+ * handler activates the netdev's read_poll(). Data flows from netdev
+ * to filter-redirector and out through the chardev.
+ *
+ * Data flow: backend_sock -> netdev (read_poll) -> filter-redirector -> chardev
+ */
+static void test_redirector_with_vm_stop(void)
+{
+    int backend_sock[2], recv_sock;
+    uint32_t ret = 0, len = 0;
+    char send_buf[] = "Hello!!";
+    char sock_path0[] = "filter-redirector0.XXXXXX";
+    char *recv_buf;
+    uint32_t size = sizeof(send_buf);
+    size = htonl(size);
+    QTestState *qts;
+    struct timeval tv;
+    fd_set rfds;
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    ret = mkstemp(sock_path0);
+    g_assert_cmpint(ret, !=, -1);
+
+    /*
+     * Setup TX path: netdev -> filter-redirector -> chardev
+     * Data sent to backend_sock[0] will be read by the netdev,
+     * passed through filter-redirector, and output to sock_path0.
+     * Enable enable_when_stopped to activate read_poll when VM stops.
+     */
+    qts = qtest_initf(
+        "-nic socket,id=qtest-bn0,fd=%d "
+        "-chardev socket,id=redirector0,path=%s,server=on,wait=off "
+        "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
+        "queue=tx,outdev=redirector0,enable_when_stopped=true ",
+        backend_sock[1], sock_path0);
+
+    recv_sock = unix_connect(sock_path0, NULL);
+    g_assert_cmpint(recv_sock, !=, -1);
+
+    /* Ensure connection is established */
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    struct iovec iov[] = {
+        {
+            .iov_base = &size,
+            .iov_len = sizeof(size),
+        }, {
+            .iov_base = send_buf,
+            .iov_len = sizeof(send_buf),
+        },
+    };
+
+    /*
+     * Stop the VM - this triggers our vm_state_change handler
+     * which should activate the netdev's read_poll()
+     */
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'stop'}");
+
+    /* Wait for VM to actually stop */
+    qtest_qmp_eventwait(qts, "STOP");
+
+    /*
+     * Send data to backend socket while VM is stopped.
+     * The netdev should still read the data (because read_poll is
+     * activated by our vm_state_change handler), pass it through
+     * filter-redirector, and output to the chardev.
+     */
+    ret = iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    /*
+     * Data should arrive at recv_sock even with VM stopped,
+     * because read_poll is activated.
+     */
+    FD_ZERO(&rfds);
+    FD_SET(recv_sock, &rfds);
+    tv.tv_sec = 5;
+    tv.tv_usec = 0;
+    ret = select(recv_sock + 1, &rfds, NULL, NULL, &tv);
+    g_assert_cmpint(ret, ==, 1);  /* Data should arrive */
+
+    ret = recv(recv_sock, &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==, sizeof(len));
+    len = ntohl(len);
+
+    g_assert_cmpint(len, ==, sizeof(send_buf));
+    recv_buf = g_malloc(len);
+    ret = recv(recv_sock, recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
+    g_assert_cmpstr(recv_buf, ==, send_buf);
+
+    g_free(recv_buf);
+    close(recv_sock);
+    close(backend_sock[0]);
+    unlink(sock_path0);
+    qtest_quit(qts);
+}
+
 static void test_redirector_rx_event_opened(void)
 {
     int backend_sock[2], send_sock;
@@ -489,5 +593,7 @@ int main(int argc, char **argv)
                    test_redirector_init_status_off);
     qtest_add_func("/netfilter/redirector_rx_event_opened",
                    test_redirector_rx_event_opened);
+    qtest_add_func("/netfilter/redirector_with_vm_stop",
+                   test_redirector_with_vm_stop);
     return g_test_run();
 }
-- 
2.52.0


