Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF2DEC047B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM0z-0003qH-JC; Tue, 03 Mar 2026 04:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0r-0003jX-DY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0o-0004Oy-6n
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOTVBDryMvB/ifAjJXKEw1DxeeXGlfy8QOKzchYR8q0=;
 b=WQcxN/TPhRK37/a8+h/jF9LrrdIT9MpHIk79VU5AxfDDnKm/R7XwdWjp9TIPr5qNqG1Qpp
 fi6WvbyT38wPh6aDUJPn5+9c2Jbum37n77L6p0nIKJSUvGKLaBK1IhEiHJz7Hov0k4eJcZ
 3ylIUmAz36qJelotD0CjaPOs+709zZ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-6m9vEX3NNECgBz04xwqFmw-1; Tue,
 03 Mar 2026 04:25:49 -0500
X-MC-Unique: 6m9vEX3NNECgBz04xwqFmw-1
X-Mimecast-MFC-AGG-ID: 6m9vEX3NNECgBz04xwqFmw_1772529948
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76EB519560AD; Tue,  3 Mar 2026 09:25:48 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 820CF30001B9; Tue,  3 Mar 2026 09:25:45 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
Date: Tue,  3 Mar 2026 10:25:14 +0100
Message-ID: <20260303092532.2410177-4-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It will generate WDAT table [1] customized for TCO watchdog.
This allows Windows guests (Windows Server 2008/Vista+) to
use TCO watchdog using built-in generic driver, which
alleviates need to install vendor specific drivers.

Given that enabling it might change guest behaviour
(both Windows/Linux) the feature is disabled by default.

Users that need it can enable the feature with
following CLI option.
    -machine wdat=on

1)
   "Hardware Watchdog Timers Design Specification"
    https://uefi.org/acpi 'Watchdog Action Table (WDAT)'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 include/hw/acpi/wdat-ich9.h | 15 +++++++
 hw/acpi/meson.build         |  3 +-
 hw/acpi/wdat-ich9-stub.c    | 15 +++++++
 hw/acpi/wdat-ich9.c         | 90 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 12 +++++
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/acpi/wdat-ich9.h
 create mode 100644 hw/acpi/wdat-ich9-stub.c
 create mode 100644 hw/acpi/wdat-ich9.c

diff --git a/include/hw/acpi/wdat-ich9.h b/include/hw/acpi/wdat-ich9.h
new file mode 100644
index 0000000000..60a2a6a112
--- /dev/null
+++ b/include/hw/acpi/wdat-ich9.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_ICH9_H
+#define QEMU_HW_ACPI_WDAT_ICH9_H
+
+#include "hw/acpi/aml-build.h"
+
+void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t tco_base);
+
+#endif /* QEMU_HW_ACPI_WDAT_ICH9_H */
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 66c978aae8..22290ca835 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -24,7 +24,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c', 'wdat-ich9.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
 acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
@@ -33,6 +33,7 @@ if have_tpm
 endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
+system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-ich9-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
diff --git a/hw/acpi/wdat-ich9-stub.c b/hw/acpi/wdat-ich9-stub.c
new file mode 100644
index 0000000000..7c30ef3558
--- /dev/null
+++ b/hw/acpi/wdat-ich9-stub.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/wdat-ich9.h"
+
+void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/acpi/wdat-ich9.c b/hw/acpi/wdat-ich9.c
new file mode 100644
index 0000000000..259c45c62d
--- /dev/null
+++ b/hw/acpi/wdat-ich9.c
@@ -0,0 +1,90 @@
+/*
+ * TCO Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/wdat.h"
+#include "hw/acpi/wdat-ich9.h"
+#include "hw/southbridge/ich9.h"
+
+#define TCO_REG(base, reg_offset, reg_width) { .space_id = AML_AS_SYSTEM_IO, \
+            .address = base + reg_offset, .bit_width = reg_width, \
+            .access_width = AML_WORD_ACC, };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ *
+ *   ICH9 specific implementation.
+ */
+void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t tco_base)
+{
+    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+    struct AcpiGenericAddress tco_rld =  TCO_REG(tco_base, 0x0, 16);
+    struct AcpiGenericAddress tco2_sts = TCO_REG(tco_base, 0x6, 16);
+    struct AcpiGenericAddress tco1_cnt = TCO_REG(tco_base, 0x8, 16);
+    struct AcpiGenericAddress tco_tmr =  TCO_REG(tco_base, 0x12, 16);
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
+    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * limits/resolution are defined by ICH9 TCO spec
+     */
+    build_append_int_noprefix(table_data, 0x258, 4);/* Timer Period, ms */
+    build_append_int_noprefix(table_data, 0x3ff, 4);/* Maximum Count */
+    build_append_int_noprefix(table_data, 0x4, 4);  /* Minimum Count */
+    /*
+     * WATCHDOG_ENABLED & WATCHDOG_STOPPED_IN_SLEEP_STATE
+     */
+    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * watchdog instruction entries
+     */
+    build_append_int_noprefix(table_data, 10 /* # of actions below */, 4);
+    /* Action table */
+    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
+        WDAT_INS_WRITE_VALUE,
+        tco_rld, 0x1, 0x1ff);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
+        WDAT_INS_READ_VALUE,
+        tco1_cnt, 0x0, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco1_cnt, 0, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
+        WDAT_INS_READ_VALUE,
+        tco1_cnt, 0x800, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco1_cnt, 0x800, 0x800);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
+        WDAT_INS_WRITE_COUNTDOWN,
+        tco_tmr, 0x0, 0x3FF);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_COUNTDOWN_PERIOD,
+        WDAT_INS_READ_COUNTDOWN,
+        tco_tmr, 0x0, 0x3FF);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
+        WDAT_INS_READ_VALUE,
+        tco2_sts, 0x2, 0x2);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco2_sts, 0x2, 0x2);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        tco2_sts, 0x4, 0x4);
+
+    acpi_table_end(linker, &table);
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f622b91b76..b623926de4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -78,6 +78,7 @@
 
 #include "hw/acpi/hmat.h"
 #include "hw/acpi/viot.h"
+#include "hw/acpi/wdat-ich9.h"
 
 #include CONFIG_DEVICES
 
@@ -110,6 +111,7 @@ typedef struct AcpiPmInfo {
     uint16_t cpu_hp_io_base;
     uint16_t pcihp_io_base;
     uint16_t pcihp_io_len;
+    uint64_t tco_io_base;
 } AcpiPmInfo;
 
 typedef struct AcpiMiscInfo {
@@ -204,6 +206,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_io_len = 0;
     pm->smi_on_cpuhp = false;
     pm->smi_on_cpu_unplug = false;
+    pm->tco_io_base = 0;
 
     assert(obj);
     init_common_fadt_data(machine, obj, &pm->fadt);
@@ -225,6 +228,8 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
             !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
         pm->smi_on_cpu_unplug =
             !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT));
+        pm->tco_io_base = object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BASE,
+            NULL) + ICH9_PMIO_TCO_RLD;
     }
     pm->pcihp_io_base =
         object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
@@ -2078,6 +2083,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
 
+    if (pcms->wdat_enabled == true) {
+        g_assert(pm.tco_io_base);
+        acpi_add_table(table_offsets, tables_blob);
+        build_ich9_wdat(tables_blob, tables->linker, x86ms->oem_id,
+                        x86ms->oem_table_id, pm.tco_io_base);
+    }
+
     /* Add tables supplied by user (if any) */
     for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
         unsigned len = acpi_table_len(u);
-- 
2.47.3


