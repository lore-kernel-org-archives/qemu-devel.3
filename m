Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DBAF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPo-0006em-Cm; Fri, 10 Apr 2026 15:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPj-0005wP-P8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPi-0001aq-8s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrbyBCyRCrUTpCfsw4FXQ87PN8E4xHrqUwFNeptatsY=;
 b=ETf79tEtEDc2c9YmK71Xu8/AjQuJdMW4CsFKqe27Ydnp83ibnQMMeqYfl3zU6mkN4kxmz1
 2WRo7QLa9UzmLHlTNGOErBXt/TR8+Om8UwDqdx/H8ht7tU1jgZIrMI2M5T/msqIcnUkBCA
 mDjldvS3Kfahl0VdUc8E39f0Rrj+SvQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-2ArQdatZMJKQFVrASN263Q-1; Fri,
 10 Apr 2026 15:21:07 -0400
X-MC-Unique: 2ArQdatZMJKQFVrASN263Q-1
X-Mimecast-MFC-AGG-ID: 2ArQdatZMJKQFVrASN263Q_1775848866
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8888819560AA; Fri, 10 Apr 2026 19:21:06 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 159FB1800357; Fri, 10 Apr 2026 19:21:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:44 +0400
Subject: [PATCH v2 22/67] ui/console-vc: refactor text_console_resize()
 into vt100_set_image()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-22-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hGNex5Z8ktmnpUuKhaz5DK+qq1hXD5X1R8yragDrE5U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0U+HIV6XWW8Qz/7MOjA4aUz0nyXldqx1LE/
 BwtXpzSRiiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5aF0EACOYeHXi6Btb2ohEhaIeQA05wJCLLgak/Hz884HpdYIetGTvquYONb5bVlTX4B4ANhmLNS
 Yo9iNdGwpEhCPqo/x6cKlx1V+8xtJnZv7Im/3evQO6a+PIxCwxiryfEX8UJnpFjVN+3HSA/+uJH
 HSZQDKytWq1UcCPnaeD7Xjb9ltPyqbik+lJ+QourrHILp9170d+E9gyRAtmnLARt+QoAxcSHgxD
 gkKDC6mCgPCxOAc2vFnL4n/Ku60jZxV9MbtmRf+z/GspQEBHb5XFKp4G1S0o9oUCFAPeETk5p/V
 ZXaWO4iGc7Sas/SxKsvNS1+cA+odxpjBpnDcWeYA6bxoOvN0zZBXsbEUWZ9LA2Gh2/Q0VnZtUhQ
 GVPch1iUpf3+CtkfIqTmJDD4vHJtVIJwz8ML5+WV0zEpIjkVf3EPiKXfjf5xsPwjbL+6E5RpWTt
 VPwDYRzHZ0Hhfq8GVut5UxbhPG1SsFguqAJCqe9+yhAW2LLGopx0On+g/uqRCwaEpVCo4Z8mujl
 Zr7FxdNskKkuMnEw1ZgHpOEhfLBJpRpNmMtDS6sCyYnbGqQHW9yEu8pPwO7Ma3BtOAkIuWTWj/i
 qcYEqO4d4x/RPlEUivfdutKupSRi/NF7Sz+7FWHLZnG5EJxRtzLNT6oQxp6j/AOMleOD2STpvyN
 3UXRk2/m35ksEyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
index c6846af3697..85c794062fc 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -12,6 +12,7 @@
 #include "ui/console.h"
 #include "ui/cp437.h"
 
+#include "pixman.h"
 #include "trace.h"
 #include "console-priv.h"
 
@@ -397,44 +398,41 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
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
@@ -1137,7 +1135,7 @@ static void text_console_invalidate(void *opaque)
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
-        text_console_resize(QEMU_TEXT_CONSOLE(s));
+        vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
     }
     vt100_refresh(&s->vt);
 }
@@ -1257,7 +1255,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    text_console_resize(s);
+    vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
 
     if (chr->label) {
         char *msg;

-- 
2.53.0


