Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE3E69186
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXBw-0001c5-B7; Fri, 22 Nov 2024 12:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.eads@gmail.com>)
 id 1tEXBt-0001au-H4; Fri, 22 Nov 2024 12:11:33 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.eads@gmail.com>)
 id 1tEXBr-0005ho-Gj; Fri, 22 Nov 2024 12:11:33 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-460c2418e37so15281911cf.0; 
 Fri, 22 Nov 2024 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732295490; x=1732900290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izQJKG6QF25GAEH564C0myRJVqYdt1T0ELVAI90Dfrs=;
 b=dk1jrvAMV5s+dGzNyNvZbHABOt7SsQFozjyJJYKmZ+L9fNnf8Ex6wCk1/78Xm2fgt4
 l8DEET3LSGzlktAYllOHq4wH9ijBh13IMN0UkVlPW1O3O4hVLvYHMYBz726wyT4fflhe
 D+2XPj4vStvIIjSSsOJ8jL5tn7s6ZOkG0kS/1drRMlJG5OvnokueL39fQRABX9IwJdjM
 kXoTGHvoRZpmhGKdzc7ogYIWAFubynGfSMEmiTrFxwGHb6Uo3C+F/PuQgMMT6fr8OI6c
 E1634PFv6p45UtvhLLbF4Owv5zcRCm9BAmedq7RbBZqkIyv8Rq3QbUjkPHTbbnbfPs2G
 zUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732295490; x=1732900290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izQJKG6QF25GAEH564C0myRJVqYdt1T0ELVAI90Dfrs=;
 b=LAhLSKigIG7za+4Z2v5IfYhIOmtXFtMYQ19dwvO08CM4mA2cKy4xKvtv2WuncLoJ4E
 ZghRHlcWHPcadX9ppLHvU9Ai6yp0hKEpMCoQgXZRd0pEwCY07S4ENyL+Ak7G+094M20C
 goGMqbtG2kLtXy0vCcf8qW7cjp83INYKTeqtv9JAobqpZBL5tivv2fdlJ0ThD15+Alfv
 MoVq+Z6fCgO5SwGzeiU2UglJ/q2YI/XC104JjNzTnOB6TlFMmIU9dgj353a0i5cfFVmG
 lkve64/jOYm1/k9YZ/BJyMtKIzsvoDkMLixrk0wvGYX8F/EgyhSw9sHJjzixXL7mm7hf
 nUCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUChWF5KuuQS3fnQ1S85o/3/aNC+P1hYJrt4ZUQWipr1ldBZVkNYIQ/IejEE+Zu5Ou9sCjMbjPW1S07@nongnu.org,
 AJvYcCXuiBPdoifjkKntnDlOD7ndrUFSpmdRU9C6H25OCNpSW2h2Tf1I0GGBNr3Bi8H7FuJWIZPVZa7WMLA=@nongnu.org
X-Gm-Message-State: AOJu0Yw7UaOjq6x/NpNe9uXYvRE6yT6xEHci5s5TTcAKPy41IKeqX9pn
 yIBSA4hdbGFZWFiBrDc/AC8fElusOUsNcVkZYe9MpvX6Znh39ZHe
X-Gm-Gg: ASbGncveXLiLhJRGaHarLOqUoSTWCF93aOkz6G55/InNAhW9YZ2AbTurJbPZt+8oUlR
 /MhJAFRtXCZg+Ns53tLBvm2GxCdprNLyPg9Ld68ESvWavYP0xinNGPkPMlewSYkghA8aS5eH+WK
 fFVDRQde6GtAF2VjL7fVW7marew4c3HwrNm4imcbNWldzrtzPbrMKUuqr/xOxe9AF7QyAq0tjKj
 oCjVF9Y+SigOAxJtyBWi09Ag9Dy6gq9kyiZiocy8qx7MMjqIRlkboAXW8kZ9n1EBI/HqTyvKsFV
 Bysp4oDkDecXGuvjBk5va1RGQ/4Voc96JSSQm0dr
X-Google-Smtp-Source: AGHT+IF+nz8GJd9NgBxsAE0qG5YvL2/Sioi+MVPiSCw0WNFKDlun6rGlD00K/SZeJ8Yz8Ctki1y1Fg==
X-Received: by 2002:a05:622a:1e8e:b0:460:ab29:e6b1 with SMTP id
 d75a77b69052e-4653d617eb8mr48438801cf.44.1732295489785; 
 Fri, 22 Nov 2024 09:11:29 -0800 (PST)
Received: from tungsten-chungus.. (c-174-169-154-147.hsd1.nh.comcast.net.
 [174.169.154.147]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c3d7189sm13730381cf.14.2024.11.22.09.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 09:11:29 -0800 (PST)
From: Patrick Eads <patrick.eads@gmail.com>
X-Google-Original-From: Patrick Eads <peads@users.noreply.github.com>
To: 
Cc: Patrick Eads <patrick.eads@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-ppc@nongnu.org (open list:New World (mac99)),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 2/2] Added support for WACOM 2.x/ArtZ/Digitizer II
Date: Fri, 22 Nov 2024 17:10:52 +0000
Message-ID: <20241122171101.2370389-3-peads@users.noreply.github.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122171101.2370389-1-peads@users.noreply.github.com>
References: <20241122171101.2370389-1-peads@users.noreply.github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=patrick.eads@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Patrick Eads <patrick.eads@gmail.com>

streamlined efficiency since setting the xy-values to zero is not the correct way by adding state variables against which the new xy-values can be compared

added other buttons

Signed-off-by: Patrick Eads <patrick.eads@gmail.com>
---
 hw/input/adb-wacom.c  | 50 +++++++++++++++++++++++++++----------------
 hw/input/trace-events |  2 +-
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/hw/input/adb-wacom.c b/hw/input/adb-wacom.c
index 1e8fb83cf4..91df9508d4 100644
--- a/hw/input/adb-wacom.c
+++ b/hw/input/adb-wacom.c
@@ -37,6 +37,7 @@ struct WacomState {
     QemuInputHandlerState *hs;
     int buttons_state, last_buttons_state;
     uint16_t dx, dy, dz;
+    uint16_t last_x, last_y;
 };
 
 struct ADBWacomClass {
@@ -47,8 +48,11 @@ struct ADBWacomClass {
     DeviceRealize parent_realize;
 };
 
-#define ADB_WACOM_BUTTON_LEFT   0x01
-#define ADB_WACOM_BUTTON_RIGHT  0x02
+#define ADB_WACOM_BUTTON_MIDDLE     0x01
+#define ADB_WACOM_BUTTON_LEFT       0x02
+#define ADB_WACOM_BUTTON_RIGHT      0x04
+#define ADB_WACOM_BUTTON_SIDE       0x08
+#define ADB_WACOM_BUTTON_EXTRA      0x10
 
 static void adb_wacom_handle_event(DeviceState *dev, QemuConsole *src,
                                     InputEvent *evt) {
@@ -56,8 +60,11 @@ static void adb_wacom_handle_event(DeviceState *dev, QemuConsole *src,
     InputMoveEvent *move;
     InputBtnEvent *btn;
     static const int bmap[INPUT_BUTTON__MAX] = {
-            [INPUT_BUTTON_LEFT]   = ADB_WACOM_BUTTON_LEFT,
-            [INPUT_BUTTON_RIGHT]  = ADB_WACOM_BUTTON_RIGHT,
+            [INPUT_BUTTON_LEFT]        = ADB_WACOM_BUTTON_LEFT,
+            [INPUT_BUTTON_RIGHT]       = ADB_WACOM_BUTTON_RIGHT,
+            [INPUT_BUTTON_MIDDLE]      = ADB_WACOM_BUTTON_MIDDLE,
+            [INPUT_BUTTON_SIDE]        = ADB_WACOM_BUTTON_SIDE,
+            [INPUT_BUTTON_EXTRA]       = ADB_WACOM_BUTTON_EXTRA
     };
 
     switch (evt->type) {
@@ -68,12 +75,10 @@ static void adb_wacom_handle_event(DeviceState *dev, QemuConsole *src,
                 case INPUT_AXIS_X:
                     // Digitizer II / Artz lpi 2540 => dpi 5080
                     s->dx = (uint16_t) (move->value * qemu_console_get_width(src, 640) / 2450);
-//                    s->dx = (uint16_t) (move->value * qemu_console_get_width(src, 640) / 5080);
                     break;
                 case INPUT_AXIS_Y:
                     // 6x8 inch interactive surface => 4:3 aspect ratio
                     s->dy = (uint16_t) (move->value * qemu_console_get_height(src, 480) / 1905);
-//                    s->dy = (uint16_t) (move->value * qemu_console_get_height(src, 480) / 3810);
                     break;
                 default:
                     break;
@@ -111,7 +116,10 @@ static const QemuInputHandler adb_wacom_handler = {
 static int adb_wacom_poll(ADBDevice *d, uint8_t *obuf) {
     WacomState *s = ADB_WACOM(d);
 
-    if (s->last_buttons_state == s->buttons_state && !(s->dx || s->dy)) {
+    // if state of button(s) or coordinates have changed since last poll
+    if (!(s->last_buttons_state != s->buttons_state
+        || s->dx != s->last_x
+        || s->dy != s->last_y)) {
         return 0;
     }
     // Not quite any of the WACOM II-S/IV/IVe, BitPad One/Two, or MM 1201/961
@@ -121,12 +129,13 @@ static int adb_wacom_poll(ADBDevice *d, uint8_t *obuf) {
     // with ADB unlike with a standard serial bus, the packet can be condensed
     // into five bytes instead of requiring seven.
     s->last_buttons_state = s->buttons_state;
-    obuf[0] = 0xC0 | ((s->dx >> 8) & 0x3F);
+    s->last_x = s->dx;
+    s->last_y = s->dy;
+    obuf[0] = (0xC0 | ((s->dx >> 8) & 0x3F)) & 0xFF;
     obuf[1] = s->dx & 0xFF;
-    obuf[2] = ((s->dy >> 8) & 0xFF);
+    obuf[2] = (s->dy >> 8) & 0xFF;
     obuf[3] = s->dy & 0xFF;
-    obuf[4] = s->buttons_state;
-    s->dx = s->dy = 0;
+    obuf[4] = s->buttons_state & 0xFF;
     return 5;
 }
 
@@ -138,10 +147,8 @@ static int adb_wacom_request(ADBDevice *d, uint8_t *obuf, const uint8_t *buf,
 
     if ((buf[0] & 0x0f) == ADB_FLUSH) {
         /* flush wacom fifo */
-        s->buttons_state = s->last_buttons_state;
-        s->dx = 0;
-        s->dy = 0;
-        s->dz = 0;
+        s->last_buttons_state = s->buttons_state = 0;
+        s->last_x = s->last_y = s->dx = s->dy = s->dz = 0;
         trace_adb_device_wacom_flush();
         return 0;
     }
@@ -153,9 +160,9 @@ static int adb_wacom_request(ADBDevice *d, uint8_t *obuf, const uint8_t *buf,
         case ADB_WRITEREG:
             switch (reg) {
                 default:
-//                case 1: // receives 0xFE0449 on initialization. seems to be settings packet
+                case 1: // receives 0xFE0449 on initialization. seems to be settings packet
                         // described (the manual, p. 47)?
-//                case 2: // receives 0x204A when modifying certain settings in control panel
+                case 2: // receives 0x204A when modifying certain settings in control panel
                         // doesn't seem to vary based on settings values chosen.
                     break;
                 case 3:
@@ -170,6 +177,9 @@ static int adb_wacom_request(ADBDevice *d, uint8_t *obuf, const uint8_t *buf,
                     }
 
                     switch (buf[2]) {
+                        case 'h':
+                            d->devaddr = (buf[0] & 0xF0) >> 4;
+                            break;
                         case ADB_CMD_SELF_TEST:
                             break;
                         case ADB_CMD_CHANGE_ID:
@@ -191,7 +201,7 @@ static int adb_wacom_request(ADBDevice *d, uint8_t *obuf, const uint8_t *buf,
                             break;
                     }
             }
-            if (reg != 3) trace_adb_device_wacom_writereg(reg, *(uint64_t *) buf);
+            trace_adb_device_wacom_writereg(reg, *(uint64_t *) buf);
             break;
         case ADB_READREG:
             switch (reg) {
@@ -245,7 +255,7 @@ static void adb_wacom_reset(DeviceState *dev) {
     d->handler = 0x3A;
     d->devaddr = ADB_DEVID_TABLET;
     s->last_buttons_state = s->buttons_state = 0;
-    s->dx = s->dy = s->dz = 0;
+    s->last_x = s->last_y = s->dx = s->dy = s->dz = 0;
 }
 
 static const VMStateDescription vmstate_adb_wacom = {
@@ -257,6 +267,8 @@ static const VMStateDescription vmstate_adb_wacom = {
                                ADBDevice),
                 VMSTATE_INT32(buttons_state, WacomState),
                 VMSTATE_INT32(last_buttons_state, WacomState),
+                VMSTATE_UINT16(last_x, WacomState),
+                VMSTATE_UINT16(last_y, WacomState),
                 VMSTATE_UINT16(dx, WacomState),
                 VMSTATE_UINT16(dy, WacomState),
                 VMSTATE_UINT16(dz, WacomState),
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 90e9f61dc2..610955245f 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -17,7 +17,7 @@ adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "chan
 # adb-wacom.c
 adb_device_wacom_flush(void) "flush"
 adb_device_wacom_writereg(int reg, uint64_t buf) "\t<- reg %d buf 0x%04lX"
-adb_device_wacom_readreg(int reg, uint64_t obut) "\t-> reg %d obuf 0x%04lX"
+adb_device_wacom_readreg(int reg, uint64_t obuf) "\t-> reg %d obuf 0x%04lX"
 adb_device_wacom_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
 # adb.c
-- 
2.45.2


