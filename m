Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EC9C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguSv-0003z3-2H; Tue, 29 Jul 2025 20:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFA-0001au-SA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF8-00042Q-Ol
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74b50c71b0aso3629058b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833625; x=1754438425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U2nXMnHMpWoFyt5+dkR10XXNFdZXSTwsI6X/q1e4fEc=;
 b=EwkZAiOY2zBPMJndRjfPTvVr/RrmuCrwcjIf8VmioK1TvYzKSFcA+cf22WQWC4S0i1
 jnA98B8AbtNVzctmYAQXBz6J3SWsbx29AHzbzhxPvmk3n08T/zDGd21gfHFioJOBCOfP
 cC9OpRcKeNsTjAAHcQ5mXf063Pakt693i4K7LR+UlMax0tEBDGKX1kO6mtdFgPDcbyTH
 x8zbui/f5mS15B9/G7G4KGfT2g/PAYwPwrTfJhxyNUJjTq3FA6TKoMfRXnnffnKsQFDT
 1H6byLC3gZdBibuu5DKqzaFUKE7LTqrmVwjVhXr0Ps4K8a+/fBwhskCpVdq8hzSVeopJ
 tq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833625; x=1754438425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2nXMnHMpWoFyt5+dkR10XXNFdZXSTwsI6X/q1e4fEc=;
 b=gaXHtZ/9HAQ+b1LVug7wYHwqfzR/SiwroTfr1BcDEgw2MnVhwOIJKSoD+ZAKnizyZj
 wqsMZpYu47VnOMPu6B0GxXpDcemWGNbNjku2xAnFyB+e4whHKhSjaSs5Oe+mAsFORQc9
 HqNSFGarIaFgbEmDK8mHMIysLF6sUu72RJw5otrwRf/vR0/nF3O0I3GNoT4y0CZryyNU
 r26j9AQ3VT0ZVvBBKZHlRXX9q6VjMQNtzm9GtQhluGLXL7JfMd6S++yGON1QKuFxJBd+
 zDewfxan6qJ1MIFb0VE98/eSaW58icMjM+zLWfwlrqa7k0uodl5gAwuRXkWAaBjHnoeo
 MkeA==
X-Gm-Message-State: AOJu0YyL0TiLh0MYVCzerh9zvaXfdLZHQHatGwNA0OH5CkqcM5HoJQ40
 bJmNoeyb9FE+LyGq4XoGKrWFQY+E0FxhgNs0m3Hla7xvJVUaiI7mfKGT1auOzFTj1vdv6XgCzJt
 IaWmn
X-Gm-Gg: ASbGncsc0dfnvaGL8UMf9uY620KO1l+95QzDlXEFYtv0r50Fj89ZDzngN+YLlvi69H7
 syna7nu/Qwh8z2YegnjtIchLorDcc33MAz/Oiu/A87iZzzcQC709KiOJn7bxjrYXfDQ1MLmbjMC
 kkYGM9o05zSpMzt9G1LVx8PChbH8qisTlBk7Z3TqHA4c8eIH+H9P6vx9L3Gm7o5zADwfE2hk9lU
 4CNjfn9Ogi/UmqeR2CyX9sonqFATntBJfNGCPCo+ASU5dJXkoN9/q8UwXjjdeGqnq9D8QqP83T5
 mQi77K1MBa80RHypDFEz4H2gjZUBvlgKXwedGBvlAYiD2jByiBZWELusR5vL7SLS7lSRQLz1RZn
 g3nJmhCW/5Lqb6uhOPC1JwRNuaWm04VvlELZUvN2bTfJn2ZCfgbUdegDUAHxVI+E2W7R0uvOLs9
 aFzmSHgxb2fLlaNadp6f+X
X-Google-Smtp-Source: AGHT+IFOjY2MF9ppq5NYrqMobv/wK6MPVP2MAdqkxON736aP3+44tKgKhimIMO9nR9eb+ZxrSv/lTA==
X-Received: by 2002:a05:6a20:918e:b0:1ee:8435:6b69 with SMTP id
 adf61e73a8af0-23dc0d31952mr1653041637.1.1753833624736; 
 Tue, 29 Jul 2025 17:00:24 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/89] linux-user: Remove ELF_HWCAP
Date: Tue, 29 Jul 2025 13:58:44 -1000
Message-ID: <20250730000003.599084-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

All real definitions of ELF_HWCAP are now identical, and the stub
definitions are 0.  Provide a weak stub as a fallback definition.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cd83307750..8036f902cc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -38,7 +38,6 @@
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
 #undef ELF_PLATFORM
-#undef ELF_HWCAP
 #undef ELF_HWCAP2
 #undef ELF_CLASS
 #undef ELF_DATA
@@ -158,8 +157,6 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
@@ -459,7 +456,6 @@ static bool init_guest_commpage(void)
     return true;
 }
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 #define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
 
 #define ELF_PLATFORM get_elf_platform()
@@ -549,7 +545,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
-#define ELF_HWCAP   get_elf_hwcap(thread_cpu)
 #define ELF_HWCAP2  get_elf_hwcap2(thread_cpu)
 
 #if TARGET_BIG_ENDIAN
@@ -575,8 +570,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -608,7 +601,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_ARCH        EM_PPC
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 #define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
 
 /*
@@ -735,8 +727,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #define ELF_PLATFORM "loongarch"
 
 #endif /* TARGET_LOONGARCH64 */
@@ -844,8 +834,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #endif /* TARGET_MIPS */
 
 #ifdef TARGET_MICROBLAZE
@@ -919,7 +907,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     (*regs)[32] = tswapreg(env->pc);
     (*regs)[33] = tswapreg(cpu_get_sr(env));
 }
-#define ELF_HWCAP 0
+
 #define ELF_PLATFORM NULL
 
 #endif /* TARGET_OPENRISC */
@@ -973,8 +961,6 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #endif
 
 #ifdef TARGET_M68K
@@ -1049,8 +1035,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->psw.addr = infop->entry;
@@ -1109,8 +1093,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1278,10 +1260,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define elf_check_abi(x) (1)
 #endif
 
-#ifndef ELF_HWCAP
-#define ELF_HWCAP 0
-#endif
-
 #ifndef STACK_GROWS_DOWN
 #define STACK_GROWS_DOWN 1
 #endif
@@ -1301,6 +1279,14 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define EXSTACK_DEFAULT false
 #endif
 
+/*
+ * Provide fallback definitions that the target may omit.
+ */
+abi_ulong __attribute__((weak)) get_elf_hwcap(CPUState *cs)
+{
+    return 0;
+}
+
 #include "elf.h"
 
 /* We must delay the following stanzas until after "elf.h". */
@@ -1878,7 +1864,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_EUID, (abi_ulong) geteuid());
     NEW_AUX_ENT(AT_GID, (abi_ulong) getgid());
     NEW_AUX_ENT(AT_EGID, (abi_ulong) getegid());
-    NEW_AUX_ENT(AT_HWCAP, (abi_ulong) ELF_HWCAP);
+    NEW_AUX_ENT(AT_HWCAP, get_elf_hwcap(thread_cpu));
     NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
     NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
-- 
2.43.0


