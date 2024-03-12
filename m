Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00680C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2iH-00012f-Jo; Tue, 12 Mar 2024 10:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2iB-0000vW-AE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2i9-0008Qp-FX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rd3zZWW3+nNd5d0+NShlKikfVYU55y+GRVEXBnvWUbM=;
 b=ffKvNmcPoZwt7wrnqlG16P5hMEXSUPeJ8SLPGNy8M0u2DCXAWzvrpK4JFAKmv/cFcdIurW
 YwEE2trHQQwBk4iVhT4o33M2oyGCNaxE6s7/gaKPh0+vgNe3Hmr8kHExSQwNAxh2cD6j4Z
 6Ckz0gIp19wPrkxwYJLk2oKj8K0b44w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-KOyUMIbCPv6dmBb61PSvBQ-1; Tue, 12 Mar 2024 10:02:29 -0400
X-MC-Unique: KOyUMIbCPv6dmBb61PSvBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20454800262;
 Tue, 12 Mar 2024 14:02:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F1781C060CE;
 Tue, 12 Mar 2024 14:02:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 1/5] ui/vnc: Respect bound console
Date: Tue, 12 Mar 2024 18:02:12 +0400
Message-ID: <20240312140216.313618-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240312140216.313618-1-marcandre.lureau@redhat.com>
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

ui/vnc may have a bound console so pass it to qemu_console_is_graphic()
and qemu_text_console_put_keysym().

Fixes: 1d0d59fe2919 ("vnc: allow binding servers to qemu consoles")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231211-vnc-v1-1-a3551d284809@daynix.com>
---
 ui/vnc.c | 59 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index af20d24534..fc12b343e2 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1931,7 +1931,8 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
     }
 
     qkbd_state_key_event(vs->vd->kbd, qcode, down);
-    if (!qemu_console_is_graphic(NULL)) {
+    if (!qemu_console_is_graphic(vs->vd->dcl.con)) {
+        QemuTextConsole *con = QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
         bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);
         bool control = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
         /* QEMU console emulation */
@@ -1945,88 +1946,88 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
             case 0xb8:                          /* Right ALT */
                 break;
             case 0xc8:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_UP);
+                qemu_text_console_put_keysym(con, QEMU_KEY_UP);
                 break;
             case 0xd0:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_DOWN);
+                qemu_text_console_put_keysym(con, QEMU_KEY_DOWN);
                 break;
             case 0xcb:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_LEFT);
+                qemu_text_console_put_keysym(con, QEMU_KEY_LEFT);
                 break;
             case 0xcd:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_RIGHT);
+                qemu_text_console_put_keysym(con, QEMU_KEY_RIGHT);
                 break;
             case 0xd3:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_DELETE);
+                qemu_text_console_put_keysym(con, QEMU_KEY_DELETE);
                 break;
             case 0xc7:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_HOME);
+                qemu_text_console_put_keysym(con, QEMU_KEY_HOME);
                 break;
             case 0xcf:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_END);
+                qemu_text_console_put_keysym(con, QEMU_KEY_END);
                 break;
             case 0xc9:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEUP);
+                qemu_text_console_put_keysym(con, QEMU_KEY_PAGEUP);
                 break;
             case 0xd1:
-                qemu_text_console_put_keysym(NULL, QEMU_KEY_PAGEDOWN);
+                qemu_text_console_put_keysym(con, QEMU_KEY_PAGEDOWN);
                 break;
 
             case 0x47:
-                qemu_text_console_put_keysym(NULL, numlock ? '7' : QEMU_KEY_HOME);
+                qemu_text_console_put_keysym(con, numlock ? '7' : QEMU_KEY_HOME);
                 break;
             case 0x48:
-                qemu_text_console_put_keysym(NULL, numlock ? '8' : QEMU_KEY_UP);
+                qemu_text_console_put_keysym(con, numlock ? '8' : QEMU_KEY_UP);
                 break;
             case 0x49:
-                qemu_text_console_put_keysym(NULL, numlock ? '9' : QEMU_KEY_PAGEUP);
+                qemu_text_console_put_keysym(con, numlock ? '9' : QEMU_KEY_PAGEUP);
                 break;
             case 0x4b:
-                qemu_text_console_put_keysym(NULL, numlock ? '4' : QEMU_KEY_LEFT);
+                qemu_text_console_put_keysym(con, numlock ? '4' : QEMU_KEY_LEFT);
                 break;
             case 0x4c:
-                qemu_text_console_put_keysym(NULL, '5');
+                qemu_text_console_put_keysym(con, '5');
                 break;
             case 0x4d:
-                qemu_text_console_put_keysym(NULL, numlock ? '6' : QEMU_KEY_RIGHT);
+                qemu_text_console_put_keysym(con, numlock ? '6' : QEMU_KEY_RIGHT);
                 break;
             case 0x4f:
-                qemu_text_console_put_keysym(NULL, numlock ? '1' : QEMU_KEY_END);
+                qemu_text_console_put_keysym(con, numlock ? '1' : QEMU_KEY_END);
                 break;
             case 0x50:
-                qemu_text_console_put_keysym(NULL, numlock ? '2' : QEMU_KEY_DOWN);
+                qemu_text_console_put_keysym(con, numlock ? '2' : QEMU_KEY_DOWN);
                 break;
             case 0x51:
-                qemu_text_console_put_keysym(NULL, numlock ? '3' : QEMU_KEY_PAGEDOWN);
+                qemu_text_console_put_keysym(con, numlock ? '3' : QEMU_KEY_PAGEDOWN);
                 break;
             case 0x52:
-                qemu_text_console_put_keysym(NULL, '0');
+                qemu_text_console_put_keysym(con, '0');
                 break;
             case 0x53:
-                qemu_text_console_put_keysym(NULL, numlock ? '.' : QEMU_KEY_DELETE);
+                qemu_text_console_put_keysym(con, numlock ? '.' : QEMU_KEY_DELETE);
                 break;
 
             case 0xb5:
-                qemu_text_console_put_keysym(NULL, '/');
+                qemu_text_console_put_keysym(con, '/');
                 break;
             case 0x37:
-                qemu_text_console_put_keysym(NULL, '*');
+                qemu_text_console_put_keysym(con, '*');
                 break;
             case 0x4a:
-                qemu_text_console_put_keysym(NULL, '-');
+                qemu_text_console_put_keysym(con, '-');
                 break;
             case 0x4e:
-                qemu_text_console_put_keysym(NULL, '+');
+                qemu_text_console_put_keysym(con, '+');
                 break;
             case 0x9c:
-                qemu_text_console_put_keysym(NULL, '\n');
+                qemu_text_console_put_keysym(con, '\n');
                 break;
 
             default:
                 if (control) {
-                    qemu_text_console_put_keysym(NULL, sym & 0x1f);
+                    qemu_text_console_put_keysym(con, sym & 0x1f);
                 } else {
-                    qemu_text_console_put_keysym(NULL, sym);
+                    qemu_text_console_put_keysym(con, sym);
                 }
                 break;
             }
@@ -2044,7 +2045,7 @@ static void key_event(VncState *vs, int down, uint32_t sym)
     int keycode;
     int lsym = sym;
 
-    if (lsym >= 'A' && lsym <= 'Z' && qemu_console_is_graphic(NULL)) {
+    if (lsym >= 'A' && lsym <= 'Z' && qemu_console_is_graphic(vs->vd->dcl.con)) {
         lsym = lsym - 'A' + 'a';
     }
 
-- 
2.44.0


