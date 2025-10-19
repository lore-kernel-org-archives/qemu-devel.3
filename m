Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15520CCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9e-0002EH-OG; Sun, 19 Oct 2025 11:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9b-0002Bh-Ka
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:17:03 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9Y-0003Eu-T3
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:17:03 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id C07D760AA0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:59 +0200 (CEST)
Received: (qmail 23758 invoked by uid 990); 19 Oct 2025 15:16:59 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:59 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v8 19/25] target/sh4: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:08 +0200
Message-ID: <f054d7015aeddb50a108b25759f5699853357cbe.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99997) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=henyk1pn+Y7JL09xIai+moS5k8bo4s/ntXusmsrLMEM=;
 b=ICcGmOSmeYzG63LRRfIlDVCnIBCkhK/f+rmSmydLBxX6i+WX7wFMXukJ5XCpE9HGWjt6t5YZ6n
 KT4W+YYJOj5TzLHm2PCfwc0Jp4Rl3hor9iuqC+513IY51cQ+o50x5olPSbhBrLZVhUllP9lqSiyN
 XAMT0MfWWbJewNKmO8L8k6XYtpfaOkyXO6Kg3L5Ra3khBUXk77x8mz334uwsfcwcfGpvsAZUo48I
 Lp/xKRUinB9F5OyES0Y8K4njtcnAqMZ5+e20RaEge5YIx1fKfAqnb+qcWWwop2C6PlMar0fEkXPh
 oIq4Q1qcsOCEGSV8ZqU68bRqQJ/bCh0NfAM7/M8yiPssVaoDGUcTCpN0Op0PPPDLByrKT/6WkDYO
 49zZqcvp1bmP5V27H6/Qwgvb2buP7xF87kUVzS5K5noruFvBqFLN5eJvo8TzQpQ09PAAK0Iv92ya
 rLkhd/vzULPc4cQ5S/cKKYahByNRDOZqkN82nFQUInb+Vgm8+sOfaWrIO2LXvDbQ0i/Jl8BhD24u
 aD6SVWdSHboHHpZdMP5dNWkBiOddiCRgpwHOAlxDiU8BvHkeHQlUZi4A4aL7GHIKGhlwxzINs5Mw
 NbKRfnfojDYMFIUq1ln2E8T5nakJo8+1RKZ265PYoJU8dfsyKLIRnllJzLHX/Gl2tuDGf3nlO+OZ
 g=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

This change places hooks for SuperH targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/sh4/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 3b18a320b8..5d6295618f 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -24,6 +24,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/log.h"
+#include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/sh4/sh_intc.h"
@@ -60,6 +61,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     CPUSH4State *env = cpu_env(cs);
     int do_irq = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     int do_exp, irq_vector = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     /* prioritize exceptions over interrupts */
 
@@ -176,12 +178,14 @@ void superh_cpu_do_interrupt(CPUState *cs)
             env->pc = env->vbr + 0x100;
             break;
         }
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
         return;
     }
 
     if (do_irq) {
         env->intevt = irq_vector;
         env->pc = env->vbr + 0x600;
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         return;
     }
 }
-- 
2.49.1


