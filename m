Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C236C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguYc-0006pR-S0; Tue, 29 Jul 2025 20:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIv-0004Yd-GC
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:21 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIs-0004c6-Pa
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:21 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-749068b9b63so243459b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833857; x=1754438657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YT5Dw0jEKgC1/JLaOSqyR4nwF5hDqmJ+TxNAy/ecj/0=;
 b=oAfPi07UHP0Y+TIP1fBd3LIqpGT1GCFyrc4RI4Tc3pJelYobQDKyFWlyaGa/Y3e6uv
 vKZJFgFXYn4XCCTMrOB0iP0wzIf4eNGh13hBxCQ1C4hSq62bYuENCEIZqZ4fpXnAVRD3
 Bc1zekvrwlp9SdBz6FcIt9bX8cjNS0B7sxS37N+PQSSbS3nBOssn8qzV4VNmjR+G1QIF
 AcXrhPBmt75PGtrD3se3gpnRwpt5rxmVGmNYmzzRLb+I+fGoRWo0gETFMpMsP0nS6WiX
 Q75FK33rRVVgGkjlVjBSmtNeBgx0sGYSWf0gN1wfX7Gjz6w2T5EwL2RwBUPMUJCFY/Tn
 OA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833857; x=1754438657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YT5Dw0jEKgC1/JLaOSqyR4nwF5hDqmJ+TxNAy/ecj/0=;
 b=HbwKGImyJo95MXk+4VqyfitHCKb4TPla3A7Cc5R8ztOdCm2IJ0Rd/1lPQZTWouRGR+
 BWRYlhKrAGk0Wm2MY6MkYFGjCIDFDkpqoB2EvcTJnAZGqrV0bccj55nazUA316MFvokW
 e4+AuRxMwbmRVzemNjfRPuC0J5sHyJMxe+BsltCWLfJe1827X0jzrU9s7nTcjtb7e49e
 u/LGx3Zk9ziDTQw/2N8VfcCR/uT6q42qqMyzOl2nnFIs0TAmWscmyZPbU1QpOVNN7qAv
 R4IXkBFC5alwp/NcVyn/B7M2/FtvT6zAkfP5fBKjfP5VSKLu12AeaX+7L211Zgc3Wv1b
 it1g==
X-Gm-Message-State: AOJu0YwHSMNzY0HdqKKVfYSTPC9CTM9RlT5G7QcU2Lfn4ZbxcjTu/Zod
 iSlUZZwRxKtQ/fhL0Vs0eTfOOYUm5MWEhtdm5JEsgg5SX8tdTCQZcX6da0Zcfh/aG1EYUjXb6TP
 yI5h4
X-Gm-Gg: ASbGncsipUnIQsV6t4p2+L3kNQlyrXBqHbKzPWV7A9RVZsX6Y7d0ZHXX4zCXAFz3/R+
 Sp2dkU12VBI/secyTAoet+nhMnaZqBHmAJFLrd2f6P1Gsd4z//6QN0CYBoXsq97dSbthSK+RJs/
 1XP1GUB2ERLXZG+tirQmYZ8+q6PqYSJiF2yy+OxQYO3x7WcAZY/5y+W2zvTq39x+vz69ors+i4C
 5Wn47e+XxIrQufo46g/8tdPmhA00ZA7zz1INmMykDeNa8BeoXwkFauQctgqRVyxFA0qjgIASpHD
 8XtxEjxrI2ZoarHCNyeIrcBVrj+56vYy4DHZCJS9MU46ZvkA1L6eFGWsXWLRlWy4SQfXQUNSJ53
 0utKonbg+wKQugwAp0E+G+9KrjsM2RACo550C8XwFEgS1zNoVuJnuH9LuspcEctuon4MbDiZ13K
 Lo9s54Kg1zaQ==
X-Google-Smtp-Source: AGHT+IGU/q8wiao7jwkNlxNRGhpS4UCVy+VdvTgT/KHtwvQL3R6kns1lw71dRSx/c0cRC0nxsWGNKQ==
X-Received: by 2002:a05:6a00:4b0c:b0:740:b394:3ebd with SMTP id
 d2e1a72fcca58-76ab092312amr2042018b3a.7.1753833857342; 
 Tue, 29 Jul 2025 17:04:17 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/89] linux-user/microblaze: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:21 -1000
Message-ID: <20250730000003.599084-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c                        | 21 +--------------------
 linux-user/microblaze/target_coredump.c.inc | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 20 deletions(-)
 create mode 100644 linux-user/microblaze/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d37e580ada..59d179092b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -437,27 +437,8 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_EXEC_PAGESIZE        4096
 
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
-#define ELF_NREG 38
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env)
-{
-    int i, pos = 0;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[pos++] = tswapreg(env->regs[i]);
-    }
-
-    (*regs)[pos++] = tswapreg(env->pc);
-    (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->ear);
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->esr);
-}
-
 #endif /* TARGET_MICROBLAZE */
 
 #ifdef TARGET_OPENRISC
diff --git a/linux-user/microblaze/target_coredump.c.inc b/linux-user/microblaze/target_coredump.c.inc
new file mode 100644
index 0000000000..11ef0e3e92
--- /dev/null
+++ b/linux-user/microblaze/target_coredump.c.inc
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define ELF_NREG 38
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env)
+{
+    int i, pos = 0;
+
+    for (i = 0; i < 32; i++) {
+        (*regs)[pos++] = tswapreg(env->regs[i]);
+    }
+
+    (*regs)[pos++] = tswapreg(env->pc);
+    (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
+    (*regs)[pos++] = 0;
+    (*regs)[pos++] = tswapreg(env->ear);
+    (*regs)[pos++] = 0;
+    (*regs)[pos++] = tswapreg(env->esr);
+}
-- 
2.43.0


