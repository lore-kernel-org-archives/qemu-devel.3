Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A214C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KN6-0001YX-MX; Tue, 07 May 2024 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KN4-0001Us-Oi
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:56:39 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KN1-0004UO-Rn
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:56:38 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KMw-000MDU-U7; Tue, 07 May 2024 14:56:30 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s4KMw-000JjE-1J; Tue, 07 May 2024 14:56:30 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 541ED4801C3;
 Tue,  7 May 2024 14:56:30 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id zWNazU2G2fhJ; Tue,  7 May 2024 14:56:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 0ADE3480157;
 Tue,  7 May 2024 14:56:30 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id U_HZDD2t27oq; Tue,  7 May 2024 14:56:29 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [192.168.96.242])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id DA9AA480182;
 Tue,  7 May 2024 14:56:29 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: devel@rtems.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
Date: Tue,  7 May 2024 14:56:24 +0200
Message-Id: <20240507125624.86731-2-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <CAFEAcA8DAt+o-XZepg8xtj4i3xLW_yChwPnDZVM0O=rW8+9qJQ@mail.gmail.com>
References: <CAFEAcA8DAt+o-XZepg8xtj4i3xLW_yChwPnDZVM0O=rW8+9qJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27268/Tue May  7 10:25:13 2024)
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
index 20b3f701e0..79aee56053 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1397,6 +1397,13 @@ static void gic_dist_writeb(void *opaque, hwaddr o=
ffset,
                 value =3D ALL_CPU_MASK;
             }
             s->irq_target[irq] =3D value & ALL_CPU_MASK;
+            if (irq >=3D GIC_INTERNAL && s->irq_state[irq].pending) {
+                /*
+                 * Changing the target of an interrupt that is currently
+                 * pending updates the set of CPUs it is pending on.
+                 */
+                GIC_DIST_SET_PENDING(irq, value);
+            }
         }
     } else if (offset < 0xf00) {
         /* Interrupt Configuration.  */
--=20
2.35.3


