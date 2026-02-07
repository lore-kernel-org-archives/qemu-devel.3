Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2D7EE0AE4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigB-0003YV-QQ; Sat, 07 Feb 2026 08:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifr-0003Je-CH
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifk-0003Ew-Dy
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4ehdhIooVsJXMe4M0Z1v1Zz4s/zK/9guJ7vD04/nOg=;
 b=gcjm/jw3yK8Vu0jOBqUl3XSUGF2j24/wPaX/LBjCpjvVbNsD9fyqbJRUaFb3vViWovfGSj
 1PKt1Jcc10dJw0Tj8vWrfvDux9rgvzAIp2VhIhWLS9D5M+0tHag744Af2YFgxAuHVk6xRY
 oT33SZ+sUmBPOayMAYm5/Ho6aOkQIUc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-TIz5Xx2FOyGC-SSLUfkciw-1; Sat,
 07 Feb 2026 08:48:25 -0500
X-MC-Unique: TIz5Xx2FOyGC-SSLUfkciw-1
X-Mimecast-MFC-AGG-ID: TIz5Xx2FOyGC-SSLUfkciw_1770472104
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98ED31955F12; Sat,  7 Feb 2026 13:48:24 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD08D3000218; Sat,  7 Feb 2026 13:48:20 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 05/12] tests/qtest: add tests for filter-redirector
 indev/outdev statistics
Date: Sat,  7 Feb 2026 21:47:21 +0800
Message-ID: <20260207134728.1495932-5-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Add test cases to verify the indev/outdev counters for filter-redirector:

test_query_netfilter_stats_rx():
- Extended to verify indev counter in the counters array
- Uses filter-redirector with indev to inject packets
- Verifies indev packets/bytes are updated

test_query_netfilter_stats_redirector_outdev():
- New test for outdev statistics
- Uses filter-redirector with outdev configured
- Verifies initial outdev counters are zero
- Sends packet and verifies outdev packets/bytes are updated

These tests verify the new flexible counters array design where
filter-specific statistics are returned via the get_stats callback.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 tests/qtest/test-netfilter.c | 371 +++++++++++++++++++++++++++++++++++
 1 file changed, 371 insertions(+)

diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilter.c
index 326d4bd85f..20b0373cf7 100644
--- a/tests/qtest/test-netfilter.c
+++ b/tests/qtest/test-netfilter.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/iov.h"
 #include "libqtest-single.h"
 #include "qobject/qdict.h"
 
@@ -124,6 +125,371 @@ static void add_multi_netfilter(void)
     qobject_unref(response);
 }
 
+/*
+ * Test query-netfilter-stats for TX direction using filter-mirror.
+ *
+ * Traffic flow:
+ *   test_sock -> socket backend (bn0) -> filter-mirror (TX stats++) -> chardev
+ */
+static void test_query_netfilter_stats_tx(void)
+{
+    QTestState *qts;
+    QDict *response;
+    QList *stats_list;
+    const QListEntry *entry;
+    int send_sock[2], recv_sock[2];
+    int ret;
+    char send_buf[] = "Hello TX stats!";
+    uint32_t size = sizeof(send_buf);
+    uint32_t net_size;
+    bool found_filter = false;
+
+    net_size = htonl(size);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, recv_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    qts = qtest_initf(
+        "-nic socket,id=bn0,fd=%d "
+        "-chardev socket,id=mirror0,fd=%d "
+        "-object filter-mirror,id=f0,netdev=bn0,queue=tx,outdev=mirror0",
+        send_sock[1], recv_sock[1]);
+
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    /* Query initial stats */
+    response = qtest_qmp(qts, "{'execute': 'query-netfilter-stats'}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    stats_list = qdict_get_qlist(response, "return");
+    g_assert(stats_list);
+
+    for (entry = qlist_first(stats_list); entry; entry = qlist_next(entry)) {
+        QDict *stats = qobject_to(QDict, qlist_entry_obj(entry));
+        const char *name = qdict_get_str(stats, "name");
+        if (g_strcmp0(name, "f0") == 0) {
+            found_filter = true;
+            g_assert_cmpint(qdict_get_int(stats, "packets-tx"), ==, 0);
+            g_assert_cmpint(qdict_get_int(stats, "bytes-tx"), ==, 0);
+            g_assert_cmpstr(qdict_get_str(stats, "type"), ==, "filter-mirror");
+        }
+    }
+    g_assert(found_filter);
+    qobject_unref(response);
+
+    /* Send packet - triggers TX direction */
+    struct iovec iov[] = {
+        { .iov_base = &net_size, .iov_len = sizeof(net_size) },
+        { .iov_base = send_buf, .iov_len = sizeof(send_buf) },
+    };
+    ret = iov_send(send_sock[0], iov, 2, 0,
+                   sizeof(net_size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(net_size));
+
+    g_usleep(100000);
+
+    /* Verify TX stats updated */
+    response = qtest_qmp(qts, "{'execute': 'query-netfilter-stats'}");
+    g_assert(response);
+    stats_list = qdict_get_qlist(response, "return");
+
+    found_filter = false;
+    for (entry = qlist_first(stats_list); entry; entry = qlist_next(entry)) {
+        QDict *stats = qobject_to(QDict, qlist_entry_obj(entry));
+        const char *name = qdict_get_str(stats, "name");
+        if (g_strcmp0(name, "f0") == 0) {
+            found_filter = true;
+            g_assert_cmpint(qdict_get_int(stats, "packets-tx"), >=, 1);
+            g_assert_cmpint(qdict_get_int(stats, "bytes-tx"), >=,
+                            sizeof(send_buf));
+        }
+    }
+    g_assert(found_filter);
+    qobject_unref(response);
+
+    close(send_sock[0]);
+    close(send_sock[1]);
+    close(recv_sock[0]);
+    close(recv_sock[1]);
+    qtest_quit(qts);
+}
+
+/*
+ * Test query-netfilter-stats for RX direction using filter-redirector.
+ *
+ * Traffic flow:
+ *   indev_sock -> chardev (indev) -> filter-redirector -> netdev (RX path)
+ *
+ * When filter-redirector reads from indev and calls redirector_to_filter(),
+ * it passes the packet to the next filter in the chain via
+ * qemu_netfilter_pass_to_next(). We add a second filter (filter-buffer)
+ * that will receive the packet and update its RX stats.
+ */
+static void test_query_netfilter_stats_rx(void)
+{
+    QTestState *qts;
+    QDict *response;
+    QList *stats_list;
+    const QListEntry *entry;
+    int backend_sock[2], indev_sock[2];
+    int ret;
+    char send_buf[] = "Hello RX stats!";
+    uint32_t size = sizeof(send_buf);
+    uint32_t net_size;
+    bool found_buffer = false;
+
+    net_size = htonl(size);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, indev_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    /*
+     * Setup:
+     * - filter-redirector (rd0, queue=rx, indev) at tail - injects data
+     * - filter-buffer (fb0, queue=rx) at head - receives and counts
+     *
+     * RX direction traverses from tail to head, so:
+     * indev -> rd0 (reads, calls pass_to_next) -> fb0 (receive_iov, RX stats++)
+     */
+    qts = qtest_initf(
+        "-nic socket,id=bn0,fd=%d "
+        "-chardev socket,id=indev0,fd=%d "
+        "-object filter-buffer,id=fb0,netdev=bn0,queue=rx,interval=1000000,position=head "
+        "-object filter-redirector,id=rd0,netdev=bn0,queue=rx,indev=indev0,position=tail",
+        backend_sock[1], indev_sock[1]);
+
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    /* Query initial stats - fb0 should have zero RX */
+    response = qtest_qmp(qts, "{'execute': 'query-netfilter-stats'}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    stats_list = qdict_get_qlist(response, "return");
+    g_assert(stats_list);
+
+    for (entry = qlist_first(stats_list); entry; entry = qlist_next(entry)) {
+        QDict *stats = qobject_to(QDict, qlist_entry_obj(entry));
+        const char *name = qdict_get_str(stats, "name");
+        if (g_strcmp0(name, "fb0") == 0) {
+            found_buffer = true;
+            g_assert_cmpint(qdict_get_int(stats, "packets-rx"), ==, 0);
+            g_assert_cmpint(qdict_get_int(stats, "bytes-rx"), ==, 0);
+            g_assert_cmpstr(qdict_get_str(stats, "type"), ==, "filter-buffer");
+        }
+    }
+    g_assert(found_buffer);
+    qobject_unref(response);
+
+    /* Inject packet via indev - triggers RX direction */
+    struct iovec iov[] = {
+        { .iov_base = &net_size, .iov_len = sizeof(net_size) },
+        { .iov_base = send_buf, .iov_len = sizeof(send_buf) },
+    };
+    ret = iov_send(indev_sock[0], iov, 2, 0,
+                   sizeof(net_size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(net_size));
+
+    g_usleep(100000);
+
+    /* Verify fb0's RX stats and rd0's indev stats updated */
+    response = qtest_qmp(qts, "{'execute': 'query-netfilter-stats'}");
+    g_assert(response);
+    stats_list = qdict_get_qlist(response, "return");
+
+    found_buffer = false;
+    bool found_redirector = false;
+    for (entry = qlist_first(stats_list); entry; entry = qlist_next(entry)) {
+        QDict *stats = qobject_to(QDict, qlist_entry_obj(entry));
+        const char *name = qdict_get_str(stats, "name");
+        if (g_strcmp0(name, "fb0") == 0) {
+            found_buffer = true;
+            g_assert_cmpint(qdict_get_int(stats, "packets-rx"), >=, 1);
+            g_assert_cmpint(qdict_get_int(stats, "bytes-rx"), >=,
+                            sizeof(send_buf));
+        }
+        if (g_strcmp0(name, "rd0") == 0) {
+            QList *counters;
+            const QListEntry *centry;
+            bool found_indev = false;
+
+            found_redirector = true;
+            /* Verify indev counter in counters array */
+            g_assert(qdict_haskey(stats, "counters"));
+            counters = qdict_get_qlist(stats, "counters");
+            for (centry = qlist_first(counters); centry;
+                 centry = qlist_next(centry)) {
+                QDict *counter = qobject_to(QDict, qlist_entry_obj(centry));
+                const char *cname = qdict_get_str(counter, "name");
+                if (g_strcmp0(cname, "indev") == 0) {
+                    found_indev = true;
+                    g_assert_cmpint(qdict_get_int(counter, "packets"), >=, 1);
+                    g_assert_cmpint(qdict_get_int(counter, "bytes"),
+                                    >=, sizeof(send_buf));
+                }
+            }
+            g_assert(found_indev);
+        }
+    }
+    g_assert(found_buffer);
+    g_assert(found_redirector);
+    qobject_unref(response);
+
+    /* Test query by name */
+    response = qtest_qmp(qts,
+                         "{'execute': 'query-netfilter-stats',"
+                         " 'arguments': { 'name': 'fb0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    stats_list = qdict_get_qlist(response, "return");
+    g_assert_cmpint(qlist_size(stats_list), ==, 1);
+    qobject_unref(response);
+
+    /* Test error for non-existent filter */
+    response = qtest_qmp(qts,
+                         "{'execute': 'query-netfilter-stats',"
+                         " 'arguments': { 'name': 'nonexistent' }}");
+    g_assert(response);
+    g_assert(qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    close(backend_sock[0]);
+    close(backend_sock[1]);
+    close(indev_sock[0]);
+    close(indev_sock[1]);
+    qtest_quit(qts);
+}
+
+/*
+ * Test filter-redirector outdev statistics.
+ *
+ * Traffic flow:
+ *   test_sock -> socket backend -> filter-redirector (outdev) -> chardev
+ *
+ * When data passes through filter-redirector with outdev configured,
+ * it sends the data to outdev and updates outdev statistics.
+ */
+static void test_query_netfilter_stats_redirector_outdev(void)
+{
+    QTestState *qts;
+    QDict *response;
+    QList *stats_list;
+    const QListEntry *entry;
+    int send_sock[2], recv_sock[2];
+    int ret;
+    char send_buf[] = "Hello outdev stats!";
+    uint32_t size = sizeof(send_buf);
+    uint32_t net_size;
+    bool found_redirector = false;
+
+    net_size = htonl(size);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, recv_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    qts = qtest_initf(
+        "-nic socket,id=bn0,fd=%d "
+        "-chardev socket,id=outdev0,fd=%d "
+        "-object filter-redirector,id=rd0,netdev=bn0,queue=tx,outdev=outdev0",
+        send_sock[1], recv_sock[1]);
+
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    /* Query initial stats */
+    response = qtest_qmp(qts, "{'execute': 'query-netfilter-stats'}");
+    g_assert(response);
+    stats_list = qdict_get_qlist(response, "return");
+
+    for (entry = qlist_first(stats_list); entry; entry = qlist_next(entry)) {
+        QDict *stats = qobject_to(QDict, qlist_entry_obj(entry));
+        const char *name = qdict_get_str(stats, "name");
+        if (g_strcmp0(name, "rd0") == 0) {
+            QList *counters;
+            const QListEntry *centry;
+            bool found_outdev = false;
+
+            found_redirector = true;
+            g_assert(qdict_haskey(stats, "counters"));
+            counters = qdict_get_qlist(stats, "counters");
+            for (centry = qlist_first(counters); centry;
+                 centry = qlist_next(centry)) {
+                QDict *counter = qobject_to(QDict, qlist_entry_obj(centry));
+                const char *cname = qdict_get_str(counter, "name");
+                if (g_strcmp0(cname, "outdev") == 0) {
+                    found_outdev = true;
+                    g_assert_cmpint(qdict_get_int(counter, "packets"), ==, 0);
+                    g_assert_cmpint(qdict_get_int(counter, "bytes"), ==, 0);
+                }
+            }
+            g_assert(found_outdev);
+        }
+    }
+    g_assert(found_redirector);
+    qobject_unref(response);
+
+    /* Send packet - triggers TX direction and outdev */
+    struct iovec iov[] = {
+        { .iov_base = &net_size, .iov_len = sizeof(net_size) },
+        { .iov_base = send_buf, .iov_len = sizeof(send_buf) },
+    };
+    ret = iov_send(send_sock[0], iov, 2, 0,
+                   sizeof(net_size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(net_size));
+
+    g_usleep(100000);
+
+    /* Verify outdev stats updated */
+    response = qtest_qmp(qts, "{'execute': 'query-netfilter-stats'}");
+    g_assert(response);
+    stats_list = qdict_get_qlist(response, "return");
+
+    found_redirector = false;
+    for (entry = qlist_first(stats_list); entry; entry = qlist_next(entry)) {
+        QDict *stats = qobject_to(QDict, qlist_entry_obj(entry));
+        const char *name = qdict_get_str(stats, "name");
+        if (g_strcmp0(name, "rd0") == 0) {
+            QList *counters;
+            const QListEntry *centry;
+            bool found_outdev = false;
+
+            found_redirector = true;
+            /* TX stats should also be updated */
+            g_assert_cmpint(qdict_get_int(stats, "packets-tx"), >=, 1);
+
+            /* Verify outdev counter */
+            counters = qdict_get_qlist(stats, "counters");
+            for (centry = qlist_first(counters); centry;
+                 centry = qlist_next(centry)) {
+                QDict *counter = qobject_to(QDict, qlist_entry_obj(centry));
+                const char *cname = qdict_get_str(counter, "name");
+                if (g_strcmp0(cname, "outdev") == 0) {
+                    found_outdev = true;
+                    g_assert_cmpint(qdict_get_int(counter, "packets"), >=, 1);
+                    g_assert_cmpint(qdict_get_int(counter, "bytes"),
+                                    >=, sizeof(send_buf));
+                }
+            }
+            g_assert(found_outdev);
+        }
+    }
+    g_assert(found_redirector);
+    qobject_unref(response);
+
+    close(send_sock[0]);
+    close(send_sock[1]);
+    close(recv_sock[0]);
+    close(recv_sock[1]);
+    qtest_quit(qts);
+}
+
 /* add multi(2) netfilters to a netdev and then remove the netdev */
 static void remove_netdev_with_multi_netfilter(void)
 {
@@ -187,6 +553,11 @@ int main(int argc, char **argv)
     qtest_add_func("/netfilter/remove_netdev_multi",
                    remove_netdev_with_multi_netfilter);
 
+    qtest_add_func("/netfilter/query_stats_tx", test_query_netfilter_stats_tx);
+    qtest_add_func("/netfilter/query_stats_rx", test_query_netfilter_stats_rx);
+    qtest_add_func("/netfilter/query_stats_redirector_outdev",
+                   test_query_netfilter_stats_redirector_outdev);
+
     args = g_strdup_printf("-nic user,id=qtest-bn0");
     qtest_start(args);
     ret = g_test_run();
-- 
2.52.0


