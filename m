Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDCEC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4xe-0003mG-L0; Wed, 15 Jul 2026 15:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wk4xW-0003j5-LT; Wed, 15 Jul 2026 15:07:55 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wk4xS-0001o5-7Z; Wed, 15 Jul 2026 15:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784142463;
 bh=cIoCa6uQAskBje+hAP7eqP57YaZpyMwGxTDnEkEojM4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p7l56AAIfAFI3e9ylHei1rcvX68uRic+ZSNwKafn0ZEePolFlEq40q3WeFOUKR8jR
 gVPne+vvk2YlJe+uDICow7wZObozV5H++qsu3Yl7o0bJbxOZpZoIwkYSZDpYl13BOs
 S/U5WzOaLcR7M+0GkqlR4aWT59X0RK6jEoRdRxJn+katXz0oCuGd4Gz1YBKTZuBQ+Y
 7JhhOWRZjdEfebG6UNL/RBBofTw2uQiqF8ZuTfo5PEY8Arp9O/5P3iBboD3aoC/ohc
 mU1B8jFCJ25Yl7GpZvKMUghXmdoibcKdakWWmosRqV3q7bfvPvVidDaJVbx7v4fBpy
 tMIYBcI4uePZg==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id AB5CF4023C;
 Wed, 15 Jul 2026 21:07:43 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id A7013FF861;
 Wed, 15 Jul 2026 21:07:43 +0200 (CEST)
Received: from naga.. (unknown [78.243.103.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id E15D3400E7;
 Wed, 15 Jul 2026 21:07:42 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 2/3] disas/riscv.c: Correct disasm of lq
Date: Wed, 15 Jul 2026 21:07:36 +0200
Message-ID: <20260715190737.1381701-3-frederic.petrot@univ-grenoble-alpes.fr>
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

Lq shares the cmo opcode space, but the cbos must have rd = 0.
Now ensure that they are matched only in that case.
This implies that lq can be recognized as such only when rd != 0.
Update the decoder file accordingly.

Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 disas/riscv.c              | 19 ++++++++++---------
 target/riscv/insn32.decode |  2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 490bda8e56..831ff526ad 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2889,21 +2889,22 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2:
                /*
                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                * with 'cbo' insns.
+                * with 'cbo' insns, but assumes rd != 0.
                 *
                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
-                *
-                * Anything that doesn't match these will default to 'lq'.
                 */
-               switch (inst >> 20) {
-               case 0: op = rv_op_cbo_inval; break;
-               case 1: op = rv_op_cbo_clean; break;
-               case 2: op = rv_op_cbo_flush; break;
-               case 4: op = rv_op_cbo_zero; break;
-               default: op = rv_op_lq; break;
+               if ((inst >> 7) & 0b11111) {
+                  op = rv_op_lq;
+               } else {
+                  switch (inst >> 20) {
+                  case 0: op = rv_op_cbo_inval; break;
+                  case 1: op = rv_op_cbo_clean; break;
+                  case 2: op = rv_op_cbo_flush; break;
+                  case 4: op = rv_op_cbo_zero; break;
+                  }
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


