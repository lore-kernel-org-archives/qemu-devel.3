Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3665CD59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8inH-0008Im-7g; Wed, 06 Nov 2024 11:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8inF-0008IU-Sv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:22:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8inB-0000CH-NP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730910118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NQvBjLobvmM1bkG98S18JcM/uZx1quEAFCJC3F0rSqI=;
 b=aXLaTjHgr8IZuIVJ3TzX+Tf98dicMLlvo5TdQD8wIrAYULr+uPMeoTAr0IbXpg+SAQTwbZ
 YgBnfJh+IpJjiWLU9fEWUmt5HDsPiXfK0lTBCFhjGL3Zhbfj6vC9e32dCIvUk374KNCXtv
 j2tTG80N5bMlxdkIJD3kevEg/4cPgs8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-n2fAmXABO0OzvmKAzimSwg-1; Wed, 06 Nov 2024 11:21:55 -0500
X-MC-Unique: n2fAmXABO0OzvmKAzimSwg-1
X-Mimecast-MFC-AGG-ID: n2fAmXABO0OzvmKAzimSwg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d43e7acd9so3382964f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730910113; x=1731514913;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NQvBjLobvmM1bkG98S18JcM/uZx1quEAFCJC3F0rSqI=;
 b=KQMvdO+m5KroZG8y4gzws6rMFZsWyX7UE6q3ZrzdAkx3HkMG6CjnoqFThpeNgp6POf
 no4/J8/YUEG+zPA5/Mimbhiya6tWqJKSML4eMa/xzlSnYek9dpW4A0JGQuHJDyYnOVfW
 BeOoNlrlWMYYytfwrutQcx0tenty/8+KF96s/0BcOKx9ubkCAIIR/iPmBUBfJEOFnOYk
 c8OSU14ndRCPlB4pUUU0r5/MgaXrEmIbZEiQwz15FJu2qVUKE/lk9XwrjgKDFKLtYaEL
 1GoKqxd74BNKFPVqoaEvTEGrbkEpzJsbXuNeAY8erhnITgbWgU52rUuppUrfZf/W38pW
 GJIA==
X-Gm-Message-State: AOJu0YwjVGeCxqVZ/XZSbEXBMNfokndYo9580Ja97Pn87torqqHsjcFP
 XHsQ/rUX7xaUeUsdJ/BKxCjNbjmHP2fi64qoyLrKi54gvmMRO49WFOMF2LGzkxkelgCxsqgYHJx
 8dFSRRmSRoW9pLXLy4ioEca9RuMCYlkP5hKx2d0sIPbh0GhZqmAfaKf8KGmdB5JyIaVVhvLID4H
 tQidGFwHniCxih5A071/AfK9YFMRtqhyHJdXVQe6A=
X-Received: by 2002:a5d:5cce:0:b0:37d:446a:9e60 with SMTP id
 ffacd0b85a97d-38060ffe8cbmr28392053f8f.0.1730910113602; 
 Wed, 06 Nov 2024 08:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGP5tVfjHKTJNUYjj7QP0lNuSpwb5/UI4PxWH/FRU9TCC3c4zIuPkYPf+H0XKzlnmGXaLsdA==
X-Received: by 2002:a5d:5cce:0:b0:37d:446a:9e60 with SMTP id
 ffacd0b85a97d-38060ffe8cbmr28391999f8f.0.1730910112162; 
 Wed, 06 Nov 2024 08:21:52 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e6b5sm19845061f8f.88.2024.11.06.08.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 08:21:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH RFT] cocoa: Remove deprecated
 CVDisplayLinkCreateWithCGDisplay() calls
Date: Wed,  6 Nov 2024 17:21:50 +0100
Message-ID: <20241106162150.522782-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When building on macOS 15 we get:

../../ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is deprecated:
    first deprecated in macOS 15.0
    - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:),
      or NSScreen.displayLink(target:selector:)
    [-Werror,-Wdeprecated-declarations]
  662 |         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
      |              ^

Instead get the refresh rate from either CGDisplayModeGetRefreshRate or IOKit,
following the model of https://github.com/gwm17/glfw/commit/4ec7daf3e92.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2575
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build |  2 +-
 ui/cocoa.m  | 90 ++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index c386593c527..b12ccc12223 100644
--- a/meson.build
+++ b/meson.build
@@ -1135,7 +1135,7 @@ if get_option('attr').allowed()
 endif
 
 cocoa = dependency('appleframeworks',
-                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
+                   modules: ['Cocoa', 'IOKit', 'QuartzCore'],
                    required: get_option('cocoa'))
 
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd335323..e3330d41500 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #import <Cocoa/Cocoa.h>
+#import <IOKit/IOKitLib.h>
 #import <QuartzCore/QuartzCore.h>
 #include <crt_externs.h>
 
@@ -292,6 +293,75 @@ static void handleAnyDeviceErrors(Error * err)
     }
 }
 
+static bool get_fallback_refresh_rate(CGDirectDisplayID displayID, double *p_rate)
+{
+    bool found = false;
+    io_iterator_t it;
+    io_service_t service;
+    CFNumberRef indexRef, clockRef, countRef;
+    uint32_t clock, count;
+
+    if (IOServiceGetMatchingServices(kIOMasterPortDefault,
+                                     IOServiceMatching("IOFramebuffer"),
+                                     &it) != 0) {
+        return false;
+    }
+    while ((service = IOIteratorNext(it)) != 0) {
+        uint32_t index;
+        bool found_display_id;
+        indexRef = IORegistryEntryCreateCFProperty(service,
+                                                   CFSTR("IOFramebufferOpenGLIndex"),
+                                                   kCFAllocatorDefault,
+                                                   kNilOptions);
+        if (!indexRef) {
+            continue;
+        }
+        found_display_id =
+            CFNumberGetValue(indexRef, kCFNumberIntType, &index) &&
+            CGOpenGLDisplayMaskToDisplayID(1 << index) == displayID;
+        CFRelease(indexRef);
+        if (found_display_id) {
+            break;
+        }
+    }
+    if (!service) {
+        goto out;
+    }
+
+    clockRef = IORegistryEntryCreateCFProperty(service,
+                                               CFSTR("IOFBCurrentPixelClock"),
+                                               kCFAllocatorDefault,
+                                               kNilOptions);
+    if (!clockRef) {
+        goto out;
+    }
+    if (!CFNumberGetValue(clockRef, kCFNumberIntType, &clock) || !clock) {
+        goto out_clock_ref;
+    }
+
+    countRef = IORegistryEntryCreateCFProperty(service,
+                                               CFSTR("IOFBCurrentPixelCount"),
+                                               kCFAllocatorDefault,
+                                               kNilOptions);
+    if (!countRef) {
+        goto out_clock_ref;
+    }
+    if (!CFNumberGetValue(countRef, kCFNumberIntType, &count) || !count) {
+        goto out_count_ref;
+    }
+
+    *p_rate = clock / (double) count;
+    found = true;
+
+out_count_ref:
+    CFRelease(countRef);
+out_clock_ref:
+    CFRelease(clockRef);
+out:
+    IOObjectRelease(it);
+    return found;
+}
+
 /*
  ------------------------------------------------------
     QemuCocoaView
@@ -655,20 +725,16 @@ - (void) updateUIInfoLocked
         NSSize screenSize = [[[self window] screen] frame].size;
         CGSize screenPhysicalSize = CGDisplayScreenSize(display);
         bool isFullscreen = ([[self window] styleMask] & NSWindowStyleMaskFullScreen) != 0;
-        CVDisplayLinkRef displayLink;
+        CGDisplayModeRef mode = CGDisplayCopyDisplayMode(display);
+        double rate = CGDisplayModeGetRefreshRate(mode);
+
+        if (rate != 0.0 || get_fallback_refresh_rate(display, &rate)) {
+            update_displaychangelistener(&dcl, 1000 / rate);
+            info.refresh_rate = (int64_t)1000 * rate;
+        }
+        CGDisplayModeRelease(mode);
 
         frameSize = isFullscreen ? [self screenSafeAreaSize] : [self frame].size;
-
-        if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
-            CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
-            CVDisplayLinkRelease(displayLink);
-            if (!(period.flags & kCVTimeIsIndefinite)) {
-                update_displaychangelistener(&dcl,
-                                             1000 * period.timeValue / period.timeScale);
-                info.refresh_rate = (int64_t)1000 * period.timeScale / period.timeValue;
-            }
-        }
-
         info.width_mm = frameSize.width / screenSize.width * screenPhysicalSize.width;
         info.height_mm = frameSize.height / screenSize.height * screenPhysicalSize.height;
     } else {
-- 
2.47.0


