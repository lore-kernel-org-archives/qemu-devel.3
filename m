Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080ADCA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbVz-0007iy-5N; Thu, 28 Aug 2025 08:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRr-000314-6F
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRn-0007In-Ob
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7720b23a49fso940724b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382981; x=1756987781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGYZ/16zBJfYDfE4nRu94YbCxMVoWNYG9n9EpekXW5s=;
 b=C0Bb041CbJGgqHTKr2VfmPHCZUhS1g6dLtAfrDk28vjMGhBpRfkT3e+kf4nu6h3beQ
 n/zws5XBL1ryb40Uk6l8yDHgsRKirRWZxoxxjKPCfrHVDJuzZ/Yrdkzo/8Js1xhMAFnK
 A3zSBrXHtJSVs0zAjLNx92Trta/gIB75jY5ZNEHjqUv2zpz2h3xWigEQSwtQ5WJxEbzS
 +FvtzNIDjrbZYNSSpyqk76Cruzg2UimPrWbDCVXfX8x0AaBAaH+jH59cmVOgiLtWo2MA
 DhBdKusiBwtvOWRWLE+FXbNpo2cC+rJqV9vxOKXOUWk5CSYLPSF5myZaNfgn20cn/3bV
 Xbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382981; x=1756987781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGYZ/16zBJfYDfE4nRu94YbCxMVoWNYG9n9EpekXW5s=;
 b=B3Y13AsH8pslsXI7Vqtl1R0ndSaCv9UGVDRxZyaLw9sKSlVyqKerYNRjOKXUTOeezy
 E+lddlejao6l0RWIk7rihahT4925VCAachD3K3r6MLxuNI7WC7OrLSl5l2sUizf0vuK3
 ipy6/fGSDiAjAqACx/mGymMypgvunW10TcGhcuWeohZeFfA9b1yCsztpVd3HhilKsbqY
 UFC9o1H95bzkmBzdMc70u8vCc2OCv2tbu2KuNgHNj81G/J3sDS1wN/eD1NuuofOjlg06
 0S6Z2i71yt6c+aFfAO7NaB0/CmI1Rse8mINU5NrXBcRd8DebEx9Y5Nax151DVNT5bNLR
 2/1g==
X-Gm-Message-State: AOJu0Ywhz2QBrhz9WJP1gPx5z8CPDIqJcl/1tjQowEll0hsV567Nd8cF
 GeRXX0zl9JjnJSrES+gB1Iwhy36M4Qxob5fJySxGOkOu/+ZvyM1LB/VdzQJR4P6Rw0dJk3+NaJs
 0Pf95Pxo=
X-Gm-Gg: ASbGncunAWmKmP+ycp2qw47FbACmEp97Qe8srKTWYZHzJo8Oefnna/yiGK0GP/Lf7mB
 JE0vLrsDespGa87IpSZ0DKA1P4CG9moL+yNhiq4iqhlO3cNaNdz+TjJo9oWzkHArtNffPjjUNmx
 sKcTVjdKHQRuf8NWuGgofeCTW2djXlPrySYykkm+RgESTg6dMMzO9mq2wgzg3fYlrDLFq5JaC0X
 jZUxjFLPcSZHZwPfxvQWYG+2gVS/zkJzfH5WR/k9ou8vGVptkM4P67QOxEwAglS4EAHx7xdKD8y
 TZrHggXQdyvyGNayR3SZDJ4hzIRmBCAXbnVEsXRk7B+1bN06svsj8YC9Qp8Az5C089W0aVa8kEB
 DmizSXrCnONfeOSoxMDbXEwuJJA==
X-Google-Smtp-Source: AGHT+IFaIHd5iiumBcD7BiXgat4xVST+S/YVfk6Qu2zUs+VIy5XgJ9s/h3rK2JA5s5MwoMpZ1q5Yjg==
X-Received: by 2002:a05:6a21:3286:b0:243:78c9:1637 with SMTP id
 adf61e73a8af0-24378c94c0bmr20728275637.42.1756382981477; 
 Thu, 28 Aug 2025 05:09:41 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 25/87] linux-user: Move elf_core_copy_regs to sh4/elfload.c
Date: Thu, 28 Aug 2025 22:07:34 +1000
Message-ID: <20250828120836.195358-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/sh4/target_elf.h |  9 +++++++++
 linux-user/elfload.c        | 33 ---------------------------------
 linux-user/sh4/elfload.c    | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index badd0f5371..f7443ddbac 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -9,5 +9,14 @@
 #define SH4_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/sh/include/asm/elf.h.  */
+#define ELF_NREG                23
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8c3ef41312..69532faddb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -433,39 +433,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-/* See linux kernel: arch/sh/include/asm/elf.h.  */
-#define ELF_NREG 23
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
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
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
-{
-    for (int i = 0; i < 16; i++) {
-        r->regs[i] = tswapreg(env->gregs[i]);
-    }
-
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
-    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
-    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
-    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
-    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
-    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 99ad4f6334..71cae9703e 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -36,3 +37,31 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
     return hwcap;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
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
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
+{
+    for (int i = 0; i < 16; i++) {
+        r->regs[i] = tswapreg(env->gregs[i]);
+    }
+
+    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
+    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
+    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
+    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
+    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
+    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
+    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
+}
-- 
2.43.0


