Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1EAC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMb-0007Pf-S7; Fri, 04 Sep 2026 01:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMM-0007GK-3D
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:06 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MME-0001QI-Px
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:01 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so679175a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499257; x=1789104057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ebJAWqhE/c3qLIZNfeTusweGem8SvfGeZIqigBFha44=;
 b=rEbRPk4IgpEXVFN4vB15HGgGy27TE809SK1uplE2dZ0gDA2ZRMT6+I34TVtooo3ioc
 CCVns6nUpP/7CGm3zyv8w5Wmcujhx2VXs5f1pP+k4J/CGl77YtUezpAn8DMytDbd+jsw
 kRX3p2j2H0QyF9/zGic5y21ZxWN5JCIlelZOVrUG58AyB5Vg5OYRlgRptMbWnnUONXJm
 75KVZxq8hRcvZCH1eiBCzwg1I7yxB2THP0X8JJotAVoOxEQMEJwJWXiStOPf31bwWW97
 sNQVvxKlc8Z/M5Clg8qfCoSHGirJVz5ad3l/xRflDnL1MQREQlGoR90yzZGOwopa3rxg
 /SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499257; x=1789104057;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ebJAWqhE/c3qLIZNfeTusweGem8SvfGeZIqigBFha44=;
 b=nZbw56meIzU5DKb9jAU1mlirMNP/uaGuxnWifdCyQaE56Wi5hICwTckcUbCu2BjfqU
 y2244ot9OkZfAGUGz81tl72MYfyTswhAN7xI7MwRTpuF/pK8VPV/iqifvzWn3Kh8cM+b
 wfwA/1mL4JYeOrgY51f7M+5Mg9jJ0IjMxFeFSqcnnavQoGms1/zxvLbTR1Pg/eI8dqGX
 UT1oHj6eVvN8buuYVnbr8Z+C+1lOUhz7jhCFh7ETqfRcBxMbBBzNp0oIp8eTjwiDck8y
 cEJX44sz8hwN5PgPoFqsQG859dyc6kXo6jrDzJcqPZnh53tODo1xmhdhz+D9wSUp3wv0
 ePyQ==
X-Gm-Message-State: AFuF++m8TIsSXn0ViQYniWpzz39fQSGZcKVmgAjP61cSXlUP9vW+ZSR9
 Bd6xzptmR6C0EIVzVSPwv6rtqpJiIFvozXSUVtCCatJzjOb9aM31mVsvCs9DXg==
X-Gm-Gg: AYBFou1eTSLtobrhbatcs1M7T1earLSQb7I6GskBudn1a68sovaJetbiTgevBa/qqjl
 53xxlnsK96v9WHvdNt6OrMhoCaxbvhi26Fe7KWEqF6MYKi/FO14TkqV4nxVxDwdjw6YpLAI1zCd
 1s2QvPXpeRFQV1Z+965u3q6qkiJuNCenQCBNBFozYR5pNEszKOg8iHG22zwAQ1x1jre0XVzmZvw
 G2wIKA3uCCvwhQoMM2Y2iqkNrRDNoPc2T2G7/FKt1GNHJXVmZ7XZSUa6RAPrYtcknfSYCe9Jcd7
 P1bphrZks58GLr/1IqUlyst8Tlw0Snl22u+GRcpSrLUF4UcQYMyFexF4MGjwXh3CLJqqLfsTz2+
 GCh+nyL7aOn3nKF8yhhmjr+ZCI0XcdivHETyB5i4jx45mVjnCIUG3TZTtEKuvoosNTFmFpsi/Ah
 0i3ecjHHRbpLyBN9ajwliVC/emh4JAe79L8o89gQlGTuG9pTPDL9esWf+bX9sF+/pQZGE4uohYS
 8cKppnY0kQX0D52
X-Received: by 2002:a05:6a20:430b:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3da3a04b312mr5232777637.21.1788499257149; 
 Thu, 03 Sep 2026 22:20:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 20/47] hw/riscv/fdt_common,
 virt.c: add riscv_create_fdt_socket_aplic()
Date: Fri,  4 Sep 2026 15:19:16 +1000
Message-ID: <20260904051943.799041-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Similar to what we did with 'imsic' in the previous patch, including
creating a helper struct to encapsulate the extra arguments required to
create the FDT.

TODO: I believe the tt-atlantis board can use this same helper too.  We
just need to verify how to map the phandles used by it and what the
helper is using (which was inherited by the 'virt' board).

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260828203918.350131-8-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  19 +++++
 hw/riscv/fdt-common.c         | 109 ++++++++++++++++++++++++++
 hw/riscv/virt.c               | 139 ++++++----------------------------
 3 files changed, 151 insertions(+), 116 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 182c03d8ce..8207cfee7b 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -12,6 +12,7 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "exec/hwaddr.h"
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
@@ -50,6 +51,18 @@ typedef struct IMSICFdtProps {
     int aia_guests;
 } IMSICFdtProps;
 
+typedef struct APLICFdtProps {
+    const MemMapEntry *aplic_m;
+    const MemMapEntry *aplic_s;
+    const MemMapEntry *platform_bus;
+    int platform_bus_irq;
+    int socket;
+    int num_harts;
+    bool numa_enabled;
+    int irqchip_num_sources;
+    int aia_type;
+} APLICFdtProps;
+
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size);
 void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -98,4 +111,10 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
 void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
                             uint32_t *next_phandle, uint32_t *intc_phandles,
                             uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
+void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                                   uint32_t msi_m_phandle,
+                                   uint32_t msi_s_phandle,
+                                   uint32_t *next_phandle,
+                                   uint32_t *intc_phandles,
+                                   uint32_t *aplic_phandles);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ae24ad0011..d815c5adff 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
+#include "hw/core/sysbus-fdt.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
@@ -593,3 +594,111 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
                          imsic_num_bits(props->aia_guests + 1));
 
 }
+
+/* Caller must free string after use */
+static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
+{
+    return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
+                           aplic_addr);
+}
+
+static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
+                                 hwaddr aplic_addr, uint32_t aplic_size,
+                                 uint32_t msi_phandle,
+                                 uint32_t *intc_phandles,
+                                 uint32_t aplic_phandle,
+                                 uint32_t aplic_child_phandle,
+                                 bool m_mode)
+{
+    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
+    static const char * const aplic_compat[2] = {
+        "qemu,aplic", "riscv,aplic"
+    };
+
+    for (int cpu = 0; cpu < props->num_harts; cpu++) {
+        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
+    }
+
+    qemu_fdt_add_subnode(fdt, aplic_name);
+    qemu_fdt_setprop_string_array(fdt, aplic_name, "compatible",
+                                  (char **)&aplic_compat,
+                                  ARRAY_SIZE(aplic_compat));
+    qemu_fdt_setprop_cell(fdt, aplic_name, "#address-cells",
+                          FDT_APLIC_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, aplic_name,
+                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
+    qemu_fdt_setprop(fdt, aplic_name, "interrupt-controller", NULL, 0);
+
+    if (props->aia_type == AIA_TYPE_APLIC) {
+        qemu_fdt_setprop(fdt, aplic_name, "interrupts-extended",
+                         aplic_cells, props->num_harts * sizeof(uint32_t) * 2);
+    } else {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "msi-parent", msi_phandle);
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, aplic_name, "reg",
+                                 2, aplic_addr, 2, aplic_size);
+    qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,num-sources",
+                          props->irqchip_num_sources);
+
+    if (aplic_child_phandle) {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,children",
+                              aplic_child_phandle);
+        qemu_fdt_setprop_cells(fdt, aplic_name, "riscv,delegation",
+                               aplic_child_phandle, 0x1,
+                               props->irqchip_num_sources);
+    }
+
+    if (props->numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "numa-node-id", props->socket);
+    }
+
+    qemu_fdt_setprop_cell(fdt, aplic_name, "phandle", aplic_phandle);
+}
+
+void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                                   uint32_t msi_m_phandle,
+                                   uint32_t msi_s_phandle,
+                                   uint32_t *next_phandle,
+                                   uint32_t *intc_phandles,
+                                   uint32_t *aplic_phandles)
+{
+    uint32_t aplic_m_phandle, aplic_s_phandle;
+    hwaddr aplic_addr;
+
+    if (next_phandle) {
+        aplic_m_phandle = (*next_phandle)++;
+        aplic_s_phandle = (*next_phandle)++;
+    } else {
+        aplic_m_phandle = qemu_fdt_alloc_phandle(fdt);
+        aplic_s_phandle = qemu_fdt_alloc_phandle(fdt);
+    }
+
+    if (props->aplic_m) {
+        /* M-level APLIC node */
+        aplic_addr = props->aplic_m->base + (props->aplic_m->size * props->socket);
+        create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_m->size,
+                             msi_m_phandle, intc_phandles,
+                             aplic_m_phandle, aplic_s_phandle,
+                             true);
+    }
+
+    /* S-level APLIC node */
+    aplic_addr = props->aplic_s->base + (props->aplic_s->size * props->socket);
+    create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_s->size,
+                         msi_s_phandle, intc_phandles,
+                         aplic_s_phandle, 0,
+                         false);
+
+    if (!props->socket && props->platform_bus_irq) {
+        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
+                                       props->platform_bus->base,
+                                       props->platform_bus->size,
+                                       props->platform_bus_irq);
+    }
+
+    aplic_phandles[props->socket] = aplic_s_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cb6cd8f030..63a32de3b4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -319,113 +319,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     }
 }
 
-/* Caller must free string after use */
-static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
-{
-    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
-}
-
-static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
-                                 unsigned long aplic_addr, uint32_t aplic_size,
-                                 uint32_t msi_phandle,
-                                 uint32_t *intc_phandles,
-                                 uint32_t aplic_phandle,
-                                 uint32_t aplic_child_phandle,
-                                 bool m_mode, int num_harts)
-{
-    int cpu;
-    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
-    MachineState *ms = MACHINE(s);
-    static const char * const aplic_compat[2] = {
-        "qemu,aplic", "riscv,aplic"
-    };
-
-    for (cpu = 0; cpu < num_harts; cpu++) {
-        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
-    }
-
-    qemu_fdt_add_subnode(ms->fdt, aplic_name);
-    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
-                                  (char **)&aplic_compat,
-                                  ARRAY_SIZE(aplic_compat));
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
-                          FDT_APLIC_ADDR_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
-                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
-    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
-
-    if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
-        qemu_fdt_setprop(ms->fdt, aplic_name, "interrupts-extended",
-                         aplic_cells, num_harts * sizeof(uint32_t) * 2);
-    } else {
-        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
-    }
-
-    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
-                                 2, aplic_addr, 2, aplic_size);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
-                          VIRT_IRQCHIP_NUM_SOURCES);
-
-    if (aplic_child_phandle) {
-        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
-                              aplic_child_phandle);
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
-                               aplic_child_phandle, 0x1,
-                               VIRT_IRQCHIP_NUM_SOURCES);
-    }
-
-    riscv_socket_fdt_write_id(ms, aplic_name, socket);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
-}
-
-static void create_fdt_socket_aplic(RISCVVirtState *s,
-                                    int socket,
-                                    uint32_t msi_m_phandle,
-                                    uint32_t msi_s_phandle,
-                                    uint32_t *phandle,
-                                    uint32_t *intc_phandles,
-                                    uint32_t *aplic_phandles,
-                                    int num_harts)
-{
-    unsigned long aplic_addr;
-    MachineState *ms = MACHINE(s);
-    uint32_t aplic_m_phandle, aplic_s_phandle;
-
-    aplic_m_phandle = (*phandle)++;
-    aplic_s_phandle = (*phandle)++;
-
-    if (!kvm_enabled()) {
-        /* M-level APLIC node */
-        aplic_addr = s->memmap[VIRT_APLIC_M].base +
-                     (s->memmap[VIRT_APLIC_M].size * socket);
-        create_fdt_one_aplic(s, socket, aplic_addr,
-                             s->memmap[VIRT_APLIC_M].size,
-                             msi_m_phandle, intc_phandles,
-                             aplic_m_phandle, aplic_s_phandle,
-                             true, num_harts);
-    }
-
-    /* S-level APLIC node */
-    aplic_addr = s->memmap[VIRT_APLIC_S].base +
-                 (s->memmap[VIRT_APLIC_S].size * socket);
-    create_fdt_one_aplic(s, socket, aplic_addr, s->memmap[VIRT_APLIC_S].size,
-                         msi_s_phandle, intc_phandles,
-                         aplic_s_phandle, 0,
-                         false, num_harts);
-
-    if (!socket) {
-        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
-                                       s->memmap[VIRT_PLATFORM_BUS].base,
-                                       s->memmap[VIRT_PLATFORM_BUS].size,
-                                       VIRT_PLATFORM_BUS_IRQ);
-    }
-
-    aplic_phandles[socket] = aplic_s_phandle;
-}
-
 static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
@@ -452,6 +345,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     int socket_count = riscv_socket_count(ms);
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
+    APLICFdtProps aplic_props;
 
     riscv_fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
@@ -509,15 +403,26 @@ static void create_fdt_sockets(RISCVVirtState *s,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
+    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
+        aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
+        aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
+        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
+        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
+        aplic_props.socket = 0;
+        aplic_props.num_harts = ms->smp.cpus;
+        aplic_props.numa_enabled = numa_enabled;
+        aplic_props.irqchip_num_sources = VIRT_IRQCHIP_NUM_SOURCES;
+        aplic_props.aia_type = s->aia_type;
+    }
+
     /*
      * With KVM AIA aplic-imsic, using an irqchip without split
      * mode, we'll use only one APLIC instance.
      */
     if (!virt_use_emulated_aplic(s->aia_type)) {
-        create_fdt_socket_aplic(s, 0,
-                                msi_m_phandle, msi_s_phandle, phandle,
-                                &intc_phandles[0], xplic_phandles,
-                                ms->smp.cpus);
+        riscv_create_fdt_socket_aplic(ms->fdt, &aplic_props,
+                                      msi_m_phandle, msi_s_phandle, phandle,
+                                      &intc_phandles[0], xplic_phandles);
 
         *irq_mmio_phandle = xplic_phandles[0];
         *irq_virtio_phandle = xplic_phandles[0];
@@ -532,11 +437,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
                                        &intc_phandles[phandle_pos],
                                        xplic_phandles);
             } else {
-                create_fdt_socket_aplic(s, socket,
-                                        msi_m_phandle, msi_s_phandle, phandle,
-                                        &intc_phandles[phandle_pos],
-                                        xplic_phandles,
-                                        s->soc[socket].num_harts);
+                aplic_props.socket = socket;
+                aplic_props.num_harts = s->soc[socket].num_harts;
+                riscv_create_fdt_socket_aplic(ms->fdt, &aplic_props,
+                                              msi_m_phandle, msi_s_phandle,
+                                              phandle,
+                                              &intc_phandles[phandle_pos],
+                                              xplic_phandles);
             }
         }
 
-- 
2.55.0


