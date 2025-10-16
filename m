Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112EDCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNY-0007QH-3z; Thu, 16 Oct 2025 07:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMw-00079U-5R; Thu, 16 Oct 2025 07:42:06 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMn-0003WC-7X; Thu, 16 Oct 2025 07:42:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C93BEC01DB;
 Thu, 16 Oct 2025 14:41:35 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-RYE1Ekdu; Thu, 16 Oct 2025 14:41:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614895;
 bh=EvwL8eyab7no1GJoMEbPxt58P+5KUvNjBpLEjfyiDkg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BcxDl4YTma2QtPqK/1IwlM1blnT5tiF4RQWapBzF0vU1RSdKAioQFmLBOlU2QE/cx
 s/N8LoCVcVosZN02pg9J7dtkZ2s28sR4m95uN6phvVCzHiGa2COQ1bp+VxSlwL0Xs3
 sm3vzGJ3kHz5hBhMoeq7Wfni7MlWv7m5WitY3u/I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 16/25] chardev: add .chr_get_client() handler
Date: Thu, 16 Oct 2025 14:40:53 +0300
Message-ID: <20251016114104.1384675-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A pair for .char_add_client(), to be used to support backend-transfer
migration of chardev attached to vhost-user-blk in following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-socket.c  | 7 +++++++
 chardev/char.c         | 6 ++++++
 include/chardev/char.h | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 0a5738c158..51bb9d0a2d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -929,6 +929,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
     return 0;
 }
 
+static int tcp_chr_get_client(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    return s->sioc->fd;
+}
 
 static int tcp_chr_add_client(Chardev *chr, int fd)
 {
@@ -1591,6 +1597,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->get_msgfds = tcp_get_msgfds;
     cc->set_msgfds = tcp_set_msgfds;
     cc->chr_add_client = tcp_chr_add_client;
+    cc->chr_get_client = tcp_chr_get_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
 
diff --git a/chardev/char.c b/chardev/char.c
index b68d44e394..3c2ed972f1 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -247,6 +247,12 @@ int qemu_chr_add_client(Chardev *s, int fd)
         CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
 
+int qemu_chr_get_client(Chardev *s)
+{
+    return CHARDEV_GET_CLASS(s)->chr_get_client ?
+        CHARDEV_GET_CLASS(s)->chr_get_client(s) : -1;
+}
+
 static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            const char *default_filename, Error **errp)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index d2e01f0f9c..671f64cb7e 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -216,6 +216,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
 void qemu_chr_be_event(Chardev *s, QEMUChrEvent event);
 
 int qemu_chr_add_client(Chardev *s, int fd);
+int qemu_chr_get_client(Chardev *s);
 Chardev *qemu_chr_find(const char *name);
 
 bool qemu_chr_has_feature(Chardev *chr,
@@ -316,6 +317,9 @@ struct ChardevClass {
     /* accept the given fd */
     int (*chr_add_client)(Chardev *chr, int fd);
 
+    /* get fd back */
+    int (*chr_get_client)(Chardev *chr);
+
     /* wait for a connection */
     int (*chr_wait_connected)(Chardev *chr, Error **errp);
 
-- 
2.48.1


