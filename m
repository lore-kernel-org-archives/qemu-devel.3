Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1D1CFB454
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtET-0004es-8P; Mon, 07 Oct 2024 15:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEK-0004US-Ln; Mon, 07 Oct 2024 15:17:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEI-00046H-UP; Mon, 07 Oct 2024 15:17:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A6BA996246;
 Mon,  7 Oct 2024 22:16:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7409A14F727;
 Mon,  7 Oct 2024 22:16:55 +0300 (MSK)
Received: (nullmailer pid 2592731 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 10/32] hw/intc/arm_gic: fix spurious level triggered
 interrupts
Date: Mon,  7 Oct 2024 22:16:27 +0300
Message-Id: <20241007191654.2592616-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jan Klötzke <jan.kloetzke@kernkonzept.com>

On GICv2 and later, level triggered interrupts are pending when either
the interrupt line is asserted or the interrupt was made pending by a
GICD_ISPENDRn write. Making a level triggered interrupt pending by
software persists until either the interrupt is acknowledged or cleared
by writing GICD_ICPENDRn. As long as the interrupt line is asserted,
the interrupt is pending in any case.

This logic is transparently implemented in gic_test_pending() for
GICv1 and GICv2.  The function combines the "pending" irq_state flag
(used for edge triggered interrupts and software requests) and the
line status (tracked in the "level" field).  However, we also
incorrectly set the pending flag on a guest write to GICD_ISENABLERn
if the line of a level triggered interrupt was asserted.  This keeps
the interrupt pending even if the line is de-asserted after some
time.

This incorrect logic is a leftover of the initial 11MPCore GIC
implementation.  That handles things slightly differently to the
architected GICv1 and GICv2.  The 11MPCore TRM does not give a lot of
detail on the corner cases of its GIC's behaviour, and historically
we have not wanted to investigate exactly what it does in reality, so
QEMU's GIC model takes the approach of "retain our existing behaviour
for 11MPCore, and implement the architectural standard for later GIC
revisions".

On that basis, commit 8d999995e45c10 in 2013 is where we added the
"level-triggered interrupt with the line asserted" handling to
gic_test_pending(), and we deliberately kept the old behaviour of
gic_test_pending() for REV_11MPCORE.  That commit should have added
the "only if 11MPCore" condition to the setting of the pending bit on
writes to GICD_ISENABLERn, but forgot it.

Add the missing "if REV_11MPCORE" condition, so that our behaviour
on GICv1 and GICv2 matches the GIC architecture requirements.

Cc: qemu-stable@nongnu.org
Fixes: 8d999995e45c10 ("arm_gic: Fix GIC pending behavior")
Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
Message-id: 20240911114826.3558302-1-jan.kloetzke@kernkonzept.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded comment a little and converted to coding-style form;
 expanded commit message with the historical backstory]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 110684c9a69a02cbabfbddcd3afa921826ad565c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 806832439b..2a48f0da2f 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1263,9 +1263,14 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                     trace_gic_enable_irq(irq + i);
                 }
                 GIC_DIST_SET_ENABLED(irq + i, cm);
-                /* If a raised level triggered IRQ enabled then mark
-                   is as pending.  */
-                if (GIC_DIST_TEST_LEVEL(irq + i, mask)
+                /*
+                 * If a raised level triggered IRQ enabled then mark
+                 * it as pending on 11MPCore. For other GIC revisions we
+                 * handle the "level triggered and line asserted" check
+                 * at the other end in gic_test_pending().
+                 */
+                if (s->revision == REV_11MPCORE
+                        && GIC_DIST_TEST_LEVEL(irq + i, mask)
                         && !GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
                     DPRINTF("Set %d pending mask %x\n", irq + i, mask);
                     GIC_DIST_SET_PENDING(irq + i, mask);
-- 
2.39.5


