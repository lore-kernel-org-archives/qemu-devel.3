Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEF5E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFu-0000nh-Ez; Thu, 19 Dec 2024 20:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFX-0007YG-0X
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:25 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFU-0004Zh-NT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:18 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-728e3826211so1251197b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659774; x=1735264574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=if0t+RynGyy+jWaLxcCbDUoikewpbbgwcODeBNI/aRM=;
 b=PkaUcrfTJtRQ9IQ+4IM2cIyQE77Xb2PNXhh3zxdZVqowrXXIbFeSX2leLI7yDWNkL/
 DEYJ8+lT4Pa/3fCcqXvBs3HX+P8+7SBbPSoAr85A0kW7WMpBKZMG2G2pGdhV7jH2Fkrf
 BuhH5qEXpEYbjVMYg99ThUuseSYZ1OxkZxWdLR5T31iCz1pv7tw5N2LAY9Nkd85nfQwY
 9gkeqVprVUWAd1ryPslGC5bRLycwEkT9t2YP7NSBHrutRKxGzz+qzlYFage/ck1IJZdn
 uVoxBpkvkAt4NQ5wbRimbZbmm+mvbWm79JUP43GdmGrVtAgdkOzeyCCeNiuhRmpU6/+0
 TCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659774; x=1735264574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=if0t+RynGyy+jWaLxcCbDUoikewpbbgwcODeBNI/aRM=;
 b=PEjmSup9i8Gpanw6+D9V6Fsc5wpY9Yw15WmaMbYI2mbr6iUwEc8PJLT3Jhm+zqL2pl
 nf22LJ5TO41KQRrl4E9LoFX5wJEbMz+4wBl4+jHU+SkZgyXPfV/XotovL791TwBQ3IxZ
 +YWT25SfwFmstjzgOIZQ4/seUjGpdHOKMZFlVppXkPKBvQSQm7B1qe7pcn1B3eEpUHSd
 ENY2fPIiqqMQfxQvIGZWPqHX4wUNRVrfO7PzZtoSshGyH9hEdOILTVyedjTE8NmrM6J6
 5SrzOhseXUBqbq9JVBKUyiauNW1KmsAW7aR+mXEvls9fHx4IbQBfVSfhyoUJVkOvaja6
 s+Mw==
X-Gm-Message-State: AOJu0YxW8MngAI45906K9eOra7Suq2P6cFdXEZak4eaETP1Y2hi/ZHK6
 3t7wYMlSdAegEzMEDrm6NtIMlYZtYKTegP7iCPrTxO+6OYKNg4cD216Kaurb
X-Gm-Gg: ASbGnctKnefIaczgmVN0vlDkH3uYgbHhzSf76T6dj4py1XQArrZv2chLY++8pBJfjD5
 UFKaTOjwILPTGgiaJhBVucBRly8cYLjJbds7DJLSh0a01QG8Kv1AyX1/3adnUhZtx3o7shEHv/M
 +pvGV2LQN9n73xQ2GAmR5ETpstbm1akND7vyOBPhUfRNZ4q+45JmRnPmxncTabySZbXtUCTb1GP
 VjJT7R3lIqmmyJ1EQyKXwZRX+ftfOAFiquDYNlAjLTvcKOK9GQxAphQ3sWUMj1wLH8VChz2Ww3t
 gdXstbbvoZzXr9B9tllSC1o1egFcBYjA7Eu/2sIl/98fE6O0HvFW1otbAOOW37I=
X-Google-Smtp-Source: AGHT+IHpx+n3NLuQ0tz7mvgjOprejWxYtGvU+T2S0FtY8vRfDvJQOBCFTKAi1mz+g2CxOt/NP4/z+g==
X-Received: by 2002:a05:6a00:414a:b0:727:3fd5:b530 with SMTP id
 d2e1a72fcca58-72abde0f264mr1217648b3a.15.1734659774537; 
 Thu, 19 Dec 2024 17:56:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 27/39] hw/riscv: Add a new struct RISCVBootInfo
Date: Fri, 20 Dec 2024 11:54:27 +1000
Message-ID: <20241220015441.317236-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Add a new struct RISCVBootInfo to sync boot information between multiple
boot functions.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241120153935.24706-3-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h    | 25 ++++++++++-----
 hw/riscv/boot.c            | 65 ++++++++++++++++++++++----------------
 hw/riscv/microchip_pfsoc.c | 11 ++++---
 hw/riscv/opentitan.c       |  4 ++-
 hw/riscv/sifive_e.c        |  4 ++-
 hw/riscv/sifive_u.c        | 12 ++++---
 hw/riscv/spike.c           | 12 ++++---
 hw/riscv/virt.c            | 13 +++++---
 8 files changed, 90 insertions(+), 56 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 34a80c5ff4..06b51ed086 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -27,11 +27,20 @@
 #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
+typedef struct RISCVBootInfo {
+    ssize_t kernel_size;
+    hwaddr image_low_addr;
+    hwaddr image_high_addr;
+
+    bool is_32bit;
+} RISCVBootInfo;
+
 bool riscv_is_32bit(RISCVHartArrayState *harts);
 
 char *riscv_plic_hart_config_string(int hart_count);
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                           target_ulong firmware_end_addr);
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
@@ -43,13 +52,13 @@ char *riscv_find_firmware(const char *firmware_filename,
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr *firmware_load_addr,
                                  symbol_fn_t sym_cb);
-target_ulong riscv_load_kernel(MachineState *machine,
-                               RISCVHartArrayState *harts,
-                               target_ulong firmware_end_addr,
-                               bool load_initrd,
-                               symbol_fn_t sym_cb);
-uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts);
+void riscv_load_kernel(MachineState *machine,
+                       RISCVBootInfo *info,
+                       target_ulong kernel_start_addr,
+                       bool load_initrd,
+                       symbol_fn_t sym_cb);
+uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
+                                MachineState *ms, RISCVBootInfo *info);
 void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr saddr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index d36d3a7104..81d27f935e 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -67,9 +67,15 @@ char *riscv_plic_hart_config_string(int hart_count)
     return g_strjoinv(",", (char **)vals);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVHartArrayState *harts,
+void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
+{
+    info->kernel_size = 0;
+    info->is_32bit = riscv_is_32bit(harts);
+}
+
+target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                           target_ulong firmware_end_addr) {
-    if (riscv_is_32bit(harts)) {
+    if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
         return QEMU_ALIGN_UP(firmware_end_addr, 2 * MiB);
@@ -175,7 +181,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
+static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 {
     const char *filename = machine->initrd_filename;
     uint64_t mem_size = machine->ram_size;
@@ -196,7 +202,7 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
      * halfway into RAM, and for boards with 1GB of RAM or more we put
      * the initrd at 512MB.
      */
-    start = kernel_entry + MIN(mem_size / 2, 512 * MiB);
+    start = info->image_low_addr + MIN(mem_size / 2, 512 * MiB);
 
     size = load_ramdisk(filename, start, mem_size - start);
     if (size == -1) {
@@ -215,14 +221,14 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
     }
 }
 
-target_ulong riscv_load_kernel(MachineState *machine,
-                               RISCVHartArrayState *harts,
-                               target_ulong kernel_start_addr,
-                               bool load_initrd,
-                               symbol_fn_t sym_cb)
+void riscv_load_kernel(MachineState *machine,
+                       RISCVBootInfo *info,
+                       target_ulong kernel_start_addr,
+                       bool load_initrd,
+                       symbol_fn_t sym_cb)
 {
     const char *kernel_filename = machine->kernel_filename;
-    uint64_t kernel_load_base, kernel_entry;
+    ssize_t kernel_size;
     void *fdt = machine->fdt;
 
     g_assert(kernel_filename != NULL);
@@ -234,21 +240,28 @@ target_ulong riscv_load_kernel(MachineState *machine,
      * the (expected) load address load address. This allows kernels to have
      * separate SBI and ELF entry points (used by FreeBSD, for example).
      */
-    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
-                         NULL, &kernel_load_base, NULL, NULL, 0,
-                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
-        kernel_entry = kernel_load_base;
+    kernel_size = load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NULL,
+                                   &info->image_low_addr, &info->image_high_addr,
+                                   NULL, 0, EM_RISCV, 1, 0, NULL, true, sym_cb);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
         goto out;
     }
 
-    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
-                       NULL, NULL, NULL) > 0) {
+    kernel_size = load_uimage_as(kernel_filename, &info->image_low_addr,
+                                 NULL, NULL, NULL, NULL, NULL);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
+        info->image_high_addr = info->image_low_addr + kernel_size;
         goto out;
     }
 
-    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
-                               current_machine->ram_size, NULL) > 0) {
-        kernel_entry = kernel_start_addr;
+    kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
+                                         current_machine->ram_size, NULL);
+    if (kernel_size > 0) {
+        info->kernel_size = kernel_size;
+        info->image_low_addr = kernel_start_addr;
+        info->image_high_addr = info->image_low_addr + kernel_size;
         goto out;
     }
 
@@ -257,23 +270,21 @@ target_ulong riscv_load_kernel(MachineState *machine,
 
 out:
     /*
-     * For 32 bit CPUs 'kernel_entry' can be sign-extended by
+     * For 32 bit CPUs 'image_low_addr' can be sign-extended by
      * load_elf_ram_sym().
      */
-    if (riscv_is_32bit(harts)) {
-        kernel_entry = extract64(kernel_entry, 0, 32);
+    if (info->is_32bit) {
+        info->image_low_addr = extract64(info->image_low_addr, 0, 32);
     }
 
     if (load_initrd && machine->initrd_filename) {
-        riscv_load_initrd(machine, kernel_entry);
+        riscv_load_initrd(machine, info);
     }
 
     if (fdt && machine->kernel_cmdline && *machine->kernel_cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                 machine->kernel_cmdline);
     }
-
-    return kernel_entry;
 }
 
 /*
@@ -293,7 +304,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms, RISCVHartArrayState *harts)
+                                MachineState *ms, RISCVBootInfo *info)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
@@ -321,7 +332,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
      * Thus, put it near to the end of dram in RV64, and put it near to the end
      * of dram or 3GB whichever is lesser in RV32.
      */
-    if (!riscv_is_32bit(harts)) {
+    if (!info->is_32bit) {
         temp = dram_end;
     } else {
         temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index ba8b0a2c26..a302965b6d 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -521,6 +521,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
+    RISCVBootInfo boot_info;
 
     /* Sanity check on RAM size */
     if (machine->ram_size < mc->default_ram_size) {
@@ -615,17 +616,19 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &firmware_load_addr, NULL);
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (kernel_as_payload) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
 
         /* Compute the fdt load address in dram */
         fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                                memmap[MICROCHIP_PFSOC_DRAM_LO].size,
-                                               machine, &s->soc.u_cpus);
+                                               machine, &boot_info);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
         /* Load the reset vector */
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 8ce85ea9f7..87ad9c8f34 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -81,6 +81,7 @@ static void opentitan_machine_init(MachineState *machine)
     OpenTitanState *s = OPENTITAN_MACHINE(machine);
     const MemMapEntry *memmap = ibex_memmap;
     MemoryRegion *sys_mem = get_system_memory();
+    RISCVBootInfo boot_info;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -102,8 +103,9 @@ static void opentitan_machine_init(MachineState *machine)
         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &boot_info,
                           memmap[IBEX_DEV_RAM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5a1959f2a9..ebcd33ab95 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -78,6 +78,7 @@ static void sifive_e_machine_init(MachineState *machine)
     SiFiveEState *s = RISCV_E_MACHINE(machine);
     MemoryRegion *sys_mem = get_system_memory();
     int i;
+    RISCVBootInfo boot_info;
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -113,8 +114,9 @@ static void sifive_e_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine, &s->soc.cpus,
+        riscv_load_kernel(machine, &boot_info,
                           memmap[SIFIVE_E_DEV_DTIM].base,
                           false, NULL);
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index fd59124500..6270e1ccec 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -526,6 +526,7 @@ static void sifive_u_machine_init(MachineState *machine)
     BlockBackend *blk;
     DeviceState *flash_dev, *sd_dev, *card_dev;
     qemu_irq flash_cs, sd_cs;
+    RISCVBootInfo boot_info;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
@@ -591,12 +592,13 @@ static void sifive_u_machine_init(MachineState *machine)
     firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
                                                      &start_addr, NULL);
 
+    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc.u_cpus,
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc.u_cpus,
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -607,7 +609,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
                                            memmap[SIFIVE_U_DEV_DRAM].size,
-                                           machine, &s->soc.u_cpus);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     if (!riscv_is_32bit(&s->soc.u_cpus)) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index acd7ab1ae1..c3ad16d316 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -206,6 +206,7 @@ static void spike_board_init(MachineState *machine)
     char *soc_name;
     int i, base_hartid, hart_count;
     bool htif_custom_base = false;
+    RISCVBootInfo boot_info;
 
     /* Check socket count limit */
     if (SPIKE_SOCKETS_MAX < riscv_socket_count(machine)) {
@@ -300,13 +301,14 @@ static void spike_board_init(MachineState *machine)
     create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
 
     /* Load kernel */
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
     if (machine->kernel_filename) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr,
-                                         true, htif_symbol_callback);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, htif_symbol_callback);
+        kernel_entry = boot_info.image_low_addr;
     } else {
        /*
         * If dynamic firmware is used, it doesn't know where is the next mode
@@ -317,7 +319,7 @@ static void spike_board_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
                                            memmap[SPIKE_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 98da79a5be..d2bfdec56a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1434,6 +1434,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
+    RISCVBootInfo boot_info;
 
     /*
      * An user provided dtb must include everything, including
@@ -1482,17 +1483,19 @@ static void virt_machine_done(Notifier *notifier, void *data)
         }
     }
 
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
     if (machine->kernel_filename && !kernel_entry) {
-        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
-
-        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
-                                         kernel_start_addr, true, NULL);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
+                          true, NULL);
+        kernel_entry = boot_info.image_low_addr;
     }
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
                                            memmap[VIRT_DRAM].size,
-                                           machine, &s->soc[0]);
+                                           machine, &boot_info);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
-- 
2.47.1


