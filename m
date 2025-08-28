Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75696CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTj-0004yy-AP; Thu, 28 Aug 2025 08:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRk-0002lC-33
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:43 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRg-0007HA-O1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:39 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4c53892a56so799222a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382975; x=1756987775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIfXsalfKXZPBG/HfzJiE2bOo32PAgp8HxaWLSOVE5E=;
 b=l/oRPyTC1lW5/TtAp2zfak62mqSQhEibjmeN1kMPz6PP39C9CdpxZt3xY1/eoPVyKv
 +dipvXXIhheHmUbRrkfzojnnKkyAnHHPhKwbTu5s1BZgafZWJ/ayraitjpw/xAexNHXz
 r96N/JkFp7/fVquQst6Z2IgUNVFzsmJAs8XPKJuUhplAW3FEmSVo4Yav7iZwHBWQvrJK
 Ozr1eOTZrTxPI7p+UwcN262KJAImo99YLFlh7rzJetUyeKNRrAhdz5+1C11TuOBrdK+f
 2yfDYtb6OilQt7iMZpnMiwH9klluudFPZdvA1YSudvvKfSiPYsn58Hx0QenkdIisRpwY
 s4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382975; x=1756987775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIfXsalfKXZPBG/HfzJiE2bOo32PAgp8HxaWLSOVE5E=;
 b=o2oX89w1b5c/wzMQwVWXgoXW1xvQWW2NalQN5I+ZmCedJhlY/SR2RVsjPTK4kEsCr/
 fg7wmHGZy84DALOfZUNu2ucau5+0I4RaH5ckd0IwJ+Qv1OZBSJrSIQhPQkWuV/9gDjxe
 JVWnRUZbxNah4HCt7rPcuKPv86HlJ3CdpXLfL6ELgjmVoUoKbiswA8RionvdmxgdPyFr
 Yt3GbB22mSooha72nz93yGytVCA1mP/KjpFNOZDQVU9RNXCrbpDuRnpWyogRMPiK0n9X
 G2vFsC0qUcmCuSKALATIbiAuSV/7oq0pnC8hBRS8LY+pBPYCSIJXzk88z4qksMfFR7PR
 4lsg==
X-Gm-Message-State: AOJu0YynjjOWbjvOX8she4z92R2I4glFcja6KFFnWO2/nOI6PJFBmTsw
 +fj/kfxcJhShjavwCaTaJKy80qsWmKWlVbhmXPMJjOvVtTc7CbcTdOtJWPVNvS2nqKG0N/90RX0
 IBRv3tf4=
X-Gm-Gg: ASbGncuNG/Fj/jLkRMBH+r5C4JBwq3AhaD4QRWcoKiy80Fl5u6e1ULYDr1zn2+5oQEn
 2/iUIHeGxjqulFZeWAxXXocn1FvKAp2HgER8iir5WA5EYLVYRkYqG7HJEOE1z4U6v0EqH619WbM
 SvX+b3FTzqPrsgeJPQs5Jw0A0+MnaGHzx1NJE2fa1k7PXpzvqrS2cUtAuXu28yDfPp/fYXozYh/
 E9H8K4Z+eplNZtNA0cOyx/brqlq72K41fjUl+TrOQGMTNGOR5Qn8UAcoqUtIfWLjGe0q5yl5WJJ
 6XjhZeICKEyZoEo4JXRqNgYx+cKniolvCqmHv3AJSGdL6sD3xDaQD0S8htxiVyBPGqJUGK28r3R
 E4wfmt/zCR192zuZcAZvO4VExr6Injko+H2Y8
X-Google-Smtp-Source: AGHT+IGx4+CAuM4tRH2ljvJ72GUZ66Sug02pWs/psIT3FeavQ9YZJn9bBKvFdJpztgqVs+CZt3vhOw==
X-Received: by 2002:a17:90b:3d88:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-32517d1dd5bmr28530334a91.27.1756382974837; 
 Thu, 28 Aug 2025 05:09:34 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 22/87] linux-user: Move elf_core_copy_regs to mips/elfload.c
Date: Thu, 28 Aug 2025 22:07:31 +1000
Message-ID: <20250828120836.195358-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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


