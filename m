Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A20ECA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGsN-0003ct-8Z; Thu, 04 Sep 2025 16:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGsL-0003cD-Ce
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:48:09 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGsC-0000m6-6D
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:48:07 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 1B71E60C5C
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:25 +0200 (CEST)
Received: (qmail 346 invoked by uid 990); 4 Sep 2025 20:47:25 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:24 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v6 20/25] target/sparc: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:57 +0200
Message-ID: <e5ecf7f7ed5242809abec86a27cb284d321950c1.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999829) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=sUcYG7ruyA+9QHxAzSD9HdeHOhM3xRfzfStnbhoeH60=;
 b=kQ6EQ44QRV0p254UZmu+Cj/1T5/wp7VRimKsqGZ/ayVaF3gKLcdoF/hEaWwPRkfF67y78RVD3t
 TNfTZAvsJ3mgTj/lIxzLHyLGu33N5F5FjDnWfIkQKCFYqIe5efE3ZGyRgt91QaKM6BxqlJk8tjBt
 qz9wyMaqXZu/dvndb9XsuDTxyu0mLnXV9EqAu1OvMccD4+yTv1Kwi8N74o6rOeroW7Puso60DtQB
 LzdztEJ4u9tiUm5msY32p0iLKlJV4rResbnP3U1MWFf2kJT9nn8r+8XUKpypy6RpwYOy7C/UQ5nU
 a4PsEMNE6XNz+WgltldPv0XEIJXkVA/vEVNCFWFSvT8zhyoX2gpNTwMjw2f2AJIc4a9eAb/NGRp4
 fFotEA9YlpWQEmcFLLcEIpJaFihEb55StH6IiGZFwzOWfMRuSAUSPwSJHJWWRdiKrLCZv3RkbXvQ
 7HvphoWpALu1tqYTeEOGNLgVg7FjIo+V4ciN8i7fRCJtl7mCoSJiVfyYvhJDe2xWzsZThhPS/2DW
 pPJJkjyhA0TYP11IFLSMRhUDO5gy2GbOlbL7fw3EE++Z+AOxCYqj44liiohUAj3cyFqZDwkkFzj2
 LpzQ22Fo6TRsMSFfigIN8pLMxClJfPsGGANHZJWdxBQx6a09vhvPV+YajBfJi06iPCRZs48mL9MJ
 o=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 49e4e51c6d..1de9de0961 100644
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
2.49.1


