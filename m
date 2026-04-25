Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42600FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGfIn-00086g-DN; Sat, 25 Apr 2026 11:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIV-00080g-Id
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:00 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIS-00012S-Eh
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:51:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BF9F36011F;
 Sat, 25 Apr 2026 15:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12733C2BCB0;
 Sat, 25 Apr 2026 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777132313;
 bh=QIFtf3dqQlSgmjSkVvwlhh3G2J8OJkshPhuv1bYI+XA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W/wXxi6GPNWlBF2vwGQ2mInU1zcNbHELKUz6F3mGR1p0e+ahF3jPQQAL3oKx1YxdW
 aCvwjSckA4E00F52MBoKAwA1yaEORWNZ5WrC2i8CgS3RWiv9GcoE7FEqMDKGQx8cKF
 mJQW3iuEAC7JV4xqTDsVvNE+1ZpnZOVzPTX0AC8goFTLf+qohYN993xKhortbQAqMm
 LrLbyafmspdR4834ChsCYXFFTpxHW1GDFED7JbnCpA3bk88c01W0kRenhGAEfwMTlQ
 AZ54t0MaOvsgubvg8d7JW4e+lWjtlB9+kuVI69g19WtGFD0OcyWIpRymiGuxf807Hc
 ttMGGAgMXHFpA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/14] linux-user/arm/nwfpe: Replace user_registers with
 current_cpu
Date: Sat, 25 Apr 2026 17:51:31 +0200
Message-ID: <20260425155140.50186-6-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425155140.50186-1-deller@kernel.org>
References: <20260425155140.50186-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

From: Richard Henderson <richard.henderson@linaro.org>

Use the thread-local variable current_cpu instead of
a global variable to access the general registers.
This also means we don't need to pass env to EmulateAll.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/arm/cpu_loop.c    |  2 +-
 linux-user/arm/nwfpe/fpa11.c |  9 +--------
 linux-user/arm/nwfpe/fpa11.h | 23 +++++++----------------
 3 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 19874f4c72..262ab5cc41 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -215,7 +215,7 @@ static bool insn_is_linux_bkpt(uint32_t opcode, bool is_thumb)
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
2.53.0


