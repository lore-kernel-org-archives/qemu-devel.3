Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B8BCD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkE-00024T-0A; Tue, 16 Jun 2026 06:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkB-0001nt-FZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:07 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk8-0004Dr-Sc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:07 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c85a2c012e5so1467793a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604603; x=1782209403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgiXv0DdqXhZdd1pfnR+wbylT7qv8kTRYp/BSPGj9xY=;
 b=M529jpRqCYIyiwugqMxQI8q50XWQ9Owiv1NaiKuJOZQX9jYYMC3TQWXdn3BdkFyS2O
 BlTCOhQbnmTo4tVE/PfB7kIin+AaCrVfgvzijQQO9zkkvK76/DGNCpKM+vmGc9ScsLDZ
 auZyDYB4vDQAk61I9ea8L2MXLrKL1ET4pZ6ZAU/SzyDa/hsUJ/97aB1nlaAAlGHQ7cvK
 q0QDTa4tGI3K2oCKQpX8VmC1UgxAP8N8qaUvUp5erf3ecWzOQIrXThbwPsR5r9sx4Ty/
 eCr70WT4kb1OeKujcskhyq84FWd5XfvBuQ411P4Ptq9SmqYfYdJZgqTTlhjzJHNSKMYv
 4B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604603; x=1782209403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgiXv0DdqXhZdd1pfnR+wbylT7qv8kTRYp/BSPGj9xY=;
 b=evNN0o1sb9vexpXwikTB+swCDfotFmy0/COGRp12OW1kI6cSxppqOVdtqVOpfJ4zJs
 cxyXdqamguuy2cy/MPivGsIOxdzI4o0z74YK0Cp1Gkqw4B19cXn/BS5PXYIicuZKOC/7
 Z+20XdqALJH7iozUp1SwX6Jbblw3TwYqcTWqGR7I2eTvWQKfJ6oOtpG5eOkgVOVh7fwR
 iWmx2fknTZY0I+SuaOx6C+2/kgYQgvz5bXT7MZ6XXnuGqqB+528pFS1pQzKvf/zcz787
 E7vxxmTiTStRMCz+cWK110MQPJIj0MCqufj5lrUFUne3/2hdhXck9VLuP11mc5xvNxls
 U5FA==
X-Gm-Message-State: AOJu0YxLV9cjIW4yo9f6YTwOE2NEDvww9CImDH83mIrWXXUz8z0OzPPy
 qhHA+aXdQUBUf+w9j8hHQu9KA8NF+htDi40PTQR3RCshR1fKd/J1sD8Zm6lsE7xq
X-Gm-Gg: Acq92OHsrCz/4IA+MPBh+QkcRve+ZqM3cJdp6NNyFe8LepqtdRrAzCF+BqZgNbf8GHf
 kMCN3Jwa6gf75s5LbCenU3tyTOJp2dk4d1LCj8NXSPJK+fliplXzM14ZFUBcEPDwdPZnrtiawvc
 g520G50xjSoWZPiHfA8Ix6ZAeegs4t6j3osjVnys/MFF2Soo0RuNRAkwCqGAQM7+rQzZJNHVnKP
 EDllUfzZ9IVUJBE+TRsgcVAMqkrUlyRCxT49+T2PS8jllAfzN47iy7b/XYYFFTv6pixrIUGi+Ca
 /VuZemrJoxnFQ6w1onvj47NxcsGdwSpPUT4oDv177pKSknAT6PsSas9MNlEcOQOcq3G8jCzU3Hf
 u96x5SIG8O7KL5RhjKJBMrGCFqnRSDgJkoxm+R96yrRILNj0YDsR5MJHFDpC1fW3fiqcLhkjiwD
 qujDPvEk/2O8j1jivhnm6/YLlVsIQFZXMjIcVI9s9C
X-Received: by 2002:a05:6a20:9186:b0:39b:8dcb:f36d with SMTP id
 adf61e73a8af0-3b7e49d09f6mr3392604637.35.1781604603452; 
 Tue, 16 Jun 2026 03:10:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 77/83] hw/riscv: add create_fdt_clint() helper
Date: Tue, 16 Jun 2026 20:05:20 +1000
Message-ID: <20260616100527.1939565-78-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

Move all clint FDT generation to fdt-common.c reducing code repetition.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-8-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  5 ++++
 hw/riscv/fdt-common.c         | 33 +++++++++++++++++++++++++
 hw/riscv/sifive_u.c           | 25 +++----------------
 hw/riscv/spike.c              | 31 ++++-------------------
 hw/riscv/virt.c               | 46 ++++++-----------------------------
 5 files changed, 54 insertions(+), 86 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 81689f418b..6e81d6cd6c 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -13,4 +13,9 @@ void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
 void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
                               int socket_id, bool numa_enabled);
+void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
+                      uint32_t *intc_phandles, int num_harts);
+void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                             int socket_id, uint32_t *intc_phandles,
+                             int num_harts, bool numa_enabled);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 719c36e001..d2661ec389 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -12,6 +12,7 @@
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
+#include "target/riscv/cpu_bits.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size)
@@ -50,3 +51,35 @@ void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
         qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket_id);
     }
 }
+
+void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
+                             int socket_id, uint32_t *intc_phandles,
+                             int num_harts, bool numa_enabled)
+{
+    g_autofree uint32_t *clint_cells = g_new0(uint32_t, num_harts * 4);
+    g_autofree char *clint_name = NULL;
+    static const char * const clint_compat[2] = {
+        "sifive,clint0", "riscv,clint0"
+    };
+
+    for (int cpu = 0; cpu < num_harts; cpu++) {
+        clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+        clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
+        clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+    }
+
+    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, clint_name);
+    qemu_fdt_setprop_string_array(fdt, clint_name, "compatible",
+                                  (char **)&clint_compat,
+                                  ARRAY_SIZE(clint_compat));
+    qemu_fdt_setprop_sized_cells(fdt, clint_name, "reg",
+                                 2, addr, 2, size);
+    qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+                     clint_cells, num_harts * sizeof(uint32_t) * 4);
+
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket_id);
+    }
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ce86989bc8..9a791b36d6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -105,9 +105,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
     static const char * const ethclk_names[2] = { "pclk", "hclk" };
-    static const char * const clint_compat[2] = {
-        "sifive,clint0", "riscv,clint0"
-    };
     static const char * const plic_compat[2] = {
         "sifive,plic-1.0.0", "riscv,plic0"
     };
@@ -180,25 +177,9 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         g_free(nodename);
     }
 
-    cells =  g_new0(uint32_t, ms->smp.cpus * 4);
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-    }
-    nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[SIFIVE_U_DEV_CLINT].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
-        (char **)&clint_compat, ARRAY_SIZE(clint_compat));
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_DEV_CLINT].base,
-        0x0, memmap[SIFIVE_U_DEV_CLINT].size);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, ms->smp.cpus * sizeof(uint32_t) * 4);
-    g_free(cells);
-    g_free(nodename);
+    create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
+                            memmap[SIFIVE_U_DEV_CLINT].size, 0,
+                            intc_phandles, ms->smp.cpus, false);
 
     nodename = g_strdup_printf("/soc/otp@%lx",
         (long)memmap[SIFIVE_U_DEV_OTP].base);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 82005ec163..b15188fb07 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -58,13 +58,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     unsigned long clint_addr;
     int cpu, socket;
     MachineState *ms = MACHINE(s);
-    uint32_t *clint_cells;
     uint32_t cpu_phandle, phandle = 1;
-    char *clint_name, *clust_name;
+    char *clust_name;
     char *core_name, *cpu_name, *intc_name;
-    static const char * const clint_compat[2] = {
-        "sifive,clint0", "riscv,clint0"
-    };
+    bool numa_enabled = riscv_numa_enabled(ms);
 
     fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
         "ucbbar,spike-bare-dev", &fdt_size);
@@ -136,29 +133,11 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         create_fdt_socket_memory(fdt, memaddr, memsize, socket,
                                  riscv_numa_enabled(ms));
 
-        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
-
-        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        }
-
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
-        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
-        qemu_fdt_add_subnode(fdt, clint_name);
-        qemu_fdt_setprop_string_array(fdt, clint_name, "compatible",
-            (char **)&clint_compat, ARRAY_SIZE(clint_compat));
-        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
-            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
-        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
-            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
-        riscv_socket_fdt_write_id(ms, clint_name, socket);
-
-        g_free(clint_name);
-        g_free(clint_cells);
+        create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].size,
+                                socket, intc_phandles,
+                                s->soc[socket].num_harts, numa_enabled);
         g_free(clust_name);
     }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index df3eadef78..b134f11266 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -302,42 +302,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     }
 }
 
-static void create_fdt_socket_clint(RISCVVirtState *s,
-                                    int socket,
-                                    uint32_t *intc_phandles)
-{
-    int cpu;
-    g_autofree char *clint_name = NULL;
-    g_autofree uint32_t *clint_cells = NULL;
-    hwaddr clint_addr;
-    MachineState *ms = MACHINE(s);
-    static const char * const clint_compat[2] = {
-        "sifive,clint0", "riscv,clint0"
-    };
-
-    clint_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
-
-    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-        clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
-        clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-    }
-
-    clint_addr = s->memmap[VIRT_CLINT].base +
-                 s->memmap[VIRT_CLINT].size * socket;
-    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, clint_addr);
-    qemu_fdt_add_subnode(ms->fdt, clint_name);
-    qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
-                                  (char **)&clint_compat,
-                                  ARRAY_SIZE(clint_compat));
-    qemu_fdt_setprop_sized_cells(ms->fdt, clint_name, "reg",
-        2, clint_addr, 2, s->memmap[VIRT_CLINT].size);
-    qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
-        clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
-    riscv_socket_fdt_write_id(ms, clint_name, socket);
-}
-
 static void create_fdt_socket_aclint(RISCVVirtState *s,
                                      int socket,
                                      uint32_t *intc_phandles)
@@ -728,6 +692,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     uint32_t xplic_phandles[MAX_NODES];
     g_autofree uint32_t *intc_phandles = NULL;
     int socket_count = riscv_socket_count(ms);
+    bool numa_enabled = riscv_numa_enabled(ms);
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
@@ -762,8 +727,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
             create_fdt_socket_aclint(s, socket,
                                      &intc_phandles[phandle_pos]);
         } else if (tcg_enabled()) {
-            create_fdt_socket_clint(s, socket,
-                                    &intc_phandles[phandle_pos]);
+            hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
+                               s->memmap[VIRT_CLINT].size * socket;
+
+            create_fdt_socket_clint(ms->fdt, clintaddr,
+                                    s->memmap[VIRT_CLINT].size,
+                                    socket, &intc_phandles[phandle_pos],
+                                    s->soc[socket].num_harts, numa_enabled);
         }
     }
 
-- 
2.54.0


