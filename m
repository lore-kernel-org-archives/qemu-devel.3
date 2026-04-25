Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2145FF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcto-000743-NB; Sat, 25 Apr 2026 09:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctk-00071l-Jx
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:16 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcti-0008Sd-FI
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso4764892b3a.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123093; x=1777727893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vt5sRZArkhJCu53zKZmmSu/3/eUzzNisCbL+VsSeRpU=;
 b=aOA3ncywwTBLeAp2X68LQ33jDdR837TtfBtb3R8beRSkcCHuxjKKi1veURx+bf+0Pj
 Rr0bd0Xy7sszU0WhAn2fcNdiUVQ6oUbppbWGqFRxkdGBEp2hKnWONItgweYmzvc/Tb5B
 3vNYLC8DH6hwp6/Orrbt41R8/joGbX71Ozc6RnKwsI693RA/pqan6Du9dWg6cP1JQ7jM
 6m6eb79nGMbG0yVCEXICLY5G65upn7+nZXgrjexXoNnlogziMiG8ZEgI1u+ZfeNEuUvL
 yd3K2Pqt2fR5sVvjrQdv1FmOOuQe2I+5oXjyI2ifS3baj2/Mih9iPMVnQ4cRwkhxLtxw
 XUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123093; x=1777727893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vt5sRZArkhJCu53zKZmmSu/3/eUzzNisCbL+VsSeRpU=;
 b=dXWJkyZzu/OCdnhj0NZ/LEf2bN77uLNWQ7VAakN1PznrLFLVbfjy5wdY/VxTLkayNh
 bJK5j3++pkzFG1nex5EKeFjzBbw3e0YWst+ci+9h7aiGeyqBx2N+lH1jzL82zGwUE18B
 mbwR+1taz3fsICqRPPOgxFBAJvXrlnDLGcg0P0WzvwOFPIYjVmFcrLybBESKz70E/zdU
 4orvUHMk6r/tlDr0sf81RnhzbocCjZ2UoAAhg+bHO/3fsi7S66aHHKrgVtWSrW9hyNci
 N2Vob3TvGP7Db1rxi+t7K01yuqhqhalyXLwQmSB1BOiPx53tZK7zqIEJMkqdRmoR+i8p
 HPFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HKlGg8xxj9OA4CiFdDvfUFRRcK4yRgUQSuibshuBWB7iJJjJ5dln0jMKf7bi2hf1uw1GY5ZZQ0yGv@nongnu.org
X-Gm-Message-State: AOJu0Ywm5ciBFdPqnRyhmG3CTjUwKciS6X/jY52XDpUpntZ7g6xaiw6X
 NHUx56WcOLo316VzpdlTA8t80RxLcHxL2I03OZBodCIQNzxkwt3iKW08
X-Gm-Gg: AeBDiet0/rd6C9EGF4VKPu2K3Jr1ZZqcc4M+aK9ogJGBQKL9PI4o8qYvo3A6a45mgXT
 TL3xz7/pNp0PoAI99nD9mV2BmBk9aFEKhc4TU/0OLVTmfbFV8Zg62z0TNTdwMDB25yLyOiFZckV
 Jhr9YqFVvwKXplLdXnocvZfjrnO1zXd95sVlAjJXOIBo3G0z/Ilx9o6CHf5UD2HBp03zd+OnJX7
 vnXqNxjYxF12JLcXYukjFh/tFZZfT5Ec6nnXhCiMQZm+bgKtC86Cx1e6/4doFQxJfcTmnAXFoh7
 u9eMOGjdIZK3vfmlNme76X3ViFG9kmsZeKqJF059yPsIsh0031yzJFy8vXD4F+LRdHx+1XA+TL5
 kq8bHY48njHHsUOvO+WZxQmsspCVbxpeX+fueN92hjbli/XunbRyflMaZf9CRoVEedvUvGRDpTp
 HgsR2vfmyhKJha55ruyGTfFp/JMuQfLvtXGLYLPL2JyqkGkLjIBcWu5FAYcbmzEcT1i5NB7dgsV
 R8nrABH14isTfC3PgeJwS56aakqjXix
X-Received: by 2002:a05:6a00:6de7:b0:82f:776f:a78d with SMTP id
 d2e1a72fcca58-82f8c888e09mr36076980b3a.19.1777123093077; 
 Sat, 25 Apr 2026 06:18:13 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:12 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 03/13] hw/riscv/boot: Account for discontiguous memory when
 loading firmware
Date: Sat, 25 Apr 2026 23:17:09 +1000
Message-ID: <20260425131721.932250-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x433.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

This loads firmware into the first (low) memory range,
accounting for machines having discontiguous memory regions.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v4: Make RISCVBootInfo *info const in riscv_load_firmware
v3: Call riscv_boot_info_init before riscv_find_and_load_firmware in
    sifive_u
---
 include/hw/riscv/boot.h    |  5 ++++-
 hw/riscv/boot.c            | 18 ++++++++++++------
 hw/riscv/microchip_pfsoc.c |  6 ++++--
 hw/riscv/opentitan.c       |  6 ++++--
 hw/riscv/shakti_c.c        |  6 +++++-
 hw/riscv/sifive_u.c        |  6 ++++--
 hw/riscv/spike.c           |  6 ++++--
 hw/riscv/virt.c            |  7 ++++---
 hw/riscv/xiangshan_kmh.c   |  6 +++++-
 9 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 115e3222174f..b2ef64fb1d14 100644
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
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5c9547429a36..4fbc778263cf 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -145,6 +145,7 @@ char *riscv_find_firmware(const char *firmware_filename,
 }
 
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    RISCVBootInfo *info,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
                                     symbol_fn_t sym_cb)
@@ -157,7 +158,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        firmware_end_addr = riscv_load_firmware(firmware_filename,
+        firmware_end_addr = riscv_load_firmware(machine, info,
+                                                firmware_filename,
                                                 firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
@@ -165,10 +167,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
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
 
@@ -197,7 +202,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
-                                           current_machine->ram_size, NULL,
+                                           mem_size, NULL,
                                            NULL);
 
     if (firmware_size > 0) {
@@ -212,7 +217,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
-    uint64_t mem_size = machine->ram_size;
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     void *fdt = machine->fdt;
     hwaddr start, end;
     ssize_t size;
@@ -258,6 +263,7 @@ void riscv_load_kernel(MachineState *machine,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
+    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     ssize_t kernel_size;
     void *fdt = machine->fdt;
@@ -289,7 +295,7 @@ void riscv_load_kernel(MachineState *machine,
     }
 
     kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
-                                         current_machine->ram_size, NULL, NULL);
+                                         mem_size, NULL, NULL);
     if (kernel_size > 0) {
         info->kernel_size = kernel_size;
         info->image_low_addr = kernel_start_addr;
@@ -385,7 +391,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
 
     if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
-        error_report("No enough memory to place DTB after kernel/initrd");
+        error_report("Not enough memory to place DTB after kernel/initrd");
         exit(1);
     }
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 743f31f00578..1d1ddb05a882 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -618,18 +618,20 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         firmware_load_addr = RESET_VECTOR;
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
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
index 309125e854bc..8cd660dd4154 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -99,12 +99,14 @@ static void opentitan_machine_init(MachineState *machine)
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
index 49a39b30212d..eb720d9cdf5d 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -45,6 +45,7 @@ static void shakti_c_machine_state_init(MachineState *mstate)
 {
     ShaktiCMachineState *sms = RISCV_SHAKTI_MACHINE(mstate);
     MemoryRegion *system_memory = get_system_memory();
+    RISCVBootInfo boot_info;
     hwaddr firmware_load_addr = shakti_c_memmap[SHAKTI_C_RAM].base;
 
     /* Initialize SoC */
@@ -57,8 +58,11 @@ static void shakti_c_machine_state_init(MachineState *mstate)
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
index 7ec67b256514..dda8687bfdd8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -589,11 +589,13 @@ static void sifive_u_machine_init(MachineState *machine)
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
index 35c696f891d8..6ee915a8ba4e 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -281,9 +281,12 @@ static void spike_board_init(MachineState *machine)
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
@@ -293,7 +296,6 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a1c323e66dfd..4501d5581b62 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1457,7 +1457,10 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                     firmware_name,
                                                      &start_addr, NULL);
 
     pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
@@ -1480,8 +1483,6 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    riscv_boot_info_init(&boot_info, &s->soc[0]);
-
     if (machine->kernel_filename && !kernel_entry) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 436e51c1c593..247a0b5d1f21 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -166,6 +166,7 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
     const MemMapEntry *memmap = xiangshan_kmh_memmap;
     MemoryRegion *system_memory = get_system_memory();
     hwaddr start_addr = memmap[XIANGSHAN_KMH_DRAM].base;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -177,13 +178,16 @@ static void xiangshan_kmh_machine_init(MachineState *machine)
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
-- 
2.47.3


