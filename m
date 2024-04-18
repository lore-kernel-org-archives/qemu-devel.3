Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB7C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyl-0001y8-Kf; Thu, 18 Apr 2024 16:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyj-0001qi-Dy; Thu, 18 Apr 2024 16:03:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXyh-0005TV-Rc; Thu, 18 Apr 2024 16:03:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5FC3F5FE19;
 Thu, 18 Apr 2024 23:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BD79CB93FF;
 Thu, 18 Apr 2024 23:02:25 +0300 (MSK)
Received: (nullmailer pid 952891 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cedric Le Goater <clg@kaod.org>, Kowshik Jois <kowsjois@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 58/59] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer
 IRQ range for CPU IPIs.
Date: Thu, 18 Apr 2024 23:02:18 +0300
Message-Id: <20240418200224.952785-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
the range of CPU IPIs during initialization of nr-irqs property.
It is more appropriate to have its own define which can be further
reused as appropriate for correct interpretation.

Suggested-by: Cedric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Kowshik Jois <kowsjois@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 2df5c1f5b014126595a26c6797089d284a3b211c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a0d1e1298e..97b2fc42ab 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -23,6 +23,8 @@
 
 #include "trace.h"
 
+QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
+
 static const TypeInfo spapr_intc_info = {
     .name = TYPE_SPAPR_INTC,
     .parent = TYPE_INTERFACE,
@@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
+        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
+                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..4fd2d5853d 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -14,9 +14,21 @@
 #include "qom/object.h"
 
 /*
- * IRQ range offsets per device type
+ * The XIVE IRQ backend uses the same layout as the XICS backend but
+ * covers the full range of the IRQ number space. The IRQ numbers for
+ * the CPU IPIs are allocated at the bottom of this space, below 4K,
+ * to preserve compatibility with XICS which does not use that range.
+ */
+
+/*
+ * CPU IPI range (XIVE only)
  */
 #define SPAPR_IRQ_IPI        0x0
+#define SPAPR_IRQ_NR_IPIS    0x1000
+
+/*
+ * IRQ range offsets per device type
+ */
 
 #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
 #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
-- 
2.39.2


