Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8135C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsaSd-0006Cf-Tv; Sat, 08 Aug 2026 02:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaSX-0006C2-7H; Sat, 08 Aug 2026 02:23:07 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaSP-00037q-1C; Sat, 08 Aug 2026 02:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sn
 BProiOIxyknSbGfXU/tB7P9GoSoUrXxWizFIPHlXA=; b=GZRzIkqpi8jBLwFOmO
 dhZUMj1CEHwXAjuXyiU9pmiaCCBwUXkQ0mT0T2dXVid0wj/ZuH3wjq6l2ywVGANH
 qd5i0cQiFcmplnSjy9RIT4ymygvik/5HUuF+Vx1l5rfcmbVwz3PXbwGfXwTaapBo
 5kjfevlCaeegepthUdSiVGDYE=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgC3_wsky3Zq2MzjLw--.10202S4;
 Sat, 08 Aug 2026 14:22:36 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v3 2/7] hw/riscv: k230: add gsdma in K230 board
Date: Sat,  8 Aug 2026 14:22:22 +0800
Message-ID: <20260808062227.66961-3-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808062227.66961-1-dingtao0430@163.com>
References: <20260808062227.66961-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgC3_wsky3Zq2MzjLw--.10202S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry3XFW3WryxArW7ZFWfuFg_yoW5KF1xpF
 sxWrZFyrW8GFn3A3WfKrsxurykWa1kuF15Cw43u34rGrW7ArZ8tFsI93WIv348JFZ5A345
 uFy0kaySv3W5Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR573kUUUUU=
X-Originating-IP: [101.204.17.203]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-Qw2dGp2yyxszwAA3r
Received-SPF: pass client-ip=117.135.210.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This commit replaces the unimplemented part of GSDMA in K230. And connect the interrupt to plic.

Update K230.rst.

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/k230.rst |  1 +
 hw/riscv/Kconfig           |  1 +
 hw/riscv/k230.c            | 12 +++++++++---
 include/hw/riscv/k230.h    |  3 +++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..a426a1d776 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
 * Platform-Level Interrupt Controller (PLIC)
 * 2 K230 Watchdog Timer
 * 5 UART
+* System Direct Memory Access (SDMA)
 
 Boot options
 ------------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..d28ac06043 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -162,3 +162,4 @@ config K230
     select SERIAL_MM
     select UNIMP
     select K230_WDT
+    select K230_GSDMA
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..c80bd65694 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -206,6 +207,14 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
 
+    /* Gsdma */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gsdma), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gsdma), 0, memmap[K230_DEV_GSDMA].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -221,9 +230,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                                 memmap[K230_DEV_AI_2D_ENGINE].base,
                                 memmap[K230_DEV_AI_2D_ENGINE].size);
 
-    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
-                                memmap[K230_DEV_GSDMA].size);
-
     create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
                                 memmap[K230_DEV_DMA].size);
 
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..156a386edc 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/dma/k230_gsdma.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,6 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
+    K230GSDMAState gsdma;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -129,6 +131,7 @@ enum {
     K230_UART4_IRQ  = 20,
     K230_WDT0_IRQ   = 107,
     K230_WDT1_IRQ   = 108,
+    K230_GSDMA_IRQ  = 140,
 };
 
 #define K230_UART_COUNT 5
-- 
2.43.0


