Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD668CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkV-0002gg-Rn; Sat, 30 Aug 2025 11:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7au-0004Fd-Qo
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7as-0003XC-IL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-771f90a45easo2234846b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506552; x=1757111352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2g9oIt4VPwMetgB/wVKiRncFietrLuZrsmH8GdIqkvs=;
 b=kWYK/NHc80krr3Mm6Bo8YLGguTp5JoW3H4/pmNFNr6u1JKAvPz/l0ypZeuBpjB0ybA
 Y1SQ+5KKc4h3cpV2tFUDVvKA4X6NIwmFe6WAq2QzqyQNexY8tU1W+ioLqouXkEQXL7Vu
 5n6rtXKf57CIV6YpmkQzRpcFrP8gDEAL9Hk2Gg9mGEixpGgfJQ3cac7emZTjUhaiaE2W
 qz1XVJ+/Wyts2iH3uz01mLY6YKikht0KoGNUb/J3MUITGhCiVzun9VNB9CaVFtxzb4fV
 DEbrTRCr3ExbE5d0HrI5CdSGaLWVAYnVkoDw2jVVUFj2MIDdsjNTq4/IyVhcq+nF8vF4
 QhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506552; x=1757111352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2g9oIt4VPwMetgB/wVKiRncFietrLuZrsmH8GdIqkvs=;
 b=dgvSxg4MV/9m2jowNMqxG6Nwy+9mL6Nx95cmyhUz75dN2nfGd5M+j5r3btikn/ehZt
 744pWaobZv/qNpRY1LOslU9MPWCw9sr/6mIEPIKBrNVJJ3OClypL0zZFOeka0C6QHAA/
 8H8pwJZk5qcMvM+RcaB5ODI87NTtHMtgSFP0CyoO48+oHOVMXLJcceAj/0C8wDQXNGvC
 Rn2cubovIf4dUsXH3xwRfZph37LpJrC2HNsRHq33y4abn201yyxk0DXF2GWf0RviumYL
 nZU8tclqjl7QhiVWQAvktragw2Kjq1ViWgt0Q9Nd+orAhVgXDmNGSdSzofymzNylPJz7
 9k4g==
X-Gm-Message-State: AOJu0YwQOoBUVnfHcEaXIVT7+mwAjL1RzDDbYxxS+ThfzD0ZqhEHaePt
 xQA7WA/t1LnmQF+36HVmDorqjalD6pGLkaOsFOQ0cW7wm/mYYfRtggIPHNCHbMBGQyvD3nBEOiM
 q4O9xUbw=
X-Gm-Gg: ASbGncsqYQ+XgQdjInzB0UAGPUrHR3KpZCHr0iBWTI3k8M/Spq4rg3XtUSHQ8zoFLXu
 LPIVzQ+hhpg+Yh8emNYNbmjnmLYUTyzyvS0U1D7PQEF53nxMPWHNCcRqLUxIA6dNFgXDPXUEcRA
 /vTwMg3X2nK/C58Nz1KgGGLh/2eBZr3A1BPmhV1sy7q1gx78l6+usKeusiD6bfm7TQvLO/JYPyU
 yerOM9P0/9Kvw0nUEGpJKdrWxohmsgzrVZjSqs0/NnJDp7Fo9D4fPHYXZZFW2b2rrWx9+6Bs039
 vEuwhJA7OaABCkOlC4amUPPIZKBH3UnrBXaqNQ4dL3Hja+eUja0W6nS7MBIbScad5OdojyiJiGs
 agPacovO78B4RVqeu2QZc+GaS7/sWHTgrn7+4YjvN8+IESAPvd502YYFxZumUo6e1uU0c4RpK31
 KGPdJsBwDm
X-Google-Smtp-Source: AGHT+IHI6U/jfzqaT+L/sJRm1f3mhmnEACaC8NmzV2UuJS40DasTHyIwCw8EofxDV2xxrqU5JIdZMA==
X-Received: by 2002:a05:6a21:32a8:b0:243:bd98:de64 with SMTP id
 adf61e73a8af0-243d6f02826mr297189637.28.1756506552510; 
 Fri, 29 Aug 2025 15:29:12 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 40/91] linux-user/aarch64: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:36 +1000
Message-ID: <20250829222427.289668-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
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

Make use of the fact that target_elf_gregset_t is a
proper structure by using target_user_pt_regs.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h | 11 +++++++----
 linux-user/aarch64/elfload.c    | 11 +++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index b0728a1008..9eb8bb547e 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -8,16 +8,19 @@
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-#define ELF_NREG                34
+/*
+ * See linux kernel: arch/arm64/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 00550f9fdf..07a0c3f844 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -349,13 +349,12 @@ const char *get_elf_platform(CPUState *cs)
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->xregs[i]);
+    for (int i = 0; i < 31; i++) {
+        r->pt.regs[i] = tswap64(env->xregs[i]);
     }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
+    r->pt.sp = tswap64(env->xregs[31]);
+    r->pt.pc = tswap64(env->pc);
+    r->pt.pstate = tswap64(pstate_read((CPUARMState *)env));
 }
-- 
2.43.0


