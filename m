Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A900EC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 11:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sATAe-00080t-HC; Fri, 24 May 2024 07:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAb-00080C-4y; Fri, 24 May 2024 07:33:09 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAZ-000861-Bk; Fri, 24 May 2024 07:33:08 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAT-000HaM-1y; Fri, 24 May 2024 13:33:01 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAU-000A8r-0x; Fri, 24 May 2024 13:33:01 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 32901480049;
 Fri, 24 May 2024 13:33:01 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id f9yf7b3Hvxuh; Fri, 24 May 2024 13:33:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id CE0834801F6;
 Fri, 24 May 2024 13:33:00 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VrTqsqfEdEzm; Fri, 24 May 2024 13:33:00 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [192.168.96.242])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 9E5DF480197;
 Fri, 24 May 2024 13:33:00 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Luc Michel <luc@lmichel.fr>
Subject: [PATCH v2 1/2] hw/intc/arm_gic: Fix set pending of PPIs
Date: Fri, 24 May 2024 13:32:55 +0200
Message-Id: <20240524113256.8102-2-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524113256.8102-1-sebastian.huber@embedded-brains.de>
References: <20240524113256.8102-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27285/Fri May 24 10:30:55 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
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

According to the GICv2 specification section 4.3.7, "Interrupt Set-Pendin=
g
Registers, GICD_ISPENDRn":

"In a multiprocessor implementation, GICD_ISPENDR0 is banked for each con=
nected
processor. This register holds the Set-pending bits for interrupts 0-31."

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/intc/arm_gic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 074cf50af2..241255081d 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1308,12 +1308,15 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
=20
         for (i =3D 0; i < 8; i++) {
             if (value & (1 << i)) {
+                int mask =3D (irq < GIC_INTERNAL) ? (1 << cpu)
+                                                : GIC_DIST_TARGET(irq + =
i);
+
                 if (s->security_extn && !attrs.secure &&
                     !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                     continue; /* Ignore Non-secure access of Group0 IRQ =
*/
                 }
=20
-                GIC_DIST_SET_PENDING(irq + i, GIC_DIST_TARGET(irq + i));
+                GIC_DIST_SET_PENDING(irq + i, mask);
             }
         }
     } else if (offset < 0x300) {
--=20
2.35.3


