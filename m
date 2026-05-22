Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBBACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXh-0003CV-QD; Fri, 22 May 2026 17:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWs-0000IZ-SB; Fri, 22 May 2026 17:35:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWq-0000Aa-VA; Fri, 22 May 2026 17:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=jjsX3vuFG5pdqzcPcvEy5TDx1NFhTrvU0iAbRklyfh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NpAu/AYKTSn+SADYoaQPIWmfou9Hq1yLs3AaZtBm0zsugBDzwiLGiU6WO+Og+tJSe
 HCO5G78a1LHg+4qE3BR2e55b8f8LmLxn/dzA6BfvnWXX4dg/Vt4RP1F76vFmPxaLVb
 gtG1HDm/Bkld53W7OeOPeVq+LbWXIA2kSbiCsb9nkqTzLREndNf8CmxsNB4j/W2O2D
 HTtCDK8URCvlcQ7E2diNB1EqDyk0fsPh8abIqS1pwBrmE23v08+dYb1mwKXfK92VCB
 nb/I/ZvxGTM3DN424KO/4FH7WglVR+QXqfCy14+h/gAE5IUsAMGr8oeaSNUwiqDXjv
 dtxt4FQlAWOIA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D9741AFADE;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BF6183B7164;
 Sat, 23 May 2026 00:33:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 79/94] linux-user/sh4: Fix target_ucontext tuc_link
 field type
Date: Sat, 23 May 2026 00:33:36 +0300
Message-ID: <20260522213356.806058-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matt Turner <mattst88@gmail.com>

tuc_link is declared as 'struct target_ucontext *', which is a HOST
pointer.  On a 64-bit host running a 32-bit SH4 target, this is 8 bytes
instead of the 4 bytes the target expects, padding pushes tuc_mcontext
8 bytes past its correct offset.

When a signal handler receives ucontext_t *, every field accessed through
uc_mcontext (gregs[], pc, pr, ...) is read from the wrong address.  In
particular the saved PC comes back as a garbage stack value, which breaks
any code that initialises a libunwind cursor from the signal context.

Fix it by using abi_ulong, which is always sized to the target ABI (4
bytes for SH4), matching the layout the kernel and glibc agree on.  This
is the same pattern used by arm/signal.c.

Also remove the (unsigned long *) cast from the __put_user that zeros
tuc_link.  The cast was harmless when tuc_link was pointer-sized (8
bytes matching unsigned long on a 64-bit host), but after the type
change __put_user's sizeof dispatch would select stq_le_p (8-byte write)
for a now-4-byte field, silently overwriting the start of tuc_stack.

Neither this fix nor the companion setup_sigtramp fix is independently
sufficient: this fix corrects register values read from the signal context
but libunwind still cannot detect the frame without the correct trampoline
pattern; that fix makes the frame detectable but register reads remain
garbage without the correct ucontext layout.  Together they fix the
following libunwind tests on a 64-bit host:
  Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
  Ltest-sig-context, Ltest-trace

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit c3176e645774fcb795bf99c1c6c40c67432232db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 9ecc026fae..20d2bc8b2c 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -57,7 +57,7 @@ struct target_sigframe
 
 struct target_ucontext {
     target_ulong tuc_flags;
-    struct target_ucontext *tuc_link;
+    abi_ulong tuc_link;
     target_stack_t tuc_stack;
     struct target_sigcontext tuc_mcontext;
     target_sigset_t tuc_sigmask;        /* mask last for extensibility */
@@ -237,7 +237,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, (unsigned long *)&frame->uc.tuc_link);
+    __put_user(0, &frame->uc.tuc_link);
     target_save_altstack(&frame->uc.tuc_stack, regs);
     setup_sigcontext(&frame->uc.tuc_mcontext,
                      regs, set->sig[0]);
-- 
2.47.3


