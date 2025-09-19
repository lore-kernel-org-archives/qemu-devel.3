Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F65DCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZds-0001ly-Ed; Fri, 19 Sep 2025 07:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZdr-0001l2-5F
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZdi-0000mT-ET
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdRoEwCHMx+zjgwRt6dMBJqTTFrggUWD628P7VP28VY=;
 b=YiXyl5LK1tOfFqE9IVloRk+rF0Yb3JdJjFKe33N91qQzEO/NZKnDbBVe5KgmfUsLEe+NdR
 8MnPDTRBT6vZqI3ussv8lu9nvESLBOEsid6lz5yeRQRlLHOIBj0LwUuibCLi0z+wcB1Q1c
 YtKQu+ligb6EBhmrTwbWhGO1aSgJyiE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-FF262A2ENbOqTtDaVXgaPg-1; Fri,
 19 Sep 2025 07:50:52 -0400
X-MC-Unique: FF262A2ENbOqTtDaVXgaPg-1
X-Mimecast-MFC-AGG-ID: FF262A2ENbOqTtDaVXgaPg_1758282650
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39B5819560A1; Fri, 19 Sep 2025 11:50:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF2A01953944; Fri, 19 Sep 2025 11:50:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 02/16] migration/qemu-file: don't make incoming fds blocking
 again
Date: Fri, 19 Sep 2025 12:50:03 +0100
Message-ID: <20250919115017.1536203-3-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

In migration we want to pass fd "as is", not changing its
blocking status.

The only current user of these fds is CPR state (through VMSTATE_FD),
which of-course doesn't want to modify fds on target when source is
still running and use these fds.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.50.1


