Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E943D3C921
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUz-00022u-L6; Sat, 19 Oct 2024 12:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUt-0001wf-QH
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:11 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUs-0003xH-4E
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:11 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id E1C79180379
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:59 +0200 (CEST)
Received: (qmail 9805 invoked by uid 990); 19 Oct 2024 16:39:59 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:59 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH v2 6/7] target/riscv: call plugin trap callbacks
Date: Sat, 19 Oct 2024 18:39:39 +0200
Message-ID: <4a0a1da117dcb66eb3050570869bedcfefb86100.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.969764) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.069764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=Wfx4XlJFAqOqDm2oM4VSKIM/3Bzy+eWnXxIR053cDbE=;
 b=GGpDg7Q2r5mudjMMjpc6s18O8YwbcCOPWTpTIc1spDDuSmgxYjTTZuoarql1YV+7Z/mFjM4k8S
 UL9re4W2/bDt4I4Vlbl8a/SKj0d0aRJySqIc+E85g6MI3/HhwP1FqOAoLgs4yWe4zRWlk1GU3XCg
 nphtdwZiloeeIQ3xtCjjtAwik6jueAOFgT+Q1TUrm8Oi3hG+xMUPALthdq5DjOkWReVvqqq/a99C
 bQAMXV3NrO/FRuRz7zrEWvDz8e4NnTxMZp8BoVlL8LmyUW9RFjYijaIEx5aWGIVbvcraIxYfr9Ip
 LQzpiydyOLb7x+cTdYtaW4xXIIn4AqZfguMe5wTQUZlyR1EL4ltxOrog04lax/SU6MIGwYISIyyg
 0lJIVa0vVKl2wZBsRWcSRKvnpv//U0l0htoo5/BxXA1l+9xuDI+mdWPw7+hTepob/ewsTBEP78uG
 z2K2D06E1OcrHIwqsyVNScsWCfxkdCggzSXyIxNPY6/WbWwF5XwJ8qnRyDcfBqdBAuPsJc0NFdtJ
 ntnZpFxZad14+f/w92ud5WB9TmDLz5G9MV5WBBikUljRwTqhpvXAB52eBU7jJOhdwXsKSyTNeYIb
 oKPMNGvEBrkdmplswB1gDi2x6VVxbxclmkV5nNxrLY6IzVs7cRdJIUq41oDDqW5owBPaBKae75ne
 8=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for RISC-V targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/riscv/cpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a935377b4a..2a95869339 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "qemu/plugin.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -1678,6 +1679,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
+            qemu_plugin_vcpu_semihosting_cb(cs);
             return;
 #endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -1839,6 +1841,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M, virt);
     }
 
+    if (async) {
+        qemu_plugin_vcpu_interrupt_cb(cs);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs);
+    }
+
     /*
      * NOTE: it is not necessary to yield load reservations here. It is only
      * necessary for an SC from "another hart" to cause a load reservation
-- 
2.45.2


