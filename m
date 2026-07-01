Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25986C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welT3-0007SD-6q; Tue, 30 Jun 2026 23:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.cgq0mqo81tzk5f6=hvoa3jab30xi=sfhleq1hr8x0uv@em1175899.techtravels.org>)
 id 1welT1-0007RS-Kx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:18:27 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.cgq0mqo81tzk5f6=hvoa3jab30xi=sfhleq1hr8x0uv@em1175899.techtravels.org>)
 id 1welT0-0007cR-4M
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782875895; h=from :
 subject : to : message-id : date;
 bh=B2l5PYmVBfozlaitEBYUvK6EFCgTEeIkFxlFelerabk=;
 b=G8iKuOqeWkMxOzAIAz1ZjO4cyJONusNBHNuII32Tefw1WIB7KdsE5V+DsFFbcg0Xyc4/Y
 6Ev9x/HfUMXbvSitQStYgqplRBJfTl2ZzEq+Q+8mTNHSWUgLYQoUrV8ds11vDz8iCIZsh6W
 2AFmbov3qrY5GX7+LCK29rRHHKQoCpBnPKTXQklTytUQL8PjH5HgAdeHZjht7zkZTH9ur9Q
 AE+N3RvCdX+ccTOuEdgHvXWsukpfs4lZpAFhksVYY2d215mfFY3jijqLkjXzN08dLj0ebbi
 13QXBSgZakYFQ8WTJlQO4VWVRl2VoF5hoQ+uoWwDKQwQ74ksRHoqH7SXjLAw==
Received: from [10.91.249.253] (helo=antecquad..) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1welSi-AIkwcC8jwR2-2r5p; Wed, 01 Jul 2026 03:18:09 +0000
From: Keith Monahan <keith@techtravels.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH 1/2] hw/misc/lasi: derive IRR from pending and unmasked sources
Date: Tue, 30 Jun 2026 23:18:02 -0400
Message-ID: <20260701031803.1817812-2-keith@techtravels.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701031803.1817812-1-keith@techtravels.org>
References: <20260701031803.1817812-1-keith@techtravels.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aL0uvZj:1175899shdmUDFNyw
X-smtpcorp-track: ie1Y8xBJfWFz.z6XjR01ERUJJ.u9LFSwFZCYu
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.cgq0mqo81tzk5f6=hvoa3jab30xi=sfhleq1hr8x0uv@em1175899.techtravels.org;
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

The LASI interrupt controller request register (IRR) was latched: a bit
was set when a source asserted and then neither cleared nor re-evaluated
against the mask, so a request the guest masked, or that a level source
dropped, stayed set forever.  The parisc core I/O dispatcher reads IRR
(not IPR) to find its source and relies on a request clearing once the
device deasserts or is masked, so a stuck bit is redelivered on every
later interrupt as an "unexpected core I/O interrupt".

On an installed HP-UX 10.20 system the i82596 LAN raises an interrupt no
loaded driver acknowledges; the held request latched into IRR, masking
it had no effect, and the flood wedged the boot before it reached
multiuser.

Derive IRR as (pending and unmasked) and track the level of each source
in IPR (cleared when it deasserts), matching the hardware and the in tree
parisc gsc/lasi driver.

Signed-off-by: Keith Monahan <keith@techtravels.org>
---
 hw/misc/lasi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index e8e1578b75..fb7bd9f18a 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -62,7 +62,17 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
 
     switch (addr) {
     case LASI_IRR:
-        val = s->irr;
+        /*
+         * The interrupt request register reports the interrupts that are both
+         * pending and unmasked.  It is derived live from IPR and IMR rather
+         * than latched: masking a source must remove it from IRR immediately,
+         * and a source that is masked or no longer asserted must stop being
+         * reported.  The parisc core I/O interrupt dispatcher reads IRR and
+         * relies on a request clearing once the device deasserts or is masked;
+         * a latched bit that never cleared would be redelivered forever as a
+         * phantom "unexpected" interrupt.
+         */
+        val = s->ipr & s->imr;
         break;
     case LASI_IMR:
         val = s->imr;
@@ -234,13 +244,18 @@ static void lasi_set_irq(void *opaque, int irq, int level)
 
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


