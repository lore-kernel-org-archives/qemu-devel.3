Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F142F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQK-0000nz-4d; Fri, 10 Apr 2026 15:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQG-0000Ar-0K
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQD-0001eO-GF
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDLYNXZjlTlSxzcMb74MrLDpQtk/TMaFCRV7hGZTqqY=;
 b=AHwq2CGu2NP9kzBCf8jalcdv3vLpe/g26PFAdXbaEsfUoHYULUvckSJPEe6JXDjV7nWJXd
 YW5cD4323B1JO/TjBq74uUV6/c4xNlzeq0y+a4snfcni82sgTT7OiGeoLUih6nXvIi8u7G
 ZQolQB4zn6LJgQPLvM/6VYR/M1C3r9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-4spDCFraP0WJ1VHOYwUL1g-1; Fri,
 10 Apr 2026 15:21:37 -0400
X-MC-Unique: 4spDCFraP0WJ1VHOYwUL1g-1
X-Mimecast-MFC-AGG-ID: 4spDCFraP0WJ1VHOYwUL1g_1775848896
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EDC5180058D; Fri, 10 Apr 2026 19:21:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53CD0180049F; Fri, 10 Apr 2026 19:21:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:49 +0400
Subject: [PATCH v2 27/67] ui/console-vc: extract vt100_keysym() from
 qemu_text_console_handle_keysym()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-27-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+oqf6AEhVnc97NT06e9h+2Bd4I1hHF+5HPYR62+f2m8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VPs59GxFP3E5IRXlZpPNm436UNDAUqvSYm
 W5mRcmifl2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5YmBEAC60zh88rRAHw0/RtJ+Ol8A5TrU0qPxzRl+l9mkNV0burQiw9ftROtdRiy4q2/+Wsqgpwf
 sT7ccQPYHyU2nWpHQOnMrdDFbklXq0ohk3RzezjecKP9qqN6wIcMIEZ1gCEUB4xB50p9Zk4hQ/v
 yk/H//av7lOlAgaTZ8qnUqwhQ2kAcI+W8zKy+r4xMWfC6hVMyFhz5qpeF564WdTJC46gVpG073R
 dTflZYGep1yh6X6aZ63f+iFFXNEYtBTs4KMCYGQdje3EDMfWwwdmG3LbeedW7oD9W2iZv5duLNN
 7H/fMOnEu+YNHTMdgR+KGyR1SPg/4BDJYct6X16L7TKhp4/aOdGnPNpCLF9rm+RpAGNqxWVqPqx
 LfngY77vYTjIfAztoq9IQYyM1DLJZKvLpc/UsuUKpulgp+umXtXC+PjegUuezx8qJJhmdtAALf0
 wiTSauHzH0UbFGXDQpbb3G8t/CsJ8KVPSfZueSAlFsYrEbDHBpm5YOousGvAFK2LjCXX0osTuuH
 sOFUXXmeKHvUXAcB2wmKCCsQIFf6gww4ZOUZtxloHPcdhDuuFwqMN24oikMSa/WiLLyS6sedp4d
 koITS+OL09+mDlsRBckPi7nbJ1CfToOKtRm8ImpPpH0lZBKCSE9dkP+iyGk1ZaoCmaMEvEcR7YG
 N8ErT9xNAIXk2dw==
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
index 15600128380..194233f41df 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -326,24 +326,25 @@ static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
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
@@ -360,18 +361,24 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
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
2.53.0


