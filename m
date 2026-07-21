Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1902C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm3f7-00037t-6a; Tue, 21 Jul 2026 02:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wm3f5-00037V-5a; Tue, 21 Jul 2026 02:09:03 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wm3ey-00012C-9r; Tue, 21 Jul 2026 02:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=NbRFyAIXD5fwnPyAV8Vs+ddMpdavc8dlEgAhyETj7lc=;
 b=CZLO2LjdqT8vAtiUOExaLNhHVcF+jbj9qga5jL4QMxrbFrWR9Zz/f2PDltyZes
 JuHUZtGploDg9YO7AyLVnMT89CDbg9RVUwgVYVRSQPo8h/5fpDzsuz82Kh+94tKE
 3QMglJ5FdHfffoEy1984CyzfZRRprhpWQ3cQXzka0kNQ0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3v8vlDF9qWYX7KA--.47423S2; 
 Tue, 21 Jul 2026 14:08:37 +0800 (CST)
From: Jian Cai <lingqian_gi@163.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, Jian Cai <lingqian_gi@163.com>
Subject: [PATCH v2] hw/riscv/k230: add k230_sram_create() helper function
Date: Tue, 21 Jul 2026 14:04:07 +0800
Message-ID: <20260721060409.9688-2-lingqian_gi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720074545.8987-2-lingqian_gi@163.com>
References: <20260720074545.8987-2-lingqian_gi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v8vlDF9qWYX7KA--.47423S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4rWryrXF48GFWxuryUKFg_yoW5KF1DpF
 s7Gr929rn7GFyDZFs3tF1rXFyvqa1vgr1UWwn7u34kGr47Jryqyr4rJ3W0v3W7WrWxAw1U
 uFyYqF1ru3W8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnSdkUUUUU=
X-Originating-IP: [42.193.175.155]
X-CM-SenderInfo: 5olqw15ldqswrl6rljoofrz/xtbCwQeupGpfDOc5UgAA35
Received-SPF: pass client-ip=220.197.31.5; envelope-from=lingqian_gi@163.com;
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

The K230 shared SRAM (2 MB at 0x80200000) has no software-visible
controller registers: it is a pure on-chip RAM block accessed via
the AXI bus.  Replace the inline memory_region_init_ram calls in
k230_soc_realize() with a static k230_sram_create() helper, which
follows the same pattern as the existing k230_create_plic() and
k230_create_uart() helpers.

Also fix two non-ASCII characters (registered sign and em-dash)
in k230.rst that would cause git send-email to reject the patch
as 8-bit.

Reference:
K230 TRM V0.3.1 (2024-11-18), Section 5.2 Sram
https://github.com/revyos/external-docs/blob/master/K230/en-us/
K230_Technical_Reference_Manual_V0.3.1_20241118.pdf

Signed-off-by: Jian Cai <lingqian_gi@163.com>
---

Changes in v2:
- Dropped SysBusDevice model per Chao Liu's review; use a static helper
  function k230_sram_create() in k230.c instead.
- Removed k230_sram.c, k230_sram.h, and k230-sram-test.c.
- Fixed two non-ASCII characters (registered sign, em-dash) in k230.rst.
- Removed SRAM entries from MAINTAINERS (no new files added).
- v1: [RFC PATCH 0/3] hw/riscv: add K230 SRAM device model
  https://lore.kernel.org/qemu-devel/

 docs/system/riscv/k230.rst |  3 ++-
 hw/riscv/k230.c            | 14 ++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
index cea8202e55..18eb6806f6 100644
--- a/docs/system/riscv/k230.rst
+++ b/docs/system/riscv/k230.rst
@@ -2,7 +2,7 @@ Kendryte K230 virt reference platform (``k230``)
 ==========================================================================
 The ``k230`` machine is compatible with the Kendryte K230 SDK.
 
-The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+The K230 is a chip from the AIoT SoC series made by Kendryte (R) -- a part of
 Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
 structure.
 
@@ -111,3 +111,4 @@ this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
 with the host-calculated value above when typing the command. ``cma=0`` avoids
 the SDK kernel reserving too much of the little-core memory window for initramfs
 boot.
+
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 656f28190c..96add64c2a 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu-qom.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -151,6 +152,14 @@ static void k230_create_uart(MemoryRegion *sys_mem, DeviceState *plic,
                    399193, serial_hd(index), DEVICE_LITTLE_ENDIAN);
 }
 
+static void k230_sram_create(K230SoCState *s)
+{
+    memory_region_init_ram(&s->sram, OBJECT(s), "k230.sram",
+                           memmap[K230_DEV_SRAM].size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                memmap[K230_DEV_SRAM].base, &s->sram);
+}
+
 static void k230_soc_realize(DeviceState *dev, Error **errp)
 {
     K230SoCState *s = RISCV_K230_SOC(dev);
@@ -162,10 +171,7 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     c908_cpus = s->c908_cpu.num_harts;
 
     /* SRAM */
-    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
-                           memmap[K230_DEV_SRAM].size, &error_fatal);
-    memory_region_add_subregion(sys_mem, memmap[K230_DEV_SRAM].base,
-                                &s->sram);
+    k230_sram_create(s);
 
     /* BootROM */
     memory_region_init_rom(&s->bootrom, OBJECT(dev), "bootrom",
-- 
2.43.0


