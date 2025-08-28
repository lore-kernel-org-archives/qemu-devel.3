Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277E3CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBh-0002Wp-SB; Thu, 28 Aug 2025 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWD-00085R-Mk
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW7-0008IS-51
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-244582738b5so7690585ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383247; x=1756988047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDNbW1jEFzivMgdjpGb4I3ZK7So1buAUk1BT20d5CFI=;
 b=eyQVzekdgLlJI1742KJ9p1lE/cgYH5ku1pinPfoGGg7OfuVkaaw8yETY5NrhKRUlg1
 SZVDuhAEy8gjqmkhH/1KejnNP5UXjkb2cGzWkdbOG4K9qD3WQozjSQyPBq3Ou46UPzFc
 MN1l+xcL0infita8CdD5B0qKxJAVG6DIFJVr3UtP+8Y97DFY07Z4qEPwBfXNke0jVzVX
 vF+nhPoAsA8IQmuPdsmImmcmKtvjm2Gw7r55FnMqHaGHYLD5AWC1iRp2i4PsfMFdFeDs
 pRzdzfg6RTpGzMjWzURNHzacI0ULnXlEN8sZwKelPybtHTqKUkDI/7N8Tksk3rcklgkQ
 U0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383247; x=1756988047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDNbW1jEFzivMgdjpGb4I3ZK7So1buAUk1BT20d5CFI=;
 b=eCKbWNZ+EwlWu67BDbfQyKZXYtiKYmBOeCmKx4uT1nphw9Sfr6riisjw/gmdF2E2Xm
 JmlaQ+jkq4mgwyuMyPQuPHVQerrZwC74wSDasyqnZXyWqFZEdpXR4tpR0YRyBGJ9LXJe
 TxGgkXpgnaYZ7fpR+6QbubQVeZdu6K5LOysX2KUDEeOksJm7mCS2zMLKxM19PUbGEt9Y
 utlIIrW+3Qwerr3I1OgPSMxpKf/me9Xl0U9eBVDyD3r4uGuhjk1gByWjeE3P+MveXdar
 bMasWRURtHuLXf18TUKiuOr6+NBdQA8OkUPvP4O2mVmn/4EP2LFd49kA62JEgBUe4HYB
 ySeA==
X-Gm-Message-State: AOJu0Yz4lMynQe7WayDi+rxyrkTKIGWgM+qWtZaGQ0zAWdwQI8xPXXBG
 acZCtXrVjIQSO18d5LiebF9L98resE/5mgeWjQATkP2Y0sq55Xv+Bypsn1M4R+As10GRy3Aofax
 aBzRoHsk=
X-Gm-Gg: ASbGncuZY9C3d7gBjhjvIySuhGC51Jf1Qk40g0gHoMG0cmHyCBXbKegRfjsOM7s4VJ9
 plxbT/vqXfOGuhJeN68n1CgWglIPNyX6RWUMvJxzydeBTDeH/KWBKW/57G6A2C7lBvCmc0AHIEW
 EAEsRfe+zxv1mIXIImMPCc27JYrjkoou2n6a9KHyTQG9yKdVteyXrkjRTx9v4a47lmzzNQhxycB
 g2XtSkz9UVnCpgPlAL9BtvMPDQgx2UZ3TVeIcy48q2dREekAJg0yqM3x4IP5RaYp/zeqUAyi2Vz
 M2SPLD/EJJBd5CNcjEmKL3Y8YsinHadObViL6fAyn4ZD+K5aFjx8OZeHsP6ZEXVfwQ5cpv/3+S5
 5ziiGgUJDpO/851psOoHB8CZwdg==
X-Google-Smtp-Source: AGHT+IEUtiQT4vpn0WJZ3M4GOHrIkpRGLzAUAAFj0TcxMt0tA+LBi3cvHf937VM/nIPyDpIJsVAASg==
X-Received: by 2002:a17:902:da89:b0:248:cd4c:d6e with SMTP id
 d9443c01a7336-248cd4c0defmr35049975ad.9.1756383247445; 
 Thu, 28 Aug 2025 05:14:07 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 54/87] linux-user/sh4: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:08:03 +1000
Message-ID: <20250828120836.195358-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_elf.h | 12 +++++++-----
 linux-user/sh4/elfload.c    | 28 +++++++---------------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index f7443ddbac..fd3ae68a01 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -8,15 +8,17 @@
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/sh/include/asm/elf.h.  */
-#define ELF_NREG                23
+/*
+ * See linux kernel: arch/sh/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 71cae9703e..ddf2aaaed7 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -38,30 +38,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     return hwcap;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
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
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
     for (int i = 0; i < 16; i++) {
-        r->regs[i] = tswapreg(env->gregs[i]);
+        r->pt.regs[i] = tswapal(env->gregs[i]);
     }
 
-    r->regs[TARGET_REG_PC] = tswapreg(env->pc);
-    r->regs[TARGET_REG_PR] = tswapreg(env->pr);
-    r->regs[TARGET_REG_SR] = tswapreg(env->sr);
-    r->regs[TARGET_REG_GBR] = tswapreg(env->gbr);
-    r->regs[TARGET_REG_MACH] = tswapreg(env->mach);
-    r->regs[TARGET_REG_MACL] = tswapreg(env->macl);
-    r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
+    r->pt.pc = tswapal(env->pc);
+    r->pt.pr = tswapal(env->pr);
+    r->pt.sr = tswapal(env->sr);
+    r->pt.gbr = tswapal(env->gbr);
+    r->pt.mach = tswapal(env->mach);
+    r->pt.macl = tswapal(env->macl);
 }
-- 
2.43.0


