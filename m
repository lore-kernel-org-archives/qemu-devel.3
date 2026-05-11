Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F2BCD484F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVIA-0005cK-Iw; Mon, 11 May 2026 14:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHP-0004h0-1J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:59 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHL-0002fV-LE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:58 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d9b155deso1648904b6e.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523774; x=1779128574; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=muRRlgjx9MFhD0Pp20yLIk8Ku1tknLVnfgDx3b/+agQ=;
 b=Jl7fLrDUIlnEYzZXujPyks7DRs4OMqw2dN8vUdILQ6TwW0AeBdKJEJtFxIKZQNkth8
 38xd45ykk19kuW244L+D84RXdKBRj2KIASxcRATVke3WPi5U8t0qP7ADfsTMJoDMu+lU
 pYby94hE3v8r/ZYcJeO4bk1j2ohOTo3i2hD8Trq2bnKlT36UmO+rmJzAMMzoM9ezynGl
 MmZ0XqPdKQ4bJobDtJeOT748Sp1KOcMyX1BngzB4iJ2ZNxe4oJpsMf/hDN8n1t2JAY9O
 k4DC1pkO87xSSpVp5oXl8/oyyxSl9NkAJyBWO4QXAFt77t5BozUgZfXSKMBnaEnaxObe
 wGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523774; x=1779128574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=muRRlgjx9MFhD0Pp20yLIk8Ku1tknLVnfgDx3b/+agQ=;
 b=evnBPAnBEZfX/gPaqNl29cd2nrIQzv32SDf/IIRi+RUs9j9mQu3HNYYCiWCGnjMqCj
 qunwTw1WtOj+g55KeEHSgvT8vRBGS1vcfD8wE8yQQr0nT11suI9arn1NUx3yPV60ny5y
 6ZFyzhCRbpA8nJFJKe9n0oEFLNnjKyQXXc3jzwyQ60WEqD+h+2m0D46iaROIehJuc4UZ
 JH+VRq36cbNb71kPo2Kt5pmzo0Cyh8C9wS4J6byb472D+XsgwwWfBgti6yZr8DMIlF3X
 mGIPMJ4gJNII1rKcy0rm+7Xg8wyYCq1Ow+sx5/wvnAzmXpeRtF55I2fXGfMOKxKXn1xg
 oy5w==
X-Gm-Message-State: AOJu0YyKA+kRUqlwCel5VQ9HZDxR8g9fR8AjEWdiJ8LWMoKCQx3z7Jd9
 ifpOjpv14gnBbZYe46SdBN96HhKtzBSkBgRNcrX/KgsYX/6K3Yw0ULZ6
X-Gm-Gg: Acq92OFkbXmPLqyxkW8Hk1iTp+EnoKBfnF+tAaPGVYlEkHP2llYefMyvkVDs8bWg+Q7
 RXpvsAuS1Tr3TRGCfDNJhLmrFFQEi9iyzQoLYeeyodmhVEzb0RVsRF8twdZa4V29DFfZZN7ThSp
 1Oe8XMBhjaL1t7BolSFH9LuyFEH7exE0hivZfdYHlH/5xEY5wTD7MyxsihEUJMIcWWQ36XmOlZa
 6SYJ37Rn4jz2FNJ+KmDU8is0z6JkDntmOc9oVdUg79CI2ahHpmVOwcOVybwcOd6x44tO3iFQnOR
 hR03qJeovf84ari0WFlkBIwS8xXo9qdMTxcHT65geI843ooLK8A/hjyb5bYyDF9PoHEoPXzUEJK
 JAoyzC9glffI1gJR1GTgKUXSOZZaU5ZavAydhv2m4PcF4PhBsyO3Yf+3Ey2zIMti6/XRO6Uly1G
 Pm5vB9NPemYIEzBahm4X3vcVH5MfaKWZywTZqsrPoSnQi/aPKyA1kqCa4rFhizFS+UrtmxBQkPj
 RQyriy1Wm3Mwe3/0thNo4QL2vQ+Oqr4s7vzywRF4HpYPt/sl5d1pYVnOG52pgrltP3wIfB1O1in
 PKY=
X-Received: by 2002:a05:6808:e647:b0:47b:c96a:a3b6 with SMTP id
 5614622812f47-4804258fb69mr11254737b6e.44.1778523774168; 
 Mon, 11 May 2026 11:22:54 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:34 -0600
Subject: [PATCH v6 03/35] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-3-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Linux/MIPS enables software fixups for user-mode unaligned scalar
accesses by default through MIPS_FIXADE/TIF_FIXADE.  QEMU linux-user did
not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions unless
translation was forced to use unaligned host accesses.

Key MIPS translation blocks on the linux-user unaligned policy, implement
sysmips(MIPS_FIXADE) to toggle that policy, and raise SIGBUS/BUS_ADRALN
when fixups are disabled.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Rename the TB flag from TB_FLAG_UNALIGN to TB_FLAG_MIPS_FIXADE
    to match the MIPS_FIXADE ABI policy.

Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE and MIPS_ATOMIC_SET into preparatory sysmips
    patches.  (suggested by Richard Henderson)
---
 linux-user/mips/cpu_loop.c         | 5 +++++
 linux-user/mips/target_syscall.h   | 1 +
 linux-user/mips64/target_syscall.h | 1 +
 linux-user/syscall.c               | 8 ++++++++
 target/mips/cpu.c                  | 8 ++++++--
 target/mips/cpu.h                  | 4 ++++
 target/mips/tcg/translate.c        | 6 +++++-
 7 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index fa264b27ec..ff9d293c29 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -161,6 +161,11 @@ done_syscall:
         case EXCP_DSPDIS:
             force_sig(TARGET_SIGILL);
             break;
+        case EXCP_AdEL:
+        case EXCP_AdES:
+            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
+                            env->CP0_BadVAddr);
+            break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
             break;
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 9206694f4f..be6942445a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
 #define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index e07687f8ac..c11d0a0888 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
 #define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3786a34041..551caa8e7c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6663,9 +6663,17 @@ static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
 static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
                            abi_long arg2)
 {
+    CPUState *cs = env_cpu(env);
+
     switch (cmd) {
     case TARGET_SYSMIPS_ATOMIC_SET:
         return do_sysmips_atomic_set(env, arg1, arg2);
+    case TARGET_SYSMIPS_FIXADE:
+        if (arg1 & ~3) {
+            return -TARGET_EINVAL;
+        }
+        cs->prctl_unalign_sigbus = !(arg1 & 1);
+        return 0;
     case TARGET_SYSMIPS_FLUSH_CACHE:
         return 0;
     default:
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index f803d47763..6e827c72de 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -565,11 +565,15 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
+    uint32_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
+
+#ifdef CONFIG_USER_ONLY
+    flags |= TB_FLAG_MIPS_FIXADE * !cs->prctl_unalign_sigbus;
+#endif
 
     return (TCGTBCPUState){
         .pc = env->active_tc.PC,
-        .flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
-                                MIPS_HFLAG_HWRENA_ULR),
+        .flags = flags,
     };
 }
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cbb9b3e1b1..b478f834c1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1161,6 +1161,10 @@ typedef struct CPUArchState {
 #define MIPS_HFLAG_ELPA  0x4000000
 #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on ITC tag */
 #define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
+#define MIPS_HFLAG_TB_MASK (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK | \
+                            MIPS_HFLAG_HWRENA_ULR)
+
+#define TB_FLAG_MIPS_FIXADE  0x40000000
     target_ulong btarget;        /* Jump / branch target               */
     target_ulong bcond;          /* Branch condition (if needed)       */
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54ed253a7d..dac30aff8d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15070,6 +15070,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUMIPSState *env = cpu_env(cs);
+    uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->saved_pc = -1;
@@ -15092,7 +15093,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->CP0_LLAddr_shift = env->CP0_LLAddr_shift;
     ctx->cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
-    ctx->hflags = (uint32_t)ctx->base.tb->flags; /* FIXME: maybe use 64 bits? */
+    ctx->hflags = tb_flags & MIPS_HFLAG_TB_MASK;
     ctx->ulri = (env->CP0_Config3 >> CP0C3_ULRI) & 1;
     ctx->ps = ((env->active_fpu.fcr0 >> FCR0_PS) & 1) ||
              (env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F));
@@ -15112,6 +15113,9 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
+    if (tb_flags & TB_FLAG_MIPS_FIXADE) {
+        ctx->default_tcg_memop_mask = MO_UNALN;
+    }
 
     /*
      * Execute a branch and its delay slot as a single instruction.

-- 
2.54.0


