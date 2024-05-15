Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0A1C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8o-0001Lx-DF; Wed, 15 May 2024 05:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8T-0007aj-Mo
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8H-0001hq-2D
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34eb52bfca3so5715596f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766067; x=1716370867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptESGmuN49Tl7V6u83AkDBF4NQdy5veoa/gvk2M2qX0=;
 b=uxhyoAgScpAYhgS36jZb5kTESPXlyENGmC0YRqCYK7kmjXLBySjgdarBv6FAncJQXW
 gtzFtgjVqfRnmNECOF7xeLSaJKT3A5HIOxYhJJE1Q0Er7nocDVrlgUVJAEQGOlR+ukT0
 QL6cC2AGmuQuI88dccbKtafUQx0m0FuRb2s/gAZl5w0f4LT+6+mVJ4rKUVDmM2H6A6XX
 OffzmCb8yhd6PyoGB+ViZngZKoGfxan9HSw4UNyTKCJQT0Uuf1liRaSsjLZYgUY8vxQk
 FlErZd53AhIxMSId66UH6DyWWBGfgin7/pViSWrry6khfnV6hzcGO4sX4MNByGepxo8t
 94lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766067; x=1716370867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptESGmuN49Tl7V6u83AkDBF4NQdy5veoa/gvk2M2qX0=;
 b=uX2Zeo/xlFXRA7clMiFPF21mjwIK7Tn7XH9N1kem5QUtAHGvjY0qbK+XrppJkrS/L8
 WJArkvjBgieGhy3IVRE7ndYf//YbsOYSvGO5decQgbfNCa4myaRJWtY4qui7kaETheH8
 RWNVVPbjCtN3PqpMOLhLWLM6IRtsgzSgIgGgwJAg+2Avab9EAx3+B6+AwkaL5IFUFTGr
 urwStHMsk4D8f74G7vHi7ybpnOHOlSxQe6yTF0RY0pGtuIxp6l8SBwbcJu0m3dcULTRP
 1ObMn6JKjcuCMrycg0qBgNy/yG3UlMiscmPLTERaNBbkQ4R+4/6dThxPnGytK7CJW0TA
 eQVQ==
X-Gm-Message-State: AOJu0Yzc1WuzihpwnDjQ0adBEjt6sMvEoYbZvJwmjYYTLHQJN5gS3msY
 2jSkQaNRcfbYXc7W01HdNcRc2rE1Fezx9CBGIJwAw78duCnA3slUT1NPR2e/YpmqnP8AEkJtAkV
 DNhc=
X-Google-Smtp-Source: AGHT+IETcsOEHKF/wwOx2GXvqJ576ANlKY0gUX7Pt6ynU6QanTSgptSjM23jrxaJdezIGMrmDJB4TQ==
X-Received: by 2002:a5d:52d1:0:b0:34e:af06:a096 with SMTP id
 ffacd0b85a97d-3504a73deafmr11833030f8f.31.1715766067466; 
 Wed, 15 May 2024 02:41:07 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 31/43] linux-user/hppa: Force all code addresses to PRIV_USER
Date: Wed, 15 May 2024 11:40:31 +0200
Message-Id: <20240515094043.82850-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The kernel does this along the return path to user mode.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_cpu.h |  4 ++--
 target/hppa/cpu.h            |  3 +++
 linux-user/elfload.c         |  4 ++--
 linux-user/hppa/cpu_loop.c   | 14 +++++++-------
 linux-user/hppa/signal.c     |  6 ++++--
 target/hppa/cpu.c            |  7 +++++--
 target/hppa/gdbstub.c        |  6 ++++++
 target/hppa/translate.c      |  4 ++--
 8 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index aacf3e9e02..4b84422a90 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -28,8 +28,8 @@ static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
     /* Indicate child in return value.  */
     env->gr[28] = 0;
     /* Return from the syscall.  */
-    env->iaoq_f = env->gr[31];
-    env->iaoq_b = env->gr[31] + 4;
+    env->iaoq_f = env->gr[31] | PRIV_USER;
+    env->iaoq_b = env->iaoq_f + 4;
 }
 
 static inline void cpu_clone_regs_parent(CPUHPPAState *env, unsigned flags)
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c37b4e12fb..5a1e720bb6 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -42,6 +42,9 @@
 #define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
 #define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
 
+#define PRIV_KERNEL       0
+#define PRIV_USER         3
+
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
 /* No need to flush MMU_ABS*_IDX  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b473cda6b4..c1e1511ff2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1887,8 +1887,8 @@ static inline void init_thread(struct target_pt_regs *regs,
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
-    regs->iaoq[0] = infop->entry;
-    regs->iaoq[1] = infop->entry + 4;
+    regs->iaoq[0] = infop->entry | PRIV_USER;
+    regs->iaoq[1] = regs->iaoq[0] + 4;
     regs->gr[23] = 0;
     regs->gr[24] = infop->argv;
     regs->gr[25] = infop->argc;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index d5232f37fe..bc093b8fe8 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -129,8 +129,8 @@ void cpu_loop(CPUHPPAState *env)
             default:
                 env->gr[28] = ret;
                 /* We arrived here by faking the gateway page.  Return.  */
-                env->iaoq_f = env->gr[31];
-                env->iaoq_b = env->gr[31] + 4;
+                env->iaoq_f = env->gr[31] | PRIV_USER;
+                env->iaoq_b = env->iaoq_f + 4;
                 break;
             case -QEMU_ERESTARTSYS:
             case -QEMU_ESIGRETURN:
@@ -140,8 +140,8 @@ void cpu_loop(CPUHPPAState *env)
         case EXCP_SYSCALL_LWS:
             env->gr[21] = hppa_lws(env);
             /* We arrived here by faking the gateway page.  Return.  */
-            env->iaoq_f = env->gr[31];
-            env->iaoq_b = env->gr[31] + 4;
+            env->iaoq_f = env->gr[31] | PRIV_USER;
+            env->iaoq_b = env->iaoq_f + 4;
             break;
         case EXCP_IMP:
             force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR, env->iaoq_f);
@@ -152,9 +152,9 @@ void cpu_loop(CPUHPPAState *env)
         case EXCP_PRIV_OPR:
             /* check for glibc ABORT_INSTRUCTION "iitlbp %r0,(%sr0, %r0)" */
             if (env->cr[CR_IIR] == 0x04000000) {
-		    force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->iaoq_f);
+                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->iaoq_f);
             } else {
-		    force_sig_fault(TARGET_SIGILL, TARGET_ILL_PRVOPC, env->iaoq_f);
+                force_sig_fault(TARGET_SIGILL, TARGET_ILL_PRVOPC, env->iaoq_f);
             }
             break;
         case EXCP_PRIV_REG:
@@ -170,7 +170,7 @@ void cpu_loop(CPUHPPAState *env)
             force_sig_fault(TARGET_SIGFPE, 0, env->iaoq_f);
             break;
         case EXCP_BREAK:
-            force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->iaoq_f & ~3);
+            force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->iaoq_f);
             break;
         case EXCP_DEBUG:
             force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->iaoq_f);
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index 682ba25922..f6f094c960 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -101,7 +101,9 @@ static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
     cpu_hppa_loaded_fr0(env);
 
     __get_user(env->iaoq_f, &sc->sc_iaoq[0]);
+    env->iaoq_f |= PRIV_USER;
     __get_user(env->iaoq_b, &sc->sc_iaoq[1]);
+    env->iaoq_b |= PRIV_USER;
     __get_user(env->cr[CR_SAR], &sc->sc_sar);
 }
 
@@ -162,8 +164,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         unlock_user(fdesc, haddr, 0);
         haddr = dest;
     }
-    env->iaoq_f = haddr;
-    env->iaoq_b = haddr + 4;
+    env->iaoq_f = haddr | PRIV_USER;
+    env->iaoq_b = env->iaoq_f + 4;
     env->psw_n = 0;
     return;
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index be8c558014..a007de5521 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -32,6 +32,9 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
+#ifdef CONFIG_USER_ONLY
+    value |= PRIV_USER;
+#endif
     cpu->env.iaoq_f = value;
     cpu->env.iaoq_b = value + 4;
 }
@@ -93,8 +96,8 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs,
     tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
 
 #ifdef CONFIG_USER_ONLY
-    cpu->env.iaoq_f = tb->pc;
-    cpu->env.iaoq_b = tb->cs_base;
+    cpu->env.iaoq_f = tb->pc | PRIV_USER;
+    cpu->env.iaoq_b = tb->cs_base | PRIV_USER;
 #else
     /* Recover the IAOQ values from the GVA + PRIV.  */
     uint32_t priv = (tb->flags >> TB_FLAG_PRIV_SHIFT) & 3;
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 4a965b38d7..0daa52f7af 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -163,12 +163,18 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->cr[CR_SAR] = val & (hppa_is_pa20(env) ? 63 : 31);
         break;
     case 33:
+#ifdef CONFIG_USER_ONLY
+        val |= PRIV_USER;
+#endif
         env->iaoq_f = val;
         break;
     case 34:
         env->iasq_f = (uint64_t)val << 32;
         break;
     case 35:
+#ifdef CONFIG_USER_ONLY
+        val |= PRIV_USER;
+#endif
         env->iaoq_b = val;
         break;
     case 36:
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 16b25a9ede..12359bafb6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2054,7 +2054,7 @@ static void do_page_zero(DisasContext *ctx)
 
             tcg_gen_st_i64(cpu_gr[26], tcg_env,
                            offsetof(CPUHPPAState, cr[27]));
-            tcg_gen_ori_i64(next.base, cpu_gr[31], 3);
+            tcg_gen_ori_i64(next.base, cpu_gr[31], PRIV_USER);
             install_iaq_entries(ctx, &next, NULL);
             ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         }
@@ -4583,7 +4583,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->is_pa20 = hppa_is_pa20(cpu_env(cs));
 
 #ifdef CONFIG_USER_ONLY
-    ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
+    ctx->privilege = PRIV_USER;
     ctx->mmu_idx = MMU_USER_IDX;
     ctx->iaoq_first = ctx->base.pc_first | ctx->privilege;
     ctx->iaq_b.disp = ctx->base.tb->cs_base - ctx->base.pc_first;
-- 
2.34.1


