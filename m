Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63417C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf2Za-0007tT-8b; Wed, 01 Jul 2026 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.12z04cv3btw88n0=vpz22ppphfu9=9e2hb48lqb2g1v@em1175899.techtravels.org>)
 id 1wf2ZY-0007ss-7H
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:34:20 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.12z04cv3btw88n0=vpz22ppphfu9=9e2hb48lqb2g1v@em1175899.techtravels.org>)
 id 1wf2ZW-00089C-NL
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782941644; h=from :
 subject : to : message-id : date;
 bh=6TyIQGe5nKgG8efVYuK4A2vSVU/zotj9XIBU1Sl9kvk=;
 b=URggQX4M92mSB1GNlX9d7bGDeymWnrNGKcqso2zXstKHjn4JzCpP3ULJGw8L2KfvwI9J0
 nMfqu3ZO4rQuwquQHos8Km4mcnUWhY+HxDu6ZT89Vv/tQZJvXHo87wqDOm36LLRQn/dTV8R
 w+uj2rUV7w8w+8iNculzvrnAEMObX4pM0onAiQbDNDCy/1KdwZgiGFrYGJWYODvXm1VE9df
 OULdoAbJm4VOOFLubgFZBq7rF/rn+aqa/UD89SRnuTugsfpaPyWHaYtlMcoV9pWzEJCSRqt
 V+OSA25c21ieXhSnrRXLFKtoPVWrAlWxxmTotFwhnqcqa1ult3xJpPGWCYuw==
Received: from [10.91.249.253] (helo=antecquad..) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wf2ZF-FnQW0hPscrZ-GnN3; Wed, 01 Jul 2026 21:34:01 +0000
From: Keith Monahan <keith@techtravels.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
Subject: [PATCH v2 1/4] hw/misc/lasi: derive IRR from pending and unmasked
 requests
Date: Wed,  1 Jul 2026 17:33:56 -0400
Message-ID: <20260701213359.1855870-2-keith@techtravels.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701213359.1855870-1-keith@techtravels.org>
References: <20260701213359.1855870-1-keith@techtravels.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aL0uvZj:1175899sBq7-A2oFb
X-smtpcorp-track: 4V0NyJAWXDYc.Tue5cxI5_PbL.hohf3QgT23G
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.12z04cv3btw88n0=vpz22ppphfu9=9e2hb48lqb2g1v@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
2.43.0


