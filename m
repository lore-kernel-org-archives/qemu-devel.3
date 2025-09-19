Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqf-0005l0-TO; Fri, 19 Sep 2025 05:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqW-0005eh-IW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:06 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqQ-0004Z3-JE
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B643C80ECB;
 Fri, 19 Sep 2025 12:55:51 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-5g2G55JV; Fri, 19 Sep 2025 12:55:51 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275751;
 bh=VnjjGEpdrx+Fz6XfH6ULYBNOdX6UQVMGJsU+DGOMTo8=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=0zQn9gXdpoykszQEZvpTtOhRkJbXvdptdslz0BhK+kdVOtlLLW79SsGPzapsuqJGJ
 jwTR0kYdKmwiID5TnDvLqhujPW48VlHTa/budoqZCaZuEiQZr5RhL9ZggmenMr7kND
 x7m0+rOQPwVM9Z07TstGXgXXSuLcJS6qiARoMBDI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 01/19] migration/qemu-file: don't make incoming fds
 blocking again
Date: Fri, 19 Sep 2025 12:55:27 +0300
Message-ID: <20250919095545.1912042-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

In migration we want to pass fd "as is", not changing its
blocking status.

The only current user of these fds is CPR state (through VMSTATE_FD),
which of-course doesn't want to modify fds on target when source is
still running and use these fds.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel.h  |  1 +
 io/channel-socket.c   | 13 +++++++++----
 migration/qemu-file.c |  3 ++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 234e5db70d..12266256a8 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -36,6 +36,7 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 
 #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
 #define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
+#define QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING 0x4
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff..21f8f2e0c5 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -464,7 +464,8 @@ static void qio_channel_socket_finalize(Object *obj)
 
 #ifndef WIN32
 static void qio_channel_socket_copy_fds(struct msghdr *msg,
-                                        int **fds, size_t *nfds)
+                                        int **fds, size_t *nfds,
+                                        bool preserve_blocking)
 {
     struct cmsghdr *cmsg;
 
@@ -497,8 +498,10 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
                 continue;
             }
 
-            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            qemu_socket_set_block(fd);
+            if (!preserve_blocking) {
+                /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
+                qemu_socket_set_block(fd);
+            }
 
 #ifndef MSG_CMSG_CLOEXEC
             qemu_set_cloexec(fd);
@@ -556,7 +559,9 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(&msg, fds, nfds);
+        qio_channel_socket_copy_fds(
+            &msg, fds, nfds,
+            flags & QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING);
     }
 
     return ret;
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034..d5c6e7ec61 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -340,7 +340,8 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
 
     do {
         struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
-        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
+        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd,
+                                     QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING,
                                      &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
-- 
2.48.1


