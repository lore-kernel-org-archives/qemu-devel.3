Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7B5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WW-0007Op-Ma; Sun, 11 May 2025 09:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WR-00073H-Mc
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:15 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WO-0006qq-CE
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:15 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id B1EB4180061
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:51 +0200 (CEST)
Received: (qmail 26156 invoked by uid 990); 11 May 2025 13:14:51 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:51 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 17/23] target/rx: call plugin trap callbacks
Date: Sun, 11 May 2025 15:14:09 +0200
Message-ID: <012fb70e3b3ae27c79eb99da91a38d8430121c28.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.996848) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.596848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=hQkRJhsCAoh/1qVrrVBmBN8T3iX5LzPpXKtF61AGsE0=;
 b=bNlQ7ETHZ3QxGqHksZYM9fmkVvf58JHSip2x4fBBRI7yw6flarYsWV8iaEGjhAgpupIZY4eD55
 hv5fOQDd3atZ9ayGNZpYG5DXmlqWn8rQE1e7ocRwnaq1aryj7MACNWKykTwGnx/SY9yFTBPY/cxM
 8ULhm3aYYlQUn78YZhz8uDj00fJ/ez44AUM7SVd6knj5nKatpMeORB/LZHccGL76eAbk2GQ2vmM7
 lfvsAVjP3ORR/4iIH1MRsFBsXPLaQ9dRGYMlO+eeb85LTgYzkTaAfGNugkU78680XczcFdfAqR7k
 XrrcNrA3dAig1NPmFeN5D7RPOwwStGDTFZ8/TtVq8fg6mhR1g1PWlXztKqDWPrtm3ZGCxWqCSm4S
 gkS78QGS6p1BXdV2I/ztNA5CU3Ff+p52lIGm9NCbp/tlC+fCmkJteAEZ+Answ8/psJn/zUzrvpe5
 S3qIZzkpCLVlYqnzyqIWr8KFYa2BZoK6kVHKOiu1TJMqhquCotJ03kEaOjqRzoZeXiH/YyAo52dd
 jLumtyNu49W0bKkUBkeJdiEWeCrlDzd3kNae9nHL9i4F2wZUqYa/C9LMCXLBt8wlNPhioS3tyPRB
 t9cfYOu2uxpkW5K//Y3LVuIvde4tuLlOzIVQYtFhrg50IQTomNYTb749MTVzRzTJ1XhgjDlP1YIS
 4=
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

This change places hooks for Renesas Xtreme targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/rx/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0640ab322b..09f1c25be2 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -22,6 +22,7 @@
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "hw/irq.h"
+#include "qemu/plugin.h"
 
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 {
@@ -46,6 +47,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
     CPURXState *env = cpu_env(cs);
     int do_irq = cs->interrupt_request & INT_FLAGS;
     uint32_t save_psw;
+    uint64_t last_pc = env->pc;
 
     env->in_sleep = 0;
 
@@ -65,6 +67,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->psw_ipl = 15;
             cs->interrupt_request &= ~CPU_INTERRUPT_FIR;
             qemu_set_irq(env->ack, env->ack_irq);
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
             qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
         } else if (do_irq & CPU_INTERRUPT_HARD) {
             env->isp -= 4;
@@ -75,6 +78,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
             env->psw_ipl = env->ack_ipl;
             cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
             qemu_set_irq(env->ack, env->ack_irq);
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
             qemu_log_mask(CPU_LOG_INT,
                           "interrupt 0x%02x raised\n", env->ack_irq);
         }
@@ -92,6 +96,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         } else {
             env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
         }
+
+        if (vec == 30) {
+            /* Non-maskable interrupt */
+            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        } else {
+            qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        }
+
         switch (vec) {
         case 20:
             expname = "privilege violation";
-- 
2.49.0


