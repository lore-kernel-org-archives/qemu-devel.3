Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFE6D3C921
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUx-0001zp-EB; Sat, 19 Oct 2024 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUv-0001yu-Dp
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:13 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUt-0003zY-Qr
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:13 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 31DDF17F810
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:40:00 +0200 (CEST)
Received: (qmail 9824 invoked by uid 990); 19 Oct 2024 16:40:00 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:40:00 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH v2 7/7] target/sparc: call plugin trap callbacks
Date: Sat, 19 Oct 2024 18:39:40 +0200
Message-ID: <baadbcc7a25a0d5c7428482673a61a422e96c289.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.994807) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.594807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=0DIXz22ZQVybjpDzj+NirHJXZfr6QSriqPOofdXhjlE=;
 b=lzCnfXIllGcULlYAEBS9aQbHYKtUBBQmsR6BkMlfr208O3+okvULCTX8gFPY1OawgtFs5EGfAQ
 XHsHCAMXkDrbe9OTL4IiCQL4Tbd9/apwL048msbHroiHHzlxr3997HSsgirZo1TXoXtqJbFU9SoB
 3M2vxSoqDwTGmql4NyGwY5i1EdgGWpOnRHnYO8/cV6QQ0qXRyQO529FbsKEFZFsY1eo0Ai1eJMcf
 bPmJHoMjagBYqOMVxOrBYrA5iR6lv3kxBMIbKPb4hd3SPt7kQzPZPKFpgwxgQFTsHIBFrr/mFDQw
 HcM8gS84jLvja9Tx1+sY5DfB9d0UBR3fA9wh/HYUXAtgVhE0WtfiWWpwD6ehNa8HsjVhRWVcALuf
 6RXboiSasx4t7pQqadXFzpEb7cKcDOP289QzWp9xzX12iThtTyspC0B+hQsoj4IXqURPWvI7pGzq
 4vYF/QiczlD0gaLNIGFvTHB3Gyq2fP5gfF0pTqgzr0mS26oynbsQbSUx1m2cU9YmBkRRdPXHw5+X
 Zdl4CMIDQC3H1Hf9z1aJiLILsEgDfQOxdVc6YGiyNHAqT+LX9ZbNwD1Dd0j7JJbBy+pZIb3dVvqJ
 DgIQy5hcXkV4JM79PjAx31IvaSf18AcA2E9ObNu4ZZ3WCSt7dgMV4MAxx3JvPnQd12GxgyYBE+Kp
 s=
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

This change places hooks for SPARC (32bit and 64bit) targets. We treat
any interrupt other than EXTINT and IVEC as exceptions as they appear to
be synchroneous events. Also note that SPARC targets do not have
semihosting events.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/sparc/int32_helper.c |  7 +++++++
 target/sparc/int64_helper.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index f2dd8bcb2e..4eb41694f7 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -24,6 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "sysemu/runstate.h"
+#include "qemu/plugin.h"
 
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
@@ -172,4 +173,10 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         env->qemu_irq_ack(env, intno);
     }
 #endif
+
+    if (intno == TT_EXTINT) {
+        qemu_plugin_vcpu_interrupt_cb(cs);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs);
+    }
 }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index bd14c7a0db..f4175ef912 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
+#include "qemu/plugin.h"
 
 #define DEBUG_PCALL
 
@@ -253,6 +254,15 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     }
     env->npc = env->pc + 4;
     cs->exception_index = -1;
+
+    switch (intno) {
+    case TT_EXTINT:
+    case TT_IVEC:
+        qemu_plugin_vcpu_interrupt_cb(cs);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs);
+    }
 }
 
 trap_state *cpu_tsptr(CPUSPARCState* env)
-- 
2.45.2


