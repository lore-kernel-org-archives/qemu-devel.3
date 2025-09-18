Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3DECAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJiC-0001zj-S8; Thu, 18 Sep 2025 14:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi7-0001tg-Sb; Thu, 18 Sep 2025 14:50:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi4-0003Iu-Sv; Thu, 18 Sep 2025 14:50:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ACC2C56F32D;
 Thu, 18 Sep 2025 20:50:12 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3jaO2hd2aauU; Thu, 18 Sep 2025 20:50:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B473156F30C; Thu, 18 Sep 2025 20:50:10 +0200 (CEST)
Message-ID: <2d0d90d16bb02cb9c0606ca8690cf22d296f982c.1758219840.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1758219840.git.balaton@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 06/14] hw/pci-host/raven: Simplify direct config access
 address decoding
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 18 Sep 2025 20:50:10 +0200 (CEST)
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

Use ctz instead of an open coded version and rename function to better
show what it does.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index a400a22df3..66dab28a29 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -57,16 +57,9 @@ struct PREPPCIState {
 
 #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
 
-static inline uint32_t raven_pci_io_config(hwaddr addr)
+static inline uint32_t raven_idsel_to_addr(hwaddr addr)
 {
-    int i;
-
-    for (i = 0; i < 11; i++) {
-        if ((addr & (1 << (11 + i))) != 0) {
-            break;
-        }
-    }
-    return (addr & 0x7ff) |  (i << 11);
+    return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
 }
 
 static void raven_pci_io_write(void *opaque, hwaddr addr,
@@ -74,7 +67,7 @@ static void raven_pci_io_write(void *opaque, hwaddr addr,
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    pci_data_write(phb->bus, raven_pci_io_config(addr), val, size);
+    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
 }
 
 static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
@@ -82,7 +75,7 @@ static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    return pci_data_read(phb->bus, raven_pci_io_config(addr), size);
+    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
 }
 
 static const MemoryRegionOps raven_pci_io_ops = {
-- 
2.41.3


