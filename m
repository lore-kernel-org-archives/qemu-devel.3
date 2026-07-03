Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57020C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfjcq-0003y5-Pg; Fri, 03 Jul 2026 15:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfjco-0003xG-HV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:32:35 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfjcn-0000yK-45
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:32:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F86A60051;
 Fri,  3 Jul 2026 19:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67D61F000E9;
 Fri,  3 Jul 2026 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783107151;
 bh=ndds5RZ27bGFNNaxo9hClUTJEIepvJejSx77MsBXgVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=InW7RKtGl7A/UyxA+xwW0+iHfDs4r2zl4wTQ9MIo0lReZ5qHvnYmUzVEYfq77Rwn/
 hHZSvEmGv2TYa9TFUgc6+5upMR6FOFQipLRNSwckmzHfbbfY+kA0OKLeeSNfkOzWj0
 Jc5tcIqJApxQofsEQhzbFZKYosJRNjJ8rY5GN0Km9VOUX1sSRmVl7vskX5p/EW3+4r
 zF8ZrRirC5WkYxYw+8vjQVZkJCp0Dgv4z5n7s4mC41dwLW+7WWINh4cO0aDYlYrJtD
 8DoFcb2g3xD2v9z89EeQRlJ/aTF7glnnXnQX3FG3TlhnyT3QCfVeAG5/CkvsL1nrBk
 VZPGbGvWQIoFQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Keith Monahan <keith@techtravels.org>
Subject: [PATCH 3/4] hw/misc/lasi: derive IRR from pending and unmasked
 requests
Date: Fri,  3 Jul 2026 21:32:23 +0200
Message-ID: <20260703193224.33135-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703193224.33135-1-deller@kernel.org>
References: <20260703193224.33135-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Keith Monahan <keith@techtravels.org>

The LASI interrupt request register (IRR) was latched: set when a source
asserted and then never cleared or re-evaluated against the mask, so a
masked or dropped request stayed set forever. The parisc core I/O
dispatcher reads IRR to find its interrupt source, so the stuck bit was
returned on every later interrupt as an "unexpected core I/O interrupt".
On an installed HP-UX system an unacknowledged i82596 LAN interrupt
latched this way and the flood wedged the boot.

Derive IRR as (pending & unmasked) with IPR tracking each source's level,
matching the hardware and the in-tree parisc gsc/lasi driver.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index e8e1578b75..f0dfd78b4d 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -62,7 +62,15 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
 
     switch (addr) {
     case LASI_IRR:
-        val = s->irr;
+        /*
+         * The interrupt request register reports the interrupts that are both
+         * pending and unmasked, derived live from IPR and IMR rather than
+         * latched, so masking or deasserting a source removes it immediately.
+         * The parisc core I/O interrupt dispatcher reads IRR; a latched bit
+         * that never cleared would be redelivered forever as a phantom
+         * "unexpected" interrupt.
+         */
+        val = s->ipr & s->imr;
         break;
     case LASI_IMR:
         val = s->imr;
@@ -234,13 +242,18 @@ static void lasi_set_irq(void *opaque, int irq, int level)
 
     if (level) {
         s->ipr |= bit;
-        if (bit & s->imr) {
+        if ((bit & s->imr) && (s->icr & ICR_BUS_ERROR_BIT) == 0) {
             uint32_t iar = s->iar;
-            s->irr |= bit;
-            if ((s->icr & ICR_BUS_ERROR_BIT) == 0) {
-                stl_be_phys(&address_space_memory, iar & -32, iar & 31);
-            }
+            stl_be_phys(&address_space_memory, iar & -32, iar & 31);
         }
+    } else {
+        /*
+         * The interrupt sources are level triggered, so a source that drops
+         * its request must clear its pending bit.  Otherwise the bit stays set
+         * in IPR (and hence IRR) and is redelivered as a phantom "unexpected"
+         * core I/O interrupt on every later interrupt.
+         */
+        s->ipr &= ~bit;
     }
 }
 
-- 
2.54.0


