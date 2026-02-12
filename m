Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE38CEEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbpp-0004kh-55; Thu, 12 Feb 2026 13:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqbpi-0004ZR-5M
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:54:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqbpf-0004Et-Hr
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:54:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C8AC596ADA;
 Thu, 12 Feb 2026 19:54:27 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 5OD8RZ5i--jT; Thu, 12 Feb 2026 19:54:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2F854596A29; Thu, 12 Feb 2026 19:54:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/usb/hcd-ohci: Implement frame number overflow event
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org
Message-Id: <20260212185425.2F854596A29@zero.eik.bme.hu>
Date: Thu, 12 Feb 2026 19:54:25 +0100 (CET)
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
FrameNumberOverflow interrupt should be generated. This fixes
usb-audio on mac99,via=pmu with MacOS 9.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3274
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Elisey Konstantinov <elisey.konstantinov@gmail.com>
---
v2:
- updated commit message
- added Tested-by and Resolves tags

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


