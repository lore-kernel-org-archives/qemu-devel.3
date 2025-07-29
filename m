Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35286C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugubt-00064E-BW; Tue, 29 Jul 2025 20:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIu-0004X7-2o
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIr-0004bn-Sm
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so4185913b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833856; x=1754438656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t2/RZsdrZdm1zu0RRpH4NJHGJS7CMB/KnnFtJyXdzcY=;
 b=Q416dUrBiR42nOtHiB27ECfoLlmKJmGL1ip/BpsgQ/xpU+XSGzc366Xp6LmRvwua6O
 xL8zN6MB8UrhVa16qbKvsiRVSmbRGC2U0kv7RwRonUWn5UCIaiFvfVgUND3mNQFBsRcc
 +89fgNd9qjhuAonnK+jSyzoktqM9UQ6rv3an9FBGQkI1Zs7TmfRFUdaLcMqecyES6CSz
 SdnZ8LlqbdE7KQE1C/3NaJPb1sNN4ZMrC+e35JU2eyP/qVV/s5EPXgITFaHq04GYh6m+
 N91CjKJVRcUnPRqgoXBPywaNBviOjaOfO+Zp7lGmOq18tEfMiLqiEHsJbIdRrnTJMkhg
 rJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833856; x=1754438656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2/RZsdrZdm1zu0RRpH4NJHGJS7CMB/KnnFtJyXdzcY=;
 b=MmH9DiCaFL+UC7a4zrDucPznCDTDJjZfKQ0X9uTCA9TBL7g8+gumXyFK49evT7M/i3
 rB225enXBJcXKVe4bx2EEdacjsC+qvIYURE4mG68K7vVYpjs17INO9MIPsI9w0WPk0UC
 nNTiimosI8rscD0VI/U7m/ENhd/7Br22HmrlmncFIxek3cMstcEx6tjTPVPN6pE5Lj0t
 iFCX6+VF3DPWivGzOsNWWEoBKvZ+T8rosxl1kZBUBtOG8pbcBhenr/uYC3LvSzVSEgJi
 6E5Jdz+khB6CJpI1oVEJqCsq6Nu38Uriv03l4fen7rSJr421+7H2nsb5U14iOzTFn5qq
 M5IQ==
X-Gm-Message-State: AOJu0YzUQo8aF7zuWr1Ja2bBP1aC654w3KfjkfRF4D5pOQexauL7/Rw/
 iwNkiIsGX4O8qK0JRMOx1WvrycEr1KFz1PgNYTl+yjR6RyRtA9QrweRUE22+614D+fpDg2FPKje
 TkFb0
X-Gm-Gg: ASbGncsejbgzxrEI5LMG6aMQCCcF9PI5WZG5u4hLm2oZKU1+h6cgnLzkjPomn+kb6Dn
 TRSZtyZ056L3kWSb8gS36Uh3Ia2LjcOhYMEBhsEiYQeE1FJVa2Bb22tbNTBPbubsMQWTR0weMZ9
 vOE4He2HuyLuTKGgvKadN2yE23Xro8NDY1Otq13tv/5DLAHT8zP0GPBzrN7QOFzbSdRmU7lKzu6
 BaL1iqM2J9CqFPfQFNRCvF6V6ARHmnidbGLpl+p8jw4mh1cej0zGPFOz2AIjhl9Bsu8bOFVvLU/
 eFAXz2ZVSgppypod+aoa/WxM/dn43dfRGxk6mGQq864QYxxkI0hGrGK5kom7bCxwAXoYhkn5lRV
 XNAthMKaRbgYAdu1T88N/EPyhqFaXh1YZgslJeaF3xxt0Z0Al/gn5leeYG7jMgFMSuZvc2uuOm9
 5H4l6avQdCeA==
X-Google-Smtp-Source: AGHT+IHZ1ukmMybFgBEL0W6fLFZ7aKo3TMmwMggBxqJh5PuukRt2pULzGQAf4EW6/Zqg+AkMIZkOeg==
X-Received: by 2002:a05:6a00:1908:b0:746:3025:6576 with SMTP id
 d2e1a72fcca58-76ab2938574mr1751667b3a.14.1753833855800; 
 Tue, 29 Jul 2025 17:04:15 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 47/89] linux-user/mips: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:20 -1000
Message-ID: <20250730000003.599084-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 linux-user/elfload.c                    | 46 +------------------------
 linux-user/mips/target_coredump.c.inc   | 46 +++++++++++++++++++++++++
 linux-user/mips64/target_coredump.c.inc |  1 +
 3 files changed, 48 insertions(+), 45 deletions(-)
 create mode 100644 linux-user/mips/target_coredump.c.inc
 create mode 100644 linux-user/mips64/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 77730fdbaf..d37e580ada 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -422,51 +422,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-/* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
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
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *env)
-{
-    int i;
-
-    for (i = 0; i < TARGET_EF_R0; i++) {
-        (*regs)[i] = 0;
-    }
-    (*regs)[TARGET_EF_R0] = 0;
-
-    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
-    }
-
-    (*regs)[TARGET_EF_R26] = 0;
-    (*regs)[TARGET_EF_R27] = 0;
-    (*regs)[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
-    (*regs)[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
-    (*regs)[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
-    (*regs)[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
-    (*regs)[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
-    (*regs)[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
diff --git a/linux-user/mips/target_coredump.c.inc b/linux-user/mips/target_coredump.c.inc
new file mode 100644
index 0000000000..bbdf5faba3
--- /dev/null
+++ b/linux-user/mips/target_coredump.c.inc
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/mips/include/asm/elf.h.  */
+#define ELF_NREG 45
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
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
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUMIPSState *env)
+{
+    for (int i = 0; i < TARGET_EF_R0; i++) {
+        (*regs)[i] = 0;
+    }
+    (*regs)[TARGET_EF_R0] = 0;
+
+
+    for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
+        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
+    }
+
+    (*regs)[TARGET_EF_R26] = 0;
+    (*regs)[TARGET_EF_R27] = 0;
+    (*regs)[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
+    (*regs)[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
+    (*regs)[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
+    (*regs)[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
+    (*regs)[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
+    (*regs)[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
+}
diff --git a/linux-user/mips64/target_coredump.c.inc b/linux-user/mips64/target_coredump.c.inc
new file mode 100644
index 0000000000..950d873550
--- /dev/null
+++ b/linux-user/mips64/target_coredump.c.inc
@@ -0,0 +1 @@
+#include "../mips/target_coredump.c.inc"
-- 
2.43.0


