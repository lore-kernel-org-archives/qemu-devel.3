Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 19:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxuHG-0004U5-Nb; Fri, 19 Apr 2024 15:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxuHF-0004Tb-0e
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:52:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxuHA-0004q4-Lp
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ORrWk6OZBCnrD3OWSoi1f9pNjLtL8H1wx40T95LWl4Q=; b=1goBwYmGmEpxUAOzeAAyVaSUGS
 Hclesiz4r7Owp2ndb0RGXzA1cqUzIz6Xv7OvRmngvJhVGEMymV/Hw+xB/gCThGtHNzXkqyQO/O6R8
 u9/8J7T5AnQsYScfip8dZYBqarPbyKZQhNUZkilENZ6IGHT3vf95/Tu2jUg2C1Yg9kFCY38RsV6qN
 m9IAS2DViTtdXWmI5ePPOTfrC1ABOjb+a7ppxzKazHtEz2+YIecw4xTVkmgwyrEayHSKa0rWGwIrp
 93HxbZu3cTwfIdkfoiRXkaP+m/Bss3RYguwolwbjmjzzVbDkNATJPod7q2eU93WBfw6jzA4+g7q5r
 lxe3oJqZMIQw3qMYoOpYdt51Bmim9YG069Pq1RDYLkzJ/IayDkNMXgkPpjtxTt7aLUaG5eRYup9nQ
 ZlYLs7D250HFIA4LwKlY3gosea2scIi3zWIjPK95/KY1by//EGLjowc9VKPz1KSjSbinWNEDgDh0H
 KV5rr8aW2RhOQby4AJnrNwZc8C8owrrtA3lC/aCe6B9f1pmFWsHA20RY7VDWOoOlKAe49fU9jRumY
 8qBN2+CJD+9/pAEXa9wFKyGG39I7faeulnxhz76BwRm0IzRMoD8rzW+MMgOhzUlVtZmhmcHqY2Oxa
 ARWvqs6qE1PlC//19Wb9eUIWVqr2ouYMd0MmF5qnE=;
Received: from [2a00:23c4:8bb4:4000:a36d:d178:601a:c356]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxuG3-00050p-7H; Fri, 19 Apr 2024 20:50:55 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org
Date: Fri, 19 Apr 2024 20:51:47 +0100
Message-Id: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a36d:d178:601a:c356
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] target/i386/translate.c: always write 32-bits for SGDT and
 SIDT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

The various Intel CPU manuals claim that SGDT and SIDT can write either 24-bits
or 32-bits depending upon the operand size, but this is incorrect. Not only do
the Intel CPU manuals give contradictory information between processor
revisions, but this information doesn't even match real-life behaviour.

In fact, tests on real hardware show that the CPU always writes 32-bits for SGDT
and SIDT, and this behaviour is required for at least OS/2 Warp and WFW 3.11 with
Win32s to function correctly. Remove the masking applied due to the operand size
for SGDT and SIDT so that the TCG behaviour matches the behaviour on real
hardware.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198

--
MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed that this
patch fixes the issue in WFW 3.11 with Win32s. For more technical information I
highly recommend the excellent write-up at
https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
---
 target/i386/tcg/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76a42c679c..3026eb6774 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, gdt.base));
-            if (dflag == MO_16) {
-                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
-            }
+            /*
+             * NB: Despite claims to the contrary in Intel CPU documentation,
+             *     all 32-bits are written regardless of operand size.
+             */
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             break;
 
@@ -5901,9 +5902,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, idt.base));
-            if (dflag == MO_16) {
-                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
-            }
+            /*
+             * NB: Despite claims to the contrary in Intel CPU documentation,
+             *     all 32-bits are written regardless of operand size.
+             */
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             break;
 
-- 
2.39.2


