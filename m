Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2626C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2602-0003jw-UB; Thu, 03 Sep 2026 07:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x2601-0003iV-7j; Thu, 03 Sep 2026 07:52:57 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x25zz-0002hG-6t; Thu, 03 Sep 2026 07:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=np1BU3p
 RTzWRwQK6Lth1u4upehvhHSAXUVQyUccdRYryJ+OtlJLXEvknXu+LegZaUeswbGa5A8jcW
 T8w7BhYbjWPLR8xJar70HiT8jHtUwTUHyvit2T01rtAJ1foHcEMSD4iP5pRHdDSl9WsFpz
 UnEvg7RDIdn16VyjmRo1TQLaz0hnhyzzOmePtHO6m1E9U+hOy51Zs83VYvobc6LeGMxH51
 tebXivvgfDSXJOViMZ1y+zS2VEBe8nYIrUFp7Y4BXG2x4AlzdYsalsAmAG1Uc5uyJVn796
 sOrFowK5fGiYjlQMcfoGNmGLyIg/zYs9Oj2M8ifHPC+ky24Fnn9DEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=0
 OTWgZjx9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=SDGKQReAx9VpW5Z9ibeGSedfnnGvvhujvD3Lp8IAhbbUn5LyBTcIpwOvUQSH4dSfuSfp
 AACjCgFCGyrN0gpNCgn3KDbtVkuMD9n7MtOZoH/b1GHX8grof7n//M6khv1pF8snT5H5tj
 73ATViKqiR+wD6vlzE+YV2vXzDr6mRgtYooY5cMz6BsbJ0jxWxeFQWXeHFX/3gjTVgoUOj
 7CpodNb8kQhTInF17xbuCdaHIOuTzU/F85ZgJth+z6OTPm1fzqpDZMPH95CglsLufltz5G
 JxyAPWeGU3bzXDWPy9jFcU5j0BMoMkTfSvj5zKfxhH3LOmmEIlK/7mNGADlLEHbg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=F8zXYT9A; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=5D2i2Tg6;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=0OTWgZjx
 9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=F8zXYT9AvGYfdGAhm/aOHp3/WvRsfc8+rxA
 sxti+4e47qKpjUmb7Wwdjqt2uL0TyhNGM+PIh99zRTHcH/zBqniA+3aW3kQuSg++LRrDDf
 HPxhvJ8scW93im3IIJJ5uv0mPPLo+Vj5+BAtPA1esNs76VE2BY0FIN5mzjeO2gJKgVMWhc
 QBRyocx0Qs6UbqT8mWa/Nb4J3V43zgYrPlYsvivq8kbRtz+0j3mrpD2lefxGE3kcScmgiY
 3dPbJzVYkz8m6cJhl/QaBreEAbTz1oKKuPeZK834ccVku+FUVL6/q/eqKpo80u65nsX2xx
 gZrs/inVGpsrcKQvW2lPE+F6KBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=0OTWgZjx9Loia+02herFsXxqxRWHhR9TMYMBOb0kF5U=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=5D2i2Tg6ZXTw2vkJxk
 ynR2kogZWd/prusLQWOV+/v+mgsizinwr5J1cRK71g9i5z/GaX2cbQfL/ggZ7QRY2XDg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id db389ec9
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 13:52:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id b4fb2c83;
 Thu, 3 Sep 2026 13:52:47 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 1/5] openpic: Preserve IRQs masked by CTPR
Date: Thu,  3 Sep 2026 13:50:26 +0200
Message-ID: <20260903115229.95811-2-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903115229.95811-1-kirill@korins.ky>
References: <20260903115229.95811-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


