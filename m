Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5340CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 12:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl6Dl-0004rK-Td; Mon, 02 Sep 2024 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1sl6D1-0004jz-6Z
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 08:31:03 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1sl6Cv-0008UR-R0
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 08:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=0lHBMMLjyV66zNy0vADjphnQD9Jvz+0KNvkhvWpuC8g=; b=mBLUezLnbDrgq4L6BKIq+72db2
 3n/OFWHBuVsw2ev2PQVAFmU33JghhL36HW2YvlMyuh6pAknqscaWpBfMIOgloxaXCgGUj7SjvhKxD
 mkDb9j+bFsgPDjk1GCZG2oJ5ieI9p2lKmE/OvwIL1kChCEDcofPqg3dSa515w2NP2GIBwcSs23haC
 b7rsv+ttVS01T6Z3fldefjDC349aFXY2ao7jN00euNdlL9M+SuZ4uEWmSDpZP9Mqclsuw21GkP0Bz
 qJ2zrfWmQLzXet9gceIacOACBHwnVSvreoge3X0YtM+AneNYBEFsrvduKhZMXDoQb9vcc1Tsb3yiV
 cIMkrLMA==;
Received: from p50883c9a.dip0.t-ipconnect.de ([80.136.60.154]
 helo=shark.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1sl6Cr-009sVb-12; Mon, 02 Sep 2024 14:30:53 +0200
From: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
Subject: [PATCH] hw/intc/arm_gic: fix spurious level triggered interrupts
Date: Mon,  2 Sep 2024 14:30:38 +0200
Message-Id: <20240902123038.1135412-1-jan.kloetzke@kernkonzept.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=jan.kloetzke@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Level triggered interrupts are pending when either the interrupt line
is asserted or the interrupt was made pending by a GICD_ISPENDRn write.
Making a level triggered interrupt pending by software persists until
either the interrupt is acknowledged or cleared by writing
GICD_ICPENDRn. As long as the interrupt line is asserted, the interrupt
is pending in any case.

This logic is transparently implemented in gic_test_pending(). The
function combines the "pending" irq_state flag (used for edge triggered
interrupts and software requests) and the line status (tracked in the
"level" field). Now, writing GICD_ISENABLERn incorrectly set the
pending flag if the line of a level triggered interrupt was asserted.
This keeps the interrupt pending even if the line is de-asserted after
some time.

Fix this by simply removing the code. The pending status is fully
handled by gic_test_pending() and does not need any special treatment
when enabling the level interrupt.

Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
---
 hw/intc/arm_gic.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 806832439b..10fc9bfd14 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1248,9 +1248,6 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
 
         for (i = 0; i < 8; i++) {
             if (value & (1 << i)) {
-                int mask =
-                    (irq < GIC_INTERNAL) ? (1 << cpu)
-                                         : GIC_DIST_TARGET(irq + i);
                 int cm = (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
 
                 if (s->security_extn && !attrs.secure &&
@@ -1263,13 +1260,6 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                     trace_gic_enable_irq(irq + i);
                 }
                 GIC_DIST_SET_ENABLED(irq + i, cm);
-                /* If a raised level triggered IRQ enabled then mark
-                   is as pending.  */
-                if (GIC_DIST_TEST_LEVEL(irq + i, mask)
-                        && !GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
-                    DPRINTF("Set %d pending mask %x\n", irq + i, mask);
-                    GIC_DIST_SET_PENDING(irq + i, mask);
-                }
             }
         }
     } else if (offset < 0x200) {
-- 
2.39.2


