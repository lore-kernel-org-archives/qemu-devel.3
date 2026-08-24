Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA37C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 00:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyIds-0007xK-QS; Sun, 23 Aug 2026 20:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdo-0007wq-Qg
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:34:20 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdn-0007ij-0t
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:34:20 -0400
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdi-000MWn-2Q for qemu-devel@nongnu.org;
 Mon, 24 Aug 2026 02:34:14 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdh-0004N5-2q for qemu-devel@nongnu.org;
 Mon, 24 Aug 2026 02:34:13 +0200
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 83E3F48015A
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:13 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id shmLD8A3ZN1E for <qemu-devel@nongnu.org>;
 Mon, 24 Aug 2026 02:34:13 +0200 (CEST)
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 38D04480153
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 38D04480153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1787531653;
 bh=dxWI6WGQFJ7EpG1oKNYr5GhcQ1+ZM7yjJSqMh2KHyaM=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=IdU+aFaC+ygZTCAIGQpQGxHmgLCEPOuwSyefSOL7S9x/RDWetGCmKE9zMSHyQUTf0
 igolZOTgQJ7A73YqyKp3burnG1E5PMfyviBX6qIcgR4q5rjCgtLoa+Tr5bF5soJXZY
 rnxFwszjlM+Sb4nz4dX5zXqxhWRxky/WwOYIWXH45VfFoUlAt66JSWiiNod5XMSufp
 YzsKpCGXcgrBO9TLd1a9B8iSR+Vy09e6mEUDsQTgHh2ubJxinkXRNDjW6ocd37KyXA
 NBn8stLpbnfAeS+0toNzJ6fTQjF5cpYqqPyUSrqc2rBUQmeuKmYnPQWAFbLm6c3HXF
 HXF6avUkMrslw==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id mJdbkbMX-fvb for <qemu-devel@nongnu.org>;
 Mon, 24 Aug 2026 02:34:13 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 963E648006F
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:12 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/timer/xilinx_timer: Start on the enable edge
Date: Mon, 24 Aug 2026 02:34:04 +0200
Message-ID: <20260824003405.616297-2-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260824003405.616297-1-sebastian.huber@embedded-brains.de>
References: <20260824003405.616297-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-DKIM-Status: pass [(embedded-brains.de) - 78.47.166.52]
X-Virus-Scanned: Clear (ClamAV 1.4.3/28101/Sun Aug 23 08:26:53 2026)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Every write to a control register which has the enable bit set
restarted the count from the load value.  A guest which clears the
interrupt of a periodic timer writes that register with the enable bit
still set, so every period gained the latency of the interrupt.

Start the count only where the enable bit goes from zero to one.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/timer/xilinx_timer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 8a502dae0e..dff439c623 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -175,17 +175,25 @@ timer_write(void *opaque, hwaddr addr,
     addr &=3D 3;
     switch (addr)=20
     {
-        case R_TCSR:
+        case R_TCSR: {
+            uint32_t old =3D xt->regs[R_TCSR];
+
             if (value & TCSR_TINT)
                 value &=3D ~TCSR_TINT;
=20
             xt->regs[addr] =3D value & 0x7ff;
-            if (value & TCSR_ENT) {
+            /*
+             * Only a transition of the enable bit to one starts the cou=
nt.
+             * A write which leaves the bit set, such as the acknowledge=
 of
+             * an interrupt, does not restart it.
+             */
+            if ((value & TCSR_ENT) && !(old & TCSR_ENT)) {
                 ptimer_transaction_begin(xt->ptimer);
                 timer_enable(xt);
                 ptimer_transaction_commit(xt->ptimer);
             }
             break;
+        }
 =20
         default:
             if (addr < ARRAY_SIZE(xt->regs))
--=20
2.51.0


