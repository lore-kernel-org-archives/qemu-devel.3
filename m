Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C27DC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8zyP-0003fQ-8O; Mon, 20 May 2024 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s8zyK-0003eU-9q; Mon, 20 May 2024 06:10:24 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s8zyA-0002OD-Fm; Mon, 20 May 2024 06:10:24 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C7634E6000;
 Mon, 20 May 2024 12:10:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ujGJWZknsGZ9; Mon, 20 May 2024 12:10:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A25A34E602E; Mon, 20 May 2024 12:10:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] macio: Add unimp region for debugging
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240520101007.A25A34E602E@zero.eik.bme.hu>
Date: Mon, 20 May 2024 12:10:07 +0200 (CEST)
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

The macio device has a container mmio region that embeds several other
devices. Some of these devices are not implemented but because of the
container region, the unassigned memory traces don't catch accesses to
these. To help debugging, add an unimplemented-device covering the
container region to get logs when the guest accesses unassigned areas.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Here's a patch that should help getting logs for unimplemented registers
in macio with -d unimp which may help finding out where the writes go and
what needs to be implemented.

 hw/misc/Kconfig       | 1 +
 hw/misc/macio/macio.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b83..4197a786d6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -66,6 +66,7 @@ config MACIO
     select MAC_DBDMA
     select MAC_NVRAM
     select MOS6522
+    select UNIMP
 
 config IVSHMEM_DEVICE
     bool
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 3f449f91c0..43b683c294 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -34,6 +34,7 @@
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/intc/heathrow_pic.h"
+#include "hw/misc/unimp.h"
 #include "trace.h"
 
 #define ESCC_CLOCK 3686400
@@ -94,6 +95,14 @@ static bool macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     SysBusDevice *sbd;
+    DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+
+    qdev_prop_set_string(dev, "name", "macio-unimp");
+    qdev_prop_set_uint64(dev, "size", memory_region_size(&s->bar));
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion_overlap(&s->bar, 0,
+                                        sysbus_mmio_get_region(sbd, 0), -1000);
 
     if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), errp)) {
         return false;
-- 
2.30.9


