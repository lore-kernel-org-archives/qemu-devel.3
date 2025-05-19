Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBA4C54754
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4e-00036D-Ho; Mon, 19 May 2025 00:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrov-0008Ng-If
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:45 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrot-0004Nm-Cq
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b26f5eb16a5so1721161a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627782; x=1748232582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZUiww2oTdBqm1/iAjGdigfjMeVEgXCovMh/RAiSn+w=;
 b=dpjKrwhmeIsQsjIjzzWJka2MuWUEUUGjw61+kWLQaijQ3hePxgrhrrKTDrga77C25J
 kya4K/6pSm1xXwfjwVAeFqgZztHQTY9NJAYZmcimxv3LMWO0Dbp4ebbK07ggyqktNRFw
 ge8gV8V/FasFZchX8BPzA/lUqcyCnrZQb5t24agwFuBwkKWuQ+XRNE0PxHj55om1Fcjl
 2UKHR0hoG2uTT6g6nem9owB972KdyQ48ZjnGYBHMGE+YtJ5RHUt8Tq2/8gHsgX4fRlI0
 B1UiqoC/F/OYFwww7zXHtb5Cyx5L4f5fQp+2RfaSAZ3D1Q/tFGpbOmt2XW9Ll3rtMiXP
 chuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627782; x=1748232582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZUiww2oTdBqm1/iAjGdigfjMeVEgXCovMh/RAiSn+w=;
 b=emNECn60BT3mcF83Me2jyqmYqdDl022T3M41qv1wDJUS6IW7eROrgHL4OJ9EDtTmKJ
 bvP/nBd4VKaYVOVZevgQ/PcK+KAETDxUgWMypKcaMw7Xta7qcI2kVwek/znhvgEOC5JV
 UqvefVTwfcYRGQayOcfSZZ3UnMNmdZBKIa3ndpNgkYv8Rl2QNBcVbuewGLyS9syBxlRL
 QmPTgt3W7YQxDb9s1K15v12mMd4huaqFFvVEFa6s6GmGg9akhc60o4pfFjLEXLx7WmEc
 sEaeyfsuYtc9lbbJ2A32H0ZMdbqcShHNtrqgZNFGQ7uAdoLX5ZT251p9PjYnLEBvOtkL
 rtkg==
X-Gm-Message-State: AOJu0YxIeMOjMMRNlqYsVvM7N2mwK9Kw0NKkdHPyKrCavkE8DuQQRhEJ
 Xd2/6pNaAHwXZS5xW4EXt4rl77BM5YCK817Wvl6oJjBWmEPC0fYR2bPp6l7JkA==
X-Gm-Gg: ASbGnctZYVfC0oTKqot+iciWWDNmAJZp7rt36bbqFM+9GwS52K+xLsXod7cM5IVVtnR
 b9D8CbzX5F1rNp+UmTlSVv5CXtL+AG9obL4ChiTOsOZqg4CJxhqVWv1+/AT+r9ZgXXEttACqMgK
 BpvbcsQhMfXZo2qO1o6rBTqPY10IcWCYuFTQZUEFfT55S3fuz8dPDb0WKLTr3mK+X3kPxtLlp4f
 BOxiprjG//RXaEdKEaw35ARQYpo4duESfq7iliiIRr7acSG/sXhHQpO0s2Hsuz9G7XkgoYLOIoY
 kEUuxfcxHFMF3Ezzl49ziQzF1kA8QXgQzz2BPb+j3S1dakzSo/uuzEuVcGLcKWXZuqC/Wmk8t+0
 AEJ5438hT3RzckhVRUv0ZJEHAo88cifdZp1KjF+P0k+rIGc6yPdskECmr
X-Google-Smtp-Source: AGHT+IGMTmARbNyneurL/JMorDY9/QVydXtgdf5uGBZ/0kr+V0TMAhiMqlYyQHzF2swNclYvefKZKg==
X-Received: by 2002:a17:903:8c3:b0:231:d0da:5e1f with SMTP id
 d9443c01a7336-231d4e7b7b6mr163408295ad.21.1747627781476; 
 Sun, 18 May 2025 21:09:41 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Subject: [PULL 48/56] hw/riscv/virt.c: enforce s->memmap use in machine_init()
Date: Mon, 19 May 2025 14:05:45 +1000
Message-ID: <20250519040555.3797167-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20250429125811.224803-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5958ad1f7d..0200679240 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1522,7 +1522,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
 static void virt_machine_init(MachineState *machine)
 {
-    const MemMapEntry *memmap = virt_memmap;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
@@ -1530,6 +1529,8 @@ static void virt_machine_init(MachineState *machine)
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
+    s->memmap = virt_memmap;
+
     /* Check socket count limit */
     if (VIRT_SOCKETS_MAX < socket_count) {
         error_report("number of sockets/nodes should be less than %d",
@@ -1577,7 +1578,7 @@ static void virt_machine_init(MachineState *machine)
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
-                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
@@ -1586,28 +1587,28 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1615,11 +1616,11 @@ static void virt_machine_init(MachineState *machine)
 
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
 
@@ -1641,8 +1642,8 @@ static void virt_machine_init(MachineState *machine)
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
-                             memmap[VIRT_APLIC_S].base,
-                             memmap[VIRT_IMSIC_S].base,
+                             s->memmap[VIRT_APLIC_S].base,
+                             s->memmap[VIRT_IMSIC_S].base,
                              s->aia_guests);
     }
 
@@ -1658,21 +1659,20 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1683,12 +1683,12 @@ static void virt_machine_init(MachineState *machine)
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
 
@@ -1696,11 +1696,11 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
+    serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
+    sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
@@ -1718,7 +1718,7 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
     } else {
-        create_fdt(s, memmap);
+        create_fdt(s, s->memmap);
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-- 
2.49.0


