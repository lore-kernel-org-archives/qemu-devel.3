Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C5E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bG-0005Ym-M1; Wed, 18 Dec 2024 17:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zw-0003hL-2Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zu-0003KK-0F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:39 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21654fdd5daso1605725ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561095; x=1735165895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z509UPTD57WEr7p8VYSXhGl+qC0HoPatf4mTzR73rZo=;
 b=OdIn0ybGZAq1FAUT6iRWRXY/fgArUN4fzwLmxCUfT9VZ5QuhNekYdAm8FpUQ7sFm7m
 ZH+JOJqD/898z//7b9lOUGczwLBIV2cmUx+TPSABe/NCYCRF2hXu3NIjjx6tCd6NSlCG
 7HE0pupT4eKhIu9JY/Pl9qSYWCcTU1NaQ5yFmqfXaCVlMeQjMobZHr7kZJa5HsklYJEb
 9102NTtfq9Zy4E2GMp/t8P9kVM/sTCW4MwySJvrASNuNuGtgMSXuGoDs3ojC4dFDwW8W
 Y9qOinwufPxsPDoX3b69lKJ/43CxlyNCC7DTBB42SmZHtrkyAVju+a2ICrh3DPHVfu7A
 LC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561095; x=1735165895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z509UPTD57WEr7p8VYSXhGl+qC0HoPatf4mTzR73rZo=;
 b=X4z04kkiW154eABzJyxga9KKDQebyOF5amovxavaUbE0E6QCKHNvkc1Q/LInyDOHxA
 j0BEjpgCnJdJ1i/cz0EKHfpQFmzhEiOHzPN4wW1+xB4Mvr2JsPXTGrLKJ3qsQswFn7NP
 MAGsMQCmQiZpV9zAma5fyaSL7WqI/Mpp7LBBMQqSaYszXEKQpRdio922hlZQIziW3tK3
 Z5Ce+9j2fcTMMf+wMwZMJ7p/4yQm76To8hmAVyNwCMnDXsI5TZkvvV1rzAj+0xShcLHF
 YP4HkinKQhc3E6L1YPRgvlP7yPQr4dvU8AfeKmTARV2LE8cF4+O1AX8IoDD1MAsAD3UO
 C7ng==
X-Gm-Message-State: AOJu0Yyjnfefj6w9tnOBQYCCKU04qtgqgQbFuNJHl6YCnZT0hJWprHd6
 GNQr1CbvkioOqN35g+F95dAw9C82sGbMtZgNnj45/YfbT8oLWVCrVU9rAbxU
X-Gm-Gg: ASbGnctY6zZt5rVaQkoyeKc3ysvuWyro9dJn/2vETTO4UZuFS6cx1vKV6TOJgaHi/Wd
 Wy2j/k3pL62flGqM1l44h33DNcq0vnbA0oBEwZHd+gxxkHX4orIhVwOJa+/9mm6OKJrof6klKYT
 Qcw/yD7LP8OuTkYxlm9ahEGsvTIS6GT26miutKyp0k7lcACwqRmMa+X0QSj6xwAD9thaVwekNz3
 5b9o1gL80S3E40tifbeVYs1cHeHk1jaxR4hVQ7//+cACck4d1kTCZ5/T77F26f5cXcZMBvdXmdB
 U6KvJXLCcMr6s0IswhKYS8uRchx4NhYJxRXT1DfWZsOQt4RuPhDZzw62tROd3N4=
X-Google-Smtp-Source: AGHT+IHgZeg9AFjNOwrO2hZw+XLL6ZzLDhD12ggJocUZomz8XDMpmgTbZtgmDFiUIGpS9QmapWTp8Q==
X-Received: by 2002:a17:902:e546:b0:216:3e9a:89e with SMTP id
 d9443c01a7336-218d725a7b1mr56117815ad.35.1734561094588; 
 Wed, 18 Dec 2024 14:31:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 26/39] hw/riscv: Support to load DTB after 3GB memory on 64-bit
 system.
Date: Thu, 19 Dec 2024 08:29:56 +1000
Message-ID: <20241218223010.1931245-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
system doesn't have 32-bit addressable issue, we just load DTB to the end
of dram in 64-bit system.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241120153935.24706-2-jim.shu@sifive.com>
[ Changes by AF
 -  Store fdt_load_addr_hi32 in the reset vector
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h    |  2 +-
 hw/riscv/boot.c            | 14 +++++++++-----
 hw/riscv/microchip_pfsoc.c |  4 ++--
 hw/riscv/sifive_u.c        |  8 +++++---
 hw/riscv/spike.c           |  4 ++--
 hw/riscv/virt.c            |  2 +-
 6 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f778b560de..34a80c5ff4 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -49,7 +49,7 @@ target_ulong riscv_load_kernel(MachineState *machine,
                                bool load_initrd,
                                symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
-                                MachineState *ms);
+                                MachineState *ms, RISCVHartArrayState *harts);
 void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr saddr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 2e319168db..d36d3a7104 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -293,7 +293,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms)
+                                MachineState *ms, RISCVHartArrayState *harts)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
@@ -317,11 +317,15 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
 
     /*
      * We should put fdt as far as possible to avoid kernel/initrd overwriting
-     * its content. But it should be addressable by 32 bit system as well.
-     * Thus, put it at an 2MB aligned address that less than fdt size from the
-     * end of dram or 3GB whichever is lesser.
+     * its content. But it should be addressable by 32 bit system as well in RV32.
+     * Thus, put it near to the end of dram in RV64, and put it near to the end
+     * of dram or 3GB whichever is lesser in RV32.
      */
-    temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
+    if (!riscv_is_32bit(harts)) {
+        temp = dram_end;
+    } else {
+        temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
+    }
 
     return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
 }
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f9a3b43d2e..ba8b0a2c26 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -519,7 +519,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     bool kernel_as_payload = false;
     target_ulong firmware_end_addr, kernel_start_addr;
     uint64_t kernel_entry;
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
 
     /* Sanity check on RAM size */
@@ -625,7 +625,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         /* Compute the fdt load address in dram */
         fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                                memmap[MICROCHIP_PFSOC_DRAM_LO].size,
-                                               machine);
+                                               machine, &s->soc.u_cpus);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
         /* Load the reset vector */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 124ffd4842..fd59124500 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -518,8 +518,9 @@ static void sifive_u_machine_init(MachineState *machine)
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
+    uint32_t fdt_load_addr_hi32 = 0x00000000;
     int i;
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     uint64_t kernel_entry;
     DriveInfo *dinfo;
     BlockBackend *blk;
@@ -606,11 +607,12 @@ static void sifive_u_machine_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
                                            memmap[SIFIVE_U_DEV_DRAM].size,
-                                           machine);
+                                           machine, &s->soc.u_cpus);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     if (!riscv_is_32bit(&s->soc.u_cpus)) {
         start_addr_hi32 = (uint64_t)start_addr >> 32;
+        fdt_load_addr_hi32 = fdt_load_addr >> 32;
     }
 
     /* reset vector */
@@ -625,7 +627,7 @@ static void sifive_u_machine_init(MachineState *machine)
         start_addr,                    /* start: .dword */
         start_addr_hi32,
         fdt_load_addr,                 /* fdt_laddr: .dword */
-        0x00000000,
+        fdt_load_addr_hi32,
         0x00000000,
                                        /* fw_dyn: */
     };
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index fceb91d946..acd7ab1ae1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -201,7 +201,7 @@ static void spike_board_init(MachineState *machine)
     hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
     target_ulong kernel_start_addr;
     char *firmware_name;
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     uint64_t kernel_entry;
     char *soc_name;
     int i, base_hartid, hart_count;
@@ -317,7 +317,7 @@ static void spike_board_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
                                            memmap[SPIKE_DRAM].size,
-                                           machine);
+                                           machine, &s->soc[0]);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 43a1c86c33..98da79a5be 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1492,7 +1492,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
                                            memmap[VIRT_DRAM].size,
-                                           machine);
+                                           machine, &s->soc[0]);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
-- 
2.47.1


