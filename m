Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5722C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNs-0001VY-6T; Sat, 02 Aug 2025 19:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNk-0000qp-Qi
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:17 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNi-0001hi-Pg
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:16 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-433f36eb840so249186b6e.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176273; x=1754781073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KbhO7POhrURIC+yT8sCUyvN31i9kXisb1gFTuWumUKk=;
 b=FU1wx+kvdSR6Z/qij30/RFXlaqF6LULLiXLpzJA+U57UcV/K/S6qALrgSz6+bsVJsk
 cranlAVSFNNTXSHQZNEYM2zz39K0ABAkAOSB+C1lkonnbpcCxbe9MNQzJW2XZqcurIHa
 hZUAowKpK+rMZyesAiLJ4IUx80+/288Eu+Szmy54wisG1myyK8mGolYJ3IsjokVqVF38
 Or1V/wel9861hhitt5sY67mrXypcSmZJOwGNWN0yoJsrx3KN1HCdFwrymjwQ1FxsoXrv
 TtpgyWwhEnN3wS+dSCNf2oOaa3VlMEP68Ld2lUiqPEhpbh1Bcx5vC92K6s3Fp78FchQC
 mfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176273; x=1754781073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbhO7POhrURIC+yT8sCUyvN31i9kXisb1gFTuWumUKk=;
 b=pCy2A9tHMpriQTQsmhJVVGs9xLHZt5K8Fvyn7tHAqxCA9jryaaAqDqYgqtI3KbXH2G
 NVvkmNUdOrO1Sh9Ajw9mdab/XvJTs9q/surHCBPW0sR+/VC4Jmnn8BVoNiFAcVe0Rkdf
 4ic+cH0aUmaVVJHua77zJf5Eb3YCWPiU/CtT3wIyT3EI9UIRhr+PKNByBWO7eCpT5/OL
 iyoWeLcj9mqQHfC/S6EZwo9pwX6ryPd3K8o0+sTm113eYvRWkBa8P4/CHnXP/rAWkvY3
 6DmdzFgpw3x9pelEGCA/mso8bPsr+LYIAw/xMOpgvuRjzL5gxVyTr3s+KjqrCMyF4HNF
 2u8g==
X-Gm-Message-State: AOJu0YxN5LdVCiLh1YuwfSOpgnuATK7XteHa+tQq1NkIzHtxBHGauWfE
 7WBb8nIwTIZiYxSR12vGyh0gjIlMGRvzv1wHJXaUM/CCN65RtK3UupEzIp76g0zHjk/x/+P6bSk
 BicHGUVY=
X-Gm-Gg: ASbGncsa5gDozU+CKUfAZK2RImio0tWuouZWdJI8PNPsV+L1Nb4Ow+W0d4ZnixnDN/Z
 Cj6m0K1gzP/cIsRDud6pIXO0KNZFpph48rOtv4Pq3IA6QTW0/89rWTrdhBiAHQT/kmdBe/lillT
 RgtQ2VCViac/W8Yx0YGwmSrK6TPleGqcno7yyS9zjNNSnRvx/3CH29wa2bgzda1Ap108LhLZ4HK
 zSdTjQTV2+XwAZUaPsrEAVQbqYdPqaD/GJrxglJ+zgaZC6aLH6XB9cLzA5ujEqV1nJCfKeLml5K
 GTymfQvch/RfYAZKUQHyzpMjdS7fHF1AvPneoTsS2WTDWmk9+fyo+andIBV9FXsDFreOMYnhnT2
 6T+QpZVkyRx0HaQUcEzDlpAS3SK67ilyPgS4vmIsReiQypw8YJzXo
X-Google-Smtp-Source: AGHT+IH/cxB9wBEkC/gymG6DWSnftqWFYcbr1P/jWTrO3NsHHlFcnwEpXyn3BfK9lXw+Xng85tRfew==
X-Received: by 2002:a05:6808:1889:b0:41b:eb59:7c63 with SMTP id
 5614622812f47-433f020f7dbmr3065999b6e.1.1754176273347; 
 Sat, 02 Aug 2025 16:11:13 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 50/95] linux-user: Move elf_core_copy_regs to {i386,
 x86_64}/elfload.c
Date: Sun,  3 Aug 2025 09:04:14 +1000
Message-ID: <20250802230459.412251-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   |  8 ++++
 linux-user/x86_64/target_elf.h |  8 ++++
 linux-user/elfload.c           | 70 ----------------------------------
 linux-user/i386/elfload.c      | 21 ++++++++++
 linux-user/x86_64/elfload.c    | 31 +++++++++++++++
 5 files changed, 68 insertions(+), 70 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 44dde1ac4a..aaf7b229c0 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -11,4 +11,12 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 
+/*
+ * Note that ELF_NREG should be 19 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+#define ELF_NREG                17
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 498c3f7e4e..3ab10a6328 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -11,4 +11,12 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 
+/*
+ * Note that ELF_NREG should be 29 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+#define ELF_NREG                27
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4e0d52f1f6..177741522c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -145,46 +145,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#define ELF_NREG    27
-
-/*
- * Note that ELF_NREG should be 29 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
-{
-    regs[0] = tswapl(env->regs[15]);
-    regs[1] = tswapl(env->regs[14]);
-    regs[2] = tswapl(env->regs[13]);
-    regs[3] = tswapl(env->regs[12]);
-    regs[4] = tswapl(env->regs[R_EBP]);
-    regs[5] = tswapl(env->regs[R_EBX]);
-    regs[6] = tswapl(env->regs[11]);
-    regs[7] = tswapl(env->regs[10]);
-    regs[8] = tswapl(env->regs[9]);
-    regs[9] = tswapl(env->regs[8]);
-    regs[10] = tswapl(env->regs[R_EAX]);
-    regs[11] = tswapl(env->regs[R_ECX]);
-    regs[12] = tswapl(env->regs[R_EDX]);
-    regs[13] = tswapl(env->regs[R_ESI]);
-    regs[14] = tswapl(env->regs[R_EDI]);
-    regs[15] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
-    regs[16] = tswapl(env->eip);
-    regs[17] = tswapl(env->segs[R_CS].selector & 0xffff);
-    regs[18] = tswapl(env->eflags);
-    regs[19] = tswapl(env->regs[R_ESP]);
-    regs[20] = tswapl(env->segs[R_SS].selector & 0xffff);
-    regs[21] = tswapl(env->segs[R_FS].selector & 0xffff);
-    regs[22] = tswapl(env->segs[R_GS].selector & 0xffff);
-    regs[23] = tswapl(env->segs[R_DS].selector & 0xffff);
-    regs[24] = tswapl(env->segs[R_ES].selector & 0xffff);
-    regs[25] = tswapl(env->segs[R_FS].selector & 0xffff);
-    regs[26] = tswapl(env->segs[R_GS].selector & 0xffff);
-}
-
 #if ULONG_MAX > UINT32_MAX
 #define INIT_GUEST_COMMPAGE
 static bool init_guest_commpage(void)
@@ -221,36 +181,6 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    17
-
-/*
- * Note that ELF_NREG should be 19 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
-{
-    regs[0] = tswapl(env->regs[R_EBX]);
-    regs[1] = tswapl(env->regs[R_ECX]);
-    regs[2] = tswapl(env->regs[R_EDX]);
-    regs[3] = tswapl(env->regs[R_ESI]);
-    regs[4] = tswapl(env->regs[R_EDI]);
-    regs[5] = tswapl(env->regs[R_EBP]);
-    regs[6] = tswapl(env->regs[R_EAX]);
-    regs[7] = tswapl(env->segs[R_DS].selector & 0xffff);
-    regs[8] = tswapl(env->segs[R_ES].selector & 0xffff);
-    regs[9] = tswapl(env->segs[R_FS].selector & 0xffff);
-    regs[10] = tswapl(env->segs[R_GS].selector & 0xffff);
-    regs[11] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
-    regs[12] = tswapl(env->eip);
-    regs[13] = tswapl(env->segs[R_CS].selector & 0xffff);
-    regs[14] = tswapl(env->eflags);
-    regs[15] = tswapl(env->regs[R_ESP]);
-    regs[16] = tswapl(env->segs[R_SS].selector & 0xffff);
-}
-
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
  * All others only supply AT_SYSINFO_EHDR.
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index ef3a6c35d2..909f8edcab 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -23,3 +23,24 @@ const char *get_elf_platform(CPUState *cs)
     family = MAX(MIN(family, 6), 3);
     return elf_platform[family - 3];
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
+{
+    regs[0] = tswapl(env->regs[R_EBX]);
+    regs[1] = tswapl(env->regs[R_ECX]);
+    regs[2] = tswapl(env->regs[R_EDX]);
+    regs[3] = tswapl(env->regs[R_ESI]);
+    regs[4] = tswapl(env->regs[R_EDI]);
+    regs[5] = tswapl(env->regs[R_EBP]);
+    regs[6] = tswapl(env->regs[R_EAX]);
+    regs[7] = tswapl(env->segs[R_DS].selector & 0xffff);
+    regs[8] = tswapl(env->segs[R_ES].selector & 0xffff);
+    regs[9] = tswapl(env->segs[R_FS].selector & 0xffff);
+    regs[10] = tswapl(env->segs[R_GS].selector & 0xffff);
+    regs[11] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
+    regs[12] = tswapl(env->eip);
+    regs[13] = tswapl(env->segs[R_CS].selector & 0xffff);
+    regs[14] = tswapl(env->eflags);
+    regs[15] = tswapl(env->regs[R_ESP]);
+    regs[16] = tswapl(env->segs[R_SS].selector & 0xffff);
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 88541ea45e..cd7aeb9743 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -19,3 +19,34 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "x86_64";
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
+{
+    regs[0] = tswapl(env->regs[15]);
+    regs[1] = tswapl(env->regs[14]);
+    regs[2] = tswapl(env->regs[13]);
+    regs[3] = tswapl(env->regs[12]);
+    regs[4] = tswapl(env->regs[R_EBP]);
+    regs[5] = tswapl(env->regs[R_EBX]);
+    regs[6] = tswapl(env->regs[11]);
+    regs[7] = tswapl(env->regs[10]);
+    regs[8] = tswapl(env->regs[9]);
+    regs[9] = tswapl(env->regs[8]);
+    regs[10] = tswapl(env->regs[R_EAX]);
+    regs[11] = tswapl(env->regs[R_ECX]);
+    regs[12] = tswapl(env->regs[R_EDX]);
+    regs[13] = tswapl(env->regs[R_ESI]);
+    regs[14] = tswapl(env->regs[R_EDI]);
+    regs[15] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
+    regs[16] = tswapl(env->eip);
+    regs[17] = tswapl(env->segs[R_CS].selector & 0xffff);
+    regs[18] = tswapl(env->eflags);
+    regs[19] = tswapl(env->regs[R_ESP]);
+    regs[20] = tswapl(env->segs[R_SS].selector & 0xffff);
+    regs[21] = tswapl(env->segs[R_FS].selector & 0xffff);
+    regs[22] = tswapl(env->segs[R_GS].selector & 0xffff);
+    regs[23] = tswapl(env->segs[R_DS].selector & 0xffff);
+    regs[24] = tswapl(env->segs[R_ES].selector & 0xffff);
+    regs[25] = tswapl(env->segs[R_FS].selector & 0xffff);
+    regs[26] = tswapl(env->segs[R_GS].selector & 0xffff);
+}
-- 
2.43.0


