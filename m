Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9ob-0000Iv-Ms; Thu, 06 Jun 2024 05:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oa-0000D6-2s
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oY-0002Hp-Jy
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=g1XyuWsPbbTNoYfpRGNg+VmdmBlVjoFl9YL7pF0DpnY=; b=tZf+Uq/HAvyiGCjExSc+yrnyqS
 YqjYKKGE17c8mrxUSdeBfFIwi7naqptP7tUt82Js1iOa7qVgBalqWy1r0fFEA3zDRbF6iCG/gXCAb
 fN7BVae7EUz9Tn+UkR5a5EsqOKpV+FkrJ3ONm1VA5fKwxjgNRrxpeefEIdJuoX/EThwyE6APvVlJ6
 5SNzGqsy+e/Qj1+EaAnSVHqNhu6yvxx0jTivM/a8YHB3FaY+sJjYitpLKq5oZwwTEcoTIlPJ8kX7u
 bed28VuQwCyLr4dT++Yz/TJf3HwEfv0k4Ba19q03zAeuDh2ZYNTM/PWXrdOenS1vsDLmPl2wIT83h
 ozP3w8nHwUEpeGupuqqpR20q2rdGKURqzTiLSdcvEx2WM0KhGvYMpmpbU263j/f5qTrHkEu0YvYZB
 nv4Y7Qc3Pilad7VpE6dcaQakgPteeHdXfuSF9VOvOHrlGjMBr6SHkgKvOeodTV0jhiM/vYrel4VtQ
 Id3z3FLmWmJP4jbZSmBg1acps5NGofbhcm+6GDZ1rubOa4azof4KrOvP3H9JYMF+8IWYrd/tnvUGF
 PMrMaB1ixP2NOPhQL24FgbQ9BJmurdARzCGRDBuLz0x/kcuik6yptPX1qfBJBQdQkTZeVRnuFt1Ef
 Cvq5JxRo4ETMc26dQqkEwcdvocPJKjeuClL7G3Z/I=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9nF-0004cT-Sm; Thu, 06 Jun 2024 10:52:30 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2024 10:53:19 +0100
Message-Id: <20240606095319.229650-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
References: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/4] target/i386: fix size of EBP writeback in gen_enter()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The calculation of FrameTemp is done using the size indicated by mo_pushpop()
before being written back to EBP, but the final writeback to EBP is done using
the size indicated by mo_stacksize().

In the case where mo_pushpop() is MO_32 and mo_stacksize() is MO_16 then the
final writeback to EBP is done using MO_16 which can leave junk in the top
16-bits of EBP after executing ENTER.

Change the writeback of EBP to use the same size indicated by mo_pushpop() to
ensure that the full value is written back.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0486ab6911..0716ca35d5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2125,7 +2125,7 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     }
 
     /* Copy the FrameTemp value to EBP.  */
-    gen_op_mov_reg_v(s, a_ot, R_EBP, s->T1);
+    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T1);
 
     /* Compute the final value of ESP.  */
     tcg_gen_subi_tl(s->T1, s->T1, esp_addend + size * level);
-- 
2.39.2


