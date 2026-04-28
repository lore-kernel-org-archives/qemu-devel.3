Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C789FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdZr-00069h-SZ; Tue, 28 Apr 2026 04:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZq-000679-E0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdZo-00062A-P8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBBF7t1JGaQ+5NkzBMe2IvOwuHtbPA/oX7g06ftpQZY=;
 b=ghF490mASe8hENqzmZIlpPLx7jO29bjF7dljMscOtpM9CsRnGyhad8gNAHkQp/m7OkTpoR
 3Luh62XoAvr3/F2pZ2g8wHtW7DzL1z2mjFxoX8juoA6GrEVgAdNkdUrg3ZVQwjpJbepX0x
 5Q/uHXxttsqygpj+ZYHbvx1RrCJztzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480--TiiULULPFO0jEBIeQ57Ug-1; Tue,
 28 Apr 2026 04:13:50 -0400
X-MC-Unique: -TiiULULPFO0jEBIeQ57Ug-1
X-Mimecast-MFC-AGG-ID: -TiiULULPFO0jEBIeQ57Ug_1777364029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FD61800358; Tue, 28 Apr 2026 08:13:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 860E3196B8FB; Tue, 28 Apr 2026 08:13:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/15] ui/console: remove qemu_console_is_visible()
Date: Tue, 28 Apr 2026 12:12:54 +0400
Message-ID: <20260428081303.990973-8-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Drop the bookkeeping, we can simply afford an empty "foreach".

Notice that dpy_gfx_update_texture() is now called even when there are
no listeners. This is more correct, as the texture is not fully
refreshed when a listener connects, so it may be outdated/garbaged.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  1 -
 ui/console-priv.h    |  1 -
 ui/console.c         | 29 -----------------------------
 3 files changed, 31 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index e2e5ff76ec1..f04844263b9 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -399,7 +399,6 @@ QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
                                                 uint32_t head, Error **errp);
 QEMUCursor *qemu_console_get_cursor(QemuConsole *con);
-bool qemu_console_is_visible(QemuConsole *con);
 bool qemu_console_is_graphic(QemuConsole *con);
 bool qemu_console_is_fixedsize(QemuConsole *con);
 bool qemu_console_is_gl_blocked(QemuConsole *con);
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 39798c3e9d7..2299898984d 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -16,7 +16,6 @@ struct QemuConsole {
     DisplayState *ds;
     DisplaySurface *surface;
     DisplayScanout scanout;
-    int dcls;
     DisplayGLCtx *gl;
     int gl_block;
     QEMUTimer *gl_unblock_timer;
diff --git a/ui/console.c b/ui/console.c
index 8f65308958a..abb6cba2826 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -648,9 +648,6 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     dcl->ds = get_alloc_displaystate();
     QLIST_INSERT_HEAD(&dcl->ds->listeners, dcl, next);
     gui_setup_refresh(dcl->ds);
-    if (dcl->con) {
-        dcl->con->dcls++;
-    }
     displaychangelistener_display_console(dcl, &error_fatal);
     if (QEMU_IS_GRAPHIC_CONSOLE(dcl->con)) {
         dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(dcl->con));
@@ -678,9 +675,6 @@ void unregister_displaychangelistener(DisplayChangeListener *dcl)
     if (!ds) {
         return;
     }
-    if (dcl->con) {
-        dcl->con->dcls--;
-    }
     QLIST_REMOVE(dcl, next);
     dcl->ds = NULL;
     gui_setup_refresh(ds);
@@ -745,9 +739,6 @@ void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h)
     w = MIN(w, width - x);
     h = MIN(h, height - y);
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     dpy_gfx_update_texture(con, con->surface, x, y, w, h);
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
@@ -846,9 +837,6 @@ void dpy_text_cursor(QemuConsole *con, int x, int y)
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
             continue;
@@ -864,9 +852,6 @@ void dpy_text_update(QemuConsole *con, int x, int y, int w, int h)
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
             continue;
@@ -882,9 +867,6 @@ void dpy_text_resize(QemuConsole *con, int w, int h)
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
             continue;
@@ -904,9 +886,6 @@ void dpy_mouse_set(QemuConsole *c, int x, int y, bool on)
     con->cursor_x = x;
     con->cursor_y = y;
     con->cursor_on = on;
-    if (!qemu_console_is_visible(c)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (c != dcl->con) {
             continue;
@@ -925,9 +904,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
 
     cursor_unref(con->cursor);
     con->cursor = cursor_ref(cursor);
-    if (!qemu_console_is_visible(c)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (c != dcl->con) {
             continue;
@@ -1285,11 +1261,6 @@ QEMUCursor *qemu_console_get_cursor(QemuConsole *con)
     return QEMU_IS_GRAPHIC_CONSOLE(con) ? QEMU_GRAPHIC_CONSOLE(con)->cursor : NULL;
 }
 
-bool qemu_console_is_visible(QemuConsole *con)
-{
-    return con->dcls > 0;
-}
-
 bool qemu_console_is_graphic(QemuConsole *con)
 {
     return con && QEMU_IS_GRAPHIC_CONSOLE(con);
-- 
2.53.0


