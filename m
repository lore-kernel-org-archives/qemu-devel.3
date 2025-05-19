Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC62C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4w-0004cx-FZ; Mon, 19 May 2025 00:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpA-00009r-JR
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:03 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrp8-0004QE-2R
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af59c920d32so2500407a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627796; x=1748232596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaRnZd2vCdVT+sLYYKhYWL8+DRdee1Kb+vvdCs/4kqM=;
 b=lSRL8jLKQ0QC+Bdu8UTXgeLQ/Bx8xMCgfpO+gjWyaVTGfctL2I74sDPi8aaKghU5gj
 onCqj4Go8f9/NruG3tD6LP8gWlu8UbjJvjEe6rFoMPYWBTYSvMLZVg2qmK4w5ZeCbxD2
 N4f5Ld9ozjr9GJMBS5Eyi0vWoNo8m9IbxQETuDFE6R565U6LokaD0ejT9c9ljK5Dnpiu
 /OVy7l5FABrtkkwvbtUmfmKT8PiRblS8naPJUgB1xUz49wgp0NYtivLN4c6Z5uLd7xCZ
 wrLQeksLvSjJgOSJDdnf1+W4WD27xDA0RAgJulguceVJ+PcsqoeSxw2SQ4eWUrYD95lv
 oBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627796; x=1748232596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaRnZd2vCdVT+sLYYKhYWL8+DRdee1Kb+vvdCs/4kqM=;
 b=g0mRxCF7IOL3KVBemsOTAIYgGVBmxFJCib/XVc3nLr8bYrIqrZ3y9QeFAfB5Vv2rD0
 6310H2Z8DzbYj9YoS+0K7qrmS4LL56utIihrUW+jPyQ5tegsG30m3ZmTiIK2e1vYaMUD
 6GBAZ+4kuYZ5u1Nzci5N1C+4s0PTpAMJMwCOI2mQbAmkdnMq8RTJ5W14o+/Al4aB0wiQ
 XNSS/ys/J8AqoGqxSLjpClj+E2KLhCn8qHxWcu+ifIpYPFptcv3hJv+Yu0q4KmXedyaP
 fNkB2tybYMl25YU4MCmZZ0PvJb+b4lCxHl5bLXPOjvipr4gm6wtZGp67vXyl7CgPPjo5
 h+qQ==
X-Gm-Message-State: AOJu0Yw/nUQLe8xuxJh0xlOMU0Yatf79pYUvYL8A7shToGujz6SlEdsQ
 Jx4xeYQRIiBXSGxSBRiCDpsJV1JCn6cr8d4p/rP0vjiIqNcWU8mszWMt2a8ZWA==
X-Gm-Gg: ASbGnctFyzQZ3xV8E09M48QiuptEyqhnt03+o9VIPlJhpmczEJQc54EMUo7Sf9mDm1g
 D2DQwaJAslqgodecKWtPkG588i2LkkjjCFEPHiLnLgtWAb1DKwzRt7yZHsvqxzOgnFGjE/yPd4n
 x/dMYe8lce9WliZr8juc5u+MoBoHNBVpMJ+wmZuAbGQKeHOG0YxoSKvazyUyZvPxgGBl5ulOnhG
 GFco1MoADU522tjUYsPxJlq6wJYl4QfTlQDtjK3/p42YJcE+z9jX9sgcXOBVQ0okyg6q3Wgz+4Y
 Bzoccon9xxwmmqebIaWwc/xT0ntyVvToRWYYtOnYrfUSF5D9k24Am2I1u29u0XS1BSj1gzuwqi2
 xyK0XNxkDlM+WT5WMbtOUUsV9vEL6c80uksMe/9u8UrgNNqhT4JAuir8Q
X-Google-Smtp-Source: AGHT+IH4hS8OzJvYwP5s74emapmY704ijLGVfoiv2GzO6x6tjD/kux7Jnu6aYJkzVN6FZldn+/iRIg==
X-Received: by 2002:a17:903:94f:b0:223:5ca1:3b0b with SMTP id
 d9443c01a7336-231d45a9aa0mr177243175ad.40.1747627795807; 
 Sun, 18 May 2025 21:09:55 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/56] hw/riscv/virt.c: use s->memmap in create_fdt_sockets()
 path
Date: Mon, 19 May 2025 14:05:50 +1000
Message-ID: <20250519040555.3797167-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

create_fdt_sockets() and all its fdt helpers (create_fdt_socket_aplic(),
create_fdt_imsic(), create_fdt_socket_plic(), create_fdt_socket_aclint()
and create_fdt_socket_memory()) can use s->memmap from their
RISCVVirtState pointer instead of having an extra memmap argument.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 89 ++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8a703a0233..e66a46f524 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -301,14 +301,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     }
 }
 
-static void create_fdt_socket_memory(RISCVVirtState *s,
-                                     const MemMapEntry *memmap, int socket)
+static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
 {
     g_autofree char *mem_name = NULL;
     uint64_t addr, size;
     MachineState *ms = MACHINE(s);
 
-    addr = memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
+    addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
     size = riscv_socket_mem_size(ms, socket);
     mem_name = g_strdup_printf("/memory@%lx", (long)addr);
     qemu_fdt_add_subnode(ms->fdt, mem_name);
@@ -319,7 +318,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s,
 }
 
 static void create_fdt_socket_clint(RISCVVirtState *s,
-                                    const MemMapEntry *memmap, int socket,
+                                    int socket,
                                     uint32_t *intc_phandles)
 {
     int cpu;
@@ -340,21 +339,22 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
         clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
     }
 
-    clint_addr = memmap[VIRT_CLINT].base + (memmap[VIRT_CLINT].size * socket);
+    clint_addr = s->memmap[VIRT_CLINT].base +
+                 (s->memmap[VIRT_CLINT].size * socket);
     clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
     qemu_fdt_add_subnode(ms->fdt, clint_name);
     qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
                                   (char **)&clint_compat,
                                   ARRAY_SIZE(clint_compat));
     qemu_fdt_setprop_cells(ms->fdt, clint_name, "reg",
-        0x0, clint_addr, 0x0, memmap[VIRT_CLINT].size);
+        0x0, clint_addr, 0x0, s->memmap[VIRT_CLINT].size);
     qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
         clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     riscv_socket_fdt_write_id(ms, clint_name, socket);
 }
 
 static void create_fdt_socket_aclint(RISCVVirtState *s,
-                                     const MemMapEntry *memmap, int socket,
+                                     int socket,
                                      uint32_t *intc_phandles)
 {
     int cpu;
@@ -381,8 +381,10 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
     aclint_cells_size = s->soc[socket].num_harts * sizeof(uint32_t) * 2;
 
     if (s->aia_type != VIRT_AIA_TYPE_APLIC_IMSIC) {
-        addr = memmap[VIRT_CLINT].base + (memmap[VIRT_CLINT].size * socket);
+        addr = s->memmap[VIRT_CLINT].base +
+               (s->memmap[VIRT_CLINT].size * socket);
         name = g_strdup_printf("/soc/mswi@%lx", addr);
+
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible",
             "riscv,aclint-mswi");
@@ -397,13 +399,13 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
     }
 
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        addr = memmap[VIRT_CLINT].base +
+        addr = s->memmap[VIRT_CLINT].base +
                (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket);
         size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
     } else {
-        addr = memmap[VIRT_CLINT].base + RISCV_ACLINT_SWI_SIZE +
-            (memmap[VIRT_CLINT].size * socket);
-        size = memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
+        addr = s->memmap[VIRT_CLINT].base + RISCV_ACLINT_SWI_SIZE +
+               (s->memmap[VIRT_CLINT].size * socket);
+        size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
     }
     name = g_strdup_printf("/soc/mtimer@%lx", addr);
     qemu_fdt_add_subnode(ms->fdt, name);
@@ -420,14 +422,15 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
     g_free(name);
 
     if (s->aia_type != VIRT_AIA_TYPE_APLIC_IMSIC) {
-        addr = memmap[VIRT_ACLINT_SSWI].base +
-            (memmap[VIRT_ACLINT_SSWI].size * socket);
+        addr = s->memmap[VIRT_ACLINT_SSWI].base +
+               (s->memmap[VIRT_ACLINT_SSWI].size * socket);
+
         name = g_strdup_printf("/soc/sswi@%lx", addr);
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible",
             "riscv,aclint-sswi");
         qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, addr, 0x0, memmap[VIRT_ACLINT_SSWI].size);
+            0x0, addr, 0x0, s->memmap[VIRT_ACLINT_SSWI].size);
         qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
             aclint_sswi_cells, aclint_cells_size);
         qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
@@ -438,7 +441,7 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
 }
 
 static void create_fdt_socket_plic(RISCVVirtState *s,
-                                   const MemMapEntry *memmap, int socket,
+                                   int socket,
                                    uint32_t *phandle, uint32_t *intc_phandles,
                                    uint32_t *plic_phandles)
 {
@@ -452,7 +455,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     };
 
     plic_phandles[socket] = (*phandle)++;
-    plic_addr = memmap[VIRT_PLIC].base + (memmap[VIRT_PLIC].size * socket);
+    plic_addr = s->memmap[VIRT_PLIC].base +
+                (s->memmap[VIRT_PLIC].size * socket);
     plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
     qemu_fdt_add_subnode(ms->fdt, plic_name);
     qemu_fdt_setprop_cell(ms->fdt, plic_name,
@@ -491,7 +495,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     }
 
     qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
-        0x0, plic_addr, 0x0, memmap[VIRT_PLIC].size);
+        0x0, plic_addr, 0x0, s->memmap[VIRT_PLIC].size);
     qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
                           VIRT_IRQCHIP_NUM_SOURCES - 1);
     riscv_socket_fdt_write_id(ms, plic_name, socket);
@@ -500,8 +504,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
 
     if (!socket) {
         platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
-                                       memmap[VIRT_PLATFORM_BUS].base,
-                                       memmap[VIRT_PLATFORM_BUS].size,
+                                       s->memmap[VIRT_PLATFORM_BUS].base,
+                                       s->memmap[VIRT_PLATFORM_BUS].size,
                                        VIRT_PLATFORM_BUS_IRQ);
     }
 }
@@ -588,7 +592,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
     qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
 }
 
-static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
+static void create_fdt_imsic(RISCVVirtState *s,
                              uint32_t *phandle, uint32_t *intc_phandles,
                              uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
 {
@@ -597,12 +601,12 @@ static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
 
     if (!kvm_enabled()) {
         /* M-level IMSIC node */
-        create_fdt_one_imsic(s, memmap[VIRT_IMSIC_M].base, intc_phandles,
+        create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_M].base, intc_phandles,
                              *msi_m_phandle, true, 0);
     }
 
     /* S-level IMSIC node */
-    create_fdt_one_imsic(s, memmap[VIRT_IMSIC_S].base, intc_phandles,
+    create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_S].base, intc_phandles,
                          *msi_s_phandle, false,
                          imsic_num_bits(s->aia_guests + 1));
 
@@ -679,7 +683,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
 }
 
 static void create_fdt_socket_aplic(RISCVVirtState *s,
-                                    const MemMapEntry *memmap, int socket,
+                                    int socket,
                                     uint32_t msi_m_phandle,
                                     uint32_t msi_s_phandle,
                                     uint32_t *phandle,
@@ -696,18 +700,19 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
 
     if (!kvm_enabled()) {
         /* M-level APLIC node */
-        aplic_addr = memmap[VIRT_APLIC_M].base +
-                     (memmap[VIRT_APLIC_M].size * socket);
-        create_fdt_one_aplic(s, socket, aplic_addr, memmap[VIRT_APLIC_M].size,
+        aplic_addr = s->memmap[VIRT_APLIC_M].base +
+                     (s->memmap[VIRT_APLIC_M].size * socket);
+        create_fdt_one_aplic(s, socket, aplic_addr,
+                             s->memmap[VIRT_APLIC_M].size,
                              msi_m_phandle, intc_phandles,
                              aplic_m_phandle, aplic_s_phandle,
                              true, num_harts);
     }
 
     /* S-level APLIC node */
-    aplic_addr = memmap[VIRT_APLIC_S].base +
-                 (memmap[VIRT_APLIC_S].size * socket);
-    create_fdt_one_aplic(s, socket, aplic_addr, memmap[VIRT_APLIC_S].size,
+    aplic_addr = s->memmap[VIRT_APLIC_S].base +
+                 (s->memmap[VIRT_APLIC_S].size * socket);
+    create_fdt_one_aplic(s, socket, aplic_addr, s->memmap[VIRT_APLIC_S].size,
                          msi_s_phandle, intc_phandles,
                          aplic_s_phandle, 0,
                          false, num_harts);
@@ -715,8 +720,8 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
     if (!socket) {
         g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
         platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
-                                       memmap[VIRT_PLATFORM_BUS].base,
-                                       memmap[VIRT_PLATFORM_BUS].size,
+                                       s->memmap[VIRT_PLATFORM_BUS].base,
+                                       s->memmap[VIRT_PLATFORM_BUS].size,
                                        VIRT_PLATFORM_BUS_IRQ);
     }
 
@@ -734,7 +739,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
     riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
 }
 
-static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
+static void create_fdt_sockets(RISCVVirtState *s,
                                uint32_t *phandle,
                                uint32_t *irq_mmio_phandle,
                                uint32_t *irq_pcie_phandle,
@@ -770,20 +775,20 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         create_fdt_socket_cpus(s, socket, clust_name, phandle,
                                &intc_phandles[phandle_pos]);
 
-        create_fdt_socket_memory(s, memmap, socket);
+        create_fdt_socket_memory(s, socket);
 
         if (virt_aclint_allowed() && s->have_aclint) {
-            create_fdt_socket_aclint(s, memmap, socket,
+            create_fdt_socket_aclint(s, socket,
                                      &intc_phandles[phandle_pos]);
         } else if (tcg_enabled()) {
-            create_fdt_socket_clint(s, memmap, socket,
+            create_fdt_socket_clint(s, socket,
                                     &intc_phandles[phandle_pos]);
         }
     }
 
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        create_fdt_imsic(s, memmap, phandle, intc_phandles,
-            &msi_m_phandle, &msi_s_phandle);
+        create_fdt_imsic(s, phandle, intc_phandles,
+                         &msi_m_phandle, &msi_s_phandle);
         *msi_pcie_phandle = msi_s_phandle;
     }
 
@@ -792,7 +797,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
      * mode, we'll use only one APLIC instance.
      */
     if (!virt_use_emulated_aplic(s->aia_type)) {
-        create_fdt_socket_aplic(s, memmap, 0,
+        create_fdt_socket_aplic(s, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
                                 ms->smp.cpus);
@@ -806,11 +811,11 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
             phandle_pos -= s->soc[socket].num_harts;
 
             if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-                create_fdt_socket_plic(s, memmap, socket, phandle,
+                create_fdt_socket_plic(s, socket, phandle,
                                        &intc_phandles[phandle_pos],
                                        xplic_phandles);
             } else {
-                create_fdt_socket_aplic(s, memmap, socket,
+                create_fdt_socket_aplic(s, socket,
                                         msi_m_phandle, msi_s_phandle, phandle,
                                         &intc_phandles[phandle_pos],
                                         xplic_phandles,
@@ -1126,7 +1131,7 @@ static void finalize_fdt(RISCVVirtState *s)
     uint32_t irq_pcie_phandle = 1, irq_virtio_phandle = 1;
     uint32_t iommu_sys_phandle = 1;
 
-    create_fdt_sockets(s, s->memmap, &phandle, &irq_mmio_phandle,
+    create_fdt_sockets(s, &phandle, &irq_mmio_phandle,
                        &irq_pcie_phandle, &irq_virtio_phandle,
                        &msi_pcie_phandle);
 
-- 
2.49.0


