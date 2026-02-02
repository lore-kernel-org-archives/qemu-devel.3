Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2CCE7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14B-00054H-A8; Mon, 02 Feb 2026 16:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn13S-0002ak-Me; Mon, 02 Feb 2026 16:01:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn13Q-0004WJ-W9; Mon, 02 Feb 2026 16:01:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 723AC1851B0;
 Mon, 02 Feb 2026 23:57:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3BF4835B327;
 Mon, 02 Feb 2026 23:58:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 36/74] m68k: fix CAS2 writeback when Dc1==Dc2
Date: Mon,  2 Feb 2026 23:57:47 +0300
Message-ID: <20260202205833.941615-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Laurent Vivier <laurent@vivier.eu>

According to Programmer's Reference Manual, if Dc1 and Dc2 specify the
same data register and the comparison fails, memory operand 1 is stored
in the data register.

The current helpers wrote Dc1 then Dc2, leaving operand 2 in the shared
register.

Swap the writeback order for cas2w/cas2l so memory operand 1 wins.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251226213707.331741-1-laurent@vivier.eu>
(cherry picked from commit 11dac41f2e830bcd7ba74969dc50f5740e3ce7e7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index f29ae12af8..b40cc02c65 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -777,8 +777,8 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
         env->cc_v = c2;
     }
     env->cc_op = CC_OP_CMPW;
-    env->dregs[Dc1] = deposit32(env->dregs[Dc1], 0, 16, l1);
     env->dregs[Dc2] = deposit32(env->dregs[Dc2], 0, 16, l2);
+    env->dregs[Dc1] = deposit32(env->dregs[Dc1], 0, 16, l1);
 }
 
 static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
@@ -839,8 +839,8 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
         env->cc_v = c2;
     }
     env->cc_op = CC_OP_CMPL;
-    env->dregs[Dc1] = l1;
     env->dregs[Dc2] = l2;
+    env->dregs[Dc1] = l1;
 }
 
 void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
-- 
2.47.3


