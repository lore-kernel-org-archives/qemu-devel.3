Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE79C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwOm-0004Be-Op; Wed, 20 Mar 2024 09:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwOl-0004Ai-6a
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rmwOj-0000BA-6O
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710942868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hd7LmA408dvHfo5kRnbpaogkLqac1ZzU7woAzEbOZcM=;
 b=a9bk0C5Ce1qyqJlzp6G0FSzdlTM1gs9KFg+135shxW25f2Xq+HEtro9kQepG7mAGgpuNOp
 KHWYnqovmOqB0JW0oRxYudDRfh2otNyV80tFYvhIKHxdvqBxOjPlUKe0b0t/cqtMD2lQt2
 8LfBzUpaetLQUrWljRLQC7BybNsbM4Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-qbo5EUDpP7OV8an0IpsA-A-1; Wed, 20 Mar 2024 09:54:25 -0400
X-MC-Unique: qbo5EUDpP7OV8an0IpsA-A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A7381A285;
 Wed, 20 Mar 2024 13:54:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B286492BCA;
 Wed, 20 Mar 2024 13:54:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/5] ui/cocoa: Do not use console_select()
Date: Wed, 20 Mar 2024 17:53:47 +0400
Message-ID: <20240320135349.2139402-4-marcandre.lureau@redhat.com>
In-Reply-To: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
References: <20240320135349.2139402-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

ui/cocoa needs to update the UI info and reset the keyboard state
tracker when switching the console, or the new console will see the
stale UI info or keyboard state. Previously, updating the UI info was
done with cocoa_switch(), but it is meant to be called when the surface
is being replaced, and may be called even when not switching the
console. ui/cocoa never reset the keyboard state, which resulted in
stuck keys.

Add ui/cocoa's own implementation of console_select(), which updates the
UI info and resets the keyboard state tracker.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240319-console-v2-3-3fd6feef321a@daynix.com>
---
 ui/cocoa.m | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd..810751cf26 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -102,6 +102,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
 };
+static QKbdState *kbd;
 static int cursor_hide = 1;
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
@@ -309,7 +310,6 @@ @interface QemuCocoaView : NSView
     NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
-    QKbdState *kbd;
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
@@ -361,7 +361,6 @@ - (id)initWithFrame:(NSRect)frameRect
 
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
-        kbd = qkbd_state_init(dcl.con);
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
@@ -378,8 +377,6 @@ - (void) dealloc
         pixman_image_unref(pixman_image);
     }
 
-    qkbd_state_free(kbd);
-
     if (eventsTap) {
         CFRelease(eventsTap);
     }
@@ -429,6 +426,20 @@ - (void) viewWillMoveToWindow:(NSWindow *)newWindow
     [self removeTrackingRect];
 }
 
+- (void) selectConsoleLocked:(unsigned int)index
+{
+    QemuConsole *con = qemu_console_lookup_by_index(index);
+    if (!con) {
+        return;
+    }
+
+    unregister_displaychangelistener(&dcl);
+    qkbd_state_switch_console(kbd, con);
+    dcl.con = con;
+    register_displaychangelistener(&dcl);
+    [self updateUIInfo];
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -718,7 +729,8 @@ - (void) handleMonitorInput:(NSEvent *)event
     }
 
     if (keysym) {
-        qemu_text_console_put_keysym(NULL, keysym);
+        QemuTextConsole *con = QEMU_TEXT_CONSOLE(dcl.con);
+        qemu_text_console_put_keysym(con, keysym);
     }
 }
 
@@ -898,7 +910,7 @@ - (bool) handleEventLocked:(NSEvent *)event
 
                         // enable graphic console
                         case '1' ... '9':
-                            console_select(key - '0' - 1); /* ascii math */
+                            [self selectConsoleLocked:key - '0' - 1]; /* ascii math */
                             return true;
 
                         // release the mouse grab
@@ -909,7 +921,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                 }
             }
 
-            if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(dcl.con)) {
                 qkbd_state_key_event(kbd, keycode, true);
             } else {
                 [self handleMonitorInput: event];
@@ -924,7 +936,7 @@ - (bool) handleEventLocked:(NSEvent *)event
                 return true;
             }
 
-            if (qemu_console_is_graphic(NULL)) {
+            if (qemu_console_is_graphic(dcl.con)) {
                 qkbd_state_key_event(kbd, keycode, false);
             }
             return true;
@@ -1374,7 +1386,7 @@ - (void)toggleZoomInterpolation:(id) sender
 - (void)displayConsole:(id)sender
 {
     with_bql(^{
-        console_select([sender tag]);
+        [cocoaView selectConsoleLocked:[sender tag]];
     });
 }
 
@@ -1945,7 +1957,6 @@ static void cocoa_switch(DisplayChangeListener *dcl,
     pixman_image_ref(image);
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        [cocoaView updateUIInfo];
         [cocoaView switchSurface:image];
     });
 }
@@ -1955,7 +1966,7 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
-    graphic_hw_update(NULL);
+    graphic_hw_update(dcl->con);
 
     if (qemu_input_is_absolute(dcl->con)) {
         dispatch_async(dispatch_get_main_queue(), ^{
@@ -2039,8 +2050,12 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     add_console_menu_entries();
     addRemovableDevicesMenuItems();
 
+    dcl.con = qemu_console_lookup_default();
+    kbd = qkbd_state_init(dcl.con);
+
     // register vga output callbacks
     register_displaychangelistener(&dcl);
+    [cocoaView updateUIInfo];
 
     qemu_event_init(&cbevent, false);
     cbowner = [[QemuCocoaPasteboardTypeOwner alloc] init];
-- 
2.44.0


