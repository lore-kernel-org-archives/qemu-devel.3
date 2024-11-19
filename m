Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A374D6C2B4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 22:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDWYD-000823-4Z; Tue, 19 Nov 2024 17:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.eads@gmail.com>)
 id 1tDWYA-000807-9E; Tue, 19 Nov 2024 17:18:23 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.eads@gmail.com>)
 id 1tDWY7-0006T3-8g; Tue, 19 Nov 2024 17:18:22 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6eebb54fc48so4253707b3.1; 
 Tue, 19 Nov 2024 14:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732054697; x=1732659497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ClOm6z1mywJC9F9eSi7Piry3fhwxwfqw4breY7fRkWI=;
 b=TEWal8zx9Hot85Mp4qBwWqHIrjfz6HHpHEkHbVkoeuu95rZ+q/agABtW1euMbTEC6p
 6868F+2t5OYVZIYiDeXWBgMtOopx2HIYf2kkUGo4NDg5zf2FeHyE21AQaYwwCGw6ZB25
 UOj0+cPtktiT6sI34Sji4qpS1O2YFZzamwU+gB/X+W31+6WjLRPbVJDiIYWoMgHL0Kb4
 yMRn8jtbxOrQNVDmFb/eOhkpEjmDQbI77ygBRhLLHOkowukHs7IHZCERwY22Y4i6CsxZ
 QOuk/t/ZLEKnDSVs4KgD75G6J78psO6d0Xsa4VRK+wmes4eHlnSpwt3GGTf7T2zvf5Ms
 PScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732054697; x=1732659497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ClOm6z1mywJC9F9eSi7Piry3fhwxwfqw4breY7fRkWI=;
 b=w/hQj+4nsHRbV3kWGulwwl9SfbpUkNB2C1qqkf9Eo3QDhVkNW22vnTqb0s3M0z8NDY
 Lif144oNIIM2upC+h9f5gUojBZgd0cO3iqrBITEDU1OJ4NxbHFOIEWWWKTYMyBdSpybi
 tl134E67Y7PmSDlv7gnUV4HcPBLhRXMimbjiTv4BPDqb4+VHdY3sewYU2Kuqj5QT1SA6
 TmKBIZ21VKRrj8n7cadkosiDIlgTmx4ZPEtrVtFGJ0WQX9aw7TgwcdOqqOKN92uzxtkR
 +uL9kFcoo1Iz42IkI1vbmVp2JIhLneAzF3q4CW1niFVecuMpPoVuoAI7Lq+s1vEHZ2N9
 7zEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdijcKFNrpLSlylsU8BXil3Is0YQac9+lYI84iE0a56JwAzlCySrzcfsJKLr3NhDhbm/cC+nU3fy8=@nongnu.org,
 AJvYcCXXKEs+bzPf6cWRSqhUCAngTJuZ2NpMvAp1N9nUONmLJildz2UyC/A2vxFYlWHj1VmpoPbL4Z9D7caA@nongnu.org
X-Gm-Message-State: AOJu0YyJicZlbl+UQeEWK7z4GWb21NgzNKNMvMbbBIlX6kwj4DDBchhL
 ZY3NcAaaIFzn8AH5CdVis7PoIVnr5CdKd806H1RU+WjJEJlo4yjS7k5b/w==
X-Google-Smtp-Source: AGHT+IHYg0yX/aSjQDCBUSledlycuaRAbXgxJ70AebvN6CxNlb4FTImpovyyP/bYOTx2UD0q4JwIdA==
X-Received: by 2002:a05:690c:4c0f:b0:6ee:b8ab:56a1 with SMTP id
 00721157ae682-6eebd17f2a5mr6840897b3.20.1732054697015; 
 Tue, 19 Nov 2024 14:18:17 -0800 (PST)
Received: from tungsten-chungus.. (c-174-169-154-147.hsd1.nh.comcast.net.
 [174.169.154.147]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b479d91951sm10516785a.63.2024.11.19.14.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:18:16 -0800 (PST)
From: Patrick Eads <patrick.eads@gmail.com>
X-Google-Original-From: Patrick Eads <peads@users.noreply.github.com>
To: 
Cc: Patrick Eads <patrick.eads@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-ppc@nongnu.org (open list:New World (mac99)),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] Added support for WACOM 2.x/ArtZ/Digitizer II compatibility.
 It does require the driver (easily available via many of the classic macos
 archives),
 but it allows a simple way to have an absolute pointing device on
 ADB-compatible VMs.
Date: Tue, 19 Nov 2024 22:17:55 +0000
Message-ID: <20241119221758.1575779-1-peads@users.noreply.github.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=patrick.eads@gmail.com; helo=mail-yw1-x1135.google.com
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

init

Promising polling initiated and data moving cursor now

Reverted delete of dev handler for wacom tablet

got the y-axis!

getting closer

more progress. it appears to not quite be WACOM II/IV, but x-axis is controlled by the first 2-3 bytes

really? 12-bits is the key? oh well, x-axis get

it's like a weird mesh of adb extended and wacom's protocols. fine, y-axis get

x AND y

twiddling with the settings in the driver control panel works wonders!

zeroing in on the resolution / dpi scale calculation

addded commentary to describe source material and reverse engineering decisions

commentary editing

renamed to adb-wacom, s.t. that it is clear it requires the wacom driver

Signed-off-by: Patrick Eads <patrick.eads@gmail.com>
---
 hw/input/adb-mouse.c   |   1 +
 hw/input/adb-wacom.c   | 311 +++++++++++++++++++++++++++++++++++++++++
 hw/input/meson.build   |   2 +-
 hw/input/trace-events  |   6 +
 include/hw/input/adb.h |   1 +
 5 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 hw/input/adb-wacom.c

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 77b280d242..3404b83b84 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -202,6 +202,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
                  * 0x03: Mouse systems A3 trackball
                  * 0x04: Extended Apple Mouse Protocol
                  * 0x2f: Microspeed mouse
+                 * 0x3A: Wacom tablet
                  * 0x42: Macally
                  * 0x5f: Microspeed mouse
                  * 0x66: Microspeed mouse
diff --git a/hw/input/adb-wacom.c b/hw/input/adb-wacom.c
new file mode 100644
index 0000000000..1e8fb83cf4
--- /dev/null
+++ b/hw/input/adb-wacom.c
@@ -0,0 +1,311 @@
+/*
+ * QEMU ADB wacom support
+ *
+ * This file is part of the QEMU distribution
+ * (https://gitlab.com/qemu-project/qemu).
+ * Copyright (c) 2024 Patrick Eads.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 3.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "ui/console.h"
+#include "hw/input/adb.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "adb-internal.h"
+#include "trace.h"
+#include "qom/object.h"
+
+OBJECT_DECLARE_TYPE(WacomState, ADBWacomClass, ADB_WACOM)
+
+struct WacomState {
+    /*< public >*/
+    ADBDevice parent_obj;
+    /*< private >*/
+
+    QemuInputHandlerState *hs;
+    int buttons_state, last_buttons_state;
+    uint16_t dx, dy, dz;
+};
+
+struct ADBWacomClass {
+    /*< public >*/
+    ADBDeviceClass parent_class;
+    /*< private >*/
+
+    DeviceRealize parent_realize;
+};
+
+#define ADB_WACOM_BUTTON_LEFT   0x01
+#define ADB_WACOM_BUTTON_RIGHT  0x02
+
+static void adb_wacom_handle_event(DeviceState *dev, QemuConsole *src,
+                                    InputEvent *evt) {
+    WacomState *s = (WacomState *) dev;
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+    static const int bmap[INPUT_BUTTON__MAX] = {
+            [INPUT_BUTTON_LEFT]   = ADB_WACOM_BUTTON_LEFT,
+            [INPUT_BUTTON_RIGHT]  = ADB_WACOM_BUTTON_RIGHT,
+    };
+
+    switch (evt->type) {
+        case INPUT_EVENT_KIND_ABS:
+
+            move = evt->u.abs.data;
+            switch (move->axis) {
+                case INPUT_AXIS_X:
+                    // Digitizer II / Artz lpi 2540 => dpi 5080
+                    s->dx = (uint16_t) (move->value * qemu_console_get_width(src, 640) / 2450);
+//                    s->dx = (uint16_t) (move->value * qemu_console_get_width(src, 640) / 5080);
+                    break;
+                case INPUT_AXIS_Y:
+                    // 6x8 inch interactive surface => 4:3 aspect ratio
+                    s->dy = (uint16_t) (move->value * qemu_console_get_height(src, 480) / 1905);
+//                    s->dy = (uint16_t) (move->value * qemu_console_get_height(src, 480) / 3810);
+                    break;
+                default:
+                    break;
+            }
+            break;
+
+        case INPUT_EVENT_KIND_BTN:
+            btn = evt->u.btn.data;
+            if (bmap[btn->button]) {
+                if (btn->down) {
+                    s->buttons_state |= bmap[btn->button];
+                } else {
+                    s->buttons_state &= ~bmap[btn->button];
+                }
+            }
+            break;
+
+        default:
+            /* keep gcc happy */
+            break;
+    }
+}
+
+static const QemuInputHandler adb_wacom_handler = {
+        .name  = "QEMU ADB Wacom",
+        .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
+        .event = adb_wacom_handle_event,
+        /*
+         * We do not need the .sync handler because unlike e.g. PS/2 where async
+         * wacom events are sent over the serial port, an ADB wacom is constantly
+         * polled by the host via the adb_wacom_poll() callback.
+         */
+};
+
+static int adb_wacom_poll(ADBDevice *d, uint8_t *obuf) {
+    WacomState *s = ADB_WACOM(d);
+
+    if (s->last_buttons_state == s->buttons_state && !(s->dx || s->dy)) {
+        return 0;
+    }
+    // Not quite any of the WACOM II-S/IV/IVe, BitPad One/Two, or MM 1201/961
+    // protocols described in "WACOM Software Interface Reference Manual UD- KT-
+    // SD-Series Graphics Wacoms" (herein: "the manual", Ch. 4).
+    // It's closest to WACOM II, but possibly because the sync bit is unnecessary
+    // with ADB unlike with a standard serial bus, the packet can be condensed
+    // into five bytes instead of requiring seven.
+    s->last_buttons_state = s->buttons_state;
+    obuf[0] = 0xC0 | ((s->dx >> 8) & 0x3F);
+    obuf[1] = s->dx & 0xFF;
+    obuf[2] = ((s->dy >> 8) & 0xFF);
+    obuf[3] = s->dy & 0xFF;
+    obuf[4] = s->buttons_state;
+    s->dx = s->dy = 0;
+    return 5;
+}
+
+static int adb_wacom_request(ADBDevice *d, uint8_t *obuf, const uint8_t *buf,
+                              int len) {
+
+    WacomState *s = ADB_WACOM(d);
+    int cmd, reg, olen;
+
+    if ((buf[0] & 0x0f) == ADB_FLUSH) {
+        /* flush wacom fifo */
+        s->buttons_state = s->last_buttons_state;
+        s->dx = 0;
+        s->dy = 0;
+        s->dz = 0;
+        trace_adb_device_wacom_flush();
+        return 0;
+    }
+
+    cmd = buf[0] & 0xc;
+    reg = buf[0] & 0x3;
+    olen = 0;
+    switch (cmd) {
+        case ADB_WRITEREG:
+            switch (reg) {
+                default:
+//                case 1: // receives 0xFE0449 on initialization. seems to be settings packet
+                        // described (the manual, p. 47)?
+//                case 2: // receives 0x204A when modifying certain settings in control panel
+                        // doesn't seem to vary based on settings values chosen.
+                    break;
+                case 3:
+                    /*
+                     * MacOS 9 has a bug in its ADB driver whereby after configuring
+                     * the ADB bus devices it sends another write of invalid length
+                     * to reg 3. Make sure we ignore it to prevent an address clash
+                     * with the previous device.
+                     */
+                    if (len != 3) {
+                        return 0;
+                    }
+
+                    switch (buf[2]) {
+                        case ADB_CMD_SELF_TEST:
+                            break;
+                        case ADB_CMD_CHANGE_ID:
+                        case ADB_CMD_CHANGE_ID_AND_ACT:
+                        case ADB_CMD_CHANGE_ID_AND_ENABLE:
+                            d->devaddr = buf[1] & 0xf;
+                            break;
+                        default:
+                            d->devaddr = buf[1] & 0xf;
+                            /*
+                             * 0x3A: Wacom tablet
+                             */
+                            if (0x3A == buf[2]) {
+                                d->handler = buf[2];
+                            }
+
+                            trace_adb_device_wacom_request_change_addr_and_handler(
+                                    d->devaddr, d->handler);
+                            break;
+                    }
+            }
+            if (reg != 3) trace_adb_device_wacom_writereg(reg, *(uint64_t *) buf);
+            break;
+        case ADB_READREG:
+            switch (reg) {
+                case 0:
+                    olen = adb_wacom_poll(d, obuf);
+                    break;
+                case 1:
+                    // "WAC 0608 4" -- EISA ID, product ID, buttons - ASCII
+                    // it doesn't like the first three being anything else;
+                    // the next four don't seem to affect operation
+                    // nor does the last (the manual, p. 40).
+                    obuf[0] = 0x57;
+                    obuf[1] = 0x41;
+                    obuf[2] = 0x43;
+                    obuf[3] = 0x30;
+                    obuf[4] = 0x36;
+                    obuf[5] = 0x30;
+                    obuf[6] = 0x38;
+                    obuf[7] = 4;
+                    olen = 8;
+                    break;
+                case 3:
+                    obuf[0] = d->devaddr;
+                    obuf[1] = d->handler;
+                    olen = 2;
+                    break;
+                default:
+                    break;
+            }
+            if (reg) {
+                trace_adb_device_wacom_readreg(reg, *(uint64_t *) obuf);
+            }
+            break;
+        default:
+            break;
+    }
+    return olen;
+}
+
+static bool adb_wacom_has_data(ADBDevice *d) {
+    WacomState *s = ADB_WACOM(d);
+
+    return !(s->last_buttons_state == s->buttons_state &&
+             s->dx == 0 && s->dy == 0);
+}
+
+static void adb_wacom_reset(DeviceState *dev) {
+    ADBDevice *d = ADB_DEVICE(dev);
+    WacomState *s = ADB_WACOM(dev);
+
+    d->handler = 0x3A;
+    d->devaddr = ADB_DEVID_TABLET;
+    s->last_buttons_state = s->buttons_state = 0;
+    s->dx = s->dy = s->dz = 0;
+}
+
+static const VMStateDescription vmstate_adb_wacom = {
+        .name = "adb_wacom",
+        .version_id = 2,
+        .minimum_version_id = 2,
+        .fields = (const VMStateField[]) {
+                VMSTATE_STRUCT(parent_obj, WacomState, 0, vmstate_adb_device,
+                               ADBDevice),
+                VMSTATE_INT32(buttons_state, WacomState),
+                VMSTATE_INT32(last_buttons_state, WacomState),
+                VMSTATE_UINT16(dx, WacomState),
+                VMSTATE_UINT16(dy, WacomState),
+                VMSTATE_UINT16(dz, WacomState),
+                VMSTATE_END_OF_LIST()
+        }
+};
+
+static void adb_wacom_realizefn(DeviceState *dev, Error **errp) {
+    WacomState *s = ADB_WACOM(dev);
+    ADBWacomClass *amc = ADB_WACOM_GET_CLASS(dev);
+
+    amc->parent_realize(dev, errp);
+
+    s->hs = qemu_input_handler_register(dev, &adb_wacom_handler);
+}
+
+static void adb_wacom_initfn(Object *obj) {
+    ADBDevice *d = ADB_DEVICE(obj);
+
+    d->devaddr = ADB_DEVID_TABLET;
+}
+
+static void adb_wacom_class_init(ObjectClass *oc, void *data) {
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ADBDeviceClass *adc = ADB_DEVICE_CLASS(oc);
+    ADBWacomClass *amc = ADB_WACOM_CLASS(oc);
+
+    device_class_set_parent_realize(
+            dc, adb_wacom_realizefn,
+            &amc->parent_realize);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+
+    adc->devreq = adb_wacom_request;
+    adc->devhasdata = adb_wacom_has_data;
+    device_class_set_legacy_reset(dc, adb_wacom_reset);
+    dc->vmsd = &vmstate_adb_wacom;
+}
+
+static const TypeInfo adb_wacom_type_info = {
+        .name = TYPE_ADB_WACOM,
+        .parent = TYPE_ADB_DEVICE,
+        .instance_size = sizeof(WacomState),
+        .instance_init = adb_wacom_initfn,
+        .class_init = adb_wacom_class_init,
+        .class_size = sizeof(ADBWacomClass),
+};
+
+static void adb_wacom_register_types(void) {
+    type_register_static(&adb_wacom_type_info);
+}
+
+type_init(adb_wacom_register_types)
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 90a214962c..65800cdfc1 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -1,5 +1,5 @@
 system_ss.add(files('hid.c'))
-system_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c'))
+system_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c', 'adb-wacom.c',))
 system_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
 system_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
 system_ss.add(when: 'CONFIG_PS2', if_true: files('ps2.c'))
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 1484625565..90e9f61dc2 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -14,6 +14,12 @@ adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x
 adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
 adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
+# adb-wacom.c
+adb_device_wacom_flush(void) "flush"
+adb_device_wacom_writereg(int reg, uint64_t buf) "\t<- reg %d buf 0x%04lX"
+adb_device_wacom_readreg(int reg, uint64_t obut) "\t-> reg %d obuf 0x%04lX"
+adb_device_wacom_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
+
 # adb.c
 adb_bus_request(uint8_t addr, const char *cmd, int size) "device 0x%x %s cmdsize=%d"
 adb_bus_request_done(uint8_t addr, const char *cmd, int size) "device 0x%x %s replysize=%d"
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index 20fced15f7..aa4c3e4e99 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -104,5 +104,6 @@ void adb_register_autopoll_callback(ADBBusState *s, void (*cb)(void *opaque),
 
 #define TYPE_ADB_KEYBOARD "adb-keyboard"
 #define TYPE_ADB_MOUSE "adb-mouse"
+#define TYPE_ADB_WACOM "adb-wacom"
 
 #endif /* ADB_H */
-- 
2.45.2


