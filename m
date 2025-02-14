Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A11C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 06:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tip8N-00072B-DU; Fri, 14 Feb 2025 01:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8I-0006wW-K3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:25:02 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8G-0003Ej-8U
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 01:25:02 -0500
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip8A-000LL9-0C; Fri, 14 Feb 2025 07:24:54 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tip89-000Myz-0h; Fri, 14 Feb 2025 07:24:53 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 87DFE480059;
 Fri, 14 Feb 2025 07:24:53 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id wraC8gW08fTL; Fri, 14 Feb 2025 07:24:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 544E8480160;
 Fri, 14 Feb 2025 07:24:53 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EFfQeWzoBcn6; Fri, 14 Feb 2025 07:24:53 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 360D4480059;
 Fri, 14 Feb 2025 07:24:52 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 1/5] hw/misc: Add MPFS system reset support
Date: Fri, 14 Feb 2025 07:24:38 +0100
Message-ID: <20250214062443.9936-2-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27548/Thu Feb 13 10:51:29 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/misc/mchp_pfsoc_sysreg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index 7876fe0c5b..08196525aa 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -27,7 +27,9 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
+#include "system/runstate.h"
=20
+#define MSS_RESET_CR    0x18
 #define ENVM_CR         0xb8
 #define MESSAGE_INT     0x118c
=20
@@ -56,6 +58,11 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwad=
dr offset,
 {
     MchpPfSoCSysregState *s =3D opaque;
     switch (offset) {
+    case MSS_RESET_CR:
+        if (value =3D=3D 0xdead) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
     case MESSAGE_INT:
         qemu_irq_lower(s->irq);
         break;
--=20
2.43.0


