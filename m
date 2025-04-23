Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438D1C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XwQ-0004NB-2w; Wed, 23 Apr 2025 07:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwI-0004Lu-CU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwE-0000KO-5s
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224100e9a5cso74296265ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406403; x=1746011203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYmpMs/o04+SEBZ1SRQFaE1GuD9MT41yqQ25wxrcfqg=;
 b=ojslz7Yob5reYLL7SqZewC3PLhwmN7pOHaTVLj0jE/4Ycrm8jvXJSCKEAl88r/DRjG
 8EXbjnzj5Y9qqOQrNBC4HA4zDK6eo7/K+ujgWieBbuSnTA1hWiZbi4RTKNXuQ0jB5Xzr
 l/EpZVtjoffCmbYMNTcVztVl+gK4PP/mfuvw12l0GK2fmYpUJV+f/lpsFSbBt89J2URE
 eFRV7WmdMHFXl19Y9BeqlMwX5maCLrrVxvWm7jsX2dMgyqZVTvpO/B4f00SaV1Rgr8m9
 nz5m+h7qQyceMDS3vFfVpF+WQUHG9leAoJHtOKwqtfwzPQnsl35vbuj4+fHvVEeSGNJQ
 inoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406403; x=1746011203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYmpMs/o04+SEBZ1SRQFaE1GuD9MT41yqQ25wxrcfqg=;
 b=VoUR9F/QbcobBry4scCYeuoG+30+G7OUMzBTgUhViMfxcNqeK3v92+U3khVN8ojjXR
 LMM1f4A1588xTdNMm6p8ny9E0WtgvDu25Aufy+jqZj5DGclGa/DzF/pR8bgGYox3fxZw
 6UC2Qbf/Jrt2vnnx2VXH7h5chcfI9yLehrxlMuYfa8QqLG+hrmBQ8+G68p1JjlHitkOc
 ffRuZg0o5+e/NQhle9KPhAAfCGblRuxlnVRJ9aSU0rFjaSLnY4O7RqW+oWSjNdcrnZzF
 Ypuz0OXBK206FilYXXXjyFRwzy0L8bhgBlS96JOgJ64IAe17m/sU9/G7i+a/1Lx3qqPb
 XWIg==
X-Gm-Message-State: AOJu0Yw1XHXR6XM8B7yj/2Rr1YU3B82BK1oT+DDYlesNlsaB0pWX0H2X
 a43XTdRUocp8sOKGN1yN33O97+F8LBFU882O/DzNmk4YVBWAJpKcsb7KYOklHm3zxQa7QFyfG3e
 5
X-Gm-Gg: ASbGncsEg/dxcsfARvazWTq/g4RL3W4wnzf9FOxie+I6gi6JiqbNS1wR/l1HJ4DqT9A
 Y+IcgJaTmYR9d7AgINKhlvfG7ZManvGsKJPnCxvgzaTW/X6RytawW1b1rBFttCSHle8N/nb2OSW
 V0htpYa/oj9mB58RX6Aj0z3BUiqzHKiusr4EioZyn2a9lYhfXkJweuw3NgG3l08EdE4BU0unCpa
 BJB2PGs6GXZxT3S0FaNqy5LHRsoVjmhUm6t871/72UYOyiet1ZK1QgUxNuRGci9kZYGBwfr3emv
 LS+YlfZnTaqBVG2vfI7sXILMtwi2U1t6Top+9IzyG5bo5ikqfpY+6/51S6L3rjS6ywxcquZT3g=
 =
X-Google-Smtp-Source: AGHT+IEBo93Is7EqVzGUYuc5avELRwWWgrXKiWq/EExEM0bhAp8VK8XtwQeGaZGJ5Ldhw3KO5a19gg==
X-Received: by 2002:a17:903:1ce:b0:223:f9a4:3f9c with SMTP id
 d9443c01a7336-22c5337ca0cmr252056435ad.9.1745406403363; 
 Wed, 23 Apr 2025 04:06:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:06:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/9] hw/riscv/virt.c: enforce s->memmap use in machine_init()
Date: Wed, 23 Apr 2025 08:06:22 -0300
Message-ID: <20250423110630.2249904-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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
---
 hw/riscv/virt.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c9d255d8a8..6e3e34879f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1527,7 +1527,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
 static void virt_machine_init(MachineState *machine)
 {
-    const MemMapEntry *memmap = virt_memmap;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
@@ -1535,6 +1534,8 @@ static void virt_machine_init(MachineState *machine)
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
+    s->memmap = virt_memmap;
+
     /* Check socket count limit */
     if (VIRT_SOCKETS_MAX < socket_count) {
         error_report("number of sockets/nodes should be less than %d",
@@ -1582,7 +1583,7 @@ static void virt_machine_init(MachineState *machine)
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
-                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
@@ -1591,28 +1592,28 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1620,11 +1621,11 @@ static void virt_machine_init(MachineState *machine)
 
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
 
@@ -1646,8 +1647,8 @@ static void virt_machine_init(MachineState *machine)
     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
-                             memmap[VIRT_APLIC_S].base,
-                             memmap[VIRT_IMSIC_S].base,
+                             s->memmap[VIRT_APLIC_S].base,
+                             s->memmap[VIRT_IMSIC_S].base,
                              s->aia_guests);
     }
 
@@ -1663,21 +1664,20 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1688,12 +1688,12 @@ static void virt_machine_init(MachineState *machine)
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
 
@@ -1701,11 +1701,11 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
-    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
+    serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
+    sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
@@ -1723,7 +1723,7 @@ static void virt_machine_init(MachineState *machine)
             exit(1);
         }
     } else {
-        create_fdt(s, memmap);
+        create_fdt(s, s->memmap);
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-- 
2.49.0


