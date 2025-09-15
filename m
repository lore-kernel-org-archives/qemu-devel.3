Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E69CAC59A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9AX-0001nN-GT; Mon, 15 Sep 2025 09:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AS-0001kR-GR; Mon, 15 Sep 2025 09:22:53 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AA-0006z8-As; Mon, 15 Sep 2025 09:22:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D7008807EE;
 Mon, 15 Sep 2025 16:22:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-mtwHgqNM; Mon, 15 Sep 2025 16:22:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942545;
 bh=kTPfJfNtj+B7eANPZYX4bCpuZQIRdjdV7XMIRrA/FeU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=A0yQ8TL1bK1GNZTbogsh4rG6AuhuDfJYLc4ZJwPe8uKLPeOA12a5O2u/f6jEy5mqF
 HgZGc3FITspXT3fFQA2EhiF0mIStt37VIniXqABp+w0zo4pMer0frm7ROpbxvBwLQK
 8TJ7ql8g0SRVl8Ep1GhQdVlIjAN198ezkFU81g3A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH v3 09/13] io/channel-socket: rework
 qio_channel_socket_copy_fds()
Date: Mon, 15 Sep 2025 16:22:06 +0300
Message-ID: <20250915132211.135095-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915132211.135095-1-vsementsov@yandex-team.ru>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We want to switch from qemu_socket_set_block() to newer
qemu_set_blocking(), which provides return status of operation,
to handle errors.

Still, we want to keep qio_channel_socket_readv() interface clean,
as currently it allocate @fds only on success.

So, in case of error, we should close all incoming fds and keep
user's @fds untouched or zero.

Let's make separate functions qio_channel_handle_fds() and
qio_channel_cleanup_fds(), to achieve what we want.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/io/channel.h |  8 +++---
 io/channel-socket.c  | 67 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 999a8f5f23..0f25ae0069 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -124,8 +124,8 @@ struct QIOChannelClass {
      * incoming fds are set BLOCKING (unless
      * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag is set) and
      * CLOEXEC (if available).
-     * @fds and @nfds are set only on success path, and untouched
-     * in case of errors.
+     * @fds and @nfds are set only on success path. Still, setting
+     * @fds and @nfds to zero is acceptable on failure path.
      */
     ssize_t (*io_readv)(QIOChannel *ioc,
                         const struct iovec *iov,
@@ -246,8 +246,8 @@ void qio_channel_set_name(QIOChannel *ioc,
  * to call close() on each file descriptor and to
  * call g_free() on the array pointer in @fds.
  * @fds allocated and set (and @nfds is set too)
- * _only_ on success path. These parameters are
- * untouched in case of errors.
+ * _only_ on success path. Still, @fds and @nfds
+ * may be set to zero on failure path.
  * qio_channel_readv_full() guarantees that all
  * incoming fds are set BLOCKING (unless
  * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
diff --git a/io/channel-socket.c b/io/channel-socket.c
index f7e3cb9742..e53d9ac76f 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -464,8 +464,7 @@ static void qio_channel_socket_finalize(Object *obj)
 
 #ifndef WIN32
 static void qio_channel_socket_copy_fds(struct msghdr *msg,
-                                        int **fds, size_t *nfds,
-                                        bool preserve_blocking)
+                                        int **fds, size_t *nfds)
 {
     struct cmsghdr *cmsg;
 
@@ -473,7 +472,7 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
     *fds = NULL;
 
     for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
-        int fd_size, i;
+        int fd_size;
         int gotfds;
 
         if (cmsg->cmsg_len < CMSG_LEN(sizeof(int)) ||
@@ -491,24 +490,53 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
         gotfds = fd_size / sizeof(int);
         *fds = g_renew(int, *fds, *nfds + gotfds);
         memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
+        *nfds += gotfds;
+    }
+}
 
-        for (i = 0; i < gotfds; i++) {
-            int fd = (*fds)[*nfds + i];
-            if (fd < 0) {
-                continue;
-            }
+static bool qio_channel_handle_fds(int *fds, size_t nfds,
+                                   bool preserve_blocking, Error **errp)
+{
+    int *end = fds + nfds, *fd;
+
+#ifdef MSG_CMSG_CLOEXEC
+    if (preserve_blocking) {
+        /* Nothing to do */
+        return true;
+    }
+#endif
 
-            if (!preserve_blocking) {
-                /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-                qemu_socket_set_block(fd);
+    for (fd = fds; fd != end; fd++) {
+        if (*fd < 0) {
+            continue;
+        }
+
+        if (!preserve_blocking) {
+            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
+            if (!qemu_set_blocking(*fd, true, errp)) {
+                return false;
             }
+        }
 
 #ifndef MSG_CMSG_CLOEXEC
-            qemu_set_cloexec(fd);
+        qemu_set_cloexec(*fd);
 #endif
+    }
+
+    return true;
+}
+
+static void qio_channel_cleanup_fds(int **fds, size_t *nfds)
+{
+    for (size_t i = 0; i < *nfds; i++) {
+        if ((*fds)[i] < 0) {
+            continue;
         }
-        *nfds += gotfds;
+        close((*fds)[i]);
     }
+
+    g_clear_pointer(fds, g_free);
+    *nfds = 0;
 }
 
 
@@ -559,9 +587,16 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(
-            &msg, fds, nfds,
-            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING);
+        bool preserve_blocking =
+            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING;
+
+        qio_channel_socket_copy_fds(&msg, fds, nfds);
+
+        if (!qio_channel_handle_fds(*fds, *nfds,
+                                    preserve_blocking, errp)) {
+            qio_channel_cleanup_fds(fds, nfds);
+            return -1;
+        }
     }
 
     return ret;
-- 
2.48.1


