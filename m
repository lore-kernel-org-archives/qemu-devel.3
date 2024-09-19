Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92BACE8D49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9o-0002St-Ij; Thu, 19 Sep 2024 01:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9l-000215-En; Thu, 19 Sep 2024 01:56:45 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9i-0007Qp-U1; Thu, 19 Sep 2024 01:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725403; x=1758261403;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=85v++8FV1/OeoJfcfM2dF4Z0fvvP/1Y4odYjQpC249A=;
 b=We6e8tAkjnhIG9u/GK6oTcvN35Th3auW7KKIpaBLcVhlbROhPTkbDD/y
 sFZ4+BE0t4itnptYTF6T2vUJ+dPLzhwgJ1xz8cpBt15+HRkGMCg53UAV7
 Iz9/yEyzo1O6qcdS0f7Dt4QmdR17VwSou9wJ/q9n1bD4ivnw9VzXmB4p/
 AZ6D3AvARhnWW4PoKzW34A2dri/VGd5YrtrlHZWZvP28qb2yCkKNL68UP
 oP1DuID4VPk90B8P1dO+W+v/yGyMmajMsyoricVzHHDAzjYMHD9VtJZCl
 T3tWJJ/dGH42E3SZzJlJeYuU9XlQVlewnG06swEgXYT1AX92LGarCqSUl w==;
X-CSE-ConnectionGUID: frF3s5S6QrSZZ5Nuzx+kig==
X-CSE-MsgGUID: GGG2KbwMSaGs0fHPZMvdcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813763"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813763"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:56:41 -0700
X-CSE-ConnectionGUID: UYayTWY+RcSOXbGe/lxomA==
X-CSE-MsgGUID: oSBDaJfESCymhB7De9E+LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418828"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:56:32 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 11/12] i386/machine: Split machine initialization after CPU
 creation into post_init()
Date: Thu, 19 Sep 2024 14:11:27 +0800
Message-Id: <20240919061128.769139-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919061128.769139-1-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Custom topology will allow machine to skip the default CPU creation and
accept user's CPU creation from CLI.

Therefore, for microvm, pc-i440fx and pc-q35, split machine
initialization from x86_cpus_init(), and place the remaining part into
post_init(), which can continue to run after CPU creation from CLI.

This addresses the CPU dependency for the remaining initialization steps
after x86_cpus_init().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/microvm.c    |  7 +++++++
 hw/i386/pc_piix.c    | 40 +++++++++++++++++++++++++---------------
 hw/i386/pc_q35.c     | 36 ++++++++++++++++++++++--------------
 include/hw/i386/pc.h |  3 +++
 4 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 49a897db50fc..dc9b21a34230 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -463,6 +463,11 @@ static void microvm_machine_state_init(MachineState *machine)
     microvm_memory_init(mms);
 
     x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+}
+
+static void microvm_machine_state_post_init(MachineState *machine)
+{
+    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
 
     microvm_devices_init(mms);
 }
@@ -665,6 +670,8 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     /* Machine class handlers */
     mc->reset = microvm_machine_reset;
 
+    mc->post_init = microvm_machine_state_post_init;
+
     /* hotplug (for cpu coldplug) */
     mc->get_hotplug_handler = microvm_get_hotplug_handler;
     hc->pre_plug = microvm_device_pre_plug_cb;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2bf6865d405e..c1db2f3129cf 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -105,19 +105,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
-    ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
-    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
-    uint64_t hole64_size = 0;
 
+    pcms->pci_type = pci_type;
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
      * complicated for backward compatibility reasons ...
@@ -150,9 +140,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
      *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
      */
     if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
+        xen_hvm_init_pc(pcms, &pcms->pre_config_ram);
     } else {
-        ram_memory = machine->ram;
+        pcms->pre_config_ram = machine->ram;
         if (!pcms->max_ram_below_4g) {
             pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
         }
@@ -182,6 +172,23 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
+}
+
+static void pc_post_init1(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    uint64_t hole64_size = 0;
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -195,7 +202,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
         object_property_add_child(OBJECT(machine), "i440fx", phb);
         object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
+                                 OBJECT(pcms->pre_config_ram), &error_fatal);
         object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
                                  OBJECT(pci_memory), &error_fatal);
         object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
@@ -206,7 +213,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                  x86ms->below_4g_mem_size, &error_fatal);
         object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                                  x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pcms->pci_type,
                                 &error_fatal);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
@@ -413,6 +420,7 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 static void pc_init_isa(MachineState *machine)
 {
     pc_init1(machine, NULL);
+    pc_post_init1(machine);
 }
 #endif
 
@@ -423,6 +431,7 @@ static void pc_xen_hvm_init_pci(MachineState *machine)
                 TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
 
     pc_init1(machine, pci_type);
+    pc_post_init1(machine);
 }
 
 static void pc_xen_hvm_init(MachineState *machine)
@@ -463,6 +472,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_nic = "e1000";
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    m->post_init = pc_post_init1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8319b6d45ee3..9ce3e65d7182 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -129,21 +129,7 @@ static void pc_q35_init(MachineState *machine)
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
-    Object *phb;
-    PCIDevice *lpc;
-    DeviceState *lpc_dev;
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
-    GSIState *gsi_state;
-    ISABus *isa_bus;
-    int i;
     ram_addr_t lowmem;
-    DriveInfo *hd[MAX_SATA_PORTS];
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    bool acpi_pcihp;
-    bool keep_pci_slot_hpc;
-    uint64_t pci_hole64_size = 0;
 
     assert(pcmc->pci_enabled);
 
@@ -188,6 +174,27 @@ static void pc_q35_init(MachineState *machine)
 
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
+}
+
+static void pc_q35_post_init(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    Object *phb;
+    PCIDevice *lpc;
+    DeviceState *lpc_dev;
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
+    GSIState *gsi_state;
+    ISABus *isa_bus;
+    int i;
+    DriveInfo *hd[MAX_SATA_PORTS];
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    bool acpi_pcihp;
+    bool keep_pci_slot_hpc;
+    uint64_t pci_hole64_size = 0;
 
     if (kvm_enabled()) {
         kvmclock_create(pcmc->kvmclock_create_always);
@@ -348,6 +355,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->no_floppy = 1;
     m->max_cpus = 4096;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    m->post_init = pc_q35_post_init;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 14ee06287da3..14534781e8fb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -58,6 +58,9 @@ typedef struct PCMachineState {
 
     SGXEPCState sgx_epc;
     CXLState cxl_devices_state;
+
+    MemoryRegion *pre_config_ram;
+    const char *pci_type;
 } PCMachineState;
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
-- 
2.34.1


