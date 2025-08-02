Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7C0C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJ4-0001TH-7m; Sat, 02 Aug 2025 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIm-00016Q-RM
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:17 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIk-00017c-Vx
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:08 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-42ce1441042so1167819b6e.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175965; x=1754780765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7yOBImSiodxYnzN8XvMdq74qSZ6gWrRgjjgFNxAniQ=;
 b=LOb163qDxxWjSiYBOnyT6w74wiyB1uRipNxhcbHxsfq1gKMDsroSxPQn93QUahz8Nr
 6Aq5SQ3uA2ssDtIUTmmwjPff7/rn3lKEKmj7F+ZwuBcyZwQmuIlW4q6S52qEdu7eARRv
 KFi2Qkz6RlPhF6Y7/m2NcyjkHUqE5M0ZFRUP47aA94Cg4FWnm7Lc3KtYgYDeF1qNoIKX
 Z0EzxvfBHR01Fiv6+yiSbTYYe1ZARb8surRwTN5cLJSETaaEeZitqfNojj4XfchMrIiR
 U36g8S1mvQUYRKUjAiQqkOecwux/aEqFxL2+Iuj0FyY3sTR0dX5QbaJ8KQO1wZVk8FYW
 lcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175965; x=1754780765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7yOBImSiodxYnzN8XvMdq74qSZ6gWrRgjjgFNxAniQ=;
 b=foaMKin9Tb5EBEDhz0xBBpETc3YUJwKIlQ6SrGcoxNyL7zTldW/vlqsyF7xIXUKCQU
 22AWPQ+j0zYhSxHrL6dSuNGfFQ4kwKaXW63iNy0x/0O/a1yGfmjrAxxH9WTuIXcan0Q2
 8OSGBZdOcq7Ngvfp3vkjCllcFtSuCg16pPKScXXbqvjMq7/STcgGSWrTgbu9i4qG7uj6
 5ys6tJTpAUFCzRc0wnCKHVH1QfqGAb3N5R2ZHJ4pjV9Gkc+/joIKf5yuKJfmUI2CqSgf
 hPr6kQJ8PZ4F6Xyubz8y60l7r2d02PuKoqzjzsewRB0z4Yb4tsMpdNXnHQyZSumqNnHy
 ywVw==
X-Gm-Message-State: AOJu0Ywwztcgc8DgoX4wsCElK8bHzhPAe4kXaD5YuyTRTDEJaqDCZwom
 zTSz2iNkhMtj1Ev+AsCW20p5hQ/MiIHzqpzpNPxRI4UwEPDmmgIPSNy7s9cKnaZz/QhhogKSTof
 bCtaVtfA=
X-Gm-Gg: ASbGncsCFRvPVmRAYFcc7zr/PPsA9TeRaS6xllsZ14STUHO+IrVr7RpDvE9k7eWwytS
 WZLxnCjBzYuLip4wLNWHVQL/7kWP4q9LRdJ/r/gzkf0FO83MsrhIv4wz/cdZThUE0hhv8zekr30
 WfShJG8EWkBuAvI878A5KK18vzs4xbsc6tBblSZJScefswoIsYQ/fJ6o7EC5nTksLcm2wlWTMJa
 X2zmSjeobGsFgYK7KSWsnvzu1IvrHQAMAUDX4xagVRTBIUZ01oXX7JZlp8JAMidFFq72XgwjwYf
 tnbtNzgVizKnHo7BGR2j+LFTKV4F0unOWiztT3x5yHE9DTFWg7Wzm0tYsnZonmEu56x4J6j4QKq
 Io6bTVfEC/O8lrI2sPHyeWIbyMSPBwX/YUBlw29MbVvPGc/ZmuS53
X-Google-Smtp-Source: AGHT+IEx8f+BaY6NenopBc7XNNwNVflurhm2B60HUQvPHSzqi67zZnqGk3ZDJAV2MAmOybxSNGpTdA==
X-Received: by 2002:a05:6808:181a:b0:40a:5839:71c5 with SMTP id
 5614622812f47-433f0224714mr3108790b6e.8.1754175965109; 
 Sat, 02 Aug 2025 16:06:05 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/95] linux-user: Remove ELF_HWCAP
Date: Sun,  3 Aug 2025 09:03:39 +1000
Message-ID: <20250802230459.412251-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
definitions are 0.  Provide zero stub as a fallback definition.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ce4055b0e9..88d439f348 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -28,6 +28,7 @@
 #include "qemu/lockable.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "target_elf.h"
 #include "target_signal.h"
 #include "tcg/debuginfo.h"
 
@@ -148,8 +149,6 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
@@ -449,7 +448,6 @@ static bool init_guest_commpage(void)
     return true;
 }
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 #define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
 
 #define ELF_PLATFORM get_elf_platform()
@@ -539,7 +537,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
-#define ELF_HWCAP   get_elf_hwcap(thread_cpu)
 #define ELF_HWCAP2  get_elf_hwcap2(thread_cpu)
 
 #if TARGET_BIG_ENDIAN
@@ -565,8 +562,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -598,7 +593,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_ARCH        EM_PPC
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 #define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
 
 /*
@@ -725,8 +719,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #define ELF_PLATFORM "loongarch"
 
 #endif /* TARGET_LOONGARCH64 */
@@ -834,8 +826,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #endif /* TARGET_MIPS */
 
 #ifdef TARGET_MICROBLAZE
@@ -909,7 +899,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     (*regs)[32] = tswapreg(env->pc);
     (*regs)[33] = tswapreg(cpu_get_sr(env));
 }
-#define ELF_HWCAP 0
+
 #define ELF_PLATFORM NULL
 
 #endif /* TARGET_OPENRISC */
@@ -963,8 +953,6 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 #endif
 
 #ifdef TARGET_M68K
@@ -1039,8 +1027,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->psw.addr = infop->entry;
@@ -1099,8 +1085,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_HWCAP get_elf_hwcap(thread_cpu)
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1268,10 +1252,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define elf_check_abi(x) (1)
 #endif
 
-#ifndef ELF_HWCAP
-#define ELF_HWCAP 0
-#endif
-
 #ifndef STACK_GROWS_DOWN
 #define STACK_GROWS_DOWN 1
 #endif
@@ -1291,6 +1271,15 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define EXSTACK_DEFAULT false
 #endif
 
+/*
+ * Provide fallback definitions that the target may omit.
+ * One way or another, we'll get a link error if the setting of
+ * HAVE_* doesn't match the implementation.
+ */
+#ifndef HAVE_ELF_HWCAP
+abi_ulong get_elf_hwcap(CPUState *cs) { return 0; }
+#endif
+
 #include "elf.h"
 
 /* We must delay the following stanzas until after "elf.h". */
@@ -1868,7 +1857,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
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


