Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C50CA5FA4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3tg-0001iF-Nc; Mon, 28 Sep 2026 01:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3q4-0005fk-6t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:44 -0400
Received: from mail-dl2-x0d.google.com ([2607:f8b0:4864:38::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3q0-000898-O9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:43 -0400
Received: by mail-dl2-x0d.google.com with SMTP id
 a92af1059eb24-1474c6b7742so959809c88.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573019; x=1791177819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IS1UZYId12KIlinDehyorm2IQtlo8wg2V9f7wEwKC64=;
 b=kAwYTXOEGInhQwXWIaiFawAZy3pwjFsYPHaJZv7fwWMMSZTyu6yEcbwynxPa4Wco+B
 bZuRz8tFnByIEGFfg5LCOOUIfoKhszc0GnxQk/AX5DcnnvNhRBl/JHNeTkV1XBZWO5YE
 46CUAOh2MRCPnQ8reCaJMjxrKqNdXAl9iamFyjVYnT5ZOyl8maglPp2lLv3DAiMFrYWb
 oW5Q8FHSblG7Cdat6c+MLTdHOQfqFu/bTVDJU7d1JTXmSpmxWDzgKf1RDyPpw6nGg1zf
 r7KxZyYYhpnS5yU0ylIa+GvYkTesDJAKtDwfRmbYcwDMizY1bggs6mL/Twxx5YjqGZKN
 l4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573019; x=1791177819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IS1UZYId12KIlinDehyorm2IQtlo8wg2V9f7wEwKC64=;
 b=QgnybGmZ3NbPo3YQfkzVhf9I0r7jKtWNk/+3z6VorEmYkxr3p7QGfWUggvJR2JJcZH
 8T/is9v0WdRfP51eE7G8s7rRr7wc57G41a5Kyd/d54utfqR1VUTZZGEm+bN9isP88Wvp
 9H81+Ny6N1q7JXW+BpUpOAoJf9rDhEDUUF5AbRtrb7lJ5/18XjUYfO7+dEcpBpDiC59F
 QQMssf2aomiRmllGDJqDx0F0uz11jC7y5lRVAxdWAGYrbub6zedmTiFlgxdDrSM06lQP
 p79HBBwc3/pqyHiZhuHTeqpuFfttwwjIia8r9QdP6lpMNtDjSq/DJiZRHbawehEhCcaM
 wbcg==
X-Gm-Message-State: AFuF++meBahDWAswx9HOY4N7kIovvOce+5Dx6taVBqcWmmhP3MStDLsW
 rtTNi4IzIjnPK0GL0yn+Kp5gna2iDexitjJQYT3S7cIfDF/QW/GQfG7yHUMTdvkid68=
X-Gm-Gg: AYBFou28SRXZVqzcZOWzx9V2jhKe7HzueXiUkqL3t8pEtUH3+mJw+g3xl8N6PjMQHyM
 wSjea7uLcrgCEgHI9jBzY8TnXnKNfW0cW1d36pCNY6zAor1ak5EmPjzYJEzk24xlU8swq1nk+AF
 k+ihdpOwHnVjQIJdSYzc+U8F3XLdhI86fNGCgCbJqfBMbXlRzscbn93cL2EX2NuDuKdlVhaL9LN
 jdD3OT5wi3ZdrfkB+8LtJCB4ohVvJfsWqikiKLRSeKD21MukVx9VGArYqAfSINAH3/w5B44aFqW
 OdIK6mZ0sW3ihtCpEsy+rQPSmgayGEOV33tsxk5ofpgJSAflyx2FgFe5DDi2K9YnoO768fU8FjF
 oc5IMZZCopLDpNyiKhSpTe3dRIz7JfPKzPXVkyYAdDWKaRucm91in+I5oYLcj+KbqBcmf067LeC
 K49Fiyw57oD4hCnsfYXLmaNonhNLZm7N9ZUsSqz0xbyUqVU35qpy88rSW+Snr0jH3JqW6e96VMA
 p78oziAoTW5nHheWCzTUaHaN4QSvG4=
X-Received: by 2002:a05:701b:451a:20b0:143:296a:3ed with SMTP id
 a92af1059eb24-146d03a0516mr8276165c88.24.1790573018472; 
 Sun, 27 Sep 2026 22:23:38 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:23:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 20/24] target/arm: convert exception_internal to raise_excp
Date: Mon, 28 Sep 2026 13:20:46 +0800
Message-ID: <20260928052051.251-21-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Switch gen_exception_internal to raise_excp, and drop TCG
exception_internal. Keep syndrome helpers. Fold leftover C exits
into cpu_loop_exit_excp. Keep arm_raise_exception_ra via restore
then arm_raise_exception.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/helper-defs.h |  1 -
 target/arm/tcg/m_helper.c    |  3 ++-
 target/arm/tcg/op_helper.c   | 33 ++++++---------------------------
 target/arm/tcg/translate.c   |  2 +-
 4 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 269ac515065..14ef3120373 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -45,7 +45,6 @@ DEF_HELPER_FLAGS_2(usad8, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 
 DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
                    i32, i32, i32, i32)
-DEF_HELPER_2(exception_internal, noreturn, env, i32)
 DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55bc..161c5460217 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -18,6 +18,7 @@
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "semihosting/common-semi.h"
 #endif
 #if !defined(CONFIG_USER_ONLY)
@@ -575,7 +576,7 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
          */
         env->regs[15] = dest & ~1;
         env->thumb = dest & 1;
-        HELPER(exception_internal)(env, EXCP_EXCEPTION_EXIT);
+        cpu_loop_exit_excp(env_cpu(env), EXCP_EXCEPTION_EXIT, 0);
         /* notreached */
     }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 643b1482523..2ad45b23725 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -64,10 +64,9 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     }
 
     assert(!excp_is_internal(excp));
-    cs->exception_index = excp;
     env->exception.syndrome = syndrome;
     env->exception.target_el = target_el;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, excp, 0);
 }
 
 void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
@@ -399,9 +398,8 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     qatomic_set(&env->halt_reason, HALT_WFI);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -461,9 +459,8 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
         timer_mod(cpu->wfxt_timer, nexttick);
     }
     qatomic_set(&env->halt_reason, HALT_WFI);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -630,9 +627,8 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
     }
 
     qatomic_set(&env->halt_reason, HALT_WFE);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -724,9 +720,8 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
     }
 
     qatomic_set(&env->halt_reason, HALT_WFE);
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -738,23 +733,7 @@ void HELPER(yield)(CPUARMState *env)
      * that the guest is currently busy-looping. Yield control back to the
      * top level loop so that a more deserving VCPU has a chance to run.
      */
-    cs->exception_index = EXCP_YIELD;
-    cpu_loop_exit(cs);
-}
-
-/* Raise an internal-to-QEMU exception. This is limited to only
- * those EXCP values which are special cases for QEMU to interrupt
- * execution and not to be used for exceptions which are passed to
- * the guest (those must all have syndrome information and thus should
- * use exception_with_syndrome*).
- */
-void HELPER(exception_internal)(CPUARMState *env, uint32_t excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    assert(excp_is_internal(excp));
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_YIELD, 0);
 }
 
 /* Raise an exception with the specified syndrome register value */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 8c56348a665..6452888ed41 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -379,7 +379,7 @@ static void gen_rebuild_hflags(DisasContext *s, bool new_el)
 void gen_exception_internal(int excp)
 {
     assert(excp_is_internal(excp));
-    gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp));
 }
 
 static void gen_singlestep_exception(DisasContext *s)
-- 
2.52.0.windows.1


