Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B747C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaM-0005Hd-9y; Sat, 05 Sep 2026 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaJ-0005F0-7p; Sat, 05 Sep 2026 13:53:47 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaG-0008Jw-US; Sat, 05 Sep 2026 13:53:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0909F4478A;
 Sat,  5 Sep 2026 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6461F00A3E;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=Ij2k42owOV+OROf/MB1CscRZGK/WiXn0iNaX3gJtNOA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aHbrx/Pi1mSKsyM4sJWwLAOZiZR80J5VArsW7fPn6Iayk29EJf64O4uhsRKLXVCWn
 5R5Kwjn6lN5RZCMQ0DAvD/daUyCz9xGL/4s+JC+N0X8U91g+O92sH0SzecoxgrHtAB
 Zvj+T0JyUWfhsmrYvLUCywt6EpR40X4WZ4UR8qtOGX6cIu6n/s/bllyuYY0/G3E6ub
 Y6bYk2tkYnD+ESdXUfcBKAssVjgi9UwXzxFTF4RdPgjfQWSvxlepHhF757FqXse2Pz
 R1QKjyIbR8DGHG4/sVe5eH0SryTsS0r1SIxMVAoOGgmsoK7bgKg185Z+ymhRZ5Q8Ha
 oMp710YheFqHA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bkrp-34eB; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/8] hw/i186: add support for HEST table with SCI
Date: Sat,  5 Sep 2026 19:53:23 +0200
Message-ID: <b57abc926bb60af1ebb4c444f0e1b5ea94d46444.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Added needed bits at x86 architecture to allow both pb and
q32 machines to support GHESv2 via HEST tables.

To do that, add needed _OSC capability bits to enable APEI
support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/i386/Kconfig      |  1 +
 hw/i386/acpi-build.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 41 ++++++++++++++++++
 include/hw/i386/pc.h |  5 +++
 4 files changed, 146 insertions(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index e27d8816e5bb..b1fbfaf33f9b 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -47,6 +47,7 @@ config PC
     select MC146818RTC
     # For ACPI builder:
     select SERIAL_ISA
+    select ACPI_APEI
     select ACPI_PCI
     select ACPI_VMGENID
     select ACPI_VMCLOCK
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687d1..78ff78bd8200 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -71,6 +71,7 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/ghes.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -852,6 +853,53 @@ static void build_acpi0017(Aml *table)
     aml_append(table, scope);
 }
 
+/* ACPI 5.0, 6.2.10.2: Platform-Wide OSPM Capabilities. */
+#define ACPI_OSC_CAP_APEI                  (1U << 4)
+
+static Aml *build_apei_osc(uint32_t mask, uint32_t bits)
+{
+    Aml *method = aml_method("_OSC", 4, AML_SERIALIZED);
+    uint8_t failure[8] = { 2 }; /* _OSC failure */
+    uint32_t disabled = mask & ~bits;
+    Aml *support = aml_name("CDW2");
+    Aml *status = aml_name("CDW1");
+    Aml *if_ctx;
+
+    if_ctx = aml_if(aml_lless(aml_sizeof(aml_arg(3)), aml_int(8)));
+    aml_append(if_ctx, aml_return(aml_buffer(sizeof(failure), failure)));
+    aml_append(method, if_ctx);
+    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
+
+    /* capacity buffer */
+    if_ctx = aml_if(aml_lnot(aml_equal(aml_arg(0),
+                             aml_touuid("0811B06E-4A27-44F9-8D60-3CBBC22E7B48"))));
+    aml_append(if_ctx, aml_or(status, aml_int(4), status));
+    aml_append(if_ctx, aml_return(aml_arg(3)));
+    aml_append(method, if_ctx);
+
+    /* Revision ID: 1 */
+    if_ctx = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
+    aml_append(if_ctx, aml_or(status, aml_int(8), status));
+    aml_append(if_ctx, aml_return(aml_arg(3)));
+    aml_append(method, if_ctx);
+
+    /* Count of entries in arg 3: 2 */
+    if_ctx = aml_if(aml_lnot(aml_equal(aml_arg(2), aml_int(2))));
+    aml_append(if_ctx, aml_or(status, aml_int(2), status));
+    aml_append(if_ctx, aml_return(aml_arg(3)));
+    aml_append(method, if_ctx);
+
+    /* Update needed Platform-Wide _OSC Capabilities */
+    aml_append(method, aml_and(support, aml_int(~disabled), aml_local(0)));
+    if_ctx = aml_if(aml_lnot(aml_equal(support, aml_local(0))));
+    aml_append(if_ctx, aml_or(status, aml_int(0x10), status));
+    aml_append(method, if_ctx);
+    aml_append(method, aml_store(aml_local(0), support));
+    aml_append(method, aml_return(aml_arg(3)));
+    return method;
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1281,6 +1329,21 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, scope);
     }
 
+    if (pcms->ras) {
+        sb_scope = aml_scope("_SB");
+        aml_append(sb_scope, build_apei_osc(ACPI_OSC_CAP_APEI,
+                                            ACPI_OSC_CAP_APEI));
+        aml_append(sb_scope, aml_error_device());
+        aml_append(dsdt, sb_scope);
+
+        scope = aml_scope("_GPE");
+        method = aml_method("_E07", 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_notify(aml_name("\\_SB." ACPI_APEI_ERROR_DEVICE),
+                                      aml_int(0x80)));
+        aml_append(scope, method);
+        aml_append(dsdt, scope);
+    }
+
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
     acpi_table_end(linker, &table);
@@ -2011,6 +2074,10 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     return true;
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_SCI},
+};
+
 static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
@@ -2167,6 +2234,16 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         cxl_build_cedt(table_offsets, tables_blob, tables->linker,
                        x86ms->oem_id, x86ms->oem_table_id, &pcms->cxl_devices_state);
     }
+    if (pcms->ras) {
+        AcpiGhesState *ags =
+            acpi_device_get_ghes_state(ACPI_DEVICE_IF(x86ms->acpi_dev));
+
+        acpi_add_table(table_offsets, tables_blob);
+        acpi_build_hest(ags, tables_blob, tables->hardware_errors,
+                        tables->linker, hest_ghes_notify,
+                        ARRAY_SIZE(hest_ghes_notify),
+                        x86ms->oem_id, x86ms->oem_table_id);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
@@ -2283,6 +2360,21 @@ void acpi_setup(void)
     static FwCfgTPMConfig tpm_config;
 #endif
 
+    if (pcms->ras) {
+        AcpiGhesState *ags = NULL;
+
+        if (x86ms->acpi_dev) {
+            ags = acpi_device_get_ghes_state(ACPI_DEVICE_IF(x86ms->acpi_dev));
+        }
+        if (!x86ms->fw_cfg || !pcms->acpi_build_enabled ||
+            !x86_machine_is_acpi_enabled(x86ms) || !ags) {
+            error_report("ras=on requires ACPI table generation and a PC "
+                         "ACPI controller");
+            exit(EXIT_FAILURE);
+        }
+        ags->use_hest_addr = true;
+    }
+
     if (!x86ms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
         return;
@@ -2329,6 +2421,13 @@ void acpi_setup(void)
     }
 #endif
 
+    if (pcms->ras) {
+        AcpiGhesState *ags =
+            acpi_device_get_ghes_state(ACPI_DEVICE_IF(x86ms->acpi_dev));
+
+        acpi_ghes_add_fw_cfg(ags, x86ms->fw_cfg, tables.hardware_errors);
+    }
+
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
         vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), x86ms->fw_cfg,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e32..5906152ed31e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -50,6 +50,7 @@
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pc-hotplug.h"
+#include "hw/acpi/ghes.h"
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
@@ -1611,6 +1612,34 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
     pcms->max_fw_size = value;
 }
 
+static bool pc_machine_get_ras(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->ras;
+}
+
+static void pc_machine_set_ras(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->ras = value;
+}
+
+static void pc_sci_error(Notifier *n, void *opaque)
+{
+    PCMachineState *pcms = container_of(n, PCMachineState, ghes_sci_notifier);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
+    uint16_t *source_id = opaque;
+
+    /* Currently, only QMP injection is supported */
+    if (!pcms->ras || !x86ms->acpi_dev ||
+        *source_id != ACPI_HEST_SRC_ID_QMP) {
+        return;
+    }
+
+    acpi_send_event(DEVICE(x86ms->acpi_dev), ACPI_GENERIC_ERROR);
+}
 
 static void pc_machine_initfn(Object *obj)
 {
@@ -1645,12 +1674,18 @@ static void pc_machine_initfn(Object *obj)
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
+
+    pcms->ghes_sci_notifier.notify = pc_sci_error;
+    notifier_list_add(&acpi_generic_error_notifiers,
+                        &pcms->ghes_sci_notifier);
 }
 
 static void pc_machine_finalize(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
+    notifier_remove(&pcms->ghes_sci_notifier);
+
     if (pcms->pcspk && !qdev_is_realized(DEVICE(pcms->pcspk))) {
         object_unref(OBJECT(pcms->pcspk));
     }
@@ -1769,6 +1804,12 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
         "SMBIOS Entry Point type [32, 64]");
 
+    object_class_property_add_bool(oc, "ras", pc_machine_get_ras,
+                                   pc_machine_set_ras);
+    object_class_property_set_description(oc, "ras",
+                                          "Set on/off to enable/disable reporting host memory errors "
+                                          "to a KVM guest using ACPI and guest external abort exceptions");
+
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed57fa..52b4e18ab7db 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -30,6 +30,9 @@ typedef struct PCMachineState {
     /* State for other subsystems/APIs: */
     Notifier machine_done;
 
+    /* Triggered when a new SCI GHES error raises */
+    Notifier ghes_sci_notifier;
+
     /* Pointers to devices and objects: */
     PCIBus *pcibus;
     I2CBus *smbus;
@@ -52,6 +55,8 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     bool fd_bootchk;
+    bool ras;
+
     uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
-- 
2.55.0


