Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A26C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguch-00083v-CM; Tue, 29 Jul 2025 20:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ2-0004fY-Ch
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:28 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIz-0004dH-EH
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:28 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b3bcb168fd5so5294463a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833863; x=1754438663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uMIXwlpnlSfFBAzj9mkY1Aw7ECb3bAcUI/afFDOaBLM=;
 b=zzeFuldRMwlScBjT6sJUFKiBB2if5JWheg9hZPPbpaBlhSPhDZ8FbmhGGIdBhxP5Tc
 maPwu3/4HvMWZ8zx3h+xnfLtBMcNyOqCSv/FZcYgJChRr1dVvWMRcnLQurBzxBg58db3
 8PGoXKrPKyY14sODnLbxdVnnyIe6+vkkop+CaOCagsdwGU5p3/P3x1Df/KV9gbSkiG10
 qJgsPOalP0iGLk5tUWy1Ffj9Y5olbBq3IHI5NZTaLhX4gY6D+DKugW/obuzhSK6Ra0ic
 jxdEU8Q3ph9uz278SXe7D2zI8TuDb+XC1HZdWTXfhAy2JTlARIPmPfmP3b5YeABiio7U
 vNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833863; x=1754438663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMIXwlpnlSfFBAzj9mkY1Aw7ECb3bAcUI/afFDOaBLM=;
 b=WCk/VqOBjENE5oePT99Djeso4Gx0OJ570JGUGlbBEbjKW0hrf086yZwCqdgGA9MeBl
 KHEJgVSvwHEbQr70Mtc7R+8alp4v2MpFfGpp4Zgd+J7pyKb+sXJfH5GgQThHms7dFBFf
 2c7ITd5yXP1laQ2fsOqixZ4n/SNGeXHPpDUfQMrwccaUMZiQmkeCes6Lh3JLA1DHFvSt
 GqCZuCI6moSLAaXVYlgowG1wLBDdvtFvVIOKhgH7Hrb/i811qCayh24WC8VE4tv4dDEJ
 ye54MJ1UuxkuvFQx2gVSjC9ygRCzNbulYz4jEm4Dh/qO8AFrIFoqsulw4nstHxHDadxI
 4t0A==
X-Gm-Message-State: AOJu0Yy13SrDJXGcGbM+LmC+/tYVOxyL1LvWVJRVp0EbycN5S/e3KkKo
 L/+btwhpm6b0BDZ9QMtvFABDbHYtjEkHlDhv1Rao233bqQUsPB/83l2XDcjMMFdzyqSEF4wE3zj
 OsoYu
X-Gm-Gg: ASbGnct5xRM75MqeYWofQKAKlRFz9qxYvO7My+ttYJQMN1B2f8zkOPrSNmWk1xkDvOS
 vO2aW/AymMcZ63Vq4Y0Kj45+5ysIEz1ru3kX0Wk8IQK3c/wrOuGIwynO2oNchxcokJFADNJFZH1
 J0Sil26JiiRmyeB9dvG7wmb0YEOuZzmdqmVbWVApQL3kxTkCMQW3XzcPrzGxg+N4LQ6+sEnv6qK
 eyjaGntKw1Uy0NDy4lIEu9QYGIH9hIriDbbEr3izhH9pO65AgUcpiP8ghF3WIRd+PwxG4hjOdN5
 bRUMiKNUtZC+6ZXhx/8N2ODbo5SqnndYHJcHBgoXPXlgdU4/hnx4Pm0xm7QvWK5zxw6IOlGm45h
 ohcGZo9clWfF4tkNmusWFysl5zJsYUNYqCRgPOQS9p0yzFLH0DqfZvpFlA9fs7ToQhwGQB40f/p
 bM4IOxuhVIkQ==
X-Google-Smtp-Source: AGHT+IFLZ7NeRrZErlC6Qq5pjtvwgDvrbuJlJJYicwanUBiueqOMFFlxgpSf5L4RFrqpltv+pOl8wA==
X-Received: by 2002:a05:6a20:2450:b0:220:78b9:f849 with SMTP id
 adf61e73a8af0-23dc0e445a2mr2099906637.24.1753833863440; 
 Tue, 29 Jul 2025 17:04:23 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 53/89] linux-user/xtensa: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:26 -1000
Message-ID: <20250730000003.599084-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 linux-user/elfload.c                    | 38 +------------------------
 linux-user/xtensa/target_coredump.c.inc | 38 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 37 deletions(-)
 create mode 100644 linux-user/xtensa/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7cd0d5e7db..347af3202c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -562,43 +562,7 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
-#define ELF_NREG 128
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-enum {
-    TARGET_REG_PC,
-    TARGET_REG_PS,
-    TARGET_REG_LBEG,
-    TARGET_REG_LEND,
-    TARGET_REG_LCOUNT,
-    TARGET_REG_SAR,
-    TARGET_REG_WINDOWSTART,
-    TARGET_REG_WINDOWBASE,
-    TARGET_REG_THREADPTR,
-    TARGET_REG_AR0 = 64,
-};
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUXtensaState *env)
-{
-    unsigned i;
-
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    (*regs)[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    (*regs)[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    (*regs)[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    (*regs)[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    (*regs)[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    (*regs)[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    (*regs)[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
-    xtensa_sync_phys_from_window((CPUXtensaState *)env);
-    for (i = 0; i < env->config->nareg; ++i) {
-        (*regs)[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
-    }
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
diff --git a/linux-user/xtensa/target_coredump.c.inc b/linux-user/xtensa/target_coredump.c.inc
new file mode 100644
index 0000000000..192589d1e3
--- /dev/null
+++ b/linux-user/xtensa/target_coredump.c.inc
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/xtensa/include/asm/elf.h.  */
+#define ELF_NREG 128
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+enum {
+    TARGET_REG_PC,
+    TARGET_REG_PS,
+    TARGET_REG_LBEG,
+    TARGET_REG_LEND,
+    TARGET_REG_LCOUNT,
+    TARGET_REG_SAR,
+    TARGET_REG_WINDOWSTART,
+    TARGET_REG_WINDOWBASE,
+    TARGET_REG_THREADPTR,
+    TARGET_REG_AR0 = 64,
+};
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUXtensaState *env)
+{
+    unsigned i;
+
+    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
+    (*regs)[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
+    (*regs)[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
+    (*regs)[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
+    (*regs)[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
+    (*regs)[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
+    (*regs)[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
+    (*regs)[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
+    (*regs)[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    xtensa_sync_phys_from_window((CPUXtensaState *)env);
+    for (i = 0; i < env->config->nareg; ++i) {
+        (*regs)[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+    }
+}
-- 
2.43.0


