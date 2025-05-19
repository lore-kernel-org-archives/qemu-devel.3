Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8E2C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IX-00070c-Ny; Mon, 19 May 2025 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IP-0006zT-9U
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:53 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IM-0005VJ-Py
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:52 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 07E2B180EB6
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:28 +0200 (CEST)
Received: (qmail 1638 invoked by uid 990); 19 May 2025 15:20:27 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:27 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v5 20/25] target/sparc: call plugin trap callbacks
Date: Mon, 19 May 2025 17:20:00 +0200
Message-ID: <74a9841af043f785757ad9c6cb585b51752b15f8.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999515) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=IdC88N99+YM4YmCWx53I/KZhBjRliJfCHy+BVZ5q4+g=;
 b=xJ8vZj92AAEZR8I+SczftdCmXasYa/qC6se6EF+YHNPJc1vjyUG1AH9vckvKgFgEYzQYphgX6C
 hqBoBK8h81hC/n/4sNZuGzKqWflxgfDwWCuP7+v1IlK3jcPno3r4ZKMtWi3G4AEIFhu0IBNcuPwo
 QfhGVZf7qg0UauhntuBfHbn1HzQ0C7qh4IeaNOlKaYszkwK9YQt1gSQMu9/8Gx6IQyEGpb/slivE
 mHT5IoC4RUhFoS/i6uEye8Tl+ZT1mCX375kZfGgeXA1cJcXv86C6ZTjAqZC7TRzfFihfEm/UL/XJ
 UX9ltY1UEpiXEVn5yZtwWFPEu3wmci3eicPB9doURhjTk/UmWdx6QdZbZee7PvUPpAjHccGd1o7u
 2uZOjDA0iSeoHuXO1b5rDGuUcoY06WlW1TuE4WKa6Us2sXYWvuMcHOcGQxT3660Loi4hVEE2Tm6M
 /cfg3XIzHlfSUA8TkwY4UTsSOiB8ByegBMQgflPHw7p4+gZebB811/IRv6YRhKKrbi2EL/4ihCnV
 LQyG14vJwC1XgKXhVh2oyLvUrk9A48IoqVWoIWQSRzpoHqe/D/fMmFZxUqnpWdn+pULYp5GIqJFV
 O+Gass+v10Cz9WzBgoKLjDvAp3GZkmFZBIMp9AupbLZK9PB3C63EDD0r4MQUmFj59ndmShYdZQI+
 M=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/sparc/int32_helper.c |  7 +++++++
 target/sparc/int64_helper.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 39db4ffa70..634439ab2a 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -24,6 +24,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "system/runstate.h"
+#include "qemu/plugin.h"
 
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
@@ -172,4 +173,10 @@ void sparc_cpu_do_interrupt(CPUState *cs)
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
index bd14c7a0db..9868a80669 100644
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
+        qemu_plugin_vcpu_interrupt_cb(cs, tsptr->tpc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, tsptr->tpc);
+    }
 }
 
 trap_state *cpu_tsptr(CPUSPARCState* env)
-- 
2.49.0


