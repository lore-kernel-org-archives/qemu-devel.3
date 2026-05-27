Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2B9CD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7ZZ-00043a-Ml; Wed, 27 May 2026 02:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZK-0003vm-55
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:44 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZH-0003yt-9t
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F06DD8078A;
 Wed, 27 May 2026 09:16:37 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-Dw12idiD; Wed, 27 May 2026 09:16:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862597;
 bh=z7NzS2BOltO1smLgMQemP3Hs/WnVs4xBnAPGQOKC/zU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OE87RdNzfYMt4HtclF9NB7ln/2dTl70X/1sYxsBOvegxLI008c7C+zVhPB7y67O++
 pEvv8dbVEgND1A57rafg+nnB9GAvXVXjpyDoW71NoeqKaJOrN5iZV+e1FKD2U+9uFL
 vyCLyDJZe5thhmQYrgosaPMjZ7A/5I9xhfE+JV8Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v7 09/22] vhost-user: keep QIOChannelSocket for backend channel
Date: Wed, 27 May 2026 09:16:10 +0300
Message-ID: <20260527061625.11167-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
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

Keep QIOChannelSocket pointer instead of more generic
QIOChannel. No real difference for now, but it would
be simpler to migrate socket fd in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 68dd89cd8f8..31eaf65430e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -239,7 +239,7 @@ struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
     VhostUserState *user;
-    QIOChannel *backend_ioc;
+    QIOChannelSocket *backend_sioc;
     GSource *backend_src;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
@@ -1796,8 +1796,8 @@ static void close_backend_channel(struct vhost_user *u)
     g_source_destroy(u->backend_src);
     g_source_unref(u->backend_src);
     u->backend_src = NULL;
-    object_unref(OBJECT(u->backend_ioc));
-    u->backend_ioc = NULL;
+    object_unref(OBJECT(u->backend_sioc));
+    u->backend_sioc = NULL;
 }
 
 static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
@@ -1909,7 +1909,6 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
     bool reply_supported =
         vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     Error *local_err = NULL;
-    QIOChannel *ioc;
 
     if (!vhost_user_has_protocol_feature(
             dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
@@ -1922,15 +1921,15 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
         return -saved_errno;
     }
 
-    ioc = QIO_CHANNEL(qio_channel_socket_new_fd(sv[0], &local_err));
-    if (!ioc) {
+    u->backend_sioc = qio_channel_socket_new_fd(sv[0], &local_err);
+    if (!u->backend_sioc) {
         error_report_err(local_err);
         return -ECONNREFUSED;
     }
-    u->backend_ioc = ioc;
-    u->backend_src = qio_channel_add_watch_source(u->backend_ioc,
-                                                G_IO_IN | G_IO_HUP,
-                                                backend_read, dev, NULL, NULL);
+    u->backend_src = qio_channel_add_watch_source(QIO_CHANNEL(u->backend_sioc),
+                                                  G_IO_IN | G_IO_HUP,
+                                                  backend_read, dev,
+                                                  NULL, NULL);
 
     if (reply_supported) {
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
@@ -2350,7 +2349,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
         close(u->postcopy_fd.fd);
         u->postcopy_fd.handler = NULL;
     }
-    if (u->backend_ioc) {
+    if (u->backend_sioc) {
         close_backend_channel(u);
     }
     g_free(u->region_rb);
-- 
2.52.0


