Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B765DCA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdU9-0004Xr-2t; Thu, 11 Sep 2025 05:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdU1-0004TQ-ED; Thu, 11 Sep 2025 05:20:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwdTr-0008Sl-9t; Thu, 11 Sep 2025 05:20:47 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 79EFA80791;
 Thu, 11 Sep 2025 12:20:32 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QKHlUI0GnCg0-A34ccFL2; Thu, 11 Sep 2025 12:20:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757582432;
 bh=fanUIs8fJOnKRMuooB7Tk+fpTS+KTCho29G318A1q5o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KsWWAllYXopLWWoJfjWxjaPDldgGVZIW8tHPcknmnSxFqyBh+0m2GKVCQTqFeEZlT
 zUzJWhRrr4e5ZUIjjfppOOqEcJ8HJz60RrVtqoccemtFnExJNNb4ytVDzZgcJPsii/
 CVx9Hzw4iy3ia/xoggNi8HUzHxitcbWR6ccDSi0E=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH v2 6/8] io/channel-socket: rework qio_channel_socket_copy_fds()
Date: Thu, 11 Sep 2025 12:20:04 +0300
Message-ID: <20250911092007.1370002-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
as currently it set @fds and @nfds only on success.

So, in case of error, we should to close all incoming fds and don't
touch user's @fds and @nfds.

Let's make separate functions qio_channel_handle_fds() and
qio_channel_cleanup_fds(), to achieve what we want.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 io/channel-socket.c | 73 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index f7e3cb9742..afae97b2ef 100644
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
@@ -491,24 +490,54 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
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
+static void qio_channel_cleanup_fds(int *fds, size_t nfds)
+{
+    int *end = fds + nfds, *fd;
+
+    for (fd = fds; fd != end; fd++) {
+        if (*fd < 0) {
+            continue;
         }
-        *nfds += gotfds;
+        close(*fd);
     }
+
+    g_free(fds);
 }
 
 
@@ -559,9 +588,21 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(
-            &msg, fds, nfds,
-            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING);
+        int *local_fds;
+        size_t local_nfds;
+        bool preserve_blocking =
+            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING;
+
+        qio_channel_socket_copy_fds(&msg, &local_fds, &local_nfds);
+
+        if (!qio_channel_handle_fds(local_fds, local_nfds,
+                                    preserve_blocking, errp)) {
+            qio_channel_cleanup_fds(local_fds, local_nfds);
+            return -1;
+        }
+
+        *fds = local_fds;
+        *nfds = local_nfds;
     }
 
     return ret;
-- 
2.48.1


