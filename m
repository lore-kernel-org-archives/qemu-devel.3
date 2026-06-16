Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAFACD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk9-0001ap-PV; Tue, 16 Jun 2026 06:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk7-0001Pg-Nc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:03 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk5-0004CL-QI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:03 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c85d4b4245aso3173798a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604600; x=1782209400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+CPW+mrFb4Q9pfWiijQO7BuxfxRUOuvUJFTjhbA2GY=;
 b=XC1ipNPjVS10T6YTtjEP7FpKnaee2H6OzURfCtOY03pxB3oqYzVkBr8YjT4ZYTAJRM
 oruIPPCShoWk0ln6m9rQR3H3jMi376vYvOfxA3y+4Yc+aphGqDClBT4impnm+awPmV6c
 H3naMmOnT5Uqt+neidOEgWF/U6adFfHuBybe9MvUNlQ9x+fSYl+XereP0y1PqclRFZkz
 1mkFT96HcDWhalM38qeXvltcIf1C2T4AHUNgKNOM9sxvPDG3cK7GzZHLRurUTLQuPDcY
 RUXw+X4I0btr0qJ2SMU7JOZxD3fJOJMovdRU55s0Wr1U5g3XOS0zJeE6kMHIA6YiZKZ8
 gqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604600; x=1782209400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k+CPW+mrFb4Q9pfWiijQO7BuxfxRUOuvUJFTjhbA2GY=;
 b=anBtr5PaAVak2b7dKE0cShJ9suIlcogD1puNofLxb/Qaz2OMWwyTfSwx8RYiUJgBul
 0R/7LW00z+B/sL3ezbAOYX8HbW4W7C8UBmmpNbzpoPqjx6TWTwNGAQaaURzb39eG3B/Q
 HPt5FU4KaJf6FgduNbHh5uqmbtAlNXovH7KB/+9mN9E9Zx2QvEW4r5OeZAU8mm3RJcB3
 wPwZyoEr4/QjFz2Jhcczf/uw22u1gBmVjxQ6Ps1Y9MF5BgiSNnebkTpR3nR+kIqluNEW
 nIy+qFjCmGK5zDZwNeIgktZuALi3Ovh4RGpvKyJwFjwFpcUjxFnKMtoSG1+5VT87CPXs
 mv5A==
X-Gm-Message-State: AOJu0Yy0FkiUTbSbYG+qihoHJ5JYnRnsGoO+9EEo96a/Zge3vc0x272q
 n344aq+lZX7JptO7T2hma0iMBzgdgnj8Wmm7cnBFxPNoRZE4X+Eea2BhWwiMNgpV
X-Gm-Gg: Acq92OHA5eyaNtK+4hqDapLiRD5/H2AqBqikMA/iOt00VuH++dtnORQV9qhiymlqCG3
 5OcFCeRNoTZEZ5amPqSTOmlOQ86CAzf+tttPzL15agFlJuDyOTR/Ts/XltD1SeXOZxENodaYVZZ
 UrM1h7zotiRF/0/e7Ta52gnhzlXAbkl/DzEQln/dTheAJQOVxjawU5uljpPMlY+BmxLDCPVK+Oj
 N4HBSgyRvjcFNp2Nk6PZkpzx1E3TVN4HvtcYStntNM2W9AwIK0qTUn46NqJG5Awmoo3avNEYugi
 YM4KnIDhc41aGwcgJGN0dH/7EqJTtM47knZYoOMLLsYI6jASDwFh97nPNgYUGw3jp0KKsOBehkZ
 AI+Z8lIAUnbpjzGgG6x4nCnBmEgKvZ/Ih8iSvnqCzbBYQUAnuYocR8gUH4mgxNczxHrZu59z4bS
 2/3Y/ti9MfYH1ol+ZvPrq3ALCxKtQWWiUskVEa2mOW
X-Received: by 2002:a05:6a21:e93:b0:3b4:76c6:f961 with SMTP id
 adf61e73a8af0-3b79624e144mr16215964637.17.1781604600565; 
 Tue, 16 Jun 2026 03:10:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 76/83] hw/riscv/spike.c: add intc_phandles array
Date: Tue, 16 Jun 2026 20:05:19 +1000
Message-ID: <20260616100527.1939565-77-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The clint FDT generation uses a cells array (clint_cells) that are
populated in the middle of the loop that creates the CPU socket FDT.
This is completely fine but it differs from the other boards that
creates the clint cells array right before creating the clint FDT.
'virt' and 'sifive_u' store the intc phandles in a intc_phandles array
during FDT CPU socket creation, and this array is used to create the
clint FDT cells.

Standardize the clint FDT creation for spike doing the same here,
allowing us to move everything to a common helper later.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-7-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/spike.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 92facba29d..82005ec163 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     int cpu, socket;
     MachineState *ms = MACHINE(s);
     uint32_t *clint_cells;
-    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    uint32_t cpu_phandle, phandle = 1;
     char *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
     static const char * const clint_compat[2] = {
@@ -84,6 +84,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
+        g_autofree uint32_t *intc_phandles = g_new0(uint32_t,
+                                                    s->soc[socket].num_harts);
         hwaddr memaddr = memmap[SPIKE_DRAM].base +
                          riscv_socket_mem_offset(ms, socket);
         uint64_t memsize =  riscv_socket_mem_size(ms, socket);
@@ -91,8 +93,6 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
         qemu_fdt_add_subnode(fdt, clust_name);
 
-        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
-
         for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
             cpu_phandle = phandle++;
 
@@ -113,20 +113,17 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             riscv_socket_fdt_write_id(ms, cpu_name, socket);
             qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
 
+            intc_phandles[cpu] = phandle++;
+
             intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
             qemu_fdt_add_subnode(fdt, intc_name);
-            intc_phandle = phandle++;
-            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
+            qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
+                                  intc_phandles[cpu]);
             qemu_fdt_setprop_string(fdt, intc_name, "compatible",
                 "riscv,cpu-intc");
             qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
             qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
 
-            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-
             core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
             qemu_fdt_add_subnode(fdt, core_name);
             qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
@@ -139,6 +136,15 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         create_fdt_socket_memory(fdt, memaddr, memsize, socket,
                                  riscv_numa_enabled(ms));
 
+        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
+
+        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
+            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
+            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
+            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+        }
+
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
         clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
-- 
2.54.0


