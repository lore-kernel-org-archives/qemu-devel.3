Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C23DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERv5-0000c9-T9; Thu, 30 Oct 2025 08:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vERv0-0000aZ-Ax
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vERup-00075Q-MB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761827885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAHVVTSyx5Xxrd9+qsV63pT0QmdiWt4y9ARsLPf+/nY=;
 b=Pn5ykeAhuFNg1ohad/61SH0wvkmGkY3Ul5ZBXgtDigw7d/4BzkLKHLP58bQYgS4iAoyF4o
 BI93gDoDlaa87TISrW/YMq5E73JFbKlPEAKHzZYIv+PBr+I3v95ufx0lEjhYSLt2rrOwIc
 Yw53kLInmu+Mk7kPB1ny7WiCtn/aWhY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-32n98en7Op-FuE5mE2AxzQ-1; Thu,
 30 Oct 2025 08:38:03 -0400
X-MC-Unique: 32n98en7Op-FuE5mE2AxzQ-1
X-Mimecast-MFC-AGG-ID: 32n98en7Op-FuE5mE2AxzQ_1761827882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E741954B0D
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:38:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 415491800581; Thu, 30 Oct 2025 12:38:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, berrange@redhat.com, rjones@redhat.com
Subject: [PATCH 3/5] x86: q35: generate WDAT ACPI table
Date: Thu, 30 Oct 2025 13:37:48 +0100
Message-ID: <20251030123750.136175-4-imammedo@redhat.com>
In-Reply-To: <20251030123750.136175-1-imammedo@redhat.com>
References: <20251030123750.136175-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It will generate WDAT table [1] customized for TCO watchdog.
This allows Windows guests (Windows Server 2008/Vista) to
use TCO watchdog using built-in generic driver, which
aleviates need to install vendor specific drivers.

Given that enabling it might change guest behaviour
(both Windows/Linux) the feature is disabled by default.

Users that need it can enable the feature with
following CLI option.
    -global 'ICH9-LPC.wdat=on'

1)
   "Hardware Watchdog Timers Design Specification"
    https://uefi.org/acpi 'Watchdog Action Table (WDAT)'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/wdat.h |  3 ++
 hw/acpi/meson.build    |  3 +-
 hw/acpi/wdat-ich9.c    | 85 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/wdat-stub.c    | 16 ++++++++
 hw/i386/acpi-build.c   | 13 +++++++
 5 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 hw/acpi/wdat-stub.c

diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
index c539e97e9b..67b9136d8c 100644
--- a/include/hw/acpi/wdat.h
+++ b/include/hw/acpi/wdat.h
@@ -115,4 +115,7 @@ void build_append_wdat_ins(GArray *table_data,
                            struct AcpiGenericAddress as,
                            uint32_t val, uint32_t mask);
 
+void build_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base);
+
 #endif /* QEMU_HW_ACPI_WDAT_H */
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 56b5d1ec96..fb4304f21c 100644
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
+system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
diff --git a/hw/acpi/wdat-ich9.c b/hw/acpi/wdat-ich9.c
new file mode 100644
index 0000000000..c32ecf922c
--- /dev/null
+++ b/hw/acpi/wdat-ich9.c
@@ -0,0 +1,85 @@
+/*
+ * TCO Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2025
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat.h"
+#include "hw/southbridge/ich9.h"
+
+#define TCO_REG(base, reg_offset, reg_width) { .space_id = AML_AS_SYSTEM_IO, \
+            .address = base + reg_offset, .bit_width = reg_width, \
+            .access_width = AML_WORD_ACC, };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ */
+void build_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base)
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
+    build_append_int_noprefix(table_data, 10, 4);
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
diff --git a/hw/acpi/wdat-stub.c b/hw/acpi/wdat-stub.c
new file mode 100644
index 0000000000..a9b57a047b
--- /dev/null
+++ b/hw/acpi/wdat-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright Red Hat, Inc. 2025
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat.h"
+
+void build_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                const char *oem_table_id, uint64_t tco_base)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862..ac420eab81 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -77,6 +77,7 @@
 
 #include "hw/acpi/hmat.h"
 #include "hw/acpi/viot.h"
+#include "hw/acpi/wdat.h"
 
 #include CONFIG_DEVICES
 
@@ -104,11 +105,13 @@ typedef struct AcpiPmInfo {
     bool smi_on_cpuhp;
     bool smi_on_cpu_unplug;
     bool pcihp_root_en;
+    bool wdat_enabled;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
     uint16_t pcihp_io_base;
     uint16_t pcihp_io_len;
+    uint64_t tco_io_base;
 } AcpiPmInfo;
 
 typedef struct AcpiMiscInfo {
@@ -203,6 +206,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->pcihp_io_len = 0;
     pm->smi_on_cpuhp = false;
     pm->smi_on_cpu_unplug = false;
+    pm->wdat_enabled = false;
 
     assert(obj);
     init_common_fadt_data(machine, obj, &pm->fadt);
@@ -224,6 +228,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
             !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
         pm->smi_on_cpu_unplug =
             !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT));
+        pm->wdat_enabled = object_property_get_bool(obj, "wdat", NULL);
+        pm->tco_io_base = object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BASE,
+            NULL) + ICH9_PMIO_TCO_RLD;
     }
     pm->pcihp_io_base =
         object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
@@ -2079,6 +2086,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
 
+    if (pm.wdat_enabled == true) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_wdat(tables_blob, tables->linker, x86ms->oem_id,
+                   x86ms->oem_table_id, pm.tco_io_base);
+    }
+
     /* Add tables supplied by user (if any) */
     for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
         unsigned len = acpi_table_len(u);
-- 
2.47.3


