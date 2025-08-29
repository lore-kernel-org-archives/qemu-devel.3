Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE3ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkS-0002XS-0e; Sat, 30 Aug 2025 11:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xe-0003HE-1j
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xc-00033S-11
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7720b23a49fso2928358b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506350; x=1757111150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqY7gg7nNkpb5GHdIFMfU/GOMdyhe7cpOkiV9a020oI=;
 b=ntZrbFlCd3QAVJ9obkbx+v12YNLAIwgmcKjPmlGQWggzw3Jw8xXZOLzD5QfdE9rL/T
 7Rl0oiJJCH/Icq4dbJTjWlpP0eIRapm/dhAfet53bb4bu8jbkk4j0QI70XAg71QYm4we
 fC2cajpGcNghd39bZQfnJHHDoxDbJCr4bLn+P+2jLdb6JoCnLB4vaLP5rtbyLW8Tt4Uy
 /ciDT5bi/3tlOEYbfmvjx8H4zs9rQBLspGSC+M1gj0AIlyElfRz/pFofkza/8uZCRqce
 yeDI+SLXpa1eCkraF1+rXbMPamSO8su8uTL94zeuptkQHDi0ar7qiGRnVImW9y1foH3W
 oeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506350; x=1757111150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqY7gg7nNkpb5GHdIFMfU/GOMdyhe7cpOkiV9a020oI=;
 b=LdRN8Ufj9qm4oVQM5Pr/fxZ2q5TY+3S7/HSQcf2b+Wh6ygKvhP1iP53le4yBUr5FqO
 oXqFnEG60J7JKYwU9oiOUv+1xtA/aYKZd0w3SHxCwAICmKgTMQk5qMz8ySxQTw8BJwPD
 BuNEd+Y/3+TIUx3oS7uSRu8P2U06t50g3LLJR/SsXH81L9ml3PzVeg3kNwKrjYfocukR
 JdMKqk4H/149niyq5S/nd+zSIAFYgcI5OibnFJrNLMRazRCC0BrtzKWS7AqQb+Uv9yHg
 VStcl/thrS6kyuEuFTd1GIkVhSOfT8vWhPxRsN2/83YAGKJuU5POMNPLHiM8FyiVENMV
 f30w==
X-Gm-Message-State: AOJu0Yw1PPFsECdkG4L6yW9y1NF6CJwRdfB+AZSXNaBcLN30VT+8eWOg
 /5/3YGMpDTkL/t3c+jeV6VzB/97DqJt2K3nOw74BP08EDVMo8diOFmUTNL2uM5GUfKpWp6Jgb5c
 vIgrOGrU=
X-Gm-Gg: ASbGncu0+4E2rkdLMLBBvtAPied2U1U3AWNTMpyF366KewNDfR188/HeEThh5SGXSD9
 Xm6ZZBcy/ifZc0cl29y9lwT/2x5PBYoQQmUGlkF9dww/cB3RYtVu/GTp3Axu1bAHS0Ka/ICcU3t
 VLu2SAnq+zrDEhJ+MPk206NQSNLVTh+dWCATqdoYU8BysWO1WXaKQhRpPvEW5s+n6ezm2F70tZd
 62F2yCry4GyyYwH68Z6pY5WkS/f87ZuljJYpygUfPEnxyiCbxeqJ4e75xdWUpESzRKYHKTnXn5o
 xuZL01OR3XctUka7hYta97jcxglZVP+a8u6E2onCMRqcuZJRDWCtgLrWcy2Wz33vW6AvXCGsK+J
 +eXE9ob77w8VKxSFj5E0JRW7pu4ESfHN7evaAabbk6oef6OXSmJ/Fu7uJ7cA5
X-Google-Smtp-Source: AGHT+IEr3xMyN8CuUgxJDbjgp4BXX6Q8+EAxdW/6VGLTbJXHaAURIjiINs+B4NO6LvnBbv1KJv5AIQ==
X-Received: by 2002:a05:6a20:914c:b0:243:bf79:b121 with SMTP id
 adf61e73a8af0-243d6f7e67bmr297892637.52.1756506350454; 
 Fri, 29 Aug 2025 15:25:50 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/91] linux-user: Move elf_core_copy_regs to xtensa/elfload.c
Date: Sat, 30 Aug 2025 08:23:28 +1000
Message-ID: <20250829222427.289668-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 linux-user/xtensa/target_elf.h | 10 +++++++++
 linux-user/elfload.c           | 39 ----------------------------------
 linux-user/xtensa/elfload.c    | 35 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 2c55c22e14..43e241aac1 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
+#define ELF_NREG                128
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7c783b74d4..5cdbdc20d9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -531,45 +531,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
-#define ELF_NREG 128
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-enum {
-    TARGET_REG_PC,
-    TARGET_REG_PS,
-    TARGET_REG_LBEG,
-    TARGET_REG_LEND,
-    TARGET_REG_LCOUNT,
-    TARGET_REG_SAR,
-    TARGET_REG_WINDOWSTART,
-    TARGET_REG_WINDOWBASE,
-    TARGET_REG_THREADPTR,
-    TARGET_REG_AR0 = 64,
-};
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
-{
-    unsigned i;
-
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
-    xtensa_sync_phys_from_window((CPUXtensaState *)env);
-    for (i = 0; i < env->config->nareg; ++i) {
-        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
-    }
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_XTENSA */
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index e35ba69a10..49e709a094 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -3,9 +3,44 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return XTENSA_DEFAULT_CPU_MODEL;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+enum {
+    TARGET_REG_PC,
+    TARGET_REG_PS,
+    TARGET_REG_LBEG,
+    TARGET_REG_LEND,
+    TARGET_REG_LCOUNT,
+    TARGET_REG_SAR,
+    TARGET_REG_WINDOWSTART,
+    TARGET_REG_WINDOWBASE,
+    TARGET_REG_THREADPTR,
+    TARGET_REG_AR0 = 64,
+};
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
+{
+    unsigned i;
+
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
+    r->regs[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
+    r->regs[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
+    r->regs[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
+    r->regs[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
+    r->regs[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
+    r->regs[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
+    r->regs[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    xtensa_sync_phys_from_window((CPUXtensaState *)env);
+    for (i = 0; i < env->config->nareg; ++i) {
+        r->regs[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+    }
+}
-- 
2.43.0


