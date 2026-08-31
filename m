Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72909C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rZi-0004JM-5p; Sun, 30 Aug 2026 22:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZd-0003sO-71
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZb-0007dI-E1
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:36 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so3016676a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142594; x=1788747394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRdr9+gRC0JbR6btxUltpf7akCd8aKY2gzcWzpEXK0g=;
 b=Y4Ibsn9asMSBdLpArHXwU7Q6otl4prfc+jIuA/9iChguDJFeZkR+i96r/w0BBsYR1N
 0+RrhRpyS1gT9/YJAeennT/R2vKdr2dtj/OKpD5Qz0umJBaQb5/NmjQiez5WzL3NqRYv
 PKRFLM26gN1dR+TYvwY6GqU906QhoD11bDkXUdlS6+J/yhYi95xso+pG0/YUDNLxhEUG
 rQoaI3MYZBBNZHlVnoKIKgBu4kCBrDhyO/FhJ3CMg+voTJT/cHbO8ixzhLmdIaQI/a1U
 7eEPDyvBVJ1t6jVBbBKOcL6gVKxiBK1d2IePU18AXJbR6G1avMEdu2Ev2HFXFaGRDrOd
 Y83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142594; x=1788747394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nRdr9+gRC0JbR6btxUltpf7akCd8aKY2gzcWzpEXK0g=;
 b=K9+iPGTFkH7H2B90Y0fRN2FU4Dr+9cplgSJ8EZZCzfaYSqRQcQXoZcpd7UX8ow84U3
 f75vDZaZBq8cC9uswKpvSItF3fJK1LJhPd29V5lTX1zfQCmMQ4l+lqkQ2T/yCY70BvQ3
 qGVpDV6bjEJJzW2Qv2CFsH4oj1eYHmI3379TUx5a4a8SLGSaJIaD7F3E8CksYa8YJMpK
 07d0CcS5YklhwHO1/X97zJ8a5h2nxMs4rgrrv9Fm/yhS0HeGnJOaN8TTr33LTj0tW2ID
 n6yfVBbpCwnWWUMylx9d4LFchB/2UVCDo6l5r4RgouNx1vJp3qdQQDtKiCPeG1lwYqFq
 2hDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsQ28tfj3RI4zSwvUaEr7WuhsxlOwG3DnWkYY0UTkya3TXEvTDd9A2wM48h37btjHqzmtz9G3jqLe6@nongnu.org
X-Gm-Message-State: AFuF++lCASwik9ByC0QYFSaMNYV4TOa8w84IwrZVWT1tmXGra/2yeyEX
 06Q6Ip6EjiwDbmokLIfiYe9nub2rcK3F+qpPhUfC4esKtUr6tpXQ6EMg
X-Gm-Gg: AYBFou3jiFvVWh/129FnkF/oJ9rjD9D1y/ss+PEYbBDdq8ZtSpcaW9k7RFeiWPSlFUd
 ojOlB+EEa2p+YflAoAHwSGDuCCVAYgrfDvXoijickz3MMXcHnDCTg6YC5U/Ujr+oJ3ahXH6m9+I
 GrxDdbqgw6vkYo5GuiGc0HL+OIMtvd5amnuDHqTx5U4GXUtV9GA4ktKYozX6oxL2yDZ6cDqnNji
 M4lrQPCefbq3A8nyCX3ZdxWDbk9Bpz1mYB84DwKM9ZjUQ1Z40Wo49KcfuMFhsBQk/+ql43PsIS0
 ASkR2oKtl4SiXYb7mVAV99QZIHIMai3p5XdyAybx/9juBnA/+W+jjYualgydnb5wuR1gkrycZog
 SyWwHZ2FRGQLCePePc/wp6tLNI0ujvw/JqIEZJYCD5zCC8iKNGiu9Xkvl29+Nkf59SjXpaT6s8d
 2tMIq7RtBj+ePzhWTpBqHAMMVivpXAEJlrvYmOMayadgRKheqB4NP7G7af6Q+Vr+yYFLQz8Hdsj
 WTBVaQYL1pCjFzCqOtlpcr42xtjNsOdGOYBkvOM9y+b/BhHMmdpxDGL5w7Tk4O5sQ++FMUQU+wO
 ZVPcvEiHPA8TVO0S7wEyqA==
X-Received: by 2002:a17:90b:4cd1:b0:398:9bd4:d12 with SMTP id
 98e67ed59e1d1-3989bd40da3mr23554154a91.17.1788142593870; 
 Sun, 30 Aug 2026 19:16:33 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:16:33 -0700 (PDT)
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
Subject: [PATCH v2 12/16] hw/riscv/atlantis: Decouple RAM size from
 MachineState
Date: Mon, 31 Aug 2026 11:44:53 +0930
Message-ID: <20260831021500.82565-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102b.google.com
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
index 1c75fb5d8d57..7a9f5872c7c0 100644
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
 
     create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo,
@@ -485,11 +486,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
@@ -532,20 +536,20 @@ static void tt_atlantis_machine_init(MachineState *machine)
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


