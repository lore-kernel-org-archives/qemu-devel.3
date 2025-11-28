Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FAAD116F6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 08:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOtYc-00070s-38; Fri, 28 Nov 2025 03:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vOtYJ-0006sP-4l; Fri, 28 Nov 2025 03:10:04 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vOtYG-00035a-5H; Fri, 28 Nov 2025 03:10:02 -0500
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 5AS89YGl009063
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Nov 2025 16:09:34 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 28 Nov 2025 16:09:34 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <vivahavey@gmail.com>, Alvin Chang
 <alvinga@andestech.com>, Yu-Ming Chang <yumin686@andestech.com>
Subject: [PATCH] target/riscv: Fix index of fired breakpoint and watchpoint
Date: Fri, 28 Nov 2025 16:09:28 +0800
Message-ID: <20251128080928.3160155-1-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5AS89YGl009063
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The do_trigger_action() receives index of fired trigger as second
parameter. However, in current implementation, the argument is hardcoded
as DBG_ACTION_BP which is 0. This is a bug because we may match/fire any
breakpoints or watchpoints at other index than 0.

Fix this bug by iterating cpu_breakpoint[] and cpu_watchpoint[] to
compare and match necessary checkpoints. The index of the fired
cpu_breakpoint or the cpu_watchpoint is the index of the trigger we want
to provide to do_trigger_action().

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
---
 target/riscv/debug.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466..f3bca8e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -929,11 +929,24 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
 
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
-            do_trigger_action(env, DBG_ACTION_BP);
+            /* Search fired trigger and do its action */
+            for (int i = 0; i < ARRAY_SIZE(env->cpu_watchpoint); i++) {
+                if (cs->watchpoint_hit == env->cpu_watchpoint[i]) {
+                    do_trigger_action(env, i);
+                    break;
+                }
+            }
         }
     } else {
         if (cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
-            do_trigger_action(env, DBG_ACTION_BP);
+            /* Search fired trigger and do its action */
+            for (int i = 0; i < ARRAY_SIZE(env->cpu_breakpoint); i++) {
+                CPUBreakpoint *bp = env->cpu_breakpoint[i];
+                if (bp && bp->pc == env->pc && (bp->flags & BP_CPU)) {
+                    do_trigger_action(env, i);
+                    break;
+                }
+            }
         }
     }
 }
-- 
2.43.0


