Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FBC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAH-0002ac-NQ; Tue, 08 Jul 2025 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uZDRN-00007t-72
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:53:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uZDQi-0007zk-9B
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:53:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so3609221f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752000733; x=1752605533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=cfUsbJYY1gZ5udUqOW0PuCn4HG7ETHlSxXsrDm3r0QY=;
 b=jITz9BP6XRYLPZXsB3jh9okf8HQ98dIOMCfB05vYkEnDvucfIXj2X6VBUjmfbUbfiP
 2eGhyCdeMbB2YWUDlWizkIAqi4ahX6uXtOXPdjCguoylD9Pe3KDWhaugtbRu8mu+n2Bq
 f1sngNHAXNu3MQ//cp10P6SfDkeCIjfe3A5Yrbs8nBvml1wBKfpTZEnocRFD6vxiRkwP
 LZJf0Dut+Wgwemi1612OETZGggpcShx01DysaLwbVq/NAi/f6iPV7o/AzgEo20IaN781
 6VotBHUBOO7F4DnqT6NvIdfHElSKF/TLV84ufE0mdhStIbH1scjUeXHktfGPNQ7F/Rkj
 4yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752000733; x=1752605533;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfUsbJYY1gZ5udUqOW0PuCn4HG7ETHlSxXsrDm3r0QY=;
 b=Z4H86goHneMp5kDbtODz6GvZBUIQib8fKkBYrr6sXFw+uU+TsPGKoL/0Q6npqFFRJF
 fJq48rX8a1Nxy84M2INH04bwkE8y5mJ7ohAWZe6Vyh43Adcg7ph4cJPRBh2CjaQ9NrUp
 1HTmUyQ/HYfxg/PQuXATndHLBiL3zslAIrmA6GtGkGHAzqoFKPMKPqqHcDaN0J1vaUr8
 Of9N7IjhU/th7sE6kYE4n0yxLr9lsw5iH/75KhJ3yO90p48VIui0/K93xb73scr+jrRy
 Ky4G1nKi3GQfz3HfyByTd+59LVD5FP78k7x1k9UTxn6iXol8BBskfu8qM4VVYxGiGa8E
 iVFA==
X-Gm-Message-State: AOJu0Yw7tbTcupcomosAsvD+NPiXShhzYTGZ4U7lw4rpT+fDb8GuqsCG
 ZEJ736CSBONlWNLFUtV/LvEfdnW2C1MarouOaMISk0mghyVJJR2Kg4I2FeyKMw==
X-Gm-Gg: ASbGncukp85I+aNGM/HtiyJdtNCLzH7Ot+q4CjP8B9OzyFt5K8W090svrVkR5HraJQg
 ecdvNA7JD4tKAal5OM7YuuPG3eI8J0Khzufk3fPBmBb6d8eUMXy9OEfpOJvW0VFw7QkUXrgdvNr
 FggwLdsNgekbEPGse68L/wKNWprtr3AjGq33/DhaVLXjK7CYBmJq/ojtZgwEAPNbLvrhKjVmTU9
 qRUhLkMYk23tA5Zred7YTgAnmh7mUcrZC5bKG0mXzjMiVt3cWn/8mtHfW0aZQYxLRe25fcXs5xH
 45oqCD0tsN7npCjV8EF4UJk5TpoNZYuod2Qk1mSMINXCcm1TPqHxyvgnGavbtp455aScK7Q73lr
 UJeQyqXtevKtohv1b85hRKTQxFzq51/rm/KMFerP6mpt1gMX+w2OGFNnspch3flIIPfrFwg==
X-Google-Smtp-Source: AGHT+IHrTJOP2MpjMHFy6tZxhB7pXquIFztxbwe09Y7kFduAnB707YsaQGUywEglP4RgPWQsO8IZcg==
X-Received: by 2002:a17:906:6c8b:b0:ad8:a935:b908 with SMTP id
 a640c23a62f3a-ae3fe5994efmr1311332166b.30.1751999013376; 
 Tue, 08 Jul 2025 11:23:33 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-18f0-be00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b08568sm937656366b.139.2025.07.08.11.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 11:23:32 -0700 (PDT)
Date: Tue, 08 Jul 2025 17:36:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_14/14=5D_hw/i386=3A_move_i?=
 =?US-ASCII?Q?sapc_machine_to_separate_isapc=2Ec_file?=
In-Reply-To: <20250704141018.674268-15-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
 <20250704141018.674268-15-mark.caveayland@nutanix.com>
Message-ID: <7C9CE1C1-4B5A-4EF0-90DC-EF4FF9BECFAB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
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



Am 4=2E Juli 2025 14:09:41 UTC schrieb Mark Cave-Ayland <mark=2Ecaveayland=
@nutanix=2Ecom>:
>Now that pc_init_isa() is independent of any PCI initialisation, move it =
into a
>separate isapc=2Ec file=2E This enables us to finally fix the dependency =
of ISAPC on
>I440FX in hw/i386/Kconfig=2E
>
>Note that as part of the move to a separate file we can see that the lice=
nce text
>is a verbatim copy of the MIT licence=2E The text originates from commit =
1df912cf9e
>("VL license of the day is MIT/BSD") so we can be sure that this was the =
original
>intent=2E As a consequence we can update the file header to use a SPDX ta=
g as per
>the current project contribution guidelines=2E
>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecaveayland@nutanix=2Ecom>
>---
> hw/i386/Kconfig     |   3 -
> hw/i386/isapc=2Ec     | 169 ++++++++++++++++++++++++++++++++++++++++++++
> hw/i386/meson=2Ebuild |   1 +
> hw/i386/pc_piix=2Ec   | 148 --------------------------------------
> 4 files changed, 170 insertions(+), 151 deletions(-)
> create mode 100644 hw/i386/isapc=2Ec
>
>diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>index eb65bda6e0=2E=2Ea7c746fe9e 100644
>--- a/hw/i386/Kconfig
>+++ b/hw/i386/Kconfig
>@@ -96,9 +96,6 @@ config ISAPC
>     select ISA_BUS
>     select PC
>     select IDE_ISA
>-    # FIXME: it is in the same file as i440fx, and does not compile
>-    # if separated
>-    depends on I440FX

Yay!

>=20
> config Q35
>     bool
>diff --git a/hw/i386/isapc=2Ec b/hw/i386/isapc=2Ec
>new file mode 100644
>index 0000000000=2E=2E5ac077a860
>--- /dev/null
>+++ b/hw/i386/isapc=2Ec
>@@ -0,0 +1,169 @@
>+/*
>+ * QEMU PC System Emulator
>+ *
>+ * Copyright (c) 2003-2004 Fabrice Bellard
>+ *
>+ * SPDX-License-Identifier: MIT
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+
>+#include "hw/char/parallel-isa=2Eh"
>+#include "hw/dma/i8257=2Eh"
>+#include "hw/loader=2Eh"

Is loader=2Eh used here? It seems to be unneeded in pc_piix already, so no=
 need for copying it here=2E

>+#include "hw/i386/pc=2Eh"
>+#include "hw/ide/isa=2Eh"
>+#include "hw/ide/ide-bus=2Eh"
>+#include "system/kvm=2Eh"
>+#include "hw/i386/kvm/clock=2Eh"
>+#include "hw/xen/xen-x86=2Eh"
>+#include "system/xen=2Eh"
>+#include "hw/rtc/mc146818rtc=2Eh"
>+#include "target/i386/cpu=2Eh"

i8257=2Eh, mc146818rtc=2Eh, and probably ide/isa=2Eh can now be removed fr=
om pc_piix since these are either instantiated in the southbridge or not us=
ed there=2E

>+
>+static const int ide_iobase[MAX_IDE_BUS] =3D { 0x1f0, 0x170 };
>+static const int ide_iobase2[MAX_IDE_BUS] =3D { 0x3f6, 0x376 };
>+static const int ide_irq[MAX_IDE_BUS] =3D { 14, 15 };
>+
>+
>+static void pc_init_isa(MachineState *machine)
>+{
>+    PCMachineState *pcms =3D PC_MACHINE(machine);
>+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>+    X86MachineState *x86ms =3D X86_MACHINE(machine);
>+    MemoryRegion *system_memory =3D get_system_memory();
>+    MemoryRegion *system_io =3D get_system_io();
>+    ISABus *isa_bus;
>+    GSIState *gsi_state;
>+    MemoryRegion *ram_memory;
>+    MemoryRegion *rom_memory =3D system_memory;

rom_memory isn't needed any more since system_memory can be used directly=
=2E Same for pc_piix where pci_memory can be used directly (see pc_q35)=2E

>+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>+    uint32_t irq;
>+    int i;
>+
>+    /*
>+     * There is no RAM split for the isapc machine
>+     */
>+    if (xen_enabled()) {
>+        xen_hvm_init_pc(pcms, &ram_memory);
>+    } else {
>+        ram_memory =3D machine->ram;
>+
>+        pcms->max_ram_below_4g =3D 0xe0000000; /* default: 3=2E5G */
>+        x86ms->above_4g_mem_size =3D 0;
>+        x86ms->below_4g_mem_size =3D machine->ram_size;
>+    }
>+
>+    /*
>+     * There is a small chance that someone unintentionally passes "-cpu=
 max"
>+     * for the isapc machine, which will provide a much more modern 32-b=
it
>+     * CPU than would be expected for an ISA-era PC=2E If the "max" cpu =
type has
>+     * been specified, choose the "best" 32-bit cpu possible which we co=
nsider
>+     * be the pentium3 (deliberately choosing an Intel CPU given that th=
e
>+     * default 486 CPU for the isapc machine is also an Intel CPU)=2E
>+     */
>+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>+        machine->cpu_type =3D X86_CPU_TYPE_NAME("pentium3");
>+    }
>+
>+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>+
>+    if (kvm_enabled()) {
>+        kvmclock_create(pcmc->kvmclock_create_always);
>+    }
>+
>+    /* allocate ram and load rom/bios */
>+    if (!xen_enabled()) {
>+        pc_memory_init(pcms, system_memory, rom_memory, 0);
>+    } else {
>+        assert(machine->ram_size =3D=3D x86ms->below_4g_mem_size +
>+                                    x86ms->above_4g_mem_size);
>+
>+        if (machine->kernel_filename !=3D NULL) {
>+            /* For xen HVM direct kernel boot, load linux here */
>+            xen_load_linux(pcms);
>+        }
>+    }
>+
>+    gsi_state =3D pc_gsi_create(&x86ms->gsi, false);
>+
>+    isa_bus =3D isa_bus_new(NULL, system_memory, system_io,
>+                            &error_abort);
>+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>+
>+    x86ms->rtc =3D isa_new(TYPE_MC146818_RTC);
>+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>+    irq =3D object_property_get_uint(OBJECT(x86ms->rtc), "irq",
>+                                   &error_fatal);
>+    isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
>+
>+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
>+    pcms->hpet_enabled =3D false;
>+
>+    if (x86ms->pic =3D=3D ON_OFF_AUTO_ON || x86ms->pic =3D=3D ON_OFF_AUT=
O_AUTO) {
>+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>+    }
>+
>+    if (tcg_enabled()) {
>+        x86_register_ferr_irq(x86ms->gsi[13]);
>+    }
>+
>+    pc_vga_init(isa_bus, NULL);
>+
>+    /* init basic PC hardware */
>+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>+
>+    pc_nic_init(pcmc, isa_bus, NULL);
>+
>+    ide_drive_get(hd, ARRAY_SIZE(hd));
>+    for (i =3D 0; i < MAX_IDE_BUS; i++) {
>+        ISADevice *dev;
>+        char busname[] =3D "ide=2E0";
>+        dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>+                           ide_irq[i],
>+                           hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1=
]);
>+        /*
>+         * The ide bus name is ide=2E0 for the first bus and ide=2E1 for=
 the
>+         * second one=2E
>+         */
>+        busname[4] =3D '0' + i;
>+        pcms->idebus[i] =3D qdev_get_child_bus(DEVICE(dev), busname);
>+    }
>+}
>+
>+static void isapc_machine_options(MachineClass *m)
>+{
>+    static const char * const valid_cpu_types[] =3D {
>+        X86_CPU_TYPE_NAME("486"),
>+        X86_CPU_TYPE_NAME("athlon"),
>+        X86_CPU_TYPE_NAME("kvm32"),
>+        X86_CPU_TYPE_NAME("pentium"),
>+        X86_CPU_TYPE_NAME("pentium2"),
>+        X86_CPU_TYPE_NAME("pentium3"),
>+        X86_CPU_TYPE_NAME("qemu32"),
>+        X86_CPU_TYPE_NAME("max"),
>+        NULL
>+    };
>+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>+
>+    m->desc =3D "ISA-only PC";
>+    m->max_cpus =3D 1;
>+    m->option_rom_has_mr =3D true;
>+    m->rom_file_has_mr =3D false;
>+    pcmc->pci_enabled =3D false;
>+    pcmc->has_acpi_build =3D false;
>+    pcmc->smbios_defaults =3D false;
>+    pcmc->gigabyte_align =3D false;
>+    pcmc->smbios_legacy_mode =3D true;
>+    pcmc->has_reserved_memory =3D false;
>+    m->default_nic =3D "ne2k_isa";
>+    m->default_cpu_type =3D X86_CPU_TYPE_NAME("486");
>+    m->valid_cpu_types =3D valid_cpu_types;
>+    m->no_floppy =3D !module_object_class_by_name(TYPE_ISA_FDC);
>+    m->no_parallel =3D !module_object_class_by_name(TYPE_ISA_PARALLEL);
>+}
>+
>+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>+                  isapc_machine_options);
>diff --git a/hw/i386/meson=2Ebuild b/hw/i386/meson=2Ebuild
>index 7896f348cf=2E=2E436b3ce52d 100644
>--- a/hw/i386/meson=2Ebuild
>+++ b/hw/i386/meson=2Ebuild
>@@ -14,6 +14,7 @@ i386_ss=2Eadd(when: 'CONFIG_X86_IOMMU', if_true: files(=
'x86-iommu=2Ec'),
> i386_ss=2Eadd(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu=2Ec'),
>                                       if_false: files('amd_iommu-stub=2E=
c'))
> i386_ss=2Eadd(when: 'CONFIG_I440FX', if_true: files('pc_piix=2Ec'))
>+i386_ss=2Eadd(when: 'CONFIG_ISAPC', if_true: files('isapc=2Ec'))
> i386_ss=2Eadd(when: 'CONFIG_MICROVM', if_true: files('x86-common=2Ec', '=
microvm=2Ec', 'acpi-microvm=2Ec', 'microvm-dt=2Ec'))
> i386_ss=2Eadd(when: 'CONFIG_NITRO_ENCLAVE', if_true: files('nitro_enclav=
e=2Ec'))
> i386_ss=2Eadd(when: 'CONFIG_Q35', if_true: files('pc_q35=2Ec'))
>diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>index c9d8a1cdf7=2E=2E8d0dfd881d 100644
>--- a/hw/i386/pc_piix=2Ec
>+++ b/hw/i386/pc_piix=2Ec
>@@ -71,12 +71,6 @@
>=20
> #define XEN_IOAPIC_NUM_PIRQS 128ULL
>=20
>-#ifdef CONFIG_ISAPC
>-static const int ide_iobase[MAX_IDE_BUS] =3D { 0x1f0, 0x170 };
>-static const int ide_iobase2[MAX_IDE_BUS] =3D { 0x3f6, 0x376 };
>-static const int ide_irq[MAX_IDE_BUS] =3D { 14, 15 };
>-#endif
>-
> /*
>  * Return the global irq number corresponding to a given device irq
>  * pin=2E We could also use the bus number to have a more precise mappin=
g=2E
>@@ -373,111 +367,6 @@ static void pc_set_south_bridge(Object *obj, int va=
lue, Error **errp)
>     pcms->south_bridge =3D PCSouthBridgeOption_lookup=2Earray[value];
> }
>=20
>-#ifdef CONFIG_ISAPC
>-static void pc_init_isa(MachineState *machine)
>-{
>-    PCMachineState *pcms =3D PC_MACHINE(machine);
>-    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>-    X86MachineState *x86ms =3D X86_MACHINE(machine);
>-    MemoryRegion *system_memory =3D get_system_memory();
>-    MemoryRegion *system_io =3D get_system_io();
>-    ISABus *isa_bus;
>-    GSIState *gsi_state;
>-    MemoryRegion *ram_memory;
>-    MemoryRegion *rom_memory =3D system_memory;
>-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>-    int i;
>-
>-    /*
>-     * There is no RAM split for the isapc machine
>-     */
>-    if (xen_enabled()) {
>-        xen_hvm_init_pc(pcms, &ram_memory);
>-    } else {
>-        ram_memory =3D machine->ram;
>-
>-        pcms->max_ram_below_4g =3D 0xe0000000; /* default: 3=2E5G */
>-        x86ms->above_4g_mem_size =3D 0;
>-        x86ms->below_4g_mem_size =3D machine->ram_size;
>-    }
>-
>-    /*
>-     * There is a small chance that someone unintentionally passes "-cpu=
 max"
>-     * for the isapc machine, which will provide a much more modern 32-b=
it
>-     * CPU than would be expected for an ISA-era PC=2E If the "max" cpu =
type has
>-     * been specified, choose the "best" 32-bit cpu possible which we co=
nsider
>-     * be the pentium3 (deliberately choosing an Intel CPU given that th=
e
>-     * default 486 CPU for the isapc machine is also an Intel CPU)=2E
>-     */
>-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>-        machine->cpu_type =3D X86_CPU_TYPE_NAME("pentium3");
>-    }
>-
>-    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>-
>-    if (kvm_enabled()) {
>-        kvmclock_create(pcmc->kvmclock_create_always);
>-    }
>-
>-    /* allocate ram and load rom/bios */
>-    if (!xen_enabled()) {
>-        pc_memory_init(pcms, system_memory, rom_memory, 0);
>-    } else {
>-        assert(machine->ram_size =3D=3D x86ms->below_4g_mem_size +
>-                                    x86ms->above_4g_mem_size);
>-
>-        if (machine->kernel_filename !=3D NULL) {
>-            /* For xen HVM direct kernel boot, load linux here */
>-            xen_load_linux(pcms);
>-        }
>-    }
>-
>-    gsi_state =3D pc_gsi_create(&x86ms->gsi, false);
>-
>-    isa_bus =3D isa_bus_new(NULL, system_memory, system_io,
>-                            &error_abort);
>-    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
>-
>-    x86ms->rtc =3D isa_new(TYPE_MC146818_RTC);
>-    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>-    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
>-
>-    i8257_dma_init(OBJECT(machine), isa_bus, 0);
>-    pcms->hpet_enabled =3D false;
>-
>-    if (x86ms->pic =3D=3D ON_OFF_AUTO_ON || x86ms->pic =3D=3D ON_OFF_AUT=
O_AUTO) {
>-        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
>-    }
>-
>-    if (tcg_enabled()) {
>-        x86_register_ferr_irq(x86ms->gsi[13]);
>-    }
>-
>-    pc_vga_init(isa_bus, NULL);
>-
>-    /* init basic PC hardware */
>-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
>-                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
>-
>-    pc_nic_init(pcmc, isa_bus, NULL);
>-
>-    ide_drive_get(hd, ARRAY_SIZE(hd));
>-    for (i =3D 0; i < MAX_IDE_BUS; i++) {
>-        ISADevice *dev;
>-        char busname[] =3D "ide=2E0";
>-        dev =3D isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
>-                            ide_irq[i],
>-                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + =
1]);
>-        /*
>-         * The ide bus name is ide=2E0 for the first bus and ide=2E1 for=
 the
>-         * second one=2E
>-         */
>-        busname[4] =3D '0' + i;
>-        pcms->idebus[i] =3D qdev_get_child_bus(DEVICE(dev), busname);
>-    }
>-}
>-#endif
>-
> #ifdef CONFIG_XEN
> static void pc_xen_hvm_init_pci(MachineState *machine)
> {
>@@ -839,43 +728,6 @@ static void pc_i440fx_machine_2_6_options(MachineCla=
ss *m)
>=20
> DEFINE_I440FX_MACHINE(2, 6);
>=20
>-#ifdef CONFIG_ISAPC
>-static void isapc_machine_options(MachineClass *m)
>-{
>-    static const char * const valid_cpu_types[] =3D {
>-        X86_CPU_TYPE_NAME("486"),
>-        X86_CPU_TYPE_NAME("athlon"),
>-        X86_CPU_TYPE_NAME("kvm32"),
>-        X86_CPU_TYPE_NAME("pentium"),
>-        X86_CPU_TYPE_NAME("pentium2"),
>-        X86_CPU_TYPE_NAME("pentium3"),
>-        X86_CPU_TYPE_NAME("qemu32"),
>-        X86_CPU_TYPE_NAME("max"),
>-        NULL
>-    };
>-    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>-
>-    m->desc =3D "ISA-only PC";
>-    m->max_cpus =3D 1;
>-    m->option_rom_has_mr =3D true;
>-    m->rom_file_has_mr =3D false;
>-    pcmc->pci_enabled =3D false;
>-    pcmc->has_acpi_build =3D false;
>-    pcmc->smbios_defaults =3D false;
>-    pcmc->gigabyte_align =3D false;
>-    pcmc->smbios_legacy_mode =3D true;
>-    pcmc->has_reserved_memory =3D false;
>-    m->default_nic =3D "ne2k_isa";
>-    m->default_cpu_type =3D X86_CPU_TYPE_NAME("486");
>-    m->valid_cpu_types =3D valid_cpu_types;
>-    m->no_floppy =3D !module_object_class_by_name(TYPE_ISA_FDC);
>-    m->no_parallel =3D !module_object_class_by_name(TYPE_ISA_PARALLEL);
>-}
>-
>-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>-                  isapc_machine_options);
>-#endif
>-
> #ifdef CONFIG_XEN
> static void xenfv_machine_4_2_options(MachineClass *m)
> {

With above comments addressed:

Reviewed-by: Bernhard Beschow shentey@gmail=2Ecom>


