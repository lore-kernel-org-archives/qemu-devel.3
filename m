Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED548F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQG-00006V-1u; Fri, 10 Apr 2026 15:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPw-0007RM-Vw
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPv-0001bs-H4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqgxaN0EQEIbeZuRUaIOBEyt8RA8ds5FauGylw3GKZI=;
 b=DLlyXWy/AseaiBsRY/9qA8vd2jE/Ljyan2+nClKvuOKxsxPf7+yz1FeTsGsvN/EOW51rhL
 z3GlXXZ+exDo7TmgVPfzVkDIzbCfvlzokxTia7bEQFW93eEnkYQCTGo/qSVCvnhGLvjYRf
 JiV50i3KVeZ9Q7rWpm0fIXiENlJO3Q8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-LoRkLvprNCKrTKnzoDH0cw-1; Fri,
 10 Apr 2026 15:21:19 -0400
X-MC-Unique: LoRkLvprNCKrTKnzoDH0cw-1
X-Mimecast-MFC-AGG-ID: LoRkLvprNCKrTKnzoDH0cw_1775848878
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE0A719541AE; Fri, 10 Apr 2026 19:21:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 354963000C16; Fri, 10 Apr 2026 19:21:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:46 +0400
Subject: [PATCH v2 24/67] ui/console-vc: unify the write path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-24-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3629;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rgqd45Vmz4hS+I+bczTQrpcE/mb67kdr0yCJlR22ZB0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UPqYOF1m5ya5lKn8/auDoKhIR4oTiZOU5Z
 ZKPp/TtlpiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5fT8EACWINBORQ4Cenul7+RKJwjvxKGY8Lj/dKFDOjE20z7ETotmTAuY7BRoWF7HAcwQtP3opP2
 07q1KC0mYlG/UZ3nuOAO+BUPUQn21V3RpOSECDHDKwnm12oviNhOAHRK3+qumV2dl51WdzdUjnB
 gCJBBA34f5//vEqAs+Rka0MUUBqN3JswcDTZUeu8yjaBw1m72nmv1sCrSVyeMoSClY4Ix8ikbdh
 vbJBbIwFI46HiwzTob44+MH7G3C/8kVgxlLJDCCd7hZRa9ZFmxFzXuU0Mi6hjsQWD3jreDmCLLg
 51J7nGDyVw7KS4YF1abGFdwkos5QVdrV1zMv06uHHWj/IuEsEWOXNx2GNF845JCX28Dy3ebhsdH
 HVlpm8EtkiqFl0/Z56sPG0Ey99k1C/5r8cb8MaDan932VaSsMNLH6zAEgP+o5fGSnoAaOaOncI6
 FPWEJ0Y+vFxvkT1s4SSavyDypMHYwoxjeJgGE67mDMcmIzWFaU+obYd4Ja8Jngwrhhqp5Nk7tOQ
 Zq/VBPkHtIrgXq0A20sDt1bhs/wWVYvTGivNQS+oVn/tKUoxH5YOWcthy3h+kpTOQ7ToOL1hgf/
 tlYvF4KfEn5DC98bkNF1q3X2WSH7VYDNszGk9mjQ/xtiZgrmSSWDOqwtDdRvxLt3+Ii7nYWMOfs
 RoCnxac6ibCqukQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index a367622d819..bba1fe614ef 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -299,7 +299,7 @@ static void vt100_scroll(QemuVT100 *vt, int ydelta)
     vt100_refresh(vt);
 }
 
-static void kbd_send_chars(QemuTextConsole *s)
+static void qemu_text_console_flush(QemuTextConsole *s)
 {
     uint32_t len, avail;
 
@@ -316,13 +316,21 @@ static void kbd_send_chars(QemuTextConsole *s)
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
@@ -361,9 +369,7 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
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
@@ -677,13 +683,6 @@ static void vc_put_one(VCChardev *vc, int ch)
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
@@ -1028,13 +1027,13 @@ static void vc_putchar(VCChardev *vc, int ch)
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
@@ -1194,7 +1193,7 @@ static void vc_chr_accept_input(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
 
-    kbd_send_chars(drv->console);
+    qemu_text_console_flush(drv->console);
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)

-- 
2.53.0


