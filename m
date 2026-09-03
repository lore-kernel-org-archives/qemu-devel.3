Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EFEC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20OG-0007Wv-8v; Thu, 03 Sep 2026 01:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OD-0007J8-EZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:33 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OB-0006V8-N6
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:33 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc1a4c62804so1933795a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414810; x=1789019610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MaHj2HowZCWhtPsZkI2qVF6kAeDGq/nORPPomR0v2Cc=;
 b=g1C8o5MacZcQpmU7wqC2YyTb5b+mW28iEYnInPpmP7NvWITFbBNLuJk+ZCCA6G6ZB5
 TSbCzx3tUplET8Hwwlo3uThVegG4TAIZozyuQhd/aLy9E+D5SDKz6J28S/xPQtVAqUAp
 N8nCuwC9R3rsejdm293RL0ViXj5VLJ0d+ZOnNxMqHu+Bp56hIB4rVigmbyqSZ56/ceMW
 GgLAHPM8mmv/XeHq1CwIFRpA7DJ3AstJXcNWMhEQyYFuCfKy5bgFZgHKcJEUEbo8XjTe
 V4AicHGBIvlIP8PZJjtIjR0HzLxjvW9Svos6nWsgmnXNbKE1dwY3YcYd1DS0r9V3Hugm
 r5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414810; x=1789019610;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MaHj2HowZCWhtPsZkI2qVF6kAeDGq/nORPPomR0v2Cc=;
 b=O8bv5q/WwzxXYCm+459pxu9I+c2uLYg5aDOYvzk+sV8aZT4gjEuhgl1ZBg+uKCXmAg
 SymiAl5PvAU8iWrYxJhP0eL9baKw8+77G9vSybqTPrVik4JV7jEpS21aDTRUJrwf7iHN
 2hl4ywj1vbnM14raJW82FU/gCR+b+L2D9vdTLNec44c0AF8R4FXbJZf8pC5dnBs0vRF9
 JXK58uv/ku6MTUBFjJLc6GP3SleP294ijUirVJJLfw9G7YthLIlAExKddQf2CLDAPtl6
 ComzAaYG3vK3EjTRp+nqSTLb3VXP+pfFC45jhL10/daeCfenJhWwYnQ4dS9EdOaRobYi
 jnjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwrCNunJppBpnn/Xd1yUU0RAqdHSWgu0MP+1VdVr6vAOTSPIRig0Mig7/HzRPNxqaxKRmyF9ro3Kiv@nongnu.org
X-Gm-Message-State: AFuF++kVW8DsNKrG6GJtrj4UK3o5MpYNzx/pxPrTU+iKRkST+hLFkgJ8
 9ecBnE4RBTptfubcU8yPEdEdlZRKqVBTiNW51Jn4plbPGgARQISReex7
X-Gm-Gg: AYBFou3uJr/t8eWxWh7XUWI752hJbxQdKC9VBoRpFRZfI9W3G+MVss3w4LP0+VetGgM
 qGFEedeftUGWizzFpNVD9aVm3N/f9FtSAJG/TqgRcnMd5YPJttXIBrFN6XDwjXdXc85d0pdeYmq
 ASWvl7mTsgbUCH+wxDhe30gUzsMrvtqCZjfNBqyNarNPOAlrZcf+eI8K4MUwBQjKKqBrb40Wfou
 w0xiKj0zHxp/SKyvUxdVBNk4+JVcoyiWMj3BLi/qSBsrvPIf8ZAglGxtpLg5y1OLU48JmJRjBVs
 L9cFV3ZF5LYfZxI/BpXtYZbetx5uo4YQ90oHjWfhCBAfUDtpg7L1csAGg68arxNqlBIu+XDTapt
 lopX5sSWMaZb1wg6WoTMC4nZygG9EQ4yzjROZrce9wqswziOV5OQhfV15PGEJEGD376CwmDlne/
 MHTao/LIKIAMPpRTpZxyNoX+KxloVMVngFXJ6sFBkqtuQpmY1+pv5xNtavGVcGEPS8ULhGBzHyB
 ReINiJL59DXGmnmazlqki7+y0qET2mZmCO5vnSvn0yHvEZkiURXfUsyULamT3xfl3HPDUJMMsDT
 adhtEXG+eWpb0byz0ZcHpJfNNfwmB+g=
X-Received: by 2002:a05:6a21:9f17:b0:3d3:ad3c:49a8 with SMTP id
 adf61e73a8af0-3d9ae7e0913mr15697142637.22.1788414810140; 
 Wed, 02 Sep 2026 22:53:30 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:29 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 12/16] hw/riscv/atlantis: Decouple RAM size from
 MachineState
Date: Thu,  3 Sep 2026 15:21:26 +0930
Message-ID: <20260903055131.257903-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52c.google.com
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

Keep a reference to the machine's RAM MemoryRegion in TTAtlantisState,
and get the MemoryRegion's size where the configured RAM size is
required.

This allows reading the RAM size without needing a pointer to
MachineState, decoupling the memory layout setup from the machine.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  1 +
 hw/riscv/tt_atlantis.c         | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index a29c67c1cfcf..2ec283d0fd7b 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -30,6 +30,7 @@ struct TTAtlantisState {
     const MemMapEntry *memmap;
 
     MemoryRegion *memory;
+    MemoryRegion *dram;
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 2a70119c2c6b..90b8e1bc904a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -82,12 +82,13 @@ static uint32_t next_phandle(void)
 
 static void create_fdt_memory(void *fdt, TTAtlantisState *s)
 {
-    hwaddr size_lo = MACHINE(s)->ram_size;
+    hwaddr ram_size = memory_region_size(s->dram);
+    hwaddr size_lo = ram_size;
     hwaddr size_hi = 0;
 
     if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
         size_lo = s->memmap[TT_ATL_DDR_LO].size;
-        size_hi = MACHINE(s)->ram_size - size_lo;
+        size_hi = ram_size - size_lo;
     }
 
     riscv_create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base,
@@ -486,11 +487,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
     MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
     MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
     MemoryRegion *bootrom = g_new(MemoryRegion, 1);
-    ram_addr_t lo_ram_size;
+    ram_addr_t lo_ram_size, ram_size;
     int hart_count = machine->smp.cpus;
 
     s->memory = get_system_memory();
 
+    s->dram = machine->ram;
+    ram_size = memory_region_size(s->dram);
+
     s->memmap = tt_atlantis_memmap;
 
     object_initialize_child(OBJECT(machine), "soc", &s->cpus,
@@ -533,20 +537,20 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * The high address is where RAM lives. It is always present and may be
      * up to 64GB. The low address is an alias of the first 2GB of that RAM.
      */
-    if (machine->ram_size > s->memmap[TT_ATL_DDR_HI].size) {
+    if (ram_size > s->memmap[TT_ATL_DDR_HI].size) {
         char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
         error_report("RAM size is too large, maximum is %s", sz);
         g_free(sz);
         exit(EXIT_FAILURE);
     }
 
-    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
-                             0, machine->ram_size);
+    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", s->dram,
+                             0, ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_HI].base, ram_hi);
 
-    lo_ram_size = MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size);
-    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
+    lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
+    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", s->dram,
                              0, lo_ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_LO].base, ram_lo);
-- 
2.47.3


