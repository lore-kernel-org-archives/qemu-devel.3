Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94068C61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLrD-0001qX-99; Wed, 26 Aug 2026 18:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrA-0001qC-W3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLr8-0006bM-QE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:28 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so39884a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787782345; x=1788387145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRdr9+gRC0JbR6btxUltpf7akCd8aKY2gzcWzpEXK0g=;
 b=KOZKKDuVZT/GAzaEbHVF47h1rlgNHXlGcbTrj5Xet2w2/2UDLEdT4kzqOsS12Hda5H
 DCxkDkHof+p2+pWAm+mw7wGAF2PMKgtECATZ5qOt22WsjXXVHh/NVFkAAwljelW6qhqv
 +YDOzNZGz83TdznTqntvi3TFnP66HIvcSApt26+LD4vY6EzcQi2ZgKB7scY+z4v8sJPB
 LlJwuTKdXnOjBICZr2oA3nt6FOwAL/nzw93RBUX2IOGT+tpj/IpRA2L5I1VUq8zhOO7Q
 AFJRAxfLylyDRTADWz3b2Ha3sV+OAmkvcinFhiE3pGT0k5Ed5XmBwIeQCNLBWW4Vw283
 vZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782345; x=1788387145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nRdr9+gRC0JbR6btxUltpf7akCd8aKY2gzcWzpEXK0g=;
 b=lc61BR8vPAaEgjgeawD47bGHtG29VeDrtInlBkqM9cUbDMGszoZlYQJOvX7BDHjfXQ
 Z4hlRrqqPC7fI6Pcywn9yiN2cfQXE1cCJee0UESfPiovdCJstjBMHMSDggNC7InCFtfx
 v02YlftRaDU7/nhUPTqc3g0j07tKN+XimMOhYkFNL0E1eFXcGiiskpCMpchNaB+k43jb
 LvsuCJbGG8j1MaCVCnxGJ9Krr7KNptVatRKu89NYuLEeHmWfXQ/+J6LGayRYSMVJL1gi
 0MK6+GX2NFtfo/jeqz9MZ3e7yEP2NGW7hH0n4NrI8qIWKRJbIWHURC97jqnvQoBnYEvU
 ZDDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkND9S6if5jpczRCQg5QhiBYl6QuwNJII2GZTc8GrT6FToHYo+COqAWWSAgcQwwLSh9OrLGxm4HHH2@nongnu.org
X-Gm-Message-State: AFuF++kn8BFRYMHqCMXojVNPzcniizue2NzL1D7OzGnGNLOvhjUgW88Z
 pq0G96M06HpHJxqba19tI0bvEdM8prnI9OwUE5Ww747KYffWIDQ1GAqc
X-Gm-Gg: AR+sD10VCGeEMG6uFZoDXwRR/yLzQPEFJfMF4FVPqZRVuQJqtxnqzOHi/FjD723yf6I
 jFobStTLOsefk5umiyd0Ugu73LC4U8I4A0Z/wubbU1uj9h84uw2cjktvRcDRi2GOvlL9iZn77WS
 /CyDBUrjklevSX32YO6YlnBOTj3XaGk1+dZ9taJvrcx1I8JxXy3pRo78w4C4OBGxTua27tKJ1jk
 DXESok0jbN0rf/3W6V7vva0ffrdDlW44HOwTDrR1qzD9i5tryry4/cZxv8rq4TvZ6cIkDidAPEu
 Xxacttv5S+JyuTOlXZIIWSqBAkNVHX2VjzftVBMuiaHyXwYo+jZmVCdk2A9LphIT/qZaZ5YPKRL
 LPVn/tjkI+aUSpvb9DTXYJv5GMKEWiyLSKDqFyyjed9uMK9cPmy2ihbGL0AbbcqBzt/bMgNAGBJ
 CgP4QKYsQvTf11RtYhlB87uxVBJ30g0Zq3+g9nEz9b5UyaOhwl+1XcTXm9xNCbcPXoIjV+UicHc
 7Ma+K6v6iFqkfkz+YxV7/14YTlzTMQtie1cKiqjBIvA4NiOj+1fSGvznCf9vT97ztg1RC9rTZPC
 VT7UIOponL6fh1NC5rWA
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr21498328a91.15.1787782345377; 
 Wed, 26 Aug 2026 15:12:25 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3d7fbsm17459a91.3.2026.08.26.15.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:12:24 -0700 (PDT)
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
Subject: [PATCH 12/16] hw/riscv/atlantis: Decouple RAM size from MachineState
Date: Thu, 27 Aug 2026 07:41:48 +0930
Message-ID: <20260826221154.54577-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826221154.54577-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102c.google.com
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


