Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9660CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2Ih-0007EL-GT; Mon, 19 May 2025 11:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IR-00070C-Oc
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:55 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IO-0005VM-0z
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:55 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id BAACB180EB4
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:27 +0200 (CEST)
Received: (qmail 1617 invoked by uid 990); 19 May 2025 15:20:27 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:27 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v5 19/25] target/sh4: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:59 +0200
Message-ID: <dde42e30d6f5521c8568738d1abbbe5674192f8a.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.99762) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.59762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=KlyMN/5qzgjLb+9aIafnthxsp3s3tteWGEJqz7YyfMg=;
 b=YYPLXajsqDkBGf/TQY571opD/Z4uYw5XtcUstWKb4/zk9yKz7WBXFIeyTOKH/MnJPXsGVEjj+Z
 s7jIq69h9y83XiCrm1sowg/GtL6eOT2PYThOvGEQsSqNMYHe21XzRO83MkA79Fl+U7A/OB0H+b4r
 i7WJkURV4RoccNfCHsC7mUWn2S9TlVyvrn45prsyjGaIU/4dSsEt0olos5mw8MrGetDslIPvGk31
 B9qGpMBOk5AvEC/+thger7Hk8DZNLfdOp97/Qo6lbBKRyH1viRKwHDTf6jE+X3DVHZiFqSYXz61r
 4PDi6PQ+4CkyZADm3zHV3tCdvfXwC3m41XDJLTRFEtZbcmxKf3WtZN5Zbk9W/DBsSwaBfiUkujPb
 B8nvR4DkeAiybq7AondQgykaW8HsDNcK+kyw+qg96601bk7uM4QQ9FvwNFKV8dl0KVYN97AFWI09
 DIHIne9YbTE2+SlpDRlFEgbukdcYL8aJwjXgZkwAjJXwaJMs0WGU50kCM4PKChrHyP95H7XpTSz/
 Oa68Gx5DiMFcEEocuUr/3pKzUIX1uMHcMcUakbcQRP4w5RWzebbrljDbpqBnq7Te2nVhdK5OTpXp
 7X2tF7TJaStDWEDNSyQqyHZ/0+0gYqfa77aOZsQL2poraU0KqoxPOcCyAlbdRFNwr1H8e8MSQJjN
 o=
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

This change places hooks for SuperH targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/sh4/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index fb7642bda1..ef8760111d 100644
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
     int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
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
2.49.0


