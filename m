Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3362DC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMT-0001ac-Fu; Tue, 18 Jun 2024 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMM-0000ZR-2N
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMJ-0007qe-Tr
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42108856c33so41031105e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726817; x=1719331617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdyOIVb0kwKldvxXufDtNTljWmLNSVsoqAXvT0XU1zs=;
 b=QV2SMnwkbqvLOU0cMEnRZf1RrdKfoDXzUX+utuWZXVEDhGExHLIS6cDe3xV0h9P/iO
 XeWJLdCRkJi6cuc+OQOjjqckGxvLtUIe2p23vAM4sY9GD2q2FrEFb+2Utxw/qRhUiGPp
 6jy9eotntk9IpyhYnm1HRJ1MPBNEgWk3PbNxoWrYCV2leR3dZXllphkhd1gqThwGWGAl
 PVfWmpNJqmw9KIIQhHoyUQqt8oWKmcITMJPTZUkPXizHe0I3UZ4TzgSVYnYM1nUZCdho
 7qEkN8mpdKNIbnuZ5pIjtEocA3I4Dv4ehdzt3YiQ8FuTHzPc2v+lcpCyHsR/di0xbMgb
 glRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726817; x=1719331617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdyOIVb0kwKldvxXufDtNTljWmLNSVsoqAXvT0XU1zs=;
 b=ekf8vBvSwt/vhw8GSlaiTCu2pDMplMQEzsqBkHuWv1TQaHoeft8IWhmBzOI8moaLmS
 NUlhQ315cWVil5R6HV/TVRRk9J8dax3qXfZ26ipcJC/Ehs1V6X6cTAm5fSCGBWgU1Pmr
 /vPVGlaxBjKMFObxE6nuvTd696yRqblD1kvLeHFAcddruu/p8//3EnWI9oJyNQZA1Uph
 lNocO4UKUOg+jApZrBKoLOq1PV5f/wgSD5nkKeo/qwNeC/sr+hQw/0LWz6hacCusZ8ua
 OhGpSaUhQVkuSudy6i95HmZ7sOMzhh9Ez9hcH3tI6W7rU0Mvz/cb4JsbAtlwAUTSJVKG
 eqcQ==
X-Gm-Message-State: AOJu0YxaiLI3QqmKDdg5PRQLIBgss1Uo6OqZiw/O4AGBBgsVnXK+yz6Z
 UAbECklgCIAlJNm9PYmmGj675AouNVjd7QLROfhykrdGfOKKNii6/Z/o9evq5PPTEz45Tx0rcNc
 b
X-Google-Smtp-Source: AGHT+IFibVDKmiDkSMlmxr8f4oxJe9zgYyeONm/UmO4LMRhmXkS+PKP6NS9heNVlyyH9gsQX4Obtgw==
X-Received: by 2002:adf:fa81:0:b0:362:8f0f:1c7c with SMTP id
 ffacd0b85a97d-3630191cb58mr322903f8f.33.1718726817413; 
 Tue, 18 Jun 2024 09:06:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3631488c450sm49823f8f.60.2024.06.18.09.06.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 65/76] hw/mips/loongson3_virt: Wire up loongson_ipi device
Date: Tue, 18 Jun 2024 18:00:27 +0200
Message-ID: <20240618160039.36108-66-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Wire up loongson_ipi device for loongson3_virt machine, so we
can have SMP support for TCG backend as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240605-loongson3-ipi-v3-3-ddd2c0e03fa3@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_bootp.h |  3 +++
 hw/mips/loongson3_bootp.c |  2 --
 hw/mips/loongson3_virt.c  | 39 +++++++++++++++++++++++++++++++++++++--
 hw/mips/Kconfig           |  1 +
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index 1b0dd3b591..9091265df7 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -200,6 +200,8 @@ struct boot_params {
     struct efi_reset_system_t reset_system;
 };
 
+#define LOONGSON3_CORE_PER_NODE 4
+
 /* Overall MMIO & Memory layout */
 enum {
     VIRT_LOWMEM,
@@ -211,6 +213,7 @@ enum {
     VIRT_BIOS_ROM,
     VIRT_UART,
     VIRT_LIOINTC,
+    VIRT_IPI,
     VIRT_PCIE_MMIO,
     VIRT_HIGHMEM
 };
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 03a10b63c1..b97b81903b 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -25,8 +25,6 @@
 #include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
 
-#define LOONGSON3_CORE_PER_NODE 4
-
 static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 440268a074..4ad36f0c5b 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -36,6 +36,7 @@
 #include "hw/mips/loongson3_bootp.h"
 #include "hw/misc/unimp.h"
 #include "hw/intc/i8259.h"
+#include "hw/intc/loongson_ipi.h"
 #include "hw/loader.h"
 #include "hw/isa/superio.h"
 #include "hw/pci/msi.h"
@@ -74,6 +75,7 @@ const MemMapEntry virt_memmap[] = {
     [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
     [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
     [VIRT_UART] =        { 0x1fe001e0,           0x8 },
+    [VIRT_IPI] =         { 0x3ff01000,         0x400 },
     [VIRT_LIOINTC] =     { 0x3ff01400,          0x64 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_HIGHMEM] =     { 0x80000000,           0x0 }, /* Variable */
@@ -485,6 +487,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     Clock *cpuclk;
     CPUMIPSState *env;
     DeviceState *liointc;
+    DeviceState *ipi = NULL;
     char *filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *kernel_filename = machine->kernel_filename;
@@ -494,6 +497,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
+    MemoryRegion *iocsr = g_new(MemoryRegion, 1);
 
     /* TODO: TCG will support all CPU types */
     if (!kvm_enabled()) {
@@ -527,6 +531,19 @@ static void mips_loongson3_virt_init(MachineState *machine)
     create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * MiB);
     create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * MiB);
 
+    memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
+
+    /* IPI controller is in kernel for KVM */
+    if (!kvm_enabled()) {
+        ipi = qdev_new(TYPE_LOONGSON_IPI);
+        qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+        memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
+        memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
+    }
+
     liointc = qdev_new("loongson.liointc");
     sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
 
@@ -543,6 +560,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
     for (i = 0; i < machine->smp.cpus; i++) {
+        int node = i / LOONGSON3_CORE_PER_NODE;
+        int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
 
         /* init CPUs */
@@ -553,12 +572,28 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
-        if (i >= 4) {
+        if (ipi) {
+            hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
+            base += core * 0x100;
+            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
+            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
+        }
+
+        if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
+            MemoryRegion *core_iocsr = g_new(MemoryRegion, 1);
+            g_autofree char *name = g_strdup_printf("core%d_iocsr", i);
+            memory_region_init_alias(core_iocsr, OBJECT(cpu), name,
+                                     iocsr, 0, UINT32_MAX);
+            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
+                                        0, core_iocsr);
+        }
+
+        if (node > 0) {
             continue; /* Only node-0 can be connected to LIOINTC */
         }
 
         for (ip = 0; ip < 4 ; ip++) {
-            int pin = i * 4 + ip;
+            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
             sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
                                pin, cpu->env.irq[ip + 2]);
         }
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index a7f26edebe..692bede538 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -67,6 +67,7 @@ config LOONGSON3V
     imply USB_OHCI_PCI
     select SERIAL
     select GOLDFISH_RTC
+    select LOONGSON_IPI
     select LOONGSON_LIOINTC
     select PCI_EXPRESS_GENERIC_BRIDGE
     select MSI_NONBROKEN
-- 
2.41.0


