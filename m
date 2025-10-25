Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94D9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 12:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCdnt-00054C-PC; Sat, 25 Oct 2025 08:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCdnm-00053f-Rt; Sat, 25 Oct 2025 08:55:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCdnk-0005fz-Ub; Sat, 25 Oct 2025 08:55:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1297B597307;
 Sat, 25 Oct 2025 14:55:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id O6JizkaC8B8l; Sat, 25 Oct 2025 14:55:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19967597305; Sat, 25 Oct 2025 14:55:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/pci-host/articia: Add variable for common type cast
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <20251025125512.19967597305@zero.eik.bme.hu>
Date: Sat, 25 Oct 2025 14:55:12 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We need the device casted to OBJECT often enough in realize to store
it in a local variable that also makes function calls more readable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Based-on: <cover.1761346145.git.balaton@eik.bme.hu>

hw/pci-host/articia.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index 761e89bc8f..56fe3b6953 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -174,24 +174,24 @@ static void articia_realize(DeviceState *dev, Error **errp)
 {
     ArticiaState *s = ARTICIA(dev);
     PCIHostState *h = PCI_HOST_BRIDGE(dev);
+    Object *o = OBJECT(dev);
     MemoryRegion *mr;
     PCIDevice *pdev;
 
     bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
-    memory_region_init_io(&s->gpio_reg, OBJECT(s), &articia_gpio_ops, s,
+    memory_region_init_io(&s->gpio_reg, o, &articia_gpio_ops, s,
                           TYPE_ARTICIA, 4);
 
-    memory_region_init(&s->mem, OBJECT(dev), "pci-mem", UINT64_MAX);
-    memory_region_init(&s->io, OBJECT(dev), "pci-io", 0xc00000);
-    memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
+    memory_region_init(&s->mem, o, "pci-mem", UINT64_MAX);
+    memory_region_init(&s->io, o, "pci-io", 0xc00000);
+    memory_region_init_io(&s->reg, o, &articia_reg_ops, s,
                           TYPE_ARTICIA, 0x1000000);
     memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
     mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", &s->mem,
-                             0, PCI_LOW_SIZE);
+    memory_region_init_alias(mr, o, "pci-mem-low", &s->mem, 0, PCI_LOW_SIZE);
     memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
     mr = g_new(MemoryRegion, 1);
-    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", &s->mem,
+    memory_region_init_alias(mr, o, "pci-mem-high", &s->mem,
                              PCI_HIGH_ADDR, PCI_HIGH_SIZE);
     memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);
 
-- 
2.41.3


