Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985D8C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WV-0007JY-70; Sun, 11 May 2025 09:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WR-00073I-MR
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:15 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WP-0006sA-RI
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:15 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 8AC98180080
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:52 +0200 (CEST)
Received: (qmail 26206 invoked by uid 990); 11 May 2025 13:14:52 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:52 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 20/23] target/xtensa: call plugin trap callbacks
Date: Sun, 11 May 2025 15:14:12 +0200
Message-ID: <26b7c748557fb8dc655eb003758789263705d736.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999795) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=O9OOWZjnGiK8Xl9Lei0yPEHEK29KFW4jkknqvzRxMpg=;
 b=j9CNaADfUfB2QnQHapyoPgakY8/l+op315iFCBUW7iFyEhRnGWHtTB3HPTbkAGZJc4dY/Yty0h
 mjbdCgxAP4t55m6juvfZArg6pBDb2+4upwdLBj6olfQ9lvhFJDR0nzJv1BEdbwmzIHHz1Ut5+eFb
 V0ANYbTBVz6UahY2RFbVNtmpNEzVrv1emUE3Ve9sKQpS9lh3l1L+4RmcNvTkjgGIIkCtHqnTRj9D
 TQkFhUiREdAe511C02HzxMqPSDHnwgMppBxWK9l+xXxBbK+AgfXyeRtpB2tE4QEIrP/lnXWknfxU
 B2Rfk3fOhqs6PEgQ0R6G8cQQD+LRCzHAOVasgkOM9B/Vz0AIlAmj8nG5hYKGJ2rh+bwUFui9qDj5
 +zCLdVVx+bymaRSGC+4dvfpnRFPAMy1Vctom7PZUa+3jcc+BRs4/Zy2a6J3fMssftB9COr3+LzXp
 8us9pUbMeTfc5gMfTK9NgUX6femVOADAfxjCi2TrWOsHgdU9r4enmMa31TFzqcVqE62lrzPucLoE
 KGLQ05jsdaQSs7i3wAkJSFc1LfwRMZysIW9ZMiG02lZvzAnFwKSZnUVEH0IaywnDwwvw/9RlZCgp
 HIU/5tkB1iqav/pBylzxlDtyk07JOCgB2wBIjXQ/zNV5w2ydBPo5MXNswte29JpVfIC6U7W4atif
 Q=
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

This change places hooks for xtensa targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/xtensa/exc_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index b611c9bf97..fdc522698d 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -32,6 +32,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/atomic.h"
+#include "qemu/plugin.h"
 
 void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
 {
@@ -207,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
+        uint64_t last_pc = env->pc;
+
         qemu_log_mask(CPU_LOG_INT,
                       "%s(EXC_IRQ) level = %d, cintlevel = %d, "
                       "pc = %08x, a0 = %08x, ps = %08x, "
@@ -218,6 +221,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[INTSET], env->sregs[INTENABLE],
                       env->sregs[CCOUNT]);
         handle_interrupt(env);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     }
 
     switch (cs->exception_index) {
@@ -238,9 +242,11 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
             uint32_t vector;
+            uint64_t last_pc = env->pc;
 
             vector = env->config->exception_vector[cs->exception_index];
             env->pc = relocated_vector(env, vector);
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
         } else {
             qemu_log_mask(CPU_LOG_INT,
                           "%s(pc = %08x) bad exception_index: %d\n",
-- 
2.49.0


