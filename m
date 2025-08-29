Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226B8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGl-0007Wo-NA; Sat, 30 Aug 2025 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiZ-0001D3-Cq
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiS-0008Q1-4Y
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxkiFnVY+mg3VKabUNHDgm4c9XtnC0Fwn5bhubwexes=;
 b=bm0yiVXSIffMBqoeS1Lc/PnyUjTI6Vc3UstnUi4/AjgTeRg5HXclw0jaNOtLONsjf4zjcz
 7ulNdzDe0oSqLJN5X8v/LqPVrlvcBMd72kBzhqCMD02k2H7srbwAorYbGderLTRY4RlwEJ
 qv0EwgjC3gSZ3+If0z3wwzR12JnoHQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-q53OVtmEO3-K0XXlwAMHgQ-1; Fri, 29 Aug 2025 09:00:24 -0400
X-MC-Unique: q53OVtmEO3-K0XXlwAMHgQ-1
X-Mimecast-MFC-AGG-ID: q53OVtmEO3-K0XXlwAMHgQ_1756472423
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5ff1so922735f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472423; x=1757077223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxkiFnVY+mg3VKabUNHDgm4c9XtnC0Fwn5bhubwexes=;
 b=vO0qDtWB7lsP2UvMhIthpUCccEOWe5SHJXWEnZGyb8Aqt21jX4pONlfcnojzP/3l6P
 e/5gsS4yS1ZJTN8sTN3CuhnI5B35GCHitL2Tw+D4LXx3l24s0vOGCM7dF9RRqMuiHTc8
 7ENjIatAT7iaPoKWtnM/1KJAIGuYxs2aHGCOo4a6CgnEW57JVSia8XIlQUyVCMb/zo+x
 K26ArLnPfZ2KWOcCaCnwuj+y/1+ILZZdcSS2z27ZCZo0jOtS2ZF8OQOcQpUJhbkn092I
 /d420vRgTCVJ/z8hb/8u7wXAjoCSXpw2kBS98aIs/4wvx33b04OiYF5twzOSuGwrqWwk
 Heaw==
X-Gm-Message-State: AOJu0Yzy02EsRl/Ohi9J6khfIasLbZUTOqWs/pfVkHa8YpS+P3hEoyvz
 63VmbFoV7xaYR5zuAMMiEn+gGuWnEo3xHsydC9qnzgbxplQ+GNnk4KGjn3HxG6ArNLQl+JNJYyd
 ch9CV+1t107GBFq1XCQt7hIDMIWsTRzwAPPj4iAln7tAyP0wbaW1ywf00MGjOOH6ciHvUP5lCfA
 hzgJW+Ayu4qNniDGhT8x3fCg7dp29kx4fXrk/j0qfx
X-Gm-Gg: ASbGncsD9uiX3ok56wGW1Mn87Z6mIAXPJHOrNrpODPuUTaynXNfBzI/qL5a3JekCkHW
 2mR/ke+gmsd0PdvLBvT2ibAvzyTCqA8thXNbnqdB427cRUoCVvbxxFiaRaCZELewO8NSyPTZIUp
 xM4vyhYbBMD/4x8jjfuCgqAyqIOlLurbbgFqk+JiyeIyhHT+Nvfdt5bXtXADjvYMUbfbtLNYzCR
 TPRAzHQFNATJGAnrB8+FclgSRlugFqk3mL77tv5uFUL6mYyvWEEJKaNlfw1boItEwRvlGbY6HRm
 171jIpFGNpfkaKz6c8fzmKG5X6LFbKTTJvah8QGELbc48RBNHLhaT2b+b4DMjkwTYN5X/RVFfkZ
 bXjvREwDZiRiEbbQBV8T++N2dnAJ+Jvw0q0Gi1EfPfRo=
X-Received: by 2002:a5d:64e1:0:b0:3b6:436:b8ea with SMTP id
 ffacd0b85a97d-3c5da83c601mr18910174f8f.6.1756472422264; 
 Fri, 29 Aug 2025 06:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM36Wo0fGXggWQDnWWH4VL8xKO3DiinY19cQeFX+2iWAhLjwKUpW9KtQTr1PyqqCRS29bqcg==
X-Received: by 2002:a5d:64e1:0:b0:3b6:436:b8ea with SMTP id
 ffacd0b85a97d-3c5da83c601mr18910133f8f.6.1756472421523; 
 Fri, 29 Aug 2025 06:00:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d643dsm3363125f8f.26.2025.08.29.06.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Bernhard Beschow <shentey@gmail.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 16/28] hw/i386: move isapc machine to separate isapc.c file
Date: Fri, 29 Aug 2025 14:59:23 +0200
Message-ID: <20250829125935.1526984-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Now that pc_init_isa() is independent of any PCI initialisation, move it into a
separate isapc.c file including the ISA IDE variables which are now no longer
needed for the pc-i440fx machine. This enables us to finally fix the dependency
of ISAPC on I440FX in hw/i386/Kconfig.

Note that as part of the move to a separate file we can see that the licence text
is a verbatim copy of the MIT licence. The text originates from commit 1df912cf9e
("VL license of the day is MIT/BSD") so we can be sure that this was the original
intent. As a consequence we can update the file header to use a SPDX tag as per
the current project contribution guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-17-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/isapc.c     | 190 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c   | 172 ---------------------------------------
 hw/i386/Kconfig     |   3 -
 hw/i386/meson.build |   1 +
 4 files changed, 191 insertions(+), 175 deletions(-)
 create mode 100644 hw/i386/isapc.c

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
new file mode 100644
index 00000000000..300d64b7ad2
--- /dev/null
+++ b/hw/i386/isapc.c
@@ -0,0 +1,190 @@
+/*
+ * QEMU PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/dma/i8257.h"
+#include "hw/i386/pc.h"
+#include "hw/ide/isa.h"
+#include "hw/ide/ide-bus.h"
+#include "system/kvm.h"
+#include "hw/i386/kvm/clock.h"
+#include "hw/xen/xen-x86.h"
+#include "system/xen.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "target/i386/cpu.h"
+
+static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
+static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
+static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+
+
+static void pc_init_isa(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    ISABus *isa_bus;
+    uint32_t irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
+
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
+    /*
+     * Similarly if someone unintentionally passes "-cpu host" for the isapc
+     * machine then display a warning and also switch to the "best" 32-bit
+     * cpu possible which we consider to be the pentium3. This is because any
+     * host CPU will already be modern than this, but it also ensures any
+     * newer CPU flags/features are filtered out for older guests.
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu host is invalid for isapc machine, using pentium3");
+    }
+
+    if (machine->ram_size > 3.5 * GiB) {
+        error_report("Too much memory for this machine: %" PRId64 " MiB, "
+                     "maximum 3584 MiB", machine->ram_size / MiB);
+        exit(1);
+    }
+
+    /*
+     * There is no RAM split for the isapc machine
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+
+        pcms->max_ram_below_4g = 3.5 * GiB;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
+    }
+
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
+
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                          &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                   &error_fatal);
+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, NULL);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+    }
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        X86_CPU_TYPE_NAME("host"),
+        NULL
+    };
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    pcmc->pci_enabled = false;
+    pcmc->has_acpi_build = false;
+    pcmc->smbios_defaults = false;
+    pcmc->gigabyte_align = false;
+    pcmc->smbios_legacy_mode = true;
+    pcmc->has_reserved_memory = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3ea77b2c44f..988c9edc32c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,12 +71,6 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_IDE_ISA
-static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
-static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
-static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
-#endif
-
 static GlobalProperty pc_piix_compat_defaults[] = {
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
     { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
@@ -392,134 +386,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(machine);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *system_io = get_system_io();
-    ISABus *isa_bus;
-    uint32_t irq;
-    GSIState *gsi_state;
-    MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    int i;
-
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
-
-    /*
-     * Similarly if someone unintentionally passes "-cpu host" for the isapc
-     * machine then display a warning and also switch to the "best" 32-bit
-     * cpu possible which we consider to be the pentium3. This is because any
-     * host CPU will already be modern than this, but it also ensures any
-     * newer CPU flags/features are filtered out for older guests.
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu host is invalid for isapc machine, using pentium3");
-    }
-
-    if (machine->ram_size > 3.5 * GiB) {
-        error_report("Too much memory for this machine: %" PRId64 " MiB, "
-                     "maximum 3584 MiB", machine->ram_size / MiB);
-        exit(1);
-    }
-
-    /*
-     * There is no RAM split for the isapc machine
-     */
-    if (xen_enabled()) {
-        xen_hvm_init_pc(pcms, &ram_memory);
-    } else {
-        ram_memory = machine->ram;
-
-        pcms->max_ram_below_4g = 3.5 * GiB;
-        x86ms->above_4g_mem_size = 0;
-        x86ms->below_4g_mem_size = machine->ram_size;
-    }
-
-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
-
-    if (kvm_enabled()) {
-        kvmclock_create(pcmc->kvmclock_create_always);
-    }
-
-    /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
-    } else {
-        assert(machine->ram_size == x86ms->below_4g_mem_size +
-                                    x86ms->above_4g_mem_size);
-
-        if (machine->kernel_filename != NULL) {
-            /* For xen HVM direct kernel boot, load linux here */
-            xen_load_linux(pcms);
-        }
-    }
-
-    gsi_state = pc_gsi_create(&x86ms->gsi, false);
-
-    isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                          &error_abort);
-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
-
-    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-    irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                   &error_fatal);
-    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
-
-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
-    pcms->hpet_enabled = false;
-
-    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-    }
-
-    if (tcg_enabled()) {
-        x86_register_ferr_irq(x86ms->gsi[13]);
-    }
-
-    pc_vga_init(isa_bus, NULL);
-
-    /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
-
-    pc_nic_init(pcmc, isa_bus, NULL);
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++) {
-        ISADevice *dev;
-        char busname[] = "ide.0";
-        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                            ide_irq[i],
-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-        /*
-         * The ide bus name is ide.0 for the first bus and ide.1 for the
-         * second one.
-         */
-        busname[4] = '0' + i;
-        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-    }
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init(MachineState *machine)
 {
@@ -887,44 +753,6 @@ static void pc_i440fx_machine_2_6_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 6);
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        X86_CPU_TYPE_NAME("host"),
-        NULL
-    };
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    pcmc->pci_enabled = false;
-    pcmc->has_acpi_build = false;
-    pcmc->smbios_defaults = false;
-    pcmc->gigabyte_align = false;
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
-    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 3a0e2b8ebbb..6a0ab54bea4 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -96,9 +96,6 @@ config ISAPC
     select ISA_BUS
     select PC
     select IDE_ISA
-    # FIXME: it is in the same file as i440fx, and does not compile
-    # if separated
-    depends on I440FX
 
 config Q35
     bool
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7896f348cff..436b3ce52d6 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -14,6 +14,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('isapc.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('x86-common.c', 'microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclave.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
-- 
2.51.0


