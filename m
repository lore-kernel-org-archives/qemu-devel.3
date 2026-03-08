Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B222EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMn3-0008Hq-Hb; Sun, 08 Mar 2026 18:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmu-0007p3-8Q
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMms-0003nm-Dc
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so5457625f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009589; x=1773614389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dfw9CRxibqwr6dD4hxl72mLeiLdIqrv6wWNvcJ3zBlo=;
 b=RiXKZZBPG1RGvwhtgzXDWRja5SaOgRj1vsZoljgIsy8Zk+kVajshzKuVU9mp2QxonL
 GBy23+7PjfigA1qCT0SZEmrm2y4jynAtN5ThC2bsFoHXH4StZOgTNGvrFb1j7SI7FzSt
 nSEutcF/DHD9rSRDS3ej3LFNHPcuX8sAPOvVG6zDqg5x7H0hUJXQYjMq3mwfUzZvEt53
 XIneTTTqqZ50Hqonmhpt76+mRMvf/bJgw9pXAfQxor4JbHEVmLyMau3hWrUoB93L44hn
 xhuzcKe4BSuFufblsnddGU/Ub8HEdJwaCvGXEghp9W+hQ5HcigiCJjsdNJl04UDafXLu
 WoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009589; x=1773614389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dfw9CRxibqwr6dD4hxl72mLeiLdIqrv6wWNvcJ3zBlo=;
 b=c0JBYELhPqlNv3M/6YWNHQAxbeQhIZhRXN74pIl87iQbS7k78sUfvkLWhhQTHjCQa4
 tX4sDMNjwOhFAJQztxPvn60rICNfnjomid2MVcULkmx1XekPWUM0eKk3/zckdVVu6ogE
 4oRTPsKwGuWPu76yG72+LHIKrzglQRUqXahF/KL2OLZDjP6DgI/+FfPnnN0wQk48u4gW
 rrEe00qiNBtW2YsUFVeWYemUPjkkGkGguHNOAgllNIuUV29lmRwlhmvQeHJ5V0E29cKQ
 LEV4dGARF20JpMnw+wHbguDEdQMNLYqHZ1GssNwYwbL3hwdPENCaE4nl3Zy/ig+raoeW
 RjjQ==
X-Gm-Message-State: AOJu0YwKQ7UFJYdBp3QgkvDfNWT+yLalqQkduJkPMCx5+0Bo4Oxt9fC7
 mbQOxNFxnEIkAnHOU2oET6Tg5S6e7K/OvksS9DYa+s6uq5YKUQ0p3kEVlWfCatlsvKWvayCP7yH
 0KEeH4kQ=
X-Gm-Gg: ATEYQzxc+i5dyy+RqPRP28dYsqpSHczYbCslBBt2qCZC72IvP9ovsV8D4ylsg7IeEFK
 KyF0kLkcEPQVtGPcHvq4vl4t0Xc6PD//1ZHtAOoV7hNpubdYaYjAvGzCskANWVKygUkVdd4U/e0
 cMZwi28qxzGonPPZu69LIafGXI3kQYTdq6CQ9vVlv6uEdoCcuIffB3jKxzkgeLkQS3Rgp4swwPQ
 dPEdqEHkh2UDnBl1nukCG5YFkYhlmlDAYQpyPrNr6RFD/wbM4XbYw7hmBziJyjX2U65RjtO3ryp
 uapHVOuc6nL6Gm92jroCjzgqTJdUXdfiVGpjR1awkkwTj/JXVqEke7GLN7aNbEbKfLUxH6lotsC
 R2KkvEzygwqLDKN4e7XfnscLfu+RRMYU/EDsRaKDqq/wbJzBN0u3hJEFtQeb/iiJUuEsdSO5LdX
 sdsYqfM7JLWi7VGbzUyoOIUP/rFipKpTzAYY9b2w1aDtycqHNHweqmVFHnN2pFU4tCMelQ0tFqE
 pkQb9kV+AQOB+jw
X-Received: by 2002:a05:6000:2312:b0:439:c5cf:fc6d with SMTP id
 ffacd0b85a97d-439da348c64mr16592008f8f.4.1773009588566; 
 Sun, 08 Mar 2026 15:39:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm21038760f8f.35.2026.03.08.15.39.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/49] hw/m68k/mcf_intc: Use qdev input gpios for input IRQs
Date: Sun,  8 Mar 2026 23:34:30 +0100
Message-ID: <20260308223433.25503-47-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260306190425.3047580-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/m68k/mcf.h |  5 ++---
 hw/m68k/mcf5208.c     | 24 +++++++++++-------------
 hw/m68k/mcf_intc.c    |  8 +++-----
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 5d9f876ffeb..b2a599adaad 100644
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
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index c6d1c5fae9f..0e07aa45e9d 100644
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
index 20112c94be1..1014fe6fa57 100644
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
-- 
2.53.0


