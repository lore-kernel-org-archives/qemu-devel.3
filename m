Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EB7C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kXa-0002PR-2a; Tue, 29 Apr 2025 08:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXZ-0002P3-1T
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXW-00007v-RT
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso4341623a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931500; x=1746536300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kk7W7DjCSyMwi4lFsEoEOcfFm5Zhop6VnxfXbIaEzIE=;
 b=Ms5rmfeSR7GmFe9X+qvp3LAIkSxx6iafb9KhfJ9U/mz1upB8HQuzlt+I/QYE+Trq5a
 DtLGJm61vx/2Mqdw1Ui9hJ4fO9YzJ+vc1COUNhj7w3keCtEBcFPsYJPzHGWrZWQ/dNIh
 s0JpS0ADGb4zWvXQOZ6sAE40i0/qTKLmU6BlWXTw0TUgntYp9wcdrZpv+ycKlUdhzusm
 +IbgCV6aJR9f33F41yZqS4CjO72z4nIz4ZGEpUTbagHaz5vIMLK/FQuG48JHto/V69WC
 FSa79WqNacqxqRSvb/0it1ZBcujs/lw9ekZ9SpmG61bZW7BVOXAynfElwNMLftbaChmK
 Z5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931500; x=1746536300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kk7W7DjCSyMwi4lFsEoEOcfFm5Zhop6VnxfXbIaEzIE=;
 b=bTulqYOWrrrm78YqtEjzrz/PUAOuYzh34AYTr3JtR7JogqHJstolLkegm9lS27ihYB
 KvMRUUhGc8/J48XtSw9niU9PC/Pv9bwwQYu8Zs+A2My24+uCCgIxjXl9CIZSl49XL20O
 A/NqVfUHqRG7yzm2NMVKUYpH+qgKY8ddtSo7aLDg0uZYSDgU5+1008nW1bWEb0hAlHKl
 JQTtyTsdgM+9Sk/5Jra02vpiZj6BOj0CjDnkhhoHJmkTgd3y8BObkSkKSOAST65g0W3Y
 ZPreduVrKkav6XQ3Z1rmcL6vywkGbHr8W10mkIikJAOC43dzVZ/HMgasf8V1NiT3uQAU
 7gIQ==
X-Gm-Message-State: AOJu0YxL8rOrnqZJSUjQk7r5rumt5VnteY8jYTXxr+bC8bjuw2FHmw/A
 Yhr4EggZD+FOlO69weaqNgWIVvg/I81hn3LxI6vqndmj2FJcW4mWCzmSD5w1/dTKLCDJD7wiWS4
 F
X-Gm-Gg: ASbGncvZFjk86AprZBJz9sqmKQOOczSqc//4GqNVOi2O7/Q6uvqRR3+C2wQc4xGgCxb
 3nUMq0HAhAG6FUOpY+gIVhIPNTN9BxXzAeh2eQ8+Ei1FR6IDfpMfT4HJuoh3UmHLSiUDEV5OwML
 B8vjV+tJlc/A32N3wfweTfISrVlB37P+aZGgx2V0f/H1j5sNdppN1zJMKpcLzlJSjSGgHSnR/iE
 1tnYt5M+Ri2s5prDTJ3/Sodhw0H1HOELXMLcT+44tSTaIT8YXzSPCEGXatu3hUc/dL3PTMn6FKD
 j/ZXxPJngarQ6L2Nozee+ipDrwEaVrsWXQs38k1hPYY=
X-Google-Smtp-Source: AGHT+IFPiWAwbJJYeBIyIlYJXNgVomBTqmX5HFS1b4uqsWLMvB/dxtVMnIgFyVLq8kVNthLzA7M/EA==
X-Received: by 2002:a05:6a20:d706:b0:1f5:9098:e42e with SMTP id
 adf61e73a8af0-2046a3abbb6mr21070608637.7.1745931500548; 
 Tue, 29 Apr 2025 05:58:20 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7fb7e54sm8889440a12.30.2025.04.29.05.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:58:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, joel@jms.id.au,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/9] hw/riscv/virt.c: enforce s->memmap use in
 machine_init()
Date: Tue, 29 Apr 2025 09:58:03 -0300
Message-ID: <20250429125811.224803-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Throughout the code we're accessing the board memmap, most of the time,
by accessing it statically via 'virt_memmap'. This static map is also
assigned in the machine state in s->memmap.

We're also passing it as a variable to some fdt functions, which is
unorthodox since we can spare a function argument by accessing it
statically or via the machine state.

All the current forms are valid but not all of the are scalable. In the
future we will version this board, and then all this code will need
rework because it should point to the updated memmap. In this case,
we'll want to assign the adequate versioned memmap once during init,
in s->memmap like it is being done today, and the rest of the code
will access the updated map via s->memmap.

We're also enforcing the pattern of using s->memmap instead of assigning
it to a temp variable 'memmap'. Code is copy/pasted around all the time
and being consistent is important.

We'll start these rather mechanical changes with virt_machine_init().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0ac9d63888..bcf0ddd6c6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1526,7 +1526,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
 static void virt_machine_init(MachineState *machine)
 {
-    const MemMapEntry *memmap = virt_memmap;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
@@ -1534,6 +1533,8 @@ static void virt_machine_init(MachineState *machine)
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
+    s->memmap = virt_memmap;
+
     /* Check socket count limit */
     if (VIRT_SOCKETS_MAX < socket_count) {
         error_report("number of sockets/nodes should be less than %d",
@@ -1581,7 +1582,7 @@ static void virt_machine_init(MachineState *machine)
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
-                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
@@ -1590,28 +1591,28 @@ static void virt_machine_init(MachineState *machine)
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
             } else {
                 /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
-                riscv_aclint_swi_create(memmap[VIRT_CLINT].base +
-                            i * memmap[VIRT_CLINT].size,
+                riscv_aclint_swi_create(s->memmap[VIRT_CLINT].base +
+                            i * s->memmap[VIRT_CLINT].size,
                         base_hartid, hart_count, false);
-                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
-                            i * memmap[VIRT_CLINT].size +
+                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                            i * s->memmap[VIRT_CLINT].size +
                             RISCV_ACLINT_SWI_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
                         RISCV_ACLINT_DEFAULT_MTIMECMP,
                         RISCV_ACLINT_DEFAULT_MTIME,
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
-                riscv_aclint_swi_create(memmap[VIRT_ACLINT_SSWI].base +
-                            i * memmap[VIRT_ACLINT_SSWI].size,
+                riscv_aclint_swi_create(s->memmap[VIRT_ACLINT_SSWI].base +
+                            i * s->memmap[VIRT_ACLINT_SSWI].size,
                         base_hartid, hart_count, true);
             }
         } else if (tcg_enabled()) {
             /* Per-socket SiFive CLINT */
             riscv_aclint_swi_create(
-                    memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
+                    s->memmap[VIRT_CLINT].base + i * s->memmap[VIRT_CLINT].size,
                     base_hartid, hart_count, false);
-            riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
-                        i * memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
+            riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
+                    i * s->memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
                     RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
                     RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
                     RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
@@ -1619,11 +1620,11 @@ static void virt_machine_init(MachineState *machine)
 
         /* Per-socket interrupt controller */
         if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-            s->irqchip[i] = virt_create_plic(memmap, i,
+            s->irqchip[i] = virt_create_plic(s->memmap, i,
                                              base_hartid, hart_count);
         } else {
             s->irqchip[i] = virt_create_aia(s->aia_type, s->aia_guests,
-                                            memmap, i, base_hartid,
+                                            s->memmap, i, base_hartid,
                                             hart_count);
         }
 
@@ -1645,8 +1646,8 @@ static void virt_machine_init(MachineState *machine)
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
-                             memmap[VIRT_APLIC_S].base,
-                             memmap[VIRT_IMSIC_S].base,
+                             s->memmap[VIRT_APLIC_S].base,
+                             s->memmap[VIRT_IMSIC_S].base,
                              s->aia_guests);
     }
 
@@ -1662,21 +1663,20 @@ static void virt_machine_init(MachineState *machine)
         virt_high_pcie_memmap.size = VIRT32_HIGH_PCIE_MMIO_SIZE;
     } else {
         virt_high_pcie_memmap.size = VIRT64_HIGH_PCIE_MMIO_SIZE;
-        virt_high_pcie_memmap.base = memmap[VIRT_DRAM].base + machine->ram_size;
+        virt_high_pcie_memmap.base = s->memmap[VIRT_DRAM].base +
+                                     machine->ram_size;
         virt_high_pcie_memmap.base =
             ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
     }
 
-    s->memmap = virt_memmap;
-
     /* register system main memory (actual RAM) */
-    memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
-        machine->ram);
+    memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
+                                machine->ram);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
-                           memmap[VIRT_MROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
+                           s->memmap[VIRT_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, s->memmap[VIRT_MROM].base,
                                 mask_rom);
 
     /*
@@ -1687,12 +1687,12 @@ static void virt_machine_init(MachineState *machine)
     rom_set_fw(s->fw_cfg);
 
     /* SiFive Test MMIO device */
-    sifive_test_create(memmap[VIRT_TEST].base);
+    sifive_test_create(s->memmap[VIRT_TEST].base);
 
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
-            memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
+            s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].size,
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
 
@@ -1700,11 +1700,11 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
+    serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
+    sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
@@ -1722,7 +1722,7 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
     } else {
-        create_fdt(s, memmap);
+        create_fdt(s, s->memmap);
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-- 
2.49.0


