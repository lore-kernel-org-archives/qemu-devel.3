Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB1606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rd2Y+mqv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyWw-0007eE-1v; Sun, 08 Nov 2026 03:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWp-0007aj-Kl; Sun, 08 Nov 2026 03:45:31 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWn-0000J4-D9; Sun, 08 Nov 2026 03:45:31 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0BEB4496E;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F11F0089F;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794127516;
 bh=epOF4OJpnItDTMQe4XsS/qKrRz2EeKyDCsW0kSFF+kQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Rd2Y+mqvDWdkdpkqh6OHvP0xcANDSm6J6tF/ydw60GPR8llCabl+b7hHx5QHij24Z
 N7FNtn7eluePu1wNMkyUgnnVa9hyOdLzvLSckLKUxH5F8ziAUtU4ugpsbIKHQFJ3CD
 T4e5dacpcT+L8LIcy3Ika7A/gJ08fx2V0q3q51yPMh+uNox324T5GrOk87SEnv900p
 8fswvWLefrLRSbBTFjiWL1UXmMxV6tzmBBPXVXD7cQiuqPTrAD5jRepin3RGBAIRww
 e23W/fMlThEeHB3kd84uiqmhypLbiTmSpG5Pa6yGI8j6xl3yISvdzxYL/n3x14vKtq
 gDdtak08VWqSQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWY-00000005TMT-2Uni; Sun, 08 Nov 2026 09:45:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/8] hw/i186: add support for HEST table with SCI
Date: Sun,  8 Nov 2026 09:45:04 +0100
Message-ID: <cb0bec3ea9187472c6e252b9be8685ec7e99835b.1794124132.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794124132.git.mchehab+huawei@kernel.org>
References: <cover.1794124132.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The _OSC device configuration object evaluates some platform
software specific support. Among them, there are bits there
to indicate if APEI support is enabled. Those are sitting
at the UUID 0811B06E-4A27-44F9-8D60-3CBBC22E7B48.

Bit 4 is APEI support. it has to be enabled to let x86 use
APEI/HEST/GHES.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/i386/Kconfig      |   1 +
 hw/i386/acpi-build.c | 102 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         |  41 +++++++++++++++++
 include/hw/i386/pc.h |   5 +++
 4 files changed, 149 insertions(+)

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
index 985515434974..6f960c66e2a4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -71,6 +71,7 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/ghes.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -852,6 +853,56 @@ static void build_acpi0017(Aml *table)
     aml_append(table, scope);
 }
 
+/* ACPI 5.0, 6.2.10.2: Platform-Wide OSPM Capabilities. */
+#define ACPI_PLAT_OSPM_CAP "0811B06E-4A27-44F9-8D60-3CBBC22E7B48"
+
+/* ACPI 5.0: Table 6-151: Platform-Wide _OSC caps DWORD 2 */
+#define ACPI_OSC_CAP_APEI  (1U << 4)
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
+    /* Arg0: UUID */
+    if_ctx = aml_if(aml_lnot(aml_equal(aml_arg(0),
+                    aml_touuid(ACPI_PLAT_OSPM_CAP))));
+    aml_append(if_ctx, aml_or(status, aml_int(4), status));
+    aml_append(if_ctx, aml_return(aml_arg(3)));
+    aml_append(method, if_ctx);
+
+    /* Arg1: Revision ID: 1 */
+    if_ctx = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
+    aml_append(if_ctx, aml_or(status, aml_int(8), status));
+    aml_append(if_ctx, aml_return(aml_arg(3)));
+    aml_append(method, if_ctx);
+
+    /* Arg2: count of entries in Arg3: 2 dwords */
+    if_ctx = aml_if(aml_lnot(aml_equal(aml_arg(2), aml_int(2))));
+    aml_append(if_ctx, aml_or(status, aml_int(2), status));
+    aml_append(if_ctx, aml_return(aml_arg(3)));
+    aml_append(method, if_ctx);
+
+    /* Arg3: Second DWORD: caps - update according with mask */
+    aml_append(method, aml_and(support, aml_int(~disabled), aml_local(0)));
+    if_ctx = aml_if(aml_lnot(aml_equal(support, aml_local(0))));
+    aml_append(if_ctx, aml_or(status, aml_int(mask), status));
+    aml_append(method, if_ctx);
+    aml_append(method, aml_store(aml_local(0), support));
+    aml_append(method, aml_return(aml_arg(3)));
+    return method;
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1284,6 +1335,21 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
@@ -2043,6 +2109,10 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     return true;
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_SCI},
+};
+
 static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
@@ -2199,6 +2269,16 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
@@ -2315,6 +2395,21 @@ void acpi_setup(void)
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
@@ -2361,6 +2456,13 @@ void acpi_setup(void)
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
index 4737eb471c14..28af7f507dab 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -51,6 +51,7 @@
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pc-hotplug.h"
+#include "hw/acpi/ghes.h"
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
@@ -1608,6 +1609,34 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
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
@@ -1642,12 +1671,18 @@ static void pc_machine_initfn(Object *obj)
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
@@ -1773,6 +1808,12 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
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
index 844ae835784f..533612194f32 100644
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
@@ -57,6 +60,8 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     bool fd_bootchk;
+    bool ras;
+
     uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
-- 
2.56.0


