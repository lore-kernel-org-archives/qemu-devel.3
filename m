Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CBBCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuQi-0002U6-8W; Tue, 12 May 2026 17:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuQe-0002Cr-Oy; Tue, 12 May 2026 17:14:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuQc-0005hA-6Y; Tue, 12 May 2026 17:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=3DiB7yUXUzTu1sqpTflWUQN4GiALmw0QsJAnQxZB+vo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OKlIlEh80TPQlsuhpkrydfCzaB/zmuSgOgkhuKlEsbd2STV4L/w1h+nKqRtWfo5f2
 qfOXc2zFk1IMCkQblwyNzxxY7LhJ2JE8OhW9wJRb8B32Z0PKHg0Nz7J7FngE5vvSXT
 wlV96Dil/povqYr/Mb4f5B6g41y6fTxjrd6slMO9/6LWxOosRrYyFGqSb3hya5VHWy
 Hr4vUoaN4JgKm2DST/2eMnOKikCbxW7nAbeF71OkjwWZHrQu819Pc3+xP3NruxL05T
 hI5Fb5tqz/WvWCYgCYXqSRf3ri2Zv2nutn+pZIo3PAHvb+KcgPWF5zkfWKWCXZSaXz
 uiMmPjZ/7UEXA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4EAF01AA390;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 59B373ABCFF;
 Tue, 12 May 2026 23:55:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 082/117] linux-user/arm/nwfpe: Replace user_registers
 with current_cpu
Date: Tue, 12 May 2026 23:54:24 +0300
Message-ID: <20260512205503.361097-82-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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
index cd89b7d6f5..60de1e4b1b 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -232,7 +232,7 @@ static bool insn_is_linux_bkpt(uint32_t opcode, bool is_thumb)
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


