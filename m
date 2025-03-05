Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F45C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiSd-00024I-F1; Wed, 05 Mar 2025 01:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSW-0001pG-RN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSV-0001k0-2N
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHQd6FI+FUaBqzjC9oXg2i3EXTXL8SbQgqa1BG4fkPM=;
 b=GTJDfFder85Zzk2hCbuzbtBw4D64ypgCa458i0zrFE7ohJIbtog2Ofwgul4C4ObsQc9Kml
 XfHNgHB6vQ2hnsMmT7dZ6hCz8P6n+d0BqO6hShPrW0sWzHZKoHrgUjNx1H+WJf0MfHlv4c
 XtXi+fhfuCCPszlqBKnWbZPmqDsJBt0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-9n3wgY-bOeGXwr8zFyLUCg-1; Wed,
 05 Mar 2025 01:42:13 -0500
X-MC-Unique: 9n3wgY-bOeGXwr8zFyLUCg-1
X-Mimecast-MFC-AGG-ID: 9n3wgY-bOeGXwr8zFyLUCg_1741156933
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D73B61955BC5; Wed,  5 Mar 2025 06:42:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AF2A1800266; Wed,  5 Mar 2025 06:42:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 4/6] ui/console-vc: add support for cursor DECSC and DECRC
 commands
Date: Wed,  5 Mar 2025 10:41:30 +0400
Message-ID: <20250305064132.87441-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250305064132.87441-1-marcandre.lureau@redhat.com>
References: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 127.0.0.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Roman Penyaev <r.peniaev@gmail.com>

There are aliases for save and restore cursor commands:

* save cursor
    `ESC 7`     (DEC Save Cursor [1], older VT100)
    `ESC [ s`   (CSI Save Cursor, standard ANSI)

* load cursor
    `ESC 8`     (DEC Restore Cursor [2], older VT100)
    `ESC [ u`   (CSI Restore Cursor, standard ANSI)

This change introduces older DEC sequencies for compatibility with
some scripts (for example [3]) and tools.

This change also adds saving and restoring of character attributes,
which is according to the VT spec [1][2]

[1] https://vt100.net/docs/vt510-rm/DECSC.html
[2] https://vt100.net/docs/vt510-rm/DECRC.html
[3] https://wiki.archlinux.org/title/Working_with_the_serial_console#Resizing_a_terminal

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250226075913.353676-5-r.peniaev@gmail.com>
---
 ui/console-vc.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 87f57f1c52..522adc2806 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -90,6 +90,7 @@ struct VCChardev {
     int esc_params[MAX_ESC_PARAMS];
     int nb_esc_params;
     TextAttributes t_attrib; /* currently active text attributes */
+    TextAttributes t_attrib_saved;
     int x_saved, y_saved;
 };
 typedef struct VCChardev VCChardev;
@@ -644,6 +645,31 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     s->y = y;
 }
 
+/**
+ * vc_save_cursor() - saves cursor position and character attributes.
+ */
+static void vc_save_cursor(VCChardev *vc)
+{
+    QemuTextConsole *s = vc->console;
+
+    vc->x_saved = s->x;
+    vc->y_saved = s->y;
+    vc->t_attrib_saved = vc->t_attrib;
+}
+
+/**
+ * vc_restore_cursor() - restores cursor position and character
+ * attributes from saved state.
+ */
+static void vc_restore_cursor(VCChardev *vc)
+{
+    QemuTextConsole *s = vc->console;
+
+    s->x = vc->x_saved;
+    s->y = vc->y_saved;
+    vc->t_attrib = vc->t_attrib_saved;
+}
+
 static void vc_putchar(VCChardev *vc, int ch)
 {
     QemuTextConsole *s = vc->console;
@@ -699,6 +725,12 @@ static void vc_putchar(VCChardev *vc, int ch)
             vc->state = TTY_STATE_G0;
         } else if (ch == ')') {
             vc->state = TTY_STATE_G1;
+        } else if (ch == '7') {
+            vc_save_cursor(vc);
+            vc->state = TTY_STATE_NORM;
+        } else if (ch == '8') {
+            vc_restore_cursor(vc);
+            vc->state = TTY_STATE_NORM;
         } else {
             vc->state = TTY_STATE_NORM;
         }
@@ -833,14 +865,10 @@ static void vc_putchar(VCChardev *vc, int ch)
                 }
                 break;
             case 's':
-                /* save cursor position */
-                vc->x_saved = s->x;
-                vc->y_saved = s->y;
+                vc_save_cursor(vc);
                 break;
             case 'u':
-                /* restore cursor position */
-                s->x = vc->x_saved;
-                s->y = vc->y_saved;
+                vc_restore_cursor(vc);
                 break;
             default:
                 trace_console_putchar_unhandled(ch);
-- 
2.47.0


