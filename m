Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D61CD37B7
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcGL-0006s5-CK; Sat, 09 May 2026 03:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcGB-0006b7-5M
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcG8-0007A4-E7
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMekSOPI5rQd3UY/SVPKPlCnKO03Eg5wbvUG/hVtq7o=;
 b=Sy4oDwbnsuuLKAhQD41cJLnxyg30TVVqtN8bD/VPUzg52TecJczGluCPRBhMhogv1Hsayi
 pTf8rnrBR+d4iDzlQcb9TyHfFWJMSWUuyHGSwXtEzVJNruXSHG7WEGMHMswX1ELAxJNf3u
 1amXK7ats4Rv/qLUdsthiSjuw/PTRr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-mz1DZsJhMBK2kkUrAGwzmw-1; Sat,
 09 May 2026 03:37:57 -0400
X-MC-Unique: mz1DZsJhMBK2kkUrAGwzmw-1
X-Mimecast-MFC-AGG-ID: mz1DZsJhMBK2kkUrAGwzmw_1778312276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BAF41800367; Sat,  9 May 2026 07:37:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0B481944B20; Sat,  9 May 2026 07:37:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 16/32] ui/console-vc: extract vt100_keysym() from
 qemu_text_console_handle_keysym()
Date: Sat,  9 May 2026 11:36:02 +0400
Message-ID: <20260509073621.1011778-17-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

Move the keysym handling logic out of qemu_text_console_handle_keysym()
into a new vt100_keysym() helper that operates on QemuVT100 directly,
continuing the effort to decouple the VT100 layer from the console layer.

The echo path is updated to call vt100_input() instead of
qemu_chr_write(), since the function no longer has direct access
to the chardev.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 024ab277e0b..9f5f49413d2 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -331,24 +331,25 @@ static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
     vt->out_flush(vt);
 }
 
-/* called when an ascii key is pressed */
-void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len);
+
+static void vt100_keysym(QemuVT100 *vt, int keysym)
 {
     uint8_t buf[16], *q;
     int c;
 
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
-        vt100_scroll(&s->vt, -1);
+        vt100_scroll(vt, -1);
         break;
     case QEMU_KEY_CTRL_DOWN:
-        vt100_scroll(&s->vt, 1);
+        vt100_scroll(vt, 1);
         break;
     case QEMU_KEY_CTRL_PAGEUP:
-        vt100_scroll(&s->vt, -10);
+        vt100_scroll(vt, -10);
         break;
     case QEMU_KEY_CTRL_PAGEDOWN:
-        vt100_scroll(&s->vt, 10);
+        vt100_scroll(vt, 10);
         break;
     default:
         /* convert the QEMU keysym to VT100 key string */
@@ -365,18 +366,24 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
             *q++ = '\033';
             *q++ = '[';
             *q++ = keysym & 0xff;
-        } else if (s->vt.echo && (keysym == '\r' || keysym == '\n')) {
-            qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
+        } else if (vt->echo && (keysym == '\r' || keysym == '\n')) {
+            vt100_input(vt, (uint8_t *)"\r", 1);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
-        if (s->vt.echo) {
-            qemu_chr_write(s->chr, buf, q - buf, true);
+        if (vt->echo) {
+            vt100_input(vt, buf, q - buf);
         }
-        vt100_write(&s->vt, buf, q - buf);
+        vt100_write(vt, buf, q - buf);
         break;
     }
+
+}
+/* called when an ascii key is pressed */
+void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+{
+    vt100_keysym(&s->vt, keysym);
 }
 
 static void text_console_update(void *opaque, console_ch_t *chardata)
-- 
2.54.0


