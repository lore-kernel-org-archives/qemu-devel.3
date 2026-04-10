Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBF1F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHTD-0006wa-5e; Fri, 10 Apr 2026 15:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHT9-0006uw-BC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHT3-0002Wq-01
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47nHfE6Dd9pBt6quFAl/2E1llNWDswiln4ygrouj+gg=;
 b=ZOoaJZMB9Th8UqsDkQW2qLc/oXA2Pnq0ly2VA0Pyaj/dGbgNVab997JyJHU31WgSYZh5aU
 L7eW0Z7f9KHtpIIJd7gnbY4LbT/uI//Oy3wlFmBier1GSugvaLqRGZnNSmvb8k3RbbzfKX
 AD77fyFcNcmoYrftHbXuS/U14/7Zeyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-_D5yo8MAN4e06JH3MR72uA-1; Fri,
 10 Apr 2026 15:24:30 -0400
X-MC-Unique: _D5yo8MAN4e06JH3MR72uA-1
X-Mimecast-MFC-AGG-ID: _D5yo8MAN4e06JH3MR72uA_1775849069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9154C1956054
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:24:29 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A5EF1800B7F; Fri, 10 Apr 2026 19:24:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:18 +0400
Subject: [PATCH v2 56/67] ui/console: remove qemu_console_is_visible()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-56-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4788;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bhOtDgVb1DVTenfIM+HhCL9wwiQsu901e9ovryHDGss=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WKugkNcO1CV/g75fF1+WLsZe8xJrL04bPc
 3TW1FYBHCKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5ZBqEACBp2I4fJr0Qhn8DKAjRPEF/BAumW7Q4SwO5Tmt8ZEmq2MbsjoiE9QfaVQXnFY80j4MhZi
 2ltqmjQPzOnSmywsNqEKaeL3FNu6qtzvc8t1ncQXsTe65zzp5D30632OmBlO+sSPOKT/ml8gj5H
 K+2UAWim4XG4lVR7hHHfklj3hNN07q9zW1lv6gT6x21wdnWT9v4Zwwi6XsFD5KzAcTuOLbqBKDR
 sa1mur0jLsL5hnXvzSBqzNKJKundjvECeHXP2Zs3KDJK8ShjiOnXsFiB8ZTNZT7vPBd6RAgGUYY
 BcJnoyM8XjEpWs2V8d0yAzgvisJ1fmiBN4cKLRsQjzo7qAFWc0kc0OvHD1Wz1XqPwPYDT86Au3G
 Qv2tSTGq6TCW4pj+q8vkrcJYB6imoZ8F7KV1E9l0eBbIHhgE1ZqDORC3Mb5SftVZq5UBBclATXP
 seJ572Im2LkYkqwM/Jc7pc5ULChjB4K7NbJJUAJj6ytU81vWVDBp+DMoRIrxN5sQXfCrRHlhr2A
 IQQEuLWTNATtxdWGyjigoYGBGj83ETKqexgediHspoznTUo5AWbhUuAl4GyrtIA3jQuWKCSQbvd
 hUQdvW+pDdtUIaQ5Siom2iZt2ukDJJABfKTYFrW+OZLrsAmWrjd5ApAHV5pF3Ml/sJSskdDp89q
 NH9jYmcKFtw4H3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index b3aaf3ff12b..472c188a727 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -392,7 +392,6 @@ QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
                                                 uint32_t head, Error **errp);
 QEMUCursor *qemu_console_get_cursor(QemuConsole *con);
-bool qemu_console_is_visible(QemuConsole *con);
 bool qemu_console_is_graphic(QemuConsole *con);
 bool qemu_console_is_fixedsize(QemuConsole *con);
 bool qemu_console_is_gl_blocked(QemuConsole *con);
diff --git a/ui/console-priv.h b/ui/console-priv.h
index f8855753e30..4f731b4f9ce 100644
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
index a9132e09eac..baffdeb22b1 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -650,9 +650,6 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     dcl->ds = get_alloc_displaystate();
     QLIST_INSERT_HEAD(&dcl->ds->listeners, dcl, next);
     gui_setup_refresh(dcl->ds);
-    if (dcl->con) {
-        dcl->con->dcls++;
-    }
     displaychangelistener_display_console(dcl, &error_fatal);
     if (QEMU_IS_GRAPHIC_CONSOLE(dcl->con)) {
         dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(dcl->con));
@@ -680,9 +677,6 @@ void unregister_displaychangelistener(DisplayChangeListener *dcl)
     if (!ds) {
         return;
     }
-    if (dcl->con) {
-        dcl->con->dcls--;
-    }
     QLIST_REMOVE(dcl, next);
     dcl->ds = NULL;
     gui_setup_refresh(ds);
@@ -747,9 +741,6 @@ void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h)
     w = MIN(w, width - x);
     h = MIN(h, height - y);
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     dpy_gfx_update_texture(con, con->surface, x, y, w, h);
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
@@ -848,9 +839,6 @@ void dpy_text_cursor(QemuConsole *con, int x, int y)
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
             continue;
@@ -866,9 +854,6 @@ void dpy_text_update(QemuConsole *con, int x, int y, int w, int h)
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
             continue;
@@ -884,9 +869,6 @@ void dpy_text_resize(QemuConsole *con, int w, int h)
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
 
-    if (!qemu_console_is_visible(con)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != dcl->con) {
             continue;
@@ -906,9 +888,6 @@ void dpy_mouse_set(QemuConsole *c, int x, int y, bool on)
     con->cursor_x = x;
     con->cursor_y = y;
     con->cursor_on = on;
-    if (!qemu_console_is_visible(c)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (c != dcl->con) {
             continue;
@@ -927,9 +906,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
 
     cursor_unref(con->cursor);
     con->cursor = cursor_ref(cursor);
-    if (!qemu_console_is_visible(c)) {
-        return;
-    }
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (c != dcl->con) {
             continue;
@@ -1287,11 +1263,6 @@ QEMUCursor *qemu_console_get_cursor(QemuConsole *con)
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


