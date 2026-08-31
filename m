Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3943C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rZY-0003gx-NB; Sun, 30 Aug 2026 22:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZX-0003gh-VD
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:31 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZW-0007cZ-9L
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:31 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso2676644a91.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142589; x=1788747389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQBiGju903XJawObkTSJlI2w6oNi2YYpQ1UlpzmMJzE=;
 b=lEkkvCQfvWVEOtiiBi+XM086vsf7XjRg2QFGfZ5zvLr2tRcf7qJD0ro5xULxMYlECL
 WvePzyToyuKV9266AslwpaRqMnwrDPuXd6rkwwylHPfr1gj2E/Eew9wpUywUCT3NkNpD
 ASqri3e47WnHAOZmzuDNWhhZkPsA1UlZYvVulSOBVT224+vKPtwiKBcQTFd4lTCKNyrD
 Q7lwi7wH8QPEN5geIcp7T+kbJha2zBSiMpLTg7o3tvL8PeL5hdl616zNkRd27TwAvvEW
 H7dyq+BMvjL4HfnU7XuxJsMTU8/a9Mc/pH68LZCXdGSY1jP/hT9kFbv/AyjpeJeqL6ci
 9UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142589; x=1788747389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQBiGju903XJawObkTSJlI2w6oNi2YYpQ1UlpzmMJzE=;
 b=DPjnJaTHzfX8IUJRhDV8hKaRXBEaNJDLvg4P1wMy2gaf1+pe78m+L+IPSnYZ8kkdr3
 NhsybH+56HKYx3L7T2E7qIly/MVLFkMf8ZrdVUVfOQTlfwH8kXD6hDwyX/XQRTNQ6+aY
 Ccve9zmPqlXw+eCyqO7Js4CnF06FLOPqroERFioifSUskZpa5fQNCY8mbyNTIvjkaVmN
 8JKTo1uTf3t9eWzN2o4MZDvsBh8RBMKPWOoDZ1MPlsiGL4YU4yBnkVgIfQofxcmo1W+I
 bdVArh4DoAADC+9ZKdn6252jvb5sIbtA8x9gCbV6wDKeMOEi8Rma4wuY6iXH++62q6hA
 nxOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB3h6uYzi30xJNTQYX46IQ8P2y69kpA86l/RaK9iUyRd94famptW40oVf9RVZYRN0c1lx5wDrFEgpy@nongnu.org
X-Gm-Message-State: AFuF++lKZwOaL++FbRvmDw+By2TsrIPvyilW1enWZWfAudBad5dd+s7P
 mLwUmVLKfzQ4QGY8L6ijXxwf5CIAlxwnv6LyFdD0NOfCvndlG4Ejvl4L
X-Gm-Gg: AYBFou2QZYa0r0aBYkm5j1AK4C+ExG3cMHaK4kNM79ucDHxyCHPZE5hMjmOU+IliNsQ
 6ouCelRwJ9X+zTzPLhzo6cAqaJXkoViy1hZXtDLeMVouzHpb2BzKopJNICyCWBN0EYX2D5fx5z8
 MOou6/ulZMeYtYoQhzw0+3dwB6U+JqkNf/of1IAgSrUn1V5CJo1idsspl2FC9ulyn5yjYIoIb2E
 XRORZv6eSxeWz/0VWXVN9HtKpJRZHo8KFXUXPh/w1KbiyJV66VqdXIauvMc+6My167b0UjNVrdU
 MOrm88FVqgJ1CZLMMQZuWTHfWphsVMdH7Oo0wLJ14EetvvuCpH6S0TdaTDpCfKdwfeqmCfBGZYo
 LwdnjcVPQO9O0WQJxK7VnVV4BhwJB575AUbHdzxQFSR0TVGMdaYLyDsxB6P3wt1NWFdw+lx7VX4
 6wVSA+f5QPfQ3NvJ2/biduBJcnCtSfA66nU8wWK1nIPTAFmCNBndEAqtoe7hGxn73g/MzmY2DYq
 OlsoOX7EFVUrn52Wl2Q/WQZZZjvaNI7h493F7Ocv4Ja2SSv2ygIc6+W+ptUan4o8KT08ufPMswh
 5hAZfnUVkMBUyyy+6Xjb
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-396d0f2391cmr33143854a91.7.1788142588774; 
 Sun, 30 Aug 2026 19:16:28 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:16:28 -0700 (PDT)
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
Subject: [PATCH v2 11/16] hw/riscv/atlantis: Use local reference for system
 memory
Date: Mon, 31 Aug 2026 11:44:52 +0930
Message-ID: <20260831021500.82565-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1032.google.com
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


