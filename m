Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A4C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTz-0006FZ-Oi; Thu, 28 Aug 2025 08:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRs-00031g-An
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRp-0007JE-HF
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-771fa65b0e1so470523b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382984; x=1756987784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7R4DNI2NJtzLUsOa8sPR5qAbu/X62eVrNpQE8ywFsac=;
 b=t+mSJOsTbkL65bA6XDcR++r5Git8sqH30D0nJV12qEv+jNN3mHex/aCiNnYyV4uMW7
 R5NPz1DY+912GIwnqRLT5YiOy8kMWkJeQz5XRj/rV0EUVroxJbo2QI87BT0giSxVLp0M
 0h/yMPjcdoC5G6zb1PriWUDQKdRc21iiF/iXY531NKF+7puZnLbO2j0+x3fUZzglHQbV
 2PpDZW1ruPcyJ8C9zFXpNKt1innawdgJ/UJ7IE1TJ1ZcX5KI5cseFlHsHujmPs/JCWcy
 6f3EZRKPigrJB6qyIy1y6sMcSVVol53BuB/+39MXPQLxeW/zNzQbELjlkmzUdicSXYpi
 eQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382984; x=1756987784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7R4DNI2NJtzLUsOa8sPR5qAbu/X62eVrNpQE8ywFsac=;
 b=HJN4YpECTTNlQBTIcgeAOA7GeScmlUUbTRNGGOyu90KbN0ymxCCntCgAxGjR03ux3R
 7hlYnN+0r7oXTueKyAKW7G+oUSOOXIzp6igym0vKMOeCOyswiae2fUnXT6dly3/jAqf5
 V9FBH2u3Ba8ZIdP1Ph5/U+hHX/Axb4fZDG1xbOOCxTqVU2X+KGeBQvDcK4bn59IGM1Jd
 TlpRgGHtS+0RttjlmTK+viXnCl4TLbJEj0BI4gc/MlWqfZGKqcO9yFqfl5XZu01NLHs/
 F7ProYV1ickuxcviOKirwXV0R9b7C35zzrFy51uQ4n4B+9OxEfmjLd76DmcMaUbuIJG7
 w99g==
X-Gm-Message-State: AOJu0YwY7K/TWvcYPRKSl8BH2ICyDaLKICc5/iYiqxKYLACLW/Cg48Ut
 lrhrr1xfIHoHe/0s3+FPaI1S3G4aSSxekPEBYFM+7sV+G1cfJNJ5gwkEFNIECCxVz3bkjKPLAoU
 TbV9W5DQ=
X-Gm-Gg: ASbGnctP39hOG7jGTEcdcGLD8SOIP8R6R17roId2ppL0X9iI5XtYnYOuUg/rLvDi/fX
 RYzVU9sVkeP9nu+00SzV4lCjCVrveqVlVnDo4CQFnOQlE9l2p68qUCPzaxOUJYr2zSeDq++wkqO
 snYqIzDGG+JEROp0K5R16GVwRAPY1RIiJoOmLKBL9gMTEqbYoPfG8+RshoFUyuvQ4vfu5rN9B7y
 uz4ba/LNmYCvQkup5B078z8fWxU4QZA+FzN1BtVARIRQwGYAaM6e9XFR+JI7nt5iTmaI2tY6DLA
 GtFn/kx+9lJKXuve6gESXS47YtK2AsasmTPMVNNY0Lp0a6zgkLDsHPT5/vXYOw2lMhWFAtOEHMU
 30yKOT6zbc14eu3HpeUfsmfHIyGbpaXbVSevJ
X-Google-Smtp-Source: AGHT+IHiPRKR+WUX3+LrwrWN3tkYnZ8qOwi6IyNF2fadFjDgCnvLZgfwnZ1vI4fXpk1OVXzFvsKKYA==
X-Received: by 2002:a05:6a21:99a7:b0:23d:ab68:1b7c with SMTP id
 adf61e73a8af0-24340d59b98mr32409430637.46.1756382983705; 
 Thu, 28 Aug 2025 05:09:43 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 26/87] linux-user: Move elf_core_copy_regs to m68k/elfload.c
Date: Thu, 28 Aug 2025 22:07:35 +1000
Message-ID: <20250828120836.195358-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 10 ++++++++++
 linux-user/elfload.c         | 31 -------------------------------
 linux-user/m68k/elfload.c    | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 62ff9d38d4..cd6908ab57 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/m68k/include/asm/elf.h.  */
+#define ELF_NREG                20
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 69532faddb..e92c424faf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -442,37 +442,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-/* See linux kernel: arch/m68k/include/asm/elf.h.  */
-#define ELF_NREG 20
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
-{
-    r->regs[0] = tswapreg(env->dregs[1]);
-    r->regs[1] = tswapreg(env->dregs[2]);
-    r->regs[2] = tswapreg(env->dregs[3]);
-    r->regs[3] = tswapreg(env->dregs[4]);
-    r->regs[4] = tswapreg(env->dregs[5]);
-    r->regs[5] = tswapreg(env->dregs[6]);
-    r->regs[6] = tswapreg(env->dregs[7]);
-    r->regs[7] = tswapreg(env->aregs[0]);
-    r->regs[8] = tswapreg(env->aregs[1]);
-    r->regs[9] = tswapreg(env->aregs[2]);
-    r->regs[10] = tswapreg(env->aregs[3]);
-    r->regs[11] = tswapreg(env->aregs[4]);
-    r->regs[12] = tswapreg(env->aregs[5]);
-    r->regs[13] = tswapreg(env->aregs[6]);
-    r->regs[14] = tswapreg(env->dregs[0]);
-    r->regs[15] = tswapreg(env->aregs[7]);
-    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    r->regs[17] = tswapreg(env->sr);
-    r->regs[18] = tswapreg(env->pc);
-    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       8192
 
 #endif
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 561ac5b3b3..2970ff7dec 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "elf.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -16,3 +17,29 @@ const char *get_elf_cpu_model(uint32_t eflags)
     /* Coldfire */
     return "any";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
+{
+    r->regs[0] = tswapreg(env->dregs[1]);
+    r->regs[1] = tswapreg(env->dregs[2]);
+    r->regs[2] = tswapreg(env->dregs[3]);
+    r->regs[3] = tswapreg(env->dregs[4]);
+    r->regs[4] = tswapreg(env->dregs[5]);
+    r->regs[5] = tswapreg(env->dregs[6]);
+    r->regs[6] = tswapreg(env->dregs[7]);
+    r->regs[7] = tswapreg(env->aregs[0]);
+    r->regs[8] = tswapreg(env->aregs[1]);
+    r->regs[9] = tswapreg(env->aregs[2]);
+    r->regs[10] = tswapreg(env->aregs[3]);
+    r->regs[11] = tswapreg(env->aregs[4]);
+    r->regs[12] = tswapreg(env->aregs[5]);
+    r->regs[13] = tswapreg(env->aregs[6]);
+    r->regs[14] = tswapreg(env->dregs[0]);
+    r->regs[15] = tswapreg(env->aregs[7]);
+    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
+    r->regs[17] = tswapreg(env->sr);
+    r->regs[18] = tswapreg(env->pc);
+    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
+}
-- 
2.43.0


