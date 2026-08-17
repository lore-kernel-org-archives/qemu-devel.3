Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5344DC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtI2-0003IG-EV; Mon, 17 Aug 2026 05:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHo-0003Er-DD; Mon, 17 Aug 2026 05:05:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHk-0001cK-PC; Mon, 17 Aug 2026 05:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=YTI+OSziWNCvE0kFhsSMYplW9R3tAXytFe27FSTdG0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uQiNtPq7Ac7ICB/nMzIVifE6ZCd8lvxZzp4yGuKxVlex4DgjFc/FBp+d03KPThFys
 Nu2YfxcbHzWU/2nTZ8adgBan4FBff8fee1WTbYr/Yct4neybc+rNYIcscexkgrP0nn
 H6TzTRj/VEp5ZiKVJjpnXXmScDTKHQPlWSVJTgjDzvQLhQp2MQ6FTj+emYc33Uj42L
 nNZFgOL7pc2UtSzXPTztXJnyHQIxpVPudIEYnsPYC3wOUmL3EZ14S7F9mhzNskZVwB
 8yXwsVaMbkqpBm4tPOuDrn8jwMZyEl7ttqkymJLQvKkNlKwjczKeRlPF5LbZ0Tjv+Q
 p9qoWfd/Y3QHQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B22B1CBA37;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE3E340D019;
 Mon, 17 Aug 2026 12:05:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A726830CE6; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 03/42] linux-user/sh4: Fix crashes on signal delivery
 in conditional delay slot
Date: Mon, 17 Aug 2026 12:04:08 +0300
Message-ID: <20260817090453.2034156-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Mikulas Patocka <mpatocka@redhat.com>

If we get a signal in the delay slot, we must roll-back the PC to the
jump instruction. This was already fixed by the commit 3b894b699c9a
("linux-user/sh4: Fix crashes on signal delivery"), however this fix
omits a test for TB_FLAG_DELAY_SLOT_COND. TB_FLAG_DELAY_SLOT_COND is set
by the conditional delayed branches bf/s and bt/s. Qemu did not roll-back
the PC in this case, resulting in incorrect program execution.

This patch fixes it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit f7ad7b1f8c8148f39bc1f2c984bfc7b7c9c59041)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 7f246e750d0..047174ac8f3 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -109,7 +109,7 @@ static void unwind_gusa(CPUSH4State *regs)
            the SP, otherwise we would be pushing the signal context to
            invalid memory.  */
         regs->gregs[15] = regs->gregs[1];
-    } else if (regs->flags & TB_FLAG_DELAY_SLOT) {
+    } else if (regs->flags & (TB_FLAG_DELAY_SLOT | TB_FLAG_DELAY_SLOT_COND)) {
         /* If we are in a delay slot, push the previous instruction.  */
         regs->pc -= 2;
     }
-- 
2.47.3


