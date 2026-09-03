Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A0C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20OC-0007FE-RT; Thu, 03 Sep 2026 01:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20O7-0006tY-PD
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:28 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20O6-0006Ub-2t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:27 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so2661869a91.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414804; x=1789019604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYttDmg2r4bFrMHv9SJAbeD+cu8jH7R+zt2RRkb6f7M=;
 b=jAp9lRF+hS+KnO/RoR7vz7e9JaDlMMZruGyNYvbH6tiO6d1kMJzJppsD0sQr4c012j
 jHRG0HixzC7WtujL3QhSSIivO8mXUu3FjO7Y7Thulo1gkf0Lb219mpwD85s+6I55TXqa
 BzhuFW+owTmvzaeUn1GividQqe0dB1NpLWG6xuo4SQDaINjMW313OK8Mw8C0ZDiVxyEO
 mBAMX3OL1cJsExGJeBje//o6Pgi98XC1WMz4EysOKD5jQOatVYPWHHNWmTaU87b8KsuF
 vvs9FyaHWI1DDpsQouJ+widk3u/gQ2xqHJfffsfIRjTaDdq2eBct5pDJyrPZ3OhKyLyS
 6AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414804; x=1789019604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYttDmg2r4bFrMHv9SJAbeD+cu8jH7R+zt2RRkb6f7M=;
 b=b9/OQDS6kP/SkEl/ybS8hxteW3mPR1op/wgrQh31g2DLkRr5N2K+wYKxVtfgMcjLLc
 lmhHib67OIvcf1IXn3kKRBtcYvhE7PgiCF+QzTUs00JFjkaSQ9VQclnyJNrnXfagCkzR
 JvZKrsP/QPDK37+UCJ8ZPjd1grPzJWUtVi+32q8/4WtdhXmHmF6mg+tq5HH5oy1hYBWv
 nDcI5HZ2wODWoKG9Eg27kftgz++SY4HBxHKgjpVPxmmAkD6j/81sdB0OMYH3vI/1hvFo
 yHzFfDLt4Wisi202waeZ5TEcTArPl0IE4QWvR44ObIXHHp1YvnXceHHDyzS5T2y9183x
 F4yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4URBwLTXKSTf5hLlffZGfyMsUalXvRDAy+pfXsxQRoBzfKW3Ivl7SDfFJ2ZaOHTanBLysJtBcAcOv@nongnu.org
X-Gm-Message-State: AFuF++nUS+13nG0dwXBTWR/QgYzIJbI5QA6KQFGzrKyxa+anxVjVYLJU
 mlSJp0X+QtD2NGjo08Hqonqcf24wXPYcIETQq9GhIxsvQOWENwUmje6/
X-Gm-Gg: AYBFou11CIMfGYBxbaNj65i3LW5r84s+JjP0p2eRv0hgAIGiP1hx7+b4Q5AYfwbYKE5
 JU11Zd6d1OHy93Jm0IzkJEuEbgxzOBpxSaJoy1wt8vQ+UsB6V832ElPkeMRZ/5EKCMh6LcNJt/N
 4O70jmNKm+Dmma/Ghd8YqrDKa9HIe0znJESOIKJsso3hvJ00F2cnM+y6roapmFDtm1QSyyhrusc
 VrIb+wevrhRfkdThmnrKCQpIpeyQ9bXPD34nTpa+52M4897wYvQL5SzkiraHfMtveiJLZp3XZ6l
 O4D9Iqu7Kv367oSgmgfHrFHTf2tgIZywaCgxGMKfQXln2fxW9ZVzm7foQdTXBFE0B4jVeSaVZWM
 hXSEH1Qtb0W0vIJA4ju2A1wANMNnz/JcyYA0TnNLTv7ACVGbU1U9Zqkc60sNYkxzUm9AfFwQHct
 6nQLMmjblEb1ySdhMCACg64o6k7PbDP2wGByTwO/ceShstK6S4fcwYBY2qsEjQXgDc8ZF7zM6tS
 EgLS9fAtD9dI/c8wI6Yhy0exEDir1rM6xryzPrecDXOVudG0tKGCMqyocgIxy3jYzGJUGCMWCHJ
 E+ZkW5Od45clIs8cP0VT
X-Received: by 2002:a17:90b:2f04:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-39aee165cf5mr16401208a91.13.1788414804409; 
 Wed, 02 Sep 2026 22:53:24 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:23 -0700 (PDT)
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
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 11/16] hw/riscv/atlantis: Use local reference for system
 memory
Date: Thu,  3 Sep 2026 15:21:25 +0930
Message-ID: <20260903055131.257903-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1034.google.com
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

Instead of system_memory, attach devices to TTAtlantisState::memory in
preparation for the ->memory becoming a container.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  1 +
 hw/riscv/tt_atlantis.c         | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 642490d21743..a29c67c1cfcf 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -29,6 +29,7 @@ struct TTAtlantisState {
     Notifier machine_done;
     const MemMapEntry *memmap;
 
+    MemoryRegion *memory;
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index f2a4a051d1f6..2a70119c2c6b 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -483,13 +483,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
 {
     TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
 
-    MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
     MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
     MemoryRegion *bootrom = g_new(MemoryRegion, 1);
     ram_addr_t lo_ram_size;
     int hart_count = machine->smp.cpus;
 
+    s->memory = get_system_memory();
+
     s->memmap = tt_atlantis_memmap;
 
     object_initialize_child(OBJECT(machine), "soc", &s->cpus,
@@ -505,7 +506,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
 
-    s->irqchip = riscv_create_aia(system_memory,
+    s->irqchip = riscv_create_aia(s->memory,
                                   true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
@@ -518,7 +519,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(system_memory,
+    riscv_aclint_mtimer_create(s->memory,
             s->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
@@ -541,23 +542,23 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
     memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
                              0, machine->ram_size);
-    memory_region_add_subregion(system_memory,
+    memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_HI].base, ram_hi);
 
     lo_ram_size = MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size);
     memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
                              0, lo_ram_size);
-    memory_region_add_subregion(system_memory,
+    memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_LO].base, ram_lo);
 
     /* Boot ROM */
     memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
                            s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, s->memmap[TT_ATL_BOOTROM].base,
+    memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 bootrom);
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
+    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     /*
@@ -571,7 +572,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
      */
     object_initialize_child(OBJECT(s), "uart1", &s->uart1,
                             TYPE_UNIMPLEMENTED_DEVICE);
-    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
+    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
                            "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
                            s->memmap[TT_ATL_UART1].size);
 
@@ -583,7 +584,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                 TYPE_DESIGNWARE_I2C);
         sbd = SYS_BUS_DEVICE(&s->i2c[i]);
         sysbus_realize(sbd, &error_fatal);
-        memory_region_add_subregion(system_memory,
+        memory_region_add_subregion(s->memory,
                                     s->memmap[TT_ATL_I2C0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
-- 
2.47.3


