Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF096CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGu-0004iZ-OO; Tue, 12 May 2026 17:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEw-00009M-0v; Tue, 12 May 2026 17:02:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEq-0006df-BS; Tue, 12 May 2026 17:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=4W0OyaGK6ZdguvnQ/kLnQO8AjuYIwk2zwEG402Qz6bs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PP92gBqU1aC2y/AAllFS+rO1dmhSPpl+JP5jKVLB1gxWPnCMseIN30iYenb2BdeUf
 X0VVLTvA5Rn8FLGTrhH6Ou8rIcZY+w/Ukx3FRRsHyq834lyggWnwrh6hudnckTY1sr
 EoEReKXEGxLbpYSjWXe/nFJGYKFbDc43Ysc7mrODuHwLcdtFrCmzuUmK5/jbz0uXC6
 I8lx5HklEPxqMpnqItm8X441Q4q1q1YUUCglzMCQsmmzkCqPf7FidO/j8HtD/nX0P1
 Z7BVUUhjjwvzBr/pWbHT5nVBrzTGjBsZOIJVcZ4XqirMtcHMpnIA+rDFqFmIKe6Fjt
 bu3V//l9FmacA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2C8FF1AA314;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3801A3ABC85;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 072/107] linux-user/arm/nwfpe: Replace user_registers
 with current_cpu
Date: Tue, 12 May 2026 23:53:59 +0300
Message-ID: <20260512205437.360850-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Use the thread-local variable current_cpu instead of
a global variable to access the general registers.
This also means we don't need to pass env to EmulateAll.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit c8ea1759009a248cf331b275854d8b272e0f7d8a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 098b54d10e..af01869620 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -231,7 +231,7 @@ static bool insn_is_linux_bkpt(uint32_t opcode, bool is_thumb)
 static bool emulate_arm_fpa11(CPUARMState *env, uint32_t opcode)
 {
     TaskState *ts = get_task_state(env_cpu(env));
-    int rc = EmulateAll(opcode, &ts->fpa, env);
+    int rc = EmulateAll(opcode, &ts->fpa);
     int raise, enabled;
 
     if (rc == 0) {
diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 0f1afbd91d..44783934b2 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -30,7 +30,6 @@
 
 
 FPA11* qemufpa = NULL;
-CPUARMState* user_registers;
 
 /* Reset the FPA11 chip.  Called to initialize and reset the emulator. */
 void resetFPA11(void)
@@ -156,7 +155,7 @@ void SetRoundingPrecision(const unsigned int opcode)
 
 /* Emulate the instruction in the opcode. */
 /* ??? This is not thread safe.  */
-unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa, CPUARMState* qregs)
+unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa)
 {
   unsigned int nRc = 0;
 //  unsigned long flags;
@@ -173,12 +172,6 @@ unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa, CPUARMState* qregs)
   }
 
   qemufpa=qfpa;
-  user_registers=qregs;
-
-#if 0
-  fprintf(stderr,"emulating FP insn 0x%08x, PC=0x%08x\n",
-          opcode, qregs[ARM_REG_PC]);
-#endif
   fpa11 = GET_FPA11();
 
   if (fpa11->initflag == 0)		/* good place for __builtin_expect */
diff --git a/linux-user/arm/nwfpe/fpa11.h b/linux-user/arm/nwfpe/fpa11.h
index d459c5da02..20f9d2eb81 100644
--- a/linux-user/arm/nwfpe/fpa11.h
+++ b/linux-user/arm/nwfpe/fpa11.h
@@ -25,15 +25,6 @@
 
 #define GET_FPA11() (qemufpa)
 
-/*
- * The processes registers are always at the very top of the 8K
- * stack+task struct.  Use the same method as 'current' uses to
- * reach them.
- */
-extern CPUARMState *user_registers;
-
-#define GET_USERREG() (user_registers)
-
 /* Need task_struct */
 //#include <linux/sched.h>
 
@@ -91,25 +82,25 @@ void SetRoundingPrecision(const unsigned int);
 
 static inline unsigned int readRegister(unsigned int reg)
 {
-    return (user_registers->regs[(reg)]);
+    CPUARMState *env = cpu_env(current_cpu);
+    return env->regs[reg];
 }
 
 static inline void writeRegister(unsigned int x, unsigned int y)
 {
-#if 0
-	printf("writing %d to r%d\n",y,x);
-#endif
-        user_registers->regs[(x)]=(y);
+    CPUARMState *env = cpu_env(current_cpu);
+    env->regs[x] = y;
 }
 
 static inline void writeConditionCodes(unsigned int x)
 {
-    cpsr_write(user_registers, x, CPSR_NZCV, CPSRWriteByInstr);
+    CPUARMState *env = cpu_env(current_cpu);
+    cpsr_write(env, x, CPSR_NZCV, CPSRWriteByInstr);
 }
 
 #define ARM_REG_PC 15
 
-unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa, CPUARMState* qregs);
+unsigned int EmulateAll(unsigned int opcode, FPA11* qfpa);
 
 unsigned int EmulateCPDO(const unsigned int);
 unsigned int EmulateCPDT(const unsigned int);
-- 
2.47.3


