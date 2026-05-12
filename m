Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE09CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjhj-0004Rg-HE; Tue, 12 May 2026 05:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjhW-0004Pe-2z
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wMjhU-00016l-5g
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:46:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-83d5bbef760so1755961b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778579211; x=1779184011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/No9fktPmi4K24uACzlU+WQCPk8PaeGoxEtfXZykuS8=;
 b=IqljklCoEboltC0tgA2Q9VnearZSqt0xfK0SqtrO7r3D8S8gpgTFE/mwd+ysTrSd2R
 285mg3xNLKFzx+i3RQ3zT+UETEbIeGzzP8n2blhhFfJCCgzYBnsw+2ZpGoytPjn6RIM1
 tO2DM7I+H4UyDgpBtGxGlX77z3uC7Cx04gw7gLLtUIRkaxk4EN+y/zeARoKQSGEIIiNf
 HXh5TyclbZHxS22CKb90DFB6Wxx6TH7t529nGuMlENx4ea7kpWlUaFcmBx+K7zbefFEa
 pyCLg+SQbNd4NcZkbPFiiuDW1MHs83wgEtQ2dRXFA2BOcwTU/ba+91kPMN8Ov7641w+f
 KW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778579211; x=1779184011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/No9fktPmi4K24uACzlU+WQCPk8PaeGoxEtfXZykuS8=;
 b=RB75lsy1qNUyKdZ8GyepDVmRM4+3IMIgehq+yqLCr01SQsjUFJaE9ubDERfZL0klWh
 867U9g9URcyeIuy3H8KhoUU0Mi6W6B4yG3RGdUZmATmKeOIrEO1WrfydYXvt/M5oB8i3
 cMTWVJLoWYKv9jMR69extbDR1/5DPwSESpJAG+YwNB4wX3NFRzSN9ddiwb0D7piKbr8X
 01i+zRw/8iN34prRsZTZejE2O35ztZG81luxr8956SG6w2RJWXQPZTY1/QT6jKvpl0wG
 rtPnrx0NF3FXSHkBouIELUVIkMTwapInhwtYaFNKXJ28OCk7gbK+UuyIN9HlDNyB9nCM
 h7IA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JXrYgmus5QFMvzTJW7KTAEvWYzu0ODRm1qTl59Ci6Ip/NJiFa+y6YmyMERNbujKrQJETZZQNmEQq0@nongnu.org
X-Gm-Message-State: AOJu0YwjmB4+hzb+NgWmRgCg/cuLy2wpgb08JVbd8szk+vxJG59BrcSZ
 OC5/+E2cMNysMklutExB4jJceGJ+npyE7R9O/2ExbI7X3QJtE2Pq1hna
X-Gm-Gg: Acq92OFf3t5B0hN4M7fJhHKCceINDSHzgZLu2e4S1PKqk1QAYNdpIR/H0BtEo28r8VL
 sTra/SBqiB2Kd/ERR5AslUAfWcpfhpaYWbYJQJ0pUwRxcZt/4ttTyPHunoy5oVdNs6sV/bRZkwl
 UKN6oV5Ce/NdhPHMDa/2Grdz2OkHYsHtMmbDqmfe2Yoa7N7yat3cMf8Xt2ZSvHGDxQfV1KiAvQx
 Cxphc4gQA/M9szPBl6L2X322n2vFLEQ8FJlbGKjJCLka2OZLkmlZNipCsPhej//2SwXYPQQAGtp
 hkjJwV9o4yBbMnfbEi1x48KrJSk5YsY4zrDE3jF+EfgF58iYRHZL1DaBswSN7Ydg5Kqj8Xw0nOt
 GwNZhRDL1ODyAfaX6EG2fW1SHw8JPS3rQ1RTh+DCX5xOIY/46IzPAu+xRjgWf2+H/p8sRRz66Ty
 XrZW8bR6ZQ9JETkgWVtMLj/a3X8Y+dWZtK9HtAeDAqStkdFwDv6yK53JLxfJKhaZ26Ka+ibpFRK
 FdMBsfJZKLqGARGPtaJNuImKOuD23wcbA==
X-Received: by 2002:a05:6a00:4088:b0:838:af72:fb1f with SMTP id
 d2e1a72fcca58-83a5afe1f08mr30226095b3a.2.1778579210648; 
 Tue, 12 May 2026 02:46:50 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682aba01sm22960593b3a.55.2026.05.12.02.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:46:50 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH RFC 5/5] hw/riscv: Add Milk-V Duo board support
Date: Tue, 12 May 2026 09:46:13 +0000
Message-ID: <20260512094614.3464388-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260512094614.3464388-1-visitorckw@gmail.com>
References: <20260512094614.3464388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add support for the Milk-V Duo development board, which is powered by
the Sophgo CV1800B SoC.

The implementation includes:
- Board-level machine initialization with 64mb of default ram.
- Integration of the CV1800B SoC.
- Support for loading external FDT, kernel, and initrd images.
- Proper setup of the reset vector to match the CV1800B's boot flow.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                                 |  11 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/milkv_duo.c                        | 122 ++++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 hw/riscv/milkv_duo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index afa178c5cc..2e729098d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1780,6 +1780,17 @@ F: docs/system/riscv/xiangshan-kunminghu.rst
 F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
+Milk-V Duo
+M: Kuan-Wei Chiu <visitorckw@gmail.com>
+S: Maintained
+F: hw/riscv/cv1800b.c
+F: hw/riscv/milkv_duo.c
+F: include/hw/riscv/cv1800b.h
+F: hw/misc/cv1800b_clk.c
+F: include/hw/misc/cv1800b_clk.h
+F: hw/char/dw8250.c
+F: include/hw/char/dw8250.h
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index a8e4d0ab33..2ba91b14d4 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -13,3 +13,4 @@
 # CONFIG_SHAKTI_C=n
 # CONFIG_XIANGSHAN_KUNMINGHU=n
 # CONFIG_MIPS_BOSTON_AIA=n
+# CONFIG_MILKV_DUO=n
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5b68991edb..8615b1cc3e 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -146,3 +146,9 @@ config SOPHGO_CV1800B
     select SIFIVE_PLIC
     select SOPHGO_CV1800B_CLK
     select DW8250
+
+config MILKV_DUO
+    bool
+    depends on RISCV64
+    default y
+    select SOPHGO_CV1800B
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 04e25eeece..19a0bf8e5b 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -19,5 +19,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 
 riscv_ss.add(when: 'CONFIG_SOPHGO_CV1800B', if_true: files('cv1800b.c'))
+riscv_ss.add(when: 'CONFIG_MILKV_DUO', if_true: files('milkv_duo.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/milkv_duo.c b/hw/riscv/milkv_duo.c
new file mode 100644
index 0000000000..5e8d5ea009
--- /dev/null
+++ b/hw/riscv/milkv_duo.c
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Milk-V Duo board
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/riscv/cv1800b.h"
+#include "hw/riscv/boot.h"
+#include "target/riscv/cpu-qom.h"
+#include "system/system.h"
+#include "system/device_tree.h"
+#include "qemu/error-report.h"
+#include "hw/core/loader.h"
+#include <libfdt.h>
+
+struct MilkVDuoState {
+    MachineState parent_obj;
+    CV1800BSoCState soc;
+};
+
+#define TYPE_MILK_V_DUO MACHINE_TYPE_NAME("milkv-duo")
+OBJECT_DECLARE_SIMPLE_TYPE(MilkVDuoState, MILK_V_DUO)
+
+static void milkv_duo_init(MachineState *machine)
+{
+    MilkVDuoState *s = MILK_V_DUO(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    RISCVBootInfo boot_info;
+    hwaddr firmware_load_addr, firmware_end_addr;
+    hwaddr fdt_load_addr = 0;
+    int fdt_size = 0;
+    uint64_t kernel_entry = 0;
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_CV1800B_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    memory_region_add_subregion(system_memory,
+                                cv1800b_memmap[CV1800B_DEV_DRAM].base,
+                                machine->ram);
+
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
+    firmware_load_addr = cv1800b_memmap[CV1800B_DEV_DRAM].base;
+    firmware_end_addr = firmware_load_addr;
+    if (machine->firmware) {
+        firmware_end_addr = riscv_find_and_load_firmware(machine, machine->firmware,
+                                                         &firmware_load_addr, NULL);
+    }
+
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
+        if (!machine->fdt) {
+            error_report("Failed to load device tree");
+            exit(1);
+        }
+
+        if (machine->kernel_cmdline && *machine->kernel_cmdline) {
+            if (fdt_path_offset(machine->fdt, "/chosen") < 0) {
+                qemu_fdt_add_subnode(machine->fdt, "/chosen");
+            }
+            qemu_fdt_setprop_string(machine->fdt, "/chosen", "bootargs",
+                                    machine->kernel_cmdline);
+        }
+    }
+
+    if (machine->kernel_filename) {
+        hwaddr kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                                firmware_end_addr);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    }
+
+    if (machine->dtb) {
+        fdt_load_addr = riscv_compute_fdt_addr(cv1800b_memmap[CV1800B_DEV_DRAM].base,
+                                               machine->ram_size, machine, &boot_info);
+        rom_add_blob_fixed_as("fdt", machine->fdt, fdt_size, fdt_load_addr,
+                              &address_space_memory);
+    }
+
+    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
+                              firmware_load_addr,
+                              cv1800b_memmap[CV1800B_DEV_ROM].base,
+                              cv1800b_memmap[CV1800B_DEV_ROM].size,
+                              kernel_entry,
+                              fdt_load_addr);
+}
+
+static void milkv_duo_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    static const char *const valid_cpu_types[] = {
+        TYPE_RISCV_CPU_THEAD_C906,
+        NULL
+    };
+
+    mc->desc = "Milk-V Duo Board (CV1800B)";
+    mc->init = milkv_duo_init;
+    mc->max_cpus = 2;
+    mc->default_cpu_type = TYPE_RISCV_CPU_THEAD_C906;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_size = 64 * MiB;
+    mc->default_ram_id = "riscv.milkv_duo.ram";
+}
+
+static const TypeInfo milkv_duo_machine_type_info = {
+    .name = TYPE_MILK_V_DUO,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(MilkVDuoState),
+    .class_init = milkv_duo_machine_class_init,
+};
+
+static void milkv_duo_machine_register_types(void)
+{
+    type_register_static(&milkv_duo_machine_type_info);
+}
+
+type_init(milkv_duo_machine_register_types)
-- 
2.54.0.563.g4f69b47b94-goog


