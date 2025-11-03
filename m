Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68801CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtrW-0002VF-3y; Mon, 03 Nov 2025 07:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vFtrJ-0002S0-6J; Mon, 03 Nov 2025 07:40:29 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <chao.liu.riscv@isrc.iscas.ac.cn>)
 id 1vFtr8-0000o6-Ds; Mon, 03 Nov 2025 07:40:27 -0500
Received: from ZEVORN-PC (unknown [114.88.97.170])
 by APP-03 (Coremail) with SMTP id rQCowADHQemhoghphSM7AQ--.13961S3;
 Mon, 03 Nov 2025 20:40:02 +0800 (CST)
From: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
To: dbarboza@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
Subject: [RFC v1 1/1] hw/riscv/server_platform_ref.c: add virtio bus
Date: Mon,  3 Nov 2025 20:39:55 +0800
Message-ID: <38a180e7ed4014ba7d401dc9b8de755fadf33bea.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
References: <cover.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHQemhoghphSM7AQ--.13961S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDGF4ktF1fCrWktF4fKrg_yoW5Kw4kpr
 4UCa1Fgw4kWF1ayrZ3ur15Cw45Cws7CFW5C34SgFs2kF1DWF1DJ3yDGa48GFyxJr15X3WY
 kFZ8uryfKa429w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjX18JUUUUU==
X-Originating-IP: [114.88.97.170]
X-CM-SenderInfo: pfkd0hholxh2hlvf4qplvuuh5lvft2wodfhubq/1tbiDAUPAGkIkuwp7AABsd
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=chao.liu.riscv@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an always present virtio bus for the rvsp-ref board.

The IRQs being used are similar to what the 'virt' board is using: IRQs
40 to 47, one IRQ for queue.

Signed-off-by: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
---
 hw/riscv/server_platform_ref.c | 42 ++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 975f07ddfb..24c3fc2e41 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -46,6 +46,7 @@
 #include "target/riscv/cpu.h"
 #include "target/riscv/pmu.h"
 #include "net/net.h"
+#include "hw/virtio/virtio-mmio.h"
 
 #define RVSP_CPUS_MAX_BITS             9
 #define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
@@ -108,16 +109,20 @@ enum {
     RVSP_PCIE_MMIO,
     RVSP_PCIE_PIO,
     RVSP_PCIE_ECAM,
-    RVSP_PCIE_MMIO_HIGH
+    RVSP_PCIE_MMIO_HIGH,
+    RVSP_VIRTIO
 };
 
 enum {
     RVSP_UART0_IRQ = 10,
     RVSP_RTC_IRQ = 11,
     RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
-    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
+    IOMMU_SYS_IRQ = 0x24, /* 36 to 39 */
+    RVSP_VIRTIO_IRQ = 0x28 /* 40 to 47 */
 };
 
+#define RVSP_VIRTIO_COUNT 8
+
 /*
  * The server soc reference machine physical address space used by some of the
  * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
@@ -151,6 +156,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
     [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
     [RVSP_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
     [RVSP_UART0] =          { 0x10000000,         0x100 },
+    [RVSP_VIRTIO] =         { 0x10001000,        0x1000 },
     [RVSP_FLASH] =          { 0x20000000,     0x4000000 },
     [RVSP_IMSIC_M] =        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
     [RVSP_IMSIC_S] =        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
@@ -816,6 +822,29 @@ static void create_fdt_flash(RVSPMachineState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
 }
 
+static void create_fdt_virtio(RVSPMachineState *s, uint32_t irq_virtio_phandle)
+{
+    int i;
+    MachineState *ms = MACHINE(s);
+    hwaddr virtio_base = rvsp_ref_memmap[RVSP_VIRTIO].base;
+
+    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
+        g_autofree char *name = NULL;
+        uint64_t size = rvsp_ref_memmap[RVSP_VIRTIO].size;
+        hwaddr addr = virtio_base + i * size;
+
+        name = g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
+
+        qemu_fdt_add_subnode(ms->fdt, name);
+        qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
+        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
+            irq_virtio_phandle);
+        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
+                            RVSP_VIRTIO_IRQ + i, 0x4);
+    }
+}
+
 static void finalize_fdt(RVSPMachineState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -835,6 +864,8 @@ static void finalize_fdt(RVSPMachineState *s)
     create_fdt_uart(s, rvsp_ref_memmap, irq_mmio_phandle);
 
     create_fdt_rtc(s, rvsp_ref_memmap, irq_mmio_phandle);
+
+    create_fdt_virtio(s, irq_mmio_phandle);
 }
 
 static void create_fdt(RVSPMachineState *s, const MemMapEntry *memmap)
@@ -1205,6 +1236,13 @@ static void rvsp_ref_machine_init(MachineState *machine)
         }
     }
 
+    /* VirtIO MMIO devices */
+    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
+        sysbus_create_simple("virtio-mmio",
+            memmap[RVSP_VIRTIO].base + i * memmap[RVSP_VIRTIO].size,
+            qdev_get_gpio_in(mmio_irqchip, RVSP_VIRTIO_IRQ + i));
+    }
+
     s->memmap = rvsp_ref_memmap;
 
     /* register system main memory (actual RAM) */
-- 
2.51.0


