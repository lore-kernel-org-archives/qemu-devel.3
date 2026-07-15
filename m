Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE559C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4xm-0003ol-Jw; Wed, 15 Jul 2026 15:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wk4xW-0003j7-P2; Wed, 15 Jul 2026 15:07:55 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wk4xT-0001ny-Vu; Wed, 15 Jul 2026 15:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784142462;
 bh=+vKy8MiHmYIZI5UzqtedK/LGUsUPhC813vzPB9twwY0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0la+hFKxBff9to33f0ej8Bj3iXKw6cBrg32EVeVEUW4NHq4QsZz8leO2zakzBQurv
 M3dai0K1wywmtkPPTok6qutPJ1Ug4hJpTI159MhLlQTiGhHBqFGxfD3iBUPuXHniEC
 fYG8UZ2L0d5kWWpGo2Nfd66xE57AhOcuN/f/9i8YMD133Spv721SpvedbvZxUlXyYX
 3b62u6hfmVWcW+RbRib2tBPyfyQAja4nqhdAlWOSQ/t3XXI0fZM64gmUHTxdsz3BVR
 vP4Km/0cCSKoEjDQzw4uR6udZWzU3eLfqUKRyHdi1yeqx1rVG2DDKc/3bSh5bcnxPu
 v5XdPqJdXWGnQ==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id CA8D64023B;
 Wed, 15 Jul 2026 21:07:42 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id C6A74FF861;
 Wed, 15 Jul 2026 21:07:42 +0200 (CEST)
Received: from naga.. (unknown [78.243.103.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 0A766400E7;
 Wed, 15 Jul 2026 21:07:41 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 1/3] disas/riscv.c: Correct wrong shifts for cbo
Date: Wed, 15 Jul 2026 21:07:35 +0200
Message-ID: <20260715190737.1381701-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
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

Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 disas/riscv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..490bda8e56 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2889,8 +2889,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2:
                /*
                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                * with 'cbo' insns.  Check the next 5 bits to select
-                * what we want:
+                * with 'cbo' insns.
                 *
                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
@@ -2899,7 +2898,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 *
                 * Anything that doesn't match these will default to 'lq'.
                 */
-               switch ((inst >> 17) & 0b11111) {
+               switch (inst >> 20) {
                case 0: op = rv_op_cbo_inval; break;
                case 1: op = rv_op_cbo_clean; break;
                case 2: op = rv_op_cbo_flush; break;
-- 
2.43.0


