Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D316C47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9Jz-000547-Gu; Sun, 28 Jan 2024 12:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J3-0002z8-Jf; Sun, 28 Jan 2024 12:51:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J1-0000oo-Ts; Sun, 28 Jan 2024 12:50:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0653C48109;
 Sun, 28 Jan 2024 20:51:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7CF7A6D525;
 Sun, 28 Jan 2024 20:50:39 +0300 (MSK)
Received: (nullmailer pid 812419 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Robbin Ehn <rehn@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 60/71] linux-user: Fixed cpu restore with pc 0 on SIGBUS
Date: Sun, 28 Jan 2024 20:50:23 +0300
Message-Id: <20240128175035.812352-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Robbin Ehn <rehn@rivosinc.com>

Commit f4e1168198 (linux-user: Split out host_sig{segv,bus}_handler)
introduced a bug, when returning from host_sigbus_handler the PC is
never set. Thus cpu_loop_exit_restore is called with a zero PC and
we immediate get a SIGSEGV.

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
Fixes: f4e1168198 ("linux-user: Split out host_sig{segv,bus}_handler")
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Message-Id: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 6d913158b5023ac948b8fd649d77fc86e28072f6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b35d1e512f..c9527adfa3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -925,7 +925,7 @@ static void host_sigsegv_handler(CPUState *cpu, siginfo_t *info,
     cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
 }
 
-static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
+static uintptr_t host_sigbus_handler(CPUState *cpu, siginfo_t *info,
                                 host_sigcontext *uc)
 {
     uintptr_t pc = host_signal_pc(uc);
@@ -947,6 +947,7 @@ static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
         sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
         cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
     }
+    return pc;
 }
 
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
@@ -974,7 +975,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
             host_sigsegv_handler(cpu, info, uc);
             return;
         case SIGBUS:
-            host_sigbus_handler(cpu, info, uc);
+            pc = host_sigbus_handler(cpu, info, uc);
             sync_sig = true;
             break;
         case SIGILL:
-- 
2.39.2


