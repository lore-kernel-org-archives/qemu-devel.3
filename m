Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4FDF33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QC3-0001EA-Ti; Tue, 17 Mar 2026 04:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QB9-00085z-AH
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QB7-0003Ov-Nw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xWzndOWq7ArgzZjWdyWaap0dhjwt0oLMqBrIzkL/y8Q=;
 b=GDRkuAmcdfr7vSCekKuTldWD1JgbzFQN+ngfQezW8kDGNL4Ii89SAvoN0px0lCp2LcC6Y8
 zyKfdjTz4Wt8IrB5ExdPGU0mN8oi/ONAp8KeI7Fett9FpsOoKYxqhU/tPNoHJF5L01lkue
 w/RcFTHv95GveEgZ+QSRv89aE+SFSkw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-kuFnNGocNUa3ODb8Z9u5xA-1; Tue,
 17 Mar 2026 04:53:26 -0400
X-MC-Unique: kuFnNGocNUa3ODb8Z9u5xA-1
X-Mimecast-MFC-AGG-ID: kuFnNGocNUa3ODb8Z9u5xA_1773737606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20120195608C
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0980B1800361
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:53:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:43 +0400
Subject: [PATCH 29/60] ui/console-vc: extract vt100_keysym() from
 qemu_text_console_handle_keysym()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-29-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Z81RkVNThOvnq6XkQ31MYQymYu0yiyGQpUgt2GLyfpg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbisCYld+dRzGUDGXkNJ/cL7gF4MSYoK8w+
 1OGbvm1j66JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5fs/D/4teXnS8qHZ4DS8tH/EVfFZgVGvCHLvzf2Da/ZxRmTgVmve7f0EknxjSuKF8lZePoMZgwx
 1Tp8K1C9dcmZ3wxnayw2gq/C6Rm23wj/4uHQcn5vHt6sWOeAjUcX88/9PwiYBBVQtmjWzIk3Jet
 CLpCygXsPrtM/fR9rXXAGyUoPBiyGI+qpvJmsB5HrKoD5GW9TKMpB0Z3UOynPq7CDi4DUz5wQ7+
 iMH6Wy546GmbPuBlde3HoQIyVMqx61/14k8ieAPNIatveSI0TOHZPvy0ye/4ShngusSrGUh1yeK
 81/lgmg8VM6mrgPrkVrjwxkylDraL4QQ/1ScC001JyMaNmENPvxUIoaWQfm/ep7vyY2CDyH6cHT
 sam/+nS1W3EdRBfPS56l8CMevUIei0u3vp9THiHE+j3IZGJoZl4NOE9Or3sQwPaNlTSfXyIm7f1
 wiyD9WMAMX3gdqZps4ttPaQ9AQZ3VQwA6erc2YaORlCvJJ00HdsTQIW80lakwWKE3PZ8WlYB/r1
 yRT5EZyq/EqE8GZ8fPArcC+tNdstY2MkVic3MUn8jzVVIKRxcgqXPMIynlbxYELguKrWkibLS4l
 pxJ93BvgFCATbBXTomxtAwVrtvBN1Cr4pOvojAl8xdvBjRznaO7l6BOZcGUr4yZa50hbP5uFRDL
 vmmil3CJB3GfXpg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Move the keysym handling logic out of qemu_text_console_handle_keysym()
into a new vt100_keysym() helper that operates on QemuVT100 directly,
continuing the effort to decouple the VT100 layer from the console layer.

The echo path is updated to call vt100_input() instead of
qemu_chr_write(), since the function no longer has direct access
to the chardev.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 3ef492c2d4c..dcd6445a1c3 100644
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


