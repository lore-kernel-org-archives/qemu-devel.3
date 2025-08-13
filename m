Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF8FC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfq-0002rh-FD; Wed, 13 Aug 2025 12:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfH-0002dg-V3; Wed, 13 Aug 2025 12:49:29 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEf4-0007o1-2p; Wed, 13 Aug 2025 12:49:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E9C4980E6C;
 Wed, 13 Aug 2025 19:49:10 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-6cbQRs5F; Wed, 13 Aug 2025 19:49:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103750;
 bh=F7rCpmxVpR6c7FR7+mLk5bx9QDN1wAHijBrBI/wUa5A=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gDHRbkSQWx8MptULTFtrxsJ3x3Hl6vHar4m1lyw+4diRkUKu0osG5n2O4jl3b12cR
 kL6qtbc521gztJd3bbxpHoIHz7bgjjBuC85djS9Pw/BEb/jsFEkTtL1ueNfKTReSTK
 VALvGYKj2vjzkuiTzKGSqpTWlkS4dL6G46SVV9V8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 09/33] vhost-user: keep QIOChannelSocket for backend channel
Date: Wed, 13 Aug 2025 19:48:30 +0300
Message-ID: <20250813164856.950363-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Keep QIOChannelSocket pointer instead of more generic
QIOChannel. No real difference for now, but it would
be simpler to migrate socket fd in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 46f09f5988..fe9d91348d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -244,7 +244,7 @@ struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
     VhostUserState *user;
-    QIOChannel *backend_ioc;
+    QIOChannelSocket *backend_sioc;
     GSource *backend_src;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
@@ -1789,8 +1789,8 @@ static void close_backend_channel(struct vhost_user *u)
     g_source_destroy(u->backend_src);
     g_source_unref(u->backend_src);
     u->backend_src = NULL;
-    object_unref(OBJECT(u->backend_ioc));
-    u->backend_ioc = NULL;
+    object_unref(OBJECT(u->backend_sioc));
+    u->backend_sioc = NULL;
 }
 
 static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
@@ -1897,7 +1897,6 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
     bool reply_supported =
         vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     Error *local_err = NULL;
-    QIOChannel *ioc;
 
     if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
         return 0;
@@ -1909,15 +1908,15 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
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
@@ -2321,7 +2320,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
         close(u->postcopy_fd.fd);
         u->postcopy_fd.handler = NULL;
     }
-    if (u->backend_ioc) {
+    if (u->backend_sioc) {
         close_backend_channel(u);
     }
     g_free(u->region_rb);
-- 
2.48.1


