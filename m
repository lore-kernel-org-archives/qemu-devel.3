Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37383C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WK-0006dK-UA; Sun, 11 May 2025 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WE-0006RT-Qw
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:02 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WD-0006pn-0g
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:02 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id AB5A7180059
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:48 +0200 (CEST)
Received: (qmail 26014 invoked by uid 990); 11 May 2025 13:14:48 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:48 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 08/23] target/hppa: call plugin trap callbacks
Date: Sun, 11 May 2025 15:14:00 +0200
Message-ID: <6c9c98627a21c77f66e12c25b3a4f44d9e7b4bdc.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999422) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=W6dAuA1iLdBCbnZJz/uIyyL1KNX/P3H4QkX0p21d6Ks=;
 b=EbrbQOH6amy3lcTw2tqduNhtmt1OuqUfGU/8/PhkZTYnE+repZlsoYMAprPsrvr3yeVWR1iNZ7
 ird2sso9oE2rNelySAe1KbNQIdkI/DMtlfIFyIMQfg4rXObcyzhosVO6nEoxrJ1exf0jSjkros2O
 iodQ6XOTP3lMDUK++MFVOZSNfQpFcI+lKJXEaigV5UNPXsJVcDlJdA7zS7TLvSsvvsNsTpyA2kHK
 bYLuuzUmmGGoQ+5AsHzwiDQQUxMVNrm9WdZsRrhIjmAdODdFDKVJKnswMr/VdXuu7XjRL0PTF6tL
 u8UB5z5tMpf9v2sl6x2chKhEFDR/wRReP3b/TGbA6ACBWW/r8QOW5AekS00b4oZlXhOd0B62Rent
 5yYLKSlNn41gTNteRNi9V06ZI7FvyxvgFyrRP/ktS2EAuq2ECTrW2ouVc5Il3KIwZIWEnNRMBurk
 rcddvrQFyzI3+qXEQ9VMalFg/vv84ZYY/EriKETwjKeFK64TrGPNkiKKhIwrUALN4TzsSOhBS0Jw
 /e4S+C4Tc74PGbzcfvBMeIsaBkyiQ+TkQHJVJ8pm03CPVLBLVsgRxYeRm+PpLd6GA+9cQSfEZtjo
 kPJEUKM2yWs17l5z8a1YN1Er6CJ4L5GsSpPXipryuM+8tGF+Q81WmpPhYNKbWUeKYl+9Z6MC41Gy
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

We identified a number of exceptions as interrupts, and we assume any
unknown exception is also an interrupt. HPPA appears to not have any
form of host-call.

This change places the hook for PA-RISC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/hppa/int_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 7d48643bb6..e9325319a7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "qemu/plugin.h"
 
 static void eval_interrupt(HPPACPU *cpu)
 {
@@ -95,6 +96,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
     uint64_t old_psw, old_gva_offset_mask;
+    uint64_t last_pc = cs->cc->get_pc(cs);
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
@@ -208,6 +210,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     env->iasq_f = 0;
     env->iasq_b = 0;
 
+    switch (i) {
+    case EXCP_HPMC:
+    case EXCP_POWER_FAIL:
+    case EXCP_RC:
+    case EXCP_EXT_INTERRUPT:
+    case EXCP_LPMC:
+    case EXCP_PER_INTERRUPT:
+    case EXCP_TOC:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    case EXCP_ITLB_MISS:
+    case EXCP_IMP:
+    case EXCP_ILL:
+    case EXCP_BREAK:
+    case EXCP_PRIV_OPR:
+    case EXCP_PRIV_REG:
+    case EXCP_OVERFLOW:
+    case EXCP_COND:
+    case EXCP_ASSIST:
+    case EXCP_DTLB_MISS:
+    case EXCP_NA_ITLB_MISS:
+    case EXCP_NA_DTLB_MISS:
+    case EXCP_DMP:
+    case EXCP_DMB:
+    case EXCP_TLB_DIRTY:
+    case EXCP_PAGE_REF:
+    case EXCP_ASSIST_EMU:
+    case EXCP_HPT:
+    case EXCP_LPT:
+    case EXCP_TB:
+    case EXCP_DMAR:
+    case EXCP_DMPI:
+    case EXCP_UNALIGN:
+    case EXCP_SYSCALL:
+    case EXCP_SYSCALL_LWS:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    }
+
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static const char * const names[] = {
             [EXCP_HPMC]          = "high priority machine check",
-- 
2.49.0


