Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3FFCF9C69
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 01:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sroeT-0003G4-Qf; Fri, 20 Sep 2024 21:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@nikitashushura.com>)
 id 1srmQp-0003Lq-Gm
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 18:48:55 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@nikitashushura.com>)
 id 1srmQl-0004MK-VN
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 18:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nikitashushura.com;
 s=protonmail; t=1726872526; x=1727131726;
 bh=r72x9yn9SrXc+06YAdL2uht8NhKM8ayt3HicxTZ0fhI=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=rWRO0M7xfvuWFd90p3w/i4ZlU7TJEiC80IRtgmNOk9MnGv7y12nEueB9k4aWUKyYx
 S22sGS6npfJ2erpUbWo6JgVrRxLR2W6U4p2f1s+fNbwhzyRF5HJEqYM80f77xpi/Ua
 FUEAbwGVyU2VCkQEZAuaz8RQ2Ea+nXHHyEJxw4OTs1RWEqdGn51TeuJ92Hsz6Jipze
 Krm5FQYI8MJ6aB6eHE36r2VpLFA2WnmKXSFR6z1tcYF+fPEMvzOznrE48PIX3rDm3h
 JrHhibhp1cS1imucUt0k9SQ1/a1VKJORIk4kdlNO3isTpXpyFOhTbIVwG7ZutbwT3r
 zIA/6jOoTRjkA==
Date: Fri, 20 Sep 2024 22:48:41 +0000
To: qemu-devel@nongnu.org
From: Nikita Shushura <me@nikitashushura.com>
Cc: Nikita Shushura <me@nikitashushura.com>
Subject: [PATCH 1/2] hw/intc/grlib_irqmp: add support for extended interrupts
Message-ID: <20240920224810.69038-1-me@nikitashushura.com>
Feedback-ID: 120968030:user:proton
X-Pm-Message-ID: c1024a18bbe014edcd41b9adbc5d8350fdcb9a9e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=me@nikitashushura.com;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Sep 2024 21:11:05 -0400
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

---
 hw/intc/grlib_irqmp.c | 68 +++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 37ac63fd80..2fd76dd1b4 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -1,8 +1,6 @@
 /*
  * QEMU GRLIB IRQMP Emulator
  *
- * (Extended interrupt not supported)
- *
  * SPDX-License-Identifier: MIT
  *
  * Copyright (c) 2010-2024 AdaCore
@@ -38,25 +36,29 @@
 #include "qemu/module.h"
 #include "qom/object.h"
=20
-#define IRQMP_MAX_CPU 16
-#define IRQMP_REG_SIZE 256      /* Size of memory mapped registers */
+#define IRQMP_MAX_CPU (16)
+#define IRQMP_REG_SIZE (256)    /* Size of memory mapped registers */
=20
 /* Memory mapped register offsets */
-#define LEVEL_OFFSET     0x00
-#define PENDING_OFFSET   0x04
-#define FORCE0_OFFSET    0x08
-#define CLEAR_OFFSET     0x0C
-#define MP_STATUS_OFFSET 0x10
-#define BROADCAST_OFFSET 0x14
-#define MASK_OFFSET      0x40
-#define FORCE_OFFSET     0x80
-#define EXTENDED_OFFSET  0xC0
+#define LEVEL_OFFSET     (0x00)
+#define PENDING_OFFSET   (0x04)
+#define FORCE0_OFFSET    (0x08)
+#define CLEAR_OFFSET     (0x0C)
+#define MP_STATUS_OFFSET (0x10)
+#define BROADCAST_OFFSET (0x14)
+#define MASK_OFFSET      (0x40)
+#define FORCE_OFFSET     (0x80)
+#define EXTENDED_OFFSET  (0xC0)
=20
 /* Multiprocessor Status Register  */
 #define MP_STATUS_CPU_STATUS_MASK ((1 << IRQMP_MAX_CPU)-2)
-#define MP_STATUS_NCPU_SHIFT      28
+#define MP_STATUS_NCPU_SHIFT      (28)
+#define MP_STATUS_EIRQ_OFFSET     (16)
+
+#define MAX_PILS_STD (16)
+#define MAX_PILS_EXT (32)
=20
-#define MAX_PILS 16
+#define DEFAULT_EIRQ (12)
=20
 OBJECT_DECLARE_SIMPLE_TYPE(IRQMP, GRLIB_IRQMP)
=20
@@ -68,6 +70,7 @@ struct IRQMP {
     MemoryRegion iomem;
=20
     unsigned int ncpus;
+    unsigned int eirq;
     IRQMPState *state;
     qemu_irq start_signal[IRQMP_MAX_CPU];
     qemu_irq irq[IRQMP_MAX_CPU];
@@ -89,13 +92,25 @@ struct IRQMPState {
=20
 static void grlib_irqmp_check_irqs(IRQMPState *state)
 {
-    int i;
+    int i, j;
=20
     assert(state !=3D NULL);
     assert(state->parent !=3D NULL);
=20
     for (i =3D 0; i < state->parent->ncpus; i++) {
         uint32_t pend =3D (state->pending | state->force[i]) & state->mask=
[i];
+
+        /*
+         * Check is pending interrupt is extended,
+         * if so set pending to EIRQ and acknowledge extended interrupt"
+         */
+        for (j =3D MAX_PILS_STD; j <=3D MAX_PILS_EXT; j++) {
+            if ((pend & (1 << j)) !=3D 0) {
+                pend =3D (1 << state->parent->eirq);
+                state->extended[i] =3D (j & 0xffff);
+            }
+        }
+
         uint32_t level0 =3D pend & ~state->level;
         uint32_t level1 =3D pend &  state->level;
=20
@@ -110,6 +125,10 @@ static void grlib_irqmp_check_irqs(IRQMPState *state)
 static void grlib_irqmp_ack_mask(IRQMPState *state, unsigned int cpu,
                                  uint32_t mask)
 {
+    if ((mask & (1 << state->parent->eirq)) !=3D 0) {
+        mask |=3D (1 << state->extended[cpu]);
+    }
+
     /* Clear registers */
     state->pending  &=3D ~mask;
     state->force[cpu] &=3D ~mask;
@@ -144,7 +163,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq, =
int level)
     assert(s         !=3D NULL);
     assert(s->parent !=3D NULL);
=20
-
     if (level) {
         trace_grlib_irqmp_set_irq(irq);
=20
@@ -278,6 +296,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr=
,
                 state->mpstatus &=3D ~(1 << i);
             }
         }
+
+        /* Writing EIRQ number */
+        state->mpstatus |=3D (state->parent->eirq << MP_STATUS_EIRQ_OFFSET=
);
         return;
=20
     case BROADCAST_OFFSET:
@@ -345,7 +366,8 @@ static void grlib_irqmp_reset(DeviceState *d)
     memset(irqmp->state, 0, sizeof *irqmp->state);
     irqmp->state->parent =3D irqmp;
     irqmp->state->mpstatus =3D ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHIFT=
) |
-        ((1 << irqmp->ncpus) - 2);
+        ((1 << irqmp->ncpus) - 2) |
+        (irqmp->eirq << MP_STATUS_EIRQ_OFFSET);
 }
=20
 static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
@@ -359,7 +381,14 @@ static void grlib_irqmp_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
-    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+    if ((!irqmp->eirq) || (irqmp->eirq >=3D MAX_PILS_STD)) {
+        error_setg(errp, "Invalid eirq properties: "
+                   "%u, must be 0 < eirq < %u.", irqmp->eirq,
+                   MAX_PILS_STD);
+        return;
+    }
+
+    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS_EXT);
=20
     /*
      * Transitionning from 0 to 1 starts the CPUs. The opposite can't
@@ -378,6 +407,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error=
 **errp)
=20
 static Property grlib_irqmp_properties[] =3D {
     DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
+    DEFINE_PROP_UINT32("eirq", IRQMP, eirq, DEFAULT_EIRQ),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.46.1



