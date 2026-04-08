Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F710F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQc-0005eV-Mv; Wed, 08 Apr 2026 15:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAY0D-00052P-CZ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:51:50 -0400
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHKC-0001QR-BY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610198; x=1775869398;
 bh=J70lQstTQVknvHfsteZTD4+60wiGyrWRUrFeYvP4YI4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=P8rff3h9TLnKNXgb+i4vcE0NHGJw66dj8YBJTTk4qKDh0rQhHn4d3UudzUU//SqTl
 /ZoFeDWpEV1xAuTSt1e6Pzpy5uVocFmS3REo1KRfN2kd6NuesPVW9zR9xv/WQGLiqT
 Vj72lcscCoI9waT0xZs1zOJVcoMphK/fT95pVJVBxIUMqf2DUKN9VPQkivFHeMe4Ve
 6TJa92gMdDXpk4Bg4wFZXB46+9Q2/WREgkySfFbRuzx1geWbkFQZdnMNqF8eDna2rN
 NNU0gtU/GPWPmp2niLQSWW8oNfMoJxgbKF86lfE05XmYxOdeQbCygjkMNNt9Y0scZK
 TVbjQSkQO3+cg==
Date: Wed, 08 Apr 2026 01:03:15 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, marcandre.lureau@redhat.com
Subject: [PATCH 8/8] ui: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-9-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 5b7bbd041a4983705a8acf8250fc87a54828c37d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.18; envelope-from=matt@matthewpenney.net;
 helo=mail-4318.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 ui/dbus-clipboard.c    |  6 ++----
 ui/input-barrier.c     |  5 +----
 ui/vnc-auth-sasl.c     |  4 +---
 ui/vnc-auth-vencrypt.c |  9 ++-------
 ui/vnc-ws.c            | 18 ++++--------------
 5 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 935b6b1a2a..90318384ee 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -80,8 +80,7 @@ dbus_clipboard_update_info(DBusDisplay *dpy, QemuClipboar=
dInfo *info)
     if (req->invocation && info->types[req->type].data) {
         dbus_clipboard_complete_request(dpy, req->invocation, info, req->t=
ype);
         g_clear_object(&req->invocation);
-        g_source_remove(req->timeout_id);
-        req->timeout_id =3D 0;
+        g_clear_handle_id(&req->timeout_id, g_source_remove);
         return;
     }
=20
@@ -183,8 +182,7 @@ dbus_clipboard_request_cancelled(DBusClipboardRequest *=
req)
         "Cancelled clipboard request");
=20
     g_clear_object(&req->invocation);
-    g_source_remove(req->timeout_id);
-    req->timeout_id =3D 0;
+    g_clear_handle_id(&req->timeout_id, g_source_remove);
 }
=20
 static void
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 0a2198ca50..711ad81b34 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -519,10 +519,7 @@ static void input_barrier_instance_finalize(Object *ob=
j)
 {
     InputBarrier *ib =3D INPUT_BARRIER(obj);
=20
-    if (ib->ioc_tag) {
-        g_source_remove(ib->ioc_tag);
-        ib->ioc_tag =3D 0;
-    }
+    g_clear_handle_id(&ib->ioc_tag, g_source_remove);
=20
     if (ib->sioc) {
         qio_channel_close(QIO_CHANNEL(ib->sioc), NULL);
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 3f4cfc471d..ac68a507ae 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -127,9 +127,7 @@ size_t vnc_client_write_sasl(VncState *vs)
      * SASL encoded output
      */
     if (vs->output.offset =3D=3D 0) {
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag =3D qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
             vnc_client_io, vs, NULL);
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index d9c212ff32..0b4be384b9 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -75,9 +75,7 @@ static void vnc_tls_handshake_done(QIOTask *task,
         vnc_client_error(vs);
         error_free(err);
     } else {
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag =3D qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_OUT,
             vnc_client_io, vs, NULL);
@@ -102,10 +100,7 @@ static int protocol_client_vencrypt_auth(VncState *vs,=
 uint8_t *data, size_t len
         vnc_write_u8(vs, 1); /* Accept auth */
         vnc_flush(vs);
=20
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-            vs->ioc_tag =3D 0;
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
=20
         tls =3D qio_channel_tls_new_server(
             vs->ioc,
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 9e3503d93d..e072c1b3fa 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -37,9 +37,7 @@ static void vncws_tls_handshake_done(QIOTask *task,
         error_free(err);
     } else {
         VNC_DEBUG("TLS handshake complete, starting websocket handshake\n"=
);
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag =3D qio_channel_add_watch(vs->ioc,
                                             G_IO_IN | G_IO_HUP | G_IO_ERR,
                                             vncws_handshake_io, vs, NULL);
@@ -55,10 +53,7 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_U=
NUSED,
     QIOChannelTLS *tls;
     Error *err =3D NULL;
=20
-    if (vs->ioc_tag) {
-        g_source_remove(vs->ioc_tag);
-        vs->ioc_tag =3D 0;
-    }
+    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
=20
     if (condition & (G_IO_HUP | G_IO_ERR)) {
         vnc_client_error(vs);
@@ -107,9 +102,7 @@ static void vncws_handshake_done(QIOTask *task,
     } else {
         VNC_DEBUG("Websock handshake complete, starting VNC protocol\n");
         vnc_start_protocol(vs);
-        if (vs->ioc_tag) {
-            g_source_remove(vs->ioc_tag);
-        }
+        g_clear_handle_id(&vs->ioc_tag, g_source_remove);
         vs->ioc_tag =3D qio_channel_add_watch(
             vs->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR,
             vnc_client_io, vs, NULL);
@@ -124,10 +117,7 @@ gboolean vncws_handshake_io(QIOChannel *ioc G_GNUC_UNU=
SED,
     VncState *vs =3D opaque;
     QIOChannelWebsock *wioc;
=20
-    if (vs->ioc_tag) {
-        g_source_remove(vs->ioc_tag);
-        vs->ioc_tag =3D 0;
-    }
+    g_clear_handle_id(&vs->ioc_tag, g_source_remove);
=20
     if (condition & (G_IO_HUP | G_IO_ERR)) {
         vnc_client_error(vs);
--=20
2.53.0



