Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CA7C30653
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNeGn-0000D4-D9; Sat, 29 Jun 2024 16:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sNeGl-0000BG-JJ
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 16:01:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sNeGj-0004fe-Vn
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 16:01:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0F7E94E6000;
 Sat, 29 Jun 2024 22:01:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id sfk6lJkrpk-t; Sat, 29 Jun 2024 22:01:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1C3B34E6001; Sat, 29 Jun 2024 22:01:53 +0200 (CEST)
Message-Id: <e3ffd0f6ef8845d0f7247c9b6ff33f7ee8b432cf.1719690591.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1719690591.git.balaton@eik.bme.hu>
References: <cover.1719690591.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/2] hw: Move declaration of IRQState to header and add init
 function
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jun 2024 22:01:53 +0200 (CEST)
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

To allow embedding a qemu_irq in a struct move its definition to the
header and add a function to init it in place without allocating it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/core/irq.c    | 25 +++++++++++--------------
 include/hw/irq.h | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 3f14e2dda7..db95ffc18f 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -26,16 +26,6 @@
 #include "hw/irq.h"
 #include "qom/object.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(IRQState, IRQ)
-
-struct IRQState {
-    Object parent_obj;
-
-    qemu_irq_handler handler;
-    void *opaque;
-    int n;
-};
-
 void qemu_set_irq(qemu_irq irq, int level)
 {
     if (!irq)
@@ -44,6 +34,15 @@ void qemu_set_irq(qemu_irq irq, int level)
     irq->handler(irq->opaque, irq->n, level);
 }
 
+void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
+                   int n)
+{
+    object_initialize(irq, sizeof(*irq), TYPE_IRQ);
+    irq->handler = handler;
+    irq->opaque = opaque;
+    irq->n = n;
+}
+
 qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
                            void *opaque, int n)
 {
@@ -69,10 +68,8 @@ qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
 {
     IRQState *irq;
 
-    irq = IRQ(object_new(TYPE_IRQ));
-    irq->handler = handler;
-    irq->opaque = opaque;
-    irq->n = n;
+    irq = g_new(IRQState, 1);
+    qemu_init_irq(irq, handler, opaque, n);
 
     return irq;
 }
diff --git a/include/hw/irq.h b/include/hw/irq.h
index 645b73d251..c861c1debd 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -1,9 +1,20 @@
 #ifndef QEMU_IRQ_H
 #define QEMU_IRQ_H
 
+#include "qom/object.h"
+
 /* Generic IRQ/GPIO pin infrastructure.  */
 
 #define TYPE_IRQ "irq"
+OBJECT_DECLARE_SIMPLE_TYPE(IRQState, IRQ)
+
+struct IRQState {
+    Object parent_obj;
+
+    qemu_irq_handler handler;
+    void *opaque;
+    int n;
+};
 
 void qemu_set_irq(qemu_irq irq, int level);
 
@@ -23,6 +34,13 @@ static inline void qemu_irq_pulse(qemu_irq irq)
     qemu_set_irq(irq, 0);
 }
 
+/*
+ * Init a single IRQ. The irq is assigned with a handler, an opaque data
+ * and the interrupt number.
+ */
+void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
+                   int n);
+
 /* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
  * opaque data.
  */
-- 
2.30.9


