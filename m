Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3402BCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQo-0007Ut-J3; Tue, 26 May 2026 00:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQm-0007UO-VX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQk-0007au-70
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so63400315e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769813; x=1780374613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKB0CL/PndMACk8dNljjuEebI2FwjYhCCYhB05ovDtE=;
 b=q7IYK9pM/oHMhRKsInnRlE/mzGdOvcL2KXYGQgxLHJdPnr4Pv5m0zESdFCe0RwZ8/U
 z8JpqNg1LNXCzcA+4/0knmaZD5tl8H9gpM3zPHtyRZm34Qb4Gnkx74D1jjhb/+itcfAE
 ulHHyGyrol6yXXHyhYYULCNhWKHfiqECNsnuAggsUB7kI9FO5fSo05B6fINkUkxwQ2vZ
 b85+q+M+TQ/9Lr5uFx7wVDzZOKPUDxU4vPTvEnH1xm3HtFBwqo6oeUp7QkXySDmNrl8d
 AT9pSBd0adEege7eh8+ry68yxyU9z8xLuiQIBIOxslFOeUAjaXR9G5Em4/cjEDN0J3lQ
 AeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769813; x=1780374613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GKB0CL/PndMACk8dNljjuEebI2FwjYhCCYhB05ovDtE=;
 b=iLxzHzkDYak7bcsVQ4YRX9jz+ZnJo1scEbv5toqhUPSc5Ho+fFaF2Ofeat5AG8DVSf
 u4dMKaOPNhCRDefL/EMkFlUtNKUA4RVOcp3AuCeDAP+t+lu9AWGl8oo54U3VjSbvbH7z
 /Jm7KCtxXjV8L9iQ2e+yAPW8/WZM+Fo9Qc3sXi0VlZR2POcwNQAWkc8ykfU1SZYCu5w7
 PWZcSKvXVHedkpXWQhfn6mwZJYaagbKI5mFGo0/qZbw+HvyqOBI/XkZrAied23IvDyPQ
 HGqt5vcRDs+CTSiw3SVeSrbRsYhW9LJ5Wuhwy6g6BSlLut+/bHNjeHPcNOxvn6kz4Ck1
 eHjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ROWT71an7p+oHQqc/z6TxnJO649cPF85qkI50tlzbUyg+AzMXj2hx8720+MUo+1+RNtzARPtTipMD@nongnu.org
X-Gm-Message-State: AOJu0YyBTKTvCiAAxITkjyLJKUnq/3Sj7m+dAt45PAneDZ2hbAcqGuMT
 BKRTwx26kodE2WQcSv1dZrtecyaeaWJArSLgBUn1HtYFTxWjt0GZkPg/
X-Gm-Gg: Acq92OFVkZ8SdvX+lAdF8Bp/7EAMJsOuz1Lc4PdSxz1lqLVsJ6FOB7r3uLW0Bzbyglf
 XzU7hsNWQNSPbAk+QoU6klbA3wirl310HZNUR5UxHyGBl9k2xOs2u62MNGLo7l3hq3vUaLcDrBx
 Q8DkjS37SeV+5pe+ubUHXyRarZc1Ho1KXdz+txaVHfiRNUibLBurHHMzx2XFvfoLOul6TeVjxWF
 QJlfsLkHfqyPHwXptf/wNrGe3feFmHvzmIXlCtaiLJCAykoQlV36DQZbb5/ERzf5CKFhF2vJAiv
 jU03KMdn8gtPPy+BHSZ3Q+TLvPTBF3V56tyqnte4+iVSPRNZih3qE519zI/pZArIQt3So8uZ3V1
 nex6TSdlBZ5rj+u/ZZspWlDW5bXSc4aUHHJagi6e55icyPOMnLRLKPO6dq5Q+fSn0AjJnHLTuDl
 FxRU7GQDlqXFga3op2DzrMvOnr43R2/nC4SXyN2a56VGQeXPTUM0c0LJDTruuKfAd9Yrx6a/h36
 XU=
X-Received: by 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-49042489c30mr320297815e9.5.1779769812633; 
 Mon, 25 May 2026 21:30:12 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:12 -0700 (PDT)
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
Subject: [PATCH v4 5/8] hw/acpi: Introduce the QEMU AC adapter
Date: Tue, 26 May 2026 07:29:24 +0300
Message-ID: <20260526042928.9203-6-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x331.google.com
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

The AC adapter device communicates AC power state to the guest via ACPI.
AC adapter state is controlled programmatically via QMP commands,
ensuring deterministic behavior.

Properties:
- 'ioport': I/O port base address (default: 0x53c)

The device implements the ACPI_DEV_AML_IF interface to generate its
own AML code, placing the ADP0 device directly under \_SB scope.

QMP commands:
- ac-adapter-set-state: Set AC adapter connection state
- query-ac-adapter: Query current AC adapter state

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 MAINTAINERS                          |   2 +
 hw/acpi/Kconfig                      |   4 +
 hw/acpi/acad-stub.c                  |  20 +++
 hw/acpi/acad.c                       | 251 +++++++++++++++++++++++++++
 hw/acpi/meson.build                  |   2 +
 hw/acpi/trace-events                 |   4 +
 hw/i386/Kconfig                      |   1 +
 include/hw/acpi/acad.h               |  25 +++
 include/hw/acpi/acpi_dev_interface.h |   1 +
 qapi/acpi.json                       |  47 +++++
 10 files changed, 357 insertions(+)
 create mode 100644 hw/acpi/acad-stub.c
 create mode 100644 hw/acpi/acad.c
 create mode 100644 include/hw/acpi/acad.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 47436ec878..90941519e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3047,6 +3047,8 @@ AC Adapter
 M: Leonid Bloch <lb.workbox@gmail.com>
 S: Maintained
 F: docs/specs/acad.rst
+F: hw/acpi/acad*
+F: include/hw/acpi/acad.h
 
 Subsystems
 ----------
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 6b2c46d37a..889ace2dfa 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -74,6 +74,10 @@ config ACPI_VIOT
     bool
     depends on ACPI
 
+config AC_ADAPTER
+    bool
+    depends on ACPI
+
 config ACPI_HW_REDUCED
     bool
     select ACPI
diff --git a/hw/acpi/acad-stub.c b/hw/acpi/acad-stub.c
new file mode 100644
index 0000000000..92093b7682
--- /dev/null
+++ b/hw/acpi/acad-stub.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU emulated AC adapter device - QMP stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi.h"
+
+void qmp_ac_adapter_set_state(bool connected, Error **errp)
+{
+    error_setg(errp, "No AC adapter device found");
+}
+
+AcAdapterInfo *qmp_query_ac_adapter(Error **errp)
+{
+    error_setg(errp, "No AC adapter device found");
+    return NULL;
+}
diff --git a/hw/acpi/acad.c b/hw/acpi/acad.c
new file mode 100644
index 0000000000..11777fbb3c
--- /dev/null
+++ b/hw/acpi/acad.c
@@ -0,0 +1,251 @@
+/*
+ * QEMU emulated AC adapter device.
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
+#include "hw/acpi/acad.h"
+
+#define AC_ADAPTER_DEVICE(obj) OBJECT_CHECK(ACADState, (obj), \
+                                            TYPE_AC_ADAPTER)
+
+#define AC_STA_ADDR               0
+
+enum {
+    AC_ADAPTER_OFFLINE = 0,
+    AC_ADAPTER_ONLINE = 1,
+};
+
+typedef struct ACADState {
+    ISADevice dev;
+    MemoryRegion io;
+    uint16_t ioport;
+    uint8_t state;
+    bool qmp_connected;
+} ACADState;
+
+static void acad_get_dynamic_status(ACADState *s)
+{
+    s->state = s->qmp_connected ? AC_ADAPTER_ONLINE : AC_ADAPTER_OFFLINE;
+
+    trace_acad_get_dynamic_status(s->state);
+}
+
+static void acad_realize(DeviceState *dev, Error **errp)
+{
+    ISADevice *d = ISA_DEVICE(dev);
+    ACADState *s = AC_ADAPTER_DEVICE(dev);
+    bool ambiguous;
+
+    trace_acad_realize();
+
+    object_resolve_path_type("", TYPE_AC_ADAPTER, &ambiguous);
+    if (ambiguous) {
+        error_setg(errp, "at most one %s device is permitted",
+                   TYPE_AC_ADAPTER);
+        return;
+    }
+
+    /* Initialize to disconnected by default */
+    s->qmp_connected = false;
+
+    isa_register_ioport(d, &s->io, s->ioport);
+}
+
+static const Property acad_device_properties[] = {
+    DEFINE_PROP_UINT16(AC_ADAPTER_IOPORT_PROP, ACADState, ioport, 0x53c),
+};
+
+static const VMStateDescription acad_vmstate = {
+    .name = "acad",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(qmp_connected, ACADState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void build_acad_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev, *field, *method, *pkg;
+    Aml *acad_state;
+    Aml *sb_scope;
+    ACADState *s = AC_ADAPTER_DEVICE(adev);
+
+    acad_state  = aml_local(0);
+
+    sb_scope = aml_scope("\\_SB");
+    dev = aml_device("ADP0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0003")));
+
+    aml_append(dev, aml_operation_region("ACST", AML_SYSTEM_IO,
+                                         aml_int(s->ioport),
+                                         AC_ADAPTER_LEN));
+    field = aml_field("ACST", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("PWRS", 8));
+    aml_append(dev, field);
+
+    method = aml_method("_PSR", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_name("PWRS"), acad_state));
+    aml_append(method, aml_return(acad_state));
+    aml_append(dev, method);
+
+    method = aml_method("_PCL", 0, AML_NOTSERIALIZED);
+    pkg = aml_package(1);
+    aml_append(pkg, aml_name("_SB"));
+    aml_append(method, aml_return(pkg));
+    aml_append(dev, method);
+
+    method = aml_method("_PIF", 0, AML_NOTSERIALIZED);
+    pkg = aml_package(6);
+    /* Power Source State */
+    aml_append(pkg, aml_int(0));  /* Non-redundant, non-shared */
+    /* Maximum Output Power */
+    aml_append(pkg, aml_int(AC_ADAPTER_VAL_UNKNOWN));
+    /* Maximum Input Power */
+    aml_append(pkg, aml_int(AC_ADAPTER_VAL_UNKNOWN));
+    /* Model Number */
+    aml_append(pkg, aml_string("QADP001"));
+    /* Serial Number */
+    aml_append(pkg, aml_string("SN00000"));
+    /* OEM Information */
+    aml_append(pkg, aml_string("QEMU"));
+    aml_append(method, aml_return(pkg));
+    aml_append(dev, method);
+
+    aml_append(sb_scope, dev);
+    aml_append(scope, sb_scope);
+
+    /* Status Change */
+    method = aml_method("\\_GPE._E0B", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.ADP0"), aml_int(0x80)));
+    aml_append(scope, method);
+}
+
+static void acad_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(class);
+
+    dc->realize = acad_realize;
+    dc->hotpluggable = false;
+    device_class_set_props(dc, acad_device_properties);
+    dc->vmsd = &acad_vmstate;
+    adevc->build_dev_aml = build_acad_aml;
+}
+
+static uint64_t acad_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ACADState *s = opaque;
+
+    acad_get_dynamic_status(s);
+
+    switch (addr) {
+    case AC_STA_ADDR:
+        return s->state;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps acad_ops = {
+    .read = acad_ioport_read,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void acad_instance_init(Object *obj)
+{
+    ACADState *s = AC_ADAPTER_DEVICE(obj);
+
+    memory_region_init_io(&s->io, obj, &acad_ops, s, "acad",
+                          AC_ADAPTER_LEN);
+}
+
+static const TypeInfo acad_info = {
+    .name          = TYPE_AC_ADAPTER,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(ACADState),
+    .class_init    = acad_class_init,
+    .instance_init = acad_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_ACPI_DEV_AML_IF },
+        { },
+    },
+};
+
+static ACADState *find_acad_device(Error **errp)
+{
+    bool ambiguous;
+    Object *o = object_resolve_path_type("", TYPE_AC_ADAPTER, &ambiguous);
+
+    if (!o) {
+        error_setg(errp, "No AC adapter device found");
+        return NULL;
+    }
+    if (ambiguous) {
+        error_setg(errp, "More than one AC adapter device present");
+        return NULL;
+    }
+    return AC_ADAPTER_DEVICE(o);
+}
+
+void qmp_ac_adapter_set_state(bool connected, Error **errp)
+{
+    ACADState *s = find_acad_device(errp);
+    Object *obj;
+
+    if (!s) {
+        return;
+    }
+
+    s->qmp_connected = connected;
+
+    obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+        acpi_send_event(DEVICE(obj), ACPI_AC_ADAPTER_CHANGE_STATUS);
+    }
+}
+
+AcAdapterInfo *qmp_query_ac_adapter(Error **errp)
+{
+    ACADState *s = find_acad_device(errp);
+    AcAdapterInfo *ret;
+
+    if (!s) {
+        return NULL;
+    }
+
+    ret = g_new0(AcAdapterInfo, 1);
+    ret->connected = s->qmp_connected;
+
+    return ret;
+}
+
+static void acad_register_types(void)
+{
+    type_register_static(&acad_info);
+}
+
+type_init(acad_register_types)
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index e6bc78274e..731e9477e3 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -37,6 +37,8 @@ stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
 stub_ss.add(files('pci-bridge-stub.c'))
 acpi_ss.add(when: 'CONFIG_BATTERY', if_true: files('battery.c'))
 stub_ss.add(files('battery-stub.c'))
+acpi_ss.add(when: 'CONFIG_AC_ADAPTER', if_true: files('acad.c'))
+stub_ss.add(files('acad-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 stub_ss.add(files('ghes_cper_stub.c'))
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 8a6ab91a13..67602000f3 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -91,3 +91,7 @@ acpi_nvdimm_invalid_revision(uint32_t revision) "Revision 0x%" PRIx32 " is not s
 # battery.c
 battery_realize(void) "Battery device realize entry"
 battery_get_dynamic_status(uint32_t state, uint32_t rate, uint32_t charge) "Battery read state: 0x%"PRIx32", rate: %"PRIu32", charge: %"PRIu32
+
+# acad.c
+acad_realize(void) "AC adapter device realize entry"
+acad_get_dynamic_status(uint8_t state) "AC adapter read state: %"PRIu8
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 94004ffeb2..06f21cadb7 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -40,6 +40,7 @@ config PC
     imply NVDIMM
     imply FDC_ISA
     imply BATTERY
+    imply AC_ADAPTER
     select I8259
     select I8254
     select PCKBD
diff --git a/include/hw/acpi/acad.h b/include/hw/acpi/acad.h
new file mode 100644
index 0000000000..f163158f35
--- /dev/null
+++ b/include/hw/acpi/acad.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU emulated AC adapter device.
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
+#ifndef HW_ACPI_AC_ADAPTER_H
+#define HW_ACPI_AC_ADAPTER_H
+
+#define TYPE_AC_ADAPTER                  "acad"
+#define AC_ADAPTER_IOPORT_PROP           "ioport"
+
+#define AC_ADAPTER_VAL_UNKNOWN  0xFFFFFFFF
+
+#define AC_ADAPTER_LEN          1
+
+#endif
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index a6f9022c0b..00566c56a7 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -15,6 +15,7 @@ typedef enum {
     ACPI_POWER_DOWN_STATUS = 64,
     ACPI_GENERIC_ERROR = 128,
     ACPI_BATTERY_CHANGE_STATUS = 256,
+    ACPI_AC_ADAPTER_CHANGE_STATUS = 2048,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 4711a05614..025b5d8eaa 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -213,3 +213,50 @@
 ##
 { 'command': 'query-battery',
   'returns': 'BatteryInfo' }
+
+##
+# @ac-adapter-set-state:
+#
+# Set the state of the emulated AC adapter device
+#
+# @connected: whether the AC adapter is connected
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "ac-adapter-set-state",
+#          "arguments": { "connected": true } }
+#     <- { "return": {} }
+##
+{ 'command': 'ac-adapter-set-state',
+  'data': { 'connected': 'bool' } }
+
+##
+# @AcAdapterInfo:
+#
+# AC adapter state information
+#
+# @connected: whether the AC adapter is connected
+#
+# Since: 11.1
+##
+{ 'struct': 'AcAdapterInfo',
+  'data': { 'connected': 'bool' } }
+
+##
+# @query-ac-adapter:
+#
+# Query the current state of the emulated AC adapter device
+#
+# Returns: AC adapter connection state
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-ac-adapter" }
+#     <- { "return": { "connected": true } }
+##
+{ 'command': 'query-ac-adapter',
+  'returns': 'AcAdapterInfo' }
-- 
2.54.0


