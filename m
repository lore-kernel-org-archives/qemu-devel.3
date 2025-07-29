Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF4FC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugubb-0004kV-5v; Tue, 29 Jul 2025 20:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIl-0004Na-52
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIj-0004aM-6Z
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so1845080b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833848; x=1754438648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SwxnF4qqNf4bM30MZ3SLjOwS3GMqPn/ph/UJVhS2pbg=;
 b=sWc4jV3+BsXyID7Zhsh1ewuUOcPe7BXKe6Ku0VHTtKRxu+Bd2hE23C5dg8kX12j7DP
 l0s3r59LUqOTkRnhi31U1ppNOGViOYCVhk0wde5vUo+pka1baH5+FwNNFKxcoUjCJoga
 N0Qzilh24hApYqg7et4vTE/xnRLrHkBSLOEdy6UqY8mkqSLTmT4o0xwv1KEHG44tdt/h
 zDwz/rWRhgXUNRTTzQNLK/vJBkvh8JpM3rS0I6/ifh1TSC/lGdoTn7xgowmdfmgUqVul
 YopD6d05VGmALue65UyAiHI5WokzZqyH/yHEMGYkDIlpUj7gG5KD2a4Pkj/zV4nYYbXh
 WpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833848; x=1754438648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwxnF4qqNf4bM30MZ3SLjOwS3GMqPn/ph/UJVhS2pbg=;
 b=IAiZRZy+/a2dTyq18BUkm420d/b3ZIHOF+EXd0b6QlRnSm8jW30vYX2hms+SUF8s73
 08Bmsdgr4aJRIsggIydCWV8D3mgr2tLOleIN4yhy4T+NKfNzEeMEfXUeZFmyAUkCqFxd
 EX391LEWNw8LjiHL7157iSju5EFvQ9MnrqGjP26nk5LJNszl1ZjDFlyIDhI9pa6a7pep
 UtAqfRGmyYKXL3kzGn5K89F7+ebxQjrLSqDIzgQXkt8W85HOh6A5xf+FAEDXFEL2crMj
 hkNy9Afq+6lpXfEJVOVs3/smCPW2ftWtS6WB8xlQVz0BUNBVHTljigafUe/LiGMDNtnj
 lk4g==
X-Gm-Message-State: AOJu0YydIsfMQ+NyfwHrZtBpmBNXleDvyy2a4gbptp6tsSpGhgWv0QDN
 pbrCtL06iEhTG1O/sG06DdfBWB25dkppHVUvXHZR3a6SLahhK1kS497yXPycGjv4/eNzGJ8k3Yz
 oSSww
X-Gm-Gg: ASbGncvg9yYgcIrKaoa+/lGRhDggKmVYIw758FD8WqEQaa13soAUHWC8ldlrWafgbMl
 WDPlqDU6ww58P5f1H16x0UQsqveR1CjNBDyXmHWWbYjAGT9i1SeX+YxSi0Y/uOWaVWsYiu4ug44
 tsSlKHH8Ijo4QJCup1yeGPXRDqmVCLqgRPtYPz3TjE1+PEP/dTo0WpXDmmj2leLtJFCgsx/UKpj
 fQqk5ihQpCQBitahdr4wWrX77o3LWwNlcuwMTg6WfyvMGTJmfwm2bZRQ1cpr5YuXcS/FhzY0EEY
 sobh0XPvEPUYgL/5g8U1tyj2R+/LaMeCeVvKUftuOKLZmcX6ILvrJ65T3tiU/0sAgEEljiKp+3C
 HJb2dsrIblNU2WUDl5kbSK/t+eSVkIlijKBstvPvdkbCjPDEM2wSSyj1PG5vOeKYVWsAJ2264fG
 JnpNFVnzRsDadgRQDX2Uv1
X-Google-Smtp-Source: AGHT+IHybfkMbDsOzGh0Btb/XQAKF5fPP9Dnw4CXDDEWNmJMhgCEJfrCEAJHIesoOu2pPHEo2jVc5Q==
X-Received: by 2002:a05:6a00:2313:b0:749:472:d3a7 with SMTP id
 d2e1a72fcca58-76ab30dd088mr2200683b3a.18.1753833847550; 
 Tue, 29 Jul 2025 17:04:07 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/89] linux-user/x86_64: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:14 -1000
Message-ID: <20250730000003.599084-42-richard.henderson@linaro.org>
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
 linux-user/elfload.c                    | 41 +-----------------------
 linux-user/x86_64/target_coredump.c.inc | 42 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 40 deletions(-)
 create mode 100644 linux-user/x86_64/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 27682f0c81..fc2ee4e0e3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -159,46 +159,7 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#define ELF_NREG    27
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-
-/*
- * Note that ELF_NREG should be 29 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
-{
-    (*regs)[0] = tswapreg(env->regs[15]);
-    (*regs)[1] = tswapreg(env->regs[14]);
-    (*regs)[2] = tswapreg(env->regs[13]);
-    (*regs)[3] = tswapreg(env->regs[12]);
-    (*regs)[4] = tswapreg(env->regs[R_EBP]);
-    (*regs)[5] = tswapreg(env->regs[R_EBX]);
-    (*regs)[6] = tswapreg(env->regs[11]);
-    (*regs)[7] = tswapreg(env->regs[10]);
-    (*regs)[8] = tswapreg(env->regs[9]);
-    (*regs)[9] = tswapreg(env->regs[8]);
-    (*regs)[10] = tswapreg(env->regs[R_EAX]);
-    (*regs)[11] = tswapreg(env->regs[R_ECX]);
-    (*regs)[12] = tswapreg(env->regs[R_EDX]);
-    (*regs)[13] = tswapreg(env->regs[R_ESI]);
-    (*regs)[14] = tswapreg(env->regs[R_EDI]);
-    (*regs)[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[16] = tswapreg(env->eip);
-    (*regs)[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[18] = tswapreg(env->eflags);
-    (*regs)[19] = tswapreg(env->regs[R_ESP]);
-    (*regs)[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    (*regs)[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
-}
+#include "target_coredump.c.inc"
 
 #if ULONG_MAX > UINT32_MAX
 #define INIT_GUEST_COMMPAGE
diff --git a/linux-user/x86_64/target_coredump.c.inc b/linux-user/x86_64/target_coredump.c.inc
new file mode 100644
index 0000000000..b85ee22669
--- /dev/null
+++ b/linux-user/x86_64/target_coredump.c.inc
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define ELF_NREG    27
+typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+
+/*
+ * Note that ELF_NREG should be 29 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUX86State *env)
+{
+    (*regs)[0] = tswapreg(env->regs[15]);
+    (*regs)[1] = tswapreg(env->regs[14]);
+    (*regs)[2] = tswapreg(env->regs[13]);
+    (*regs)[3] = tswapreg(env->regs[12]);
+    (*regs)[4] = tswapreg(env->regs[R_EBP]);
+    (*regs)[5] = tswapreg(env->regs[R_EBX]);
+    (*regs)[6] = tswapreg(env->regs[11]);
+    (*regs)[7] = tswapreg(env->regs[10]);
+    (*regs)[8] = tswapreg(env->regs[9]);
+    (*regs)[9] = tswapreg(env->regs[8]);
+    (*regs)[10] = tswapreg(env->regs[R_EAX]);
+    (*regs)[11] = tswapreg(env->regs[R_ECX]);
+    (*regs)[12] = tswapreg(env->regs[R_EDX]);
+    (*regs)[13] = tswapreg(env->regs[R_ESI]);
+    (*regs)[14] = tswapreg(env->regs[R_EDI]);
+    (*regs)[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    (*regs)[16] = tswapreg(env->eip);
+    (*regs)[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    (*regs)[18] = tswapreg(env->eflags);
+    (*regs)[19] = tswapreg(env->regs[R_ESP]);
+    (*regs)[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    (*regs)[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    (*regs)[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    (*regs)[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    (*regs)[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    (*regs)[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    (*regs)[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+}
-- 
2.43.0


