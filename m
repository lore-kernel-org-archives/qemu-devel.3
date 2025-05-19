Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECEEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs2p-0000Pc-Uj; Mon, 19 May 2025 00:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmw-0004m3-U8
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmv-00049p-12
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23035b3edf1so31814145ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627659; x=1748232459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ33rutGsbxPMjM9pnehuUNs+p/NJdxcEzcKEdKerGU=;
 b=lX1gdTI27pjl6yTji7fchVXXieLoWRjt8MSBIDaaVBjtnP6vgwZKLw91vCe3/culbN
 NNNGsFu+afOHvEP/oVkD+uJsjmmw/M+NCZHEYAQMUhDvBK5LBbtWJ7PdKIXPn+QpTy5G
 UU6o6sknaH55m0XAX99TA+d17IpK0rfqq9SRh4eOu4hXNqKYpxXejL0z1bLzjmpTdLKo
 BSrMCLl79BWuCyzumjHn1795WaMqf0yiq1lo1DpAnY6MEdO60+OFJrdLeEddWSzlI9BO
 jkWfLVQslH3BDGfA2af59am1ZrkNLQii/5yLakOk6OwkutbY9sXFBqRyMstlCvsG5+9g
 slcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627659; x=1748232459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZ33rutGsbxPMjM9pnehuUNs+p/NJdxcEzcKEdKerGU=;
 b=jtRVEQOl2fm+TArru3j7toqGn4ww9DE3KXAgIXYccSFJvy1FGLwWaHOstiNu+qURyF
 XKsxsk9htzNw83A42kRjRFNOjJmtCxog0txsv0oi2GHzaVecYAAfwYBcwtfx2J7XQIbG
 g8CTe+RR6Rtjyu3HFOFLmK/Qd8uoHaMCVER37aDkq4G1suGVf7GNw5DAiD1RQ02qIdsi
 mw184IjGl0PjcMcG3nZqZmBQ1aovsd5HDsEgE4xke6vkMVXJX/Kjw1Tzp/plgRoCjNYw
 mLNj9zRkiBwRsZfn+S71ZdSJRHVOMtk+Ll6brQ2rTcv1wZsxO2L6HmqUgw5t8LFKS2ya
 g6ig==
X-Gm-Message-State: AOJu0YxVlMBSS7NCZYsUdQtFsfDBQqb7sSyPqQcHL/VdyB6ZW4XIREjK
 RipAMEYpkp87XKAlxjugERF4JIu03tq2fQr5zK4b3VgQkwYQe5Tieglq2hJgBQ==
X-Gm-Gg: ASbGncvEpslHu+SwMKPcwrqKMhV1E1vy9k7rQf9oR8qmsuKu3nO9xF4nctvkRDG5K78
 XgYhMVDzJLrdMZd1DfguIAqa7KXbFyNE+jXzAB2AUt4E/WVKr0z+PIni9E29ogglZCF9G1BwK48
 rfvp3aGkypH6RqMqXqukQ324EbJhGSwS4DW0a1B7394IzdSZ0PYmT+opMUtQrR/CEQZ62LoXFkW
 7b/+pkHX9wKhb9ImA6Ltxl3bhFxojJz/hn0X+yM+qniURH9jOAvgBg++33OkLxNtCdX/kgpAFWl
 TxYhnp5yxnbcfxEvCiapO5/q/PVhUXNxT9fIbhZS/uUw7Xxm+Qj5l75AwmAvBzSDojv/S19Mqmy
 9p0wszY/g4Icv+HyGeId4njaL+zyGncAboNbhs0SgLwBl8N+NtOx6WZ5e
X-Google-Smtp-Source: AGHT+IF+kxuk5YO/dYQUxeC7HZHz3aI6q3kU47TpY+TRTIBmRwGLMjUu4NfPGd6oRYCDnvA1b6cdrw==
X-Received: by 2002:a17:902:c951:b0:22f:d47e:c6dd with SMTP id
 d9443c01a7336-231d439e08cmr145225575ad.13.1747627659305; 
 Sun, 18 May 2025 21:07:39 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/56] hw/riscv: Make FDT optional for MPFS
Date: Mon, 19 May 2025 14:05:08 +1000
Message-ID: <20250519040555.3797167-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

Real-time kernels such as RTEMS or Zephyr may use a static device tree
built into the kernel image.  Do not require to use the -dtb option if
-kernel is used for the microchip-icicle-kit machine.  Issue a warning
if no device tree is provided by the user since the machine does not
generate one.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 6bb44e3ac5..b8a8d5251d 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -516,7 +516,6 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t mem_low_size, mem_high_size;
     hwaddr firmware_load_addr;
     const char *firmware_name;
-    bool kernel_as_payload = false;
     target_ulong firmware_end_addr, kernel_start_addr;
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
@@ -589,25 +588,12 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
      *
      * This ensures backwards compatibility with how we used to expose -bios
      * to users but allows them to run through direct kernel booting as well.
-     *
-     * When -kernel is used for direct boot, -dtb must be present to provide
-     * a valid device tree for the board, as we don't generate device tree.
      */
 
-    if (machine->kernel_filename && machine->dtb) {
-        int fdt_size;
-        machine->fdt = load_device_tree(machine->dtb, &fdt_size);
-        if (!machine->fdt) {
-            error_report("load_device_tree() failed");
-            exit(1);
-        }
-
+    if (machine->kernel_filename) {
         firmware_name = RISCV64_BIOS_BIN;
         firmware_load_addr = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
-        kernel_as_payload = true;
-    }
-
-    if (!kernel_as_payload) {
+    } else {
         firmware_name = BIOS_FILENAME;
         firmware_load_addr = RESET_VECTOR;
     }
@@ -617,7 +603,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
                                                      &firmware_load_addr, NULL);
 
     riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
-    if (kernel_as_payload) {
+    if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
                                                          firmware_end_addr);
 
@@ -625,19 +611,33 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
                           true, NULL);
         kernel_entry = boot_info.image_low_addr;
 
-        /* Compute the fdt load address in dram */
-        hwaddr kernel_ram_base = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
-        hwaddr kernel_ram_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
-
-        if (kernel_entry - kernel_ram_base >= kernel_ram_size) {
-            kernel_ram_base = memmap[MICROCHIP_PFSOC_DRAM_HI].base;
-            kernel_ram_size = mem_high_size;
+        if (machine->dtb) {
+            int fdt_size;
+            machine->fdt = load_device_tree(machine->dtb, &fdt_size);
+            if (!machine->fdt) {
+                error_report("load_device_tree() failed");
+                exit(1);
+            }
+
+            /* Compute the FDT load address in DRAM */
+            hwaddr kernel_ram_base = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+            hwaddr kernel_ram_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
+
+            if (kernel_entry - kernel_ram_base >= kernel_ram_size) {
+                kernel_ram_base = memmap[MICROCHIP_PFSOC_DRAM_HI].base;
+                kernel_ram_size = mem_high_size;
+            }
+
+            fdt_load_addr = riscv_compute_fdt_addr(kernel_ram_base, kernel_ram_size,
+                                                   machine, &boot_info);
+            riscv_load_fdt(fdt_load_addr, machine->fdt);
+        } else {
+            warn_report_once("The QEMU microchip-icicle-kit machine does not "
+                             "generate a device tree, so no device tree is "
+                             "being provided to the guest.");
+            fdt_load_addr = 0;
         }
 
-        fdt_load_addr = riscv_compute_fdt_addr(kernel_ram_base, kernel_ram_size,
-                                               machine, &boot_info);
-        riscv_load_fdt(fdt_load_addr, machine->fdt);
-
         /* Load the reset vector */
         riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load_addr,
                                   memmap[MICROCHIP_PFSOC_ENVM_DATA].base,
-- 
2.49.0


