Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B912C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncXi-0001J5-Cw; Fri, 22 Mar 2024 06:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rncXg-0001Id-ML
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:54:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rncXe-0005P2-R1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:54:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e00896dfdcso12822565ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711104869; x=1711709669;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTLbnQPEPDwoXUWi2uYp+x2vsIJP3Gey84NQIdKmYME=;
 b=vRuFdnk7WGSeEz6UhaFKZBqgw7k5T6XYDHKBscK3DP9+dZyilvUJ/scxGY/qcmHedX
 sUMBVhLP8k10TzF130Bpu7bIAOK1SaEB6z/GkpeWrk4pJo7hdmdd8SB7KrtMn3MPoPNF
 /g04XV6PXz8pSC/WAkq31lYY7BttibD1UEbbyxxma5ztSYLrEJ+rOe7bldU87rpZTWlV
 QJGPRXAIc9zV0MWfbdx9NM5KqF8H64nCAJDbq9BGcm2bcbqZRip1vhrktstAvBID1TOL
 hAP9EEy30616ltZELkDpaMCH1bm+D3Qum1nl2JgZe7vsf4Tq7IPSMBcLhF3t5S93e3SN
 w3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711104869; x=1711709669;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VTLbnQPEPDwoXUWi2uYp+x2vsIJP3Gey84NQIdKmYME=;
 b=dvof88I8vHGx5zkAJor/JEZE/LmDG8kxrOJNq4mZLX75M5glKLDX4s/vLL7cWX8I11
 dfGUcAHdh9JO+4JhfRhBSZDJdQ9Dob7b+l2P/9aazlLgGzWMUjt/v/45p4bv1CyuV1nv
 noRTybeOsa/HxC1zRppHCENzOpxo3lWnBQ579iHHH6q5xh5LZkByXOzFnB4yqjx8nnss
 DLRsUUt33NOCjg9/Mxpmg4KSN3pUFSY85qutY8OocRUaGKsQ5+KMwpTZcBg4/AtPtPGm
 WNh5UlRQ0TQOeFH9Lb+XgHwL+PInqR1gZfGG2QOfoVgZnI5yf94uzVb9U8ajHp8s6LO5
 qdWg==
X-Gm-Message-State: AOJu0YzlzuC6FhrXLY9TN2pINpPZFqPQPIYxlYAjWf/zJhlwhN919nox
 E+LVzPMIg12WqOC3Wwi12KOPKWLHu6IrU9iEy8Zl5sFfDUeX5S6lhCEt7yrowo8=
X-Google-Smtp-Source: AGHT+IFHFfW4r4qcv8ugH6c0W5g2PL41y5qxRdnc8hhQgPEOGCaQSL2rleGSI1g6rC4gfsbx1H+t9g==
X-Received: by 2002:a17:903:2448:b0:1dd:c93c:580c with SMTP id
 l8-20020a170903244800b001ddc93c580cmr2532422pls.4.1711104868887; 
 Fri, 22 Mar 2024 03:54:28 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 k12-20020a170902f28c00b001def088c036sm1616860plc.19.2024.03.22.03.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 03:54:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Mar 2024 19:54:25 +0900
Subject: [PATCH] ui/cocoa: Use qemu_add_mouse_change_notifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-mouse-v1-1-0b7d4d9bdfbf@daynix.com>
X-B4-Tracking: v=1; b=H4sIAGBj/WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMj3dz80uJU3aSkZIO0REuDVIuUZCWg2oKi1LTMCrA50bG1tQDrqZw
 KVwAAAA==
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This eliminates the polling in cocoa_refresh and implements the
propagation of the mouse mode change from absolute to relative.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 62 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 810751cf2644..b53920b8814c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -310,6 +310,14 @@ @interface QemuCocoaView : NSView
     NSTrackingArea *trackingArea;
     QEMUScreen screen;
     pixman_image_t *pixman_image;
+    /* The state surrounding mouse grabbing is potentially confusing.
+     * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
+     *   pointing device an absolute-position one?"], but is only updated on
+     *   next refresh.
+     * isMouseGrabbed tracks whether GUI events are directed to the guest;
+     *   it controls whether special keys like Cmd get sent to the guest,
+     *   and whether we capture the mouse when in non-absolute mode.
+     */
     BOOL isMouseGrabbed;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
@@ -321,17 +329,8 @@ - (void) setFullGrab:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (bool) handleEvent:(NSEvent *)event;
 - (bool) handleEventLocked:(NSEvent *)event;
-- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
-/* The state surrounding mouse grabbing is potentially confusing.
- * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
- *   pointing device an absolute-position one?"], but is only updated on
- *   next refresh.
- * isMouseGrabbed tracks whether GUI events are directed to the guest;
- *   it controls whether special keys like Cmd get sent to the guest,
- *   and whether we capture the mouse when in non-absolute mode.
- */
+- (void) notifyMouseModeChange;
 - (BOOL) isMouseGrabbed;
-- (BOOL) isAbsoluteEnabled;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
 @end
@@ -437,6 +436,7 @@ - (void) selectConsoleLocked:(unsigned int)index
     qkbd_state_switch_console(kbd, con);
     dcl.con = con;
     register_displaychangelistener(&dcl);
+    [self notifyMouseModeChange];
     [self updateUIInfo];
 }
 
@@ -1103,14 +1103,26 @@ - (void) ungrabMouse
     [self raiseAllButtons];
 }
 
-- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
+- (void) notifyMouseModeChange {
+    bool tIsAbsoluteEnabled = bool_with_bql(^{
+        return qemu_input_is_absolute(dcl.con);
+    });
+
+    if (tIsAbsoluteEnabled == isAbsoluteEnabled) {
+        return;
+    }
+
     isAbsoluteEnabled = tIsAbsoluteEnabled;
+
     if (isMouseGrabbed) {
-        CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
+        if (isAbsoluteEnabled) {
+            [self ungrabMouse];
+        } else {
+            CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
+        }
     }
 }
 - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
-- (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
 - (QEMUScreen) gscreen {return screen;}
 
 /*
@@ -1784,6 +1796,17 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
+static void cocoa_mouse_mode_change_notify(Notifier *notifier, void *data)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView notifyMouseModeChange];
+    });
+}
+
+static Notifier mouse_mode_change_notifier = {
+    .notify = cocoa_mouse_mode_change_notify
+};
+
 @interface QemuCocoaPasteboardTypeOwner : NSObject<NSPasteboardTypeOwner>
 @end
 
@@ -1968,17 +1991,6 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
     graphic_hw_update(dcl->con);
 
-    if (qemu_input_is_absolute(dcl->con)) {
-        dispatch_async(dispatch_get_main_queue(), ^{
-            if (![cocoaView isAbsoluteEnabled]) {
-                if ([cocoaView isMouseGrabbed]) {
-                    [cocoaView ungrabMouse];
-                }
-            }
-            [cocoaView setAbsoluteEnabled:YES];
-        });
-    }
-
     if (cbchangecount != [[NSPasteboard generalPasteboard] changeCount]) {
         qemu_clipboard_info_unref(cbinfo);
         cbinfo = qemu_clipboard_info_new(&cbpeer, QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
@@ -2055,6 +2067,8 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     // register vga output callbacks
     register_displaychangelistener(&dcl);
+    qemu_add_mouse_mode_change_notifier(&mouse_mode_change_notifier);
+    [cocoaView notifyMouseModeChange];
     [cocoaView updateUIInfo];
 
     qemu_event_init(&cbevent, false);

---
base-commit: fea445e8fe9acea4f775a832815ee22bdf2b0222
change-id: 20240322-mouse-bbc0fa90e8dc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


