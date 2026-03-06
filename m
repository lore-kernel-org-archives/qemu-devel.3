Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34600FCC05D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyaTV-00058t-GO; Fri, 06 Mar 2026 14:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyaTS-00058X-GF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:04:34 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyaTO-0001ex-A3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:04:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so1205255e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772823868; x=1773428668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VzhIZPxk//VX1ktJTYRZ47iapQxAY1fuSLVGdAwm/Ko=;
 b=Dq9X9rM039Cljq+dq4vD4iGt944ArDa61T3F7lXUXPEn7f2gEZHe6bTu3xumPJseeb
 AWQ0yVLKWBGHq62R63fsJ3Smp3FUEHaIUwVRXBoInuA9thqYK+gl1tR7KWuv8Ou/sdF3
 FWoZZquzyEA9T2zn5dv7bcGfENJo22cEJ6mD/vVpB35xP6aEXiwILTKcLtY0PZ+pDt4s
 sLNxpRJ8daByAezC6u7UAnqZQp0TXjKFQwXnt4TnRvRkAl/P9rzxuSsonXK6TuSFXTKn
 aof0YU5uJ6zTSa0cj4ir9Omqfz5eLT1PgC82Z239QFkMzRXWlUPhiuKoX65xYVKNMoy0
 TfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823868; x=1773428668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzhIZPxk//VX1ktJTYRZ47iapQxAY1fuSLVGdAwm/Ko=;
 b=vfirIrStDyqwD2QqhxnpO8Iua6VbEHV8Hy416QeQ6thPIZBBBj2p3Y42EDfJWSVi5A
 IxmHS+Z+Cib1JJ4Qh7F9Rl58XGkfCndMu+BRP6qSRzk/1ZlEoGGzDwA2hiLgu2ZFQ+hB
 B/+tl8isVsVSRJua0YSDM/XfKDeTPVhLaPrwLJhLYLJaMFxUwBaG++3la+FQbtkdoOJy
 FMLhRRlFF0n75yVxmR0OKQG61bB7x5RZ+zo10NY6Yne5m8VZ0FucUrlYaDOxEM/miSmp
 AGdAKD3KqP5cPMhVgHCNe+wCHRc+bK9H+jCJ+gXVkAtZ5rApdAIYMbpDh0SltgllPcB/
 CyCQ==
X-Gm-Message-State: AOJu0Yx0fpeUwJ5o3pvoomlMtEk7ORpzb5+qjiFrJJJiURqwWz7Tnn1g
 NSgkBzESb07D74r2VjxYaJxj051ypVpjbdv1Vn+i/eGY0YkS2IOS0iSIeAFsuSlcfaskkECr9Q8
 pgJE8
X-Gm-Gg: ATEYQzxMoqb7bAL+Y+CEjTmlqsP5W7+tJ3f9T4NWZa7jaCRKSOag17qiG9jbMYiFHvO
 vz9x7BFEhoMJmNGabt3EmHWpIq1ghZau+ipqz7+MRL8vwpDJIz37M7ajMQwHtjFqfmOzd8tRgtE
 +hKqg5rToEjycsy2xMs/EpCKJSfKK0pGPJ/z9URB56/BMNSvahIP/xUkI5r4MF7UTS9Ojz5RkIc
 MyQXpEqAc6JG7/3/ELiQBMpuImsvLYM1BQdZ0PyMzW1UI18YknquQYZuYeq/4arMtTNyKMF9B7w
 +DdiEOFeORAoBs7RlWHR47s2yEV9CIsEuhOwVWmxlI9jxrnzNBWiKVWqH3bIl9tjcYi29L/ORTB
 GNOq6YmAnYzgcRgMNQPgDDmbfHq9U36kRv8eOD/o2RqrldyuBWDNhYv5tUP2z4N9u1iSxPy0p6g
 dPjh6DpoeNzMu+7pR8qC/PnRzmtnn3oj+YS0GZ4L7odkikvthBcPaxmQCr3ukA8NWc/T1Z++5N7
 i960TA++S+qYq9/RWuosoi/PlEhcZ4=
X-Received: by 2002:a05:600c:4451:b0:483:71f9:37ef with SMTP id
 5b1f17b1804b1-48526923bf0mr54072415e9.8.1772823867753; 
 Fri, 06 Mar 2026 11:04:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48529f019a4sm9195915e9.12.2026.03.06.11.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:04:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>
Subject: [PATCH] hw/m68k/mcf_intc: Use qdev input gpios for input IRQs
Date: Fri,  6 Mar 2026 19:04:25 +0000
Message-ID: <20260306190425.3047580-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The m68k mcf_intc interrupt controller currently implements its
inbound IRQ lines by calling qemu_allocate_irqs() in mcf_intc_init().
This results in leaks like this:

Direct leak of 2944 byte(s) in 46 object(s) allocated from:
    #0 0x5cf95ec15323 in malloc (/home/pm215/qemu/build/san/qemu-system-m68k+0xf9e323) (BuildId: 18d55ef8ea9856e68ee30802078af5050b8b06c5)
    #1 0x7637c65c5ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5cf95f6b2f27 in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:767:15
    #3 0x5cf95f6aa62e in qemu_allocate_irq /home/pm215/qemu/build/san/../../hw/core/irq.c:91:25
    #4 0x5cf95f6aa62e in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:79:16
    #5 0x5cf95f5f6d99 in mcf5208evb_init /home/pm215/qemu/build/san/../../hw/m68k/mcf5208.c:310:11

This isn't an important leak, as it is memory we allocate once at
QEMU startup and that has to stay live for the lifetime of the
system.  However it does point at a code improvement.

Modernise this to have the device itself create inbound GPIOs with
qdev_init_gpio_in() that the board can then refer to and wire up
individually.

As the device is used in only a single board, we can update device
and board in a single patch rather than having to try to figure out
some way to change the API more piecemeal.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
there's quite a bit more in this board which could be
modernised, but I stuck to just the thing getting reported
as a memory leak...
---
 hw/m68k/mcf5208.c     | 24 +++++++++++-------------
 hw/m68k/mcf_intc.c    |  8 +++-----
 include/hw/m68k/mcf.h |  5 ++---
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index c6d1c5fae9..0e07aa45e9 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -227,7 +227,7 @@ static const MemoryRegionOps m5208_rcm_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
+static void mcf5208_sys_init(MemoryRegion *address_space, DeviceState *intc,
                              M68kCPU *cpu)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
@@ -250,11 +250,11 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
                               "m5208-timer", 0x00004000);
         memory_region_add_subregion(address_space, 0xfc080000 + 0x4000 * i,
                                     &s->iomem);
-        s->irq = pic[4 + i];
+        s->irq = qdev_get_gpio_in(intc, 4 + i);
     }
 }
 
-static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, qemu_irq *irqs)
+static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, DeviceState *intc)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -268,7 +268,7 @@ static void mcf_fec_init(MemoryRegion *sysmem, hwaddr base, qemu_irq *irqs)
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     for (i = 0; i < FEC_NUM_IRQ; i++) {
-        sysbus_connect_irq(s, i, irqs[i]);
+        sysbus_connect_irq(s, i, qdev_get_gpio_in(intc, i + 36));
     }
 
     memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
@@ -283,10 +283,10 @@ static void mcf5208evb_init(MachineState *machine)
     int kernel_size;
     uint64_t elf_entry;
     hwaddr entry;
-    qemu_irq *pic;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *rom = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
+    DeviceState *intc;
 
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -307,17 +307,15 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x80000000, sram);
 
     /* Internal peripherals.  */
-    pic = mcf_intc_init(address_space_mem, 0xfc048000, cpu);
+    intc = mcf_intc_init(address_space_mem, 0xfc048000, cpu);
 
-    mcf_uart_create_mmap(0xfc060000, pic[26], serial_hd(0));
-    mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
-    mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
+    mcf_uart_create_mmap(0xfc060000, qdev_get_gpio_in(intc, 26), serial_hd(0));
+    mcf_uart_create_mmap(0xfc064000, qdev_get_gpio_in(intc, 27), serial_hd(1));
+    mcf_uart_create_mmap(0xfc068000, qdev_get_gpio_in(intc, 28), serial_hd(2));
 
-    mcf5208_sys_init(address_space_mem, pic, cpu);
+    mcf5208_sys_init(address_space_mem, intc, cpu);
 
-    mcf_fec_init(address_space_mem, 0xfc030000, pic + 36);
-
-    g_free(pic);
+    mcf_fec_init(address_space_mem, 0xfc030000, intc);
 
     /*  0xfc000000 SCM.  */
     /*  0xfc004000 XBS.  */
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 20112c94be..1014fe6fa5 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -175,6 +175,7 @@ static void mcf_intc_instance_init(Object *obj)
 
     memory_region_init_io(&s->iomem, obj, &mcf_intc_ops, s, "mcf", 0x100);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    qdev_init_gpio_in(DEVICE(s), mcf_intc_set_irq, 64);
 }
 
 static const Property mcf_intc_properties[] = {
@@ -206,9 +207,7 @@ static void mcf_intc_register_types(void)
 
 type_init(mcf_intc_register_types)
 
-qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
-                        hwaddr base,
-                        M68kCPU *cpu)
+DeviceState *mcf_intc_init(MemoryRegion *sysmem, hwaddr base, M68kCPU *cpu)
 {
     DeviceState  *dev;
 
@@ -218,6 +217,5 @@ qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
-
-    return qemu_allocate_irqs(mcf_intc_set_irq, dev, 64);
+    return dev;
 }
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 5d9f876ffe..b2a599adaa 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -14,9 +14,8 @@ DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chr);
 DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *chr);
 
 /* mcf_intc.c */
-qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
-                        hwaddr base,
-                        M68kCPU *cpu);
+DeviceState *mcf_intc_init(struct MemoryRegion *sysmem,
+                           hwaddr base, M68kCPU *cpu);
 
 /* mcf5206.c */
 #define TYPE_MCF5206_MBAR "mcf5206-mbar"
-- 
2.43.0


