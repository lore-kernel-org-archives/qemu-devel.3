Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A086AC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLrA-0001q9-0M; Wed, 26 Aug 2026 18:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLr6-0001pL-PX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:25 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLr3-0006a6-SV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:24 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1d57602e8so332225a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787782340; x=1788387140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQBiGju903XJawObkTSJlI2w6oNi2YYpQ1UlpzmMJzE=;
 b=FqgH8j2dkEyFnGRpoiFmzEErzsll0M0QYtIAb1TtlnhTHqPhBmpxQ6YJ629HBB6d+V
 n2zlCi+hTDbggecQYP3NB//wvuBVz11oYQt+rcPiVgnTFkd12fYnrkMLrh3r/2RtfcYV
 erDbNveQ9Qo5DupJ6hJvMVe5M6swp8p26mLOWfoOxDb+UmHt3VwO0a/gqA2eouQ62efO
 PPguOw15dJf156ElOFnYtdMa9OTadkbklCkUHCV29lMMBjkYc5rggmKxWq5KNjrDUUs5
 5hS8TXrKSJTUaakDC+Q8Oud/gqU6QbgggDLMdSW7CQ/nunbqDB1EeXn4bT2gVnnP3o3g
 a4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782340; x=1788387140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQBiGju903XJawObkTSJlI2w6oNi2YYpQ1UlpzmMJzE=;
 b=nyFUraF8N5slJKugx9WJlytkx4U6O/nzrFI89vPJcJ15Wri9SZvC7lo0796bpilk8k
 hYMvPGqMF+cV1nBJjZ49D1/70jkuWoR4kPEotRR+kv9o+XHowlcUTDJxx3fPekiGwL/6
 mt7sycWzIyPVHeLRaPZvqnIW2CMq/26CEMRG6aQPxGdsKGorqqtBNBOBG5YttDMVE0Ey
 4Lcas763WzCTVet2nT14FISak4L3tXl1e9IVj8jrk4TqfeZtsE6VyztjaObWGpT8k6Or
 LmpoHg/T3YFbZlmc0XN0Unnss9zB/8E/B/3czjLixwowVbSSaGA9zTuRSrnQmMZ2/Nee
 K4Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpP3SRjnzj/Ke7PicVfwZmsntG61FMxpFFcysj62sDbE+IyhEN406MIo1uamYixVLxlqSO/1R6Gh5l6@nongnu.org
X-Gm-Message-State: AFuF++kLpSR9c5yPuZx7p5ARF1nofj26nVcFZNp13LiPTxkMxszSMyu4
 EMRFAz6gdhQBOrLF1MQrSAeNReEbid3rmXAnhSPsXhZWqD7jcwzW0XQ1
X-Gm-Gg: AR+sD11N1dUg1tpVydDeWAhC/C1hw56wW5fF+7PKtHEQUs64+y0Ld9vHTkQO/MolF5A
 4pY0N0VoS9x6lsujGlON5GQB7VLPJNS1aXOY+NWO2r+auPFVYY+siZvlWiY8+IsazpXp5ZHaL89
 n0EthEYnCuDOvvp+AffXFoaBtXGda+fwkxDEFFcDr4JU5Hx5rGagZbgYUqkfmjZ80H/xRoYz8aP
 8qOH6iJGz/DQwFImzDkY8ivozLEk94Vqi9UPJIjxNMTHLeom6LDX6RYr091uoBGiFlUFttJMVfA
 UouDew7cxKU76mwZW3ULaq4yyBTffl3XWlnXVabKF1/PgtZBu28rVo8EXm45sRUQS1zo8m8SMhP
 14xU8nURvdyLj7oM6N0jhFHRV8h5B2r1ruf93Eh/JvbaoNRwrygt+dQ2bu8UcQ20T4qhtrEZjFS
 hghoH9ix4szd6ufoofzv2vNMxY1ZOITy66Jg5VVO6pdZx4r0Jou1t1yVxuq290TXlUyNZQMQNnY
 xU1TwDjhsoIur4366SyaUQOp/dpuOh3KQJIb0K7RBtQE3z86y3gYaZMnByt2kR7dem6Vma+lp9f
 +s/rQzr5wzrqJSwd/oUSG7e9+iQ8axhf
X-Received: by 2002:a17:90a:d2cb:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-3966d36df78mr21195647a91.2.1787782340499; 
 Wed, 26 Aug 2026 15:12:20 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3d7fbsm17459a91.3.2026.08.26.15.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:12:20 -0700 (PDT)
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
Subject: [PATCH 11/16] hw/riscv/atlantis: Use local reference for system memory
Date: Thu, 27 Aug 2026 07:41:47 +0930
Message-ID: <20260826221154.54577-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826221154.54577-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
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
index c471c7cebf12..1c75fb5d8d57 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -482,13 +482,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
@@ -504,7 +505,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
 
-    s->irqchip = riscv_create_aia(system_memory,
+    s->irqchip = riscv_create_aia(s->memory,
                                   true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
@@ -517,7 +518,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(system_memory,
+    riscv_aclint_mtimer_create(s->memory,
             s->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
@@ -540,23 +541,23 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
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
@@ -570,7 +571,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
      */
     object_initialize_child(OBJECT(s), "uart1", &s->uart1,
                             TYPE_UNIMPLEMENTED_DEVICE);
-    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
+    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
                            "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
                            s->memmap[TT_ATL_UART1].size);
 
@@ -582,7 +583,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
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


