Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9B2C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 00:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyIds-0007xU-QE; Sun, 23 Aug 2026 20:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdp-0007x3-QQ
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:34:22 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdn-0007jD-0l
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:34:21 -0400
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdj-000MX6-28 for qemu-devel@nongnu.org;
 Mon, 24 Aug 2026 02:34:14 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdi-0004Tc-2i for qemu-devel@nongnu.org;
 Mon, 24 Aug 2026 02:34:14 +0200
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 7A0E048006F
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:14 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jaYjO_Z_evDG for <qemu-devel@nongnu.org>;
 Mon, 24 Aug 2026 02:34:14 +0200 (CEST)
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 191BA480153
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 191BA480153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1787531654;
 bh=5lQnvr/w0aQKUxL94xjZv+++DhvywaDZVxwDAzz9vlU=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=LyyMw3p2FZ3wQkZMVyLCD/nBHjVcmq2YXTcgYQQV7k1+3wFYqLnU0DFyvSXQ/gMDH
 Z/cVh6oxMifengHuSyAlgppOEuJ+hNe199x7+SGp2ibS+Eq38BqqPInKhGUGOv2KNC
 lJ9wgqbHl4KNa+deJ1jAlbrjjfo4g7dlZnCR5LWQ7y0VDVczQ1R47brk5SwAlppuHf
 ONQde+bHGpq2nE4GvASA6SE1e/5mu9FJSmdB9Hy0c6GX9I9eL7+Vf0Ae5+sIbaWpVA
 Zz92+vH1Gxkbi1UqAW4My9lGP78guazQL5RihnMv0Zgse7rwabaTIQHQHxHMsEhBIv
 Le9W1txybFJjQ==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WxwwabC6zaor for <qemu-devel@nongnu.org>;
 Mon, 24 Aug 2026 02:34:14 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 77A4248006F
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:13 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/timer/xilinx_timer: Reload at the expiry
Date: Mon, 24 Aug 2026 02:34:05 +0200
Message-ID: <20260824003405.616297-3-sebastian.huber@embedded-brains.de>
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

The callback of a timer with the auto reload and hold bit set restarted
the count.  It restarted it at the moment the callback ran, so every
period gained the latency of the callback and the period moved with the
load of the host.

Run the ptimer in the periodic mode, so that it reloads at the expiry.
A write of the load register while the count runs sets the limit for
the next reload, which keeps the load value live.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/timer/xilinx_timer.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index dff439c623..7120c339ec 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -139,6 +139,14 @@ timer_read(void *opaque, hwaddr addr, unsigned int s=
ize)
     return r;
 }
=20
+static uint64_t timer_limit(struct xlx_timer *xt)
+{
+    if (xt->regs[R_TCSR] & TCSR_UDT)
+        return xt->regs[R_TLR];
+    else
+        return ~0 - xt->regs[R_TLR];
+}
+
 /* Must be called inside ptimer transaction block */
 static void timer_enable(struct xlx_timer *xt)
 {
@@ -149,12 +157,14 @@ static void timer_enable(struct xlx_timer *xt)
=20
     ptimer_stop(xt->ptimer);
=20
-    if (xt->regs[R_TCSR] & TCSR_UDT)
-        count =3D xt->regs[R_TLR];
-    else
-        count =3D ~0 - xt->regs[R_TLR];
+    count =3D timer_limit(xt);
     ptimer_set_limit(xt->ptimer, count, 1);
-    ptimer_run(xt->ptimer, 1);
+    /*
+     * The auto reload and hold bit makes the count periodic.  Let the p=
timer
+     * carry the period, so that it reloads at the expiry rather than wh=
en the
+     * callback runs.
+     */
+    ptimer_run(xt->ptimer, !(xt->regs[R_TCSR] & TCSR_ARHT));
 }
=20
 static void
@@ -195,6 +205,19 @@ timer_write(void *opaque, hwaddr addr,
             break;
         }
 =20
+        case R_TLR:
+            xt->regs[addr] =3D value;
+            /*
+             * A running periodic count takes the new load value at its =
next
+             * reload.
+             */
+            if (xt->regs[R_TCSR] & TCSR_ENT) {
+                ptimer_transaction_begin(xt->ptimer);
+                ptimer_set_limit(xt->ptimer, timer_limit(xt), 0);
+                ptimer_transaction_commit(xt->ptimer);
+            }
+            break;
+
         default:
             if (addr < ARRAY_SIZE(xt->regs))
                 xt->regs[addr] =3D value;
@@ -226,9 +249,6 @@ static void timer_hit(void *opaque)
     XpsTimerState *t =3D xt->parent;
     D(fprintf(stderr, "%s %d\n", __func__, xt->nr));
     xt->regs[R_TCSR] |=3D TCSR_TINT;
-
-    if (xt->regs[R_TCSR] & TCSR_ARHT)
-        timer_enable(xt);
     timer_update_irq(t);
 }
=20
--=20
2.51.0


