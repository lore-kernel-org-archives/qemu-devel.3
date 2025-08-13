Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D422CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg9-0003Bh-IW; Wed, 13 Aug 2025 12:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfo-0002q3-JE; Wed, 13 Aug 2025 12:50:00 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfk-0007tP-77; Wed, 13 Aug 2025 12:50:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9CAD381397;
 Wed, 13 Aug 2025 19:49:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-6QpLxnRE; Wed, 13 Aug 2025 19:49:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103763;
 bh=xvfsbTtoNa6txz9pDWOU7s8gMBMfz7afPsycmey1QP0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Pb7sGPsu/zEU/ogwFSulZ6rY7olIH3GJgwgVbQbSJDI0UoS2AkpWB5aGvmFpssdsc
 iE418Gx98MF3egceYMLuarQNjfcVj+u1DC5aafzWVDkPblDddFSx72lrl05ijpsBy7
 DwYMhg3W34mLXJo5MiybgrsGD7KnSLXHVx5CBLWw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
Date: Wed, 13 Aug 2025 19:48:47 +0300
Message-ID: <20250813164856.950363-27-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a possibility to keep socket non-block status when passing
through qio channel. We need this to support migration of open
fds through migration channel.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/io/channel-socket.h |  3 +++
 io/channel-socket.c         | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a88cf8b3a9..0a4327d745 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool keep_nonblock;
 };
 
 
@@ -275,4 +276,6 @@ int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
                                        size_t size,
                                        Error **errp);
 
+void qio_channel_socket_keep_nonblock(QIOChannel *ioc);
+
 #endif /* QIO_CHANNEL_SOCKET_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3b7ca924ff..cd93d7f180 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -462,9 +462,16 @@ static void qio_channel_socket_finalize(Object *obj)
 }
 
 
+void qio_channel_socket_keep_nonblock(QIOChannel *ioc)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    sioc->keep_nonblock = true;
+}
+
+
 #ifndef WIN32
 static void qio_channel_socket_copy_fds(struct msghdr *msg,
-                                        int **fds, size_t *nfds)
+                                        int **fds, size_t *nfds, bool set_block)
 {
     struct cmsghdr *cmsg;
 
@@ -497,8 +504,9 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
                 continue;
             }
 
-            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            qemu_socket_set_block(fd);
+            if (set_block) {
+                qemu_socket_set_block(fd);
+            }
 
 #ifndef MSG_CMSG_CLOEXEC
             qemu_set_cloexec(fd);
@@ -556,7 +564,7 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
     }
 
     if (fds && nfds) {
-        qio_channel_socket_copy_fds(&msg, fds, nfds);
+        qio_channel_socket_copy_fds(&msg, fds, nfds, !sioc->keep_nonblock);
     }
 
     return ret;
-- 
2.48.1


