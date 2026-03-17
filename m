Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236BCF3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QCy-0003Tm-Jb; Tue, 17 Mar 2026 04:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAr-0007Mj-7u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAp-0003CA-IV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmRDjLj7ipFrLHCObHHmmLv5yjAMdPQASv1LdJP6SDY=;
 b=hj9QedZ8ro25f1jl0YO9PDSLfMB3F8lTckmhxEWXqHkOpzNEwDBHq51gTSWjvuDD4mvdU5
 Ocn2VMK5kicMMZtZ9Ff0xEFrLG8U+bQ4QJiRc6TlGLEHgoILgVBtbc+eVK10yUBedkHW05
 fKJeGIW9KUphzSzqyWm7hRMwo/DQz54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-mCXbk_rIObyxH2mJv-1oPQ-1; Tue,
 17 Mar 2026 04:53:09 -0400
X-MC-Unique: mCXbk_rIObyxH2mJv-1oPQ-1
X-Mimecast-MFC-AGG-ID: mCXbk_rIObyxH2mJv-1oPQ_1773737588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3320C195608B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3614819560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:40 +0400
Subject: [PATCH 26/60] ui/console-vc: unify the write path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-26-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3549;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bqSrs4f//wifWiC1OG0jromCGTEbHnPBPszWsC7hIV4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbBDT+5eO7Z+30AbJeHQ7Q3sUOkH+aA0xX3
 6YcgiWLJoqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5YBbEACON8FvAyE2OpAEDg3liaNwC+afd0SNj5l3ueBZrexaRIV73CHBJHbm8Lwx/soRVMlKcbA
 9Jl5iohYPkXQLM07lovzU0POHrbf67PSBqsSPxUkq1qJemP6nNScGTtjJmfEKkF1nu6xsaHVTrY
 kqAMs5OFRrrMjwpasH7eB8u7PSRE0dh9ZSiFauJlCfnIdsAGTJSTZo3P5VQ3MChv21jA/QfebEX
 i7CA8Pa2qU/xAk7Nid5m5n5zWErius+K4ZlLLVrYyIIpBP9T9LOnDAMhx8MSGjo2uSJmyaHsq8u
 RoHDNE30O+GWKv2olcyhpBRTLrALfuBWxxmgq4pI9MTUT5tXKXVzv6ZvnFbvGnvzlLs8g1NOHfo
 n4mHBvvOGmvnH9RnEsYKP61ok71cVOrYQreIx1mYQjkeSmqP0ywlmGsKHgeV7fN2BWoivHwz42Z
 NbzfUVHnxQ19nGRbi9b/P/27X/KZfp9Q1Rw5LA2/hglV3oaFZD0ewURQlqb/b3vi/OhAsSYKncb
 um/a0M5FbgMucIJbqdO5rhW4ybpft55OMgQKnRWGwUBbbgCa76aq5tydNi4izRkDWIsuiFSoSXn
 AwSLJb1rg5LRhRmo4abJJA1A/CeMrLPKqNgaRzrStfxMtvBkQILVw71e7nFpePJTfIZ7M3fzS74
 X1gaWcED+mgDjbQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

VT100 escape responses (DSR) used qemu_chr_be_write() to write directly
to the chardev backend, bypassing the output FIFO, while keyboard input
went through the FIFO and flush path. This inconsistency could lead to
out-of-order delivery when both paths are active.

Introduce qemu_text_console_write() that pushes data into the output
FIFO and flushes it, and use it for both keyboard input and VT100
responses. Remove the now-unnecessary vc_respond_str() helper. Rename
kbd_send_chars() to qemu_text_console_flush() to better reflect its
purpose.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 4ea9f88f55a..8d4178f8cab 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -299,7 +299,7 @@ static void vt100_scroll(QemuVT100 *vt, int ydelta)
     vt100_refresh(vt);
 }
 
-static void kbd_send_chars(QemuTextConsole *s)
+static void qemu_text_console_flush(QemuTextConsole *s)
 {
     uint32_t len, avail;
 
@@ -316,12 +316,20 @@ static void kbd_send_chars(QemuTextConsole *s)
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
     uint8_t buf[16], *q;
     int c;
-    uint32_t num_free;
 
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
@@ -360,9 +368,7 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
         if (s->vt.echo) {
             qemu_chr_write(s->chr, buf, q - buf, true);
         }
-        num_free = fifo8_num_free(&s->out_fifo);
-        fifo8_push_all(&s->out_fifo, buf, MIN(num_free, q - buf));
-        kbd_send_chars(s);
+        qemu_text_console_write(s, buf, q - buf);
         break;
     }
 }
@@ -673,13 +679,6 @@ static void vc_put_one(VCChardev *vc, int ch)
     s->vt.x++;
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
@@ -1018,13 +1017,13 @@ static void vc_putchar(VCChardev *vc, int ch)
                 switch (vc->esc_params[0]) {
                 case 5:
                     /* report console status (always succeed)*/
-                    vc_respond_str(vc, "\033[0n");
+                    qemu_text_console_write(s, "\033[0n", 4);
                     break;
                 case 6:
                     /* report cursor position */
                     response = g_strdup_printf("\033[%d;%dR",
                                                s->vt.y + 1, s->vt.x + 1);
-                    vc_respond_str(vc, response);
+                    qemu_text_console_write(s, response, strlen(response));
                     break;
                 }
                 break;
@@ -1183,7 +1182,7 @@ static void vc_chr_accept_input(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
 
-    kbd_send_chars(drv->console);
+    qemu_text_console_flush(drv->console);
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)

-- 
2.53.0


