Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNM3H-00038X-9U; Sat, 31 Oct 2026 23:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM3C-00035F-Sm; Sat, 31 Oct 2026 23:16:07 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM38-0000K6-B0; Sat, 31 Oct 2026 23:16:06 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJ5jlruZqSD4aAA--.22476S5;
 Sun, 01 Nov 2026 11:15:56 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 3/5] hw/riscv: Move platform bus FDT creation to machine code
Date: Sun,  1 Nov 2026 11:15:45 +0800
Message-ID: <20261101031547.125591-4-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJ5jlruZqSD4aAA--.22476S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyrKry8uFykGrW3uryfJFb_yoWxGw45pF
 W8CF47ZFW8GF1aga13Aw48XrW3CwsYkr47Xw1xuryIywsrXr43Ja1kt3WUZFy5tFyUAas0
 9a1vgry5AF4FgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUH214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
 IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
 McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I64
 8v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK
 6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj6uWPUUUU
 U==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

riscv_create_fdt_socket_aplic() contains a direct reference to
platform_bus_add_all_fdt_nodes(), even though fdt-common.c is
built unconditionally and CONFIG_PLATFORM_BUS may be disabled.

This causes an undefined reference in minimal RISC-V builds
without platform bus support.

Move platform bus FDT creation to the virt and server reference
machines, which both select CONFIG_PLATFORM_BUS. Export a helper
to obtain the APLIC node name and remove the platform bus fields
from APLICFdtProps.

This removes the dependency from the common APLIC FDT helper
while preserving the platform bus interrupt-parent configuration.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/fdt-common.c          | 13 ++-----------
 hw/riscv/server_platform_ref.c |  9 +++++++--
 hw/riscv/virt.c                | 11 +++++++++--
 include/hw/riscv/fdt-common.h  |  3 +--
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ce2dcb43b4..e90502b1bc 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -11,7 +11,6 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
-#include "hw/core/sysbus-fdt.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
@@ -599,7 +598,7 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
 }
 
 /* Caller must free string after use */
-static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
+char *riscv_fdt_get_aplic_nodename(hwaddr aplic_addr)
 {
     return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
                            aplic_addr);
@@ -613,7 +612,7 @@ static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
                                  uint32_t aplic_child_phandle,
                                  bool m_mode)
 {
-    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+    g_autofree char *aplic_name = riscv_fdt_get_aplic_nodename(aplic_addr);
     g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
     static const char * const aplic_compat[2] = {
         "qemu,aplic", "riscv,aplic"
@@ -695,14 +694,6 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                          aplic_s_phandle, 0,
                          false);
 
-    if (!props->socket && props->platform_bus_irq) {
-        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
-                                       props->platform_bus->base,
-                                       props->platform_bus->size,
-                                       props->platform_bus_irq);
-    }
-
     aplic_phandles[props->socket] = aplic_s_phandle;
 }
 
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5f485b1c79..3526c80d79 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -192,6 +192,7 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
 {
     int socket, phandle_pos;
     MachineState *ms = MACHINE(s);
+    g_autofree char *aplic_name = NULL;
     uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
     uint32_t xplic_phandles[MAX_NODES];
     g_autofree uint32_t *intc_phandles = NULL;
@@ -251,8 +252,6 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
     aplic_fdt_props.aplic_m = !kvm_enabled()
                               ? &memmap[RVSERVER_APLIC_M] : NULL;
     aplic_fdt_props.aplic_s = &memmap[RVSERVER_APLIC_S];
-    aplic_fdt_props.platform_bus = &memmap[RVSERVER_PLATFORM_BUS];
-    aplic_fdt_props.platform_bus_irq = RVSERVER_PLATFORM_BUS_IRQ;
     aplic_fdt_props.num_harts = ms->smp.cpus;
     aplic_fdt_props.numa_enabled = numa_enabled;
     aplic_fdt_props.irqchip_num_sources = RVSERVER_IRQCHIP_NUM_SOURCES;
@@ -270,6 +269,12 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
                                       xplic_phandles);
     }
 
+    aplic_name = riscv_fdt_get_aplic_nodename(memmap[RVSERVER_APLIC_S].base);
+    platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
+                                   memmap[RVSERVER_PLATFORM_BUS].base,
+                                   memmap[RVSERVER_PLATFORM_BUS].size,
+                                   RVSERVER_PLATFORM_BUS_IRQ);
+
     for (socket = 0; socket < socket_count; socket++) {
         if (socket == 0) {
             *irq_mmio_phandle = xplic_phandles[socket];
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..7ec7596b24 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -290,8 +290,6 @@ static void create_fdt_sockets(RISCVVirtState *s,
     if (s->aia_type != VIRT_AIA_TYPE_NONE) {
         aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
         aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
-        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
-        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
         aplic_props.socket = 0;
         aplic_props.num_harts = ms->smp.cpus;
         aplic_props.numa_enabled = numa_enabled;
@@ -347,6 +345,15 @@ static void create_fdt_sockets(RISCVVirtState *s,
         }
     }
 
+    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
+        g_autofree char *aplic_name =
+            riscv_fdt_get_aplic_nodename(s->memmap[VIRT_APLIC_S].base);
+        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
+                                       s->memmap[VIRT_PLATFORM_BUS].base,
+                                       s->memmap[VIRT_PLATFORM_BUS].size,
+                                       VIRT_PLATFORM_BUS_IRQ);
+    }
+
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index eb9db8278d..b3b14ada0a 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -54,8 +54,6 @@ typedef struct IMSICFdtProps {
 typedef struct APLICFdtProps {
     const MemMapEntry *aplic_m;
     const MemMapEntry *aplic_s;
-    const MemMapEntry *platform_bus;
-    int platform_bus_irq;
     int socket;
     int num_harts;
     bool numa_enabled;
@@ -129,6 +127,7 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
 void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
                                     uint32_t *intc_phandles);
 /* Caller must free the returned string.  */
+char *riscv_fdt_get_aplic_nodename(hwaddr addr);
 char *riscv_fdt_get_uart_nodename(hwaddr addr);
 void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
                            int uart_irq, int aia_type,
-- 
2.53.0


