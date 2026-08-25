Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B6FC61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyo61-000323-U4; Tue, 25 Aug 2026 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wyo60-00031b-LK; Tue, 25 Aug 2026 06:09:32 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wyo5y-0002g2-OU; Tue, 25 Aug 2026 06:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787652568;
 bh=V7xWE/MO0+j9X5KVbBLBbazluYuQy+pYibiRpxq9GZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oBdKL2pFOV6sbAqragzXU7uE/ehxzTcb4fJtUcf8/+xV/lZgnPLEWmKIOWYRfHGul
 qjHMXBPjDfpC+JlN4r8NeI8QjKagRGmPXi3V6Q/M8HfX3Mq+VhQ4T9ISxMawHMmDKq
 Eq6aYJA8wJSMPdsyruZI8hirntYx4tPDiusnHbkVQbrbFctEgJCi2rnhA+B3ppcL50
 ti31jd/WwJpOWMn/fDw+9zjZw283I910RryUz15eP88Z+DTRSWzcCLfgIZIek8JJb7
 R7y0oSc5wAfdMEwHlr5zDWH8JuWiS3w4syc3ucG/BdmmGboDyrOR+xeKDgLNCawiNi
 JJvcz13ds97Kg==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 0A15A4026E;
 Tue, 25 Aug 2026 12:09:28 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 05BF1FF85D;
 Tue, 25 Aug 2026 12:09:28 +0200 (CEST)
Received: from naga.. (pers-185-231.vpn-inp.grenoble-inp.fr [147.171.185.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id C617014004C;
 Tue, 25 Aug 2026 12:09:27 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
Subject: [PATCH v3] disas/riscv.c: Correct dasm for cbo and lq
Date: Tue, 25 Aug 2026 12:09:22 +0200
Message-ID: <20260825100922.387919-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825100922.387919-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260825100922.387919-1-frederic.petrot@univ-grenoble-alpes.fr>
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
 disas/riscv.c              | 20 +++++++++++---------
 target/riscv/insn32.decode |  2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index b8099cbdf8..e85dbac035 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1281,22 +1281,24 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2:
                /*
                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                * with 'cbo' insns.  Check the next 5 bits to select
-                * what we want:
+                * with 'cbo' insns.
                 *
                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
                 *
-                * Anything that doesn't match these will default to 'lq'.
+                * lq matches when rd != 0
                 */
-               switch ((inst >> 17) & 0b11111) {
-               case 0: return &op_cbo_inval;
-               case 1: return &op_cbo_clean;
-               case 2: return &op_cbo_flush;
-               case 4: return &op_cbo_zero;
-               default: return &op_lq;
+               if ((inst >> 7) & 0b11111) {
+                   return &op_lq;
+               } else {
+                   switch (inst >> 20) {
+                   case 0: return &op_cbo_inval;
+                   case 1: return &op_cbo_clean;
+                   case 2: return &op_cbo_flush;
+                   case 4: return &op_cbo_zero;
+                   }
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


