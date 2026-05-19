Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A6DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPL4r-0001Tp-JZ; Tue, 19 May 2026 10:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4p-0001Sz-Be
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:43 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4l-00077E-A7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B2F0A6012B;
 Tue, 19 May 2026 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFFBC2BCB3;
 Tue, 19 May 2026 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779199537;
 bh=PY17bYS21Bby74vu+bLPlBHFARjqbvT+1eN8tdKEo+E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WN8lLU52U0h65NZRg1rz0Et39SNUwYVLl9aBgHSoOfLTUeL9FR55kxZEmxT5yegf6
 S/WaiMIPVhPTrnFDB2E82U6EOZIjtpMkWhNSXQQkjSvt2WSHBUoXSDz/tsMI8gCMmm
 8vqRRVevokJN/Bo1W/IE5McZHml4T3oJ/YdxRapXPDw5OPNucdsnVoFniHs4gqGRxU
 NYyly0JCmS0x1JXuYeG1STjxkSPlhfAciAXFCDabWBkuqor1OFw/T8wlTnocwbobSZ
 LHVgGbPI8K2B/u43RreNHUpGv4UXgtEuX7KCiSKEwKw0ZmWZ4uVibUYO6yYkARFXEd
 2UqleJTlvzfyQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 2/4] linux-user/sh4: Fix target_ucontext tuc_link field type
Date: Tue, 19 May 2026 16:05:29 +0200
Message-ID: <20260519140531.11931-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519140531.11931-1-deller@kernel.org>
References: <20260519140531.11931-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/sh4/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.54.0


