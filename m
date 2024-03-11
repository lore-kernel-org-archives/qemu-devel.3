Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2ADC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 06:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjZOn-0003rc-W9; Mon, 11 Mar 2024 02:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjZOG-0003nE-Lz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 02:44:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjZO7-0000qp-BG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 02:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A8QX9v10FACgPccHhMrGRm3x9vZG8mtPh75idLSNa/c=; b=aNh+6PI6uDSLBPfg2eO0vbCne4
 HiQKDeD05Dq11ZySiFXkg4vLani0OsAwqX5JqcDJSQ+nsPYydhNzWp2J7OW+B0Ox7wOIL7leX0kR5
 /KluNz9G9yEVCoSTaCcba/FTNWWdZiENErI6e1MWELSsuEXMTOYsxV8qkfKskvZAnNGbpxdV3P8Yq
 kRLaQrmNu+lab4AOUFOVsSu6X3aTqa7jnh6tckwZnxyS/OdZV7DUke9wiZBVPgb00gHhzOPHAmNvE
 dgLr0ejLA0AaICZGGAS4yjKVdrgveUTlWfXAv2I5L0bCvGYdyHbGTD1vZS0q10gqjaWTu78YwC379
 JhKyV/8DWXF5m9REIuWLP8wu9d8pMPfS+bR4hJkYGJ27lGofbEHeXr6+2AKoRe3a5K7kjQkSmG4IL
 cG0zdr084zbxMesgTbSBQb5qk7u+LnOHaEZVLHHDECbtNX7eEHcanJMoDXKVAPdJT2JTLzNxW98yp
 4GB5FlzpS2bS7cvoKHII7HqMCFqszrQmuWpAg/012SKEAtecKrGpzqQWFf8Qx9njEo8yWLz3v2/si
 +0nUQ1kg4T0SeemywUheqFbN/D57ewcscVgURNX9HbmWnOBpphvpBPGNPAbiIhUV3WnWffuzCzLTX
 dZ7exs0xJBybJG4+rsjZ6cFaFXG22i9/AcEfRwlmM=;
Received: from [2a00:23c4:8bb3:800:fe57:b8b5:ee67:e0c6]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjZNF-0003K7-8I
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:43:05 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Mon, 11 Mar 2024 06:43:45 +0000
Message-Id: <20240311064345.2531197-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:800:fe57:b8b5:ee67:e0c6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] sun4u: remap ebus BAR0 to use unassigned_io_ops instead of
 alias to PCI IO space
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

During kernel startup OpenBSD accesses addresses mapped by BAR0 of the ebus device
but at offsets where no IO devices exist. Before commit 4aa07e8649 ("hw/sparc64/ebus:
Access memory regions via pci_address_space_io()") BAR0 was mapped to legacy IO
space which allows accesses to unmapped devices to succeed, but afterwards these
accesses to unmapped PCI IO space cause a memory fault which prevents OpenBSD from
booting.

Since no devices are mapped at the addresses accessed by OpenBSD, change ebus BAR0
from a PCI IO space alias to an IO memory region using unassigned_io_ops which allows
these accesses to succeed and so allows OpenBSD to boot once again.

Fixes: 4aa07e8649 ("hw/sparc64/ebus: Access memory regions via pci_address_space_io()")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---

[MCA: I'd like to merge this for 9.0 since I've been carrying various local workarounds
to allow OpenBSD to boot on SPARC64 for some time.]

 hw/sparc64/sun4u.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index eda9b58a21..cff6d5abaf 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -360,8 +360,13 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     pci_dev->config[0x09] = 0x00; // programming i/f
     pci_dev->config[0x0D] = 0x0a; // latency_timer
 
-    memory_region_init_alias(&s->bar0, OBJECT(s), "bar0",
-                             pci_address_space_io(pci_dev), 0, 0x1000000);
+    /*
+     * BAR0 is accessed by OpenBSD but not for ebus device access: allow any
+     * memory access to this region to succeed which allows the OpenBSD kernel
+     * to boot.
+     */
+    memory_region_init_io(&s->bar0, OBJECT(s), &unassigned_io_ops, s,
+                          "bar0", 0x1000000);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
     memory_region_init_alias(&s->bar1, OBJECT(s), "bar1",
                              pci_address_space_io(pci_dev), 0, 0x8000);
-- 
2.39.2


