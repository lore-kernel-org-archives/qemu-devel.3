Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E85FC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOI-0007o1-Uv; Fri, 04 Jul 2025 07:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeN1-0004ny-61
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMx-0004LO-Ik
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23508d30142so11811795ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627653; x=1752232453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tanjo3IjdnvrqigXkqoaDukbAgpXNFJ8dVjpQVHFZak=;
 b=DAWUoaIqsFVa/bhILRHhWy/TCLe8JvMMZP77nyyLHMfKQq16xh4rzfwWs8H6heib7Y
 RvKf7ws+4OuSWJmex+eSNAxSb2wag8uHrC5OxveteNmFv+aZoM73+hQm4HobM3i2Z3V+
 SqdNyOLIxs2GZq9lOpsJ+p9lX0mpSktp6eOTOWM5HemJtkqUAFsHQqd97xyZ2t0Q6Nm+
 Jio+dG5owJJPMjlqDoLyomX7R178TPmO8kEuzRhX88D6s9ieignnHiN4pZJIFi1QCWjW
 KXsX7jUNyJJynKTHsKOOykZD+zLHOrYTQsk3eMh/xhJMNFZnJh2gQ0J9p8Npm3zTUUOg
 pN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627653; x=1752232453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tanjo3IjdnvrqigXkqoaDukbAgpXNFJ8dVjpQVHFZak=;
 b=ghOZbjR1x8jJA87rqfc1EDGq6vP9Hn6yB2/pvtxU3C4QyY61SfqiIVloF3yrwVA4m2
 aMvny3p+3c+6LEUaefeq46hshcneuGts6ncVBc5KJoTyS+5PT4K/mcVDuuiS8EWxEw08
 Bs7l54qjcHnX63d90Txhr7RVag90AHfeGZsWeV3eZck981RroZYcSEpYMr4MpGyMQ4i2
 12JdUNXa1FANK9PcHEGqX7SILjlyn4dRav44OQuH9z695V8BHDcC2VSTxBLirawIHiNQ
 jgdFJlCq7B87c4iZ+WGaraIIE6gl3obkmNgeJBqbrvYphZ/OHth3QuDEkwRAf71kJkd1
 h0+g==
X-Gm-Message-State: AOJu0Yyw5wH49+WSHcZqd+y73atQ7x/W49gtOxVmaOpqqlGiNLNRV6vh
 5/jYHg0fFCrT9C96e0WPv6sc4QXXjeuUE/0MuN9xqc2fOXKXyMZocHPxIvU3dA==
X-Gm-Gg: ASbGncv/06Xyow8FxbpvH9reA1AZCNgEctSEGeFvOpkK7+bAarkB0Vp0B9FUHDjjR0a
 W3vQQ5Bmztc5OHF9CgmByXfryEQooZ5BQKvRvx/zskmN02LhbnvgKPy+E614RiBxmMUkhnaV22P
 oFiY0/ccW5Yb4xkuwk9rOWKnbOhHD+nKyqmA00mUmzPNTHgnbgLVeuA3Q627eovaMyUHCU2YiD8
 r2gB3xwg3uEUAztJ2NJAsSjXVq9Z91T4u1p7MC/bDUR0Q50P63Uu6aI0UFjLaDsq3FioLoGAcao
 fR2hb5VkZpK9uCePbgn4Uuk/4IynDxT33DGZC/u/VCnNOWakAaXV4YLbPkzAgpTFT6eMGN17EAE
 s1vqhLm9LeLhhA8te1iXGQtnKQg7O0qC25556EC4SfTH+6G+MtV31BnNvG9QAMqx7b4k=
X-Google-Smtp-Source: AGHT+IHUClWgC5HhiEDKBUEpjigPyI1d+vslMoaBqC/s27XIHBgUFjbs1/0kxzz95xB4vWgvz0Tn+A==
X-Received: by 2002:a17:902:ce82:b0:235:711:f810 with SMTP id
 d9443c01a7336-23c85e2e40bmr31759845ad.23.1751627653348; 
 Fri, 04 Jul 2025 04:14:13 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Huang Borong <3543977024@qq.com>,
 qinshaoqing <qinshaoqing@bosc.ac.cn>, Yang Wang <wangyang@bosc.ac.cn>,
 Yu Hu <819258943@qq.com>, Ran Wang <wangran@bosc.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/40] hw/riscv: Initial support for BOSC's Xiangshan Kunminghu
 FPGA prototype
Date: Fri,  4 Jul 2025 21:12:01 +1000
Message-ID: <20250704111207.591994-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Huang Borong <3543977024@qq.com>

This implementation provides emulation for the Xiangshan Kunminghu
FPGA prototype platform, including support for UART, CLINT, IMSIC,
and APLIC devices. More details can be found at
https://github.com/OpenXiangShan/XiangShan

Signed-off-by: qinshaoqing <qinshaoqing@bosc.ac.cn>
Signed-off-by: Yang Wang <wangyang@bosc.ac.cn>
Signed-off-by: Yu Hu <819258943@qq.com>
Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
Signed-off-by: Borong Huang <3543977024@qq.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250617074222.17618-1-wangran@bosc.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                 |   7 +
 docs/system/riscv/xiangshan-kunminghu.rst   |  39 ++++
 docs/system/target-riscv.rst                |   1 +
 configs/devices/riscv64-softmmu/default.mak |   1 +
 include/hw/riscv/xiangshan_kmh.h            |  68 ++++++
 hw/riscv/xiangshan_kmh.c                    | 220 ++++++++++++++++++++
 hw/riscv/Kconfig                            |   9 +
 hw/riscv/meson.build                        |   1 +
 8 files changed, 346 insertions(+)
 create mode 100644 docs/system/riscv/xiangshan-kunminghu.rst
 create mode 100644 include/hw/riscv/xiangshan_kmh.h
 create mode 100644 hw/riscv/xiangshan_kmh.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b1cbfe115b..12efc88aa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1697,6 +1697,13 @@ S: Maintained
 F: hw/riscv/microblaze-v-generic.c
 F: docs/system/riscv/microblaze-v-generic.rst
 
+Xiangshan Kunminghu
+M: Ran Wang <wangran@bosc.ac.cn>
+S: Maintained
+F: docs/system/riscv/xiangshan-kunminghu.rst
+F: hw/riscv/xiangshan_kmh.c
+F: include/hw/riscv/xiangshan_kmh.h
+
 RX Machines
 -----------
 rx-gdbsim
diff --git a/docs/system/riscv/xiangshan-kunminghu.rst b/docs/system/riscv/xiangshan-kunminghu.rst
new file mode 100644
index 0000000000..46e7ceeda0
--- /dev/null
+++ b/docs/system/riscv/xiangshan-kunminghu.rst
@@ -0,0 +1,39 @@
+BOSC Xiangshan Kunminghu FPGA prototype platform (``xiangshan-kunminghu``)
+==========================================================================
+The ``xiangshan-kunminghu`` machine is compatible with our FPGA prototype
+platform.
+
+XiangShan is an open-source high-performance RISC-V processor project.
+The third generation processor is called Kunminghu. Kunminghu is a 64-bit
+RV64GCBSUHV processor core. More information can be found in our Github
+repository:
+https://github.com/OpenXiangShan/XiangShan
+
+Supported devices
+-----------------
+The ``xiangshan-kunminghu`` machine supports the following devices:
+
+* Up to 16 xiangshan-kunminghu cores
+* Core Local Interruptor (CLINT)
+* Incoming MSI Controller (IMSIC)
+* Advanced Platform-Level Interrupt Controller (APLIC)
+* 1 UART
+
+Boot options
+------------
+The ``xiangshan-kunminghu`` machine can start using the standard ``-bios``
+functionality for loading the boot image. You need to compile and link
+the firmware, kernel, and Device Tree (FDT) into a single binary file,
+such as ``fw_payload.bin``.
+
+Running
+-------
+Below is an example command line for running the ``xiangshan-kunminghu``
+machine:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -machine xiangshan-kunminghu \
+      -smp 16 -m 16G \
+      -bios path/to/opensbi/platform/generic/firmware/fw_payload.bin \
+      -nographic
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 95457af130..89b2cb732c 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
    riscv/shakti-c
    riscv/sifive_u
    riscv/virt
+   riscv/xiangshan-kunminghu
 
 RISC-V CPU firmware
 -------------------
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index 39ed3a0061..e485bbd1a3 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -11,3 +11,4 @@
 # CONFIG_RISCV_VIRT=n
 # CONFIG_MICROCHIP_PFSOC=n
 # CONFIG_SHAKTI_C=n
+# CONFIG_XIANGSHAN_KUNMINGHU=n
diff --git a/include/hw/riscv/xiangshan_kmh.h b/include/hw/riscv/xiangshan_kmh.h
new file mode 100644
index 0000000000..c5dc6b1a9a
--- /dev/null
+++ b/include/hw/riscv/xiangshan_kmh.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * QEMU RISC-V Board Compatible with the Xiangshan Kunminghu
+ * FPGA prototype platform
+ *
+ * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
+ *
+ */
+
+#ifndef HW_XIANGSHAN_KMH_H
+#define HW_XIANGSHAN_KMH_H
+
+#include "hw/boards.h"
+#include "hw/riscv/riscv_hart.h"
+
+#define XIANGSHAN_KMH_MAX_CPUS 16
+
+typedef struct XiangshanKmhSoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState cpus;
+    DeviceState *irqchip;
+    MemoryRegion rom;
+} XiangshanKmhSoCState;
+
+#define TYPE_XIANGSHAN_KMH_SOC "xiangshan.kunminghu.soc"
+DECLARE_INSTANCE_CHECKER(XiangshanKmhSoCState, XIANGSHAN_KMH_SOC,
+                         TYPE_XIANGSHAN_KMH_SOC)
+
+typedef struct XiangshanKmhState {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    XiangshanKmhSoCState soc;
+} XiangshanKmhState;
+
+#define TYPE_XIANGSHAN_KMH_MACHINE MACHINE_TYPE_NAME("xiangshan-kunminghu")
+DECLARE_INSTANCE_CHECKER(XiangshanKmhState, XIANGSHAN_KMH_MACHINE,
+                         TYPE_XIANGSHAN_KMH_MACHINE)
+
+enum {
+    XIANGSHAN_KMH_ROM,
+    XIANGSHAN_KMH_UART0,
+    XIANGSHAN_KMH_CLINT,
+    XIANGSHAN_KMH_APLIC_M,
+    XIANGSHAN_KMH_APLIC_S,
+    XIANGSHAN_KMH_IMSIC_M,
+    XIANGSHAN_KMH_IMSIC_S,
+    XIANGSHAN_KMH_DRAM,
+};
+
+enum {
+    XIANGSHAN_KMH_UART0_IRQ = 10,
+};
+
+/* Indicating Timebase-freq (1MHZ) */
+#define XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ 1000000
+
+#define XIANGSHAN_KMH_IMSIC_NUM_IDS 255
+#define XIANGSHAN_KMH_IMSIC_NUM_GUESTS 7
+#define XIANGSHAN_KMH_IMSIC_GUEST_BITS 3
+
+#define XIANGSHAN_KMH_APLIC_NUM_SOURCES 96
+
+#endif
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
new file mode 100644
index 0000000000..a95fd6174f
--- /dev/null
+++ b/hw/riscv/xiangshan_kmh.c
@@ -0,0 +1,220 @@
+/*
+ * QEMU RISC-V Board Compatible with the Xiangshan Kunminghu
+ * FPGA prototype platform
+ *
+ * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the Xiangshan Kunminghu
+ * FPGA prototype platform:
+ *
+ * 0) UART (16550A)
+ * 1) CLINT (Core-Local Interruptor)
+ * 2) IMSIC (Incoming MSI Controller)
+ * 3) APLIC (Advanced Platform-Level Interrupt Controller)
+ *
+ * More information can be found in our Github repository:
+ * https://github.com/OpenXiangShan/XiangShan
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/boot.h"
+#include "hw/riscv/xiangshan_kmh.h"
+#include "hw/riscv/riscv_hart.h"
+#include "system/system.h"
+
+static const MemMapEntry xiangshan_kmh_memmap[] = {
+    [XIANGSHAN_KMH_ROM] =          {     0x1000,        0xF000 },
+    [XIANGSHAN_KMH_UART0] =        { 0x310B0000,       0x10000 },
+    [XIANGSHAN_KMH_CLINT] =        { 0x38000000,       0x10000 },
+    [XIANGSHAN_KMH_APLIC_M] =      { 0x31100000,        0x4000 },
+    [XIANGSHAN_KMH_APLIC_S] =      { 0x31120000,        0x4000 },
+    [XIANGSHAN_KMH_IMSIC_M] =      { 0x3A800000,       0x10000 },
+    [XIANGSHAN_KMH_IMSIC_S] =      { 0x3B000000,       0x80000 },
+    [XIANGSHAN_KMH_DRAM] =         { 0x80000000,           0x0 },
+};
+
+static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
+{
+    int i;
+    const MemMapEntry *memmap = xiangshan_kmh_memmap;
+    hwaddr addr = 0;
+    DeviceState *aplic_m = NULL;
+
+    /* M-level IMSICs */
+    addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
+    for (i = 0; i < num_harts; i++) {
+        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
+                           1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
+    }
+
+    /* S-level IMSICs */
+    addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
+    for (i = 0; i < num_harts; i++) {
+        riscv_imsic_create(addr +
+                           i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
+                           i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
+                           XIANGSHAN_KMH_IMSIC_NUM_IDS);
+    }
+
+    /* M-level APLIC */
+    aplic_m = riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
+                                 memmap[XIANGSHAN_KMH_APLIC_M].size,
+                                 0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
+                                 1, true, true, NULL);
+
+    /* S-level APLIC */
+    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
+                       memmap[XIANGSHAN_KMH_APLIC_S].size,
+                       0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
+                       1, true, false, aplic_m);
+
+    return aplic_m;
+}
+
+static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    XiangshanKmhSoCState *s = XIANGSHAN_KMH_SOC(dev);
+    const MemMapEntry *memmap = xiangshan_kmh_memmap;
+    MemoryRegion *system_memory = get_system_memory();
+    uint32_t num_harts = ms->smp.cpus;
+
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "num-harts", num_harts);
+    qdev_prop_set_uint32(DEVICE(&s->cpus), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(&s->cpus), "cpu-type",
+                         TYPE_RISCV_CPU_XIANGSHAN_KMH);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+
+    /* AIA */
+    s->irqchip = xiangshan_kmh_create_aia(num_harts);
+
+    /* UART */
+    serial_mm_init(system_memory, memmap[XIANGSHAN_KMH_UART0].base, 2,
+                   qdev_get_gpio_in(s->irqchip, XIANGSHAN_KMH_UART0_IRQ),
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* CLINT */
+    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
+                            0, num_harts, false);
+    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
+                               RISCV_ACLINT_SWI_SIZE,
+                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                               0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,
+                               RISCV_ACLINT_DEFAULT_MTIME,
+                               XIANGSHAN_KMH_CLINT_TIMEBASE_FREQ, true);
+
+    /* ROM */
+    memory_region_init_rom(&s->rom, OBJECT(dev), "xiangshan.kunminghu.rom",
+                           memmap[XIANGSHAN_KMH_ROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                memmap[XIANGSHAN_KMH_ROM].base, &s->rom);
+}
+
+static void xiangshan_kmh_soc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = xiangshan_kmh_soc_realize;
+    dc->user_creatable = false;
+}
+
+static void xiangshan_kmh_soc_instance_init(Object *obj)
+{
+    XiangshanKmhSoCState *s = XIANGSHAN_KMH_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+}
+
+static const TypeInfo xiangshan_kmh_soc_info = {
+    .name = TYPE_XIANGSHAN_KMH_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(XiangshanKmhSoCState),
+    .instance_init = xiangshan_kmh_soc_instance_init,
+    .class_init = xiangshan_kmh_soc_class_init,
+};
+
+static void xiangshan_kmh_soc_register_types(void)
+{
+    type_register_static(&xiangshan_kmh_soc_info);
+}
+type_init(xiangshan_kmh_soc_register_types)
+
+static void xiangshan_kmh_machine_init(MachineState *machine)
+{
+    XiangshanKmhState *s = XIANGSHAN_KMH_MACHINE(machine);
+    const MemMapEntry *memmap = xiangshan_kmh_memmap;
+    MemoryRegion *system_memory = get_system_memory();
+    hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_XIANGSHAN_KMH_SOC);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    /* Register RAM */
+    memory_region_add_subregion(system_memory,
+                                memmap[XIANGSHAN_KMH_DRAM].base,
+                                machine->ram);
+
+    /* ROM reset vector */
+    riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
+                              start_addr,
+                              memmap[XIANGSHAN_KMH_ROM].base,
+                              memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware, &start_addr, NULL);
+    }
+
+    /* Note: dtb has been integrated into firmware(OpenSBI) when compiling */
+}
+
+static void xiangshan_kmh_machine_class_init(ObjectClass *klass, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(klass);
+    static const char *const valid_cpu_types[] = {
+        TYPE_RISCV_CPU_XIANGSHAN_KMH,
+        NULL
+    };
+
+    mc->desc = "RISC-V Board compatible with the Xiangshan " \
+               "Kunminghu FPGA prototype platform";
+    mc->init = xiangshan_kmh_machine_init;
+    mc->max_cpus = XIANGSHAN_KMH_MAX_CPUS;
+    mc->default_cpu_type = TYPE_RISCV_CPU_XIANGSHAN_KMH;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_id = "xiangshan.kunminghu.ram";
+}
+
+static const TypeInfo xiangshan_kmh_machine_info = {
+    .name = TYPE_XIANGSHAN_KMH_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(XiangshanKmhState),
+    .class_init = xiangshan_kmh_machine_class_init,
+};
+
+static void xiangshan_kmh_machine_register_types(void)
+{
+    type_register_static(&xiangshan_kmh_machine_info);
+}
+type_init(xiangshan_kmh_machine_register_types)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6a0ac1fa1..fc9c35bd98 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -119,3 +119,12 @@ config SPIKE
     select HTIF
     select RISCV_ACLINT
     select SIFIVE_PLIC
+
+config XIANGSHAN_KUNMINGHU
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select SERIAL_MM
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index c22f3a7216..2a8d5b136c 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -13,5 +13,6 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
+riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 
 hw_arch += {'riscv': riscv_ss}
-- 
2.50.0


