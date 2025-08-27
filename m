Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A330CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPSL-0002Du-Ud; Wed, 27 Aug 2025 19:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPS8-000236-0H
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPS5-0004Bi-2V
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso332965b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336870; x=1756941670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7yOBImSiodxYnzN8XvMdq74qSZ6gWrRgjjgFNxAniQ=;
 b=YSdauFGPg10pAg8T8OBCYmPKpmC6t88VrbCBgTHq/1ekvhlkXP/3FbroGg1JM871yr
 1wmNGY7ZYExNbsri8hAUY67tJUasMBOhSZ+HSyRHxk9k64fzTyy8K2knu/tGdL5MqnBG
 WIEiQEXQ9+biIHUTJp1iWMH+6K9XC01r4BaA8soxYPnnpaRszv8Oy6TKOExseA6GTDLd
 2qMi7Dx+PB4XugA1SkqAUGWI/ODIzXboBq/Pt8WmVK47EdNnT+7P15O01GQDLPe1mN9w
 aS0UXaZ69dP+l8fxM5bSkG+u6fIw7nGqSO+hCyNFeDtCnDtO3Owu00ImQROEsuLXU9l5
 6+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336870; x=1756941670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7yOBImSiodxYnzN8XvMdq74qSZ6gWrRgjjgFNxAniQ=;
 b=ZcOoUhVC3+Db3SyYxeOUWtlw2WXYO0isEl6AoncTeqUH3evkSqmtO+YmOUBWBvKZlM
 ryH47nFsjQVFEUdB3ZNvIsO57HDul4Bs0znnSQMSDhRXHB81n5oq8uYwGB+pGps3C8By
 Ff55//CkOhZ9uJrleYM7vdOy8tarXybjN7HkHO9DLKeqXOJ35eb9svzOpqICfs9Hyh2N
 s87NzVPCdBcf02OUxTFsKh6QEkd9K3gxGMdO1LaETqim6gsp5P4Rkmo4JHQhuLoEB9md
 CeIFbntmWykjMlqT8klrmChhM6mIwll4RdWwZ4YbAlTBllawzlJejVnkxRl6Vhd4NetH
 URAg==
X-Gm-Message-State: AOJu0YxoKdiQCF/+6oD8f42M8OX1xX5uJVhq5PyXehQWGrKknnErA4uT
 Bcxc0cuVjArX4M82cmQe5iuWudwB9k7LRl0dswglYWitw2pH/6CKf605164beCv+WDFIW31oLjp
 asOzdUWY=
X-Gm-Gg: ASbGncsm4gafNbHE/a00hyCg8I5iLtcBOfpZpUQ3SI3ICxyu2DvTFPigqKNJojbNPmS
 3TpbYrPaeWoWUYxfv3SgZzeafvbHt0RZ74dhFrQ3VbjWfMiwk35jPX481MMCBcBKacTVb9bsLJI
 2AY9YPVaTZ3XltalgInDrLVPTLfHBwURFP3wqThXJZpVpORNdNCbtyojIhWSSzCQMis09jB/0VZ
 26fKzA8rbhDqS0yR+0ews6E7JtMillHwJOa6rGEiYm8EgRVUvdlrTiW/+QVS6wQR7T87H6GtwwQ
 2k7uhYebFSmp9QO4L5VQOUDskq7UXQnobyHkkdBBf/9KuiNTr1IKnkL7YknjOMCzSFhzvuMkU09
 +AKiDFObSAwbMkvdicssBHpAA++LzjEOK6hrR
X-Google-Smtp-Source: AGHT+IHMwXCaIU/8tIeP5QLKjr29COKfn+hP1yJ/QUFOVkFyFy/NzfgtfzL7xHGnH/t+Lh0JrKYRug==
X-Received: by 2002:a05:6a00:3c8d:b0:770:579a:bb84 with SMTP id
 d2e1a72fcca58-770579abd2amr14936502b3a.5.1756336870274; 
 Wed, 27 Aug 2025 16:21:10 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/46] linux-user: Remove ELF_HWCAP
Date: Thu, 28 Aug 2025 09:19:52 +1000
Message-ID: <20250827232023.50398-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


