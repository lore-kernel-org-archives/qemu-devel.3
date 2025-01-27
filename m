Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49525C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgOX-0008WF-Lh; Tue, 28 Jan 2025 02:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgOV-0008Qn-24; Tue, 28 Jan 2025 02:52:23 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgOT-0007a6-4g; Tue, 28 Jan 2025 02:52:22 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2ED51E1AB2;
 Tue, 28 Jan 2025 10:51:54 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D14D1A62A8;
 Tue, 28 Jan 2025 10:52:19 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 96F2851FE7; Tue, 28 Jan 2025 10:52:19 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 01/31] hw/intc/openpic: Avoid taking address of
 out-of-bounds array index
Date: Tue, 28 Jan 2025 00:40:53 +0300
Message-Id: <20250127214124.3730126-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The clang sanitizer complains about the code in the EOI handling
of openpic_cpu_write_internal():

UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in

This is because we do
  src = &opp->src[n_IRQ];
when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
is -1 then we don't do anything with the src pointer, but it is
undefined behaviour. (This has been present since this device
was first added to QEMU.)

Rearrange the code so we only do the array index when n_IRQ is not -1.

Cc: qemu-stable@nongnu.org
Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 20241105180205.3074071-1-peter.maydell@linaro.org
(cherry picked from commit 3bf7dcd47a3da0e86a9347ce5b2b5d5a1dcb5857)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index c757adbe53..adc79abbe5 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1035,13 +1035,14 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
         s_IRQ = IRQ_get_next(opp, &dst->servicing);
         /* Check queued interrupts. */
         n_IRQ = IRQ_get_next(opp, &dst->raised);
-        src = &opp->src[n_IRQ];
-        if (n_IRQ != -1 &&
-            (s_IRQ == -1 ||
-             IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
-            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
-                    idx, n_IRQ);
-            qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
+        if (n_IRQ != -1) {
+            src = &opp->src[n_IRQ];
+            if (s_IRQ == -1 ||
+                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
+                DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
+                        idx, n_IRQ);
+                qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
+            }
         }
         break;
     default:
-- 
2.39.5


