Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E8CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwfz-0004mw-G0; Fri, 29 May 2026 08:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wSwfx-0004m3-B3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:50:57 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wSwfv-0006F3-6g
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:50:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-837dfccd950so6503489b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780059054; x=1780663854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAH7CXKhbJbOYy+X+/fCpfZwl+4JE5GflKjjttJSK4A=;
 b=hmX3Myx4X251JGxLJR3PdF0y6fGgY/tdtGUhvxMKv4q3Z+/Wkvgalo0ssc4vda4uER
 pdRUQt4HzueT7RBAr1QtmccoD9Nwwy+Am2I5DE8aJS15tfvgA0RxFuKvysjLt1JbJKMF
 S7uN83JI+boX4Q+9jVt02OiuRaeoupyRkLkJpZH3lV/KkrCLD9ZdZsNHCJAyRE94TTxk
 Asr0LoJ0+Y7LNprWw0QixEi/ozY3fTZpOaEUC12zdB0+PrNCMswK9C7QdabG//Ui4HDE
 gHVbXrVHntmZScGMV/kzOxcpS39JgfjW5VbCK/W/Kw9qqv7YXYFSlSQzALjZZ8PTJqUA
 wmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059054; x=1780663854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SAH7CXKhbJbOYy+X+/fCpfZwl+4JE5GflKjjttJSK4A=;
 b=KBIGW+qYBbUSGJ4ixGlUIUDu+SWL9h2+1PMO05FLrNfDRTuA1ckRrWNTO/JNaOWjJY
 eyd1RtqJYwZ+oARsmaUnzUoZS/92ETnXup8uJysT7RvhZJl2dmj57ZLMz32Q7Y8jjOLu
 9S8CySI/bNFcc7qg1yfugqfP5ZyS4ekeDuinzmrkn2OdJZcrw53KYKLiP91mUhvzi5yj
 +v1froo5vDVXUarIFIuW+2ZMKQfPyh+2NK5pnxFNEOTSNo3azzXIak8YjJKfYjY2TI7N
 cEvNNcBODKOZ95jcyG2lBDg1N91wIPV6M7PH23ydM7Mx5SRn9kdmwySzA9Tztc6tQMwt
 94kA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yHZtxFICecFJ8OY/x1IaEglEKehJvJCTwiPRpFttPt2gBqOsx4TVU1yAl7XvvOZvRJ1Yz+QgQO5f4@nongnu.org
X-Gm-Message-State: AOJu0YyP5MyCY6Zz3lhG5OMM9nwW0FxFF5y+u/IZLj/KNxHXO7Q4Blbm
 Fj4vUJWWb/A4XREmbJWSrqjYGNnYYX8XB3tYvvN9+O6QeJUpXHazxx5Z
X-Gm-Gg: Acq92OFqPTxFYamtJmha7sUGnx+G7OvF9XW3nF205ogpEAsB4Fs0XaQWV5peGZGDwfb
 evqkr0hHWkhnUq1IDawpxVi87uXbEAfYgQ2LhKlT2KCtEhsJ8L8qAMDx47KldwyDBMUXRkGASWS
 fuHDT1xLGAjglxv59x4u8s73oH7fJbO/P2cjSIEeYoMeGxaiFjJvMakt5RbCEuDGk7sXITZESZA
 +IKFbyQYV0hTIv1pECOWoU4dDg9s8+AFJ3OQRbDUFXPkHsKgmt0+c/+6AzrYRm0obt0ORhiYqJ2
 8UY8JhkvgWOMCfc04bS9s3mqeJcT2NfWeW34Szo/KcO7mvprx7sIvUIg4Py9T1zsMpV2CnIf97e
 WBRnhAd+BKCO38AQQo56csEG+UApYd35DGU0clxHxMDS0Syj0n893T3BPIfkHFiELjH2FY3gz97
 6EsYK4dcQSDMX0CbLiyoPBFjgNS+MAPFX3sGj4k3UKgl/zhp1sEjxFHtrunzTazHm6Avq3BHQ4/
 UeRq/Xq
X-Received: by 2002:a05:6a00:130c:b0:839:dd77:3505 with SMTP id
 d2e1a72fcca58-84212ca221emr3003287b3a.22.1780059053467; 
 Fri, 29 May 2026 05:50:53 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b67b8asm1820671b3a.25.2026.05.29.05.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:50:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v7 02/10] hw/riscv/boot: Account for discontiguous memory when
 loading firmware
Date: Fri, 29 May 2026 05:50:27 -0700
Message-ID: <20260529125036.728206-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529125036.728206-1-npiggin@gmail.com>
References: <20260529125036.728206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This loads firmware into the first (low) memory range,
accounting for machines having discontiguous memory regions.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/riscv/boot.c            | 18 ++++++++++++------
 hw/riscv/microchip_pfsoc.c |  8 ++++++--
 hw/riscv/opentitan.c       |  6 ++++--
 hw/riscv/shakti_c.c        |  6 +++++-
 hw/riscv/sifive_u.c        |  6 ++++--
 hw/riscv/spike.c           |  6 ++++--
 hw/riscv/virt.c            |  7 ++++---
 hw/riscv/xiangshan_kmh.c   |  6 +++++-
 include/hw/riscv/boot.h    |  5 ++++-
 9 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index b1a020b58a..b0a2e384b1 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -150,6 +150,7 @@ char *riscv_find_firmware(const char *firmware_filename,
 }
 
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb)
@@ -162,7 +163,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        firmware_end_addr = riscv_load_firmware(firmware_filename,
+        firmware_end_addr = riscv_load_firmware(machine, info,
+                                                firmware_filename,
                                                 firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
@@ -170,10 +172,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
     return firmware_end_addr;
 }
 
-hwaddr riscv_load_firmware(const char *firmware_filename,
+hwaddr riscv_load_firmware(MachineState *machine,
+                           const RISCVBootInfo *info,
+                           const char *firmware_filename,
                            hwaddr *firmware_load_addr,
                            symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     uint64_t firmware_entry, firmware_end;
     ssize_t firmware_size;
 
@@ -202,7 +207,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
-                                           current_machine->ram_size, NULL,
+                                           mem_size, NULL,
                                            NULL);
 
     if (firmware_size > 0) {
@@ -217,7 +222,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
-    uint64_t mem_size = machine->ram_size;
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     void *fdt = machine->fdt;
     hwaddr start, end;
     ssize_t size;
@@ -263,6 +268,7 @@ void riscv_load_kernel(MachineState *machine,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     ssize_t kernel_size;
     void *fdt = machine->fdt;
@@ -294,7 +300,7 @@ void riscv_load_kernel(MachineState *machine,
     }
 
     kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
-                                         current_machine->ram_size, NULL, NULL);
+                                         mem_size, NULL, NULL);
     if (kernel_size > 0) {
         info->kernel_size = kernel_size;
         info->image_low_addr = kernel_start_addr;
@@ -390,7 +396,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
 
     if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
-        error_report("No enough memory to place DTB after kernel/initrd");
+        error_report("Not enough memory to place DTB after kernel/initrd");
         exit(1);
     }
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 5e48a29708..4017129c83 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -619,18 +619,22 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         firmware_load_addr = RESET_VECTOR;
     }
 
+    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc.u_cpus,
+                                       memmap[MICROCHIP_PFSOC_DRAM_LO].base,
+                                       mem_low_size);
+
     /* Load the firmware if necessary */
     firmware_end_addr = firmware_load_addr;
     if (firmware_name) {
         char *filename = riscv_find_firmware(firmware_name, NULL);
         if (filename) {
-            firmware_end_addr = riscv_load_firmware(filename,
+            firmware_end_addr = riscv_load_firmware(machine, &boot_info,
+                                                    filename,
                                                     &firmware_load_addr, NULL);
             g_free(filename);
         }
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index c8b2f028f2..5b2f33d5ac 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -100,12 +100,14 @@ static void opentitan_machine_init(MachineState *machine)
     memory_region_add_subregion(sys_mem,
         memmap[IBEX_DEV_RAM].base, machine->ram);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
     if (machine->firmware) {
         hwaddr firmware_load_addr = memmap[IBEX_DEV_RAM].base;
-        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
+        riscv_load_firmware(machine, &boot_info, machine->firmware,
+                            &firmware_load_addr, NULL);
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info,
                           memmap[IBEX_DEV_RAM].base,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index b1823a3125..835b1f879b 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -46,6 +46,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
 {
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
+    RISCVBootInfo boot_info;
     hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
 
     /* Initialize SoC */
@@ -58,8 +59,11 @@ static void shakti_c_machine_state_init(MachineState *mstate)
                                 shakti_c_memmap[SHAKTI_C_RAM].base,
                                 mstate->ram);
 
+    riscv_boot_info_init(&boot_info, &sms->soc.cpus);
+
     if (mstate->firmware) {
-        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL);
+        riscv_load_firmware(mstate, &boot_info, mstate->firmware,
+                            &firmware_load_addr, NULL);
     }
 
     /* ROM reset vector */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6a637e3b86..3b2763de16 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -590,11 +590,13 @@ static void sifive_u_machine_init(MachineState *machine)
         break;
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
+
     firmware_name = riscv_default_firmware_name(&s->soc.u_cpus);
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
-    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index f9d00e0d5c..8d68b4e235 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -282,9 +282,12 @@ static void spike_board_init(MachineState *machine)
         }
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
     /* Load firmware */
     if (firmware_name) {
-        firmware_end_addr = riscv_load_firmware(firmware_name,
+        firmware_end_addr = riscv_load_firmware(machine, &boot_info,
+                                                firmware_name,
                                                 &firmware_load_addr,
                                                 htif_symbol_callback);
         g_free(firmware_name);
@@ -294,7 +297,6 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7..febf49d5f1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1458,7 +1458,10 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
@@ -1481,8 +1484,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
-
     if (machine->kernel_filename && !kernel_entry) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 76417ba7ab..384624d69a 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -167,6 +167,7 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
     const MemMapEntry *memmap = xiangshan_kmh_memmap;
     MemoryRegion *system_memory = get_system_memory();
     hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -178,13 +179,16 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
                                 memmap[XIANGSHAN_KMH_DRAM].base,
                                 machine->ram);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
     /* ROM reset vector */
     riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
                               start_addr,
                               memmap[XIANGSHAN_KMH_ROM].base,
                               memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
     if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, &start_addr, NULL);
+        riscv_load_firmware(machine, &boot_info, machine->firmware,
+                            &start_addr, NULL);
     }
 
     /* Note: dtb has been integrated into firmware(OpenSBI) when compiling */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 69c99a1496..4e7bd9a225 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
-hwaddr riscv_load_firmware(const char *firmware_filename,
+hwaddr riscv_load_firmware(MachineState *machine,
+                           const RISCVBootInfo *info,
+                           const char *firmware_filename,
                            hwaddr *firmware_load_addr,
                            symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
-- 
2.53.0


