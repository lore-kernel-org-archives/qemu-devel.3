Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C5DC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOJL-0004Rw-84; Thu, 16 Jul 2026 11:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIj-00049V-Ef; Thu, 16 Jul 2026 11:47:07 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIh-0002Ny-5t; Thu, 16 Jul 2026 11:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784216817;
 bh=222PKS7W3N4GNn4iMmnFhJO/JpIslbGJc2peC8KZ+3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=4HJthci8um1XpVvaqDsk104V+Eytiwc8vaTFAIPMaP7rrRxmClQE+KsLZ3h2dYe0Y
 UQy5Z+2MEr1x3kKDhaYma4dmqnB7tA8mw+86wS5whwORQ8vm5K8pXO72SjRNUSbrGk
 MeBrjiw+6CWxAqECG9xXZlTKzjUrI8ImPR0u7l8lRyoVE03b+4QlpVtmcHOqnAMW1n
 QNmkyEyiy3KgjUL8z5OfuYcVphDfn5t9IJMlq087lnhwl950Mg7GdHmEJ7x0OqnI0V
 kQXTlcyIiTTVjgfQnV/rzVGeP8VYzyLsYSdkHTTByMQAFy1UqQtHFVQz/YqJQCxlXL
 swx2R40N8DBWg==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 493A840290;
 Thu, 16 Jul 2026 17:46:57 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 44EBDFF85F;
 Thu, 16 Jul 2026 17:46:57 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 1BF45400E7;
 Thu, 16 Jul 2026 17:46:57 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 3/3] disas/riscv.c: Correct disasm of lq
Date: Thu, 16 Jul 2026 17:46:15 +0200
Message-ID: <20260716154615.1545145-4-frederic.petrot@univ-grenoble-alpes.fr>
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

Lq shares the cmo opcode space, but the cbos must have rd = 0.
Now ensure that they are matched only in that case.
This implies that lq can be recognized as such only when rd != 0.
Update the decoder file accordingly.

Fixes: 9273cda722 ("disas/riscv.c: add 'cbo' insns to disassembler")
Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 disas/riscv.c              | 19 ++++++++++---------
 target/riscv/insn32.decode |  2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index b32a040745..27bf4d9954 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2889,21 +2889,22 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2:
                 /*
                  * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                 * with 'cbo' insns.
+                 * with 'cbo' insns, but assumes rd != 0.
                  *
                  * cbo_inval  0000000 00000 ..... 010 00000 0001111
                  * cbo_clean  0000000 00001 ..... 010 00000 0001111
                  * cbo_flush  0000000 00010 ..... 010 00000 0001111
                  * cbo_zero   0000000 00100 ..... 010 00000 0001111
-                 *
-                 * Anything that doesn't match these will default to 'lq'.
                  */
-                switch (inst >> 20) {
-                case 0: op = rv_op_cbo_inval; break;
-                case 1: op = rv_op_cbo_clean; break;
-                case 2: op = rv_op_cbo_flush; break;
-                case 4: op = rv_op_cbo_zero; break;
-                default: op = rv_op_lq; break;
+                if ((inst >> 7) & 0b11111) {
+                    op = rv_op_lq;
+                } else {
+                    switch (inst >> 20) {
+                    case 0: op = rv_op_cbo_inval; break;
+                    case 1: op = rv_op_cbo_clean; break;
+                    case 2: op = rv_op_cbo_flush; break;
+                    case 4: op = rv_op_cbo_zero; break;
+                    }
                 }
             }
             break;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 21272fdb50..aa02dae3c9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -216,6 +216,8 @@ ldu      ............   ..... 111 ..... 0000011 @i
   ]
 
   # *** RVI128 lq ***
+  # *** Catches an lq with rd = 0, which we disallow
+  illegal  ------------   ----- 010 00000 0001111
   lq       ............   ..... 010 ..... 0001111 @i
 }
 sq       ............   ..... 100 ..... 0100011 @s
-- 
2.43.0


