Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D36ECD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDP-0000Ao-LY; Sun, 14 Jun 2026 15:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD4-0007Z3-9W
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD1-0002e7-IN
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mhm2Z0+zF7FCJcUlbFK2dWY8j2xichPXZTo2x7IOY8=;
 b=UsZ4eXQqBDaYOPvouHB8sK4/Ajkh1YZEGSBxg58aM2fWmuyS6lSPChQd1LXuYL2gi8x2dl
 Bt5R4Zu8qi+tOkZ3UH16X5LYb7HhHoe/ZIQVjYEcZcwQhwcW613rIU8iwq88j64m+iDo3i
 8EclXqBikE4eDkrODZ3eZGhmVK9VT00=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-oa_8DS0ZNCa2Rc1cFVk_xw-1; Sun, 14 Jun 2026 15:09:25 -0400
X-MC-Unique: oa_8DS0ZNCa2Rc1cFVk_xw-1
X-Mimecast-MFC-AGG-ID: oa_8DS0ZNCa2Rc1cFVk_xw_1781464165
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490e547f3cfso24343395e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464164; x=1782068964; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mhm2Z0+zF7FCJcUlbFK2dWY8j2xichPXZTo2x7IOY8=;
 b=acQqBRwJ8ykXgYG8FD6fZ+EAHuupO1v2PAGkw8HdbNrqd1l+OoZbrIrFpszTJN3rJo
 /GlTXFPRIHNZM+4x5uNEaFXltLmP0jASn9M3mFLk5EnCFU+8cCtwB1l6VmVE7q9knIh2
 IvwwqOYbV5PDEQgW+kR2hoUrDkthFtj1APlSsh89yodcEWpmWrFHXUmOKEIQ5aJp7RA9
 WzbeFyYo7fozypfhKz8ofAqpXLoqCK8aMW97V8BHKOy4dDEFTYcgz+9uFzjHQKku9L26
 Mwd3U9gvRMtTT8Q/nSHWrcu8yJMV+TZPbbRbUA681Yg6fwUD/ah1MNBZaGysBvyr/7hI
 Cm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464164; x=1782068964;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7mhm2Z0+zF7FCJcUlbFK2dWY8j2xichPXZTo2x7IOY8=;
 b=sYBaSHc65HNtucuyE6x/MQ4s+CtPIawkq5JJUenUhbtCvKO4765QaApScyiev6J7+5
 Lo9Kgth5Gm4hanknPFsemEA+qOcsk/fq1pezUmPrlPsnpLeFgkoBnqc+V3gcOe/bSta2
 EdckAIIKXruY760y464sQygIcH+v2n1HE9Xemzto1/CO3PvyWVEiO8J5cvs/CdwNvgRr
 rkiLlhTu/aPeggj3NoVU/8cABA3YFd17xsN5o20vQ/Qi/70+M0Pt+PeqUcBqnV8MeHsQ
 3FwAC8qEDPfIeYXIrQjASSjQBcbQdR3C4ad8HSG2wNWY0LTmDOd78VuI5oqr3jUTpxQU
 trqA==
X-Gm-Message-State: AOJu0YwsgQsyTlN/2VH85lLjo5El6k90ifcgLm8alxkXL/kcIUARl+GB
 8nB6gBl5e8FFBDi20OB9xWPyKKjx6LvFhuIGIM/2lTFj6PejDV8dYdJDOgfhpRw2JNAsV15u5Ky
 uk5SyMnBmOh5K3OkLwWGjqa79ZMkF1F8F93j0mvIokutvMc6nIDmEK5DOY515xbRxpoFfuDFVIQ
 cns2o6bo6SLlCqCnQ7DxE12sFzYofRL4UK/Q==
X-Gm-Gg: Acq92OGl6jaHisgSeFPfmd2+AcnBTeLOsejt3DyN7Dby8SBESM3zuOIHG45bXggM6am
 204eT5Oxt6pVpnMUFHowVWS3kvKsGPoPVQRwSEvWn3vuAtwcCQhYS7VXeaSo8w1zFXQnpgpTpno
 O/+FpZVd0qMvt2E5U7DocZWxou0SAvbdH/bcnuhZcqGrcs6+srfl9+ieqVLK1ZYwhXMyjrTZRWL
 x/g/pxSuEl5+ZKQijWnLNfekdW4rL1RHWp8t8NewKfBMMyB5ai/GHvHG1pH8Tl7PHmrxtlB7FBe
 E7bFqC11RDESK7P2fAlbpri4hYTgoIRjoqC/p6RRHhUKnjvgYIZgFOHd95C3OXaLL8FvVoShq0x
 oBlcWRGQ6nALTNhtXJJHnkDb8vMpdfN3Gv/A/741KFeE=
X-Received: by 2002:a05:600c:a47:b0:490:52c0:744c with SMTP id
 5b1f17b1804b1-490ec4ee63cmr139784365e9.20.1781464164396; 
 Sun, 14 Jun 2026 12:09:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:490:52c0:744c with SMTP id
 5b1f17b1804b1-490ec4ee63cmr139784065e9.20.1781464163799; 
 Sun, 14 Jun 2026 12:09:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm3218801f8f.23.2026.06.14.12.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:23 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 087/106] x86: q35: generate WDAT ACPI table
Message-ID: <f7060ac4e7dda3edc6153356c6d665f27847368c.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260303092532.2410177-4-imammedo@redhat.com>
---
 hw/acpi/meson.build         |  3 +-
 hw/acpi/wdat-ich9-stub.c    | 15 +++++++
 hw/acpi/wdat-ich9.c         | 90 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 12 +++++
 include/hw/acpi/wdat-ich9.h | 15 +++++++
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/wdat-ich9-stub.c
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 include/hw/acpi/wdat-ich9.h

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 1c5251909b..0c7bfb278a 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -25,7 +25,8 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
 stub_ss.add(files('acpi-pci-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c', 'wdat-ich9.c'))
+stub_ss.add(files('wdat-ich9-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
 stub_ss.add(files('ipmi-stub.c'))
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
index 0d7c83d5e9..2ee061558c 100644
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
-- 
MST


