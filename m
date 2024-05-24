Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FE3C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 11:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sATAh-00083D-S3; Fri, 24 May 2024 07:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAd-00080s-Eu; Fri, 24 May 2024 07:33:12 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAZ-000860-NQ; Fri, 24 May 2024 07:33:10 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAT-000HaL-1q; Fri, 24 May 2024 13:33:01 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATAU-000A8R-0p; Fri, 24 May 2024 13:33:01 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 214D74801F5;
 Fri, 24 May 2024 13:33:01 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id DQ-hZ0HYiCjT; Fri, 24 May 2024 13:33:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id D2251480049;
 Fri, 24 May 2024 13:33:00 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Mpm92T11SG3j; Fri, 24 May 2024 13:33:00 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [192.168.96.242])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id ABCBB4801E3;
 Fri, 24 May 2024 13:33:00 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Luc Michel <luc@lmichel.fr>
Subject: [PATCH v2 2/2] hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
Date: Fri, 24 May 2024 13:32:56 +0200
Message-Id: <20240524113256.8102-3-sebastian.huber@embedded-brains.de>
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

According to the GICv2 specification section 4.3.12, "Interrupt Processor
Targets Registers, GICD_ITARGETSRn":

"Any change to a CPU targets field value:
[...]
* Has an effect on any pending interrupts. This means:
  - adding a CPU interface to the target list of a pending interrupt make=
s that
    interrupt pending on that CPU interface
  - removing a CPU interface from the target list of a pending interrupt
    removes the pending state of that interrupt on that CPU interface."

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/intc/arm_gic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 241255081d..1f9bffc88c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1410,6 +1410,13 @@ static void gic_dist_writeb(void *opaque, hwaddr o=
ffset,
                 value =3D ALL_CPU_MASK;
             }
             s->irq_target[irq] =3D value & ALL_CPU_MASK;
+            if (irq >=3D GIC_INTERNAL && s->irq_state[irq].pending) {
+                /*
+                 * Changing the target of an interrupt that is currently
+                 * pending updates the set of CPUs it is pending on.
+                 */
+                s->irq_state[irq].pending =3D value & ALL_CPU_MASK;
+            }
         }
     } else if (offset < 0xf00) {
         /* Interrupt Configuration.  */
--=20
2.35.3


