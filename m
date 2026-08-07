Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E08C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKbP-00018z-Qy; Fri, 07 Aug 2026 09:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbI-00015x-IB
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:07 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbH-0007hU-43
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:04 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EC8A436BB;
 Fri,  7 Aug 2026 13:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2E61F000E9;
 Fri,  7 Aug 2026 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786109222;
 bh=RrMYKTvmx3jhoSITMt71yGt3H0mvNwE3sRAvOwuYlR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BJf3f3Pn5XgXBhC9xNcfpoSY5oK7aNsvKZGkwNSLflG79JfV8IbLVkv3FlWpfSdrM
 ypW7MOdsQRCwI14wQxn2c89j1snzyBBADY+3UmDU3jkbCnVoTXJxCMAEbGbwHR4rT8
 kZlBB4nIzlrV1N5XsZfGXqcr7rB4rM3LeA2XxdYIoq1Gd3sGz6ME+ArfuU54oRzjeS
 6J6pLjvdGkGu1LHOkJ4OMgJ/4m9osfJb3zlzbmKwl9azz4xdD20QcXPexKatlr7VDk
 Wh+uouM8eMTAmHAI5cRGEGnbTIPPgbcVjyq+vQL4DlgS9cnjPjbi+6/+1dtPA7Mcdw
 /+LbruHq7UJ7g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, deller@gmx.de,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PULL 3/3] linux-user/sh4: Fix crashes on signal delivery in
 conditional delay slot
Date: Fri,  7 Aug 2026 15:26:52 +0200
Message-ID: <20260807132652.9687-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807132652.9687-1-deller@kernel.org>
References: <20260807132652.9687-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/sh4/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 7f246e750d..047174ac8f 100644
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
2.54.0


