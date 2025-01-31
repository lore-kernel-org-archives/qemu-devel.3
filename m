Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76233C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDv-00082o-MH; Fri, 31 Jan 2025 16:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDt-0007q5-Je
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDr-0007t7-PC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283dedso24845715e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357602; x=1738962402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mP3QyIe81tPdRVqVU2heOfv/G9r7fIu1+pBAt75OnDs=;
 b=tENHfI9d/HRmuDYvg4470ecv26GrQ6il/wsSBVFoPlCTJ4GdJvH4uqLjsbPSYPHDy8
 7qL3vVgumyxh/ql398oo5CuD1StcxpLFcNk6jVHNRiyyD3v9Yw2crwoxqA2cQlfsA7tX
 j4ZegJjRIkQQ3W01oqFC8YqUi50kVRH6ChDRtcKjH++CJdlbIRFDRHTb28ymiGnACtIv
 ROfHv5TUYYHBZgJRvIjEhgtjcn8+lzOgSzrB7kUIgmJW69cHyMdAtQI/jnrW5jTjaFyv
 YACJC7drMl8wEKqtKKIlcMeW0/KihLhDI+GRJ8EYXxJ8bDk6dtmlI+hE9yqQgGF4fycE
 xWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357602; x=1738962402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mP3QyIe81tPdRVqVU2heOfv/G9r7fIu1+pBAt75OnDs=;
 b=bgbiBDz5Jy7oxin88h04b1SLJiBCcKngUtlSOGglu8qgO9RTaHdlROuzAf3oDvDhjF
 r4qMz/nB8EyML6kVi+8sn4cUUDwlHk25XFf+eHPO94vk0ex9V5mXYq/Tzb7WElf3eArt
 3jTeosLqhFY4rFNhzBIi+2XOmnifSCJQsehDzAh+x0jaB/q4Lk3H5VnOmPL9Oopz5RJN
 MNkJmq3A+QSDtnCF2HMB1l13xXUdn7EP476bLRVyjaGOLXKSMQ0DCSSqFe/+BwkV/MEs
 V7iRqOYJdxxQoR9fNW51ktWBjW5O20RlOzbTpb++HQ+lvRVwA6kGnRwsVZpp1BIN5SOK
 9B3A==
X-Gm-Message-State: AOJu0Ywuvrh68rxqnSN8KRZhD1gEbAiw+DDzkf6BHTWUgl6yDeznLG9r
 2AKJMGXFJxx54DWxjQbtwYZ72ZqCxXq+By3Z/AG5dTE9E3kgvv2X7Z+923Jhe9cZw9AEfooBEoC
 bJNo=
X-Gm-Gg: ASbGnctcnc8bjWk9FfL22vP/zis42+ak9bTtdq9KAlz2AGnHIZ71Nj3i6eXvhCpqG/6
 i4KhRMnmv9YzVWGrFCABhdzsx6HGXwFTNUGyN1ex+RTKowXQoYc9Ol65uOmWHDkS8w8nadCXDYu
 c7kKCKIJMEQtCsLD3LuV9fY0XBtdR7hdA2+Cs6+jFQSeNLDhBXUL+S/lJjVQvm9Hf37FWw94X20
 kj882vnqgpCGGlJobtbrJYh5UBmxM8uKwrt6Ny3x/ztjRDK4PoIKEehJvTWH/ZogetJMCAuAOUr
 +5P/eRHHV8+W8lU8Q07fyQKShHT8BsgD4uBegbYZrgCXQ1eLKvCL7s9iFK/usPSemg==
X-Google-Smtp-Source: AGHT+IHylUD24vD/MV8WvidRNcN8mBde01q6GDOBZ3dPr980AWQWhAt1uZe2I5bG+Yje0BlCEmYncQ==
X-Received: by 2002:a05:600c:5127:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-438dc421393mr119616535e9.29.1738357601798; 
 Fri, 31 Jan 2025 13:06:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42d4sm68667495e9.6.2025.01.31.13.06.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/36] hw/sh4/r2d: Convert legacy qemu_allocate_irqs() to
 qemu_init_irqs()
Date: Fri, 31 Jan 2025 22:04:59 +0100
Message-ID: <20250131210520.85874-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The FPGA exposes a fixed set of IRQs. Hold them in the FPGA
state and initialize them in place calling qemu_init_irqs().

Move r2d_fpga_irq enums earlier so we can use NR_IRQS within
the r2d_fpga_t structure. r2d_fpga_init() returns r2d_fpga_t,
and we dereference irq from it in r2d_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121182445.35309-1-philmd@linaro.org>
---
 hw/sh4/r2d.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 2fa439819e3..d68c94e82ef 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -63,6 +63,12 @@
 #define PA_VERREG 0x32
 #define PA_OUTPORT 0x36
 
+enum r2d_fpga_irq {
+    PCI_INTD, CF_IDE, CF_CD, PCI_INTC, SM501, KEY, RTC_A, RTC_T,
+    SDCARD, PCI_INTA, PCI_INTB, EXT, TP,
+    NR_IRQS
+};
+
 typedef struct {
     uint16_t bcr;
     uint16_t irlmsk;
@@ -88,15 +94,10 @@ typedef struct {
 
 /* output pin */
     qemu_irq irl;
+    IRQState irq[NR_IRQS];
     MemoryRegion iomem;
 } r2d_fpga_t;
 
-enum r2d_fpga_irq {
-    PCI_INTD, CF_IDE, CF_CD, PCI_INTC, SM501, KEY, RTC_A, RTC_T,
-    SDCARD, PCI_INTA, PCI_INTB, EXT, TP,
-    NR_IRQS
-};
-
 static const struct { short irl; uint16_t msk; } irqtab[NR_IRQS] = {
     [CF_IDE] =   {  1, 1 << 9 },
     [CF_CD] =    {  2, 1 << 8 },
@@ -186,8 +187,8 @@ static const MemoryRegionOps r2d_fpga_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
-                               hwaddr base, qemu_irq irl)
+static r2d_fpga_t *r2d_fpga_init(MemoryRegion *sysmem,
+                                 hwaddr base, qemu_irq irl)
 {
     r2d_fpga_t *s;
 
@@ -197,7 +198,10 @@ static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
 
     memory_region_init_io(&s->iomem, NULL, &r2d_fpga_ops, s, "r2d-fpga", 0x40);
     memory_region_add_subregion(sysmem, base, &s->iomem);
-    return qemu_allocate_irqs(r2d_fpga_irq_set, s, NR_IRQS);
+
+    qemu_init_irqs(s->irq, NR_IRQS, r2d_fpga_irq_set, s);
+
+    return s;
 }
 
 typedef struct ResetData {
@@ -239,13 +243,13 @@ static void r2d_init(MachineState *machine)
     ResetData *reset_info;
     struct SH7750State *s;
     MemoryRegion *sdram = g_new(MemoryRegion, 1);
-    qemu_irq *irq;
     DriveInfo *dinfo;
     DeviceState *dev;
     SysBusDevice *busdev;
     MemoryRegion *address_space_mem = get_system_memory();
     PCIBus *pci_bus;
     USBBus *usb_bus;
+    r2d_fpga_t *fpga;
 
     cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -260,7 +264,7 @@ static void r2d_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
     s = sh7750_init(cpu, address_space_mem);
-    irq = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
+    fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
 
     dev = qdev_new("sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
@@ -268,10 +272,10 @@ static void r2d_init(MachineState *machine)
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     sysbus_mmio_map(busdev, 0, P4ADDR(0x1e200000));
     sysbus_mmio_map(busdev, 1, A7ADDR(0x1e200000));
-    sysbus_connect_irq(busdev, 0, irq[PCI_INTA]);
-    sysbus_connect_irq(busdev, 1, irq[PCI_INTB]);
-    sysbus_connect_irq(busdev, 2, irq[PCI_INTC]);
-    sysbus_connect_irq(busdev, 3, irq[PCI_INTD]);
+    sysbus_connect_irq(busdev, 0, &fpga->irq[PCI_INTA]);
+    sysbus_connect_irq(busdev, 1, &fpga->irq[PCI_INTB]);
+    sysbus_connect_irq(busdev, 2, &fpga->irq[PCI_INTC]);
+    sysbus_connect_irq(busdev, 3, &fpga->irq[PCI_INTD]);
 
     dev = qdev_new("sysbus-sm501");
     busdev = SYS_BUS_DEVICE(dev);
@@ -281,13 +285,13 @@ static void r2d_init(MachineState *machine)
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
-    sysbus_connect_irq(busdev, 0, irq[SM501]);
+    sysbus_connect_irq(busdev, 0, &fpga->irq[SM501]);
 
     /* onboard CF (True IDE mode, Master only). */
     dinfo = drive_get(IF_IDE, 0, 0);
     dev = qdev_new("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
+    sysbus_connect_irq(busdev, 0, &fpga->irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x14001000);
-- 
2.47.1


