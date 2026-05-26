Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC82CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQl-0007TK-Hb; Tue, 26 May 2026 00:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQj-0007SA-GS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQg-0007aD-88
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso1351885e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769808; x=1780374608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRYWGOL09YQ6Ynjjtdpealy3l/NaHMqGBRplsHaGGZQ=;
 b=DeJ541EbiUe4Ho0VtPpgMFrnWyBjZp80ZAUfwOWp2MfMLoLy6089+YiNIiguh2ZHkd
 HIjnes8xaHYYF85TClvYnunPszuSybUiH9zZX2yUUkd/RAr+9H6r8iNA/c9pnzjecPL4
 CdS5ss6PiFUbBHQhnyw6wkah6iVHZtopS7tYCvOgWtg+Ik8536MXggdMHgL0Hah4+3+3
 VGl6U2boy/wqXe7+PoBvyn8wcpp1nR5jkYKKb8oQD42aXAp8HzqdrEFnYk/QiS5taT4H
 fwyNgzM14aCpqG9lANjImbSsTKvl9jMtSbB3wTbo5etiEre4a/n56RBjpFDhkAuNSKiQ
 caOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769808; x=1780374608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RRYWGOL09YQ6Ynjjtdpealy3l/NaHMqGBRplsHaGGZQ=;
 b=UTDhtesIzkfmeVwmQtU5CznmRi5KL7TXI4mHbyyxZcYUWN2iA32USkw0DzBpu4u5Po
 fQ4eJ6D9e9JsueHL//q6Gep7o3ZKgfgymW1vjrjpgdfcqXagW7AqehULDTYBc5ihET4N
 37ynq24JNAzlVcSOwRlSszRn1TL5eE0YoJi++fpJwgaWAOjqSkFbvJFhdrmTiYObEvpP
 tyKtldZ6jhxy5L6ShM+diaT336KhFRUP9m/KfKkTfpqp/aWAdpG59ekD3b/y/gr0c5eD
 1yg6n1D5rp4QA3OtCI9Zs420J1ID02yN18yrWQ79HXn0oZ9XvAiDBbubdrUBSi8msixC
 a2IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ837DHhiIWRpYRHeghjvl9f4oB9EoyVwS3KQR4E7QLmHbdKtTnarBYbeazobe4GAD/7L8GiSWS3jW7B@nongnu.org
X-Gm-Message-State: AOJu0YyU1HnH5DAKw4TBRfVGLcipD6Ns1N2RubRk5+NIzp9myYkPubKE
 hf/PO1CnGiZ4wfv8wapdp+b5HXLnXok1+9P6NU+CwpwCawebQYDRZ/IS
X-Gm-Gg: Acq92OEHlJbw7XCk2ui2b8LUNatWsgaBw2lvRkF+T3D1NJ1xdfDNaEPvqIycKDa9xwY
 fls9tlYpyvLMzqTw0EpBJegW5nPjzx6q5e679cHb5Y7slMJ9fe/ilLTX0j/m+R+rgiruHED2h3G
 8wvEBay62sGHwp5dpUWQWtayJZdeDkc9Cu5MWNBkTDRObAElKdGMgk1hEMG4AqNVgc7osXbj5uX
 nKTq0H4n6Z9/TUYD7xFnmH7c4zOdYIl1FQ8LvjPwlwzZrSo+EhrCBnlqy/CnBbXgtVUWXiShDi+
 QkA38OVSzACgA7UlSzAgg/dcCPCsKpA8UjwruvkCjHEMePacH2fRQnGxFO3vuxsDPIRFmxAjhLC
 KfnaywbLdWdOK+jQ+nMpoPDGoN48HpxEKicUYXF87zlcyI74G7xZGdy+p42J+YzJ2sBXXR5Xb9v
 krrytCKoIRZ4t99X40xn/p6p17O9OCQdobQ+F40CYGoLjxar2hGE1MipsjBwN82W04nDUwGie5M
 H8qJWDC8tk33w==
X-Received: by 2002:a05:600c:4f0f:b0:490:50e4:7224 with SMTP id
 5b1f17b1804b1-49050e474d4mr245343565e9.3.1779769808176; 
 Mon, 25 May 2026 21:30:08 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:07 -0700 (PDT)
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
Subject: [PATCH v4 3/8] hw/acpi: Introduce the QEMU Battery
Date: Tue, 26 May 2026 07:29:22 +0300
Message-ID: <20260526042928.9203-4-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32b.google.com
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

The battery device communicates battery state to the guest via ACPI.
Battery state is controlled programmatically via QMP commands, making
the device deterministic and migration-safe.

Properties:
- 'ioport': I/O port base address (default: 0x530)

The device implements the ACPI_DEV_AML_IF interface to generate its
own AML code, placing the BAT0 device directly under \_SB scope as
per ACPI specification.

QMP commands:
- battery-set-state: Set battery state (present, charging, capacity, rate)
- query-battery: Query current battery state

This provides a stable interface for virtualization management systems.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 MAINTAINERS                          |   2 +
 hw/acpi/Kconfig                      |   4 +
 hw/acpi/battery-stub.c               |  20 ++
 hw/acpi/battery.c                    | 364 +++++++++++++++++++++++++++
 hw/acpi/meson.build                  |   2 +
 hw/acpi/trace-events                 |   4 +
 hw/i386/Kconfig                      |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/battery.h            |  32 +++
 qapi/acpi.json                       |  71 ++++++
 10 files changed, 501 insertions(+)
 create mode 100644 hw/acpi/battery-stub.c
 create mode 100644 hw/acpi/battery.c
 create mode 100644 include/hw/acpi/battery.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e356f46a58..ce50329f48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3040,6 +3040,8 @@ Battery
 M: Leonid Bloch <lb.workbox@gmail.com>
 S: Maintained
 F: docs/specs/battery.rst
+F: hw/acpi/battery*
+F: include/hw/acpi/battery.h
 
 Subsystems
 ----------
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index daabbe6cd1..6b2c46d37a 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -88,3 +88,7 @@ config ACPI_ERST
 config ACPI_CXL
     bool
     depends on ACPI
+
+config BATTERY
+    bool
+    depends on ACPI
diff --git a/hw/acpi/battery-stub.c b/hw/acpi/battery-stub.c
new file mode 100644
index 0000000000..d2f13b51c1
--- /dev/null
+++ b/hw/acpi/battery-stub.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU emulated battery device - QMP stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi.h"
+
+void qmp_battery_set_state(BatteryInfo *state, Error **errp)
+{
+    error_setg(errp, "No battery device found");
+}
+
+BatteryInfo *qmp_query_battery(Error **errp)
+{
+    error_setg(errp, "No battery device found");
+    return NULL;
+}
diff --git a/hw/acpi/battery.c b/hw/acpi/battery.c
new file mode 100644
index 0000000000..35b81ad486
--- /dev/null
+++ b/hw/acpi/battery.c
@@ -0,0 +1,364 @@
+/*
+ * QEMU emulated battery device.
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
+#include "hw/acpi/battery.h"
+
+#define BATTERY_DEVICE(obj) OBJECT_CHECK(BatteryState, (obj), TYPE_BATTERY)
+
+#define BATTERY_DISCHARGING  0x01  /* ACPI _BST bit 0 */
+#define BATTERY_CHARGING     0x02  /* ACPI _BST bit 1 */
+#define BATTERY_CRITICAL     0x04  /* ACPI _BST bit 2 */
+#define BATTERY_PRESENT      0x10  /* ACPI _STA bit 4 */
+
+typedef struct BatteryState {
+    ISADevice dev;
+    MemoryRegion io;
+    uint16_t ioport;
+    uint32_t state;
+    uint32_t rate;
+    uint32_t charge;
+    bool qmp_present;
+    bool qmp_charging;
+    bool qmp_discharging;
+    int32_t qmp_charge_percent;
+    int32_t qmp_rate;
+} BatteryState;
+
+enum {
+    BSTA_ADDR = 0,
+    BRTE_ADDR = 4,
+    BCRG_ADDR = 8,
+};
+
+static void battery_get_dynamic_status(BatteryState *s)
+{
+    s->state = 0;
+    if (s->qmp_present) {
+        s->state |= BATTERY_PRESENT;
+        if (s->qmp_charging) {
+            s->state |= BATTERY_CHARGING;
+        }
+        if (s->qmp_discharging) {
+            s->state |= BATTERY_DISCHARGING;
+        }
+    }
+    s->rate = s->qmp_rate;
+    s->charge = (s->qmp_charge_percent * BATTERY_FULL_CAP) / 100;
+
+    trace_battery_get_dynamic_status(s->state, s->rate, s->charge);
+}
+
+static void battery_realize(DeviceState *dev, Error **errp)
+{
+    ISADevice *d = ISA_DEVICE(dev);
+    BatteryState *s = BATTERY_DEVICE(dev);
+    bool ambiguous;
+
+    trace_battery_realize();
+
+    object_resolve_path_type("", TYPE_BATTERY, &ambiguous);
+    if (ambiguous) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_BATTERY);
+        return;
+    }
+
+    /* Initialize QMP state to sensible defaults */
+    s->qmp_present = true;
+    s->qmp_charging = false;
+    s->qmp_discharging = true;
+    s->qmp_charge_percent = 50;
+    s->qmp_rate = 1000;  /* 1000 mW discharge rate */
+
+    isa_register_ioport(d, &s->io, s->ioport);
+}
+
+static const Property battery_device_properties[] = {
+    DEFINE_PROP_UINT16(BATTERY_IOPORT_PROP, BatteryState, ioport, 0x530),
+};
+
+static const VMStateDescription battery_vmstate = {
+    .name = "battery",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(qmp_present, BatteryState),
+        VMSTATE_BOOL(qmp_charging, BatteryState),
+        VMSTATE_BOOL(qmp_discharging, BatteryState),
+        VMSTATE_INT32(qmp_charge_percent, BatteryState),
+        VMSTATE_INT32(qmp_rate, BatteryState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void build_battery_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev, *field, *method, *pkg;
+    Aml *bat_state, *bat_rate, *bat_charge;
+    Aml *sb_scope;
+    BatteryState *s = BATTERY_DEVICE(adev);
+
+    bat_state  = aml_local(0);
+    bat_rate   = aml_local(1);
+    bat_charge = aml_local(2);
+
+    sb_scope = aml_scope("\\_SB");
+    dev = aml_device("BAT0");
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0A")));
+
+    aml_append(dev, aml_operation_region("DBST", AML_SYSTEM_IO,
+                                         aml_int(s->ioport),
+                                         BATTERY_LEN));
+    field = aml_field("DBST", AML_DWORD_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("BSTA", 32));
+    aml_append(field, aml_named_field("BRTE", 32));
+    aml_append(field, aml_named_field("BCRG", 32));
+    aml_append(dev, field);
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_or(aml_int(0x0F),
+                                         aml_and(aml_name("BSTA"),
+                                                 aml_int(0x10), NULL),
+                                         NULL)));
+    aml_append(dev, method);
+
+    method = aml_method("_BIF", 0, AML_NOTSERIALIZED);
+    pkg = aml_package(13);
+    /* Power Unit */
+    aml_append(pkg, aml_int(0));             /* mW */
+    /* Design Capacity */
+    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
+    /* Last Full Charge Capacity */
+    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
+    /* Battery Technology */
+    aml_append(pkg, aml_int(1));             /* Secondary */
+    /* Design Voltage */
+    aml_append(pkg, aml_int(BATTERY_DESIGN_VOLTAGE));
+    /* Design Capacity of Warning */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_OF_WARNING));
+    /* Design Capacity of Low */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_OF_LOW));
+    /* Battery Capacity Granularity 1 */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_GRANULARITY));
+    /* Battery Capacity Granularity 2 */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_GRANULARITY));
+    /* Model Number */
+    aml_append(pkg, aml_string("QBAT001"));  /* Model Number */
+    /* Serial Number */
+    aml_append(pkg, aml_string("SN00000"));  /* Serial Number */
+    /* Battery Type */
+    aml_append(pkg, aml_string("Virtual"));  /* Battery Type */
+    /* OEM Information */
+    aml_append(pkg, aml_string("QEMU"));     /* OEM Information */
+    aml_append(method, aml_return(pkg));
+    aml_append(dev, method);
+
+    pkg = aml_package(4);
+    /* Battery State */
+    aml_append(pkg, aml_int(0));
+    /* Battery Present Rate */
+    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
+    /* Battery Remaining Capacity */
+    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
+    /* Battery Present Voltage */
+    aml_append(pkg, aml_int(BATTERY_DESIGN_VOLTAGE));
+    aml_append(dev, aml_name_decl("DBPR", pkg));
+
+    method = aml_method("_BST", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_and(aml_name("BSTA"), aml_int(0x0F),
+                                         NULL),
+                                 bat_state));
+    aml_append(method, aml_store(aml_name("BRTE"), bat_rate));
+    aml_append(method, aml_store(aml_name("BCRG"), bat_charge));
+    aml_append(method, aml_store(bat_state,
+                                 aml_index(aml_name("DBPR"), aml_int(0))));
+    aml_append(method, aml_store(bat_rate,
+                                 aml_index(aml_name("DBPR"), aml_int(1))));
+    aml_append(method, aml_store(bat_charge,
+                                 aml_index(aml_name("DBPR"), aml_int(2))));
+    aml_append(method, aml_return(aml_name("DBPR")));
+    aml_append(dev, method);
+
+    aml_append(sb_scope, dev);
+    aml_append(scope, sb_scope);
+
+    /* Status Change */
+    method = aml_method("\\_GPE._E08", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x80)));
+    aml_append(scope, method);
+}
+
+static void battery_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(class);
+
+    dc->realize = battery_realize;
+    dc->hotpluggable = false;
+    device_class_set_props(dc, battery_device_properties);
+    dc->vmsd = &battery_vmstate;
+    adevc->build_dev_aml = build_battery_aml;
+}
+
+static uint64_t battery_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BatteryState *s = opaque;
+
+    battery_get_dynamic_status(s);
+
+    switch (addr) {
+    case BSTA_ADDR:
+        return s->state;
+    case BRTE_ADDR:
+        return s->rate;
+    case BCRG_ADDR:
+        return s->charge;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps battery_ops = {
+    .read = battery_ioport_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void battery_instance_init(Object *obj)
+{
+    BatteryState *s = BATTERY_DEVICE(obj);
+
+    memory_region_init_io(&s->io, obj, &battery_ops, s, "battery",
+                          BATTERY_LEN);
+}
+
+static const TypeInfo battery_info = {
+    .name          = TYPE_BATTERY,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(BatteryState),
+    .class_init    = battery_class_init,
+    .instance_init = battery_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_ACPI_DEV_AML_IF },
+        { },
+    },
+};
+
+static BatteryState *find_battery_device(Error **errp)
+{
+    bool ambiguous;
+    Object *o = object_resolve_path_type("", TYPE_BATTERY, &ambiguous);
+
+    if (!o) {
+        error_setg(errp, "No battery device found");
+        return NULL;
+    }
+    if (ambiguous) {
+        error_setg(errp, "More than one battery device present");
+        return NULL;
+    }
+    return BATTERY_DEVICE(o);
+}
+
+void qmp_battery_set_state(BatteryInfo *state, Error **errp)
+{
+    BatteryState *s = find_battery_device(errp);
+    Object *obj;
+
+    if (!s) {
+        return;
+    }
+
+    if (state->charging && state->discharging) {
+        error_setg(errp,
+                   "'charging' and 'discharging' are mutually exclusive");
+        return;
+    }
+    if (!state->present && (state->charging || state->discharging)) {
+        error_setg(errp,
+                   "'charging'/'discharging' require 'present' to be true");
+        return;
+    }
+    if (state->charge_percent < 0 || state->charge_percent > 100) {
+        error_setg(errp, "'charge-percent' must be in the range 0..100");
+        return;
+    }
+    if (state->has_rate && (state->rate < 0 || state->rate > INT32_MAX)) {
+        error_setg(errp, "'rate' must be in the range 0..0x%" PRIX32,
+                   (uint32_t)INT32_MAX);
+        return;
+    }
+
+    s->qmp_present = state->present;
+    s->qmp_charging = state->charging;
+    s->qmp_discharging = state->discharging;
+    s->qmp_charge_percent = state->charge_percent;
+
+    if (state->has_rate) {
+        s->qmp_rate = state->rate;
+    }
+
+    obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+        acpi_send_event(DEVICE(obj), ACPI_BATTERY_CHANGE_STATUS);
+    }
+}
+
+BatteryInfo *qmp_query_battery(Error **errp)
+{
+    BatteryState *s = find_battery_device(errp);
+    BatteryInfo *ret;
+
+    if (!s) {
+        return NULL;
+    }
+
+    ret = g_new0(BatteryInfo, 1);
+
+    ret->present = s->qmp_present;
+    ret->charging = s->qmp_charging;
+    ret->discharging = s->qmp_discharging;
+    ret->charge_percent = s->qmp_charge_percent;
+    ret->has_rate = true;
+    ret->rate = s->qmp_rate;
+
+    ret->has_remaining_capacity = false;
+    ret->has_design_capacity = true;
+    ret->design_capacity = BATTERY_FULL_CAP;
+
+    return ret;
+}
+
+static void battery_register_types(void)
+{
+    type_register_static(&battery_info);
+}
+
+type_init(battery_register_types)
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 1c5251909b..e6bc78274e 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -35,6 +35,8 @@ if have_tpm
 endif
 stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
 stub_ss.add(files('pci-bridge-stub.c'))
+acpi_ss.add(when: 'CONFIG_BATTERY', if_true: files('battery.c'))
+stub_ss.add(files('battery-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 stub_ss.add(files('ghes_cper_stub.c'))
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index edc93e703c..8a6ab91a13 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -87,3 +87,7 @@ acpi_nvdimm_read_io_port(void) "Alert: we never read _DSM IO Port"
 acpi_nvdimm_dsm_mem_addr(uint64_t dsm_mem_addr) "dsm memory address 0x%" PRIx64
 acpi_nvdimm_dsm_info(uint32_t revision, uint32_t handle, uint32_t function) "Revision 0x%" PRIx32 " Handle 0x%" PRIx32 " Function 0x%" PRIx32
 acpi_nvdimm_invalid_revision(uint32_t revision) "Revision 0x%" PRIx32 " is not supported, expect 0x1"
+
+# battery.c
+battery_realize(void) "Battery device realize entry"
+battery_get_dynamic_status(uint32_t state, uint32_t rate, uint32_t charge) "Battery read state: 0x%"PRIx32", rate: %"PRIu32", charge: %"PRIu32
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 12473acaa7..94004ffeb2 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -39,6 +39,7 @@ config PC
     imply VIRTIO_VGA
     imply NVDIMM
     imply FDC_ISA
+    imply BATTERY
     select I8259
     select I8254
     select PCKBD
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 65debb90a8..a6f9022c0b 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -14,6 +14,7 @@ typedef enum {
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
     ACPI_GENERIC_ERROR = 128,
+    ACPI_BATTERY_CHANGE_STATUS = 256,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/battery.h b/include/hw/acpi/battery.h
new file mode 100644
index 0000000000..eaff760db9
--- /dev/null
+++ b/include/hw/acpi/battery.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU emulated battery device.
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
+#ifndef HW_ACPI_BATTERY_H
+#define HW_ACPI_BATTERY_H
+
+#define TYPE_BATTERY                  "battery"
+#define BATTERY_IOPORT_PROP           "ioport"
+
+#define BATTERY_FULL_CAP        10000  /* mWh */
+#define BATTERY_DESIGN_VOLTAGE  12000  /* mV */
+
+#define BATTERY_CAPACITY_OF_WARNING   (BATTERY_FULL_CAP /  10)  /* 10% */
+#define BATTERY_CAPACITY_OF_LOW       (BATTERY_FULL_CAP /  25)  /* 4%  */
+#define BATTERY_CAPACITY_GRANULARITY  (BATTERY_FULL_CAP / 100)  /* 1%  */
+
+#define BATTERY_VAL_UNKNOWN  0xFFFFFFFF
+
+#define BATTERY_LEN          0x0C
+
+#endif
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a5..4711a05614 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -142,3 +142,74 @@
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
+
+##
+# @BatteryInfo:
+#
+# Battery state information
+#
+# @present: whether the battery is present
+#
+# @charging: whether the battery is charging
+#
+# @discharging: whether the battery is discharging
+#
+# @charge-percent: battery charge percentage (0-100)
+#
+# @rate: charge/discharge rate in mW (optional)
+#
+# @remaining-capacity: remaining capacity in mWh (optional)
+#
+# @design-capacity: design capacity in mWh (optional)
+#
+# Since: 11.1
+##
+{ 'struct': 'BatteryInfo',
+  'data': { 'present': 'bool',
+            'charging': 'bool',
+            'discharging': 'bool',
+            'charge-percent': 'int',
+            '*rate': 'int',
+            '*remaining-capacity': 'int',
+            '*design-capacity': 'int' } }
+
+##
+# @battery-set-state:
+#
+# Set the state of the emulated battery device
+#
+# @state: new battery state
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "battery-set-state",
+#          "arguments": { "state": { "present": true,
+#                                    "charging": true,
+#                                    "discharging": false,
+#                                    "charge-percent": 85 } } }
+#     <- { "return": {} }
+##
+{ 'command': 'battery-set-state',
+  'data': { 'state': 'BatteryInfo' } }
+
+##
+# @query-battery:
+#
+# Query the current state of the emulated battery device
+#
+# Returns: current battery state
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-battery" }
+#     <- { "return": { "present": true,
+#                      "charging": true,
+#                      "discharging": false,
+#                      "charge-percent": 85 } }
+##
+{ 'command': 'query-battery',
+  'returns': 'BatteryInfo' }
-- 
2.54.0


