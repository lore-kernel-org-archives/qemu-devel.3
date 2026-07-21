Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD097C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDA9-0006R0-7m; Tue, 21 Jul 2026 12:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmDA5-0006QX-8S; Tue, 21 Jul 2026 12:17:41 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmDA3-0007PG-By; Tue, 21 Jul 2026 12:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=NE
 igvj1AtoZ75hcw0yHz0h53SARdssi8MLVvDj4Y+UU=; b=kdaHXxuY80PcqWkJed
 6PNPUdxMNECpe2F3CPCBIPZXZ5GrgyBsUdCdQ75LdvwN5eL4IGDzEgVZCOnM+pSt
 Nm2YkUek7MpKhVkiHPTCBsMOhADt40RaMLnn/aWcmk2UX2mGOX5h4dR5N3raMJNm
 L8IjAWq5tI85WTZytKzRKxdVE=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3F6+wml9qkr5qKg--.58375S7; 
 Wed, 22 Jul 2026 00:13:41 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 5/7] hw/riscv: k230: add decomp gzip in K230 board
Date: Wed, 22 Jul 2026 00:13:33 +0800
Message-ID: <20260721161335.73872-6-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721161335.73872-1-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3F6+wml9qkr5qKg--.58375S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWfWw4kKF43AFy8KFWfZrb_yoW5urWrpF
 sxGr4qyrWxWFyfAa1ftrs7Gryjg3ykKFy3Gw1Sv34rKrWUArZ8tFsIya1Svr18JFWDJa45
 uFy8ta1S9w17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELZ2hUUUUU=
X-Originating-IP: [101.204.18.42]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-hVGhGpfmrVllgAA3A
Received-SPF: pass client-ip=220.197.31.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This commit replaces the unimplemented part of Decomp_gzip in K230.
Connect to the handshake interface of GSDMA.

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/k230.c         | 23 +++++++++++++++++++----
 include/hw/riscv/k230.h |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d28ac06043..d06ac26648 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -163,3 +163,4 @@ config K230
     select UNIMP
     select K230_WDT
     select K230_GSDMA
+    select K230_DECOMP_GZIP
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index c80bd65694..7fd1ec4c25 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -111,6 +111,8 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-gsdma", &s->gsdma, TYPE_K230_GSDMA);
+    object_initialize_child(obj, "k230-decomp-gzip", &s->decomp_gzip,
+                            TYPE_K230_DECOMP_GZIP);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -215,6 +217,23 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gsdma), 0,
                        qdev_get_gpio_in(DEVICE(s->c908_plic), K230_GSDMA_IRQ));
 
+    /* Decomp gzip */
+    qdev_prop_set_uint64(DEVICE(&s->decomp_gzip), "sram-base",
+                         memmap[K230_DEV_SRAM].base);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->decomp_gzip), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->decomp_gzip), 0,
+                    memmap[K230_DEV_DECOMP_GZIP].base);
+    for (int i = 0; i < K230_DECOMP_GZIP_NUM_GPIOS_OUT; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->decomp_gzip), i,
+                              qdev_get_gpio_in(DEVICE(&s->gsdma), i));
+    }
+    for (int i = 0; i < K230_DECOMP_GZIP_NUM_GPIOS_IN; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->gsdma), i,
+                              qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
+    }
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
@@ -233,10 +252,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
                                 memmap[K230_DEV_DMA].size);
 
-    create_unimplemented_device("decomp-gzip",
-                                memmap[K230_DEV_DECOMP_GZIP].base,
-                                memmap[K230_DEV_DECOMP_GZIP].size);
-
     create_unimplemented_device("2d-engine.non-ai",
                                 memmap[K230_DEV_NON_AI_2D].base,
                                 memmap[K230_DEV_NON_AI_2D].size);
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 156a386edc..a12d36965a 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -19,6 +19,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
 #include "hw/dma/k230_gsdma.h"
+#include "hw/misc/k230_decomp_gzip.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -35,6 +36,7 @@ typedef struct K230SoCState {
 
     K230WdtState wdt[2];
     K230GSDMAState gsdma;
+    K230DecompGzipState decomp_gzip;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
-- 
2.43.0


