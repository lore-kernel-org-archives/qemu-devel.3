Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C70DCA5FE0
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPmN-0004PG-TN; Thu, 01 Oct 2026 19:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmE-0004Nq-4K; Thu, 01 Oct 2026 19:01:23 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmB-0007j7-Fy; Thu, 01 Oct 2026 19:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=iZ7GWYf
 3GROlueYizIhf8Y29oTAlP/ZeDsNsPUuB1hyRHCzArRIthB/fT6WdWP1knS9TrPZxdhULq
 RTtyXqHf4ZavVltv4p+bWUX4yizVcPg97V3nH8sThmiKycZlaqJR7v1ThBfTmg65uiujBq
 QTOdKysDvjNFpEiXQoPvfOOYz95EbBJ29D4yX/PtBYd3glmh/C/M2AkgrZUzdrTiCod5JR
 8SMoPeQdminFXvb2LAbKFQAwTTqq0OsMnEdl7fqFURvOl0rxlH4s+NU9AbeXmRWuCRH7H+
 cESr+cpLitnESyjRuy+yEkG1jzHepZ3uFadWYgITEdnDV1ryuevLYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=0
 ERyRb6mMZLjjAVoNWZHwoNrm9+FPGn+a7XsywChKAY=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Q0V3jbPb4fVL4A3QoyJYOT3lZZMAEtl1v4unRhVxDQ2GlKJcgMrTlx/mMOZwa5KxCpoF
 REbOgALauW5F0XZLI416ekZLqRG/FPQQ94Xj6tnvzrdKZr9Exx0FUXPDBLm5PYw/njznjn
 xud8qV55l3aOQC/W6kAmJvx+KUh3AC8oXCmFq+axc0Yut3h8JhQ7We8fcsSvIazXmjl0yI
 x95ZkHrsQo9WnUX36rY25KFeRv+xs7V4FdyBG8erNJezrQFksgN5nvPjiCVM0DnO9LFzAb
 e4uQCAD9WFonWTEWU72f4o33//bXK1I91jB5HICZsxDCS0gG9A9JDhlAWXWQJHkw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=eoGaH565; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=j+/NCJuL;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=0ERyRb6m
 MZLjjAVoNWZHwoNrm9+FPGn+a7XsywChKAY=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=eoGaH5653LUrUFvcKOiz8XPytgqIbnBp//7
 f6lT5lPhZ+DhtskTliH07ePqoPnc3CCW8u3CdkM3XTqmw3C36Az0IlowRrgwD0AiT448N5
 I97uiCW3+dfuF8zbO3dOkPEZuOcu1tBf5w1gpL4zj0QJZFwPYxJ6mobRLB8iCcMlburpN0
 6/id6YTHNVEsH4LlcOTAo62mw4jf5XZzraPNUEvj+x7hMau7/xzQmRg28rN+nd8Ag1N2kC
 ycaCwY1+jmow0JoSZqlfrGur/IrtYEBGP2ikxAxz6HHwhz45JDOZJu/SXPExGNAqbn4KLp
 zuk8BG+AtO4Qc4wmPq/TouiG8CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=0ERyRb6mMZLjjAVoNWZHwoNrm9+FPGn+a7XsywChKAY=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=j+/NCJuLoE4sAb2kXS
 qK4MMSkFbOLI1uxp/jc+ZT+WfyZFJUFy6EOhJnNBF+94HrP2bEu5YAmAjVbdpMGHELAw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id b54f8166
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 01:01:09 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id f9549012;
 Fri, 2 Oct 2026 01:01:07 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v3 1/5] openpic: Preserve IRQs masked by CTPR
Date: Fri,  2 Oct 2026 00:59:00 +0200
Message-ID: <20261001230058.11465-2-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001230058.11465-1-kirill@korins.ky>
References: <20261001230058.11465-1-kirill@korins.ky>
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

OpenBSD exposes this by raising CTPR while handling interrupts. If an
edge remains pending when EOI lowers the servicing priority, QEMU
reasserts INT without checking CTPR; IACK then returns the spurious
vector and consumes the masked edge before CTPR permits delivery.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


