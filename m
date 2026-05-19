Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EBBCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPL4s-0001U0-D1; Tue, 19 May 2026 10:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4q-0001TS-SO
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:44 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPL4m-00077K-8w
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:05:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 052ED4379D;
 Tue, 19 May 2026 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D432BC2BCB3;
 Tue, 19 May 2026 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779199538;
 bh=3v+BFejDNyEEVNhvj2/6NonkOFls7oCfp3Nq5ZbZK+c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iYw22ywRYbPJglA2aYbyurzDpgikkZ1iqRZfp6TaUeDqeJVF0K02/0lCilgrmTVUw
 OJXSwJuHoNsJpwn8LOe29cGniRC0AdrLBaQwconFEGiKhzfYPlPEhWcODZYjJZ/RKK
 oN6CA+cOM5a5HST50xmlEU9sp2gAvKtvBmcJ6b/6sstzQvFS+Kj8fruf0ECr4VJYhx
 5q43ayzjHrXF8QYjNG7sbf4QVj+5ffiv59QsPefvac+47N7qwbxSjO0Wf67tP06jGv
 OXOaKu+up7ySkzKKFTa6zUsaFPf9R3UQuUqFB7KDCyj9SYzHsUjr/B8kGqPQAWFRjs
 aVhebDiwFsZcQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/4] linux-user/sh4: Fix setup_sigtramp to match Linux kernel
 trampoline pattern
Date: Tue, 19 May 2026 16:05:30 +0200
Message-ID: <20260519140531.11931-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519140531.11931-1-deller@kernel.org>
References: <20260519140531.11931-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

QEMU used MOVW(2) (0x9300), which loads the syscall number from PC+4,
instead of the kernel's MOVW(7) (0x9305), which loads from PC+14.  The
kernel uses five "or r0,r0" nop pads between TRAP_NOARG and the syscall
number word to reach that offset.  libunwind's unw_is_signal_frame checks
for the exact kernel byte pattern 0xc3109305 at the frame PC, so QEMU's
compact layout was not detected, breaking unwinding through signal frames.

Expand each trampoline from 6 to 16 bytes matching the kernel layout
defined in arch/sh/kernel/signal_32.c:

  #define MOVW(n)    (0x9300|((n)-2))  /* Move mem word at PC+n to R3 */
  #define TRAP_NOARG 0xc310            /* Syscall w/no args (NR in R3) */
  #define OR_R0_R0   0x200b            /* or r0,r0 (insert to avoid hardware bug) */

  __put_user(MOVW(7),          &frame->retcode[0]);  /* 0x9305 */
  __put_user(TRAP_NOARG,       &frame->retcode[1]);  /* 0xc310 */
  __put_user(OR_R0_R0,         &frame->retcode[2]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[3]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[4]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[5]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[6]);  /* 0x200b */
  __put_user((__NR_sigreturn), &frame->retcode[7]);

The first two halfwords (MOVW(7) || TRAP_NOARG = 0xc3109305) form the
32-bit value libunwind checks at the frame PC, followed by two
OR_R0_R0 halfwords (0x200b200b) at PC+4.  The same layout applies to
the rt_sigreturn trampoline (lines 366-373 of signal_32.c).

Neither this fix nor the companion tuc_link fix is independently
sufficient: this fix makes signal frames detectable but register reads
remain garbage without the correct ucontext layout; that fix corrects the
ucontext layout but libunwind still cannot detect the frame without the
correct trampoline pattern.  Together they fix the following libunwind
tests on a 64-bit host:
  Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
  Ltest-sig-context, Ltest-trace

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/signal.c | 42 +++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 20d2bc8b2c..d70be24c38 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -329,20 +329,42 @@ badframe:
     return -QEMU_ESIGRETURN;
 }
 
+/*
+ * "or r0,r0" nop used by the Linux kernel inline sigreturn trampolines to
+ * avoid a hardware bug (OR_R0_R0 in arch/sh/kernel/signal_32.c).  Five of
+ * these nops follow TRAP_NOARG, placing the syscall number word 14 bytes
+ * past the MOVW(7) instruction (at MOVW(7)'s load offset).  This yields the
+ * fixed 16-byte layout that libunwind's unw_is_signal_frame detects:
+ *   [MOVW(7), TRAP_NOARG, 5x NOP_OR, .word syscall_nr]
+ */
+#define NOP_OR 0x200b
+
 void setup_sigtramp(abi_ulong sigtramp_page)
 {
-    uint16_t *tramp = lock_user(VERIFY_WRITE, sigtramp_page, 2 * 6, 0);
+    uint16_t *tramp = lock_user(VERIFY_WRITE, sigtramp_page, 2 * 16, 0);
     assert(tramp != NULL);
 
+    /* sigreturn trampoline (non-RT) at offset 0 */
     default_sigreturn = sigtramp_page;
-    __put_user(MOVW(2), &tramp[0]);
+    __put_user(MOVW(7), &tramp[0]);
     __put_user(TRAP_NOARG, &tramp[1]);
-    __put_user(TARGET_NR_sigreturn, &tramp[2]);
-
-    default_rt_sigreturn = sigtramp_page + 6;
-    __put_user(MOVW(2), &tramp[3]);
-    __put_user(TRAP_NOARG, &tramp[4]);
-    __put_user(TARGET_NR_rt_sigreturn, &tramp[5]);
-
-    unlock_user(tramp, sigtramp_page, 2 * 6);
+    __put_user(NOP_OR, &tramp[2]);
+    __put_user(NOP_OR, &tramp[3]);
+    __put_user(NOP_OR, &tramp[4]);
+    __put_user(NOP_OR, &tramp[5]);
+    __put_user(NOP_OR, &tramp[6]);
+    __put_user(TARGET_NR_sigreturn, &tramp[7]);
+
+    /* rt_sigreturn trampoline at offset 16 */
+    default_rt_sigreturn = sigtramp_page + 16;
+    __put_user(MOVW(7), &tramp[8]);
+    __put_user(TRAP_NOARG, &tramp[9]);
+    __put_user(NOP_OR, &tramp[10]);
+    __put_user(NOP_OR, &tramp[11]);
+    __put_user(NOP_OR, &tramp[12]);
+    __put_user(NOP_OR, &tramp[13]);
+    __put_user(NOP_OR, &tramp[14]);
+    __put_user(TARGET_NR_rt_sigreturn, &tramp[15]);
+
+    unlock_user(tramp, sigtramp_page, 2 * 16);
 }
-- 
2.54.0


