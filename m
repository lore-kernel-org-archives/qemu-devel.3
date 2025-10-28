Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7254BCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeZw-0002p5-JM; Tue, 28 Oct 2025 03:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeZu-0002i7-FM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:57:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeZp-0008DB-RJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:57:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso58946785e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638227; x=1762243027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymV3SGVrH7y3KZx6sZDf7SmKtbSYLXVGt7ImLouOcxk=;
 b=lppCBn1QGoDHNoAnMPZQCEFofJEC8Gliu3276u/Vv6ywA1LFv0NLwHoRUXTPXa8Qzj
 u/+H9vft4cR7iGlGJEz+WEzvJxw9o5qN9sLk1gXgD8LLlYT7cgoJjqYFUxxkR0EDxfjD
 tQP3yv6bcDqwOxDEVqIDn/LgmC7duMZmPfVVc8hsorJ8qjm4kRA8TiAAr01YyHYUT8zz
 SEoFSvd646hDp2p5vecTLlctxgAsE53gd1lFDUTDh/t5sMgfZtdeum76RGECM3xlA20h
 8zK7SVddDVsfLzmdBKX8GCc4ICY1O9cwmH98DeBk67EpdGwWhH25FezkhYrzfYzDohD1
 GUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638227; x=1762243027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymV3SGVrH7y3KZx6sZDf7SmKtbSYLXVGt7ImLouOcxk=;
 b=H+Y3v210TJAnSb+MBAnDD5rjMv3hWT88CcsEFX+uVuPgvu4n+FTqyHRAvLQPI9R5Ib
 k2ZwxQQpLoWiBC5mo42d8nv3BS29Ywks414Ouw4qnrJ9x1pJDlcSPA3Ws3Fu77y2j3Y9
 yiIpyAXUDdVP3m5nMuXF+AaPMfFsIuB5wOLRzUceQ4kBp5hf984kzM//7QfuCaSr+67n
 QMCkyFCx+EA7PY5vaLKbXtbL38pLKo/Vy1tBUTbSScJgB5yeVij+aRQ+A4g3nwK+JCyG
 HnOEiQmblNSp/VEYtEKeRsYo4F2X9TZZ9vOHQslmgT19pdYO+Ktk2FVOOyHCo5ILT26L
 qTBw==
X-Gm-Message-State: AOJu0YwnBJq6W7fYE6NfyerWp2TXNkhU99VuXIdLnUOib3IAU0Q7dbQ/
 yRo6SR93HsM+UhPXrqj45ULh7uavqk5jatZFniJ90S5Q1H0e8TTuXC9g8RidYK6sRtjtUsFHtzg
 xoe2Q3CQ=
X-Gm-Gg: ASbGncuSxcA16b7+cngRMnXsN4HGlXFAofNymp7DN0jnDuBSo3/50k4CvnLxhgM+oGd
 tXwNEdheSiDACtKcEhjmxYNbCJJampbEfpzvOCCgy9jREV5BwiC1X8zw41TwzrjvsfRsAfh8J9m
 N1oMPXpcX7N4+uR+qtZIZLEcBgRyEv3kepgm/Nx9pYvqcpT8+IBQg/szlRV9qKq0jZsQ/ZWf8Yi
 tgYh/FS2Z94aE2Me573HPAdyMdjHFX8B2Q+NhrA7WsGAtIvKIm3mbgTPJ0pJSDrf80kep9qRNED
 6GaAG3rTNk+cfJy8B0cBYnlJ4A8Xz7rZMyRUtn781iqSmyL159vU1YcZdBy/O5uJbYg1GUB06bT
 YUa/XwLpacSeS8tYlIOkoMvGVaeJzDnT6iR9oLSWDijHkTamAh0Ijt0aKiSBi/PP3aFETlFD8R5
 hKLOroosVEry6xjuXVPFzzVz29COQhQ4uq4J3Gm/hKfxMc0VmHMEtsKqQ=
X-Google-Smtp-Source: AGHT+IEzcyi+jhyoxtulko/ZZogKg9aFYfACORxzD4PKHmKAydH8ZwXLh3/UXSeuEF++JcSKy2mc+Q==
X-Received: by 2002:a05:600c:4ed4:b0:46e:3cd9:e56f with SMTP id
 5b1f17b1804b1-47717df9e5emr23815245e9.6.1761638226510; 
 Tue, 28 Oct 2025 00:57:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4a36easm181602685e9.10.2025.10.28.00.57.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:57:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PULL 22/23] hw/riscv: Use generic hwaddr for firmware addresses
Date: Tue, 28 Oct 2025 08:48:58 +0100
Message-ID: <20251028074901.22062-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20251027-feature-single-binary-hw-v1-v2-1-44478d589ae9@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Do not update riscv_load_kernel()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/boot.h    | 18 +++++++++---------
 hw/riscv/boot.c            | 20 ++++++++++----------
 hw/riscv/microchip_pfsoc.c |  2 +-
 hw/riscv/sifive_u.c        |  2 +-
 hw/riscv/spike.c           |  4 ++--
 hw/riscv/virt.c            |  2 +-
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 7d59b2e6c63..51b0e13bd3e 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -43,18 +43,18 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
-target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                          target_ulong firmware_end_addr);
-target_ulong riscv_find_and_load_firmware(MachineState *machine,
-                                          const char *default_machine_firmware,
-                                          hwaddr *firmware_load_addr,
-                                          symbol_fn_t sym_cb);
+hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                    hwaddr firmware_end_addr);
+hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    const char *default_machine_firmware,
+                                    hwaddr *firmware_load_addr,
+                                    symbol_fn_t sym_cb);
 const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
 char *riscv_find_firmware(const char *firmware_filename,
                           const char *default_machine_firmware);
-target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr *firmware_load_addr,
-                                 symbol_fn_t sym_cb);
+hwaddr riscv_load_firmware(const char *firmware_filename,
+                           hwaddr *firmware_load_addr,
+                           symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
                        target_ulong kernel_start_addr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index f38078c8c22..9510fca939b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -74,8 +74,8 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
     info->is_32bit = riscv_is_32bit(harts);
 }
 
-target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                          target_ulong firmware_end_addr) {
+hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
@@ -133,13 +133,13 @@ char *riscv_find_firmware(const char *firmware_filename,
     return filename;
 }
 
-target_ulong riscv_find_and_load_firmware(MachineState *machine,
-                                          const char *default_machine_firmware,
-                                          hwaddr *firmware_load_addr,
-                                          symbol_fn_t sym_cb)
+hwaddr riscv_find_and_load_firmware(MachineState *machine,
+                                    const char *default_machine_firmware,
+                                    hwaddr *firmware_load_addr,
+                                    symbol_fn_t sym_cb)
 {
     char *firmware_filename;
-    target_ulong firmware_end_addr = *firmware_load_addr;
+    hwaddr firmware_end_addr = *firmware_load_addr;
 
     firmware_filename = riscv_find_firmware(machine->firmware,
                                             default_machine_firmware);
@@ -154,9 +154,9 @@ target_ulong riscv_find_and_load_firmware(MachineState *machine,
     return firmware_end_addr;
 }
 
-target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr *firmware_load_addr,
-                                 symbol_fn_t sym_cb)
+hwaddr riscv_load_firmware(const char *firmware_filename,
+                           hwaddr *firmware_load_addr,
+                           symbol_fn_t sym_cb)
 {
     uint64_t firmware_entry, firmware_end;
     ssize_t firmware_size;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4c939d8e96c..a17f62cd082 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -521,7 +521,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t mem_low_size, mem_high_size;
     hwaddr firmware_load_addr;
     const char *firmware_name;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr, kernel_start_addr;
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3e1ed209ca9..a7492aa27a4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -515,7 +515,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     hwaddr start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr, kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
     uint32_t fdt_load_addr_hi32 = 0x00000000;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 641aae8c019..b0bab3fe008 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -197,9 +197,9 @@ static void spike_board_init(MachineState *machine)
     SpikeState *s = SPIKE_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    target_ulong firmware_end_addr = memmap[SPIKE_DRAM].base;
+    hwaddr firmware_end_addr = memmap[SPIKE_DRAM].base;
     hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
-    target_ulong kernel_start_addr;
+    hwaddr kernel_start_addr;
     char *firmware_name;
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 47e573f85ab..17909206c7e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1434,7 +1434,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     MachineState *machine = MACHINE(s);
     hwaddr start_addr = s->memmap[VIRT_DRAM].base;
-    target_ulong firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
-- 
2.51.0


