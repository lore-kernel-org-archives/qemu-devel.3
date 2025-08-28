Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D18CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbSn-000413-HN; Thu, 28 Aug 2025 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRY-0002Vd-Iz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRV-0007Ey-SA
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771e1e64fbbso1020161b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382964; x=1756987764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kH3xjNESjuiwMVLt0f63naDaSmmPLkDzFn3hAYVRDFQ=;
 b=VRqU1SqwZyUlCDI8PKtjwBp50DIpQZTX94Rlq5E8lWJovUSMseCQOr+SstimZiCh3D
 SXUkbVRADseLZ/owVsT/yQtjkzZorsWZI2diwY6TSQKv+9ncf1zui/Kj1uUnqz+h98AP
 ZFhoWVUbHBFb6iujCM6mNCCiCQLobbEPaFJ5OQIpkJMXVlr07g206mRUcrCDwJ+m/6Zb
 c9zgEzOSFeA/BWFX5/ZwpZbXsJL0R3UVS3GbsS9ulZIQA9FGN/vJjhuNPEupX/tcfxt6
 9HMSIkwkHpvY+xLy4DyNDh+ogwwkevr6m//f7KIoE7PuAK01AfCTbmN/qEv8T/adhERL
 k8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382964; x=1756987764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kH3xjNESjuiwMVLt0f63naDaSmmPLkDzFn3hAYVRDFQ=;
 b=dPe+o7o4kAWnMH5nBL4Us2GGiLTRp/nBAiBTprs/2NXkwEMT7TgjY1wvfRovKty6rQ
 wKB0eCvGjrEqh9oh51rVBOnxf00i/QzsM7moksGu44D5+FVOPgskXLznJyh+4ZPHdQrF
 zLMxp7w4RWesEneVqfOoIs2oFwnsfPlbJKVzYDKwgfw9DA5X0lUvvnFou5ceOPtGdfO0
 i2O1EwI0bxPpScO2hCIwze453ZAIQ2RDHRM65/0sopBm9Ro8qgc0+WXN4mgSEolnxyLp
 X3Tc0rXkJcRVf1sWwM/usTQ1VArgVxbW5JxUaukUxRJVS6nen3cpYkdM0cStXG/9ne/4
 9Ccg==
X-Gm-Message-State: AOJu0Yzp106bxyK/72SCojyXrPfIdkY+i3GjM0Cf0bbh6R6dgCQjbC5n
 WsilvQc7782O+VW01s9z/yZc3qcdivuPbuGTAi4NDc9ayQ5UYtbWAm5el/YcytcGwM3qYTsF1Md
 NK97AB/k=
X-Gm-Gg: ASbGnct2r4YT1r6nxlG2LQoIpNASpTSAUmluKy0kazDyl7G0Tf5moKTNN6uBrb7n8uy
 tEn0rDFcw7u/UB0B2OMyJsZCILwJvHb5YuUXxNa3Zkon8+FfKw637lx3ztXf8xNkmjpNCOR5vM0
 5plRBrFxCp7cUqz9xMLZgiME481XO+Ye1ZdPBXLacTvaijPfWHZwVo24Y7cNtPaoJrWIBf7/eab
 fsWe1DrA3NSIVRnjeJoq4MtG/DpRRCckYzWflsfMafm54s9TW4HAx4/pWRYd3zHrX0KCxfXTg+N
 T+zHBD887iTh4FDLIgbfdtT70u+hl35D4Cs8yqPuXrAsQOQKUsrkSuQ3EEm/lidy/mzi8sfqGvk
 pWsA++laBI5z8r4cuGCfJ41UEGA==
X-Google-Smtp-Source: AGHT+IFP5HaGEbcNWl9IucnBheTiodu3f1PhJ5Ewx1vrTL2AgeV4E0xh5cjEW3M325P9Ztprb4BFPg==
X-Received: by 2002:a05:6a21:339c:b0:238:351a:6442 with SMTP id
 adf61e73a8af0-24340d5e23amr35720837637.45.1756382963771; 
 Thu, 28 Aug 2025 05:09:23 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 17/87] linux-user: Move elf_core_copy_regs to {i386,
 x86_64}/elfload.c
Date: Thu, 28 Aug 2025 22:07:26 +1000
Message-ID: <20250828120836.195358-18-richard.henderson@linaro.org>
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
 linux-user/i386/target_elf.h   | 15 +++++++
 linux-user/x86_64/target_elf.h | 15 +++++++
 linux-user/elfload.c           | 77 ----------------------------------
 linux-user/i386/elfload.c      | 24 +++++++++++
 linux-user/x86_64/elfload.c    | 34 +++++++++++++++
 5 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 44dde1ac4a..eb286868e1 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -10,5 +10,20 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Note that ELF_NREG should be 19 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+#define ELF_NREG                17
+
+typedef abi_ulong target_elf_greg_t;
+
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 498c3f7e4e..74a77d94cd 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -10,5 +10,20 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+/*
+ * Note that ELF_NREG should be 29 as there should be place for
+ * TRAPNO and ERR "registers" as well but linux doesn't dump those.
+ *
+ * See linux kernel: arch/x86/include/asm/elf.h
+ */
+#define ELF_NREG                27
+
+typedef abi_ulong target_elf_greg_t;
+
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index af31a34594..e4f821f8c8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -153,49 +153,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#define ELF_NREG    27
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/*
- * Note that ELF_NREG should be 29 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
-{
-    r->regs[0] = tswapreg(env->regs[15]);
-    r->regs[1] = tswapreg(env->regs[14]);
-    r->regs[2] = tswapreg(env->regs[13]);
-    r->regs[3] = tswapreg(env->regs[12]);
-    r->regs[4] = tswapreg(env->regs[R_EBP]);
-    r->regs[5] = tswapreg(env->regs[R_EBX]);
-    r->regs[6] = tswapreg(env->regs[11]);
-    r->regs[7] = tswapreg(env->regs[10]);
-    r->regs[8] = tswapreg(env->regs[9]);
-    r->regs[9] = tswapreg(env->regs[8]);
-    r->regs[10] = tswapreg(env->regs[R_EAX]);
-    r->regs[11] = tswapreg(env->regs[R_ECX]);
-    r->regs[12] = tswapreg(env->regs[R_EDX]);
-    r->regs[13] = tswapreg(env->regs[R_ESI]);
-    r->regs[14] = tswapreg(env->regs[R_EDI]);
-    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[16] = tswapreg(env->eip);
-    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[18] = tswapreg(env->eflags);
-    r->regs[19] = tswapreg(env->regs[R_ESP]);
-    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
-}
-
 #if ULONG_MAX > UINT32_MAX
 #define INIT_GUEST_COMMPAGE
 static bool init_guest_commpage(void)
@@ -232,39 +189,6 @@ static bool init_guest_commpage(void)
 
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    17
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-/*
- * Note that ELF_NREG should be 19 as there should be place for
- * TRAPNO and ERR "registers" as well but linux doesn't dump
- * those.
- *
- * See linux kernel: arch/x86/include/asm/elf.h
- */
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
-{
-    r->regs[0] = tswapreg(env->regs[R_EBX]);
-    r->regs[1] = tswapreg(env->regs[R_ECX]);
-    r->regs[2] = tswapreg(env->regs[R_EDX]);
-    r->regs[3] = tswapreg(env->regs[R_ESI]);
-    r->regs[4] = tswapreg(env->regs[R_EDI]);
-    r->regs[5] = tswapreg(env->regs[R_EBP]);
-    r->regs[6] = tswapreg(env->regs[R_EAX]);
-    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    r->regs[12] = tswapreg(env->eip);
-    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    r->regs[14] = tswapreg(env->eflags);
-    r->regs[15] = tswapreg(env->regs[R_ESP]);
-    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
-}
-
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
  * All others only supply AT_SYSINFO_EHDR.
@@ -281,7 +205,6 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_I386 */
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index ef3a6c35d2..279aeb8116 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -23,3 +24,26 @@ const char *get_elf_platform(CPUState *cs)
     family = MAX(MIN(family, 6), 3);
     return elf_platform[family - 3];
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
+{
+    r->regs[0] = tswapreg(env->regs[R_EBX]);
+    r->regs[1] = tswapreg(env->regs[R_ECX]);
+    r->regs[2] = tswapreg(env->regs[R_EDX]);
+    r->regs[3] = tswapreg(env->regs[R_ESI]);
+    r->regs[4] = tswapreg(env->regs[R_EDI]);
+    r->regs[5] = tswapreg(env->regs[R_EBP]);
+    r->regs[6] = tswapreg(env->regs[R_EAX]);
+    r->regs[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[12] = tswapreg(env->eip);
+    r->regs[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[14] = tswapreg(env->eflags);
+    r->regs[15] = tswapreg(env->regs[R_ESP]);
+    r->regs[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 88541ea45e..76cf5c1509 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -19,3 +20,36 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "x86_64";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
+{
+    r->regs[0] = tswapreg(env->regs[15]);
+    r->regs[1] = tswapreg(env->regs[14]);
+    r->regs[2] = tswapreg(env->regs[13]);
+    r->regs[3] = tswapreg(env->regs[12]);
+    r->regs[4] = tswapreg(env->regs[R_EBP]);
+    r->regs[5] = tswapreg(env->regs[R_EBX]);
+    r->regs[6] = tswapreg(env->regs[11]);
+    r->regs[7] = tswapreg(env->regs[10]);
+    r->regs[8] = tswapreg(env->regs[9]);
+    r->regs[9] = tswapreg(env->regs[8]);
+    r->regs[10] = tswapreg(env->regs[R_EAX]);
+    r->regs[11] = tswapreg(env->regs[R_ECX]);
+    r->regs[12] = tswapreg(env->regs[R_EDX]);
+    r->regs[13] = tswapreg(env->regs[R_ESI]);
+    r->regs[14] = tswapreg(env->regs[R_EDI]);
+    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[16] = tswapreg(env->eip);
+    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[18] = tswapreg(env->eflags);
+    r->regs[19] = tswapreg(env->regs[R_ESP]);
+    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+}
-- 
2.43.0


