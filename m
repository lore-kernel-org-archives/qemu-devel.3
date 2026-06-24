Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C208FCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKqs-0006s9-OW; Wed, 24 Jun 2026 06:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKqr-0006qj-4h
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKqp-0007CN-49
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782296938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMbcEBa5NOl5Dg8dRc0zIT/e0EYx+nZ1G0Qrji2bcXk=;
 b=O1Wi/0B+S+8Ow9UM98bDd4nTa+T7ewh0R9/b6QBjoVwowJOs4jiqFYE0eNxlM3dyKh5QFM
 oWROoYb7zHpN3i/T4SCRiFMueC8hKqP78gLrkMVhGZy57v+ghxyl+HEfBOD3Ce41UVCJo5
 bf0K8Vr3loFuKoiLDpfrpwfGT2J5LJA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-SGPjti55MtWGG-sXjc7BqQ-1; Wed,
 24 Jun 2026 06:28:53 -0400
X-MC-Unique: SGPjti55MtWGG-sXjc7BqQ-1
X-Mimecast-MFC-AGG-ID: SGPjti55MtWGG-sXjc7BqQ_1782296932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79A681800D8F; Wed, 24 Jun 2026 10:28:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6362130001A7; Wed, 24 Jun 2026 10:28:49 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v3 06/17] acpi: introduce WDAT table for  GWDT
Date: Wed, 24 Jun 2026 12:28:19 +0200
Message-ID: <20260624102830.1355552-7-imammedo@redhat.com>
In-Reply-To: <20260624102830.1355552-1-imammedo@redhat.com>
References: <20260624102830.1355552-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add build_gwdt_wdat() to generate a Watchdog Action Table
tailored for the SBSA Generic Watchdog Timer.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  (Eric)
    - split '[PATCH v2 11/21] arm: virt: add support for WDAT based watchdog'
      on smaller chunks.
    - add/improve  comments where requested
    - actualy use 'freq' argument passed down by caller
    - simplify magic val on WRR write and add comment
    - group table records by used register
---
 include/hw/acpi/wdat-gwdt.h | 19 +++++++
 hw/acpi/meson.build         |  2 +
 hw/acpi/wdat-gwdt-stub.c    | 16 ++++++
 hw/acpi/wdat-gwdt.c         | 99 +++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c

diff --git a/include/hw/acpi/wdat-gwdt.h b/include/hw/acpi/wdat-gwdt.h
new file mode 100644
index 0000000000..42339e031e
--- /dev/null
+++ b/include/hw/acpi/wdat-gwdt.h
@@ -0,0 +1,19 @@
+/*
+ * GWDT Watchdog Action Table (WDAT) definition
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_GWDT_H
+#define QEMU_HW_ACPI_WDAT_GWDT_H
+
+#include "hw/acpi/aml-build.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq);
+
+#endif /* QEMU_HW_ACPI_WDAT_GWDT_H */
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 0c7bfb278a..09ad488a04 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -31,11 +31,13 @@ acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
 stub_ss.add(files('ipmi-stub.c'))
 stub_ss.add(files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
 stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
 stub_ss.add(files('pci-bridge-stub.c'))
+stub_ss.add(files('wdat-gwdt-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 stub_ss.add(files('ghes_cper_stub.c'))
diff --git a/hw/acpi/wdat-gwdt-stub.c b/hw/acpi/wdat-gwdt-stub.c
new file mode 100644
index 0000000000..4d43783f70
--- /dev/null
+++ b/hw/acpi/wdat-gwdt-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/wdat-gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/acpi/wdat-gwdt.c b/hw/acpi/wdat-gwdt.c
new file mode 100644
index 0000000000..b30566ef6a
--- /dev/null
+++ b/hw/acpi/wdat-gwdt.c
@@ -0,0 +1,99 @@
+/*
+ * SBSA GWDT Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat-gwdt.h"
+#include "hw/acpi/wdat.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+#define GWDT_REG(base, reg_offset, reg_width) { \
+                 .space_id = AML_AS_SYSTEM_MEMORY, \
+                 .address = base + reg_offset, .bit_width = reg_width, \
+                 .access_width = AML_DWORD_ACC };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ */
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    struct AcpiGenericAddress wrr =  GWDT_REG(rbase, 0x0, 32);
+    struct AcpiGenericAddress wor_l =  GWDT_REG(cbase, SBSA_GWDT_WOR, 32);
+    struct AcpiGenericAddress wcs =  GWDT_REG(cbase, SBSA_GWDT_WCS, 32);
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
+    /*
+     * PCI location fields are set to 0xff to indicate
+     * that the watchdog is not a PCI device.
+     */
+    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * WDAT spec: "The clock interval that the WDT uses must be
+     * greater than or equal to 1 millisecond."
+     */
+    g_assert(freq <= 1000);
+    /* Timer Period, ms */
+    build_append_int_noprefix(table_data, 1000 / freq, 4);
+    /*
+     * WDAT spec: "The time-out period before the WDT fires is recommended
+     * to be at least 5 minutes."
+     * Set max count to 10min and min count to 5sec.
+     */
+    build_append_int_noprefix(table_data, 600 * freq, 4); /* Maximum Count */
+    build_append_int_noprefix(table_data, 5 * freq, 4);   /* Minimum Count */
+    /*
+     * WATCHDOG_ENABLED | WATCHDOG_STOPPED_IN_SLEEP_STATE
+     */
+    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * watchdog instruction entries
+     */
+    build_append_int_noprefix(table_data, 8, 4);
+    /* Action table: WCS (control/status) register actions */
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x1, 0x1);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 1, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x4, 0x00000004);
+    /* WOR (offset) and WRR (refresh) register actions */
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
+        WDAT_INS_WRITE_COUNTDOWN,
+        wor_l, 0, 0xffffffff);
+    /* WRR: any write refreshes the watchdog, value is ignored */
+    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
+        WDAT_INS_WRITE_VALUE,
+        wrr, 0x1, 0x1);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wrr, 0x4, 0x4);
+
+    acpi_table_end(linker, &table);
+}
-- 
2.47.3


