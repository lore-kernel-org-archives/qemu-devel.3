Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8F2FF8870
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5X-0000JK-Pp; Mon, 27 Apr 2026 17:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5R-0000CU-4w
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:50 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5K-0003TU-P4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B744408CB;
 Mon, 27 Apr 2026 21:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A97C2BCB5;
 Mon, 27 Apr 2026 21:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323700;
 bh=N0SltF6kWrhKYQvGQd+k67AMBYWPlgGMkWYMzuPa5JM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YJIV4Ohqm4oYfmdBPKEC9tENPUxqCv2ktdv0Ru3Z1LePrpdUimOIXfVItCi8fhDyF
 PCc5F1S+9jb36b8CWNZa/e2SRJdw14H896dBL3XVosdaKqd67TsyEQ7t208cG0iGVr
 4V9zhff2iutsQvW4PNh6+aFc9YSkU4/SQZGThZNQuSowD/RsS1e6gxtFWuitOwzEwu
 +MK6ruPn4S1FjWb02GhARRaKTGfNX+d4pViXAtNlcgdZZHwu3pOnvbMNBWffoQAIKX
 jZ7md7ijioVz73RdX/6tLcjeFB+B5TRoLXvS+bOSV6vllARPGZsXo7/09kafu9MXiT
 y8bUpElIFZhHA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 02/15] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
Date: Mon, 27 Apr 2026 23:01:20 +0200
Message-ID: <20260427210133.6016-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The kernel's 64-bit signal delivery (signal_64.c) uses:

    newsp = frame - __SIGNAL_FRAMESIZE

while the 32-bit path (signal_32.c) uses:

    newsp = frame - (__SIGNAL_FRAMESIZE + 16)

The extra 16 bytes in the 32-bit case is to place siginfo and ucontext
at the same offsets as older kernels (see the comment in signal_32.c).
The 64-bit rt_sigframe starts with ucontext directly and does not need
this adjustment.

QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
on ppc64. Signal delivery and return still worked because do_rt_sigreturn
had the matching wrong offset, but the vDSO DWARF unwind info encodes
the correct kernel offset. This caused any DWARF unwinder (libunwind,
libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
register values from the signal frame.

Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in both
setup_rt_frame and do_rt_sigreturn to match the kernel.

This was verified by A/B testing with libunwind's test suite:

  ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
           and Ltest-sig-context all change from FAIL to PASS.
  ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
           from FAIL to PASS.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
---
 linux-user/ppc/signal.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 24e5a02a78..a9c10e0987 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -210,6 +210,18 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.tuc_mcontext)
 
 #endif
 
+#ifdef TARGET_PPC64
+#define RT_SIGFRAME_ADJUST 0
+#else
+/*
+ * For 32-bit rt sigframes we have an extra 16 bytes of gap
+ * on top of __SIGNAL_FRAMESIZE; this is to get the siginfo
+ * and ucontext in the same positions as in older kernels.
+ * See Linux's arch/powerpc/kernel/signal_32.c.
+ */
+#define RT_SIGFRAME_ADJUST 16
+#endif
+
 #if defined(TARGET_PPC64)
 
 struct target_func_ptr {
@@ -525,7 +537,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->fpscr = 0;
 
     /* Create a stack frame for the caller of the handler.  */
-    newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + 16);
+    newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST);
     err |= put_user(env->gpr[1], newsp, target_ulong);
 
     if (err)
@@ -641,7 +653,7 @@ long do_rt_sigreturn(CPUPPCState *env)
     struct target_rt_sigframe *rt_sf = NULL;
     target_ulong rt_sf_addr;
 
-    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + 16;
+    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST;
     if (!lock_user_struct(VERIFY_READ, rt_sf, rt_sf_addr, 1))
         goto sigsegv;
 
-- 
2.53.0


