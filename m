Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90062C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljaF-0007Mo-8z; Mon, 20 Jul 2026 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wlihZ-0001fU-Q4; Mon, 20 Jul 2026 03:46:15 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wlihV-0005SM-Ni; Mon, 20 Jul 2026 03:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y1
 jQMVk9TahKN21Ldn0+n3Bokdv6OYqjHlvBWg/BhWA=; b=ojzyV3isjhW//OE2dZ
 Fn+YBp0kigyEn8n+gQQ0lQcBXpzptG0ZYJAhbHntqIc4+JtkaMjBfgQmbwTO3462
 Q6bh6LEAmk2+FQSGiJEiEbrIUyuf4/2pNxbFTAzv9hGbc5ev6Amzn54Vabsx3JuN
 2Ch3nV7rfMHamzY4o+QTA1gnU=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3sFop0l1qwlRuKw--.5096S4; 
 Mon, 20 Jul 2026 15:45:47 +0800 (CST)
From: Jian Cai <lingqian_gi@163.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: [RFC PATCH 2/3] hw/riscv/k230: integrate SRAM device into SoC
Date: Mon, 20 Jul 2026 15:45:44 +0800
Message-ID: <20260720074545.8987-3-lingqian_gi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720074545.8987-1-lingqian_gi@163.com>
References: <20260720074545.8987-1-lingqian_gi@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3sFop0l1qwlRuKw--.5096S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF15Cw4xGFW3CF13tFy5Jwb_yoWrCr1fpF
 13GrsxCryrGFs7Zws3tFZ7GFykXan7Wr1UCwn5u3s5Ar47ArWDtrsIqa1jvFyUJFsYk3Wr
 CF95Kr1rCw4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jED7-UUUUU=
X-Originating-IP: [42.193.175.155]
X-CM-SenderInfo: 5olqw15ldqswrl6rljoofrz/xtbC6Quwpmpd0isScAAA3Y
Received-SPF: pass client-ip=117.135.210.3; envelope-from=lingqian_gi@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2026 04:42:40 -0400
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

Replace the bare memory_region_init_ram() in k230_soc_realize()
with a proper SysBusDevice.  Wire up object_initialize_child()
in k230_soc_init(), call sysbus_realize() and sysbus_mmio_map()
in k230_soc_realize(), and add the Kconfig + meson.build entries.

Update docs/system/riscv/k230.rst.

Signed-off-by: Jian Cai <lingqian_gi@163.com>
---
 docs/system/riscv/k230.rst | 8 ++++++++
 hw/riscv/Kconfig           | 4 ++++
 hw/riscv/k230.c            | 9 +++++----
 hw/riscv/meson.build       | 1 +
 include/hw/riscv/k230.h    | 3 ++-
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..a7668fa065 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -111,3 +111,11 @@ this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
 with the host-calculated value above when typing the command. ``cma=0`` avoids
 the SDK kernel reserving too much of the little-core memory window for initramfs
 boot.
+
+SRAM
+~~~~
+
+The K230 shared SRAM is a 2 MB on-chip RAM block at ``0x80200000``.  It has no
+software-visible controller registers -- the region is accessed directly via the
+AXI bus.  Clock gating and reset control are handled by separate
+system-controller peripherals (CMU and RMU).
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..ee48ea530d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -142,6 +142,9 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_IMSIC
     select SERIAL_MM
 
+config K230_SRAM
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
@@ -161,4 +164,5 @@ config K230
     select RISCV_IMSIC
     select SERIAL_MM
     select UNIMP
+    select K230_SRAM
     select K230_WDT
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..3469a9d43b 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
     object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
     object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-sram", &s->sram, TYPE_K230_SRAM);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -162,10 +163,10 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     c908_cpus = s->c908_cpu.num_harts;
 
     /* SRAM */
-    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
-                           memmap[K230_DEV_SRAM].size, &error_fatal);
-    memory_region_add_subregion(sys_mem, memmap[K230_DEV_SRAM].base,
-                                &s->sram);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sram), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sram), 0, memmap[K230_DEV_SRAM].base);
 
     /* BootROM */
     memory_region_init_rom(&s->bootrom, OBJECT(dev), "bootrom",
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 0d82ceacc4..80b7455141 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -20,5 +20,6 @@ riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
+riscv_ss.add(when: 'CONFIG_K230_SRAM', if_true: files('k230_sram.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 592e1c26bf..9f7baa513c 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -18,6 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/watchdog/k230_wdt.h"
+#include "hw/riscv/k230_sram.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -33,7 +34,7 @@ typedef struct K230SoCState {
     RISCVHartArrayState c908_cpu; /* Small core */
 
     K230WdtState wdt[2];
-    MemoryRegion sram;
+    K230SramState sram;
     MemoryRegion bootrom;
 
     DeviceState *c908_plic;
-- 
2.43.0


