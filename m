Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1B4F9B614
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4L-00011L-0w; Wed, 22 Apr 2026 06:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3c-00006a-Q3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3Y-00039D-3K
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0ttloNrFuyp/cULqVKONcBIJ9DfL2A0Mmull0Um73U=;
 b=U930BS9ixoaU6vidXOQNNkV6u5vrlOSrGJOuQfDbMIJDZhvhQuyKQljN1aNocQUIVjhHO3
 1X4VOMTwYlL4eW7SfqLp1bWLcv+kufTBQ+Ib0XaKcL/edFuS66lKLCP4DzsefmK3L3k4l+
 7n2T2ZLC2oEn6YGLvsjyKD/OJAd+EEU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-fhJ6Q04RNzuYM4K6jqWbeQ-1; Wed,
 22 Apr 2026 06:43:35 -0400
X-MC-Unique: fhJ6Q04RNzuYM4K6jqWbeQ-1
X-Mimecast-MFC-AGG-ID: fhJ6Q04RNzuYM4K6jqWbeQ_1776854614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70FA51956094; Wed, 22 Apr 2026 10:43:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40F373000C15; Wed, 22 Apr 2026 10:43:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 27/40] ui/console-vc: unify the write path
Date: Wed, 22 Apr 2026 14:40:28 +0400
Message-ID: <20260422104042.3936506-28-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

VT100 escape responses (DSR) used qemu_chr_be_write() to write directly
to the chardev backend, bypassing the output FIFO, while keyboard input
went through the FIFO and flush path. This inconsistency could lead to
out-of-order delivery when both paths are active.

Introduce qemu_text_console_write() that pushes data into the output
FIFO and flushes it, and use it for both keyboard input and VT100
responses. Remove the now-unnecessary vc_respond_str() helper. Rename
kbd_send_chars() to qemu_text_console_flush() to better reflect its
purpose.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 2de096db3ac..107294af1cc 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -296,7 +296,7 @@ static void vt100_scroll(QemuVT100 *vt, int ydelta)
     vt100_refresh(vt);
 }
 
-static void kbd_send_chars(QemuTextConsole *s)
+static void qemu_text_console_flush(QemuTextConsole *s)
 {
     uint32_t len, avail;
 
@@ -313,13 +313,21 @@ static void kbd_send_chars(QemuTextConsole *s)
     }
 }
 
+static void qemu_text_console_write(QemuTextConsole *s, const void *buf, size_t len)
+{
+    uint32_t num_free;
+
+    num_free = fifo8_num_free(&s->out_fifo);
+    fifo8_push_all(&s->out_fifo, buf, MIN(num_free, len));
+    qemu_text_console_flush(s);
+}
+
 /* called when an ascii key is pressed */
 void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 {
     QemuVT100 *vt = &s->vt;
     uint8_t buf[16], *q;
     int c;
-    uint32_t num_free;
 
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
@@ -358,9 +366,7 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
         if (vt->echo) {
             qemu_chr_write(s->chr, buf, q - buf, true);
         }
-        num_free = fifo8_num_free(&s->out_fifo);
-        fifo8_push_all(&s->out_fifo, buf, MIN(num_free, q - buf));
-        kbd_send_chars(s);
+        qemu_text_console_write(s, buf, q - buf);
         break;
     }
 }
@@ -634,13 +640,6 @@ static void vc_put_one(VCChardev *vc, int ch)
     vt->x++;
 }
 
-static void vc_respond_str(VCChardev *vc, const char *buf)
-{
-    QemuTextConsole *s = vc->console;
-
-    qemu_chr_be_write(s->chr, (const uint8_t *)buf, strlen(buf));
-}
-
 /* set cursor, checking bounds */
 static void vc_set_cursor(VCChardev *vc, int x, int y)
 {
@@ -967,13 +966,13 @@ static void vc_putchar(VCChardev *vc, int ch)
                 switch (vc->esc_params[0]) {
                 case 5:
                     /* report console status (always succeed)*/
-                    vc_respond_str(vc, "\033[0n");
+                    qemu_text_console_write(s, "\033[0n", 4);
                     break;
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
                                                vt->y + 1, vt->x + 1);
-                    vc_respond_str(vc, response);
+                    qemu_text_console_write(s, response, strlen(response));
                     break;
                 }
                 break;
@@ -1133,7 +1132,7 @@ static void vc_chr_accept_input(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
 
-    kbd_send_chars(drv->console);
+    qemu_text_console_flush(drv->console);
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
-- 
2.53.0


