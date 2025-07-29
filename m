Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC87C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugubm-0005R2-Kn; Tue, 29 Jul 2025 20:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIq-0004So-5D
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:16 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIo-0004b8-Bd
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:15 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b3226307787so5325213a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833853; x=1754438653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JVZBfD9GVwK8THkDvUogyNfVZNMyQ0SaiRaMt8vLaiM=;
 b=UsMjoi4X8Abrl1wINUvbyyq66yxo7kLJBLVHB7e6cMii+zCWrHw3sIJZ4ZFrKdkjrz
 GiGKhpk10pshJM+/CHiNg2CIVF2bFkT3wd/K26RjG7Pm/TWo1pIL39vVxyDBuJt75ByX
 rOonYy1Gcp+xgYubWrwkeFv0MOxnq6dYlVH0V7P0pFnXij/VHX9Xj3l42xxtiqNOqeIU
 QkqjAVht8bM2McTZ1uuFEjgLQlgTB6Cw/08PWjgJvAB0+w7RwNQzfgzT0g24J/nME52m
 uYh6zA0avPfKt9clVCazepJIqnaIviaEQ/mMK9Kp8GfQklo0SPJ2lxuvFzu/uh0G0I0h
 kYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833853; x=1754438653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVZBfD9GVwK8THkDvUogyNfVZNMyQ0SaiRaMt8vLaiM=;
 b=TC+ceF2yUTAvkmmdk+h80jBGe+W77WWXVV3kto/hDXhLpH4lhw3cvlYEKJD+wi22CU
 9vw7AlUvsxC1p28doNsDsBM2BjMfIMLIvPfS96MfwIYF7SPtK0uY0B2w+8YFwq2qrqlH
 tdrBq3XQJu0w66Jlc23Y4UPeE3+S5Tu6hARk+D6QhCWZ/OGa0B/c5bs9AWDZC8wPXAyi
 aZiWl4GH6o9SBnxIwhlcg8/YbB20acNQjrD8ba+WLLlLKGMlcysWca0XTmRFe9ypAhrQ
 kpaptsCvkUzJGs3LaBVC01czRFrm7IcrAVxRZReHQNPi+YcaIIjpSZgX0x19JxdplIXf
 FvpA==
X-Gm-Message-State: AOJu0YxP8p/CymlOjOEQzgN+kWObHVMTrkihNm4JJ+gJZomyFOVYick3
 u/HdFwmqfYjhL3IqHeOzayu+8SUyL6UGmfH9DCcG+CDMvpOoM919Q3ut+qc4JFz2gpZbQ0LUl5Y
 VRo/S
X-Gm-Gg: ASbGncts4Hv06MwqZBe8iuKbm64T1SasC+YQxRfbBOZSS/tjnrI/FkcGWKHt9H1MFCN
 ijA2mpoyxM9F6tRCpV0rZd4IPNhQNnq6Lc3oUYAOO+8KzUkstxHBrisv6BCE/jZX2UIPd3D16oA
 y8gcYR16v0UrrdcZdv3wvoeVzRXbveKZ9v9nm3iNrLHQT+xFqDaV7RuVvM0LBicpn5privO49jD
 LDiBE85lKsDXARgkqP1GpdZcj3oXl9YeKA6SG8TyQdJnCw33qTrK8VSRW9EC8Jih4gCPFBqHQHI
 ZUqJnxfmUulN4mVU6UUy3m/tvro3NJ9Z0I+zoIus0e6bZyKBbgG2ylnHuz6yP5Y1ZmpYKYJlNFs
 6umXlTOAJkzO6RPM5BwxcxiXT2ae0ZZ3hkAg5tjzSxumeOhNTKQLiU0NJnPwWAgbtzHXRiAHdJr
 /96mk7hsd0PZYx3LlUqekQ
X-Google-Smtp-Source: AGHT+IGlczixyKwWmje4l4Xu4WVWtvH9CguvAxdtvGQJKKuHEaJDRmEq6cgStCED1zChVuMl6u08jQ==
X-Received: by 2002:a05:6a20:2450:b0:233:951f:a572 with SMTP id
 adf61e73a8af0-23dc0d58b95mr1892396637.16.1753833852584; 
 Tue, 29 Jul 2025 17:04:12 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/89] linux-user/ppc: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:18 -1000
Message-ID: <20250730000003.599084-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 linux-user/elfload.c                 | 24 +-----------------------
 linux-user/ppc/target_coredump.c.inc | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 23 deletions(-)
 create mode 100644 linux-user/ppc/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 57bb011e63..a6e4ac86bf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -376,29 +376,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
-#define ELF_NREG 48
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *env)
-{
-    int i;
-    target_ulong ccr = 0;
-
-    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[i] = tswapreg(env->gpr[i]);
-    }
-
-    (*regs)[32] = tswapreg(env->nip);
-    (*regs)[33] = tswapreg(env->msr);
-    (*regs)[35] = tswapreg(env->ctr);
-    (*regs)[36] = tswapreg(env->lr);
-    (*regs)[37] = tswapreg(cpu_read_xer(env));
-
-    ccr = ppc_get_cr(env);
-    (*regs)[38] = tswapreg(ccr);
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
diff --git a/linux-user/ppc/target_coredump.c.inc b/linux-user/ppc/target_coredump.c.inc
new file mode 100644
index 0000000000..7671bf86e8
--- /dev/null
+++ b/linux-user/ppc/target_coredump.c.inc
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
+#define ELF_NREG 48
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUPPCState *env)
+{
+    target_ulong ccr = 0;
+
+    for (int i = 0; i < ARRAY_SIZE(env->gpr); i++) {
+        (*regs)[i] = tswapreg(env->gpr[i]);
+    }
+
+    (*regs)[32] = tswapreg(env->nip);
+    (*regs)[33] = tswapreg(env->msr);
+    (*regs)[35] = tswapreg(env->ctr);
+    (*regs)[36] = tswapreg(env->lr);
+    (*regs)[37] = tswapreg(cpu_read_xer(env));
+
+    ccr = ppc_get_cr(env);
+    (*regs)[38] = tswapreg(ccr);
+}
-- 
2.43.0


