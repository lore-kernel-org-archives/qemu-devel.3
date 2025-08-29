Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A35CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkJ-0001bQ-H1; Sat, 30 Aug 2025 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XF-00037q-2C
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XC-0002xa-BS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:28 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-325393d0ddaso2118712a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506324; x=1757111124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnsU2jXPlSI8IOQgo0w2ao2ecU4o+zzanQ1qk+jqfDE=;
 b=qAKnfpxHzWmmQSAXaga3TNZrIwIn05WwLr3WIYJ0JVxOTuGJvAcdwwV57xuVwBF0z3
 fvGbfEL0Wab+zc9OBJD2l/AC5RKRq7bORPlYHkaENHz+aXHA7D9DQhOqsusWkn80P5VW
 FvseBsnV+iIitz3NGg1r55GefN/VMWA+JK/AFsqkuEVLiNrdkjoAp2qspj0wf3Y6hWqp
 o14Cz7bAbtmQSQveU+exsi2TsG01iTUTFUq5z+VRXHWdqel2ZDdD7GcbRGmAc4V6wedv
 BiUpFukCLjR3UHcCjE94yA07vso/OD9C9EVbI87muvjiL93pt/Yv8QrLqwe8RHZiAgUV
 QIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506324; x=1757111124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnsU2jXPlSI8IOQgo0w2ao2ecU4o+zzanQ1qk+jqfDE=;
 b=b42EZF74isGLHrZg7Zj++Oehi4mcsFAIkdiKmveY/0Jag4ASZyvDw9mgYjyGOwXIBc
 +rDak3fXK9rd1uXT1qaxR3We52nGcbd7lckt4EpA5oodXI8+IHFhDda1mkAGBV8eVWUC
 9NtrGvYdXDAZ2KHAKYeBsT7O3AL6Jtkrrc5Nfp7PUKcH7uTMshCT6GBOrWnR94PJzNmp
 gTFy8jLdQ5AfOcX91/91ssfkhXnv/lk4XxTLkx84vpaJ3g+4S43KtpbOX4a3+9u74Nfy
 VffsQJWMm4gT3xGmx1B5A8FZotlFrenb4QfKG+blFS67ocHTUvCgvwQzhMcGV2R6VyiH
 pROw==
X-Gm-Message-State: AOJu0YymZEv88DTO+6auXaCligpdjPiuGV4oAZE3UNcpSyFykSEYpFDJ
 F22tHhWEd2HbApz2OQ42OTtCbGoW5MnJDNNJMGa1C8C1ywD7Ctqps9VO7JFEdRpChuwO2UaAiop
 ARjzehv8=
X-Gm-Gg: ASbGncvYURbU6eP2mMnK0VIxKgk+UF9jOXj0LvFPt/kXah6zLaJLFbzrFVcuIfBTeSW
 IOs/7OpGW2Z7MwdCpqpTQX3jrCoM/EP07FJb9V4MoT1OhyQYM1XGEpwJzvhD78cHl3Shjg7rsip
 3kTbutOcxCloNEOoeFLb8vOa1e8I/ADxcp1MU1vEJrB5cqntB0A3TOzZPuCWNtYkMVOQXkJlkBa
 A4dlI9uxDbWrK4AmE3UV9d9vnM8Ld5UDVKauabj2s/VJDItRTnQChi7GQ1zzsnqCWwa2JGkikF8
 GH+5Ub7BQBghgw/895Q84zoBdwnbnjYcwVfTYT9zYbhw+7KkEiasuF5vpCT6q84nZDMQcs+0JrL
 +OQIXBSRF+0jEi6UHtO2o7ATLpncvSfndJIuK+0zqopHVCPhaoZXTtaUlyJM1
X-Google-Smtp-Source: AGHT+IFcfrLEQRbmyIsiaOjSOt3d2a8otQPPXp/1zyxZ4hYFDEo9NubRQgv9Kenl3Qf1++QTIkpyNA==
X-Received: by 2002:a17:90b:3c0e:b0:31f:ca:63cd with SMTP id
 98e67ed59e1d1-328154121f0mr298747a91.2.1756506324126; 
 Fri, 29 Aug 2025 15:25:24 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/91] linux-user: Move elf_core_copy_regs to {i386,
 x86_64}/elfload.c
Date: Sat, 30 Aug 2025 08:23:17 +1000
Message-ID: <20250829222427.289668-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h   | 15 +++++++
 linux-user/x86_64/target_elf.h | 15 +++++++
 linux-user/elfload.c           | 77 ----------------------------------
 linux-user/i386/elfload.c      | 24 +++++++++++
 linux-user/x86_64/elfload.c    | 34 +++++++++++++++
 5 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 44dde1ac4a..eb286868e1 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -10,5 +10,20 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Note that ELF_NREG should be 19 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+#define ELF_NREG                17
+
+typedef abi_ulong target_elf_greg_t;
+
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 498c3f7e4e..74a77d94cd 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -10,5 +10,20 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Note that ELF_NREG should be 29 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+#define ELF_NREG                27
+
+typedef abi_ulong target_elf_greg_t;
+
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index af31a34594..e4f821f8c8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -153,49 +153,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#define ELF_NREG    27
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/*
- * Note that ELF_NREG should be 29 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
-{
-    r->regs[0] = tswapreg(env->regs[15]);
-    r->regs[1] = tswapreg(env->regs[14]);
-    r->regs[2] = tswapreg(env->regs[13]);
-    r->regs[3] = tswapreg(env->regs[12]);
-    r->regs[4] = tswapreg(env->regs[R_EBP]);
-    r->regs[5] = tswapreg(env->regs[R_EBX]);
-    r->regs[6] = tswapreg(env->regs[11]);
-    r->regs[7] = tswapreg(env->regs[10]);
-    r->regs[8] = tswapreg(env->regs[9]);
-    r->regs[9] = tswapreg(env->regs[8]);
-    r->regs[10] = tswapreg(env->regs[R_EAX]);
-    r->regs[11] = tswapreg(env->regs[R_ECX]);
-    r->regs[12] = tswapreg(env->regs[R_EDX]);
-    r->regs[13] = tswapreg(env->regs[R_ESI]);
-    r->regs[14] = tswapreg(env->regs[R_EDI]);
-    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[16] = tswapreg(env->eip);
-    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[18] = tswapreg(env->eflags);
-    r->regs[19] = tswapreg(env->regs[R_ESP]);
-    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
-}
-
 #if ULONG_MAX > UINT32_MAX
 #define INIT_GUEST_COMMPAGE
 static bool init_guest_commpage(void)
@@ -232,39 +189,6 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    17
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/*
- * Note that ELF_NREG should be 19 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
-{
-    r->regs[0] = tswapreg(env->regs[R_EBX]);
-    r->regs[1] = tswapreg(env->regs[R_ECX]);
-    r->regs[2] = tswapreg(env->regs[R_EDX]);
-    r->regs[3] = tswapreg(env->regs[R_ESI]);
-    r->regs[4] = tswapreg(env->regs[R_EDI]);
-    r->regs[5] = tswapreg(env->regs[R_EBP]);
-    r->regs[6] = tswapreg(env->regs[R_EAX]);
-    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[12] = tswapreg(env->eip);
-    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[14] = tswapreg(env->eflags);
-    r->regs[15] = tswapreg(env->regs[R_ESP]);
-    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
-}
-
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
  * All others only supply AT_SYSINFO_EHDR.
@@ -281,7 +205,6 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_I386 */
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index ef3a6c35d2..279aeb8116 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -23,3 +24,26 @@ const char *get_elf_platform(CPUState *cs)
     family = MAX(MIN(family, 6), 3);
     return elf_platform[family - 3];
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
+{
+    r->regs[0] = tswapreg(env->regs[R_EBX]);
+    r->regs[1] = tswapreg(env->regs[R_ECX]);
+    r->regs[2] = tswapreg(env->regs[R_EDX]);
+    r->regs[3] = tswapreg(env->regs[R_ESI]);
+    r->regs[4] = tswapreg(env->regs[R_EDI]);
+    r->regs[5] = tswapreg(env->regs[R_EBP]);
+    r->regs[6] = tswapreg(env->regs[R_EAX]);
+    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[12] = tswapreg(env->eip);
+    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[14] = tswapreg(env->eflags);
+    r->regs[15] = tswapreg(env->regs[R_ESP]);
+    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 88541ea45e..76cf5c1509 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -19,3 +20,36 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "x86_64";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
+{
+    r->regs[0] = tswapreg(env->regs[15]);
+    r->regs[1] = tswapreg(env->regs[14]);
+    r->regs[2] = tswapreg(env->regs[13]);
+    r->regs[3] = tswapreg(env->regs[12]);
+    r->regs[4] = tswapreg(env->regs[R_EBP]);
+    r->regs[5] = tswapreg(env->regs[R_EBX]);
+    r->regs[6] = tswapreg(env->regs[11]);
+    r->regs[7] = tswapreg(env->regs[10]);
+    r->regs[8] = tswapreg(env->regs[9]);
+    r->regs[9] = tswapreg(env->regs[8]);
+    r->regs[10] = tswapreg(env->regs[R_EAX]);
+    r->regs[11] = tswapreg(env->regs[R_ECX]);
+    r->regs[12] = tswapreg(env->regs[R_EDX]);
+    r->regs[13] = tswapreg(env->regs[R_ESI]);
+    r->regs[14] = tswapreg(env->regs[R_EDI]);
+    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[16] = tswapreg(env->eip);
+    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[18] = tswapreg(env->eflags);
+    r->regs[19] = tswapreg(env->regs[R_ESP]);
+    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+}
-- 
2.43.0


