Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5E7C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:24:14 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf2P-0001mk-2e; Fri, 07 Jun 2024 15:14:10 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf2A-00014z-Q5; Fri, 07 Jun 2024 15:13:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf28-0001op-S3; Fri, 07 Jun 2024 15:13:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 07E926E543;
 Fri,  7 Jun 2024 22:14:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2D620E2740;
 Fri,  7 Jun 2024 22:13:09 +0300 (MSK)
Received: (nullmailer pid 528709 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 27/45] qio: Inherit follow_coroutine_ctx across TLS
Date: Fri,  7 Jun 2024 22:12:46 +0300
Message-Id: <20240607191307.528622-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

Since qemu 8.2, the combination of NBD + TLS + iothread crashes on an
assertion failure:

qemu-kvm: ../io/channel.c:534: void qio_channel_restart_read(void *): Assertion `qemu_get_current_aio_context() == qemu_coroutine_get_aio_context(co)' failed.

It turns out that when we removed AioContext locking, we did so by
having NBD tell its qio channels that it wanted to opt in to
qio_channel_set_follow_coroutine_ctx(); but while we opted in on the
main channel, we did not opt in on the TLS wrapper channel.
qemu-iotests has coverage of NBD+iothread and NBD+TLS, but apparently
no coverage of NBD+TLS+iothread, or we would have noticed this
regression sooner.  (I'll add that in the next patch)

But while we could manually opt in to the TLS channel in nbd/server.c
(a one-line change), it is more generic if all qio channels that wrap
other channels inherit the follow status, in the same way that they
inherit feature bits.

CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Daniel P. Berrangé <berrange@redhat.com>
CC: qemu-stable@nongnu.org
Fixes: https://issues.redhat.com/browse/RHEL-34786
Fixes: 06e0f098 ("io: follow coroutine AioContext in qio_channel_yield()", v8.2.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240518025246.791593-5-eblake@redhat.com>
(cherry picked from commit 199e84de1c903ba5aa1f7256310bbc4a20dd930b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 58fe1aceee..a8ad89c3d1 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -69,37 +69,40 @@ qio_channel_tls_new_server(QIOChannel *master,
                            const char *aclname,
                            Error **errp)
 {
-    QIOChannelTLS *ioc;
+    QIOChannelTLS *tioc;
+    QIOChannel *ioc;
 
-    ioc = QIO_CHANNEL_TLS(object_new(TYPE_QIO_CHANNEL_TLS));
+    tioc = QIO_CHANNEL_TLS(object_new(TYPE_QIO_CHANNEL_TLS));
+    ioc = QIO_CHANNEL(tioc);
 
-    ioc->master = master;
+    tioc->master = master;
+    ioc->follow_coroutine_ctx = master->follow_coroutine_ctx;
     if (qio_channel_has_feature(master, QIO_CHANNEL_FEATURE_SHUTDOWN)) {
-        qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SHUTDOWN);
+        qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
     }
     object_ref(OBJECT(master));
 
-    ioc->session = qcrypto_tls_session_new(
+    tioc->session = qcrypto_tls_session_new(
         creds,
         NULL,
         aclname,
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
         errp);
-    if (!ioc->session) {
+    if (!tioc->session) {
         goto error;
     }
 
     qcrypto_tls_session_set_callbacks(
-        ioc->session,
+        tioc->session,
         qio_channel_tls_write_handler,
         qio_channel_tls_read_handler,
-        ioc);
+        tioc);
 
-    trace_qio_channel_tls_new_server(ioc, master, creds, aclname);
-    return ioc;
+    trace_qio_channel_tls_new_server(tioc, master, creds, aclname);
+    return tioc;
 
  error:
-    object_unref(OBJECT(ioc));
+    object_unref(OBJECT(tioc));
     return NULL;
 }
 
@@ -116,6 +119,7 @@ qio_channel_tls_new_client(QIOChannel *master,
     ioc = QIO_CHANNEL(tioc);
 
     tioc->master = master;
+    ioc->follow_coroutine_ctx = master->follow_coroutine_ctx;
     if (qio_channel_has_feature(master, QIO_CHANNEL_FEATURE_SHUTDOWN)) {
         qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
     }
diff --git a/io/channel-websock.c b/io/channel-websock.c
index a12acc27cf..de39f0d182 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -883,6 +883,7 @@ qio_channel_websock_new_server(QIOChannel *master)
     ioc = QIO_CHANNEL(wioc);
 
     wioc->master = master;
+    ioc->follow_coroutine_ctx = master->follow_coroutine_ctx;
     if (qio_channel_has_feature(master, QIO_CHANNEL_FEATURE_SHUTDOWN)) {
         qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
     }
-- 
2.39.2


