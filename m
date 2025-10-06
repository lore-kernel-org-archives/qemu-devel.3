Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335F3CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyr-0006an-I7; Mon, 06 Oct 2025 05:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyp-0006Z5-CL
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:58:07 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hym-0003r1-IE
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:58:06 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 4C28D60BDB
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:43 +0200 (CEST)
Received: (qmail 18918 invoked by uid 990); 6 Oct 2025 09:57:43 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:43 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v7 20/25] target/sparc: call plugin trap callbacks
Date: Mon,  6 Oct 2025 11:57:15 +0200
Message-ID: <ca4b47c5db3ff41c1b846b22d921f23a544fca4c.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99945) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=XmfQC1pUHdirPeAvXHEzNtY0D5FB5BhCt4uiwodl8Ho=;
 b=eZWvw4PKS75E2t6SedZ8nVvv8oQN6WB/8q7FcVz33U01fUyEryO7DiPTfMla0EBAkd4JCm+9qm
 VI28lw8py49szgYB9DIQRahVO2L47rPb5fol//I9KQI5o4rglQTiR2U3YGil6XrcRb66hD3Ao++p
 weAq8QlZQF1aV8XXSP6cfhwKiTMsHA7h0mHs9/kaAtIDvXeOV87A9bKYD0Taw/znfw8qZ6dO9vCZ
 2eMADywdtmaBupDemrBZ3irxxPyk608SkNjkJ2q8Uu8egQzXg0ME/bQGYDG2xZK2zivo4IdzcIGe
 xzkOoia/zBQRDMRtqLhHBJqLm75PX4Ctfxr44V/EMDX1WvyPQhmBd4+XjnwAoY0scsdq15BAcHDf
 CZUlJPg733JHtTj3b9+91C2BK5lMP5IT6mH0jGhW/DgV+8tA0RobnW1EoO7AW5ILI0C/bihAipcR
 1Ejxuwz1DQlGSQGMdDT7Q+fUhzWwrxQIqnhcJhwcqW7OVT3tfOnflYWfMr2GNArt3uGl3f66QrsE
 P5kRpAMNZzVLkm5vTtV8CosgYPQ2DGbUoLE2FYmlOtdTV6sJHw1eXLvISI27MzDnT9ZmBRF1B/vh
 k3iyV7APME4jUC6Vf1ALGzgXyuDG1hNw0Ct+zNZO48WUa8FNNvguI2IEWxDhG9Mdwl7A2c1rt4B9
 o=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
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
be synchroneous events.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/sparc/int32_helper.c |  7 +++++++
 target/sparc/int64_helper.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index fdcaa0a578..b29f693a6b 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -24,6 +24,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "system/runstate.h"
+#include "qemu/plugin.h"
 
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
@@ -174,4 +175,10 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         env->qemu_irq_ack(env, intno);
     }
 #endif
+
+    if (intno == TT_EXTINT) {
+        qemu_plugin_vcpu_interrupt_cb(cs, env->regwptr[9]);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, env->regwptr[9]);
+    }
 }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 23adda4cad..067d936cbd 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
+#include "qemu/plugin.h"
 
 #define DEBUG_PCALL
 
@@ -255,6 +256,15 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     }
     env->npc = env->pc + 4;
     cs->exception_index = -1;
+
+    switch (intno) {
+    case TT_EXTINT:
+    case TT_IVEC:
+        qemu_plugin_vcpu_interrupt_cb(cs, tsptr->tpc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, tsptr->tpc);
+    }
 }
 
 trap_state *cpu_tsptr(CPUSPARCState* env)
-- 
2.49.1


