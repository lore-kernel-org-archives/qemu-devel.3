Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D277CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkJ-0001Xa-1t; Sat, 30 Aug 2025 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XP-0003AU-H4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XN-0002zq-Ge
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1100307b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506334; x=1757111134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfGPN4/CleWn6sgibqL120GdBiTvuQNA01BElWGoypk=;
 b=qwBvAjQyBkcrtI6/t8BJigRdkEUiqO2+9Fqc4p/R5R70WQtJXU1Z7R4vuDajO3qxrz
 +ht3LB5WAlPEpEI7x3cAK5L4+pr48CJGZiRVDaiISo1HszeyW1fgYlDKO3XsunsOM2BC
 MJ8J2a4KkA0HLVA7PqRDsUzAT/ZwsXAVhyDYwT2Fszf1tiCfSJL67Ie1a9y3pGuRsjXe
 mxOO+PbjKPxSj6BSd/5lH4ZZX1FM31tmAGCwtZDycJ2vruZC5c9j/bjN+mTbhYfx7Ev3
 pWeYnnf0GnVpbS6r5i6365GjrIzsLT76utSo5c/Azi97EX9MgqC90QJTLUdexLSt8TLa
 MA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506334; x=1757111134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfGPN4/CleWn6sgibqL120GdBiTvuQNA01BElWGoypk=;
 b=d7OEZDqORaBzN1O4htGynZeScPqYLR/T28fZjiT8n4zY8gUqBKXHN5f1AX1atYx1ik
 2mgFPzX/uONsagBPi8Uur/hH8gjzw5ZMitLcz8wEI4kDu8gI61jJF2X0qmzuaCSqWuyo
 KxKunSH2O2uZx08kIhqG3ei6beTxNyU8qnuk+WkOQN1XQeAiRILUIGw9FEefQcpu88YR
 UNAPEsPYT6fh38XrE8l4BEC+E1b17w6lXmoYfMu90B13zA5x/2PcprxyfP0Ux/H4HTTI
 LeAw0uy37UIFHhKxNp/OwPszaAoP3CJbV8ekcHOKDZkLSE1/Bz0IJvvdtzD2kpTGXJGg
 o3ag==
X-Gm-Message-State: AOJu0YyghtO38ecM0gzPol/UZwz88gEivZwtn1uNu4lhgUoLI/umZWLS
 k0WK3i6bExQYh2Wq433zsarlluIS50zZVfXMfWUpcWTZKKLkEnvfyV4Px9wQb+FmG2l0OE2Qsi0
 2pnxWNVI=
X-Gm-Gg: ASbGnctRJ/l3kvj9c4YHwRVexKRYzAIePAFqnLif+ItDFN3usSqM/y5CE1GhoCkK536
 JJd+F0bWg2X3NlJ5X5zc1b4fuOxZI5SOvVELw+m0ChtVSbhHrtnS3+elGdaueIaaEiNEN6R6AZQ
 6ZF3T9Pm//DNvZsa/WcIkRQ7Rjn3KGmND5iYSiS05SX5EVaUQL3w3U8s+XZv3VvTOxEzffmru88
 JeeV5dS2ENlMj6gVXVyw0GrjoaSfZKgMpslqd8MfI5RG7/I4PZl8GdDei5wR5ODLR3j2iJIt4QE
 1yOlz+IRKzBPq0OQEpIpFSTRG/SVy5XKDV1bajhL4VNoPY1EUjq4X1iBYGa9Q0z+/MmqrLes6Yq
 LOUySleWNbhmKiklMfmZGNSH/zQfu5eyJ3J3Ppcr9q4hkIhU2keYisAMkLt9V
X-Google-Smtp-Source: AGHT+IEvDIRIIWhAJWxqg6k6PRAUibtL7TOOH1n3H3Y1DBUJcQcYXCHH6HQAB6MoGi/R1fb5j/QAQg==
X-Received: by 2002:a05:6a00:2314:b0:771:58e:5b1e with SMTP id
 d2e1a72fcca58-7723e387aadmr234757b3a.12.1756506333859; 
 Fri, 29 Aug 2025 15:25:33 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/91] linux-user: Move elf_core_copy_regs to
 loongarch64/elfload.c
Date: Sat, 30 Aug 2025 08:23:21 +1000
Message-ID: <20250829222427.289668-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 linux-user/loongarch64/target_elf.h |  9 +++++++++
 linux-user/elfload.c                | 25 -------------------------
 linux-user/loongarch64/elfload.c    | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index eb17927325..90bca4499d 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -8,5 +8,14 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/loongarch/include/asm/elf.h */
+#define ELF_NREG                45
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d1d0a112fb..4acd7b9ffe 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -383,31 +383,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-/* See linux kernel: arch/loongarch/include/asm/elf.h */
-#define ELF_NREG 45
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-enum {
-    TARGET_EF_R0 = 0,
-    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
-    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
-};
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
-{
-    r->regs[TARGET_EF_R0] = 0;
-
-    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
-    }
-
-    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_LOONGARCH64 */
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 911352840f..832890de10 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -61,3 +62,23 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "loongarch";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+enum {
+    TARGET_EF_R0 = 0,
+    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
+    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
+};
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
+{
+    r->regs[TARGET_EF_R0] = 0;
+
+    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
+        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+    }
+
+    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
+    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+}
-- 
2.43.0


