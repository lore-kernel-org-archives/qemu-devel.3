Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A15F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBZ-0000Na-NB; Tue, 17 Mar 2026 04:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAg-0007CX-5o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAe-0003B1-Gt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuszwlzFazS/xLxRKGLnEKlT1TF42DEZ+anEnziEuy4=;
 b=YNwSm+mtB9LCan1PfPK9F74MCe2tltY/x9rnvMuZCwChcYSXzW3Lnk2R5Eu402jJdn3BP4
 /5mKlIOPf+StYCSTnRfz1DCRefK1WQ362Z85CWnYmR0K/a5VPxFQJr929wo00rujc5EfPg
 ZBm2YmyY+Sq74r/dXw1TUfWl1q5OdUg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-VrYtU60POQ6buo5kWj3TmA-1; Tue,
 17 Mar 2026 04:52:58 -0400
X-MC-Unique: VrYtU60POQ6buo5kWj3TmA-1
X-Mimecast-MFC-AGG-ID: VrYtU60POQ6buo5kWj3TmA_1773737577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6655619560BF
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EA01180075B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:38 +0400
Subject: [PATCH 24/60] ui/console-vc: refactor text_console_resize() into
 vt100_set_image()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-24-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=numOHj5C41+ncaC5yXhTFVXg90F23EL7KvI8XaI8wcQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbhYblaSb3rHi4/xDsDktjkt9T+En3gYY3d
 ukewfSe4RiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5b0nD/oCQTjIhs377kmurH4+h5kF2sdWJ/x1tLvBMaoeYcrOLGEVsPTUkswZTYi0cIj8NwEwmOH
 KTVXH/zX3k9W1hW26zVeS6izp6V9h5HZ9Um72xpTN7DGkWhTqSpwrmZjwvoCrJHWXWdLNzoTZY2
 0fw0ns8LN3ShChN6b2uM/kipO3414uDxVJu5pVWm9hJkscVHKw1a2NlSZ6gBSLa36QqYT1hQI7D
 s0wScpZQ605SixULZRsOqQ1Ab2Sp9WFqEY78dE2DVtVY3nNp2qIO3+e2oXUTzfg5H2stgR+ZsEr
 +NDGIoK8wExOQSC6uOBnAh43MLT1rsa/9+eFNTO9Feg9Feg9KKRTeAGM1wOtZoRlUHgMT6rUxRl
 UCQJJhz/vrDCDHaehmssXfcQ5vTovz4nIOLct0WdTR4OKkklsnBN/B6V5ZZqnYMNelk5M1Kx1R1
 o6fKMVeK5VHi6uN6MEUirDxRivdny7gyTyrSHWTQg25QXJ08aUbgED4/gKdK6eujSzZspUikK6Q
 Npxc4+WlO7kJUIYtcfBaSUpoFRda97JCP11vjII87xx/yLaHX3UIjIVpT+ZfRVz9Zd4GujeBAWn
 Qieh+MXuHhcyijuXN0Q9FAx3RqMNLxiICRNQp0yjITCfZDZfp2/Jdg4JmFhcElXn7N9XBaSouLf
 cit7i2LpJMMHu7g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Decouple the resize logic from QemuTextConsole by operating on
QemuVT100 and taking a pixman_image_t directly, instead of reaching
into the console's scanout surface. The callers now pass the image
explicitly, which makes the VT100 layer independent of the console
object hierarchy.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index a45f4bc875b..efb10c2f8f7 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -12,6 +12,7 @@
 #include "ui/console.h"
 #include "ui/cp437.h"
 
+#include "pixman.h"
 #include "trace.h"
 #include "console-priv.h"
 
@@ -395,44 +396,41 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
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
@@ -1125,7 +1123,7 @@ static void text_console_invalidate(void *opaque)
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
-        text_console_resize(QEMU_TEXT_CONSOLE(s));
+        vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
     }
     vt100_refresh(&s->vt);
 }
@@ -1245,7 +1243,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    text_console_resize(s);
+    vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
 
     if (chr->label) {
         char *msg;

-- 
2.53.0


