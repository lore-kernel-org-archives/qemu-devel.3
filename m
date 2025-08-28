Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF5CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTx-0005ua-MR; Thu, 28 Aug 2025 08:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRp-00030y-Fx
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRl-0007IE-VP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b471737b347so589302a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382979; x=1756987779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kq3UR6cJAVbU6RZVHbic254O03tLZOp/eHhdQes8t1Y=;
 b=SZ4hYkIdrtJcSLVsWVKPZLCOq6yz39ZO14OongqWPxNh9n5tLzd9I9iBwFmJ/XgDt1
 JaqmsfKUrFwy/8E1SysFUqf3J3x247/M/fd8f3hvHJkQsohjzAyZM4x1tjWFt/SOEmQh
 jJUpvbAd3bBzbnk2EnkukmT8K7+4I4RR2HImdhsrR/W/CHyFAUiJHrZWTO44DG1fDA4+
 3c00PPqL9BMpBOLxHkww73MGrH5yJhwC2n//e7on4ZjVrcD7y23KTjLAWdIlh1eWfO1u
 1he/iCtqiCyf3at+tybMDrnVGFET0m/a1yErUlPZlOlHNFfmDW3hoowZwAZUDweQJXdb
 SU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382979; x=1756987779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kq3UR6cJAVbU6RZVHbic254O03tLZOp/eHhdQes8t1Y=;
 b=S4r0HUKybLKVUbI39q39LdNcNu7Nbrk9a/TkP/AbG/aVV/GYLhn0DEsX4k3UMjX2pc
 8Ic97LpAavrIZpvlhtQiEwUzzX7RvQhVpr7nRtXQrCHkO9ZEJnxf2Zy+86BmKMQSPAfd
 C5+7xYOu0zqcFvh4LBzKWcGYsxeRNuzpYguUMw6wKJia5R78rIHTVHsiCKwS1hMiVtga
 o6jMRAwIiS6tK/Q0e4E3X93omjkU8M6Uy5+VoxEKgipzMZ3xvIAuI1My02jYehYqjG6n
 RMcrl5zLLOyh1NR8+Qx1a3RuHcMwtum+XmLo7lVuqrGrOTlCT0MWp+1dCgEb7MGDbscW
 1kjA==
X-Gm-Message-State: AOJu0Yy9aLtJj41NN+tJEMfps7JjxOKL5G2yokWkzZxhmRYvsVPw1oZD
 kl9pdyxX5iEVWlJ1ZJcT/niFBZHL1Kxu6SAKldcklhBhBNKZ+t9pOO06zQtashdtGyB5/U0oF5z
 8xhYJpLk=
X-Gm-Gg: ASbGncs/HGEUxqIbNm+QhGiXqxRTibfZMVfnQDyipaXUXASsw+/PzgitRggIoJWlwQD
 nSghSwVxQJhaHYcaMEoEa9crWryX7rVOReSwpXHTj5ounXhH+x6WdYgczwD5hca++XVCOoMhPd4
 4JrefrNl75Eb3pzD2VTxApug5YNcRoKT+snSqAHJPQdTQDKLRHBUW7hF4SVw0CUHGJBRnUCRdbI
 B1eFDrinehHf4uunP9SIdQb+ybOICWC7NK4M+FTcQBkWq9w6bcpUAaMLBd4ImIVopzj7/GggoUx
 obq8cOjKyRjujfeZlw1qNV9t5jpunT7Qf5XE3NN+SXoxlcq/qVcRAb8gI3cYKNwVN8u8fMkNAtj
 7kVCf2EhcdgGcjsncULVegUS9QYnI7aiX6DQM
X-Google-Smtp-Source: AGHT+IFzO9SIhPTdp6WnGfhtPYGHYN07gCPGLJg8ZtVFjkyp9d1JIz4Wvk9A6e/VYiOKtZa6lkvyvg==
X-Received: by 2002:a17:90b:3503:b0:31f:867:d6b4 with SMTP id
 98e67ed59e1d1-32515edd015mr28327411a91.10.1756382979391; 
 Thu, 28 Aug 2025 05:09:39 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 24/87] linux-user: Move elf_core_copy_regs to
 openrisc/elfload.c
Date: Thu, 28 Aug 2025 22:07:33 +1000
Message-ID: <20250828120836.195358-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h | 10 ++++++++++
 linux-user/elfload.c             | 16 ----------------
 linux-user/openrisc/elfload.c    | 12 ++++++++++++
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index b34f2ff672..e97bdc11ed 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel arch/openrisc/include/asm/elf.h.  */
+#define ELF_NREG                34 /* gprs and pc, sr */
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 96ed6b6515..8c3ef41312 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -424,24 +424,8 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
-/* See linux kernel arch/openrisc/include/asm/elf.h.  */
-#define ELF_NREG 34 /* gprs and pc, sr */
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
-{
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
-    }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(cpu_get_sr(env));
-}
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index b92442dfeb..bb5ad96711 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -3,9 +3,21 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "any";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
+    }
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(cpu_get_sr(env));
+}
-- 
2.43.0


