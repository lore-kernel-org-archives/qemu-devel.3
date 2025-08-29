Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF3DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkK-0001lb-Hw; Sat, 30 Aug 2025 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XQ-0003Ah-Aa
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XO-00030O-8U
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so2837536b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506336; x=1757111136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYivKMLETGkzoEANM6kKEvsA5P64eDk8ymUZjDNO9+Y=;
 b=foch5G25B2mx/Kvr5U/3rUowWnJ1PRUIrWIydVvYLMfrkecJKTDMmQr08Ufj34Hpr2
 BerlrlxY+Ek8xsK8g+x9PIdZPXvqgueE1XbEgmeki9WJLrSQ/uQS4WWz7HkU5CUI0A3M
 VdRHF3y810dVhVY2SScO2OIe5AdSqvMJEKatWCuwHr80yJJNXCWgfCiD8MW9Oof281pH
 VfcJNyVt3xrZOeqqy22ocVr9yZSVBp7oFn9n9WRe5UUYj8OLH01u+Q20Sz7WMVsJhca5
 d+pQKvpQseUTLm94WXKwYmvZqIN40eBIPRNYZbKcA73S40I9MxWVFfj6X7xnFWGU+Jvb
 V2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506336; x=1757111136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYivKMLETGkzoEANM6kKEvsA5P64eDk8ymUZjDNO9+Y=;
 b=BqCMQ7laic3ihtTuzBg+bnomgdjTvgLtdaKaQZu/9Bxn583RUzq9RTNaRT4Yz62onk
 Ulw6KPhzGnPnAZFDrmAb9D9oNrrS8fg1/4Cngg4i0YXdF9KyWAFk0cSJOjVEvokKmp5A
 l+XjXLpPWKmIqdZXDNJRkUv/hV3RBJwhiPOILYy0foPAVVZlWey2fkaQfhNl+TH5jt8M
 cBYkhgCEEqalMuAJmtHkfFy2veZT4IolUTrEXBxjxv4ngBWyg62E74OD1b5Mp+6R+dFr
 oeNjtHuAxP6YwoVI4P3v9S0O6c9/AsSCvzsMnmwzuB7sUlsGo5HMVs4m1l9G17jjX0i9
 E/lw==
X-Gm-Message-State: AOJu0YxzYoRvoeEvs0F/j5EpX9RtxaOTbDisX3cLUNBrVNtAKp0CDMCv
 AEosQS37GZISmIsSPNY2bURu+NPM7gNyHtxokeW74arEEObNSFHR+ZKklSXoB2bpZgpLLnaQB4b
 spK2t2IU=
X-Gm-Gg: ASbGncsSWASd6VsS78J1o9yoZEbgD72N35gEwPLxNs2oDmuiMXBCNRZcKlhi42LqhX8
 Eznsq9Cz2YHpm5qBDgnhTnidiFOMD2UR6YYvSCxOLkocxJWD/M0JMUcVGyci5oVhMMxSJ0RtW0e
 z9CXOX6Lr1hxdGlUdrW4FIMdfnANEJSephUejFibsVxedub2vfpmtvakpmdkXmD/CIdUpf0/LFS
 pviCjYtuR3Dvwc9Qngbjapy71f5xv2+Mdx4d2EerL76ULOmemjct6KVIENRch290yAfC2PapqJH
 TNE8eBnISmwnN2aOsuwR2avtrhGUnQ69Q6+vDuxo+y9hx7gCwlxlSEIWXEiWeKwhRmVTOgPxJa/
 BrcBTlcdNzyHp0O0mCaQH8fdMa2LVMhZxyCdLoAI4H3ZkAKjT8VjyWAkIrElJ
X-Google-Smtp-Source: AGHT+IG3MURXW7D20+bIWpWjjZ9CaCFehSIiwBkPTfvgVKjoFN0V87VYX56YRZ9n1zSHLz8FT2ICaA==
X-Received: by 2002:a05:6a20:938c:b0:23d:48fc:652b with SMTP id
 adf61e73a8af0-243d6e009b3mr284662637.12.1756506336140; 
 Fri, 29 Aug 2025 15:25:36 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/91] linux-user: Move elf_core_copy_regs to mips/elfload.c
Date: Sat, 30 Aug 2025 08:23:22 +1000
Message-ID: <20250829222427.289668-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 linux-user/mips/target_elf.h   |  9 +++++++
 linux-user/mips64/target_elf.h | 13 ++++++++++
 linux-user/elfload.c           | 46 ----------------------------------
 linux-user/mips/elfload.c      | 46 ++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 08e699c085..f767767eaa 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -10,5 +10,14 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/mips/include/asm/elf.h.  */
+#define ELF_NREG                45
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 24bb7fcd3f..046a165eef 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -10,5 +10,18 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
+#define HAVE_ELF_CORE_DUMP      1
+
+#ifdef TARGET_ABI_MIPSN32
+typedef abi_ullong target_elf_greg_t;
+#else
+typedef abi_ulong target_elf_greg_t;
+#endif
+
+/* See linux kernel: arch/mips/include/asm/elf.h.  */
+#define ELF_NREG                45
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4acd7b9ffe..5a3a5cfc39 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -403,52 +403,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-/* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG 45
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/* See linux kernel: arch/mips/include/asm/reg.h.  */
-enum {
-#ifdef TARGET_MIPS64
-    TARGET_EF_R0 = 0,
-#else
-    TARGET_EF_R0 = 6,
-#endif
-    TARGET_EF_R26 = TARGET_EF_R0 + 26,
-    TARGET_EF_R27 = TARGET_EF_R0 + 27,
-    TARGET_EF_LO = TARGET_EF_R0 + 32,
-    TARGET_EF_HI = TARGET_EF_R0 + 33,
-    TARGET_EF_CP0_EPC = TARGET_EF_R0 + 34,
-    TARGET_EF_CP0_BADVADDR = TARGET_EF_R0 + 35,
-    TARGET_EF_CP0_STATUS = TARGET_EF_R0 + 36,
-    TARGET_EF_CP0_CAUSE = TARGET_EF_R0 + 37
-};
-
-/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
-{
-    int i;
-
-    for (i = 0; i <= TARGET_EF_R0; i++) {
-        r->regs[i] = 0;
-    }
-    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
-    }
-
-    r->regs[TARGET_EF_R26] = 0;
-    r->regs[TARGET_EF_R27] = 0;
-    r->regs[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
-    r->regs[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
-    r->regs[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
-    r->regs[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
-    r->regs[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
-    r->regs[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_MIPS */
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index c353ccc1ad..6e884911af 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "elf.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -122,3 +123,48 @@ const char *get_elf_base_platform(CPUState *cs)
 }
 
 #undef MATCH_PLATFORM_INSN
+
+#ifdef TARGET_ABI_MIPSN32
+#define tswapreg(ptr)   tswap64(ptr)
+#else
+#define tswapreg(ptr)   tswapal(ptr)
+#endif
+
+/* See linux kernel: arch/mips/include/asm/reg.h.  */
+enum {
+#ifdef TARGET_MIPS64
+    TARGET_EF_R0 = 0,
+#else
+    TARGET_EF_R0 = 6,
+#endif
+    TARGET_EF_R26 = TARGET_EF_R0 + 26,
+    TARGET_EF_R27 = TARGET_EF_R0 + 27,
+    TARGET_EF_LO = TARGET_EF_R0 + 32,
+    TARGET_EF_HI = TARGET_EF_R0 + 33,
+    TARGET_EF_CP0_EPC = TARGET_EF_R0 + 34,
+    TARGET_EF_CP0_BADVADDR = TARGET_EF_R0 + 35,
+    TARGET_EF_CP0_STATUS = TARGET_EF_R0 + 36,
+    TARGET_EF_CP0_CAUSE = TARGET_EF_R0 + 37
+};
+
+/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
+{
+    int i;
+
+    for (i = 0; i <= TARGET_EF_R0; i++) {
+        r->regs[i] = 0;
+    }
+    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
+        r->regs[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
+    }
+
+    r->regs[TARGET_EF_R26] = 0;
+    r->regs[TARGET_EF_R27] = 0;
+    r->regs[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
+    r->regs[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
+    r->regs[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
+    r->regs[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
+    r->regs[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
+    r->regs[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
+}
-- 
2.43.0


