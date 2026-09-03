Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BD8C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20O2-0006nX-0G; Thu, 03 Sep 2026 01:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Ny-0006kR-2Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Nw-0006To-8w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8485b358552so1773625b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414794; x=1789019594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qWmn3AlBJiBatFSAGPn5IZB+fcd5zMueThDsc6iFX24=;
 b=BgdSZj+qsMzSqAHAQyWQ2ZXYVDWOO0tKp+73MPjLDnU5Brt4vphI6ZTbGEgdYMxEv/
 VciIGnyy0j2SnxQYUgtUpoi5fxb2Z1Zt2VHQpwr01bCZo4CsrsZDhCpPY65SMnvayuUu
 t6j9FmVJHfFP0zw9yZeF/LgRs0GLm6qIbY7tECcmdYYxEzFtq065nl6LZxAbcEr/kRvg
 G1QLkhpSmsjqOvxDtA08+kX3eIIauxXjNFEBk/uGzxbVInXhm/w2NhqMGDUTng73dLuy
 knPL6iMpnfY6ygP2NiZkWi05yFZuiJf8TPbmUz5E4USKka+wTAFb/4joKpGMrq8A/pFC
 ZC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414794; x=1789019594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qWmn3AlBJiBatFSAGPn5IZB+fcd5zMueThDsc6iFX24=;
 b=iAEkwgfrYEhBe5PR8bmyWMGy0XlmkjwTLa2qdVGEqAhWV269OqUL4ETZrGzsGA+CFM
 ndcwQw74O0hNZN3FxdFVyBynMrjCCdvdUZP2XjYEN+UgMexqDUCWVbXl5Q1JA7lLcDSn
 pDTjJ1IneB9U6oCjvfVSQ9cH6jy8vsIdxf/vD7WcjJhHJXBhO1SP5M+N264N0u+rl4Sd
 fV8m5/YcdsuIgOJxT9v3b+hB6/9PwSPDA4Fva5OUH8cG8ZIpUylCTNouZ/+xh998Vsj1
 riUi2J/rUYSzuNlhdJYkYbuoUeZPrQn5l5EVVEbeBDAPTpC+Ozd1U+eVZoNa16h+37LS
 p9cw==
X-Forwarded-Encrypted: i=1;
 AKwUvByo17sK9e/K7ztI2fgEm2ls9+ltE6Hk3xfmg2o145/5DMSrkob6r33P8CXUgselCFxObcGYiMskOCqp@nongnu.org
X-Gm-Message-State: AFuF++l55FHNfvA1ePlZsD9IQ0kfvLlz4Hc0fVU9CDo8sGH7qL6L7n4O
 f/Y3B2N9PR4LB0CbHHkBB4M4mnIsWESvQCgOjZAigGG3lY45h8pukL7O
X-Gm-Gg: AYBFou0fWNfUpkGfZ6reEQqOAZbtsDgiXPHJjGEgcc65shxfSINaMGj+GcxO8x9pYbc
 9L65GioiCuKjbkuqOFePDZE9zKylJ+NSUVQZmf1FQZm4NyOeMfM+cdKAmVkQxYqZH/T2sd9/5/+
 znUpSA9cvqvWVQlI1h1xf3oNrdOAhc7kAYKR6gF5XrPfFoQ1Y6KHRrJ+kOnEfSC7UMFMnN9OW9X
 KP1Trdqf1afb8gHw0AH1Sxl1nW68SjMIZ3OUYQ5pX5PdeO3cuBu2aAysJLxjuytpSuA5c84iX0/
 REcZTfzGv74Ub4nWxnWIScnMK7OU8nl15i5ceYBNKz6iR8tDthukbeGQDnbbk0DOl37GxE3UNZi
 eYV0SP0wrD5bbgYx0vgKQGscye5sZMuGvqUXyKuxC/MIWvZDo7/2c0k5IvS2dXNnEdKhHGcqJOk
 ORrlJd7XMaiVFKu+xhGaSgVB75T4IDJhST6LKng6b1o3NiLis/w9TAG76za2n5eLmSCVCJP8SqR
 bpMhMl2/ZJL9J8bX8JMGYQAB6t7v5b6uF6kvHYoNtGBLRI1OjKTSCgSeuAm3unxbbPhKCGgjYCD
 09213IZfZ5vFdRjs4GeS
X-Received: by 2002:a05:6a20:e211:b0:3d0:9164:98a7 with SMTP id
 adf61e73a8af0-3d9ae0cbe20mr13604980637.11.1788414793907; 
 Wed, 02 Sep 2026 22:53:13 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:12 -0700 (PDT)
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
Subject: [PATCH v3 09/16] hw/riscv/atlantis: Rename hart array 'soc' to 'cpus'
Date: Thu,  3 Sep 2026 15:21:23 +0930
Message-ID: <20260903055131.257903-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x436.google.com
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

The RISCVHartArrayState member is named soc, but it's an array of cpus,
not the entire SoC. Use cpus instead as an accurate description of the
hart array.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  2 +-
 hw/riscv/tt_atlantis.c         | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index d0cca3b02424..642490d21743 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -29,7 +29,7 @@ struct TTAtlantisState {
     Notifier machine_done;
     const MemMapEntry *memmap;
 
-    RISCVHartArrayState soc;
+    RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 7d31294ea1fb..80300a18a4ab 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -113,13 +113,13 @@ static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
     uint32_t aclint_cells_size;
     hwaddr addr;
 
-    aclint_mtimer_cells = g_new0(uint32_t, s->soc.num_harts * 2);
+    aclint_mtimer_cells = g_new0(uint32_t, s->cpus.num_harts * 2);
 
-    for (int cpu = 0; cpu < s->soc.num_harts; cpu++) {
+    for (int cpu = 0; cpu < s->cpus.num_harts; cpu++) {
         aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
         aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
     }
-    aclint_cells_size = s->soc.num_harts * sizeof(uint32_t) * 2;
+    aclint_cells_size = s->cpus.num_harts * sizeof(uint32_t) * 2;
 
     addr = s->memmap[TT_ATL_ACLINT].base;
 
@@ -211,7 +211,7 @@ static void create_fdt_pmu(TTAtlantisState *s)
 {
     char pmu_name[] = "/pmu";
     void *fdt = MACHINE(s)->fdt;
-    RISCVCPU *hart = &s->soc.harts[0];
+    RISCVCPU *hart = &s->cpus.harts[0];
 
     qemu_fdt_add_subnode(fdt, pmu_name);
     qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
@@ -228,8 +228,8 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
 
     riscv_fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
 
-    riscv_create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
-                                 s->soc.hartid_base, &fdt_phandle,
+    riscv_create_fdt_socket_cpus(fdt, s->cpus.harts, 0, s->cpus.num_harts,
+                                 s->cpus.hartid_base, &fdt_phandle,
                                  intc_phandles, false, false);
 
     create_fdt_memory(s);
@@ -253,13 +253,13 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
     create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
                          msi_m_phandle, intc_phandles,
                          aplic_m_phandle, aplic_s_phandle,
-                         IRQ_M_EXT, s->soc.num_harts);
+                         IRQ_M_EXT, s->cpus.num_harts);
 
     /* S-level APLIC node */
     create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
                          imsic_s_phandle, intc_phandles,
                          aplic_s_phandle, 0,
-                         IRQ_S_EXT, s->soc.num_harts);
+                         IRQ_S_EXT, s->cpus.num_harts);
 }
 
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
@@ -430,7 +430,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
     hwaddr mem_size;
     target_ulong firmware_end_addr, kernel_start_addr;
-    const char *firmware_name = riscv_default_firmware_name(&s->soc);
+    const char *firmware_name = riscv_default_firmware_name(&s->cpus);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;
     RISCVBootInfo boot_info;
@@ -447,7 +447,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (mem_size > s->memmap[TT_ATL_DDR_LO].size) {
         mem_size = s->memmap[TT_ATL_DDR_LO].size;
     }
-    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc,
+    riscv_boot_info_init_discontig_mem(&boot_info, &s->cpus,
                                        s->memmap[TT_ATL_DDR_LO].base,
                                        mem_size);
 
@@ -477,7 +477,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
-    riscv_setup_rom_reset_vec(machine, &s->soc, start_addr,
+    riscv_setup_rom_reset_vec(machine, &s->cpus, start_addr,
                               s->memmap[TT_ATL_BOOTROM].base,
                               s->memmap[TT_ATL_BOOTROM].size,
                               kernel_entry,
@@ -497,18 +497,18 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
     s->memmap = tt_atlantis_memmap;
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
                             TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine->cpu_type,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "hartid-base", 0,
+    object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "num-harts", hart_count,
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", hart_count,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "resetvec",
+    object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
 
     s->irqchip = riscv_create_aia(system_memory,
                                   true, TT_IMSIC_GUESTS,
-- 
2.47.3


