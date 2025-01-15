Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F90C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8gw-0005uE-1H; Wed, 15 Jan 2025 14:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tY8gp-0005BJ-MC; Wed, 15 Jan 2025 14:04:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tY8gm-0006Ej-Ug; Wed, 15 Jan 2025 14:04:31 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B0F44E602F;
 Wed, 15 Jan 2025 20:04:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id QSkx0wUDXyib; Wed, 15 Jan 2025 20:04:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5F0FA4E6030; Wed, 15 Jan 2025 20:04:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/sd/sdhci: Set reset value of interrupt registers
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
    philmd@linaro.org
Message-Id: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
Date: Wed, 15 Jan 2025 20:04:22 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The interrupt enable registers are not reset to 0 but some bits are
enabled on reset. At least some U-Boot versions seem to expect this
and not initialise these registers before expecting interrupts. The
numbers in this patch match what QorIQ P1022 has on reset and fix
U-Boot for this SoC and should not break other drivers that initialise
(and thus overwrite) these reset values.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
I've also noticed that the work around marked with an XXX comment near
line 600 breaks the U-Boot I've tested so I need to disable it:
if ((s->sdmasysad % boundary_chk) == 0) {
-        page_aligned = true;
+//        page_aligned = true;
}
What should this hack fix and could it be now removed or somehow
restricted to cases where it's needed?

hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 58375483e3..88eb0bfcb2 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -303,6 +303,8 @@ static void sdhci_reset(SDHCIState *s)
     s->data_count = 0;
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
+    s->norintstsen = 0x013f;
+    s->errintstsen = 0x117f;
 }
 
 static void sdhci_poweron_reset(DeviceState *dev)
-- 
2.30.9


