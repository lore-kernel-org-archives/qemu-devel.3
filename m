Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B5BE7AD41
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYfiZ-0000Oz-BT; Thu, 25 Dec 2025 02:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vYfiX-0000OY-Ib
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 02:25:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vYfiV-00044z-NO
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 02:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766647498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqzEb/OlKzWFuOPHtl5nQe1KZq7hJ3A6DPbM1Iun8VU=;
 b=aH3QQUDClkb/8pJVUnbQWNxBPiFWI5U8ZEAZqN0ODNkLfny/93x8tjGNqKtTFi5V8HIq1+
 i8BLSllntWS1We5y0le5dkHkqdvFbvi8RY7U9BOnp67eFe4DAq4K+xuw9abxSezroChuR2
 LNAPwAsl97cRcWir6rKuh4eZ/M8/bBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-p1huEk2gNcSbbckjnj9y6Q-1; Thu,
 25 Dec 2025 02:24:53 -0500
X-MC-Unique: p1huEk2gNcSbbckjnj9y6Q-1
X-Mimecast-MFC-AGG-ID: p1huEk2gNcSbbckjnj9y6Q_1766647492
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED3A71800378; Thu, 25 Dec 2025 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.107])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3499A18004D4; Thu, 25 Dec 2025 07:24:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	zhangckid@gmail.com,
	lizhijian@fujitsu.com
Cc: qemu-devel@nongnu.org,
	lulu@redhat.com
Subject: [PATCH 2/2] tests/qtest: add test for filter-buffer interval change
Date: Thu, 25 Dec 2025 15:24:42 +0800
Message-ID: <20251225072442.36012-2-jasowang@redhat.com>
In-Reply-To: <20251225072442.36012-1-jasowang@redhat.com>
References: <20251225072442.36012-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add test_change_interval_timer to verify that modifying the 'interval'
property of filter-buffer at runtime takes effect immediately.

The test uses socket backend and filter-redirector to verify timer behavior:
- Creates filter-buffer with a very long interval (1000 seconds)
- Sends a packet which gets buffered
- Advances virtual clock by 1 second, verifies packet is still buffered
- Changes interval to 1ms via qom-set (timer should be rescheduled)
- Advances virtual clock by 2ms, verifies packet is now released
- This proves the timer was rescheduled immediately when interval changed

The test uses filter-redirector to observe when packets are released
by filter-buffer, providing end-to-end verification of the timer
rescheduling behavior.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/qtest/meson.build          |   1 +
 tests/qtest/test-filter-buffer.c | 169 +++++++++++++++++++++++++++++++
 tests/qtest/test-netfilter.c     |   3 +
 3 files changed, 173 insertions(+)
 create mode 100644 tests/qtest/test-filter-buffer.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..ffa85ba984 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -46,6 +46,7 @@ qtests_cxl = \
 #        for the availability of the default NICs in the tests
 qtests_filter = \
   (get_option('default_devices') and slirp.found() ? ['test-netfilter'] : []) + \
+  (get_option('default_devices') and host_os != 'windows' ? ['test-filter-buffer'] : []) + \
   (get_option('default_devices') and host_os != 'windows' ? ['test-filter-mirror'] : []) + \
   (get_option('default_devices') and host_os != 'windows' ? ['test-filter-redirector'] : [])
 
diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filter-buffer.c
new file mode 100644
index 0000000000..441cbb975c
--- /dev/null
+++ b/tests/qtest/test-filter-buffer.c
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QTest testcase for filter-buffer
+ *
+ * Copyright (c) 2025 Red Hat, Inc.
+ * Author: Jason Wang <jasowang@redhat.com>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qobject/qdict.h"
+#include "qemu/iov.h"
+#include "qemu/sockets.h"
+
+/*
+ * Test that changing interval at runtime affects packet release timing.
+ *
+ * Traffic flow with filter-buffer and filter-redirector:
+ *
+ * test side                        | qemu side
+ *                                  |
+ * +--------+                       | +---------+
+ * |  send  +------------------------>| backend |
+ * | sock[0]|                       | +----+----+
+ * +--------+                       |      |
+ *                                  | +----v----+
+ *                                  | |  fbuf0  | filter-buffer (queue=tx)
+ *                                  | +----+----+
+ *                                  |      |
+ *                                  | +----v----+  +----------+
+ *                                  | |   rd0   +->| chardev0 |
+ *                                  | +---------+  +----+-----+
+ *                                  |                   |
+ * +--------+                       |                   |
+ * |  recv  |<--------------------------------------+
+ * |  sock  |                       |
+ * +--------+                       |
+ *
+ * The test verifies that when interval is changed via qom-set, the timer
+ * is rescheduled immediately, causing buffered packets to be released
+ * at the new interval rather than waiting for the old interval to elapse.
+ */
+static void test_change_interval_timer(void)
+{
+    QTestState *qts;
+    QDict *response;
+    int backend_sock[2], recv_sock;
+    int ret;
+    char send_buf[] = "Hello filter-buffer!";
+    char recv_buf[128];
+    char sock_path[] = "filter-buffer-test.XXXXXX";
+    uint32_t size = sizeof(send_buf);
+    uint32_t len;
+
+    size = htonl(size);
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    ret = mkstemp(sock_path);
+    g_assert_cmpint(ret, !=, -1);
+
+    /*
+     * Start QEMU with:
+     * - socket backend connected to our socketpair
+     * - filter-buffer with a very long interval (1000 seconds)
+     * - filter-redirector to send released packets to a chardev socket
+     *
+     * queue=tx intercepts packets going from backend to the guest,
+     * i.e., data we send from the test side.
+     */
+    qts = qtest_initf(
+        "-nic socket,id=qtest-bn0,fd=%d "
+        "-chardev socket,id=chardev0,path=%s,server=on,wait=off "
+        "-object filter-buffer,id=fbuf0,netdev=qtest-bn0,"
+        "queue=tx,interval=1000000000 "
+        "-object filter-redirector,id=rd0,netdev=qtest-bn0,"
+        "queue=tx,outdev=chardev0",
+        backend_sock[1], sock_path);
+
+    /* Connect to the chardev socket to receive redirected packets */
+    recv_sock = unix_connect(sock_path, NULL);
+    g_assert_cmpint(recv_sock, !=, -1);
+
+    /* Send a QMP command to ensure chardev connection is established */
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    /*
+     * Send a packet from the test side.
+     * It should be buffered by filter-buffer.
+     */
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
+    ret = iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    /*
+     * Advance virtual clock by 1 second (1,000,000,000 ns).
+     * This is much less than the 1000 second interval, so the packet
+     * should still be buffered.
+     */
+    qtest_clock_step(qts, 1000000000LL);
+
+    /* Try to receive with non-blocking - should fail (packet still buffered) */
+    ret = recv(recv_sock, recv_buf, sizeof(recv_buf), MSG_DONTWAIT);
+    g_assert_cmpint(ret, ==, -1);
+    g_assert(errno == EAGAIN || errno == EWOULDBLOCK);
+
+    /*
+     * Now change the interval to 1000 us (1ms) via qom-set.
+     * This should reschedule the timer to fire in 1ms from now.
+     */
+    response = qtest_qmp(qts,
+                         "{'execute': 'qom-set',"
+                         " 'arguments': {"
+                         "   'path': 'fbuf0',"
+                         "   'property': 'interval',"
+                         "   'value': 1000"
+                         "}}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    /*
+     * Advance virtual clock by 2ms (2,000,000 ns).
+     * This exceeds the new 1ms interval, so the timer should fire
+     * and release the buffered packet.
+     *
+     * If the interval change didn't take effect immediately, we would
+     * still be waiting for the original 1000 second interval to elapse,
+     * and the packet would not be released.
+     */
+    qtest_clock_step(qts, 2000000LL);
+
+    /*
+     * Now we should be able to receive the packet through the redirector.
+     * The packet was released by filter-buffer and sent to filter-redirector,
+     * which forwarded it to the chardev socket.
+     */
+    ret = recv(recv_sock, &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==, sizeof(len));
+    len = ntohl(len);
+    g_assert_cmpint(len, ==, sizeof(send_buf));
+
+    ret = recv(recv_sock, recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
+    g_assert_cmpstr(recv_buf, ==, send_buf);
+
+    close(recv_sock);
+    close(backend_sock[0]);
+    unlink(sock_path);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/netfilter/change_interval_timer",
+                   test_change_interval_timer);
+    return g_test_run();
+}
diff --git a/tests/qtest/test-netfilter.c b/tests/qtest/test-netfilter.c
index 326d4bd85f..b7271055d6 100644
--- a/tests/qtest/test-netfilter.c
+++ b/tests/qtest/test-netfilter.c
@@ -10,7 +10,10 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "libqtest.h"
 #include "qobject/qdict.h"
+#include "qemu/iov.h"
+#include "qemu/sockets.h"
 
 /* add a netfilter to a netdev and then remove it */
 static void add_one_netfilter(void)
-- 
2.34.1


