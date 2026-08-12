Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14C8C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAV6-0000oO-2i; Wed, 12 Aug 2026 11:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuATK-0005NE-To; Wed, 12 Aug 2026 11:02:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuATI-0002d3-7y; Wed, 12 Aug 2026 11:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546234; bh=YTI+OSziWNCvE0kFhsSMYplW9R3tAXytFe27FSTdG0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p7T66Kyd8M10dzVQrd+V7eaa0Akb8WiHS20Jz+5ODSPLIRjV8xdn3M3ptDsCfgc6M
 bXfsK25RsF5KzCtwW2LR7TUiOFgCnKKbyHXaVX/qBbtM6VP34xGfuJ/C25FouU4NNZ
 b+VpQVlcRDAsYe9G9Yl7DZbNQJb3/3FxUIobKhTO88jUXk5bV94MSqraKdgzQBFM/3
 3FKOWg8vpr4VB+8i/E+ezfUbTANnJrtbWoKO7BEj2Ez1E6E3B4wfSXD6ASnC9EIqR5
 PkHKkrsfcQSfLIBnhV8LlcsFaj2voTCNp5G6X5d5Hfk/TRwtYor3SqIaflHyVTOMHl
 R40PTj0D1YVsg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 305811CA67B;
 Wed, 12 Aug 2026 17:50:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8B4FA409DC3;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EB82A2FA51; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 119/120] linux-user/sh4: Fix crashes on signal
 delivery in conditional delay slot
Date: Wed, 12 Aug 2026 17:49:42 +0300
Message-ID: <20260812144955.649205-119-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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


