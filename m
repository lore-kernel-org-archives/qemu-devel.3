Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C785C2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 07:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcIwf-00086Z-ED; Sun, 04 Jan 2026 02:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwd-00085r-4T
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vcIwb-0002K5-Kf
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 02:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767513273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYi2AdeJkUKmYKXNm64FjtkWNNMfAqqSRdIJknViB7Q=;
 b=XZe9AFV7CbeR3s5I+8FgkEOk7C8hbKmjf8xThbg7+ga8uWd/iTweIO21SXdL06VfoJpfmh
 or50R4NFCp37ssvNQ+2gKJsIlvjWjBSEMInIbQEooOZTiavGDFEFI8ha1I7J+ZaSB5X+0d
 QoL0XcqjQk7Ep7aRWoXrHJ2kPd76VRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-mWSuyD5RPpa7mxX-oXFjDA-1; Sun,
 04 Jan 2026 02:54:29 -0500
X-MC-Unique: mWSuyD5RPpa7mxX-oXFjDA-1
X-Mimecast-MFC-AGG-ID: mWSuyD5RPpa7mxX-oXFjDA_1767513268
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABD18180035A; Sun,  4 Jan 2026 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF862180044F; Sun,  4 Jan 2026 07:54:25 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: zhangckid@gmail.com, lizhijian@fujitsu.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: lulu@redhat.com
Subject: [PATCH 3/3] tests/qtest: Add test for filter-redirector rx event
 opened
Date: Sun,  4 Jan 2026 15:54:12 +0800
Message-ID: <20260104075412.1262-4-jasowang@redhat.com>
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

Add a new test case 'test_redirector_rx_event_opened' to verify the
handling of the CHR_EVENT_OPENED event in filter-redirector.

The test simulates a scenario where the backend character device (socket)
is disconnected and then reconnected. It works by:
1. Connecting to the redirector's socket (triggers CHR_EVENT_OPENED).
2. Sending a packet to verify initial connectivity.
3. Disconnecting (triggers CHR_EVENT_CLOSED).
4. Reconnecting (triggers CHR_EVENT_OPENED again).
5. Sending another packet to verify that the redirector correctly
   re-registers its handlers and resumes passing traffic.

This ensures that the filter-redirector can recover and function correctly
after a backend reconnection.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/qtest/test-filter-redirector.c | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index da0c126314..5540c232c0 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -385,6 +385,100 @@ static void test_redirector_init_status_off(void)
     qtest_quit(qts);
 }
 
+static void test_redirector_rx_event_opened(void)
+{
+    int backend_sock[2], send_sock;
+    uint32_t ret = 0, len = 0;
+    char send_buf[] = "Hello!!";
+    char send_buf2[] = "Hello2!!";
+    char sock_path0[] = "filter-redirector0.XXXXXX";
+    char *recv_buf;
+    uint32_t size = sizeof(send_buf);
+    uint32_t size2 = sizeof(send_buf2);
+    size = htonl(size);
+    size2 = htonl(size2);
+    QTestState *qts;
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
+    g_assert_cmpint(ret, !=, -1);
+
+    ret = mkstemp(sock_path0);
+    g_assert_cmpint(ret, !=, -1);
+
+    qts = qtest_initf(
+        "-nic socket,id=qtest-bn0,fd=%d "
+        "-chardev socket,id=redirector0,path=%s,server=on,wait=off "
+        "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
+        "queue=rx,indev=redirector0 ",
+        backend_sock[1], sock_path0);
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
+    struct iovec iov2[] = {
+        {
+            .iov_base = &size2,
+            .iov_len = sizeof(size2),
+        }, {
+            .iov_base = send_buf2,
+            .iov_len = sizeof(send_buf2),
+        },
+    };
+
+    /* First connection */
+    send_sock = unix_connect(sock_path0, NULL);
+    g_assert_cmpint(send_sock, !=, -1);
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
+    g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
+
+    ret = recv(backend_sock[0], &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==, sizeof(len));
+    len = ntohl(len);
+    g_assert_cmpint(len, ==, sizeof(send_buf));
+    recv_buf = g_malloc(len);
+    ret = recv(backend_sock[0], recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
+    g_assert_cmpstr(recv_buf, ==, send_buf);
+    g_free(recv_buf);
+
+    close(send_sock);
+
+    /* Verify disconnection handling if needed, but mainly we want to test Reconnection */
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    /* Second connection */
+    send_sock = unix_connect(sock_path0, NULL);
+    g_assert_cmpint(send_sock, !=, -1);
+    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
+
+    ret = iov_send(send_sock, iov2, 2, 0, sizeof(size2) + sizeof(send_buf2));
+    g_assert_cmpint(ret, ==, sizeof(send_buf2) + sizeof(size2));
+
+    ret = recv(backend_sock[0], &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==, sizeof(len));
+    len = ntohl(len);
+    g_assert_cmpint(len, ==, sizeof(send_buf2));
+    recv_buf = g_malloc(len);
+    ret = recv(backend_sock[0], recv_buf, len, 0);
+    g_assert_cmpint(ret, ==, len);
+    g_assert_cmpstr(recv_buf, ==, send_buf2);
+    g_free(recv_buf);
+
+    close(send_sock);
+    unlink(sock_path0);
+    qtest_quit(qts);
+    close(backend_sock[0]);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -393,5 +487,7 @@ int main(int argc, char **argv)
     qtest_add_func("/netfilter/redirector_status", test_redirector_status);
     qtest_add_func("/netfilter/redirector_init_status_off",
                    test_redirector_init_status_off);
+    qtest_add_func("/netfilter/redirector_rx_event_opened",
+                   test_redirector_rx_event_opened);
     return g_test_run();
 }
-- 
2.34.1


