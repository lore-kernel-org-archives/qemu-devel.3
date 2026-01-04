Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D235DC2A069
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 07:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcIwb-00085f-6q; Sun, 04 Jan 2026 02:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwZ-00085A-O6
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwY-0002JZ-1K
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767513269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkaPeokfe5utn6p03yAUV+zIHdrTJ9M5DCqbRBawJ3I=;
 b=PlWQy4b9aC/fG6Pug019TEPPDEWe5A6VKZ06cpXvzgZmy6Hkhv6WSOComum0wFJIyiQZvl
 x3rr0zcUYN5vu7RqDSsfLXK1qYuWOX22wBCEgdDjOmqu8DtnTsuHSxg1oNKFJG5i4G5P9f
 8wfEXf6ZUgPKisuX5uwiFvAWu5xfiSM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-XOeLbcXBOXetdo_xOVyxLA-1; Sun,
 04 Jan 2026 02:54:26 -0500
X-MC-Unique: XOeLbcXBOXetdo_xOVyxLA-1
X-Mimecast-MFC-AGG-ID: XOeLbcXBOXetdo_xOVyxLA_1767513265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 284F51956080; Sun,  4 Jan 2026 07:54:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83E1C180044F; Sun,  4 Jan 2026 07:54:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: zhangckid@gmail.com, lizhijian@fujitsu.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: lulu@redhat.com
Subject: [PATCH 2/3] qtest: add a test to test redirector status change
Date: Sun,  4 Jan 2026 15:54:11 +0800
Message-ID: <20260104075412.1262-3-jasowang@redhat.com>
In-Reply-To: <20260104075412.1262-1-jasowang@redhat.com>
References: <20260104075412.1262-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch adds a qtest to test the status change of
filter-redirector. Two subtests were added:

- test_redirector_status: tests dynamic on/off switching at runtime
  using qom-set QMP command

- test_redirector_init_status_off: tests creating filter-redirector
  with status=off from the start via command line

Both tests verify that:

1. When status is off, data from indev chardev is not received
2. When status is switched to on, data is received correctly

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/qtest/test-filter-redirector.c | 192 +++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index a996a80c1c..da0c126314 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -196,10 +196,202 @@ static void test_redirector_rx(void)
     qtest_quit(qts);
 }
 
+/*
+ * Test filter-redirector status on/off switching.
+ *
+ * This test verifies that:
+ * 1. When status is set to "off", the filter stops receiving data from indev
+ * 2. When status is set back to "on", the filter resumes receiving data
+ */
+static void test_redirector_status(void)
+{
+    int backend_sock[2], send_sock;
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
+     * Setup a simple rx path:
+     * chardev (sock_path0) -> filter-redirector -> socket backend
+     */
+    qts = qtest_initf(
+        "-nic socket,id=qtest-bn0,fd=%d "
+        "-chardev socket,id=redirector0,path=%s,server=on,wait=off "
+        "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
+        "queue=rx,indev=redirector0 ",
+        backend_sock[1], sock_path0);
+
+    send_sock = unix_connect(sock_path0, NULL);
+    g_assert_cmpint(send_sock, !=, -1);
+
+    /* send a qmp command to guarantee that 'connected' is setting to true. */
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
+     * Test 1: Set status to "off" and verify data is not received
+     */
+    qtest_qmp_assert_success(qts,
+        "{ 'execute': 'qom-set', 'arguments': "
+        "{ 'path': '/objects/qtest-f0', 'property': 'status', 'value': 'off' }}");
+
+    ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    /*
+     * Use select with timeout to check if data arrives.
+     * When status is off, no data should arrive.
+     */
+    FD_ZERO(&rfds);
+    FD_SET(backend_sock[0], &rfds);
+    tv.tv_sec = 0;
+    tv.tv_usec = 500000;  /* 500ms timeout */
+    ret = select(backend_sock[0] + 1, &rfds, NULL, NULL, &tv);
+    g_assert_cmpint(ret, ==, 0);  /* Should timeout, no data */
+
+    /*
+     * Test 2: Set status back to "on" and verify data is received
+     */
+    qtest_qmp_assert_success(qts,
+        "{ 'execute': 'qom-set', 'arguments': "
+        "{ 'path': '/objects/qtest-f0', 'property': 'status', 'value': 'on' }}");
+
+    ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    ret = recv(backend_sock[0], &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==, sizeof(len));
+    len = ntohl(len);
+
+    g_assert_cmpint(len, ==, sizeof(send_buf));
+    recv_buf = g_malloc(len);
+    ret = recv(backend_sock[0], recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
+    g_assert_cmpstr(recv_buf, ==, send_buf);
+
+    g_free(recv_buf);
+    close(send_sock);
+    unlink(sock_path0);
+    qtest_quit(qts);
+}
+
+/*
+ * Test filter-redirector created with status=off.
+ *
+ * This test verifies that when a filter-redirector is created with
+ * status=off, it does not receive data until status is set to on.
+ */
+static void test_redirector_init_status_off(void)
+{
+    int backend_sock[2], send_sock;
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
+     * Create filter-redirector with status=off from the start
+     */
+    qts = qtest_initf(
+        "-nic socket,id=qtest-bn0,fd=%d "
+        "-chardev socket,id=redirector0,path=%s,server=on,wait=off "
+        "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
+        "queue=rx,indev=redirector0,status=off ",
+        backend_sock[1], sock_path0);
+
+    send_sock = unix_connect(sock_path0, NULL);
+    g_assert_cmpint(send_sock, !=, -1);
+
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
+     * Test 1: Filter was created with status=off, data should not be received
+     */
+    ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    FD_ZERO(&rfds);
+    FD_SET(backend_sock[0], &rfds);
+    tv.tv_sec = 0;
+    tv.tv_usec = 500000;
+    ret = select(backend_sock[0] + 1, &rfds, NULL, NULL, &tv);
+    g_assert_cmpint(ret, ==, 0);  /* Should timeout, no data */
+
+    /*
+     * Test 2: Set status to "on" and verify data is received
+     */
+    qtest_qmp_assert_success(qts,
+        "{ 'execute': 'qom-set', 'arguments': "
+        "{ 'path': '/objects/qtest-f0', 'property': 'status', 'value': 'on' }}");
+
+    ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    ret = recv(backend_sock[0], &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==, sizeof(len));
+    len = ntohl(len);
+
+    g_assert_cmpint(len, ==, sizeof(send_buf));
+    recv_buf = g_malloc(len);
+    ret = recv(backend_sock[0], recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
+    g_assert_cmpstr(recv_buf, ==, send_buf);
+
+    g_free(recv_buf);
+    close(send_sock);
+    unlink(sock_path0);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/netfilter/redirector_tx", test_redirector_tx);
     qtest_add_func("/netfilter/redirector_rx", test_redirector_rx);
+    qtest_add_func("/netfilter/redirector_status", test_redirector_status);
+    qtest_add_func("/netfilter/redirector_init_status_off",
+                   test_redirector_init_status_off);
     return g_test_run();
 }
-- 
2.34.1


