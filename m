Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A173C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 02:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb9p7-0007HQ-71; Thu, 23 Jan 2025 21:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tb9p4-0007Ge-UH; Thu, 23 Jan 2025 21:53:30 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tb9p2-0006nP-Lz; Thu, 23 Jan 2025 21:53:30 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AFE0B4E602D;
 Fri, 24 Jan 2025 03:53:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id frBz-yVInoMV; Fri, 24 Jan 2025 03:53:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C47A24E602B; Fri, 24 Jan 2025 03:53:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/usb/hcd-ehci: Fix debug printf format string
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: philmd@linaro.org
Message-Id: <20250124025322.C47A24E602B@zero.eik.bme.hu>
Date: Fri, 24 Jan 2025 03:53:22 +0100 (CET)
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

The variable is uint64_t so needs %ld instead of %d.

Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/usb/hcd-ehci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 6c4c14c895..b090f25365 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2287,7 +2287,8 @@ static void ehci_work_bh(void *opaque)
             ehci_update_frindex(ehci, skipped_uframes);
             ehci->last_run_ns += UFRAME_TIMER_NS * skipped_uframes;
             uframes -= skipped_uframes;
-            DPRINTF("WARNING - EHCI skipped %d uframes\n", skipped_uframes);
+            DPRINTF("WARNING - EHCI skipped %"PRIu64" uframes\n",
+                    skipped_uframes);
         }
 
         for (i = 0; i < uframes; i++) {
-- 
2.30.9


