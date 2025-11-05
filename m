Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7395BCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGic8-0004OB-CN; Wed, 05 Nov 2025 13:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib7-0003zl-Cs
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib4-0003Cq-8K
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:09 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429b9b6ce96so134723f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 10:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762368664; x=1762973464;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7e8NP/uqAfJjsNCi3DwACx2SSTripBKZFs+t6givG5Y=;
 b=gQVFsTr+WS7O+r7g3LcIWfbUiaT2v4nAHaR7gjp4s40GB8GY/WtUyHRehwuQVFdzq8
 bJLp4AQ/uEqvz+zs9p2E5DQFvLkXmKDbp5kooZF9ehVFNEsXfVxyDd0oufWvcIc4RyiW
 FE7vmwp1WrFHQV1YdCnaWP6N497pi83CSbIevcb0XGg4T+cTo+8tN6Kwk8vWcQCaGysD
 g8S+1PiTbzmGKgtokTs+nRNvCpChYH7fa+jzW8W2aRAOtkWCtTwXgjm/eIeWMxKrcLy1
 wTvFNMyWPh50HsSIq/kYHXRI/W70vZtCdH22AU+quX1PVCDk9VX0gLEeooi+KDgt9Kuw
 jT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762368664; x=1762973464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7e8NP/uqAfJjsNCi3DwACx2SSTripBKZFs+t6givG5Y=;
 b=WXCZ12yUS488HdZVIjuoUN/2Q0uiKiA3NwnUF5ucU2ipslbDstHsOxJRPigLj6cym1
 telKfnrxcDUHXIzRBOqZbQLeL7kiNLd4OVgoa7d04esTZIc5o3ADpCg3XD/ZwS0uy35p
 8vEyx6cNB3t9MeBurDoi2k+heGiJ708zdoBOJctIp0EWFq5m70+f+p9KjpxQaOcacaOF
 uiMm4PVTpkbPtCDkb7lAUw4aCkGWtY2JA31qQZ7LcF6hSf9r2UN93BGoyGRc8sXZDkHp
 3ZOmI4CJG3UEtBI9qCVTTwo3zckPrcktF8pJJbNVSMINBn53h8y+fDCo+ppCy9A6g+Wm
 0Ppg==
X-Gm-Message-State: AOJu0YwxF3cHG8Vx4vONLlmivNsWGhfpH49BpOxt9KvxfULFsTndQbqU
 RM0jDmTkJScbk4p3BJ56v6C6jNAMstnV0TllZE59nIJ/+xb6U171ZlQJdbK5CojCHf/6+3x4fE8
 6qZRiun0=
X-Gm-Gg: ASbGncvCNwHMIUEU5/vy20EfYBpxm5sNVhDym344CXz3mfTB3JBXZu61EIPTY2bTxy3
 XsvkPK0odRQQEO9ONeWKULrVsmwDhHjICjeZSWWXETy36Dw7UZiR1XvV9lEGHCT5U5F9b/R1TTF
 yoUwfz1oNqjR4mLlgxkDIh/0yiKPlUF40YzMTGkSYrLuG5+CMDppxQHCVNzje1O+ldcYqce5XH5
 8ccE/GvAv5/qxhrZYQQ6HYFwaWLIk4VzktgrsWA3Hh2ic0NkH3leh8FawItgBxQveKu5Ag+L7dI
 aFL1wGeyECLEITlahYeyOO03U0b6KTswuWGe7HtzA/QDwOtMYIeOSnPTGG4wkSJCAyXdq88rh2k
 kh4wgDhTklvLUdcpy008FIoqAO4FXvB3V4Jz8xuJQiDsP04t5gm8g+GhTAtJxGGdebimDou6nOy
 dccW8H8c1yd092IqQ=
X-Google-Smtp-Source: AGHT+IFWhBX68YLa8DbzevrzJeAhb19pPzjdjMlkMLpb/wHKLP+ULyN5G+836YjNjYuKbg6wPX67tg==
X-Received: by 2002:a5d:584b:0:b0:426:d5a0:bac8 with SMTP id
 ffacd0b85a97d-429e331283emr4406175f8f.56.1762368664056; 
 Wed, 05 Nov 2025 10:51:04 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb42a354sm270622f8f.20.2025.11.05.10.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 10:51:03 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v3 5/5] hw/riscv: introduce 'neorv32' board, docs,
 and riscv32 device config
Date: Wed,  5 Nov 2025 20:50:56 +0200
Message-ID: <20251105185056.23565-6-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105185056.23565-1-michael@videogpu.com>
References: <20251105185056.23565-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::42a;
 envelope-from=michael@videogpu.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

From: Michael <michael@videogpu.com>

Introduce the 'neorv32' board wiring IMEM/DMEM/BOOTROM, SYSINFO, UART0, and SPI0;
add docs/system/riscv/neorv32.rst and riscv32-softmmu device config entry.

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 configs/devices/riscv32-softmmu/default.mak |   1 +
 docs/system/riscv/neorv32.rst               | 110 ++++++++++
 hw/riscv/Kconfig                            |   8 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/neorv32.c                          | 215 ++++++++++++++++++++
 include/hw/riscv/neorv32.h                  |  54 +++++
 6 files changed, 389 insertions(+)
 create mode 100644 docs/system/riscv/neorv32.rst
 create mode 100644 hw/riscv/neorv32.c
 create mode 100644 include/hw/riscv/neorv32.h

diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/devices/riscv32-softmmu/default.mak
index c2cd86ce05..4fdc94ab48 100644
--- a/configs/devices/riscv32-softmmu/default.mak
+++ b/configs/devices/riscv32-softmmu/default.mak
@@ -10,3 +10,4 @@
 # CONFIG_SIFIVE_U=n
 # CONFIG_RISCV_VIRT=n
 # CONFIG_OPENTITAN=n
+# CONFIG_NEORV32=n
diff --git a/docs/system/riscv/neorv32.rst b/docs/system/riscv/neorv32.rst
new file mode 100644
index 0000000000..7f9048a7ad
--- /dev/null
+++ b/docs/system/riscv/neorv32.rst
@@ -0,0 +1,110 @@
+
+NEORV32 Soft SoC (``neorv32``)
+==============================
+
+The ``neorv32`` machine models a minimal NEORV32-based SoC sufficient to
+exercise the stock NEORV32 bootloader and run example applications from an
+emulated SPI NOR flash. It exposes a UART for console I/O and an MTD-backed
+SPI flash device that can be populated with user binaries.
+
+Neorv32 full repo:
+https://github.com/stnolting/neorv32
+
+Current QEMU implementation base on commit 7d0ef6b2 in Neorv32 repo.
+
+Supported devices
+-----------------
+
+The ``neorv32`` machine provides the core peripherals needed by the
+bootloader and examples:
+
+* UART for console (mapped to the QEMU stdio when ``-nographic`` or
+  ``-serial stdio`` is used).
+* SPI controller connected to an emulated SPI NOR flash (exposed to the
+  guest via QEMU's ``if=mtd`` backend).
+* Basic timer/CLINT-like facilities required by the example software.
+
+(Exact register maps and optional peripherals depend on the QEMU version and
+the specific patch series you are using.)
+
+
+QEMU build configuration:
+------------------------
+/path/to/qemu/configure \
+  --python=/usr/local/bin/python3.12 \
+  --target-list=riscv32-softmmu \
+  --enable-fdt \
+  --enable-debug \
+  --disable-vnc \
+  --disable-gtk
+
+Boot options
+------------
+
+Typical usage is to boot the NEORV32 bootloader as the QEMU ``-bios`` image,
+and to provide a raw SPI flash image via an MTD drive. The bootloader will
+then jump to the application image placed at the configured flash offset.
+
+Preparing the SPI flash with a “Hello World” example
+----------------------------------------------------
+
+1. Create a 64 MiB flash image (filled with zeros)::
+
+   $ dd if=/dev/zero of=$HOME/flash_contents.bin bs=1 count=$((0x04000000))
+
+2. Place your application binary at the **4 MiB** offset inside the flash.
+   Replace ``/path/to/neorv32_exe.bin`` with the path to your compiled
+   example application (e.g., the NEORV32 ``hello_world`` example)::
+
+   $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin \
+        bs=1 seek=$((0x00400000)) conv=notrunc
+
+Running the “Hello World” example
+---------------------------------
+
+Run QEMU with the NEORV32 bootloader as ``-bios`` and attach the prepared
+flash image via the MTD interface. Replace the placeholder paths with your
+local paths::
+
+  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
+      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
+      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw
+
+Notes:
+
+* ``-nographic`` routes the UART to your terminal (Ctrl-A X to quit when
+  using the QEMU monitor hotkeys; or just close the terminal).
+* The bootloader starts first and will transfer control to your application
+  located at the 4 MiB offset of the flash image.
+* If you prefer, you can use ``-serial stdio`` instead of ``-nographic``.
+
+Machine-specific options
+------------------------
+
+Unless otherwise noted by the patch series, there are no special board
+options beyond the standard QEMU options shown above. Commonly useful
+generic options include:
+
+* ``-s -S`` to open a GDB stub on TCP port 1234 and start paused, so you can
+  debug both QEMU and the guest.
+* ``-d guest_errors,unimp`` (or other trace flags) for additional logging.
+
+Example: debugging with GDB::
+
+  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
+      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
+      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw \
+      -s -S
+
+  # In another shell:
+  $ riscv32-unknown-elf-gdb /path/to/neorv32/bootloader/main.elf
+  (gdb) target remote :1234
+
+
+Known limitations
+-----------------
+
+This is a functional model intended for software bring-up and testing of
+example programs. It may not model all timing details or every optional
+peripheral available in a specific NEORV32 SoC configuration.
+
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..976acd2a1b 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -128,3 +128,11 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
+
+config NEORV32
+    bool
+    default y
+    depends on RISCV32
+    select NEORV32_UART
+    select NEORV32_SPI
+    select NEORV32_SYSINFO_QEMU
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..b8788e2035 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
+riscv_ss.add(when: 'CONFIG_NEORV32', if_true: files('neorv32.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/neorv32.c b/hw/riscv/neorv32.c
new file mode 100644
index 0000000000..41494d2893
--- /dev/null
+++ b/hw/riscv/neorv32.c
@@ -0,0 +1,215 @@
+/*
+ * QEMU RISC-V Board Compatible with Neorv32 IP
+ *
+ * Provides a board compatible with the Neorv32 IP:
+ *
+ * 0) SYSINFO
+ * 1) IMEM
+ * 2) DMEM
+ * 3) UART
+ * 4) SPI
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/misc/unimp.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/boot.h"
+#include "hw/intc/riscv_aclint.h"
+#include "chardev/char.h"
+#include "system/system.h"
+#include "hw/ssi/ssi.h"    /* For ssi_realize_and_unref() */
+
+#include "hw/riscv/neorv32.h"
+#include "hw/misc/neorv32_sysinfo.h"
+#include "hw/char/neorv32_uart.h"
+#include "hw/ssi/neorv32_spi.h"
+
+/* TODO: get BOOTLOADER_ROM, IMEM, DMEM sizes from rtl auto-generated header */
+static const MemMapEntry neorv32_memmap[] = {
+
+    [NEORV32_IMEM]           = { NEORV32_IMEM_BASE,    SYSINFO_IMEM_SIZE},
+    [NEORV32_BOOTLOADER_ROM] = { NEORV32_BOOTLOADER_BASE_ADDRESS, 0x2000},
+    [NEORV32_DMEM]           = { NEORV32_DMEM_BASE,    SYSINFO_DMEM_SIZE},
+    [NEORV32_SYSINFO]        = { NEORV32_SYSINFO_BASE, 0x100},
+    [NEORV32_UART0]          = { NEORV32_UART0_BASE,   0x100},
+    [NEORV32_SPI0]           = { NEORV32_SPI_BASE,     0x100},
+};
+
+static void neorv32_machine_init(MachineState *machine)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const MemMapEntry *memmap = neorv32_memmap;
+
+    Neorv32State *s = NEORV32_MACHINE(machine);
+    MemoryRegion *sys_mem = get_system_memory();
+    int i;
+    RISCVBootInfo boot_info;
+    hwaddr start_addr = memmap[NEORV32_BOOTLOADER_ROM].base;
+
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_NEORV32_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    /* Data Tightly Integrated Memory */
+    memory_region_add_subregion(sys_mem,
+        memmap[NEORV32_DMEM].base, machine->ram);
+
+    /* Instruction Memory (IMEM) */
+    memory_region_init_ram(&s->soc.imem_region, OBJECT(&s->soc),
+                           "riscv.neorv32.imem",
+                           memmap[NEORV32_IMEM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[NEORV32_IMEM].base,
+                                &s->soc.imem_region);
+
+    /* Mask ROM reset vector */
+    uint32_t reset_vec[4];
+
+    reset_vec[1] = 0x204002b7;  /* 0x1004: lui     t0,0x20400 */
+    reset_vec[2] = 0x00028067;      /* 0x1008: jr      t0 */
+    reset_vec[0] = reset_vec[3] = 0;
+
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+
+    /* Neorv32 bootloader */
+    if (machine->firmware) {
+        riscv_find_and_load_firmware(machine, machine->firmware,
+                                     &start_addr, NULL);
+    }
+
+    /* Neorv32 example applications */
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+    if (machine->kernel_filename) {
+        riscv_load_kernel(machine, &boot_info,
+                          memmap[NEORV32_IMEM].base,
+                          false, NULL);
+    }
+}
+
+static void neorv32_machine_instance_init(Object *obj)
+{
+
+    /* Placeholder for now */
+    /* Neorv32State *s = NEORV32_MACHINE(obj); */
+}
+
+static void neorv32_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V SOC compatible with Neorv32 SDK";
+    mc->init = neorv32_machine_init;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = NEORV32_CPU;
+    mc->default_ram_id = "riscv.neorv32.dmem";
+    mc->default_ram_size = neorv32_memmap[NEORV32_DMEM].size;
+
+}
+
+static const TypeInfo neorv32_machine_typeinfo = {
+    .name          = MACHINE_TYPE_NAME("neorv32"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = neorv32_machine_class_init,
+    .instance_init = neorv32_machine_instance_init,
+    .instance_size = sizeof(Neorv32State),
+};
+
+static void neorv32_machine_init_register_types(void)
+{
+    type_register_static(&neorv32_machine_typeinfo);
+}
+
+type_init(neorv32_machine_init_register_types)
+
+static void neorv32_soc_init(Object *obj)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    Neorv32SoCState *s = RISCV_NEORV32_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
+                            &error_abort);
+
+    object_property_set_int(OBJECT(&s->cpus), "resetvec",
+                            NEORV32_BOOTLOADER_BASE_ADDRESS, &error_abort);
+
+}
+
+static void neorv32_soc_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const MemMapEntry *memmap = neorv32_memmap;
+    Neorv32SoCState *s = RISCV_NEORV32_SOC(dev);
+    MemoryRegion *sys_mem = get_system_memory();
+
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
+                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+
+    /* Bootloader ROM */
+    memory_region_init_rom(&s->bootloader_rom, OBJECT(dev),
+                           "riscv.bootloader.rom",
+                           memmap[NEORV32_BOOTLOADER_ROM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem,
+        memmap[NEORV32_BOOTLOADER_ROM].base, &s->bootloader_rom);
+
+
+    /* Sysinfo ROM */
+    neorv32_sysinfo_create(sys_mem, memmap[NEORV32_SYSINFO].base);
+
+    /* Uart0 */
+    neorv32_uart_create(sys_mem, memmap[NEORV32_UART0].base, serial_hd(0));
+
+    /* SPI controller */
+    NEORV32SPIState *spi = neorv32_spi_create(sys_mem,
+                                              memmap[NEORV32_SPI0].base);
+
+    if (!spi) {
+        error_setg(errp, "SPI is not created");
+        return;
+    }
+}
+
+static void neorv32_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    dc->realize = neorv32_soc_realize;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo neorv32_soc_type_info = {
+    .name = TYPE_RISCV_NEORV32_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(Neorv32SoCState),
+    .instance_init = neorv32_soc_init,
+    .class_init = neorv32_soc_class_init,
+};
+
+static void neorv32_soc_register_types(void)
+{
+    type_register_static(&neorv32_soc_type_info);
+}
+
+type_init(neorv32_soc_register_types)
diff --git a/include/hw/riscv/neorv32.h b/include/hw/riscv/neorv32.h
new file mode 100644
index 0000000000..bc90c2bc04
--- /dev/null
+++ b/include/hw/riscv/neorv32.h
@@ -0,0 +1,54 @@
+/*
+ * NEORV32 SOC presentation in QEMU
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NEORV32_H
+#define HW_NEORV32_H
+
+#include "hw/riscv/riscv_hart.h"
+#include "hw/boards.h"
+
+#if defined(TARGET_RISCV32)
+#define NEORV32_CPU TYPE_RISCV_CPU_NEORV32
+#endif
+
+#define TYPE_RISCV_NEORV32_SOC "riscv.neorv32.soc"
+#define RISCV_NEORV32_SOC(obj) \
+    OBJECT_CHECK(Neorv32SoCState, (obj), TYPE_RISCV_NEORV32_SOC)
+
+typedef struct Neorv32SoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState cpus;
+    DeviceState *plic;
+    MemoryRegion imem_region;
+    MemoryRegion bootloader_rom;
+} Neorv32SoCState;
+
+typedef struct Neorv32State {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    Neorv32SoCState soc;
+} Neorv32State;
+
+#define TYPE_NEORV32_MACHINE MACHINE_TYPE_NAME("neorv32")
+#define NEORV32_MACHINE(obj) \
+    OBJECT_CHECK(Neorv32State, (obj), TYPE_NEORV32_MACHINE)
+
+enum {
+    NEORV32_IMEM,
+    NEORV32_BOOTLOADER_ROM,
+    NEORV32_DMEM,
+    NEORV32_SYSINFO,
+    NEORV32_UART0,
+    NEORV32_SPI0,
+};
+
+#endif /* HW_NEORV32_H */
-- 
2.51.1


