Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7A2C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSNE-0000FI-47; Tue, 04 Mar 2025 08:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMr-00008T-Bv; Tue, 04 Mar 2025 08:31:30 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMp-0004Yo-7m; Tue, 04 Mar 2025 08:31:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 67AB25C5CE4;
 Tue,  4 Mar 2025 13:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88350C4AF0C;
 Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741095076;
 bh=XdC1WV9yBOfdA2FRBZWRs2sr1CJF0slV+rmf0X8pSDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MAHnmGcOwcGxHesS9lQGNLDf9bM/lsaF5nf9YVh7ROjDeC5/2bsaCDEKi5MvvPIj0
 RD6OnRx9iZJJoFUKx2I81UrdujNkypIz4RO0tgcakJteBibmVmcad9s97rVUVBfAvi
 wJwBaUorA5X45c5uHhMFTrmH0/F0YVyOX4u+4PENaBxnnpzBZdNNeh1vHB05nKcRbx
 Ms8A7OyCxAViO0cdV4uMu+bEORLTqjCEzOWfe+doagPGLUss+6RfZdt2VLAz5e/y5W
 kapYSToeivdxSOz2ubZ/Ago82eT5vH3jB36SWFEjk2Zz9MLk4xdUbE0qUkmRQWl+vg
 +x6DO5Z8BWzzg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMc-00000005rnT-20pO; Tue, 04 Mar 2025 14:31:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/3] hw/i186: add support for HEST table with SCI
Date: Tue,  4 Mar 2025 14:30:57 +0100
Message-ID: <02ae08c5e6e1116e587f208159a2ecf80979181d.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Can be tested by setting machine to:
	q35,ras=on

E.g.:

qemu-system-x86_64 --enable-kvm -cpu host -m 4g,maxmem=8G,slots=8 \
	-M q35,nvdimm=on,ras=on \
	-monitor stdio -no-reboot -drive if=pflash,file=OVMF_CODE.fd,format=raw \
	-kernel ../linux/arch/x86_64/boot/bzImage \
	-device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd \
	-device virtio-net-pci,netdev=mynet,id=bob \
	-drive if=none,file=debian.qcow2,format=qcow2,id=hd \
	-object memory-backend-ram,size=4G,id=mem0 \
	-netdev type=user,id=mynet,hostfwd=tcp::5555-:22 \
	-qmp tcp:localhost:4445,server=on,wait=off \
	-append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4 console=ttyS0 console=tty0'

TODO: add a notifier logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/i386/Kconfig      |  1 +
 hw/i386/acpi-build.c | 33 +++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h |  5 +++++
 4 files changed, 81 insertions(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d34ce07b215d..a07d5aa1a138 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -60,6 +60,7 @@ config PC_ACPI
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
     select ACPI_PCI_BRIDGE
+    select ACPI_APEI
     select ACPI_VIOT
     select SMBUS_EEPROM
     select PFLASH_CFI01
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a33280..cf11231b5fe6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -38,6 +38,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "hw/acpi/generic_event_device.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "system/tpm.h"
@@ -69,6 +70,7 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/ghes.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -2431,6 +2433,10 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     return true;
 }
 
+static const AcpiNotificationSourceId hest_ghes_notify[] = {
+    {ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO},
+};
+
 static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
@@ -2587,6 +2593,15 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         cxl_build_cedt(table_offsets, tables_blob, tables->linker,
                        x86ms->oem_id, x86ms->oem_table_id, &pcms->cxl_devices_state);
     }
+    if (pcms->ras) {
+        printf("ADD HEST\n");
+        acpi_add_table(table_offsets, tables_blob);
+        acpi_build_hest(tables_blob, true, tables->hardware_errors,
+                        tables->linker, hest_ghes_notify,
+                        ARRAY_SIZE(hest_ghes_notify),
+                        x86ms->oem_id, x86ms->oem_table_id);
+        printf("ADD HEST: added\n");
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
@@ -2742,6 +2757,24 @@ void acpi_setup(void)
     }
 #endif
 
+    if (pcms->ras) {
+        AcpiGhesState *ags;
+        AcpiGedState *acpi_ged_state;
+
+        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                           NULL));
+        if (acpi_ged_state) {
+            printf("GHES FW_CFG: %p\n", acpi_ged_state);
+
+            ags = &acpi_ged_state->ghes_state;
+
+            acpi_ghes_add_fw_cfg(ags, x86ms->fw_cfg, true,
+                                 tables.hardware_errors);
+
+            printf("GHES FW_CFG: end\n");
+        }
+    }
+
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
         vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), x86ms->fw_cfg,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 63a96cd23f84..b9c32dbdbcd8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -47,6 +47,7 @@
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/acpi/ghes.h"
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
@@ -1683,6 +1684,37 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
     pcms->max_fw_size = value;
 }
 
+static bool virt_get_ras(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->ras;
+}
+
+static void virt_set_ras(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->ras = value;
+}
+
+static void pc_sci_error(Notifier *n, void *opaque)
+{
+    uint16_t *source_id = opaque;
+
+    fprintf(stderr, "GHES error for source ID: %d\n", *source_id);
+
+    /* Currently, only QMP injection is supported */
+    if (*source_id != ACPI_HEST_SRC_ID_QMP)
+        return;
+
+    fprintf(stderr, "GHES error notified for QMP\n");
+
+    // TODO: add something equivalent to:
+    // PCMachineState *s = container_of(n, PCMachineState, ghes_sci_notifier);
+    // acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
+    // by calling acpi_update_sci();
+}
 
 static void pc_machine_initfn(Object *obj)
 {
@@ -1717,6 +1749,10 @@ static void pc_machine_initfn(Object *obj)
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
+
+    pcms->ghes_sci_notifier.notify = pc_sci_error;
+    notifier_list_add(&acpi_generic_error_notifiers,
+                        &pcms->ghes_sci_notifier);
 }
 
 static void pc_machine_reset(MachineState *machine, ResetType type)
@@ -1853,6 +1889,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
         "SMBIOS Entry Point type [32, 64]");
 
+    object_class_property_add_bool(oc, "ras", virt_get_ras,
+                                   virt_set_ras);
+    object_class_property_set_description(oc, "ras",
+                                          "Set on/off to enable/disable reporting host memory errors "
+                                          "to a KVM guest using ACPI and guest external abort exceptions");
+
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f82..105b087e7af6 100644
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
@@ -51,6 +54,8 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     bool fd_bootchk;
+    bool ras;
+
     uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
-- 
2.48.1


