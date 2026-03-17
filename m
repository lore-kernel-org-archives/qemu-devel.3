Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A1F3381E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEK-0006cb-HT; Tue, 17 Mar 2026 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDC-0003Xu-QU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDB-00075w-6p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaTStWYBUGR86O3Vlvs/c5wzHrDQ5EGJBZS4Xsnja34=;
 b=SoL9EICAOTuzWghd8G2V14VRbvj9efDmi2Tqua2q8V36YbZceO5kjz1oU4MUvXB4uPa2r5
 N3G7Ob8jc/NzJWrM0LNbWz/JhD9FsWShSXIiJJ1pXzEO84zlc7o+nMQzR57NZeA9OdJzv1
 ICIl+NJ14c07Cbnoiovyo6R76uWcIRI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-k4m5m8dAM4260xls094A2w-1; Tue,
 17 Mar 2026 04:55:34 -0400
X-MC-Unique: k4m5m8dAM4260xls094A2w-1
X-Mimecast-MFC-AGG-ID: k4m5m8dAM4260xls094A2w_1773737734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 022D618005B0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB5AD1800361
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:05 +0400
Subject: [PATCH 51/60] ui/console: remove qemu_console_is_visible()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-51-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4732;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CBB4c2mSRdNUcLuCSl4VRna1qSTaNHj3bnixxtfMgBk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcCIhwqZrsOAwey3hvujRbM7mRmjxUG5ZRl
 /2myyG2VuyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5R3bD/92PY6KzhKerX+oZjlCB3pJQ1QgNvlE+WrWyk1X1Ra8OvGPHuYmFw3Lo4BOPST6G1FJPMW
 1tgrosPaJq/ELtaSHXd+wQYz8jD/1uToJABB08MVM0qNpfeOrrlaHOpqRwcoZYJA7FO+bylkEZ/
 l4eivz9lc3DVag7+s63N3vk7VTIaXBu8OSXozpIJpD2/BlAhOvobEo7qej2f6hRSMBcTmgWE3Uw
 A4fwFgUyy28uPCyy+8fLmLTyKL2qBU85xT5soahUmGSD0sLsX/QRDyQ+GSHAzhmeKdsb0iT83gz
 67gKMet0s+UmEpfrgRCCtcmUCo2DP1x7Iw0R65pqKkNC4F/A4cY03X/ky6rxtUkXgQei2YFpxqr
 PaNWgRnPg8fu+b1RLs0s3ImPtjJG4Vw4Ba1NBMVky4rZ1zTnKQxnIH9ukZvnxX9STxx5pBm8VQv
 ntcr22xLSB8fgvLm3++g/Ko2bKi3Vo9QRwNHNSKnA3Cm8Uc1rzdGF6EPwu4R5XllF6oTAMZRaEq
 LRqtTqcwtRwxRo4pVnodYpSjNzOCGw3Xs/2RueZewP5f7DbZDajERfls0/vfSIfnINy1YgSDkmW
 UqqhSZHXD54HC7I84JAYBOhlJPEnZmRpTo1lh/cRBf8HygzY1HNYNCrfLW5PRoXW931+Y8PSqL8
 0qYFP25qOZLEm2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  1 -
 ui/console-priv.h    |  1 -
 ui/console.c         | 29 -----------------------------
 3 files changed, 31 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 737ceba3890..3189788fb5f 100644
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


