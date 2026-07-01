Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes26-0001av-Gg; Wed, 01 Jul 2026 06:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes23-0001KG-WF
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:04 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes22-0004k3-0Y
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:03 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-139f1dfc9faso745040c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901140; x=1783505940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VBi40b1q4o9+Ih5BciP8oZolK8MGGWsJ0sZR5efZdZw=;
 b=DdcBD03KpwWd9JQN+Wk025Nq3yEDsaZjfErESXAuOJUxYUR/0Pc8wwDFPaVMpukn3f
 Ldsh2rwapyMwdkMO2p4MqzzGYYtG+lNWYyA/KeMEhqTJ6jbgOxxYbswmZBOtHyTGpMGP
 zL/h8l3z78ua5QzHClRfGmcsnNkXz58LzLqfEmuVi/ii/YJ6clznygR3EIus0sbvIuGZ
 kvmJWp6ncPI+6MCaN+crrCllom+XfuKZ6Jn4jwgXAFvGQnGYaebSjugrXKzo23iT52Mq
 gFTcr8oJvO9Z+L4cuagA4LEEs2df950ZGEdM5dgTx0gW1S6FCuB0gwGwVpuZqOaGDcEJ
 6cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901140; x=1783505940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VBi40b1q4o9+Ih5BciP8oZolK8MGGWsJ0sZR5efZdZw=;
 b=mABZS4PxzXbmsvpN/SHJDmk2UHupjuziAH9qOup7+Mm6ahgbK8J1+7jv0dixa8GkcW
 TW4+lMfwZVY8IUe2MM2+6L6Ik96GvEEVlB28BT/dNTm7HhYX3HULnmBHPXHo/gBGRBdc
 ZQJ23YAkVO2sQ5uSl6GsCyeXPpHgGetYASzPRM06j4jnj8S5cZ6jq8iS5DLY2t+YVu6F
 4TsYSv0Rp9H6r4F6yw0az4D7wmtujqIdqd+5W7pz1PD/xJwfc/RLh/8s3DBq7Nyc6tyC
 0CSQjTABVE7dPwhvZpXBlEKb949/erTDUCfKAn3K8opU+YOpRnE7AfVRY3O5tEkOZgn1
 ojIg==
X-Gm-Message-State: AOJu0Yx4Uf8SLYSeKFx3L+NgzorqPf+Yg7FAkpWY5EOFpRSODui0H+QJ
 2lQTEVCnp7oPcnIn6Mzdj8jTcDjmIJEdbx4Rwfxqtwfh5TyTUCwYBLVc7Nzuvg==
X-Gm-Gg: AfdE7ckFp9VSN6Ytd03dfVo5+fprc+C8TQqdTqpon0kijIOihqxw0Yj48qbYHQ4CZM6
 +yEx2cjpe8R6Yna8ZPkIDM3TD/LIOVy6KXbBDsuSGoLfgZhkpPZYrGKXF9sSuTVOvB+eC7FwpD/
 HQqGLAR1MO6qq6T65VUbkYuc0KYSnkGab6sQD589yI6iMv1kJjSbgd4+YKHWapq/FsVGfLVOam8
 liylx0CEyf4OrxIRvFPnTEOaXETH9fQaGRe60BwYHQImwwuX7M4b+usqaI3GlZ3knTY9BnEH2fr
 TVZGBqKZWx1MxUdNuH71sZ9SpR0rTGNkAlGdnBerqi17WvGGhRzafMb9DdlLSBITS6Q6WtpEyHc
 i0uy/lwKNmhPWM8X9hGISAnY1ZG3ONaYG3o6mkfExQ6gU9eOGcHYJh7yAvMU7e7d0sf8meZkuGH
 +qhXLXCJthRZOAHeeVnZhdNQB+5uLO1Ng=
X-Received: by 2002:a05:7022:392:b0:138:56d:27e8 with SMTP id
 a92af1059eb24-13b390d7742mr224679c88.1.1782901140279; 
 Wed, 01 Jul 2026 03:19:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/39] hw/riscv: add create_fdt_plic() helper
Date: Wed,  1 Jul 2026 20:17:30 +1000
Message-ID: <20260701101752.2522962-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1231.google.com
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

Consolidate the common plic FDT code between 'virt' and sifive_u boards
into a single place.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260616235939.1358663-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  5 ++++
 hw/riscv/fdt-common.c         | 30 +++++++++++++++++++++
 hw/riscv/sifive_u.c           | 34 +++++++-----------------
 hw/riscv/virt.c               | 49 ++++++++++++-----------------------
 4 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 2d6b9a5d03..017278b611 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -30,4 +30,9 @@ void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
                                   int cpu_id, int socket_id,
                                   int socket_hartid_base, uint32_t *phandle,
                                   uint32_t *intc_phandles);
+void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
+                     uint32_t plic_phandle, uint32_t int_cells,
+                     uint32_t addr_cells, uint32_t *plic_cells,
+                     uint32_t cells_size, uint32_t ndev_sources,
+                     bool numa_enabled, int socket);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index b27ff13bca..e0e31af09b 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -200,3 +200,33 @@ create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
                                    socket_id, socket_hartid_base,
                                    phandle, intc_phandles, false, false);
 }
+
+void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
+                     uint32_t plic_phandle, uint32_t int_cells,
+                     uint32_t addr_cells, uint32_t *plic_cells,
+                     uint32_t cells_size, uint32_t ndev_sources,
+                     bool numa_enabled, int socket_id)
+{
+    g_autofree char *nodename = NULL;
+    static const char * const plic_compat[2] = {
+        "sifive,plic-1.0.0", "riscv,plic0"
+    };
+
+    nodename = g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx, addr);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", int_cells);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", addr_cells);
+    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
+        (char **)&plic_compat, ARRAY_SIZE(plic_compat));
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
+                     plic_cells, cells_size);
+    qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                 2, addr, 2, size);
+    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", ndev_sources);
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", socket_id);
+    }
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7dfc18d3ec..d923f041e0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -100,14 +100,11 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     MachineState *ms = MACHINE(s);
     void *fdt;
     int cpu;
-    uint32_t *cells;
+    uint32_t *cells, cells_length;
     char *nodename;
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
     static const char * const ethclk_names[2] = { "pclk", "hclk" };
-    static const char * const plic_compat[2] = {
-        "sifive,plic-1.0.0", "riscv,plic0"
-    };
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
     g_autofree char *clust_name = NULL;
 
@@ -197,7 +194,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     g_free(nodename);
 
     plic_phandle = phandle++;
-    cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
+    cells_length = ms->smp.cpus * 4 - 2;
+    cells =  g_new0(uint32_t, cells_length);
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         /* cpu 0 is the management hart that does not have S-mode */
         if (cpu == 0) {
@@ -210,26 +208,14 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
         }
     }
-    nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
-        (long)memmap[SIFIVE_U_DEV_PLIC].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
-                          SIFIVE_U_PLIC_INT_CELLS);
-    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
-                          SIFIVE_U_PLIC_ADDR_CELLS);
-    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
-        (char **)&plic_compat, ARRAY_SIZE(plic_compat));
-    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, (ms->smp.cpus * 4 - 2) * sizeof(uint32_t));
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_DEV_PLIC].base,
-        0x0, memmap[SIFIVE_U_DEV_PLIC].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev",
-                          SIFIVE_U_PLIC_NUM_SOURCES - 1);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
+
+    create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
+                    memmap[SIFIVE_U_DEV_PLIC].size,
+                    plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
+                    SIFIVE_U_PLIC_ADDR_CELLS, cells,
+                    cells_length * sizeof(uint32_t),
+                    SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
     g_free(cells);
-    g_free(nodename);
 
     gpio_phandle = phandle++;
     nodename = g_strdup_printf("/soc/gpio@%lx",
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fa464e644f..92c30a6f4c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -326,39 +326,25 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     int cpu;
     g_autofree char *plic_name = NULL;
     g_autofree uint32_t *plic_cells;
-    unsigned long plic_addr;
     MachineState *ms = MACHINE(s);
-    static const char * const plic_compat[2] = {
-        "sifive,plic-1.0.0", "riscv,plic0"
-    };
+    unsigned long plic_addr = s->memmap[VIRT_PLIC].base +
+                              (s->memmap[VIRT_PLIC].size * socket);
+    bool numa_enabled = riscv_numa_enabled(MACHINE(s));
+    uint32_t cells_length;
 
-    plic_phandles[socket] = (*phandle)++;
-    plic_addr = s->memmap[VIRT_PLIC].base +
-                (s->memmap[VIRT_PLIC].size * socket);
     plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
-    qemu_fdt_add_subnode(ms->fdt, plic_name);
-    qemu_fdt_setprop_cell(ms->fdt, plic_name,
-        "#interrupt-cells", FDT_PLIC_INT_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, plic_name,
-        "#address-cells", FDT_PLIC_ADDR_CELLS);
-    qemu_fdt_setprop_string_array(ms->fdt, plic_name, "compatible",
-                                  (char **)&plic_compat,
-                                  ARRAY_SIZE(plic_compat));
-    qemu_fdt_setprop(ms->fdt, plic_name, "interrupt-controller", NULL, 0);
 
     if (kvm_enabled()) {
-        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
+        cells_length = s->soc[socket].num_harts * 2;
+        plic_cells = g_new0(uint32_t, cells_length);
 
         for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
             plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
             plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
         }
-
-        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
-                         plic_cells,
-                         s->soc[socket].num_harts * sizeof(uint32_t) * 2);
    } else {
-        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
+        cells_length = s->soc[socket].num_harts * 4;
+        plic_cells = g_new0(uint32_t, cells_length);
 
         for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
             plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
@@ -366,19 +352,16 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
             plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
             plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
         }
-
-        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
-                         plic_cells,
-                         s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     }
 
-    qemu_fdt_setprop_sized_cells(ms->fdt, plic_name, "reg",
-                                 2, plic_addr, 2, s->memmap[VIRT_PLIC].size);
-    qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
-                          VIRT_IRQCHIP_NUM_SOURCES - 1);
-    riscv_socket_fdt_write_id(ms, plic_name, socket);
-    qemu_fdt_setprop_cell(ms->fdt, plic_name, "phandle",
-        plic_phandles[socket]);
+    plic_phandles[socket] = (*phandle)++;
+
+    create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
+                    plic_phandles[socket], FDT_PLIC_INT_CELLS,
+                    FDT_PLIC_ADDR_CELLS, plic_cells,
+                    cells_length * sizeof(uint32_t),
+                    VIRT_IRQCHIP_NUM_SOURCES - 1,
+                    numa_enabled, socket);
 
     if (!socket) {
         platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
-- 
2.54.0


