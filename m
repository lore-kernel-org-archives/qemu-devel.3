Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20C7F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHPn-0006Yf-QE; Fri, 10 Apr 2026 15:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPS-0005JW-NO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPM-0001NX-QJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHwaCg3VfefxTP+gUSxcezpwPgnHezvTvMyyDg7E+NE=;
 b=ebkM14KdgtSl9OTJw/jnUAb9zxVZHGfh7vQLdwrVgw3H/359n8Y4xF0sKKZ/ePLufexRc6
 Ls8ROD8NkrPDP++hXjqPsR7Pgp9sS/ZwDkc4yAZJnCxDYh2BH31ZLLjiPUXzf91DsThMbr
 I3ZVS99WI+4MF3tk3a//uwNWyzhvdq4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-8r7Ehv1xPeCWPV1XShcxyw-1; Fri,
 10 Apr 2026 15:20:44 -0400
X-MC-Unique: 8r7Ehv1xPeCWPV1XShcxyw-1
X-Mimecast-MFC-AGG-ID: 8r7Ehv1xPeCWPV1XShcxyw_1775848843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D668218002CA; Fri, 10 Apr 2026 19:20:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 652EA1800357; Fri, 10 Apr 2026 19:20:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:40 +0400
Subject: [PATCH v2 18/67] ui/console-vc: decouple VT100 display updates via
 function pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-18-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zv3j1wO3naVlcsBKGmflvlEq7Rd0dCKKbluzj0h8VNQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0U38SUjK/LioQPmHvhEsjq34cn48mh6eqhE
 k3oTmUhqUSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5f3iEACrnIuErEdrjXBI6dY7Eu0yE5Tf15dOrdUP7KAMDYRqqkjicKQ638CEgu7mjTPLCozYot+
 nx3WCtGMoynVpUpvPPZdHAml+Pbg/NOswLbPRJ35/ALOzE71ojvvDMYxv+aIvSmTIa0FAk/X/eE
 P3+KnDKBw6IVOD+HT6tcWchPmOQX45hGWTMPM6nXhNMzL4lle/LIBKCOM614J0h/vgSUi9vmo1g
 9q5+AiUyudLNSynQqEPwCzCI203XczLImoctkO/398QnkwyJ7k3KOLY+bhfoUjpaxxzdJ2oedBP
 SS70MWQhV9mhiUpAY78ZIEirx3r2iQid0qP8Jc9lrhwNvVJJ9T9JxjVrIK9q9/O5F88xzKgiocj
 A8uq5auEDJhLblYL321vB8URl6jDq5rGgbM8W7M0OhUc7bo2uaWgFh9kkZMwXrhYGf7Wg1lSMWg
 lPwa0PqE3osTkX/1XQzrtiwuxhsVGUP5yFTm5Vif4hrv7Xefgev6Sx2G6filCT6lbfSok/xuc77
 V1NSsXe2gCVfrX/KguUxE509Ms64QX2yClD6y4WIGKHBe5z53RDuN2eyq3odq+GipnpU5EOn6OE
 Wb/O/PKF+Ffc8LcItAN1TzqRm+L0bri8d2yNOJtEKyIP1hL0wY6MwEXh3SLj8o+/lpNj9o2wirp
 IgWJ8n1AvaDZGNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace direct dpy_gfx_update() calls from the VT100 emulation code
with an indirect call through a new image_update function pointer in
QemuVT100. This decouples the VT100 terminal emulation from the
QEMU display layer, allowing different backends to provide their own
image update implementation.

The QemuVT100 typedef is changed to a forward-declared struct so the
function pointer signature can reference QemuVT100 itself.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 61d72a0cc27..f8682d2d1dc 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -48,8 +48,11 @@ enum TTYState {
     TTY_STATE_OSC,
 };
 
-typedef struct QemuVT100 {
+typedef struct QemuVT100 QemuVT100;
+
+struct QemuVT100 {
     pixman_image_t *image;
+    void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height);
 
     int width;
     int height;
@@ -66,7 +69,7 @@ typedef struct QemuVT100 {
     int update_y0;
     int update_x1;
     int update_y1;
-} QemuVT100;
+};
 
 typedef struct QemuTextConsole {
     QemuConsole parent;
@@ -224,6 +227,11 @@ static void vt100_show_cursor(QemuVT100 *vt, int show)
     }
 }
 
+static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int height)
+{
+    vt->image_update(vt, x, y, width, height);
+}
+
 static void console_refresh(QemuTextConsole *s)
 {
     QemuVT100 *vt = &s->vt;
@@ -253,7 +261,7 @@ static void console_refresh(QemuTextConsole *s)
         }
     }
     vt100_show_cursor(&s->vt, 1);
-    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0, w, h);
+    vt100_image_update(&s->vt, 0, 0, w, h);
 }
 
 static void console_scroll(QemuTextConsole *s, int ydelta)
@@ -1089,9 +1097,9 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     }
     vt100_show_cursor(vt, 1);
     if (vt->update_x0 < vt->update_x1) {
-        dpy_gfx_update(QEMU_CONSOLE(s), vt->update_x0, vt->update_y0,
-                       vt->update_x1 - vt->update_x0,
-                       vt->update_y1 - vt->update_y0);
+        vt100_image_update(vt, vt->update_x0, vt->update_y0,
+                           vt->update_x1 - vt->update_x0,
+                           vt->update_y1 - vt->update_y0);
     }
     return len;
 }
@@ -1189,6 +1197,13 @@ void qemu_text_console_update_size(QemuTextConsole *c)
     dpy_text_resize(QEMU_CONSOLE(c), c->vt.width, c->vt.height);
 }
 
+static void text_console_image_update(QemuVT100 *vt, int x, int y, int width, int height)
+{
+    QemuTextConsole *console = container_of(vt, QemuTextConsole, vt);
+
+    dpy_gfx_update(QEMU_CONSOLE(console), x, y, width, height);
+}
+
 static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
@@ -1219,6 +1234,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     }
 
     dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
+    s->vt.image_update = text_console_image_update;
 
     s->chr = chr;
     drv->console = s;

-- 
2.53.0


