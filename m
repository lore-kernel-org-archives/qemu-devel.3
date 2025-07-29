Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BE4C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugubj-0005Ms-Nt; Tue, 29 Jul 2025 20:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIm-0004Ot-Ga
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIk-0004aR-GT
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso5545519b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833849; x=1754438649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5nEK5nD/ceEZ87USw80BOIb0YlloBar65++Aor9qra4=;
 b=Cf0cZg4YQY/yCzxe6RCUp47zcCRxcoM9whOfH7gGpp8AxgWAjuLOKw/PFNEQThMQsS
 gdB4xOesMlbWD5jSuMT96kTSxBOYyX5vvx2KyMTrxAZ8yQUtgL4jgVU6xcSWmpnSiLo1
 mCQGUGt0hS6jb/Rys8bM6GSzjFuoPyFExg/qq1D05lLghNu9ofiX6uJw3EXKy8J4eO/Y
 qaLLCx/IJoVT0Z73GZA9MNJR+nO1dxKPFEg0eaCWDtSa0TP29bXyYRBbTldaB0Wuv83+
 /kJzlXeEb+4VklOZtng37EDZ4ba6PBT4qgP6H9i9isxJbB1B0dWV6MhrhbXfRnxZ/GqV
 Sqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833849; x=1754438649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nEK5nD/ceEZ87USw80BOIb0YlloBar65++Aor9qra4=;
 b=uPBmo6ySpjBACPmoUeCoK4Ohczj8Bu29rV8/AeDAGO8bnmydw3ixBH1yhMPEyJrl09
 NLaxR8ZEHgVBOcZ9GbZIjJj0m8x7smkrGpeoi6PoI9WXaZGmgUc4iQ/RvwjEPYbuAKiM
 eN/A3o5N1pF/0cBeGmo0QGZ+t6djWJwTe0ioTM31+fZX2Czql4seqz3BIBpkIwVHB8mH
 5pe1yWFNAoxudUJxf//os/gNRoce5nHCpTRFxtiqVN1fN9aLHCM64NE77MG2AjDC/5H0
 UbZxXKyn+qct8hoGu4U2v8/NXU3ajdVvuTuUtX9/RH/fBWvU7eelRllYd9vsE/fw0eFD
 +R6Q==
X-Gm-Message-State: AOJu0Yw7i/wYCSio8bCXaZfj1OfNNun9GTeWiP9wMXr6lHoYBmRsqZcO
 tYA/mQdU4at2rm+MUawch+41jjhVue1q+BDOPlI/iy+fIKAktlNKROvlhN+rcRisqOWkzoN+ACk
 O53dC
X-Gm-Gg: ASbGncux7e6QZCFgLST64ezfRv5kuGYxqmqtSUOSdYsJtZXTgguTZflruPJEHfL9eqP
 IXp4Moi2ObGVMIeHFSAobSRZKYfO+aaLyXBY+GEW8q0NeMn6+s+By8H1fEx2rufDKF0YPTLbulI
 0efmCwmFbesyoBlYLTYW+ygQCaRWsLn84pu/C1QSURyJxRYEzQO9VxxFg0vSx8LySSMUR5/KzAI
 l0fSwKuWRH0atS/vkZKKX2UeihOZwbcLLE4KjVYY+EHVePgK7TGCTJv022tBUss31KSiKTQMWUO
 DlB2Y/KDnXUlFs77NmQViUyJxbLwhqrvMdxi3TfwJMkwGCQjMPhzky8zTof8+mHgrAxeV+LaryF
 maADgiWWH0Xrn5kYipl0Iu077xQSWUI+p7BWI2sDek6VURcJdcdntqRazB3RW3YRHu72rrVZ/UW
 XOv/ByxcXcTA==
X-Google-Smtp-Source: AGHT+IFaW9ww2UcSv/cU2qlEeeyTdN1tDFkwJxnUA65ju0Kr/br8230A1XKcSaazqlCu/GiLHkk3xQ==
X-Received: by 2002:a05:6a00:288a:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-76ab2b576aemr1654876b3a.14.1753833848736; 
 Tue, 29 Jul 2025 17:04:08 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/89] linux-user/i386: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:15 -1000
Message-ID: <20250730000003.599084-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 linux-user/elfload.c                  | 31 +-------------------------
 linux-user/i386/target_coredump.c.inc | 32 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 30 deletions(-)
 create mode 100644 linux-user/i386/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fc2ee4e0e3..b315a5a243 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -197,36 +197,7 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    17
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-
-/*
- * Note that ELF_NREG should be 19 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
-{
-    (*regs)[0] = tswapreg(env->regs[R_EBX]);
-    (*regs)[1] = tswapreg(env->regs[R_ECX]);
-    (*regs)[2] = tswapreg(env->regs[R_EDX]);
-    (*regs)[3] = tswapreg(env->regs[R_ESI]);
-    (*regs)[4] = tswapreg(env->regs[R_EDI]);
-    (*regs)[5] = tswapreg(env->regs[R_EBP]);
-    (*regs)[6] = tswapreg(env->regs[R_EAX]);
-    (*regs)[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[12] = tswapreg(env->eip);
-    (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[14] = tswapreg(env->eflags);
-    (*regs)[15] = tswapreg(env->regs[R_ESP]);
-    (*regs)[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
-}
+#include "target_coredump.c.inc"
 
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
diff --git a/linux-user/i386/target_coredump.c.inc b/linux-user/i386/target_coredump.c.inc
new file mode 100644
index 0000000000..df7a3e73b3
--- /dev/null
+++ b/linux-user/i386/target_coredump.c.inc
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define ELF_NREG    17
+typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+
+/*
+ * Note that ELF_NREG should be 19 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUX86State *env)
+{
+    (*regs)[0] = tswapreg(env->regs[R_EBX]);
+    (*regs)[1] = tswapreg(env->regs[R_ECX]);
+    (*regs)[2] = tswapreg(env->regs[R_EDX]);
+    (*regs)[3] = tswapreg(env->regs[R_ESI]);
+    (*regs)[4] = tswapreg(env->regs[R_EDI]);
+    (*regs)[5] = tswapreg(env->regs[R_EBP]);
+    (*regs)[6] = tswapreg(env->regs[R_EAX]);
+    (*regs)[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    (*regs)[12] = tswapreg(env->eip);
+    (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    (*regs)[14] = tswapreg(env->eflags);
+    (*regs)[15] = tswapreg(env->regs[R_ESP]);
+    (*regs)[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+}
-- 
2.43.0


