Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB65CFF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcuR-0007R4-7M; Sat, 25 Apr 2026 09:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuM-0007Hi-WE
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuI-0000Gz-RE
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f1bfc9b8fso3999423b3a.1
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123129; x=1777727929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5hVR0szfLa1Sd9HchfmovkD60pPov32aK2HjckAgro=;
 b=k57YKe5HwPiJp8pgXowrW0lbE2MSpif9AG6iEC3/+yH/MY2o+tApdMOhEEUG9vtEvT
 eMbXEwTMcjLFunT/X7DQoa+30OsHo/dU/4Tir1EY9X2fBfEKqQ17qDRhM38vsOBsd6nI
 xV99IuKJBy7KRM+zqzBGZs+ZcLfjefJsRYXLEIuiDrVQhM96BoLF+zN2vrEw7OC7ruAu
 CcQGJVMF3Y/gJIrYFYC6lhbTF2hd884jLJSsRv0Blf8KLvsE+SdxdIuwVBgSf1qEoA78
 PthJ2dW+87zdRO05zAiGUlfAP+XovMpfZsMUUu1qVFhvFsyR/KvxeJ9Gx+hFNCXEEQ0I
 92iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123129; x=1777727929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C5hVR0szfLa1Sd9HchfmovkD60pPov32aK2HjckAgro=;
 b=enyiAyzDaElUpIRhLShVuG66TTLgCRL92HyQnGXWXmZBSasgJUcas+hihiHuxp3BC2
 iRyb78N5cHPL7YiH2zynCVtKEo5wRZDYPbStH0+VmFPrCgJUVg3eIoE8v4pyuhf5V5vD
 F2qV/B0IYxejWW24q4nAyUArGgBlJlCUBJ/bIheimeRyk3yLxUBf1NFesVQmDqAd05cn
 44+ZCy7tF105NTlJcWu3OwOqhqJ08Zjfc3nZkegYrMr+ZEnfmfHgKEDBUNbdnxaF7FrX
 bSOQEpPkATc4DwsC42kdbpZvFiTpyfQRckMDJaOkZRqR+U+bl1/o/OWc0inBDKP4j237
 3AKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/9oQFOOQTLPwh9NvGLnSOVUI6DU090Xx/WxhfHoH95CFVw0GlAMmdyxcTb09cU4+YbnVXTMDkrIKg@nongnu.org
X-Gm-Message-State: AOJu0YwmY1g9K5z1K9jj7J0fRqWHdnudXMzBYoQkPXxmXkNMDwKQZe9v
 4J1e27NAwHKALJA3tzkObcnYQGh3H7eC0DmFZLkzHFMIx7FyJqtBL0hn
X-Gm-Gg: AeBDiesb5WYmvkqXh1NvJC916wV2Y4uk6dttS/xZ2LuazOl9rRVQND1/sQrKjmymjje
 9znTcE/1RDjwFhSbDdZG9N4QMzgusqe0VffSdFtY0h5MoPnmP9qC2P+XSSmz7GfaNxh78Qht84A
 Q0SVpH7s6xzgG/w7026MpGfdhT/8dXjwY31ho/K5/ktE54+Xgv84glVZhZ9Ots88cItp5e8iwhC
 uLKdktbRaR82pnxWjtqm/Q+3/8x1v2jaIXSBNNZ+gCPtvum/lBdVkrfwqwMSL2HmcEM45ZgIz5d
 +Z53glwsOndcsumCliDAg9sGVwFwdMofYA3X8W4GCMlYbc4paKj9iaABlj7UoQyVdeVIKTPF0xm
 m0L3xs04M0PmYhY4NUb77d6wEQELvxxbnLl03DTo00qYZCxXjNErpD4Lu+Ab0TWzgubl3yiXowS
 EAMNqIPsi8GOP91turRh0TMWiNE8lTdHjr9DVQ6gUrWndiQ/WvdQLDGOP4Acqav936IGFxE8fNi
 BmCzhHczQfRtUdxPto5veNsRBJFWRWi
X-Received: by 2002:a05:6a00:14c2:b0:82f:8332:4933 with SMTP id
 d2e1a72fcca58-82f8c7dd158mr35501433b3a.3.1777123129353; 
 Sat, 25 Apr 2026 06:18:49 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:48 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
Date: Sat, 25 Apr 2026 23:17:15 +1000
Message-ID: <20260425131721.932250-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
and CoreLab Technology. It is based on the Atlantis SoC, which includes
the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
RISC-V CPU.

This adds the machine containing serial console, interrupt controllers
and device tree support.

  qemu-system-riscv64 -M tt-atlantis -m 512M \
   -kernel Image -initrd rootfs.cpio -nographic

If there is no kernel provided the simple payload is loaded to avoid
OpenSBI hanging with no messages.

Co-Developed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v4:
 - Clean up unused PCIe defines
v3:
  - Merge simple payload change into this patch
  - Fix fw_cfg_init_mem_dma API change
  - Clean up irqchip #defines
  - Add Michael and Nick as reviewers
  - create_fdt_pmu was copying RISCVCPU by value
  - Remove unused platform_bus

remove unused defines

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                       |  11 +
 docs/system/riscv/tt_atlantis.rst |  38 ++
 docs/system/target-riscv.rst      |   1 +
 include/hw/riscv/tt_atlantis.h    |  61 +++
 hw/riscv/tt_atlantis.c            | 632 ++++++++++++++++++++++++++++++
 hw/riscv/Kconfig                  |  15 +
 hw/riscv/meson.build              |   1 +
 7 files changed, 759 insertions(+)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/riscv/tt_atlantis.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e1942a86eba5..635a380945fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1760,6 +1760,17 @@ F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 F: tests/functional/test_riscv64_sifive_u.py
 
+Tenstorrent Machines
+M: Joel Stanley <joel@jms.id.au>
+R: Nicholas Piggin <npiggin@gmail.com>
+R: Michael Ellerman <mpe@kernel.org>
+L: qemu-riscv@nongnu.org
+S: Supported
+F: docs/system/riscv/tt_*.rst
+F: hw/riscv/tt_*.c
+F: hw/riscv/aia.[ch]
+F: include/hw/riscv/tt_*.h
+
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
 S: Maintained
diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
new file mode 100644
index 000000000000..640cabf7b046
--- /dev/null
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -0,0 +1,38 @@
+Tenstorrent Atlantis (``tt-atlantis``)
+======================================
+
+The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
+and CoreLab Technology. It is based on the Atlantis SoC, which includes
+the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
+
+The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
+RISC-V CPU.
+
+Features
+--------
+
+* 8-core Ascalon-X CPU Cluster
+* Dual x32 LPDDR5 @ 6400 MT/s
+* RISC-V compliant Advanced Interrupt Architecture
+* PCIe Gen4
+* RISC-V compliant IOMMU
+* GPU and Video subsystem
+* 2x USB3.1 & 2x USB2.0
+* 2x 1GbE Ethernet
+* 2x eMMC5.1/SDIO3.0 storage
+* Extensive connectivity (SPI, I2C, UART, GPIO, CANFD)
+
+Note: the QEMU tt-atlantis machine does not model the platform
+exactly or all devices, but it is undergoing improvement.
+
+Supported software
+------------------
+
+The Tenstorrent Ascalon CPUs avoid proprietary or non-standard
+extensions, so compatibility with existing software is generally
+good. The QEMU tt-atlantis machine works with upstream OpenSBI
+and Linux with default configurations.
+
+The development board hardware will require some implementation
+specific setup in firmware which is being developed and may
+become a requirement or option for the tt-atlantis machine.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddafbb..a8e6b3342186 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
    riscv/mips
    riscv/shakti-c
    riscv/sifive_u
+   riscv/tt_atlantis
    riscv/virt
    riscv/xiangshan-kunminghu
 
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
new file mode 100644
index 000000000000..9fe50d9c9040
--- /dev/null
+++ b/include/hw/riscv/tt_atlantis.h
@@ -0,0 +1,61 @@
+/*
+ * Tenstorrent Atlantis RISC-V System on Chip
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Tenstorrent, Joel Stanley <joel@jms.id.au>
+ */
+
+#ifndef HW_RISCV_TT_ATLANTIS_H
+#define HW_RISCV_TT_ATLANTIS_H
+
+#include "hw/core/boards.h"
+#include "hw/core/sysbus.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/riscv/riscv_hart.h"
+
+#define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
+OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
+
+struct TTAtlantisState {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+    Notifier machine_done;
+    FWCfgState *fw_cfg;
+    const MemMapEntry *memmap;
+
+    RISCVHartArrayState soc;
+    DeviceState *irqchip;
+
+    int fdt_size;
+};
+
+enum {
+    TT_ATL_SYSCON_IRQ = 10,
+    TT_ATL_UART0_IRQ = 38,
+    TT_ATL_UART1_IRQ = 39,
+    TT_ATL_UART2_IRQ = 40,
+    TT_ATL_UART3_IRQ = 41,
+    TT_ATL_UART4_IRQ = 42,
+};
+
+enum {
+    TT_ATL_ACLINT,
+    TT_ATL_BOOTROM,
+    TT_ATL_DDR_LO,
+    TT_ATL_DDR_HI,
+    TT_ATL_FW_CFG,
+    TT_ATL_I2C0,
+    TT_ATL_MAPLIC,
+    TT_ATL_MIMSIC,
+    TT_ATL_SAPLIC,
+    TT_ATL_SIMSIC,
+    TT_ATL_SYSCON,
+    TT_ATL_TIMER,
+    TT_ATL_UART0,
+    TT_ATL_WDT0,
+};
+
+#endif
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
new file mode 100644
index 000000000000..5b66d7e95bb9
--- /dev/null
+++ b/hw/riscv/tt_atlantis.c
@@ -0,0 +1,632 @@
+/*
+ * Tenstorrent Atlantis RISC-V System on Chip
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright 2025 Tenstorrent, Joel Stanley <joel@jms.id.au>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qemu/guest-random.h"
+#include "qemu/units.h"
+
+#include "hw/core/boards.h"
+#include "hw/core/loader.h"
+#include "hw/core/sysbus.h"
+
+#include "target/riscv/cpu.h"
+#include "target/riscv/pmu.h"
+
+#include "hw/riscv/boot.h"
+#include "hw/riscv/numa.h"
+#include "hw/riscv/riscv_hart.h"
+
+#include "hw/char/serial-mm.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/misc/pvpanic.h"
+
+#include "system/system.h"
+#include "system/device_tree.h"
+
+#include "hw/riscv/tt_atlantis.h"
+
+#include "aia.h"
+
+#define TT_IRQCHIP_NUM_MSIS       255
+#define TT_IRQCHIP_NUM_SOURCES    128
+#define TT_IRQCHIP_NUM_PRIO_BITS  3
+#define TT_IRQCHIP_GUESTS         7 /* aia_guests */
+
+#define FDT_PCI_ADDR_CELLS    3
+#define FDT_PCI_INT_CELLS     1
+#define FDT_MAX_INT_CELLS     2
+#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
+                                 1 + FDT_MAX_INT_CELLS)
+
+#define TT_ACLINT_MTIME_SIZE    0x8050
+#define TT_ACLINT_MTIME         0x0
+#define TT_ACLINT_MTIMECMP      0x8000
+#define TT_ACLINT_TIMEBASE_FREQ 1000000000
+
+static const MemMapEntry tt_atlantis_memmap[] = {
+    /* Keep sorted with :'<,'>!sort -g -k 4 */
+    [TT_ATL_DDR_LO] =           { 0x00000000,    0x80000000 },
+    [TT_ATL_BOOTROM] =          { 0x80000000,        0x2000 },
+    [TT_ATL_FW_CFG] =           { 0x80002000,          0xff }, /* qemu only */
+    [TT_ATL_SYSCON] =           { 0x80004000,        0x1000 }, /* qemu only */
+    [TT_ATL_MIMSIC] =           { 0xa0000000,      0x200000 },
+    [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
+    [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
+    [TT_ATL_TIMER] =            { 0xa8020000,       0x10000 },
+    [TT_ATL_WDT0] =             { 0xa8030000,       0x10000 },
+    [TT_ATL_UART0] =            { 0xb0100000,       0x10000 },
+    [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
+    [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
+};
+
+static uint32_t next_phandle(void)
+{
+    static uint32_t phandle = 1;
+    return phandle++;
+}
+
+static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
+{
+    uint32_t cpu_phandle;
+    void *fdt = MACHINE(s)->fdt;
+
+    for (int cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
+        RISCVCPU *cpu_ptr = &s->soc.harts[cpu];
+        g_autofree char *cpu_name = NULL;
+        g_autofree char *intc_name = NULL;
+
+        cpu_phandle = next_phandle();
+
+        cpu_name = g_strdup_printf("/cpus/cpu@%d", s->soc.hartid_base + cpu);
+        qemu_fdt_add_subnode(fdt, cpu_name);
+
+        qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv57");
+
+        riscv_isa_write_fdt(cpu_ptr, fdt, cpu_name);
+
+        qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbom-block-size",
+                cpu_ptr->cfg.cbom_blocksize);
+
+        qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cboz-block-size",
+                cpu_ptr->cfg.cboz_blocksize);
+
+        qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbop-block-size",
+                cpu_ptr->cfg.cbop_blocksize);
+
+        qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+        qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+        qemu_fdt_setprop_cell(fdt, cpu_name, "reg", s->soc.hartid_base + cpu);
+        qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+        qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
+
+        intc_phandles[cpu] = next_phandle();
+
+        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+        qemu_fdt_add_subnode(fdt, intc_name);
+        qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
+                              intc_phandles[cpu]);
+        qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                                "riscv,cpu-intc");
+        qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+        qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+    }
+}
+
+static void create_fdt_memory_node(TTAtlantisState *s,
+                                   hwaddr addr, hwaddr size)
+{
+    void *fdt = MACHINE(s)->fdt;
+    g_autofree char *name = g_strdup_printf("/memory@%"HWADDR_PRIX, addr);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
+}
+
+static void create_fdt_memory(TTAtlantisState *s)
+{
+    hwaddr size_lo = MACHINE(s)->ram_size;
+    hwaddr size_hi = 0;
+
+    if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
+        size_lo = s->memmap[TT_ATL_DDR_LO].size;
+        size_hi = MACHINE(s)->ram_size - size_lo;
+    }
+
+    create_fdt_memory_node(s, s->memmap[TT_ATL_DDR_LO].base, size_lo);
+    if (size_hi) {
+        /*
+         * The first part of the HI address is aliased at the LO address
+         * so do not include that as usable memory. Is there any way
+         * (or good reason) to describe that aliasing 2GB with DT?
+         */
+        create_fdt_memory_node(s, s->memmap[TT_ATL_DDR_HI].base + size_lo,
+                               size_hi);
+    }
+}
+
+static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
+{
+    void *fdt = MACHINE(s)->fdt;
+    g_autofree char *name = NULL;
+    g_autofree uint32_t *aclint_mtimer_cells = NULL;
+    uint32_t aclint_cells_size;
+    hwaddr addr;
+
+    aclint_mtimer_cells = g_new0(uint32_t, s->soc.num_harts * 2);
+
+    for (int cpu = 0; cpu < s->soc.num_harts; cpu++) {
+        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
+    }
+    aclint_cells_size = s->soc.num_harts * sizeof(uint32_t) * 2;
+
+    addr = s->memmap[TT_ATL_ACLINT].base;
+
+    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIX, addr);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mtimer");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, addr + TT_ACLINT_MTIME,
+                                 2, 0x1000,
+                                 2, addr + TT_ACLINT_MTIMECMP,
+                                 2, 0x1000);
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     aclint_mtimer_cells, aclint_cells_size);
+}
+
+static void create_fdt_one_imsic(void *fdt, const MemMapEntry *mem, int cpus,
+                                 uint32_t *intc_phandles, uint32_t msi_phandle,
+                                 int irq_line, uint32_t imsic_guest_bits)
+{
+    g_autofree char *name = NULL;
+    g_autofree uint32_t *imsic_cells = g_new0(uint32_t, cpus * 2);
+
+    for (int cpu = 0; cpu < cpus; cpu++) {
+        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        imsic_cells[cpu * 2 + 1] = cpu_to_be32(irq_line);
+    }
+
+    name = g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIX, mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,imsics");
+
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
+    qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, name, "msi-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     imsic_cells, sizeof(uint32_t) * cpus * 2);
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "riscv,num-ids", TT_IRQCHIP_NUM_MSIS);
+
+    if (imsic_guest_bits) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,guest-index-bits",
+                              imsic_guest_bits);
+    }
+    qemu_fdt_setprop_cell(fdt, name, "phandle", msi_phandle);
+}
+
+static void create_fdt_one_aplic(void *fdt,
+                                 const MemMapEntry *mem,
+                                 uint32_t msi_phandle,
+                                 uint32_t *intc_phandles,
+                                 uint32_t aplic_phandle,
+                                 uint32_t aplic_child_phandle,
+                                 int irq_line, int num_harts)
+{
+    g_autofree char *name =
+        g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIX, mem->base);
+    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
+
+    for (int cpu = 0; cpu < num_harts; cpu++) {
+        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aplic_cells[cpu * 2 + 1] = cpu_to_be32(irq_line);
+    }
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aplic");
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 2);
+    qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
+
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     aplic_cells, num_harts * sizeof(uint32_t) * 2);
+    qemu_fdt_setprop_cell(fdt, name, "msi-parent", msi_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "riscv,num-sources",
+                          TT_IRQCHIP_NUM_SOURCES);
+
+    if (aplic_child_phandle) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,children",
+                              aplic_child_phandle);
+        qemu_fdt_setprop_cells(fdt, name, "riscv,delegation",
+                               aplic_child_phandle, 1, TT_IRQCHIP_NUM_SOURCES);
+    }
+
+    qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
+}
+
+static void create_fdt_pmu(TTAtlantisState *s)
+{
+    g_autofree char *pmu_name = g_strdup_printf("/pmu");
+    void *fdt = MACHINE(s)->fdt;
+    RISCVCPU *hart = &s->soc.harts[0];
+
+    qemu_fdt_add_subnode(fdt, pmu_name);
+    qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
+    riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
+}
+
+static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
+                           uint32_t aplic_s_phandle,
+                           uint32_t imsic_s_phandle)
+{
+    MachineState *ms = MACHINE(s);
+    void *fdt = MACHINE(s)->fdt;
+    g_autofree uint32_t *intc_phandles = NULL;
+
+    qemu_fdt_add_subnode(fdt, "/cpus");
+    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
+                          TT_ACLINT_TIMEBASE_FREQ);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+
+    intc_phandles = g_new0(uint32_t, ms->smp.cpus);
+
+    create_fdt_cpus(s, intc_phandles);
+
+    create_fdt_memory(s);
+
+    create_fdt_aclint(s, intc_phandles);
+
+    /* M-level IMSIC node */
+    uint32_t msi_m_phandle = next_phandle();
+    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
+                         intc_phandles, msi_m_phandle,
+                         IRQ_M_EXT, 0);
+
+    /* S-level IMSIC node */
+    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
+                         intc_phandles, imsic_s_phandle,
+                         IRQ_S_EXT, imsic_num_bits(TT_IRQCHIP_GUESTS + 1));
+
+    uint32_t aplic_m_phandle = next_phandle();
+
+    /* M-level APLIC node */
+    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
+                         msi_m_phandle, intc_phandles,
+                         aplic_m_phandle, aplic_s_phandle,
+                         IRQ_M_EXT, s->soc.num_harts);
+
+    /* S-level APLIC node */
+    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
+                         imsic_s_phandle, intc_phandles,
+                         aplic_s_phandle, 0,
+                         IRQ_S_EXT, s->soc.num_harts);
+}
+
+static void create_fdt_reset(void *fdt, const MemMapEntry *mem)
+{
+    uint32_t syscon_phandle = next_phandle();
+    char *name;
+
+    name = g_strdup_printf("/soc/syscon@%"HWADDR_PRIX, mem->base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", syscon_phandle);
+    g_free(name);
+
+    name = g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", PVPANIC_SHUTDOWN);
+    g_free(name);
+}
+
+static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
+                            int irqchip_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
+                                            mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
+    qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
+
+    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
+}
+
+static void create_fdt_fw_cfg(void *fdt, const MemMapEntry *mem)
+{
+    g_autofree char *name = g_strdup_printf("/fw-cfg@%"HWADDR_PRIX, mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "qemu,fw-cfg-mmio");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
+}
+
+static void finalize_fdt(TTAtlantisState *s)
+{
+    uint32_t aplic_s_phandle = next_phandle();
+    uint32_t imsic_s_phandle = next_phandle();
+    void *fdt = MACHINE(s)->fdt;
+
+    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
+
+    /*
+     * We want to do this, but the Linux aplic driver was broken before v6.16
+     *
+     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-parent",
+     *                       aplic_s_phandle);
+     */
+
+    create_fdt_reset(fdt, &s->memmap[TT_ATL_SYSCON]);
+
+    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
+                    aplic_s_phandle);
+}
+
+static void create_fdt(TTAtlantisState *s)
+{
+    MachineState *ms = MACHINE(s);
+    uint8_t rng_seed[32];
+    g_autofree char *name = NULL;
+    void *fdt;
+
+    fdt = create_device_tree(&s->fdt_size);
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+    ms->fdt = fdt;
+
+    qemu_fdt_setprop_string(fdt, "/", "model",
+                            "Tenstorrent Atlantis RISC-V Machine");
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "tenstorrent,atlantis");
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+
+    qemu_fdt_add_subnode(fdt, "/chosen");
+
+    /* Pass seed to RNG */
+    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
+
+    qemu_fdt_add_subnode(fdt, "/aliases");
+
+    create_fdt_fw_cfg(fdt, &s->memmap[TT_ATL_FW_CFG]);
+    create_fdt_pmu(s);
+}
+
+static DeviceState *create_reboot_device(const MemMapEntry *mem)
+{
+    DeviceState *dev = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    qdev_prop_set_uint32(dev, "events", PVPANIC_SHUTDOWN | PVPANIC_PANICKED);
+
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map(sbd, 0, mem->base);
+
+    return dev;
+}
+
+static FWCfgState *create_fw_cfg(const MemMapEntry *mem, int num_cpus)
+{
+    FWCfgState *fw_cfg;
+    hwaddr base = mem->base;
+
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
+                                 &address_space_memory);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, num_cpus);
+
+    return fw_cfg;
+}
+
+static void tt_atlantis_machine_done(Notifier *notifier, void *data)
+{
+    TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
+    MachineState *machine = MACHINE(s);
+    hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
+    hwaddr mem_size;
+    target_ulong firmware_end_addr, kernel_start_addr;
+    const char *firmware_name = riscv_default_firmware_name(&s->soc);
+    uint64_t fdt_load_addr;
+    uint64_t kernel_entry;
+    RISCVBootInfo boot_info;
+
+    /*
+     * A user provided dtb must include everything, including
+     * dynamic sysbus devices. Our FDT needs to be finalized.
+     */
+    if (machine->dtb == NULL) {
+        finalize_fdt(s);
+    }
+
+    mem_size = machine->ram_size;
+    if (mem_size > s->memmap[TT_ATL_DDR_LO].size) {
+        mem_size = s->memmap[TT_ATL_DDR_LO].size;
+    }
+    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc,
+                                       s->memmap[TT_ATL_DDR_LO].base,
+                                       mem_size);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
+                                                     &start_addr, NULL);
+
+    kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                     firmware_end_addr);
+    if (machine->kernel_filename) {
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+    } else {
+        riscv_setup_halting_payload(&boot_info, kernel_start_addr);
+    }
+    kernel_entry = boot_info.image_low_addr;
+
+    fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
+                                           s->memmap[TT_ATL_DDR_LO].size,
+                                           machine, &boot_info);
+    riscv_load_fdt(fdt_load_addr, machine->fdt);
+
+    /* load the reset vector */
+    riscv_setup_rom_reset_vec(machine, &s->soc, start_addr,
+                              s->memmap[TT_ATL_BOOTROM].base,
+                              s->memmap[TT_ATL_BOOTROM].size,
+                              kernel_entry,
+                              fdt_load_addr);
+
+}
+
+static void tt_atlantis_machine_init(MachineState *machine)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
+
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
+    MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
+    MemoryRegion *bootrom = g_new(MemoryRegion, 1);
+    ram_addr_t lo_ram_size, hi_ram_size;
+    int hart_count = machine->smp.cpus;
+    int base_hartid = 0;
+
+    s->memmap = tt_atlantis_memmap;
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_HART_ARRAY);
+    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "hartid-base", base_hartid,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "num-harts", hart_count,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "resetvec",
+                            s->memmap[TT_ATL_BOOTROM].base,
+                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+
+    s->irqchip = riscv_create_aia(true, TT_IRQCHIP_GUESTS,
+                                  TT_IRQCHIP_NUM_SOURCES,
+                                  &s->memmap[TT_ATL_MAPLIC],
+                                  &s->memmap[TT_ATL_SAPLIC],
+                                  &s->memmap[TT_ATL_MIMSIC],
+                                  &s->memmap[TT_ATL_SIMSIC],
+                                  0, base_hartid, hart_count,
+                                  TT_IRQCHIP_NUM_MSIS,
+                                  TT_IRQCHIP_NUM_PRIO_BITS);
+
+    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
+            TT_ACLINT_MTIME_SIZE,
+            base_hartid, hart_count,
+            TT_ACLINT_MTIMECMP,
+            TT_ACLINT_MTIME,
+            TT_ACLINT_TIMEBASE_FREQ, true);
+
+    /* DDR */
+
+    /* The high address covers all of RAM, the low address just the first 2GB */
+    lo_ram_size = s->memmap[TT_ATL_DDR_LO].size;
+    hi_ram_size = s->memmap[TT_ATL_DDR_HI].size;
+    if (machine->ram_size > hi_ram_size) {
+        char *sz = size_to_str(hi_ram_size);
+        error_report("RAM size is too large, maximum is %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
+                             0, lo_ram_size);
+    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
+                             0, hi_ram_size);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_DDR_LO].base, ram_lo);
+    memory_region_add_subregion(system_memory,
+                                s->memmap[TT_ATL_DDR_HI].base, ram_hi);
+
+    /* Boot ROM */
+    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
+                           s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, s->memmap[TT_ATL_BOOTROM].base,
+                                bootrom);
+
+    /*
+     * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
+     * device tree cannot be altered and we get FDT_ERR_NOSPACE.
+     */
+    s->fw_cfg = create_fw_cfg(&s->memmap[TT_ATL_FW_CFG], machine->smp.cpus);
+    rom_set_fw(s->fw_cfg);
+
+    /* Reboot and exit */
+    create_reboot_device(&s->memmap[TT_ATL_SYSCON]);
+
+    /* UART */
+    serial_mm_init(system_memory, s->memmap[TT_ATL_UART0].base, 2,
+                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ),
+                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* Load or create device tree */
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
+        if (!machine->fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+    } else {
+        create_fdt(s);
+    }
+
+    s->machine_done.notify = tt_atlantis_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Tenstorrent Atlantis RISC-V SoC";
+    mc->init = tt_atlantis_machine_init;
+    mc->max_cpus = 8;
+    mc->default_cpus = 8;
+    mc->default_ram_size = 2 * GiB;
+    mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
+    mc->block_default_type = IF_VIRTIO;
+    mc->no_cdrom = 1;
+    mc->default_ram_id = "tt_atlantis.ram";
+}
+
+static const TypeInfo tt_atlantis_types[] = {
+    {
+        .name       = MACHINE_TYPE_NAME("tt-atlantis"),
+        .parent     = TYPE_MACHINE,
+        .class_init = tt_atlantis_machine_class_init,
+        .instance_size = sizeof(TTAtlantisState),
+    },
+};
+
+DEFINE_TYPES(tt_atlantis_types)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0222c93f878b..0601ae1a7494 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -120,6 +120,21 @@ config SPIKE
     select RISCV_ACLINT
     select SIFIVE_PLIC
 
+config TENSTORRENT
+    bool
+    default y
+    depends on RISCV64
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select DEVICE_TREE
+    select RISCV_NUMA
+    select PVPANIC_MMIO
+    select SERIAL_MM
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select FW_CFG_DMA
+
 config XIANGSHAN_KUNMINGHU
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index e53c180d0d10..026e79591f4b 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -9,6 +9,7 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
+riscv_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
-- 
2.47.3


