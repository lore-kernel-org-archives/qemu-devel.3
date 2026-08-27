Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A294C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcQE-0004bD-EO; Thu, 27 Aug 2026 11:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQB-0004Zt-3f; Thu, 27 Aug 2026 11:53:43 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQ9-0003sh-Dz; Thu, 27 Aug 2026 11:53:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=twPK/ED
 A7u8HERdHlUJSuIPBYaFlkcxMH9/o9Kopu29QmZ2HNY9FW2/dkTofNHnzhaCApDnGMAlQz
 a+op1pwaZ7GCL2eiJzfrskhRTt5RyGGOHrQLFm8zsNurNVeXz8sYT6Cpy9JwU5sHt4bNaM
 cGAEUp+tT6It4rPTbsm4PcdMuuldUfTgYWmmJr6A1ukKuhfAHZB3avZGCwIBEv4E7+0rf3
 Dfg0rcaCMLhmsULYshg3EBUeICRo3mMXsv6nPHcWMXUeMwA6dhk6AN7KEiDmGdAFwnYTv7
 EK1N8WHXEWYI9FX6LjO1A/URZ/XdlxCPY0eHj4350Lka1W+MUF+j62w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=0
 OTWgZjx9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=qM9CCayo+odBClj3Be29y0zhArjJFE6wetIgo8xOthoX0EpfKaAicJTx1zaWCSs0eSWd
 LBsRouOq4lTfyX1ajQAZWBoVXTe+WRzisx1ja8RjL5JwodUjj5pm+H/d2uPKfEevBiGUKH
 31VE7rdxn70e608YubojXKBTIbmu/J94EneKxBI53If014wYiOce2zU2O/ch4gAocbYh5t
 HWoniueyfEzHljuYaYe6o4XHlIjTP3SsI7E3IejLySJ+cjfDkz3HM7tY3GnOkLux3jOEhA
 1eC16H7qHi+NqhabbGtLLlwnaYUM+NJmvq1JV8w5YeeAf7k9XOVZs1NY/T8lKJqg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=aXD7f076; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=UooqElqZ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=0OTWgZjx
 9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=aXD7f076AlH1iRT5cYj3S6y16IqwaZlYnub
 xizOq3ai4cu3jhUyrEGplhfQS2yEDPV7DvcNVyvhU+qVgaKFgG5ar28E1IbaG2ua1t0JEj
 goM3SEnl4DDiJavaCRxcJcY/+xBEKn685H+3hd+DYi6/Mc4Sc7sjMSPoFimCFbQVpvsVIS
 44lrkLzyitsXi8pbEfK0JcqPwq5/p+Wnq7QlgwUH4iCVUyklrvVSBmwNQm+racs1hqpp6u
 UHz//Chs39B3H4eKkfSDwN7n9Ykqnbw+ekGHHJ7DnAdFgUP02cgGSNASuESx8PbrMvqmeH
 3N/vM/mgqwkfNTs3PHdNLrSUPgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=0OTWgZjx9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=UooqElqZKkDctB0CYc
 TQYlzOqNW4xq8gRFPrp+nNERoChXvfXgh5CMVSTLABmoqOEprayTWr/ZTS/tlo3mthDg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 62975a9d
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:53:34 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 7f64d66a;
 Thu, 27 Aug 2026 17:53:33 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v1 1/5] openpic: Preserve IRQs masked by CTPR
Date: Thu, 27 Aug 2026 17:50:34 +0200
Message-ID: <20260827155310.7223-2-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827155310.7223-1-kirill@korins.ky>
References: <20260827155310.7223-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD exposes this by raising CTPR while handling interrupts. If an
edge remains pending when EOI lowers the servicing priority, QEMU
reasserts INT without checking CTPR; IACK then returns the spurious
vector and consumes the masked edge before CTPR permits delivery.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/intc/openpic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 99d2a1e65e..6f9a562163 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1033,8 +1033,9 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         n_IRQ = IRQ_get_next(opp, &dst->raised);
         if (n_IRQ != -1) {
             src = &opp->src[n_IRQ];
-            if (s_IRQ == -1 ||
-                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
+            if (IVPR_PRIORITY(src->ivpr) > dst->ctpr &&
+                (s_IRQ == -1 ||
+                 IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
                 DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
                         idx, n_IRQ);
                 qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
@@ -1070,12 +1071,13 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
     }
 
     src = &opp->src[irq];
-    if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
-            !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
+    if (!(src->ivpr & IVPR_ACTIVITY_MASK)) {
         error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
                 __func__, irq, dst->ctpr, src->ivpr);
         openpic_update_irq(opp, irq);
         retval = opp->spve;
+    } else if (IVPR_PRIORITY(src->ivpr) <= dst->ctpr) {
+        return opp->spve;
     } else {
         /* IRQ enter servicing state */
         IRQ_setbit(&dst->servicing, irq);
-- 
2.55.0


