Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB77EE499B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLq5-0006IY-Q4; Wed, 11 Sep 2024 07:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1soLq4-0006I4-GM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:48:48 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kloetzke@kernkonzept.com>)
 id 1soLq1-0003Sc-Kf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=WqqmsKfTkcAwlTWf02Srbejxjxz/TRlxz0ft9S9c+WQ=; b=nUJuBNfimzbDU321iwq9/q09Rt
 Uq3LNMsHuibSVC/ywC+UKf4EgzhdXsIiQjHnz2inCvGb702ipNfN7SPuEqVoJY+NlP/g4J/CFPXG+
 FnGdPZ5PuICU5cWDsbF8vLNHUQ1KeETPDLKgkCy4Qfj3Tre6a6tUu/5Bf9fvyTN8PHCfvg6Q/s+JD
 8YCc3M74YbRDLyA4rhUle6uXBLGErqwElEaGocInJQaS3zbM0QRbyDhTLcVGLDlcTzIWJD0k5AFb6
 Z0AL6U6h65DtAx6DcGTNqpsK36RGpAHo5ye7abf6oT0YJ85W54hoIMQ17wAVDf+esPEKZ7ZCgk3lh
 li+C7Hug==;
Received: from p578eca80.dip0.t-ipconnect.de ([87.142.202.128]
 helo=shark.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1soLpy-00Bwjp-0C; Wed, 11 Sep 2024 13:48:42 +0200
From: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@kernkonzept.com>
Subject: [PATCH v2] hw/intc/arm_gic: fix spurious level triggered interrupts
Date: Wed, 11 Sep 2024 13:48:26 +0200
Message-Id: <20240911114826.3558302-1-jan.kloetzke@kernkonzept.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On GICv2 and later, level triggered interrupts are pending when either
the interrupt line is asserted or the interrupt was made pending by a
GICD_ISPENDRn write. Making a level triggered interrupt pending by
software persists until either the interrupt is acknowledged or cleared
by writing GICD_ICPENDRn. As long as the interrupt line is asserted,
the interrupt is pending in any case.

This logic is transparently implemented in gic_test_pending(). The
function combines the "pending" irq_state flag (used for edge triggered
interrupts and software requests) and the line status (tracked in the
"level" field). Now, writing GICD_ISENABLERn incorrectly set the
pending flag if the line of a level triggered interrupt was asserted.
This keeps the interrupt pending even if the line is de-asserted after
some time.

Apparently, the 11MPCore behaves differently. A level triggered
interrupt that is disabled does not get pending. Thus we have to retain
the get-pending-on-enable logic just for this model. For GICv2 and
later, the pending status is fully handled by gic_test_pending() and
does not need any special treatment when enabling the level interrupt.

Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
---
v2:
  * Keep existing logic for 11MPCore

 hw/intc/arm_gic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 806832439b..4333d52ee2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1264,8 +1264,9 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                 }
                 GIC_DIST_SET_ENABLED(irq + i, cm);
                 /* If a raised level triggered IRQ enabled then mark
-                   is as pending.  */
-                if (GIC_DIST_TEST_LEVEL(irq + i, mask)
+                   is as pending on 11MPCore.  */
+                if (s->revision == REV_11MPCORE
+                        && GIC_DIST_TEST_LEVEL(irq + i, mask)
                         && !GIC_DIST_TEST_EDGE_TRIGGER(irq + i)) {
                     DPRINTF("Set %d pending mask %x\n", irq + i, mask);
                     GIC_DIST_SET_PENDING(irq + i, mask);
-- 
2.39.2


