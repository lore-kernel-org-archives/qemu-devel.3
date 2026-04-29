Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B3FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4x-00051l-H6; Wed, 29 Apr 2026 17:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4v-0004kp-Bn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4t-0003La-Ln
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rzLL/ck02/es3rtCEyzFAswJotjkFyi2i5qTXjS7v4=;
 b=B6nGDNvRFR/pLupDUSF1SrdcwGpwhd9cyfOvdIaYFtzbN2/hrHP8cLp9NFkFHh1fbyWc43
 SbFcqIRIJb3uFsJZehfxEdhttJBJNhAqYhDJt4JVuLoiS4p6WpKPntkVAjGc8v1Ubnosbp
 KpFFW1iNgHWIhWrL7lwhIMCidUDwGFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-P11UuIqfNJqca0-HXQcJeA-1; Wed,
 29 Apr 2026 17:04:13 -0400
X-MC-Unique: P11UuIqfNJqca0-HXQcJeA-1
X-Mimecast-MFC-AGG-ID: P11UuIqfNJqca0-HXQcJeA_1777496652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 560B71956080; Wed, 29 Apr 2026 21:04:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53BAC19560AB; Wed, 29 Apr 2026 21:04:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:43 +0400
Subject: [PATCH v3 10/26] ui/console-vc: extract vt100_init() and vt100_fini()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-10-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lnxoLHdniGID3jNMfTck0VEAWspSpAGOyq5lUI50G/Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILmU/orWtNu+2WtCK8xEhL8XgWVfB94j9B+
 BB1bf1ud76JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5THNEACn//+1E9J9b7nW9Len4aZpbMeiQ/CdDsqQeTl70yiAQtT3/xQPnjALcMdRYWDagCvA7pW
 9GDfcmml40F/0dvyQ7f7UU5V3VqTCt76JJAzJ7eGSpwA4rupjknxOELeAGb2vnCgLqE0iYR109N
 AFwuvJvelfwHpdgVFDbMQgbLl+O2iyxRWWvLn7Ir28/ZIbH2knBIlN8hfkaXtjw+6BKpas5Fzrw
 bJ274bx1Ql07EPm20MKAnyBxoEx5msNLlOte5kqyJCkTPEmPsP5Dsf9i9cCqFOAnZVTk1He/PRF
 /Xqti53tQU7uPopszY2k8h0WPDFsr2/On4XSrrWzQKoCNng94EZk9l3fEVwkDbSPTONMHG3I0iq
 7qx/oy+wsiDBbcIaEJ9277DqwBEmoMexPUbnMdXv8F7s/ySJmkkwBiQmgfbwwMmVZVN7SHxO6Sr
 NhtAIbhG+Cd13lbzJaju3MqUYjQ4fcf9WpLfrIxRvdW1O2BvDsTyuhQfSuoggG1rswgy+UfnIwO
 kVv3NXGGfuEC6qa/dsbUV9k8SLYED65YJt43VsT3dqKt6MYY0GGP08ieax0du1C0QLG3JZHTAix
 CNNB0EoIamY1BBfFmnxDsz5PGbrzRrU4NFdrYAU3UCQHX3pD9nMr7xsNkDZ1Fuw0Y7vWXukqTdU
 tAWydH0mNja7MBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 ui/console-vc.c | 55 +++++++++++++++++++++++++++++++++++++------------------
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


