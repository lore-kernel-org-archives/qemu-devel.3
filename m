Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4C7CCD19F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9L-00020a-Qy; Sun, 19 Oct 2025 11:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9K-00020C-D1
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:46 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9I-0003D1-PZ
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:46 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id B8AB760AA8
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:43 +0200 (CEST)
Received: (qmail 23331 invoked by uid 990); 19 Oct 2025 15:16:43 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:43 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v8 14/25] target/openrisc: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:15:03 +0200
Message-ID: <7525e266c45664ce58a2c6c7f92318cad8e6caf7.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999965) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=6By6W6p63fDAcZVupcavoMH8cQUKrNcCRvR5J3edyUo=;
 b=cKQImoW6i5GZkGR4Foqe/35EEAb7uprl7y/77gqlo3U7jSIS1IfAMpAE/3TdWqAEixBmUM0xn/
 homBxCmjtVxTyKPVQAU7gZuCE26Zviga4RfVjGGiajaXlBwZIvGG3VHreF7z2Jmm7azYBjXQWr5F
 kYKL4Qow2e0qMaCLnochYWX4Wpf6tJnFUR1DSAH/9J/qB56K5mO1r8oBWoN67cZn6fqRdnGa0cgK
 gFsy7BYloGYXiHMfSN8G5dFd7tGIzjrn/0nw1utx2cBrkOmxPD3kCUjqPyP9q6T4kw/oXoyx/LHi
 OImX+7KgZzJh8dEQLeL9N4pKDkoN9YSGPNBTT4cugd6MknhBZlnbB5IJup9tqSawixeOUGSFdxgR
 6AN0WPZV6wMfKRRdFezwVRX8gocvyPlN6L4uzPdVJvpbMAdpJpzR53QZqWnjeE5DwDLzQWUas/A8
 KtXIHHFXaS+TiMircbcCdVDzZDIAko764MNgjhJM8s8K7KUT+XVKDKZgGO3j6Nezzo8hLZML5XFp
 IA4V24BPg9rbBikl5VwbLgJr/cGjWpVU+UziaGQP0Y/N5TjFVCHoY+rabn+d6r7myaLUbmvsms3X
 loFjYbjHJTKjI+zuyIxv01xLylZEQ70qMonc50Cbp0YryTGw+j9KM1dTKcLPoomeW3nJUbOYMLUU
 8=
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

This change places hooks for OpenRISC targets. We treat anything other
than resets, timer and device interrupts as exceptions.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/openrisc/interrupt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 486823094c..d357aaa7da 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -25,11 +25,13 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/loader.h"
 #endif
+#include "qemu/plugin.h"
 
 void openrisc_cpu_do_interrupt(CPUState *cs)
 {
     CPUOpenRISCState *env = cpu_env(cs);
     int exception = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     env->epcr = env->pc;
 
@@ -98,6 +100,19 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
     }
 
+    switch (exception) {
+    case EXCP_RESET:
+        /* Resets are already exposed to plugins through a dedicated callback */
+        break;
+    case EXCP_TICK:
+    case EXCP_INT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
+
     cs->exception_index = -1;
 }
 
-- 
2.49.1


