Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F2FEDA1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aSU-00047j-ND; Tue, 17 Mar 2026 15:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSP-00046h-SI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:52:01 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSO-0006Ry-BL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:52:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 21DB14344B;
 Tue, 17 Mar 2026 19:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71F9C2BC86;
 Tue, 17 Mar 2026 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773777119;
 bh=qlaKiCfcpSKDnowV6qpRhjS+FT9ostpJw51ppO7x92k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=InvXtfMqstfwCaFkWFE2RfuOc0CeIrJHW36yG5LcQzjI1yFta4nuybHOrU1FYKi/m
 Y5AKmodcY4J81qT1OzKmR6sTVIiHJvN6Y7KWRkkNusM65OFzCwh0fl2+kyXw0fxFrd
 BMN5gcWwFUNsajRh3/Wzd98VlxRR28tdySvCzRznM2ZN9c95F05WWOH7OvnIFBMq4R
 cuUTy+R3nF8fYWaR3BDk+T6+EsJwR85/WMCACx8W7ZpHMHb7R1wYQV+Th3PiZrLEQ9
 F8oZHGzx/2bR5pw0isx4XrPtoo/e23E85p3URieJHvvX0DkJ0RZKrdxDjo1RRQScZH
 zey8PqJ1FHNbQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 4/6] hw/pci-host/astro: Use proper region names
Date: Tue, 17 Mar 2026 20:51:47 +0100
Message-ID: <20260317195149.8386-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317195149.8386-1-deller@kernel.org>
References: <20260317195149.8386-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

All 64-bit hppa machines have at least 4 Elroy PCI busses in the system.
Make sure to use proper names in the qemu device tree, e.g. "elroy0" or
"elroy2-pci-mmio", to be able to distinguish between the various chips.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 626aa9ce22..2c97d400bf 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -433,7 +433,7 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
 
     /* Elroy config access from CPU.  */
     memory_region_init_io(&s->this_mem, obj, &elroy_chip_ops,
-                          s, "elroy", 0x2000);
+                          s, dev->id, 0x2000);
 
     /* Elroy PCI config. */
     memory_region_init_io(&phb->conf_mem, obj,
@@ -448,7 +448,9 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
                                 &phb->data_mem);
 
     /* Elroy PCI bus memory.  */
-    memory_region_init(&s->pci_mmio, obj, "pci-mmio", UINT64_MAX);
+    g_autofree char *elroy_mmio_name;
+    elroy_mmio_name = g_strdup_printf("%s-pci-mmio", dev->id);
+    memory_region_init(&s->pci_mmio, obj, elroy_mmio_name, UINT64_MAX);
     memory_region_init_io(&s->pci_io, obj, &unassigned_io_ops, obj,
                             "pci-isa-mmio",
                             ((uint32_t) IOS_DIST_BASE_SIZE) / ROPES_PER_IOC);
-- 
2.53.0


