Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C20CF531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQJD-0005Kh-Bd; Mon, 13 Apr 2026 19:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQJ8-0005In-De
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:03:07 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQJ6-0005Aq-OU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:03:06 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c76bde70ec9so1965991a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121383; x=1776726183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41ldc32dTmcHvnuwGdzz+RHjc7zQRZZM6Bre2zZ/YBk=;
 b=ZoSwiDR92LSajdBMH1u+QS+zxE75S7/TVwUTnDU9xcM5c0LxnEba6bJI6tpB2MclQV
 m3m1MTWMkOfuX2EA9HsgRRAU6W2+tE5RclBg80E6yGWfKEdAQ4dLezuss/mD6M9lQZ+L
 fYd9/Lo2wV6dXuv5VVv/gzjWXRcdiDdBRbqlJl4oZPFw13qpHKZDungpJbj/+R7JkH46
 G9nEYIoPmHFiET9h5XQKUK60xRmK3ExRDJ+lTWmAcVQScuqWXOM3UrC9fSPVcRO3c+S4
 f4RNiFeYfn/lg5CHz2fKApp4lHYjGt28QkdVJbISFScOU4xIh5cOuiVrbgcFudu7V6TY
 4oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121383; x=1776726183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=41ldc32dTmcHvnuwGdzz+RHjc7zQRZZM6Bre2zZ/YBk=;
 b=b1V2Qd8g/crEBqcMyZj1Mytev8o2jg4NoXaKtcvhIOaB8eYlkU7hH+OEPzdfragXhx
 llDFnbOXhHA/vDiDrsoBbSVWnhKTkOGujQTn/CbKpNZKVjXYmtg6CNWc2yBm38/FY5Nx
 SOCEgHZQ19AyFfuTAT/4IDl15vwDAgLeNjhvjfXl3YK4mCyjrHXGrDtgvJkm6pqDs9lW
 jm2kdOXxqM0hnImElBlTNO8iJPgXuOE4fRbQW5IBMy8Bu/cP7B9jEYXZguEK6+lUIaR0
 MlcSA+Q8XMQa7PZLMxBcZ7hVWx5hRLnueXwmOXbb9Bc3ECDN5Wzgq6PpN0GBgu5A37Dp
 sF4w==
X-Gm-Message-State: AOJu0YzAlCoS4E4nZvbXzNkdExVGXMYig334n3C1MLWw8g/cpshc7Caj
 HRdnyV71Kx39zoQ2/1YrhuhmZd34p1eya8hlJq0a65EXwShh4ABfvURyFbg8EtQ+QEKHkHqOyqv
 52zyXYwM=
X-Gm-Gg: AeBDieuO+/Z9OnWsaa9oosUo0W7LcMumF+JZfdCwoEl01Grh76HpffgJXKZQuWgV+id
 PP6fSt46GiftEsfTzNHNZGQv5bk0oeNNxsgXo+5TjEF/ag4xRsaH8pzL9Nq2J6+mdlbjq1qjYre
 +Qscd+xg4qosXpaX9uFtPyow+MORETgk8S443HNFnCZMoHjM7b0ADDsJygfHR/u9hqhr1Qq8y8J
 evlio1BwnocCFeekEhWqFDHfmOWxHnUCcD/zGazmq2YItoLfJeLsbxTsddTDIoj8Ut0OfCeEIdM
 3jthn/3gVxAiymebiLXhABgQdU6BNbCOJprylUdVUUck0pGgvf3RMs/FuIWuOC9Vbb0f86Cg9Ht
 0ezL7jOsktOytwf07qw7sYlRzJIJljG1GTJg1aj+jcQJVRFMhao4f0RVCLISCm/CBhk6ZyrmVS8
 uXCBtUG0/jnVoE32VJzZDa4w6Xv6wnLhLFIQbU43FtXKfF
X-Received: by 2002:a17:902:ee94:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2b2d591d25amr107701775ad.8.1776121383093; 
 Mon, 13 Apr 2026 16:03:03 -0700 (PDT)
Received: from stoup.. ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4db008esm120507675ad.16.2026.04.13.16.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:03:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/3] linux-user/arm/nwfpe: Replace user_registers with
 current_cpu
Date: Tue, 14 Apr 2026 09:02:50 +1000
Message-ID: <20260413230251.22537-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413230251.22537-1-richard.henderson@linaro.org>
References: <20260413230251.22537-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the thread-local variable current_cpu instead of
a global variable to access the general registers.
This also means we don't need to pass env to EmulateAll.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/nwfpe/fpa11.h | 23 +++++++----------------
 linux-user/arm/cpu_loop.c    |  2 +-
 linux-user/arm/nwfpe/fpa11.c |  9 +--------
 3 files changed, 9 insertions(+), 25 deletions(-)

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
-- 
2.43.0


