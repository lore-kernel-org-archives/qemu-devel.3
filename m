Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7BEEF06FB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 00:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpEzG-0006Gn-HT; Sun, 08 Feb 2026 19:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpEzE-0006GZ-Pa
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 19:18:44 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpEzC-0003Kv-Cz
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 19:18:44 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B2755969F3;
 Mon, 09 Feb 2026 01:18:38 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7ertLS5_A7qM; Mon,  9 Feb 2026 01:18:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5413F5969F2; Mon, 09 Feb 2026 01:18:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Peter Maydell <"peter.maydell@linaro.org>, philmd"@linaro.org>
Message-Id: <20260209001836.5413F5969F2@zero.eik.bme.hu>
Date: Mon, 09 Feb 2026 01:18:36 +0100 (CET)
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

According to specification 6.5.6 FrameNumberOverflow Event when bit 15
of frame count changes (either from 1 to 0 or 0 to 1) a
FrameNumberOverflow interrupt should be generated.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/usb/hcd-ohci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c7e9c71903..f8da16bc8f 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1246,6 +1246,9 @@ static void ohci_frame_boundary(void *opaque)
     hcca.frame = cpu_to_le16(ohci->frame_number);
     /* When the HC updates frame number, set pad to 0. Ref OHCI Spec 4.4.1*/
     hcca.pad = 0;
+    if (ohci->frame_number == 0x8000 || ohci->frame_number == 0) {
+        ohci_set_interrupt(ohci, OHCI_INTR_FNO);
+    }
 
     if (ohci->done_count == 0 && !(ohci->intr_status & OHCI_INTR_WD)) {
         if (!ohci->done) {
-- 
2.41.3


