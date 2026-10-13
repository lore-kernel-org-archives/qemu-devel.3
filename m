Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF40CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiAS-0001q5-Kd; Tue, 13 Oct 2026 15:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAQ-0001pV-TR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAP-00087B-EB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XG0OZGKFxU5Od9PDLXkxtlKjW1z13fgHLaTeGYF+lFo=; b=PEEmIXwdIjoPbim5Hr5fTlaSBj
 Wo7+/tddE0AS9s09g43rK/mb8WghluC0kYqnk2cGhFuedEiwEO61aEQlPS/zmMjTHX0WQ47YgshxX
 FFR7EN1TuzOaKl3lVxtEYUWuRSkwY6DXjKi9syWX9Bv5ik2ctvbNNgC2VTltB/QnZLwG2o4TTjmur
 23EW4ZwLQHxPNJ8EXAI3DoPJGZBhgx9OM4OsipqLc3GAsKEjupqIUFVAEIulY7hirREbNfzETmH8P
 g5vzu8VqM+YYCgLlOcoZRXDpTQPnEtZtHPzyd+NKRcIGIwpJupNjfAFa+5q9iAmnWEENLgTeLJPTk
 zqQXab1ssUocTLrHgUQ6hxMrau0FCK5SRW8MB4ZhGq4/i7NVrR+8sfnK07APKf8onVSo7KhJqH4fI
 mafNa7ALi3rrW6QkiQioMIMrv3u9IMJR7+vKDuyEMgDnfQ8ExA7UbwEf7pskCu1OHtGnBiLrPHItW
 Qao5p7eh+WogC/492F8aLsmiO1XPGvXuJW4EW5vddaQg59H0qPTgW+wOnIQu9WTSrxyGpqk2GDLMt
 DmdctUo9LokvdM1dtAwAblPYqw11Tk5OX5QOmXd/w3pUdflcy64llOLqlXCob3wWY2vt30plip64t
 wD7irwSjOp54j3pQQhIEALcBpg03t4876BVlCvADc=;
Received: from [2a02:8012:2f01:0:b2a5:667b:71e2:6751]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xGi9j-001aAM-8r
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:27:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 13 Oct 2026 20:27:33 +0100
Message-ID: <20261013192751.196204-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
References: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b2a5:667b:71e2:6751
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 1/5] openpic: Preserve IRQs masked by CTPR
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Message-ID: <20261001230058.11465-2-kirill@korins.ky>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/intc/openpic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 99d2a1e65ec..6f9a5621631 100644
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
2.47.3


