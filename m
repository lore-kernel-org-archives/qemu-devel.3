Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB85CD98E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk4-0000yw-Lb; Tue, 16 Jun 2026 06:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk2-0000aj-Dn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:58 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk0-0004AX-8i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c859878eb48so1743209a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604595; x=1782209395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wdx0SFX2aYhmNm/ywqM6TXpg1nVDqEWSuSpbqkMHlY=;
 b=JKHNoz4Z8HWyyugG1Qbg1MizvJDiUyikHhUSl/IrTHr5s8bTdR3vBvBtV/xfrWCr8h
 wqnjkISL9Bpuu6m2snA93RkL9D9liaq00+zOeFIqyKQRDeDIZyteRhtIJ/G2WpXcBJOg
 jwiZw36moly0OP0tGPCKsPf6c38hDrGj+n7mI9IVb/Xpaj4hbWNVn2zFogkrJwjtyitR
 BqdWrFfDY/7A8FYpZelTFF7DLAB6DRSNjzPo8A+mFFK7bK++6AByS+skMlRLheUavwyo
 8PLcpO1vg/ST6Fnovpa3g88bK8DiJZLk1+19c/+VD0mSFkfNEQTeu3qQH3kvGvt+4MiU
 CQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604595; x=1782209395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9wdx0SFX2aYhmNm/ywqM6TXpg1nVDqEWSuSpbqkMHlY=;
 b=Og69LXQy9BsRZedncRs3Ox3OcxdqfW+IfZKnPYHhgPQZUtdiSul5caepwuwuZoyo02
 DO5f/VzTlMexacsSYJBoPs5JQg79iIgvsGRxnszqdKGh/X/saf1H/9JRPXNz4RQKFHtB
 Fc05GTnVkBzRYE3EdII1/6ZmxfCZ2OO3N+Kq2xuRmLcfd4vvYr1IzslldI5blCTOf8Iy
 TQmtPZAkdVeHx9eDq+nd9V4OfINojGWX/+y8lrD0doSb+SGninnuDo8pGqlo2r0BQurT
 W2upSwR3629BVgFA59E2YVR1SZ18QY963mUdHoIkMPc3FI4M9hvZuZtoj4L5X7p+Y/a3
 HHag==
X-Gm-Message-State: AOJu0YywdKk0rc2BVdaxsabvGLb35Qb80gB5OZcajLu9Ukguo/Y48/sZ
 zQq6iO0ALXVJE0KtqJXQ7dZLOfaQzHy0oSgK0QUS04iufP/Fq7wyp2ocymBaytqZ
X-Gm-Gg: Acq92OEchabwxIW77VXOUXWXfzwLb69atCTDsXQajcqgVW70FxqorCYdmBb7hmUdxR3
 dU/S4mnmJtk6KWxE17UMVe/GLb1hQOWmVM3y7kMgevnkcGHiYF2mJGylaBEQIu7YjqlfvDXRAZY
 p1vdUQAiakb8gZkmguc0MWMZQoyEy3uvn7Ks8OXi1yQaZoZ8+UHMwJlsL80azXJZexe/BYtKFTH
 C473McOYrrYhj+zzYI3YSL2M4pCufxGd/WSneCIUpJfj3W1vJvqgSwJZL/1a+5EBeRy3SxyBKIT
 jxRtPL5u3LACy/dF2QEkQ3dRdWpha5RXGQdWykauDaZb9niVPXCAhFlQM9Td5gzNTa0vLDPKXwE
 DdDe2pPi3+yMxIYG+WR+kf0yHWgmC26eDdzNUPNMNOjAQhltekVGuAmtgjv3ISTKX5OV+SpeXKV
 G/Oug2nYHAp4922ng5Kz4B3wndDluV5vEgSk5oRhdq92Qc8XVTb3E=
X-Received: by 2002:a05:6a21:6190:b0:3b4:7880:10c9 with SMTP id
 adf61e73a8af0-3b796423baamr17253540637.43.1781604594761; 
 Tue, 16 Jun 2026 03:09:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 74/83] hw/riscv: add create_fdt_socket_memory() helper
Date: Tue, 16 Jun 2026 20:05:17 +1000
Message-ID: <20260616100527.1939565-75-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
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

This helper encapsulates the creation of /memory@addr FDT subnodes.

Boards are responsible for calculating the adequate addr, size and
inform if we have numa enabled.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  2 ++
 hw/riscv/fdt-common.c         | 15 +++++++++++++++
 hw/riscv/sifive_u.c           | 11 ++---------
 hw/riscv/spike.c              | 18 +++++++-----------
 hw/riscv/virt.c               | 23 ++++++-----------------
 5 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index adf9b33dfd..81689f418b 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -11,4 +11,6 @@
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
+void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                              int socket_id, bool numa_enabled);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index b155246998..719c36e001 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -10,6 +10,7 @@
 
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
+#include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
@@ -35,3 +36,17 @@ void *create_board_device_tree(const char *model, const char *compatible,
 
     return fdt;
 }
+
+void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
+                              int socket_id, bool numa_enabled)
+{
+    g_autofree char *mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
+
+    qemu_fdt_add_subnode(fdt, mem_name);
+    qemu_fdt_setprop_sized_cells(fdt, mem_name, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
+
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket_id);
+    }
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5d3b2751ad..a00cfd08a7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -98,7 +98,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
                        bool is_32_bit)
 {
     MachineState *ms = MACHINE(s);
-    uint64_t mem_size = ms->ram_size;
     void *fdt;
     int cpu;
     uint32_t *cells;
@@ -138,14 +137,8 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SIFIVE_U_DEV_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        memmap[SIFIVE_U_DEV_DRAM].base >> 32, memmap[SIFIVE_U_DEV_DRAM].base,
-        mem_size >> 32, mem_size);
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-    g_free(nodename);
+    create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
+                             ms->ram_size, 0, false);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 79c9bb041f..92facba29d 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -55,13 +55,12 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
 {
     void *fdt;
     int fdt_size;
-    uint64_t addr, size;
     unsigned long clint_addr;
     int cpu, socket;
     MachineState *ms = MACHINE(s);
     uint32_t *clint_cells;
     uint32_t cpu_phandle, intc_phandle, phandle = 1;
-    char *mem_name, *clint_name, *clust_name;
+    char *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -85,6 +84,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 
     for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
+        hwaddr memaddr = memmap[SPIKE_DRAM].base +
+                         riscv_socket_mem_offset(ms, socket);
+        uint64_t memsize =  riscv_socket_mem_size(ms, socket);
+
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
         qemu_fdt_add_subnode(fdt, clust_name);
 
@@ -133,15 +136,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             g_free(cpu_name);
         }
 
-        addr = memmap[SPIKE_DRAM].base + riscv_socket_mem_offset(ms, socket);
-        size = riscv_socket_mem_size(ms, socket);
-        mem_name = g_strdup_printf("/memory@%lx", (long)addr);
-        qemu_fdt_add_subnode(fdt, mem_name);
-        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
-            addr >> 32, addr, size >> 32, size);
-        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
-        riscv_socket_fdt_write_id(ms, mem_name, socket);
-        g_free(mem_name);
+        create_fdt_socket_memory(fdt, memaddr, memsize, socket,
+                                 riscv_numa_enabled(ms));
 
         clint_addr = memmap[SPIKE_CLINT].base +
             (memmap[SPIKE_CLINT].size * socket);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cb1d83fd48..df3eadef78 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -302,22 +302,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     }
 }
 
-static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
-{
-    g_autofree char *mem_name = NULL;
-    hwaddr addr;
-    uint64_t size;
-    MachineState *ms = MACHINE(s);
-
-    addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
-    size = riscv_socket_mem_size(ms, socket);
-    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
-    qemu_fdt_add_subnode(ms->fdt, mem_name);
-    qemu_fdt_setprop_sized_cells(ms->fdt, mem_name, "reg", 2, addr, 2, size);
-    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
-    riscv_socket_fdt_write_id(ms, mem_name, socket);
-}
-
 static void create_fdt_socket_clint(RISCVVirtState *s,
                                     int socket,
                                     uint32_t *intc_phandles)
@@ -759,6 +743,10 @@ static void create_fdt_sockets(RISCVVirtState *s,
     phandle_pos = ms->smp.cpus;
     for (socket = (socket_count - 1); socket >= 0; socket--) {
         g_autofree char *clust_name = NULL;
+        hwaddr memaddr = s->memmap[VIRT_DRAM].base +
+                         riscv_socket_mem_offset(ms, socket);
+        uint64_t memsize = riscv_socket_mem_size(ms, socket);
+
         phandle_pos -= s->soc[socket].num_harts;
 
         clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
@@ -767,7 +755,8 @@ static void create_fdt_sockets(RISCVVirtState *s,
         create_fdt_socket_cpus(s, socket, clust_name, phandle,
                                &intc_phandles[phandle_pos]);
 
-        create_fdt_socket_memory(s, socket);
+        create_fdt_socket_memory(ms->fdt, memaddr, memsize,
+                                 socket, riscv_numa_enabled(ms));
 
         if (virt_aclint_allowed() && s->have_aclint) {
             create_fdt_socket_aclint(s, socket,
-- 
2.54.0


