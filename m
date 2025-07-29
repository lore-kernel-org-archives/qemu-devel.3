Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63C3C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucM-0006jo-QW; Tue, 29 Jul 2025 20:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIx-0004aV-Es
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:23 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIv-0004cX-L8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76a3818eb9bso859702b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833860; x=1754438660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MGwpdb+FITRs1No26zWUpXN/KKrncf/Yen4+5aLT7Fs=;
 b=dAH74DyzsgmjoA3L1MmEHcPlllEOsFtDK3QuMEv1Oj1ed8keYEEyt3t7gA1QO/6eCH
 +XST4waO7mXyE7//AaDiUgabnO1F6JldVj5F3j/cTrLg66LMGU2msZt7J0hrfRWd9cpT
 0SmZR7XYIFB2esRNmY5NhvSvIXkFJTltxoT8pKQ6y5KFaojigdhAsIjLCzzTmqePM+Cv
 8GuLw1sGx63y+fMgGgSrgcRmlyDduh6qqy4QXKPU2ZYF82z9TE+vXjShEfBwmrHp8rCm
 taIhWSmA4cRZz1yjt6OFdcmoAwztJKFXSQxHANRLekv96nFofyT8JDi2vkF74BhHNyGv
 UQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833860; x=1754438660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGwpdb+FITRs1No26zWUpXN/KKrncf/Yen4+5aLT7Fs=;
 b=MjfsmS2vnTliGcFKW1GBzFUkytdfnr+Ms0q7WAGisUE6/rCqcopySzjkpnN3o76OrK
 Xk15BSFUg53UUimU3Jn3rXdEdI4ryKb85WByIsWtNZ04yYeo9lNCt5w4/LYttxNck3l8
 g7i1oRn33CQ8mO1LHXqsXQEOqnz9CU9XA1h0HgrHbNdFQC9nKxHUy+Q4XwRwy0s7Zdo9
 3m5E6QhN3ipfYzEwsrt9Pn73fXOFjLtzyqjfpMfylb2tPMSxGDLUg3VgeD5a6CSVbUmR
 vUk7ZVh764oWt4Y7Zkxgrd/kM0XEW9TeO5bhZM46eEJmulhxeQuO6CwMfYeXuodhesj6
 jqpw==
X-Gm-Message-State: AOJu0Yx5We3gItVplIXoGbI6WfNGn2aqMbDwk1WYlx6qaDnNR2zAg0jA
 sM/Tum3xaswRfw2GIgik8BFmBgdvMHokaYkTnLnV8iwzC44Mkitcp46NgCVeAJsc3KnvOVtfDOS
 wfX5s
X-Gm-Gg: ASbGncvf+uZnES7cS4bwImbia3+nIe+ocLh/04eyms2DQMCrwPmirXaQ89r/wmDuieq
 vgVP+ktr/D0A1ABmlhotnazqUZBWOvSPWdcAqcDKemczWBjM8OoaYxXWnZ5Yjr3i4lPrlPJ2yAC
 i0na/vvnQOyWcHVdsojArCvSOiveQbxXFrGMtBvXXpA17AhRgi08TTlY0cUExOFhqQrMog/VSLA
 XK0SYYif6r/LF5M7ubCNUTRx0ol8Tfpd4gRM160a2oGL6XDcyo6b6QjWvsajq0NYPLszVEILmOu
 s+Qm8ImGuy15URcsDmjcdVf8fk3Cy9A5Ep1s/Ct4n7PR+83Ux8gs1rYUkN5qBGa0Mjzo1f02UvP
 nBV3MSUg5uoILgn0dxCLxCCN/s+sY+oVQV1moejoHGeBiTzC4DnaGt2hvOj8hbJWO4u7LSSxP32
 9v2iD2Cx19dg==
X-Google-Smtp-Source: AGHT+IHpWpHBVqUwdafsLghwUbLWKkQVsgRvYo84gG7GXl1Wkrnz+t+fr8M5J+cvXduSaTo4kc8mjg==
X-Received: by 2002:a05:6a20:7347:b0:235:7452:5859 with SMTP id
 adf61e73a8af0-23dc0e84b5cmr1866433637.30.1753833860042; 
 Tue, 29 Jul 2025 17:04:20 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/89] target/sh4: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:23 -1000
Message-ID: <20250730000003.599084-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 linux-user/elfload.c                 | 34 +---------------------------
 linux-user/sh4/target_coredump.c.inc | 32 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)
 create mode 100644 linux-user/sh4/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 051e9b72cf..836f01e579 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -458,39 +458,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-/* See linux kernel: arch/sh/include/asm/elf.h.  */
-#define ELF_NREG 23
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-/* See linux kernel: arch/sh/include/asm/ptrace.h.  */
-enum {
-    TARGET_REG_PC = 16,
-    TARGET_REG_PR = 17,
-    TARGET_REG_SR = 18,
-    TARGET_REG_GBR = 19,
-    TARGET_REG_MACH = 20,
-    TARGET_REG_MACL = 21,
-    TARGET_REG_SYSCALL = 22
-};
-
-static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
-                                      const CPUSH4State *env)
-{
-    int i;
-
-    for (i = 0; i < 16; i++) {
-        (*regs)[i] = tswapreg(env->gregs[i]);
-    }
-
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PR] = tswapreg(env->pr);
-    (*regs)[TARGET_REG_SR] = tswapreg(env->sr);
-    (*regs)[TARGET_REG_GBR] = tswapreg(env->gbr);
-    (*regs)[TARGET_REG_MACH] = tswapreg(env->mach);
-    (*regs)[TARGET_REG_MACL] = tswapreg(env->macl);
-    (*regs)[TARGET_REG_SYSCALL] = 0; /* FIXME */
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
diff --git a/linux-user/sh4/target_coredump.c.inc b/linux-user/sh4/target_coredump.c.inc
new file mode 100644
index 0000000000..559cd21b1d
--- /dev/null
+++ b/linux-user/sh4/target_coredump.c.inc
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/sh/include/asm/elf.h.  */
+#define ELF_NREG 23
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+/* See linux kernel: arch/sh/include/asm/ptrace.h.  */
+enum {
+    TARGET_REG_PC = 16,
+    TARGET_REG_PR = 17,
+    TARGET_REG_SR = 18,
+    TARGET_REG_GBR = 19,
+    TARGET_REG_MACH = 20,
+    TARGET_REG_MACL = 21,
+    TARGET_REG_SYSCALL = 22
+};
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUSH4State *env)
+{
+    for (int i = 0; i < 16; i++) {
+        (*regs)[i] = tswapreg(env->gregs[i]);
+    }
+
+    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
+    (*regs)[TARGET_REG_PR] = tswapreg(env->pr);
+    (*regs)[TARGET_REG_SR] = tswapreg(env->sr);
+    (*regs)[TARGET_REG_GBR] = tswapreg(env->gbr);
+    (*regs)[TARGET_REG_MACH] = tswapreg(env->mach);
+    (*regs)[TARGET_REG_MACL] = tswapreg(env->macl);
+    (*regs)[TARGET_REG_SYSCALL] = 0; /* FIXME */
+}
-- 
2.43.0


