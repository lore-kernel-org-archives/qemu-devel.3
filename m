Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB5ED5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kSr-0004Nk-Mm; Sat, 09 Nov 2024 07:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kQq-0001n8-MX; Sat, 09 Nov 2024 07:19:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kQp-0005PM-1v; Sat, 09 Nov 2024 07:19:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E62BA1651;
 Sat,  9 Nov 2024 15:08:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E8CAB167FD7;
 Sat,  9 Nov 2024 15:09:03 +0300 (MSK)
Received: (nullmailer pid 3296247 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 39/58] ppc/pnv: Fix LPC serirq routing calculation
Date: Sat,  9 Nov 2024 15:08:40 +0300
Message-Id: <20241109120901.3295995-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

The serirq routing table is split over two registers, the calculation
for the high irqs in the second register did not subtract the irq
offset. This was spotted by Coverity as a shift-by-negative. Fix this
and change the open-coded shifting and masking to use extract32()
function so it's less error-prone.

This went unnoticed because irqs >= 14 are not used in a standard
QEMU/OPAL boot, changing the first QEMU serial-isa irq to 14 to test
does demonstrate serial irqs aren't received, and that this change
fixes that.

Cc: qemu-stable@nongnu.org
Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558829 (partially)
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 899e488650bb8bd52e1b2b44ceaae17df2e20b7f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f8aad955b5..80b79dfbbc 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -435,13 +435,19 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
         return;
     }
 
+    /*
+     * Each of the ISA irqs is routed to one of the 4 SERIRQ irqs with 2
+     * bits, split across 2 OPB registers.
+     */
     for (irq = 0; irq <= 13; irq++) {
-        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
+        int serirq = extract32(lpc->opb_irq_route1,
+                                    PPC_BIT32_NR(5 + irq * 2), 2);
         lpc->irq_to_serirq_route[irq] = serirq;
     }
 
     for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
-        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
+        int serirq = extract32(lpc->opb_irq_route0,
+                               PPC_BIT32_NR(9 + (irq - 14) * 2), 2);
         lpc->irq_to_serirq_route[irq] = serirq;
     }
 }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 321ed2da75..bd32a1a5f8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -40,6 +40,7 @@
 
 #define PPC_BIT_NR(bit)         (63 - (bit))
 #define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32_NR(bit)       (31 - (bit))
 #define PPC_BIT32(bit)          (0x80000000 >> (bit))
 #define PPC_BIT8(bit)           (0x80 >> (bit))
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
-- 
2.39.5


