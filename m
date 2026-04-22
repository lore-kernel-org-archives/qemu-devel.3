Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7A3F9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV49-0000SM-Of; Wed, 22 Apr 2026 06:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3H-0008Ny-IL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3F-000371-OQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTyw85b3cKBWkTsY2lq9LORDdeMIEgKLvx9n7ye9nX0=;
 b=VqH5UazM2kRSnmBes3bNuGXaN5LwnSN64bPQkfApUBvf4FtDWSjkgcj3RUnci1SXA04n7k
 /s9a7xInpxT80/GyjlNaFFRd5M92qlx2/CMnwFh/cbZES0jWyOMTMUsW0ajXea35Ijxw7e
 HgDlpEOBqeivD4NYcUIDQrotknn7LMM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-rku4ccyEMhq3p4w3ftrvgw-1; Wed,
 22 Apr 2026 06:43:23 -0400
X-MC-Unique: rku4ccyEMhq3p4w3ftrvgw-1
X-Mimecast-MFC-AGG-ID: rku4ccyEMhq3p4w3ftrvgw_1776854602
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF8F419560AA; Wed, 22 Apr 2026 10:43:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F17C1800446; Wed, 22 Apr 2026 10:43:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 25/40] ui/console-vc: refactor text_console_resize() into
 vt100_set_image()
Date: Wed, 22 Apr 2026 14:40:26 +0400
Message-ID: <20260422104042.3936506-26-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Decouple the resize logic from QemuTextConsole by operating on
QemuVT100 and taking a pixman_image_t directly, instead of reaching
into the console's scanout surface. The callers now pass the image
explicitly, which makes the VT100 layer independent of the console
object hierarchy.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index d3e891dab92..00de9291d3d 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -11,6 +11,7 @@
 #include "qemu/queue.h"
 #include "ui/console.h"
 
+#include "pixman.h"
 #include "trace.h"
 #include "console-priv.h"
 
@@ -394,44 +395,41 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
     }
 }
 
-static void text_console_resize(QemuTextConsole *t)
+static void vt100_set_image(QemuVT100 *vt, pixman_image_t *image)
 {
-    QemuConsole *s = QEMU_CONSOLE(t);
     TextCell *cells, *c, *c1;
     int w1, x, y, last_width, w, h;
 
-    assert(s->scanout.kind == SCANOUT_SURFACE);
-
-    t->vt.image = s->surface->image;
-    w = pixman_image_get_width(t->vt.image) / FONT_WIDTH;
-    h = pixman_image_get_height(t->vt.image) / FONT_HEIGHT;
-    if (w == t->vt.width && h == t->vt.height) {
+    vt->image = image;
+    w = pixman_image_get_width(image) / FONT_WIDTH;
+    h = pixman_image_get_height(image) / FONT_HEIGHT;
+    if (w == vt->width && h == vt->height) {
         return;
     }
 
-    last_width = t->vt.width;
-    t->vt.width = w;
-    t->vt.height = h;
+    last_width = vt->width;
+    vt->width = w;
+    vt->height = h;
 
-    w1 = MIN(t->vt.width, last_width);
+    w1 = MIN(vt->width, last_width);
 
-    cells = g_new(TextCell, t->vt.width * t->vt.total_height + 1);
-    for (y = 0; y < t->vt.total_height; y++) {
-        c = &cells[y * t->vt.width];
+    cells = g_new(TextCell, vt->width * vt->total_height + 1);
+    for (y = 0; y < vt->total_height; y++) {
+        c = &cells[y * vt->width];
         if (w1 > 0) {
-            c1 = &t->vt.cells[y * last_width];
+            c1 = &vt->cells[y * last_width];
             for (x = 0; x < w1; x++) {
                 *c++ = *c1++;
             }
         }
-        for (x = w1; x < t->vt.width; x++) {
+        for (x = w1; x < vt->width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
     }
-    g_free(t->vt.cells);
-    t->vt.cells = cells;
+    g_free(vt->cells);
+    vt->cells = cells;
 }
 
 static void vc_put_lf(VCChardev *vc)
@@ -1076,7 +1074,7 @@ static void text_console_invalidate(void *opaque)
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
-        text_console_resize(QEMU_TEXT_CONSOLE(s));
+        vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
     }
     vt100_refresh(&s->vt);
 }
@@ -1196,7 +1194,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    text_console_resize(s);
+    vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
 
     if (chr->label) {
         char *msg;
-- 
2.53.0


