Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29758CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbS9-0003Te-J9; Thu, 28 Aug 2025 08:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRd-0002co-V2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRc-0007G3-1P
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7720f231174so773903b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382971; x=1756987771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pX3cyAXzWaI+M+ga3mt6VNWQq5Iik+1mUsefsD+nYFI=;
 b=Ir8eHTJGM6MzX26lQjrYla52ciCR1/EFg5tjx38d6Oq8z25MgmUZehhlsh8X5BYpcJ
 7cefVQ+GnU4YY4qsK2OSSYVdZSrN6mQY7M4ZEWBfLCjREYb6q1MpaW7O9JVperblD9Lt
 3sQYvGQVFlGB8cpitWvw0RQxnwyH0LHANVALB3B/2CMAtZHh4A6u/Ny3k4fHvTXzDtdg
 SkgFd8a9pLxJ1ofVr6FQGyNsMHyj1Dm8mk0/PkXGMtBCVBJR1e6jDdT18MWihr2a4psW
 TBkI62TRYRbun/aa3oi9rjWdpK3J/JjI70omxOgrTOTKuikdkpXnK6aidW+Yb12ArjCY
 jRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382971; x=1756987771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pX3cyAXzWaI+M+ga3mt6VNWQq5Iik+1mUsefsD+nYFI=;
 b=aXQXEVU/Xy7Pd44hqd4ClkAizUmNNBK5FxPXAjd7OLXjlFtsB9cfEUmt5zn00m5rji
 jlfLyRRjyM8vcMr3eiHumYFP16k+60uwRijzHzVQwbjja2HvW7fLHcC2ekwaNtApJCPs
 LALM/JK3hN7cNWyeiltzyCzijTA2muRBVffs9kT8GbxVbNwF2NnX5h8nAzDRqXm36yiN
 xEo15MpC5alKNBgxP/aZ+RxUiRYQRNfbIBpD/aODt/gwFhkzb782wB/dDAgf+VGVF/q4
 JAigNejk0yC5XQNWXj4uLav0h6uz2/D7sqyWboUSqlj1ATGDowQrUtNkj3aHuyx9frTx
 6U4w==
X-Gm-Message-State: AOJu0YxwXVovl8FkFfrSsKf7yKVaCQIkWMudbL6cS7H+nDWBRlGgwuAU
 ckfDYU21nlBYcx1QwTeQ4/mZZrX9BZxzWdu7xNUk1kYkKJrIG++SYVi8gXc3P9/UFUIh5kX01Z0
 /Tm+oqMg=
X-Gm-Gg: ASbGnctK6vvA/nikBuJKHv6cBUaZDeRQKWPATv4kwGXeJmbzN9lSfg+wGnMT0xK3njG
 Mb9piRFVUVtxv6QjhocNOm4TvmbUZHAJU/RS4aJPLL58A7g2s33vauNvy4/Rak6506vIo+msl3u
 Q36Wjc5OFyNVK6qOXZt9y8/+BLF9a/WIPY9yfJSCEdlwE3onLx0Y5ByVv3wwt/TQSC5jsL3Afgv
 L+2Yq1R+xlvxFfCGENMBpsqYVJrb7ptG3y80fa3QjWwxFR19CoUyNJPqspUzCM3e0ACyRVu6Re5
 KDFrqflB83GExiw1YxmHOW05q5JWI07eVHBNCRiwizwOabS3IMPJAiSPdfNV7E6XegTAor6WIDj
 k0CwpJwTrX5M/T055dw+OmXWC4NN6LYU5Se4A
X-Google-Smtp-Source: AGHT+IE4Rwt0oYBXaL9moWaBU2U6kttoV9gM+jvHmkl0c9tFM+GmILqIv0lDcxyefCxGrjhJneholg==
X-Received: by 2002:a05:6a20:9189:b0:243:7beb:8424 with SMTP id
 adf61e73a8af0-2437beb8edbmr20990106637.46.1756382970585; 
 Thu, 28 Aug 2025 05:09:30 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 20/87] linux-user: Move elf_core_copy_regs to ppc/elfload.c
Date: Thu, 28 Aug 2025 22:07:29 +1000
Message-ID: <20250828120836.195358-21-richard.henderson@linaro.org>
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
 linux-user/ppc/target_elf.h |  9 +++++++++
 linux-user/elfload.c        | 26 --------------------------
 linux-user/ppc/elfload.c    | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 4203a89d66..72615553ea 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -10,5 +10,14 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
+#define ELF_NREG                48
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 017346b82d..d1d0a112fb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -361,32 +361,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
-#define ELF_NREG 48
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
-{
-    int i;
-    target_ulong ccr = 0;
-
-    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[i] = tswapreg(env->gpr[i]);
-    }
-
-    r->regs[32] = tswapreg(env->nip);
-    r->regs[33] = tswapreg(env->msr);
-    r->regs[35] = tswapreg(env->ctr);
-    r->regs[36] = tswapreg(env->lr);
-    r->regs[37] = tswapreg(cpu_read_xer(env));
-
-    ccr = ppc_get_cr(env);
-    r->regs[38] = tswapreg(ccr);
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #ifndef TARGET_PPC64
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index a214675650..114e40a358 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -129,3 +130,24 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
 
     return features;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
+{
+    int i;
+    target_ulong ccr = 0;
+
+    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
+        r->regs[i] = tswapreg(env->gpr[i]);
+    }
+
+    r->regs[32] = tswapreg(env->nip);
+    r->regs[33] = tswapreg(env->msr);
+    r->regs[35] = tswapreg(env->ctr);
+    r->regs[36] = tswapreg(env->lr);
+    r->regs[37] = tswapreg(cpu_read_xer(env));
+
+    ccr = ppc_get_cr(env);
+    r->regs[38] = tswapreg(ccr);
+}
-- 
2.43.0


