Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5474E69E8C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICJ0-00066L-JE; Mon, 02 Dec 2024 14:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tICIz-00065m-8K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:42:01 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tICIw-0005tE-EB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:42:01 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 9A0AC18043B
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:41:54 +0100 (CET)
Received: (qmail 24763 invoked by uid 990); 2 Dec 2024 19:41:54 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:41:54 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH v3 10/11] target/sparc: call plugin trap callbacks
Date: Mon,  2 Dec 2024 20:41:36 +0100
Message-ID: <51c6069c8a2d50d70d21a10c167066e5f0aa096a.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.997331) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.597331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=eSQdBohJLxjuj+kUUKx0s/tIbRONVYZrlcGAeQZ/qZ8=;
 b=pKJ+TnM6ikj6JciNMVJ3o577JdXH+5cErtvdAuTp+n+jYpazKFIdaAH4TPjJC6wASw2W4SacSs
 kPEdgnfOOUBcJqd4gWL9PPmegnb283b8viLjIpwMU53jDxDwDZ7VzOkSmotG9Pi0VoZgud/mx6H3
 R4rvriOdiTbzOOhDSXLByX4UyeQvfQauh4QkaHX3ihyXvcfyWVK2y5dCoRLNYcdX+Jk4uQZRBJ+X
 m6uydibpB3heoAqh/74TAxLGIaGfCxC7Lh2Q0iJ/RWWXv9mc9F4HYJZVS+WTo8nhNuodcpky6f/5
 kvbVDvNiYNvOt7CsTdJq4B28QFCm5LIE/7rZlsdKBaZ5/30/QynYtz7m7vOFja6uqnMAkz2Zb8zb
 56JniMgdwrnrBMLQsBYvyph3FACcT1OZ/HsRu6J94v3usoOo/qLQtPAT9w2us51hrSsCZFt3rpav
 kTzcW+2nfT3IffUb8N2wvPRpAa8kipkv5GFBReW1X1tmv0Njzfy1HH4gASmnmUwM2Jp5kUOs6Bvo
 xpKPStTM7ptxdNAyvgzilYF1bxpSM9aQxS0X3saFYOedY1RSSAfbcXUMah13alX4SMxxhfygDYA+
 S9wdmwS2b8nAjmtZr/GszeUOC1Ej11ynII7jcysofKO9Uss0bhBLPNgoXWnWuLatPho15PYmqOrK
 w=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 target/sparc/int32_helper.c |  7 +++++++
 target/sparc/int64_helper.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index f2dd8bcb2e..86b21eecb6 100644
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
+        qemu_plugin_vcpu_interrupt_cb(cs, env->regwptr[9], env->pc);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, env->regwptr[9], env->pc);
+    }
 }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index bd14c7a0db..9f0e7206d3 100644
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
+        qemu_plugin_vcpu_interrupt_cb(cs, tsptr->tpc, env->pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, tsptr->tpc, env->pc);
+    }
 }
 
 trap_state *cpu_tsptr(CPUSPARCState* env)
-- 
2.45.2


