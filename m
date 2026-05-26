Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D0ECD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjR0-0007oA-QL; Tue, 26 May 2026 00:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQr-0007bz-Rr
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQo-0007bT-Ra
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso44961105e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769817; x=1780374617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrFjlhVp73qG6tJ6h5b8qEZ/n8t0fpSSdJJKT8K1sIU=;
 b=ZtF+pWJx5e6KGaal7maN+hSG4SA8GawtJThJgGhv7oVI/qdfcPE30GXfKoEndmQqLy
 p/O36Ba0bJkf19SgpkrcC18FCo9nKkgn8FTnI1NkBPXpXLD5hBd9ygjuYvp/Fp8rUdHi
 Vdc1ypg7P80ooISBjCTYUhqs1BZBfpLTxIqDiXvuGEL/NJ9a44WG0nSfljBjR+KcBAnh
 phFWiEgu3RvXbkF50aHXDZQPeQqmIxdGXl9GykHFHoYwK0edosq0VZ9SkbSMNPfFRQda
 h4iTGLNZRZHVmu8AKoRUF7Ja7kigjCbsSI4ZRWYiGdutogD70hx3kp8Sa4nprazJ36Ck
 otjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769817; x=1780374617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrFjlhVp73qG6tJ6h5b8qEZ/n8t0fpSSdJJKT8K1sIU=;
 b=GYklqozR8LKVHhylI9RXI3DPP4KyKiV+sr442wHf4VN2FG6n+RO1dXETxACSZONUjn
 I/9g3Kg7HQAz4o47DBOEeOdyyd7RveHk3SVeuCJHi2thbkxZDIp/2UDVqKM0Etxe1SMz
 fgfiRHEE2bphDziLv1rQ5YdWEUgBmbk+3I13RHDgXdCH1HoH+icYLNKPH+mOsBaEK4Lv
 WMK+9cxMRidBHxWMCQratcc5fJruPMpB7Tyk0Sg0c3AWOiry4gkQ1tf1E2Y6PQ+96jIF
 FH57VY5mBzZeeJVJm5huuyLEOwdRvs5tmL6uKjHOISXChTeL739I6EhpdIX2uPNEuRHb
 GW2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sC8+ujYBKbZVUHq7zg7rffKHk7QB8/9NqogD6Zm4CBzMJG2T5wYilhGGX+Ik8YBZAz10CU0/kMZ4v@nongnu.org
X-Gm-Message-State: AOJu0Yz2zi6IpOKjHQbTw3dSGGJ3LGp2li3wqVgj2JT9f55w2qU+Uv66
 zlgzvFVlOp/hZi7bzwivqDkYFn39FRk8eWqrlKkFil4yxvBwiZ75nuhc
X-Gm-Gg: Acq92OF6oXT2SgjT+34gPNi1/jWVo3bCBrFAhGgK/+hmGmHOkXsyqSYcJgtW++Mwk85
 9oHIK4g6yzppoWP9hdlJ2w+rXwiU9aNl/p/Vb2sc/IqLd0A45H83l1SUo+50bcQ1nv3DW+euPIH
 0Wn0hzU9Pt23gDNoLUadt6buIIOAefytVd0WzmKUJYjWKGY8C/5P2TrGyvFoWidzRPzYfWDzSCD
 pLOiIclXWOx3gN5MpdJh7b5zi8h+eQhrzHhbxcR7YiTd2skIDdNrv/Q43kZQeqqwQaRCnhOJY3t
 xgSzuyGGlixchJcFJDvEflg7gpY8pSzz3YPNff3xAXgh5izlascx0pUysYhXdyIg4skvBf9iCof
 vVnO/7AW9IfXTKgvpsVIkBxa4OhFZ0GPvOfxckSQSGhYuCtMkkKTx6lvUvfOUFh+h7qTjdGEwrj
 KZUU0rBGpijSN5WtcprKkG2CZSUXohcNhUt4Frmv3rAHldaHTAHnun/vJpkExWAE7/38sAMyLy+
 cA=
X-Received: by 2002:a05:600c:4f52:b0:490:4f91:5519 with SMTP id
 5b1f17b1804b1-4904f91568dmr257113735e9.18.1779769817156; 
 Mon, 25 May 2026 21:30:17 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:16 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 7/8] hw/acpi: Introduce the QEMU lid button
Date: Tue, 26 May 2026 07:29:26 +0300
Message-ID: <20260526042928.9203-8-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32e.google.com
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

The lid button device communicates laptop lid state to the guest via ACPI.
Lid state is controlled programmatically via QMP commands for consistent
behavior across environments.

The device implements the ACPI_DEV_AML_IF interface to generate its
own AML code, placing the LID0 device directly under \_SB scope.

QMP commands:
- lid-button-set-state: Set lid open/closed state
- query-lid-button: Query current lid state

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 MAINTAINERS                          |   2 +
 hw/acpi/Kconfig                      |   4 +
 hw/acpi/button-stub.c                |  20 +++
 hw/acpi/button.c                     | 227 +++++++++++++++++++++++++++
 hw/acpi/meson.build                  |   2 +
 hw/acpi/trace-events                 |   4 +
 hw/i386/Kconfig                      |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/button.h             |  23 +++
 qapi/acpi.json                       |  47 ++++++
 10 files changed, 331 insertions(+)
 create mode 100644 hw/acpi/button-stub.c
 create mode 100644 hw/acpi/button.c
 create mode 100644 include/hw/acpi/button.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 42179aba95..1f8f3e247e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3054,6 +3054,8 @@ Button
 M: Leonid Bloch <lb.workbox@gmail.com>
 S: Maintained
 F: docs/specs/button.rst
+F: hw/acpi/button*
+F: include/hw/acpi/button.h
 
 Subsystems
 ----------
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 889ace2dfa..0d5f885095 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -78,6 +78,10 @@ config AC_ADAPTER
     bool
     depends on ACPI
 
+config BUTTON
+    bool
+    depends on ACPI
+
 config ACPI_HW_REDUCED
     bool
     select ACPI
diff --git a/hw/acpi/button-stub.c b/hw/acpi/button-stub.c
new file mode 100644
index 0000000000..0ae478055b
--- /dev/null
+++ b/hw/acpi/button-stub.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU emulated lid button device - QMP stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi.h"
+
+void qmp_lid_button_set_state(bool open, Error **errp)
+{
+    error_setg(errp, "No lid button device found");
+}
+
+LidButtonInfo *qmp_query_lid_button(Error **errp)
+{
+    error_setg(errp, "No lid button device found");
+    return NULL;
+}
diff --git a/hw/acpi/button.c b/hw/acpi/button.c
new file mode 100644
index 0000000000..126969a5e7
--- /dev/null
+++ b/hw/acpi/button.c
@@ -0,0 +1,227 @@
+/*
+ * QEMU emulated lid button device
+ *
+ * Copyright (c) 2019-2026 Janus Technologies, Inc. (http://janustech.com)
+ *
+ * Authors:
+ *     Leonid Bloch <lb.workbox@gmail.com>
+ *     Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
+ *     Dmitry Fleytman <dmitry.fleytman@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "trace.h"
+#include "hw/isa/isa.h"
+#include "hw/acpi/acpi.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "qapi/qapi-commands-acpi.h"
+
+#include "hw/acpi/button.h"
+
+#define BUTTON_DEVICE(obj) OBJECT_CHECK(ButtonState, (obj), \
+                                        TYPE_BUTTON)
+
+#define BUTTON_STA_ADDR            0
+
+enum {
+    LID_CLOSED = 0,
+    LID_OPEN = 1,
+};
+
+typedef struct ButtonState {
+    ISADevice dev;
+    MemoryRegion io;
+    uint16_t ioport;
+    uint8_t lid_state;
+    bool qmp_lid_open;
+} ButtonState;
+
+static void button_get_dynamic_status(ButtonState *s)
+{
+    trace_button_get_dynamic_status();
+
+    s->lid_state = s->qmp_lid_open ? LID_OPEN : LID_CLOSED;
+}
+
+static void button_realize(DeviceState *dev, Error **errp)
+{
+    ISADevice *d = ISA_DEVICE(dev);
+    ButtonState *s = BUTTON_DEVICE(dev);
+    bool ambiguous;
+
+    trace_button_realize();
+
+    object_resolve_path_type("", TYPE_BUTTON, &ambiguous);
+    if (ambiguous) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_BUTTON);
+        return;
+    }
+
+    /* Initialize lid to open by default */
+    s->qmp_lid_open = true;
+
+    isa_register_ioport(d, &s->io, s->ioport);
+}
+
+static const Property button_device_properties[] = {
+    DEFINE_PROP_UINT16(BUTTON_IOPORT_PROP, ButtonState, ioport, 0x53d),
+};
+
+static const VMStateDescription button_vmstate = {
+    .name = "button",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(qmp_lid_open, ButtonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void build_button_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev, *field, *method;
+    Aml *button_state;
+    Aml *sb_scope;
+    ButtonState *s = BUTTON_DEVICE(adev);
+
+    button_state = aml_local(0);
+
+    sb_scope = aml_scope("\\_SB");
+    dev = aml_device("LID0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0D")));
+
+    aml_append(dev, aml_operation_region("LSTA", AML_SYSTEM_IO,
+                                         aml_int(s->ioport),
+                                         BUTTON_LEN));
+    field = aml_field("LSTA", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("LIDS", 8));
+    aml_append(dev, field);
+
+    method = aml_method("_LID", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_name("LIDS"), button_state));
+    aml_append(method, aml_return(button_state));
+    aml_append(dev, method);
+
+    aml_append(sb_scope, dev);
+    aml_append(scope, sb_scope);
+
+    /* Status Change */
+    method = aml_method("\\_GPE._E0C", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.LID0"), aml_int(0x80)));
+    aml_append(scope, method);
+}
+
+static void button_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(class);
+
+    dc->realize = button_realize;
+    dc->hotpluggable = false;
+    device_class_set_props(dc, button_device_properties);
+    dc->vmsd = &button_vmstate;
+    adevc->build_dev_aml = build_button_aml;
+}
+
+static uint64_t button_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ButtonState *s = opaque;
+
+    button_get_dynamic_status(s);
+
+    switch (addr) {
+    case BUTTON_STA_ADDR:
+        return s->lid_state;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps button_ops = {
+    .read = button_ioport_read,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void button_instance_init(Object *obj)
+{
+    ButtonState *s = BUTTON_DEVICE(obj);
+
+    memory_region_init_io(&s->io, obj, &button_ops, s, "button",
+                          BUTTON_LEN);
+}
+
+static const TypeInfo button_info = {
+    .name          = TYPE_BUTTON,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(ButtonState),
+    .class_init    = button_class_init,
+    .instance_init = button_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_ACPI_DEV_AML_IF },
+        { },
+    },
+};
+
+static ButtonState *find_button_device(Error **errp)
+{
+    bool ambiguous;
+    Object *o = object_resolve_path_type("", TYPE_BUTTON, &ambiguous);
+
+    if (!o) {
+        error_setg(errp, "No lid button device found");
+        return NULL;
+    }
+    if (ambiguous) {
+        error_setg(errp, "More than one lid button device present");
+        return NULL;
+    }
+    return BUTTON_DEVICE(o);
+}
+
+void qmp_lid_button_set_state(bool open, Error **errp)
+{
+    ButtonState *s = find_button_device(errp);
+    Object *obj;
+
+    if (!s) {
+        return;
+    }
+
+    s->qmp_lid_open = open;
+
+    obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+        acpi_send_event(DEVICE(obj), ACPI_BUTTON_CHANGE_STATUS);
+    }
+}
+
+LidButtonInfo *qmp_query_lid_button(Error **errp)
+{
+    ButtonState *s = find_button_device(errp);
+    LidButtonInfo *ret;
+
+    if (!s) {
+        return NULL;
+    }
+
+    ret = g_new0(LidButtonInfo, 1);
+    ret->open = s->qmp_lid_open;
+
+    return ret;
+}
+
+static void button_register_types(void)
+{
+    type_register_static(&button_info);
+}
+
+type_init(button_register_types)
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 731e9477e3..ab0acd2521 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -39,6 +39,8 @@ acpi_ss.add(when: 'CONFIG_BATTERY', if_true: files('battery.c'))
 stub_ss.add(files('battery-stub.c'))
 acpi_ss.add(when: 'CONFIG_AC_ADAPTER', if_true: files('acad.c'))
 stub_ss.add(files('acad-stub.c'))
+acpi_ss.add(when: 'CONFIG_BUTTON', if_true: files('button.c'))
+stub_ss.add(files('button-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 stub_ss.add(files('ghes_cper_stub.c'))
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 67602000f3..13728637ce 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -95,3 +95,7 @@ battery_get_dynamic_status(uint32_t state, uint32_t rate, uint32_t charge) "Batt
 # acad.c
 acad_realize(void) "AC adapter device realize entry"
 acad_get_dynamic_status(uint8_t state) "AC adapter read state: %"PRIu8
+
+# button.c
+button_realize(void) "Button device realize entry"
+button_get_dynamic_status(void) "Button read dynamic status entry"
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 06f21cadb7..35c65d3f37 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -41,6 +41,7 @@ config PC
     imply FDC_ISA
     imply BATTERY
     imply AC_ADAPTER
+    imply BUTTON
     select I8259
     select I8254
     select PCKBD
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 00566c56a7..35005d7ad0 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -16,6 +16,7 @@ typedef enum {
     ACPI_GENERIC_ERROR = 128,
     ACPI_BATTERY_CHANGE_STATUS = 256,
     ACPI_AC_ADAPTER_CHANGE_STATUS = 2048,
+    ACPI_BUTTON_CHANGE_STATUS = 4096,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/button.h b/include/hw/acpi/button.h
new file mode 100644
index 0000000000..d0e2d33231
--- /dev/null
+++ b/include/hw/acpi/button.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU emulated button device.
+ *
+ * Copyright (c) 2019-2026 Janus Technologies, Inc. (http://janustech.com)
+ *
+ * Authors:
+ *     Leonid Bloch <lb.workbox@gmail.com>
+ *     Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
+ *     Dmitry Fleytman <dmitry.fleytman@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_ACPI_BUTTON_H
+#define HW_ACPI_BUTTON_H
+
+#define TYPE_BUTTON                  "button"
+#define BUTTON_IOPORT_PROP           "ioport"
+
+#define BUTTON_LEN                   1
+
+#endif
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 025b5d8eaa..e0534e3657 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -260,3 +260,50 @@
 ##
 { 'command': 'query-ac-adapter',
   'returns': 'AcAdapterInfo' }
+
+##
+# @lid-button-set-state:
+#
+# Set the state of the emulated laptop lid button device
+#
+# @open: whether the lid is open
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "lid-button-set-state",
+#          "arguments": { "open": true } }
+#     <- { "return": {} }
+##
+{ 'command': 'lid-button-set-state',
+  'data': { 'open': 'bool' } }
+
+##
+# @LidButtonInfo:
+#
+# Lid button state information
+#
+# @open: whether the lid is open
+#
+# Since: 11.1
+##
+{ 'struct': 'LidButtonInfo',
+  'data': { 'open': 'bool' } }
+
+##
+# @query-lid-button:
+#
+# Query the current state of the emulated laptop lid button device
+#
+# Returns: lid button state
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-lid-button" }
+#     <- { "return": { "open": true } }
+##
+{ 'command': 'query-lid-button',
+  'returns': 'LidButtonInfo' }
-- 
2.54.0


