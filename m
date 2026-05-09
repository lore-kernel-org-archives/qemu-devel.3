Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E93CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcGN-0007GM-Se; Sat, 09 May 2026 03:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGG-0006d4-Uk
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGF-0007Ad-8O
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Ew8EtolbjA1D7Hs4jgTfKrH6QjkTzcJn1UfbgtMMQk=;
 b=h7iISuHj4ir+poTWomGCaX9HvsbpXgWmzsI+WJ+a7IbNnIwh7+BMSBvzZHb4lyWg364Vpa
 8R+iqxShdZtsajJhhssD16s3GrVQd5sinAbCbfFxV4b5/PtNZZVcGZuQ9dFDhRm+IT/Vg3
 usRqn9VIVaeXhWMif6FsHnz3DB67DHc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-wqWxFITAOhqWBm7HsSR-xA-1; Sat,
 09 May 2026 03:38:03 -0400
X-MC-Unique: wqWxFITAOhqWBm7HsSR-xA-1
X-Mimecast-MFC-AGG-ID: wqWxFITAOhqWBm7HsSR-xA_1778312282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E0CA18005B6; Sat,  9 May 2026 07:38:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB13A19560A2; Sat,  9 May 2026 07:38:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 17/32] ui/console-vc: extract vt100_init() and vt100_fini()
Date: Sat,  9 May 2026 11:36:03 +0400
Message-ID: <20260509073621.1011778-18-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Consolidate VT100 initialization and finalization into dedicated
functions, continuing the extraction of the VT100 layer from the
console/chardev code.

vt100_init() gathers the scattered setup (cursor timer, list insertion,
FIFO creation, default attributes, and image) that was previously spread
across vc_chr_open() and qemu_text_console_class_init().

vt100_fini() pairs with it by handling list removal, FIFO destruction,
and cells cleanup, replacing the open-coded QTAILQ_REMOVE in
qemu_text_console_finalize().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 55 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 9f5f49413d2..b58fe5de827 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -331,7 +331,7 @@ static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
     vt->out_flush(vt);
 }
 
-static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len);
+static size_t vt100_input(QemuVT100 *vt, const uint8_t *buf, size_t len);
 
 static void vt100_keysym(QemuVT100 *vt, int keysym)
 {
@@ -1129,12 +1129,19 @@ static void text_console_invalidate(void *opaque)
     vt100_refresh(&s->vt);
 }
 
+static void vt100_fini(QemuVT100 *vt)
+{
+    QTAILQ_REMOVE(&vt100s, vt, list);
+    fifo8_destroy(&vt->out_fifo);
+    g_free(vt->cells);
+}
+
 static void
 qemu_text_console_finalize(Object *obj)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(obj);
 
-    QTAILQ_REMOVE(&vt100s, &s->vt, list);
+    vt100_fini(&s->vt);
 }
 
 static void
@@ -1142,10 +1149,6 @@ qemu_text_console_class_init(ObjectClass *oc, const void *data)
 {
     QemuConsoleClass *cc = QEMU_CONSOLE_CLASS(oc);
 
-    if (!cursor_timer) {
-        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
-    }
-
     cc->get_label = qemu_text_console_get_label;
 }
 
@@ -1211,6 +1214,27 @@ static void text_console_out_flush(QemuVT100 *vt)
     qemu_text_console_out_flush(console);
 }
 
+static void vt100_init(QemuVT100 *vt,
+                       pixman_image_t *image,
+                       ChardevVCEncoding encoding,
+                       void (*image_update)(QemuVT100 *vt, int x, int y, int w, int h),
+                       void (*out_flush)(QemuVT100 *vt))
+{
+    if (!cursor_timer) {
+        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
+    }
+
+    vt->encoding = encoding;
+    QTAILQ_INSERT_HEAD(&vt100s, vt, list);
+    fifo8_create(&vt->out_fifo, 16);
+    vt->total_height = DEFAULT_BACKSCROLL;
+    vt->image_update = image_update;
+    vt->out_flush = out_flush;
+    /* set current text attributes to default */
+    vt->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    vt100_set_image(vt, image);
+}
+
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
@@ -1240,22 +1264,17 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
     }
 
-    QTAILQ_INSERT_HEAD(&vt100s, &s->vt, list);
-    fifo8_create(&s->vt.out_fifo, 16);
-    s->vt.total_height = DEFAULT_BACKSCROLL;
     dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
-    s->vt.image_update = text_console_image_update;
-    s->vt.out_flush = text_console_out_flush;
-
-    s->chr = chr;
-    drv->console = s;
     if (vc->has_encoding) {
-        drv->encoding = s->vt.encoding = vc->encoding;
+        drv->encoding = vc->encoding;
     }
+    vt100_init(&s->vt, QEMU_CONSOLE(s)->surface->image,
+               drv->encoding,
+               text_console_image_update,
+               text_console_out_flush);
 
-    /* set current text attributes to default */
-    s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
+    s->chr = chr;
+    drv->console = s;
 
     if (chr->label) {
         char *msg;
-- 
2.54.0


