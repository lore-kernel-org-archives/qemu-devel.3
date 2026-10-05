Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43690CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhRN-00051j-2K; Mon, 05 Oct 2026 08:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhQz-00050Q-7k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhQx-0003n3-JU
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791201881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yYwHnlmZYlzCh5qkAjnXvYra3zgQiPztuA5d2BgTr88=;
 b=Ig8BmwbYLyhg3j+ruV4UmxUEqrO5kFvwVev2WXQVamFZ6w3qRlnSQTvabkPdeTPZzdcA3Z
 pX53JdR+BQU8fVTJKEWEG4irYycsS/zKMPyX8+4oFKyEV5Yt86kp/OE+HINqt04Mm7rcqI
 Ny3+m4EnpTw9Zkd0zkVcj9VvLPr4SS8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-SnZnFbTMMdiJyNwL4cyE6g-1; Mon,
 05 Oct 2026 08:04:38 -0400
X-MC-Unique: SnZnFbTMMdiJyNwL4cyE6g-1
X-Mimecast-MFC-AGG-ID: SnZnFbTMMdiJyNwL4cyE6g_1791201877
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECE8F1800677; Mon,  5 Oct 2026 12:04:36 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 969661800581; Mon,  5 Oct 2026 12:04:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] qtest: fail fast when QEMU terminates early
Date: Mon,  5 Oct 2026 13:04:34 +0100
Message-ID: <20261005120434.413891-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If QEMU fails to start, or crashes early, before libqtest has opened
its qtest and QMP sockets, we'll get into an 'accept()' call with a
50 second timeout waiting for a connection that the zombie QEMU
process will never initiate.

Use a short 250ms timeout with accept(), but loop 200 times instead,
checking whether the process is alive on each iteration. With this
qtest detects dead QEMU immediately.

socket_accept is renamed to qtest_socket_accept to reflect that it
now requires QTestState.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 45 ++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 05d88476154..9e7a2d43a18 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -44,13 +44,14 @@
 
 #define MAX_IRQ 256
 
+#define ACCEPT_TIMEOUT_MS 250
+#define ACCEPT_RETRIES (4 * 50)
+
 #ifndef _WIN32
-# define SOCKET_TIMEOUT 50
 # define CMD_EXEC   "exec "
 # define DEV_STDERR "/dev/fd/2"
 # define DEV_NULL   "/dev/null"
 #else
-# define SOCKET_TIMEOUT 50000
 # define CMD_EXEC   ""
 # define DEV_STDERR "2"
 # define DEV_NULL   "nul"
@@ -116,20 +117,17 @@ static int init_socket(const char *socket_path)
     return sock;
 }
 
-static int socket_accept(int sock)
+static int qtest_socket_accept(QTestState *s, int sock)
 {
     struct sockaddr_un addr;
     socklen_t addrlen;
     int ret;
-    /*
-     * timeout unit of blocking receive calls is different among platforms.
-     * It's in seconds on non-Windows platforms but milliseconds on Windows.
-     */
+    size_t i;
 #ifndef _WIN32
-    struct timeval timeout = { .tv_sec = SOCKET_TIMEOUT,
-                               .tv_usec = 0 };
+    struct timeval timeout = { .tv_sec = 0,
+                               .tv_usec = ACCEPT_TIMEOUT_MS * 1000ul };
 #else
-    DWORD timeout = SOCKET_TIMEOUT;
+    DWORD timeout = ACCEPT_TIMEOUT_MS;
 #endif
 
     if (setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO,
@@ -140,13 +138,26 @@ static int socket_accept(int sock)
         return -1;
     }
 
-    do {
+    for (i = 0; i < ACCEPT_RETRIES ; i++) {
+        if (!qtest_probe_child(s)) {
+            fprintf(stderr,
+                    "child process unexpectedly exited, skipping socket accept\n");
+            goto cleanup;
+        }
+
         addrlen = sizeof(addr);
         ret = accept(sock, (struct sockaddr *)&addr, &addrlen);
-    } while (ret == -1 && errno == EINTR);
-    if (ret == -1) {
-        fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+        if (ret == -1) {
+            if (errno == EINTR || errno == EAGAIN) {
+                continue;
+            } else {
+                fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+            }
+        }
+        return ret;
     }
+
+ cleanup:
     close(sock);
 
     return ret;
@@ -549,9 +560,9 @@ void qtest_connect(QTestState *s)
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
 
     g_assert(s->sock >= 0 && s->qmpsock >= 0);
-    s->fd = socket_accept(s->sock);
+    s->fd = qtest_socket_accept(s, s->sock);
     if (s->fd >= 0) {
-        s->qmp_fd = socket_accept(s->qmpsock);
+        s->qmp_fd = qtest_socket_accept(s, s->qmpsock);
     }
     unlink(socket_path);
     unlink(qmp_socket_path);
@@ -663,7 +674,7 @@ QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
     qts = qtest_initf("-chardev socket,id=s0,path=%s -serial chardev:s0 %s",
                       sock_path, extra_args);
 
-    *sock_fd = socket_accept(sock_fd_init);
+    *sock_fd = qtest_socket_accept(qts, sock_fd_init);
 
     unlink(sock_path);
     g_free(sock_path);
-- 
2.55.0


