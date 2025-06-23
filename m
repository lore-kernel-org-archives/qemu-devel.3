Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D521C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTem6-0008Ui-AK; Mon, 23 Jun 2025 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uTem2-0008Tk-Vn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:51:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uTem0-00042Y-JI
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:51:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cf214200so36603795e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750675894; x=1751280694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=5ahn6KxuhzNbH7W57ddxj+ZI/wDtqKOvq9Xu7XEMI7Q=;
 b=lXjPuRC4vKl7JqVn9JBW5OjeTqoQPk4UKJT1Nkff0CYtZiZCKMQqydnaGDj6O7WaxQ
 xIedxEnUEbcawGytcgduUlk4/+Y7mtHhh25lVj3OaaeEZWDrwykp7FqCffxfytKwGszD
 khTY/j9PHhAYhSji/NwOqhvTH4KABwX9MQJaKtQ6ArSWEM86AlmokejjIaiVxOhiXG8m
 J6lBszjMolMaR+TVQQxGa5PyZokXVlBKhjv42QrDRCDVRZtGy+KTVMDs5tByM5eVqHiD
 uxxFa56RPPY9TWNsoS9nUWo7zWG/TXAJiQmFLI8v6ila6YnAnDyuY84oRIRwEc5RakTT
 0eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750675894; x=1751280694;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ahn6KxuhzNbH7W57ddxj+ZI/wDtqKOvq9Xu7XEMI7Q=;
 b=Ba5P8LdKLe55alNtzUA31aZmHlsBYBCqHcFCWSy9k1zeBAJRKny+fy4Mgo/L4MFb/6
 4eDn3rwnr4Zv/ByWg4I48vZUaLUoYCZFWWDm+mTzT8vu7RrO3P01/l5oWqd1E6CWmnrY
 PAAit+JjoYGgufyCpvTh3gPpXU1sOui3RVESH8FfKIb0apKlj3g/nHAt2n9MOgDHDRok
 zLOtE46eQa2c0IxMFYlZembQlgORu60CqIj15Kks1ZI/MnnIEnKc5+8mxzCCfptPmJbB
 AIEr49KBZpUdJ0TxTWIrOU5cPXY/yqx7uD6PTO+iT2IsTZ8QEQ4oJdlG8Yup2TiaLLs1
 cLMQ==
X-Gm-Message-State: AOJu0YxIERXBLRVNOuS8gCKPLJw+rp1/PgUwRz6u/FDdPGHu/jRBXXvd
 dXTXzyLKDQs3WS5PXMVLufiN7kr13IMk4NeaYz97orP/0hc4KW952XKfQoUxlQ==
X-Gm-Gg: ASbGncudtnj+2MYwrvpBlR7NaUNC02xObJIjZHsj1h2xwvwvxD3Ia7R6vsS+JCxjD80
 v1esKHj56/LrquCqB5Jqc8/xl4A3g+tPPItIyBwOg3SV5y9jxnzBd59dXI9Jcnxkiner8anNqiA
 nSjCILX7LwIRBH69Q5hdM1QOE4nC9UifDdEQk+Bk77CIs2W+J5Ib+2oFJcu9WjTfGW2XMqY0CZq
 okqr+1cehwcOR47M4bdu/TiSYyGaM3LkQ8Dfaf1gY6Bo17dxolsebx4O3gkylR11RKJ1OzTYhmd
 6P97iRw1TRh3vuixjQGCHOi+XnU8UOjkBn3ziuptNO1unui5ts1oa0U6
X-Google-Smtp-Source: AGHT+IGUPc0/dLmbmK924hDoHLRcMUrGjOV0zbGBiC+IlFMfKzscTF8UyKvPXHBkB0+DSRwyHnS/1g==
X-Received: by 2002:a05:600c:458b:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-453659ef74bmr107289565e9.22.1750675893748; 
 Mon, 23 Jun 2025 03:51:33 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647f29bdsm106115645e9.18.2025.06.23.03.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 03:51:33 -0700 (PDT)
Date: Mon, 23 Jun 2025 10:47:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_12/12=5D_hw/i386=3A_move_i?=
 =?US-ASCII?Q?sapc_machine_to_separate_isapc=2Ec_file?=
In-Reply-To: <20250618112828.235087-13-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-13-mark.caveayland@nutanix.com>
Message-ID: <CDD9CE03-5254-476B-BB37-8BA19F003500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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



Am 18=2E Juni 2025 11:27:17 UTC schrieb Mark Cave-Ayland <mark=2Ecaveaylan=
d@nutanix=2Ecom>:
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
> hw/i386/isapc=2Ec     | 145 ++++++++++++++++++++++++++++++++++++++++++++
> hw/i386/meson=2Ebuild |   1 +
> hw/i386/pc_piix=2Ec   | 117 -----------------------------------
> 4 files changed, 146 insertions(+), 120 deletions(-)
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
>=20
> config Q35
>     bool
>diff --git a/hw/i386/isapc=2Ec b/hw/i386/isapc=2Ec
>new file mode 100644
>index 0000000000=2E=2E74ffd19307
>--- /dev/null
>+++ b/hw/i386/isapc=2Ec
>@@ -0,0 +1,145 @@
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
>+#include "hw/i386/pc=2Eh"
>+#include "hw/ide/isa=2Eh"
>+#include "hw/ide/ide-bus=2Eh"
>+#include "system/kvm=2Eh"
>+#include "hw/i386/kvm/clock=2Eh"
>+#include "hw/xen/xen-x86=2Eh"
>+#include "system/xen=2Eh"

I believe that Xen can be pruned from the machine as well since it require=
s PCI AFAIR=2E

Best regards,
Bernhard

>+#include "hw/rtc/mc146818rtc=2Eh"
>+#include "target/i386/cpu=2Eh"
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
>index f9d7967dee=2E=2E8cfb228f13 100644
>--- a/hw/i386/pc_piix=2Ec
>+++ b/hw/i386/pc_piix=2Ec
>@@ -415,99 +415,6 @@ static void pc_set_south_bridge(Object *obj, int val=
ue, Error **errp)
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
>@@ -869,30 +776,6 @@ static void pc_i440fx_machine_2_6_options(MachineCla=
ss *m)
>=20
> DEFINE_I440FX_MACHINE(2, 6);
>=20
>-#ifdef CONFIG_ISAPC
>-static void isapc_machine_options(MachineClass *m)
>-{
>-    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
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

