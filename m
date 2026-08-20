Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC20C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CS-00055p-Qr; Thu, 20 Aug 2026 08:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CR-00051Y-5D
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CL-0001cB-Sv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:50 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso3681741a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230124; x=1787834924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gL9ZUS6BT6A6Gof5/PiP8kJ7NAMV2LPWE40Df0h3U48=;
 b=CnpZM3r4FLLvTIUQ6xOHu/sDnNFVrV8LmG9Id8XUVHL1YZg+qEXTdXeyagADTvOxb7
 ccMfMA7iMJD9PJ3mYL7UW5NH9IbgBnMoKZWKp4PZurGhqnBxZjE1OrtkYQCz0/SL1oRm
 OpOFak1pw4bmz7IYtFpJ5zA43ooLsHVZx5FzwArDDEKMT4oBsSLEV/21mVfAVvH9RQvi
 /PptLpIlB5uFxxu3MkW/TCHcB6EiZWX2i4rBTKID21UBcllrtt2CpTwQWJEERR6pJDKZ
 5HTYpqCEPsGDqenh2up+iGaYtsw7NnzUqn+JvmgdX02gF4l6laCGO/oAtlcD5arwhT+V
 PDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230124; x=1787834924;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gL9ZUS6BT6A6Gof5/PiP8kJ7NAMV2LPWE40Df0h3U48=;
 b=dzVWsrPcT/m+ulxHrIn3oc1yqUe1QojxJKXNn0oIDCAvANPod85hl9+nEZefc4oXN1
 1DUnJ+Ccz88T1naaH8r+5DBPQSu9kd0uCcfqeNJA40Pmw9tS8pgDqhET62re0sd7MckO
 NdCrLdLXNEKofEkWLWqH022n2lDEN6q0dpx0KGCw2pYHlEhQKX0QiyL39cTkR1TS4hBB
 beDe7AxGXFtsf9ZFsMxffG5A1IfJ1FgUdPuwLMd/HX2uJH4NNU6AElhyR5hRrrpuNt8D
 xiXihlRaYPPhlm18jHsJ3HqGaC6EXxUwLhL3qW3RuUE3FC284gm30/Yhtcjv84gBsVkB
 8u9Q==
X-Gm-Message-State: AFuF++nO+r2nljmzn8RhhtWTD3QsAKYAcYpXiKAWRKM+oNryjKQ+xtHC
 D7G2g25pCRlqf2tWRW7iGFyHf7glhhPtOY59Q/Ryap8sxCj0KsR2q2kehdsh6WOO
X-Gm-Gg: AR+sD13V7LsRpYRzIUAKF2f16xoyA0Uj1EDGXsF9hbwyMPi+2a67enFmWURfNoS/qyk
 oxuukNgd86Xkz1tF+1yBBd4HveKl9cTf1sqKixbHFrBZ3i63p9xexq89ECa86bXG0WgBbN5QDJZ
 2c8Cbwb390ITPiTHLWMzRqSUegLPk26cizQNfEG2hQwX0sQtGuZ96uhfWPaWsJwgft+kZRPjigK
 tZn46rmdkMHHC67+h9foA4cL46WaPansDF4esoZo9Sk6Mes9fogQH+J0lTqxbSnBEF2wuFrN03j
 tCV8JvUkZVcCABDxJ1VsPdu1qRc5wkYTmZA9Mmg1i3+MSWr7px83e6w1hOGxCJQZdAzlJO4azOw
 XZidOz61EucNTi5DL2YtJCwNrn3bLvcUmNdVc65be5BmSUZ0NW6PmaNBI1K/7zt4DjSXZLHNfOL
 5bs0baNsl9ndC9ry3I0liNGV57YOcaFTpHQ2OW0sjgthxvnFtm6y3bSwHAMckVAljrfZwe/oFfa
 5peEQtiAz9n
X-Received: by 2002:a05:6402:241c:b0:69e:2d56:690a with SMTP id
 4fb4d7f45d1cf-6a4032b5d70mr9966061a12.8.1787230123846; 
 Thu, 20 Aug 2026 05:48:43 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:43 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 13/14] hw/arm: add the am64-virt machine
Date: Thu, 20 Aug 2026 14:48:13 +0200
Message-ID: <20260820124824.618671-14-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a board around the AM64x SoC model. Besides the SoC it wires up a
PL011 pair, a PL031 RTC, PL061 GPIO, CFI flash, a GPEX PCIe host bridge
and an SD card, so that it is usable both for direct kernel boot and for
running the full TI boot chain from a .wic image via -bios.

A generated device tree matching the machine is added under pc-bios/dtb
for convenience, together with documentation and a MAINTAINERS entry.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS                |  22 +++
 docs/system/arm/am64.rst   |  74 ++++++++
 docs/system/target-arm.rst |   1 +
 hw/arm/Kconfig             |   9 +
 hw/arm/am64-virt.c         | 347 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build         |   1 +
 pc-bios/dtb/am64-virt.dtb  | Bin 0 -> 6116 bytes
 pc-bios/dtb/am64-virt.dts  | 292 +++++++++++++++++++++++++++++++
 8 files changed, 746 insertions(+)
 create mode 100644 docs/system/arm/am64.rst
 create mode 100644 hw/arm/am64-virt.c
 create mode 100644 pc-bios/dtb/am64-virt.dtb
 create mode 100644 pc-bios/dtb/am64-virt.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..dd0a3ee66a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1266,6 +1266,28 @@ F: hw/arm/msf2-som.c
 F: docs/system/arm/emcraft-sf2.rst
 F: tests/functional/arm/test_emcraft_sf2.py
 
+TI AM64x / K3
+M: Wadim Mueller <wafgo01@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/am64-virt.c
+F: hw/arm/ti-am64x.c
+F: hw/arm/k3-bootrom*.c
+F: hw/char/ti-am64-uart.c
+F: hw/misc/ti-*.c
+F: hw/timer/ti-k3-dmtimer.c
+F: include/hw/arm/ti-am64x.h
+F: include/hw/arm/k3-bootrom.h
+F: include/hw/char/ti-am64-uart.h
+F: include/hw/misc/ti-*.h
+F: include/hw/timer/ti-k3-dmtimer.h
+F: pc-bios/dtb/am64-virt.dt[sb]
+F: tests/functional/aarch64/test_am64_bootrom.py
+F: tests/qtest/am64-*.c
+F: tests/qtest/ti-am64-i2c-test.c
+F: tests/unit/test-k3-bootrom.c
+F: docs/system/arm/am64.rst
+
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/system/arm/am64.rst b/docs/system/arm/am64.rst
new file mode 100644
index 0000000000..cc2483b839
--- /dev/null
+++ b/docs/system/arm/am64.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (c) 2026 CMBLU Energy AG
+
+Texas Instruments AM64x (``am64-virt``)
+======================================
+
+The ``am64-virt`` machine models a board built around the Texas Instruments
+AM64x (AM6442) Sitara SoC. The AM64x is a heterogeneous multi-core device;
+the model implements enough of it to run the stock TI boot chain
+(ROM boot -> R5 SPL -> TF-A/OP-TEE -> U-Boot -> Linux).
+
+Implemented CPU cores
+---------------------
+
+* Cortex-A53 cluster (2 cores, GICv3)
+* Cortex-R5F ``MCU_R5FSS0_CORE0`` boot core
+* Cortex-M4F ``MCU_M4FSS0_CORE0``
+
+Only one R5F core is modelled today; ``max_cpus`` reserves room for the
+remaining R5F cores of both clusters.
+
+Implemented devices
+-------------------
+
+* GICv3 (GIC-500) at the real AM64x addresses
+* MCU and MAIN domain UARTs (8250-compatible)
+* TI mailbox (IPC) blocks
+* TI secure proxy and the DMSC (TI-SCI system controller firmware) model
+* RAT (region address translation) for the R5F/M4F views of the memory map
+* CTRL_MMR (including the DEVSTAT boot pins), GTC, DDRSS, SDHCI PHY and TRNG
+* K3 DMTimer
+* SDHCI controllers (MMC1/eMMC and MMC2/SD)
+* OMAP-style MAIN I2C0 (no slaves; attach them with -device)
+* OCSRAM, DDR and a small set of virtio/PCIe/PL011/PL031/PL061 conveniences
+
+Boot modes
+----------
+
+Direct kernel boot::
+
+  qemu-system-aarch64 -M am64-virt -nographic \
+      -kernel Image -append "console=ttyAMA0" \
+      -dtb pc-bios/dtb/am64-virt.dtb
+
+ROM boot from a TI combined boot image (``tiboot3.bin``). The image is parsed
+the way the on-chip boot ROM does (X.509 certificate with the TI boot
+extension, followed by the individual components), the SYSFW component is
+handed to the DMSC model and the R5 SPL is started at the certified entry
+point::
+
+  qemu-system-aarch64 -M am64-virt -nographic \
+      -bios tiboot3.bin \
+      -drive if=sd,format=raw,file=core-image.wic
+
+Boot only the M4F core::
+
+  qemu-system-aarch64 -M am64-virt -M m4boot-cpu=0 -kernel m4-firmware.elf
+
+Machine options
+---------------
+
+``m4boot-cpu``
+  Set to ``0`` to hold the A53 and R5F cores in reset and boot only the M4F
+  core. Mutually exclusive with ``-bios``.
+
+Caveats
+-------
+
+Migration is not supported: the new device models have no VMState yet.
+
+Because the SoC realizes M4F and R5F vCPUs in addition to the A53s, every
+core needs a TCG context slot inside ``smp.max_cpus``. The machine therefore
+defaults to the full vCPU budget; if you pass ``-smp`` explicitly you must
+size ``maxcpus`` accordingly, for example ``-smp cpus=2,maxcpus=7``.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index e34492402f..2fd41111e4 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -71,6 +71,7 @@ Board-specific documentation
 .. toctree::
    :maxdepth: 1
 
+   arm/am64
    arm/max78000
    arm/integratorcp
    arm/mps2
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2172fc803b..3802170287 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -38,6 +38,15 @@ config ARM_VIRT
     select ACPI_HMAT
     select WDT_SBSA
 
+config AM64_VIRT
+    bool
+    default y
+    depends on TCG && ARM
+    select AT24C  # I2C EEPROMs can be attached with -device
+    select TI_AM64X
+    select TI_DMSC
+    select TI_SEC_PROXY
+
 config CUBIEBOARD
     bool
     default y
diff --git a/hw/arm/am64-virt.c b/hw/arm/am64-virt.c
new file mode 100644
index 0000000000..e78c73a347
--- /dev/null
+++ b/hw/arm/am64-virt.c
@@ -0,0 +1,347 @@
+/*
+ * AM64 virt machine model
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/char/pl011.h"
+#include "hw/block/flash.h"
+#include "hw/rtc/pl031.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/pci/pci.h"
+#include "hw/arm/ti-am64x.h"
+#include "hw/arm/k3-bootrom.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/sd/sd.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "system/blockdev.h"
+#include "qemu/error-report.h"
+#include "chardev/char.h"
+#include "qemu/units.h"
+#include "qemu/datadir.h"
+#include "qapi/visitor.h"
+
+#define AM64_VIRT_DRAM_BASE 0x80000000ULL
+#define AM64_VIRT_UART0_BASE 0x09000000ULL
+#define AM64_VIRT_UART1_BASE 0x09040000ULL
+#define AM64_VIRT_UART0_IRQ 1
+#define AM64_VIRT_UART1_IRQ 8
+#define AM64_VIRT_RTC_BASE 0x09010000ULL
+#define AM64_VIRT_RTC_IRQ 2
+#define AM64_VIRT_GPIO_BASE 0x09030000ULL
+#define AM64_VIRT_GPIO_IRQ 7
+#define AM64_VIRT_FLASH_BASE 0x050000000ULL
+#define AM64_VIRT_FLASH_SIZE 0x08000000ULL
+#define AM64_VIRT_FLASH_SECTOR_SIZE (256 * KiB)
+#define AM64_VIRT_PCIE_MMIO_BASE 0x68000000ULL
+#define AM64_VIRT_PCIE_MMIO_SIZE 0x08000000ULL
+#define AM64_VIRT_PCIE_PIO_BASE 0x3EFF0000ULL
+#define AM64_VIRT_PCIE_PIO_SIZE 0x00010000ULL
+#define AM64_VIRT_PCIE_ECAM_BASE 0x0D000000ULL
+#define AM64_VIRT_PCIE_ECAM_SIZE 0x02000000ULL
+#define AM64_VIRT_PCIE_IRQ_BASE 3
+
+#define SYSCLK_FRQ 168000000ULL
+
+typedef struct AM64VirtMachineState {
+    MachineState parent_obj;
+    TIAM64xState *soc;
+    struct arm_boot_info bootinfo;
+    int32_t m4boot_cpu;
+} AM64VirtMachineState;
+
+#define TYPE_AM64_VIRT_MACHINE MACHINE_TYPE_NAME("am64-virt")
+OBJECT_DECLARE_SIMPLE_TYPE(AM64VirtMachineState, AM64_VIRT_MACHINE)
+
+static void am64_virt_get_m4boot_cpu(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    AM64VirtMachineState *ams = AM64_VIRT_MACHINE(obj);
+    int32_t value = ams->m4boot_cpu;
+
+    visit_type_int32(v, name, &value, errp);
+}
+
+static void am64_virt_set_m4boot_cpu(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    AM64VirtMachineState *ams = AM64_VIRT_MACHINE(obj);
+    int32_t value;
+
+    if (!visit_type_int32(v, name, &value, errp)) {
+        return;
+    }
+    if (value != -1 && value != 0) {
+        error_setg(errp, "am64-virt: m4boot_cpu must be -1 or 0");
+        return;
+    }
+    ams->m4boot_cpu = value;
+}
+
+static void am64_virt_machine_instance_init(Object *obj)
+{
+    AM64VirtMachineState *ams = AM64_VIRT_MACHINE(obj);
+
+    ams->m4boot_cpu = -1;
+    object_property_add_alias(obj, "m4boot_cpu", obj, "m4boot-cpu");
+}
+
+static void am64_virt_create_uart(hwaddr base, int irq, Chardev *chr,
+                                  DeviceState *gic)
+{
+    DeviceState *dev = qdev_new(TYPE_PL011);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    MemoryRegion *sysmem = get_system_memory();
+
+    qdev_prop_set_chr(dev, "chardev", chr);
+    sysbus_realize_and_unref(s, &error_fatal);
+    memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(gic, irq));
+}
+
+static void am64_virt_create_pcie(const AM64VirtMachineState *ams,
+                                  DeviceState *gic)
+{
+    DeviceState *dev = qdev_new(TYPE_GPEX_HOST);
+    PCIHostState *pci;
+    MemoryRegion *mmio_alias;
+    MemoryRegion *ecam_alias;
+    MemoryRegion *mmio_reg;
+    MemoryRegion *ecam_reg;
+    int i;
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, AM64_VIRT_PCIE_ECAM_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                AM64_VIRT_PCIE_ECAM_BASE, ecam_alias);
+
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
+                             mmio_reg, AM64_VIRT_PCIE_MMIO_BASE,
+                             AM64_VIRT_PCIE_MMIO_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                AM64_VIRT_PCIE_MMIO_BASE, mmio_alias);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, AM64_VIRT_PCIE_PIO_BASE);
+
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(gic,
+                                            AM64_VIRT_PCIE_IRQ_BASE + i));
+        gpex_set_irq_num(GPEX_HOST(dev), i, AM64_VIRT_PCIE_IRQ_BASE + i);
+    }
+
+    pci = PCI_HOST_BRIDGE(dev);
+    pci_init_nic_devices(pci->bus, MACHINE_GET_CLASS(ams)->default_nic);
+}
+
+static void am64_virt_create_rtc(hwaddr base, int irq, DeviceState *gic)
+{
+    sysbus_create_simple(TYPE_PL031, base, qdev_get_gpio_in(gic, irq));
+}
+
+static void am64_virt_create_gpio(hwaddr base, int irq, DeviceState *gic)
+{
+    sysbus_create_simple("pl061", base, qdev_get_gpio_in(gic, irq));
+}
+
+static void am64_virt_create_flash(void)
+{
+    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
+
+    qdev_prop_set_uint32(dev, "num-blocks",
+                         AM64_VIRT_FLASH_SIZE / AM64_VIRT_FLASH_SECTOR_SIZE);
+    qdev_prop_set_uint64(dev, "sector-length", AM64_VIRT_FLASH_SECTOR_SIZE);
+    qdev_prop_set_uint8(dev, "width", 4);
+    qdev_prop_set_uint8(dev, "device-width", 2);
+    qdev_prop_set_bit(dev, "big-endian", false);
+    qdev_prop_set_uint16(dev, "id0", 0x89);
+    qdev_prop_set_uint16(dev, "id1", 0x18);
+    qdev_prop_set_uint16(dev, "id2", 0x00);
+    qdev_prop_set_uint16(dev, "id3", 0x00);
+    qdev_prop_set_string(dev, "name", "am64-virt.flash0");
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, AM64_VIRT_FLASH_BASE);
+}
+
+static void am64_virt_init(MachineState *machine)
+{
+    AM64VirtMachineState *ams = AM64_VIRT_MACHINE(machine);
+    DeviceState *soc = qdev_new(TYPE_TI_AM64X);
+    DeviceState *gic;
+    Clock *sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    Chardev *mcu_chardev;
+    uint8_t a53_cpus = MIN(machine->smp.cpus, TI_AM64X_A53_NUM);
+    DriveInfo *sd_di = drive_get(IF_SD, 0, 0);
+
+    /*
+     * The SoC has M4 and R5F vCPUs beyond the A53s. Since TCG allocates
+     * context slots from smp.max_cpus at accelerator init, fail before realize.
+     */
+    if (machine->smp.max_cpus < a53_cpus + 2) {
+        error_report("am64-virt: -smp maxcpus=%d is too small for %d A53 "
+                     "+ M4 + R5F vCPUs; raise maxcpus (e.g. "
+                     "-smp cpus=2,maxcpus=7) or omit -smp",
+                     machine->smp.max_cpus, a53_cpus);
+        exit(1);
+    }
+
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+    qdev_prop_set_uint8(soc, "a53-cpus", a53_cpus);
+    qdev_prop_set_uint64(soc, "ram-base", AM64_VIRT_DRAM_BASE);
+    qdev_prop_set_uint64(soc, "ram-size", machine->ram_size);
+    qdev_connect_clock_in(soc, "sysclk", sysclk);
+    mcu_chardev = qemu_chr_find("uart0");
+    if (mcu_chardev) {
+        qdev_prop_set_chr(DEVICE(&TI_AM64X(soc)->mcu_uart[0]),
+                          "chardev", mcu_chardev);
+    }
+    if (ams->m4boot_cpu >= 0) {
+        if (ams->m4boot_cpu != 0) {
+            error_report("am64-virt: m4boot_cpu only supports value 0");
+            exit(1);
+        }
+        qdev_prop_set_bit(soc, "a53-start-powered-off", true);
+        qdev_prop_set_bit(soc, "m4-start-powered-off", false);
+    }
+
+    if (machine->firmware && ams->m4boot_cpu >= 0) {
+        error_report("am64-virt: -bios and m4boot-cpu are mutually "
+                     "exclusive");
+        exit(1);
+    }
+    if (machine->firmware && machine->kernel_filename) {
+        /*
+         * ROM boot consumes -bios via k3_bootrom_load() and never calls
+         * arm_load_kernel(), therefore reject a silently ignored -kernel.
+         */
+        error_report("am64-virt: -bios and -kernel are mutually exclusive");
+        exit(1);
+    }
+    if (machine->firmware) {
+        /* ROM boot starts only R5F boot core. */
+        qdev_prop_set_bit(soc, "a53-start-powered-off", true);
+        qdev_prop_set_bit(soc, "m4-start-powered-off", true);
+        qdev_prop_set_bit(soc, "r5-start-powered-off", false);
+        qdev_prop_set_chr(DEVICE(&TI_AM64X(soc)->main_uart0),
+                          "chardev", serial_hd(0));
+        if (sd_di) {
+            /*
+             * DEVSTAT primary bootmode MMC (0x8), SD port: describe MMC2
+             * (sdhci[1]) FS-mode boot, not MMC1 raw mode.
+             */
+            qdev_prop_set_uint32(DEVICE(&TI_AM64X(soc)->ctrlmmr), "devstat",
+                                 0x240);
+        }
+    }
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(soc), &error_fatal);
+    ams->soc = TI_AM64X(soc);
+    gic = DEVICE(&ams->soc->gic);
+
+    if (sd_di) {
+        DeviceState *card = qdev_new(TYPE_SD_CARD);
+
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(sd_di),
+                                &error_fatal);
+        qdev_realize_and_unref(card,
+                               qdev_get_child_bus(DEVICE(&ams->soc->sdhci[1]),
+                                                  "sd-bus"),
+                               &error_fatal);
+    }
+
+    memory_region_add_subregion(get_system_memory(), AM64_VIRT_DRAM_BASE,
+                                machine->ram);
+
+    am64_virt_create_uart(AM64_VIRT_UART0_BASE, AM64_VIRT_UART0_IRQ,
+                          machine->firmware ? serial_hd(1) : serial_hd(0),
+                          gic);
+    am64_virt_create_uart(AM64_VIRT_UART1_BASE, AM64_VIRT_UART1_IRQ,
+                          machine->firmware ? serial_hd(2) : serial_hd(1),
+                          gic);
+    am64_virt_create_rtc(AM64_VIRT_RTC_BASE, AM64_VIRT_RTC_IRQ, gic);
+    am64_virt_create_gpio(AM64_VIRT_GPIO_BASE, AM64_VIRT_GPIO_IRQ, gic);
+    am64_virt_create_flash();
+    am64_virt_create_pcie(ams, gic);
+
+    memset(&ams->bootinfo, 0, sizeof(ams->bootinfo));
+    ams->bootinfo.ram_size = machine->ram_size;
+    ams->bootinfo.loader_start = AM64_VIRT_DRAM_BASE;
+    ams->bootinfo.board_id = -1;
+    ams->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    g_assert(qemu_get_cpu(0));
+    if (machine->firmware) {
+        g_autofree char *fn =
+            qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
+
+        k3_bootrom_load(ams->soc, fn ? fn : machine->firmware,
+                        &error_fatal);
+    } else if (ams->m4boot_cpu < 0) {
+        arm_load_kernel(ARM_CPU(qemu_get_cpu(0)), machine, &ams->bootinfo);
+    }
+}
+
+static void am64_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "AM64 virt machine";
+    mc->init = am64_virt_init;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->default_nic = "virtio-net-pci";
+    mc->default_ram_id = "am64-virt.ram";
+    /*
+     * Real AM64x has four R5F cores plus one M4 beyond the A53 cluster.
+     * Reserve max_cpus headroom for the not yet modeled R5F cores.
+     */
+    mc->max_cpus = TI_AM64X_A53_NUM + 4 + 1; /* 4 R5F cores, 1 M4 */
+    /*
+     * Default to the full heterogeneous vCPU budget, so plain invocations
+     * have enough TCG slots for A53, R5F and M4 cores.
+     */
+    mc->default_cpus = mc->max_cpus;
+    mc->default_ram_size = 2 * GiB;
+
+    object_class_property_add(oc, "m4boot-cpu", "int32",
+                              am64_virt_get_m4boot_cpu,
+                              am64_virt_set_m4boot_cpu,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "m4boot-cpu",
+                                          "Set to 0 to boot only the M4 core");
+}
+
+static const TypeInfo am64_virt_machine_info = {
+    .name = TYPE_AM64_VIRT_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(AM64VirtMachineState),
+    .instance_init = am64_virt_machine_instance_init,
+    .class_init = am64_virt_machine_class_init,
+    .interfaces = arm_aarch64_machine_interfaces,
+};
+
+static void am64_virt_machine_init_register_types(void)
+{
+    type_register_static(&am64_virt_machine_info);
+}
+
+type_init(am64_virt_machine_init_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 139692dd11..cb6e881d01 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -112,6 +112,7 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 arm_common_ss.add(when: 'CONFIG_TI_AM64X', if_true: files('ti-am64x.c'))
 arm_common_ss.add(when: 'CONFIG_TI_AM64X', if_true: files('k3-bootrom-parse.c'))
 arm_common_ss.add(when: 'CONFIG_TI_AM64X', if_true: files('k3-bootrom.c'))
+arm_common_ss.add(when: 'CONFIG_AM64_VIRT', if_true: files('am64-virt.c'))
 
 arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
   'ax3000-soc.c'))
diff --git a/pc-bios/dtb/am64-virt.dtb b/pc-bios/dtb/am64-virt.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..b9cf2dd0b494ade59cd8cd4e4dc7b4d1434f7724
GIT binary patch
literal 6116
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
Hr5XMU#<@8L

literal 0
HcmV?d00001

diff --git a/pc-bios/dtb/am64-virt.dts b/pc-bios/dtb/am64-virt.dts
new file mode 100644
index 0000000000..09ab555c2e
--- /dev/null
+++ b/pc-bios/dtb/am64-virt.dts
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ */
+/dts-v1/;
+
+/ {
+	interrupt-parent = <0x8003>;
+	dma-coherent;
+	model = "linux,dummy-virt";
+	#size-cells = <0x02>;
+	#address-cells = <0x02>;
+	compatible = "linux,dummy-virt";
+
+	reserved-memory {
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		ranges;
+
+		m4f-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+			phandle = <0x05>;
+		};
+
+		m4f-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+			phandle = <0x06>;
+		};
+	};
+
+	psci {
+		migrate = <0xc4000005>;
+		cpu_on = <0xc4000003>;
+		cpu_off = <0x84000002>;
+		cpu_suspend = <0xc4000001>;
+		method = "hvc";
+		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
+	};
+
+	memory@80000000 {
+		reg = <0x00 0x80000000 0x00 0x40000000>;
+		device_type = "memory";
+	};
+
+	bus@48000000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		dma-ranges;
+		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x6400000>;
+		ti,sci-dev-id = <0x19>;
+
+		mailbox@4d000000 {
+			bootph-all;
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <0x01>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x4d000000 0x00 0x80000 0x00 0x4a600000 0x00 0x80000 0x00 0x4a400000 0x00 0x80000>;
+			interrupt-names = "rx_012";
+			interrupts = <0x00 0x22 0x04>;
+			phandle = <0x07>;
+		};
+	};
+
+	platform-bus@c000000 {
+		interrupt-parent = <0x8003>;
+		ranges;
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		compatible = "qemu,platform", "simple-bus";
+
+		mailbox@29060000 {
+			compatible = "ti,am64-mailbox";
+			reg = <0x00 0x29060000 0x00 0x200>;
+			interrupts = <0x00 0x4c 0x04>;
+			#mbox-cells = <0x01>;
+			ti,mbox-num-users = <0x04>;
+			ti,mbox-num-fifos = <0x10>;
+			status = "okay";
+			phandle = <0x03>;
+
+			mbox-m4-0 {
+				ti,mbox-rx = <0x00 0x00 0x02>;
+				ti,mbox-tx = <0x01 0x00 0x02>;
+				phandle = <0x04>;
+			};
+		};
+
+		m4fss@5000000 {
+			compatible = "ti,am64-m4fss";
+			reg = <0x00 0x5000000 0x00 0x30000 0x00 0x5040000 0x00 0x10000>;
+			reg-names = "iram", "dram";
+			resets = <0x01 0x09 0x01>;
+			firmware-name = "am64-mcu-m4f0_0-fw";
+			ti,sci = <0x02>;
+			ti,sci-dev-id = <0x09>;
+			ti,sci-proc-ids = <0x18 0xff>;
+			mboxes = <0x03 0x04>;
+			memory-region = <0x05 0x06>;
+			status = "okay";
+		};
+
+		system-controller@44043000 {
+			bootph-all;
+			compatible = "ti,k2g-sci";
+			ti,host-id = <0x0c>;
+			mbox-names = "rx", "tx";
+			mboxes = <0x07 0x0c 0x07 0x0d>;
+			reg-names = "debug_messages";
+			reg = <0x00 0x44043000 0x00 0xfe0>;
+			phandle = <0x02>;
+
+			power-controller {
+				bootph-all;
+				compatible = "ti,sci-pm-domain";
+				#power-domain-cells = <0x02>;
+			};
+
+			clock-controller {
+				bootph-all;
+				compatible = "ti,k2g-sci-clk";
+				#clock-cells = <0x02>;
+			};
+
+			reset-controller {
+				bootph-all;
+				compatible = "ti,sci-reset";
+				#reset-cells = <0x02>;
+				phandle = <0x01>;
+			};
+		};
+	};
+
+	fw-cfg@9020000 {
+		dma-coherent;
+		reg = <0x00 0x9020000 0x00 0x18>;
+		compatible = "qemu,fw-cfg-mmio";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		poweroff {
+			gpios = <0x8005 0x03 0x00>;
+			linux,code = <0x74>;
+			label = "GPIO Key Poweroff";
+		};
+	};
+
+	pl061@9030000 {
+		phandle = <0x8005>;
+		clock-names = "apb_pclk";
+		clocks = <0x8000>;
+		interrupts = <0x00 0x07 0x04>;
+		gpio-controller;
+		#gpio-cells = <0x02>;
+		compatible = "arm,pl061", "arm,primecell";
+		reg = <0x00 0x9030000 0x00 0x1000>;
+	};
+
+	pcie@d000000 {
+		interrupt-map-mask = <0x1800 0x00 0x00 0x07>;
+		interrupt-map = <0x00 0x00 0x00 0x01 0x8003 0x00 0x00 0x00 0x03 0x04 0x00 0x00 0x00 0x02 0x8003 0x00 0x00 0x00 0x04 0x04 0x00 0x00 0x00 0x03 0x8003 0x00 0x00 0x00 0x05 0x04 0x00 0x00 0x00 0x04 0x8003 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x01 0x8003 0x00 0x00 0x00 0x04 0x04 0x800 0x00 0x00 0x02 0x8003 0x00 0x00 0x00 0x05 0x04 0x800 0x00 0x00 0x03 0x8003 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x04 0x8003 0x00 0x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x01 0x8003 0x00 0x00 0x00 0x05 0x04 0x1000 0x00 0x00 0x02 0x8003 0x00 0x00 0x00 0x06 0x04 0x1000 0x00 0x00 0x03 0x8003 0x00 0x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x04 0x8003 0x00 0x00 0x00 0x04 0x04 0x1800 0x00 0x00 0x01 0x8003 0x00 0x00 0x00 0x06 0x04 0x1800 0x00 0x00 0x02 0x8003 0x00 0x00 0x00 0x03 0x04 0x1800 0x00 0x00 0x03 0x8003 0x00 0x00 0x00 0x04 0x04 0x1800 0x00 0x00 0x04 0x8003 0x00 0x00 0x00 0x05 0x04>;
+		#interrupt-cells = <0x01>;
+		ranges = <0x1000000 0x00 0x00 0x00 0x3eff0000 0x00 0x10000 0x2000000 0x00 0x68000000 0x00 0x68000000 0x00 0x08000000>;
+		reg = <0x00 0x0d000000 0x00 0x02000000>;
+		dma-coherent;
+		bus-range = <0x00 0x1f>;
+		linux,pci-domain = <0x00>;
+		#size-cells = <0x02>;
+		#address-cells = <0x03>;
+		device_type = "pci";
+		compatible = "pci-host-ecam-generic";
+	};
+
+	pl031@9010000 {
+		clock-names = "apb_pclk";
+		clocks = <0x8000>;
+		interrupts = <0x00 0x02 0x04>;
+		reg = <0x00 0x9010000 0x00 0x1000>;
+		compatible = "arm,pl031", "arm,primecell";
+	};
+
+	pl011@9000000 {
+		clock-names = "uartclk", "apb_pclk";
+		clocks = <0x8000 0x8000>;
+		interrupts = <0x00 0x01 0x04>;
+		reg = <0x00 0x9000000 0x00 0x1000>;
+		compatible = "arm,pl011", "arm,primecell";
+	};
+
+	pl011@9040000 {
+		clock-names = "uartclk", "apb_pclk";
+		clocks = <0x8000 0x8000>;
+		interrupts = <0x00 0x08 0x04>;
+		reg = <0x00 0x9040000 0x00 0x1000>;
+		compatible = "arm,pl011", "arm,primecell";
+	};
+
+	pmu {
+		interrupts = <0x01 0x07 0x304>;
+		compatible = "arm,armv8-pmuv3";
+	};
+
+	intc@1800000 {
+		phandle = <0x8003>;
+		reg = <0x00 0x1800000 0x00 0x10000
+		       0x00 0x1840000 0x00 0x40000>;
+		compatible = "arm,gic-v3";
+		ranges;
+		#size-cells = <0x02>;
+		#address-cells = <0x02>;
+		interrupt-controller;
+		#interrupt-cells = <0x03>;
+	};
+
+
+	flash@50000000 {
+		bank-width = <0x04>;
+		reg = <0x00 0x50000000 0x00 0x8000000>;
+		compatible = "cfi-flash";
+	};
+	cpus {
+		#size-cells = <0x00>;
+		#address-cells = <0x01>;
+
+		cpu-map {
+
+			socket0 {
+
+				cluster0 {
+
+					core0 {
+						cpu = <0x8002>;
+					};
+
+					core1 {
+						cpu = <0x8001>;
+					};
+				};
+			};
+		};
+
+		cpu@0 {
+			phandle = <0x8002>;
+			reg = <0x00>;
+			enable-method = "psci";
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+		};
+
+		cpu@1 {
+			phandle = <0x8001>;
+			reg = <0x01>;
+			enable-method = "psci";
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+		};
+	};
+
+	timer {
+		interrupts = <0x01 0x0d 0x304 0x01 0x0e 0x304 0x01 0x0b 0x304 0x01 0x0a 0x304>;
+		always-on;
+		compatible = "arm,armv8-timer", "arm,armv7-timer";
+	};
+
+	apb-pclk {
+		phandle = <0x8000>;
+		clock-output-names = "clk24mhz";
+		clock-frequency = <0x16e3600>;
+		#clock-cells = <0x00>;
+		compatible = "fixed-clock";
+	};
+
+	aliases {
+		serial0 = "/pl011@9000000";
+		serial1 = "/pl011@9040000";
+	};
+
+	chosen {
+		bootargs = "root=/dev/vda rw  mem=2048M console=ttyS2 console=ttyAMA0 swiotlb=0 audit=0";
+		stdout-path = "/pl011@9000000";
+		rng-seed = <0x2b2313e6 0x69289174 0x3e2a0676 0xe5dcc1a8 0xc1e04c16 0x988a8076 0x6e26a8c8 0x2a273f53>;
+		kaslr-seed = <0x10fd45dd 0xbe924a75>;
+	};
+};
-- 
2.43.0


