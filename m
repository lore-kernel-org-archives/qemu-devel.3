Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A719710F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXeX-00051l-Of; Wed, 08 Apr 2026 14:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAXeM-00051J-Ql
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:29:16 -0400
Received: from mail-0701.mail-europe.com ([51.83.17.38]
 helo=mail-07.mail-europe.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHJT-0001Ms-5r
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610151; x=1775869351;
 bh=9F4Xx4c3jF43Xnw6KAruoShQx+2+40qZvkXLmvmeME0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SD35viJHgfZohqTk1zpN4hHHqA0ZRIFRRzHioXDAPxT5IFe3muPzgDR11PK4OxgDR
 hXiWkXGfP/1EF50GhyGh20P4HlvqHeiNlkyQQsixnDjaeivjrFg1y3Gm8xhEAeSE8j
 69ZQJqoFe04JXFmR2HI0kEhz1gz1NmAV0EfM18iRf0Xm2h04L/3RkctQxCje+bNf44
 BkN3ippjiPM4IQPhDVRwBoPLR8wWh9QoHaaMmV11p9LqB3mTMh7TWhkRtmwALh2I60
 JWpaEIjvtBkbgG9OZrztsxJg2pnXVzQ7sZxWYyph4tmBkIgfQH9QGUxl3lwtEX/270
 yFQ7pHv6H/bBA==
Date: Wed, 08 Apr 2026 01:02:28 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, jasowang@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, sgarzare@redhat.com
Subject: [PATCH 4/8] net: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-5-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 071cba2470b64e0fd5634307ed693e55c0147b63
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=51.83.17.38;
 envelope-from=matt@matthewpenney.net; helo=mail-07.mail-europe.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Use g_clear_handle_id() instead of g_source_remove() with manual ID
checking and zeroing.

This simplifies the code and ensures consistent handling of GSource IDs,
since g_clear_handle_id() checks for a non-zero ID before calling the
cleanup function and zeros it afterwards.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 net/passt.c       |  8 ++------
 net/stream.c      | 15 +++------------
 net/stream_data.c | 10 ++--------
 net/vhost-user.c  |  8 ++------
 4 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 4ff94ee509..d3b5ab426c 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -90,10 +90,7 @@ static void net_passt_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net =3D NULL;
     }
-    if (s->vhost_watch) {
-        g_source_remove(s->vhost_watch);
-        s->vhost_watch =3D 0;
-    }
+    g_clear_handle_id(&s->vhost_watch, g_source_remove);
     qemu_chr_fe_deinit(&s->vhost_chr, true);
     if (s->vhost_user) {
         vhost_user_cleanup(s->vhost_user);
@@ -421,8 +418,7 @@ static void passt_vhost_user_event(void *opaque, QEMUCh=
rEvent event)
         if (s->vhost_watch) {
             AioContext *ctx =3D qemu_get_current_aio_context();
=20
-            g_source_remove(s->vhost_watch);
-            s->vhost_watch =3D 0;
+            g_clear_handle_id(&s->vhost_watch, g_source_remove);
             qemu_chr_fe_set_handlers(&s->vhost_chr, NULL, NULL,  NULL, NUL=
L,
                                      NULL, NULL, false);
=20
diff --git a/net/stream.c b/net/stream.c
index ea83f4a763..6df4e251fe 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -71,24 +71,15 @@ static gboolean net_stream_send(QIOChannel *ioc,
 static void net_stream_cleanup(NetClientState *nc)
 {
     NetStreamState *s =3D DO_UPCAST(NetStreamState, data.nc, nc);
-    if (s->timer_tag) {
-        g_source_remove(s->timer_tag);
-        s->timer_tag =3D 0;
-    }
+    g_clear_handle_id(&s->timer_tag, g_source_remove);
     if (s->addr) {
         qapi_free_SocketAddress(s->addr);
         s->addr =3D NULL;
     }
     if (s->data.ioc) {
         if (QIO_CHANNEL_SOCKET(s->data.ioc)->fd !=3D -1) {
-            if (s->data.ioc_read_tag) {
-                g_source_remove(s->data.ioc_read_tag);
-                s->data.ioc_read_tag =3D 0;
-            }
-            if (s->data.ioc_write_tag) {
-                g_source_remove(s->data.ioc_write_tag);
-                s->data.ioc_write_tag =3D 0;
-            }
+            g_clear_handle_id(&s->data.ioc_read_tag, g_source_remove);
+            g_clear_handle_id(&s->data.ioc_write_tag, g_source_remove);
         }
         object_unref(OBJECT(s->data.ioc));
         s->data.ioc =3D NULL;
diff --git a/net/stream_data.c b/net/stream_data.c
index 03740e9f73..eafc11041b 100644
--- a/net/stream_data.c
+++ b/net/stream_data.c
@@ -84,10 +84,7 @@ void net_stream_data_rs_finalize(SocketReadState *rs)
     if (qemu_send_packet_async(&d->nc, rs->buf,
                                rs->packet_len,
                                net_stream_data_send_completed) =3D=3D 0) {
-        if (d->ioc_read_tag) {
-            g_source_remove(d->ioc_read_tag);
-            d->ioc_read_tag =3D 0;
-        }
+        g_clear_handle_id(&d->ioc_read_tag, g_source_remove);
     }
 }
=20
@@ -108,10 +105,7 @@ gboolean net_stream_data_send(QIOChannel *ioc, GIOCond=
ition condition,
         /* end of connection */
     eoc:
         d->ioc_read_tag =3D 0;
-        if (d->ioc_write_tag) {
-            g_source_remove(d->ioc_write_tag);
-            d->ioc_write_tag =3D 0;
-        }
+        g_clear_handle_id(&d->ioc_write_tag, g_source_remove);
         if (d->listener) {
             qemu_set_info_str(&d->nc, "listening");
             qio_net_listener_set_client_func(d->listener,
diff --git a/net/vhost-user.c b/net/vhost-user.c
index a4bb49bbcf..2d0fc49b4d 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -215,10 +215,7 @@ static void net_vhost_user_cleanup(NetClientState *nc)
         s->vhost_net =3D NULL;
     }
     if (nc->queue_index =3D=3D 0) {
-        if (s->watch) {
-            g_source_remove(s->watch);
-            s->watch =3D 0;
-        }
+        g_clear_handle_id(&s->watch, g_source_remove);
         qemu_chr_fe_deinit(&s->chr, true);
         if (s->vhost_user) {
             vhost_user_cleanup(s->vhost_user);
@@ -356,8 +353,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrE=
vent event)
         if (s->watch) {
             AioContext *ctx =3D qemu_get_current_aio_context();
=20
-            g_source_remove(s->watch);
-            s->watch =3D 0;
+            g_clear_handle_id(&s->watch, g_source_remove);
             qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
                                      NULL, NULL, false);
=20
--=20
2.53.0



