Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6D5C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOJN-0004Ub-26; Thu, 16 Jul 2026 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIg-00049F-I9; Thu, 16 Jul 2026 11:47:07 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIa-0002NJ-Um; Thu, 16 Jul 2026 11:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784216808;
 bh=rslQ9alLFFA5W9cWtD262id/j27w+aRzGV3v6dT27ao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gQRX3snJ1my8Uqw2sko5JBmqR5h0/80oYhkos5OM8BNgYSfznviK+/bOEUg9u69qU
 9u+BcGM/w8bWMnk09uljyw4Dg6rwAsgOdXT4lyV9JZKzgKbX0ThLLFatSKNEYgLFcW
 1SbyXhCCQwN7U3vyB2RWMu9zsNOmMwid7/48aALhLh34SVN+noMLEaO+2H0rzOilWx
 R5M9npOcOqdkmzdQFNIGgY576zvkCdHQtjKHIvrjq8EZ+bjRqv3wB1dsoG8GXpk3jx
 M8hMZsP48Ovh2YrNuHIDmZRxp7tAbYssjZQstm5TyM+57jWAuv/5FBlDrrWii0qtSf
 6pcBpAzlbqbrw==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id D607240297;
 Thu, 16 Jul 2026 17:46:48 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id D1B88FF85F;
 Thu, 16 Jul 2026 17:46:48 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id AA2E7400E7;
 Thu, 16 Jul 2026 17:46:48 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 2/3] disas/riscv.c: Correct wrong shifts for cbo
Date: Thu, 16 Jul 2026 17:46:14 +0200
Message-ID: <20260716154615.1545145-3-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The cache block operations are specified on bits 31:20, but for
some reason a shift of 17 and a 5 bit masking were performed.
Make this a raw shift of 20 prior to test for the cbo operation.

Fixes: 9273cda722 ("disas/riscv.c: add 'cbo' insns to disassembler")
Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 disas/riscv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 689502f083..b32a040745 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2889,8 +2889,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2:
                 /*
                  * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                 * with 'cbo' insns.  Check the next 5 bits to select
-                 * what we want:
+                 * with 'cbo' insns.
                  *
                  * cbo_inval  0000000 00000 ..... 010 00000 0001111
                  * cbo_clean  0000000 00001 ..... 010 00000 0001111
@@ -2899,7 +2898,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                  *
                  * Anything that doesn't match these will default to 'lq'.
                  */
-                switch ((inst >> 17) & 0b11111) {
+                switch (inst >> 20) {
                 case 0: op = rv_op_cbo_inval; break;
                 case 1: op = rv_op_cbo_clean; break;
                 case 2: op = rv_op_cbo_flush; break;
-- 
2.43.0


