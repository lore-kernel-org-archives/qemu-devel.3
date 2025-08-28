Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86138CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCf-0003Gw-Ib; Thu, 28 Aug 2025 13:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWf-0008Dd-Bm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWS-0008MX-Cz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:35 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77033293ed8so802407b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383270; x=1756988070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmN81to/8LnArlBTHNgeDJCC2+8PPilHqHwHcObRIIM=;
 b=z1dWGEIysyD6AYX7J2Z2QQmFKKuzLUkHcRZJBZHF/PCw8SpkIhKIRTegLHsWjlTEaq
 8IsLYzBCpVjopYUctIu7SECoBlM68LZALJNJ0H4uVji5CJRkeQ6ao2dCWnOY/QbCOX76
 5HWk6TVAdUhwoLX0aokXuw53RNCoPJSJX7ugnJDpR7zGR1GNQI9PkPG71QV3ZfhTQB4q
 6wp5eHtqxr03OqHc3TVz+WYrfhDE4kiutKsN8FFOYt4LPBibGaeKLhY+eUxuMqnRvLIr
 0oiJujKFBCNBZgGbEyOuNAJu1s0Wh6SBOIuXkm0fQ2bONOeBB9EPFJRqE2q7QXbFfljD
 +9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383270; x=1756988070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmN81to/8LnArlBTHNgeDJCC2+8PPilHqHwHcObRIIM=;
 b=fI3mnkNNkQmQxEb4jpPyTJ5PUWtOTAi6ZVqutMf/woH61/SDLO9hQghWUkYrr130tK
 37nMX9Pc0x0kygnABcZUj5OI/u+wjM3KlX6XOoJunnZzmPTEaVLV1B/2RpRlLPibPaEd
 5BdlNp5hJG3+YWV0oG9znIRlX61GoMRuTP2oCtQS4fK3arvzI1+9TKJZe3EusPc6qa43
 mxbjyxE649L+DWKyFit+GxsIlf57DNgIbGe0ycb9mJAfMkEiatviTpbEr9348Ukii3z4
 z3nVwvWQoci2QBWBjuErB33cBuocey9R9DIuIyJvOKlCWOi4FqeJuE121mUxmrzcty9C
 3DCA==
X-Gm-Message-State: AOJu0Yyie7HSSV6Z7vw8p8DbmHO6PcZe7tauZs6ecRSFXPFOr2y2T8wS
 Yxarylem4SvlmHwVWZFfjJE+4cyOdqVReiyrVImqpv+vAqh6n/u7Z/WqjQ68RB6BJ/Q9x96aAzu
 7m51f2Es=
X-Gm-Gg: ASbGncs6gEQUGmMyxGJ/swEmbWBOrb98AO0Aae+d6LMbLQHT+vEkYJLI5Scy5eJ3lkn
 yt/mmpwm47XAhYk3N6admCKShwUkJwB5EWLYctR6b4aga0TosqGjEK/e5I0d4EGkeNdBuiQRa6S
 IfH/3fugouxk7uR2vz+DXEmT/Z/tzFajtPXW0yPKmf2J01gN4YOOOA+89l1xXdDjpTMMOuo2CI1
 WwNP4mcmL2NuW+pUSadE5aUaB0H8rAsPWOBDAkeGBtFijpwkSecovULFJXeG4Xuuq08/JlhRyTv
 cr8oA+Om84LU7IYx99VNRWW1leoo7FYIw4gh6kmOveYyituEYpHyvWJXnc/CBXfdDAdkGU4NLpC
 kSW6uNZqmw1Y8j1idXYqktJ0TdtdFdaJKaXPk
X-Google-Smtp-Source: AGHT+IGSuDiZ8dddC9V/g/ZI4dTRxP8OfGV7rhW9h3AwIrVOfbdikruKFlU6fZE2ADnfaEBlLmbWpw==
X-Received: by 2002:a17:902:d603:b0:246:a42b:a31d with SMTP id
 d9443c01a7336-246a42ba453mr222055615ad.44.1756383270191; 
 Thu, 28 Aug 2025 05:14:30 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 61/87] linux-user: Move get_vdso_image_info to arm/elfload.c
Date: Thu, 28 Aug 2025 22:08:10 +1000
Message-ID: <20250828120836.195358-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Rename from vdso_image_info to avoid a symbol clash.
Define HAVE_VDSO_IMAGE_INFO to signal the external definition exists.
Provide fallback versions for other targets.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  1 +
 linux-user/loader.h         | 12 +++++++++++
 linux-user/arm/elfload.c    | 20 ++++++++++++++++++
 linux-user/elfload.c        | 41 ++++++++-----------------------------
 4 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 5f81a43efb..19fdfa2f2c 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -14,6 +14,7 @@
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_VDSO_IMAGE_INFO    1
 
 #define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
 
diff --git a/linux-user/loader.h b/linux-user/loader.h
index c3b8f92e23..2175dd4e0a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -110,4 +110,16 @@ bool init_guest_commpage(void);
 struct target_elf_gregset_t;
 void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
 
+typedef struct {
+    const uint8_t *image;
+    const uint32_t *relocs;
+    unsigned image_size;
+    unsigned reloc_count;
+    unsigned sigreturn_ofs;
+    unsigned rt_sigreturn_ofs;
+} VdsoImageInfo;
+
+/* Note that both Elf32_Word and Elf64_Word are uint32_t. */
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags);
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index a3f14af691..7e804d82a3 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -7,6 +7,7 @@
 #include "target_elf.h"
 #include "target/arm/cpu-features.h"
 #include "target_elf.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -255,3 +256,22 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
     r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
     r->pt.orig_r0 = tswapal(env->regs[0]);
 }
+
+#if TARGET_BIG_ENDIAN
+# include "vdso-be8.c.inc"
+# include "vdso-be32.c.inc"
+#else
+# include "vdso-le.c.inc"
+#endif
+
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
+#if TARGET_BIG_ENDIAN
+    return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
+            && (elf_flags & EF_ARM_BE8)
+            ? &vdso_be8_image_info
+            : &vdso_be32_image_info);
+#else
+    return &vdso_image_info;
+#endif
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 81bf05f581..aed390ebb3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -40,15 +40,6 @@
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 #endif
 
-typedef struct {
-    const uint8_t *image;
-    const uint32_t *relocs;
-    unsigned image_size;
-    unsigned reloc_count;
-    unsigned sigreturn_ofs;
-    unsigned rt_sigreturn_ofs;
-} VdsoImageInfo;
-
 #define ELF_OSABI   ELFOSABI_SYSV
 
 /* from personality.h */
@@ -191,23 +182,6 @@ typedef abi_int         target_pid_t;
 
 #define ELF_EXEC_PAGESIZE       4096
 
-#if TARGET_BIG_ENDIAN
-#include "elf.h"
-#include "vdso-be8.c.inc"
-#include "vdso-be32.c.inc"
-
-static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
-{
-    return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
-            && (elf_flags & EF_ARM_BE8)
-            ? &vdso_be8_image_info
-            : &vdso_be32_image_info);
-}
-#define vdso_image_info vdso_image_info
-#else
-# define VDSO_HEADER  "vdso-le.c.inc"
-#endif
-
 #else
 /* 64 bit ARM definitions */
 
@@ -1973,14 +1947,17 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
-#ifndef vdso_image_info
+#ifndef HAVE_VDSO_IMAGE_INFO
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
 #ifdef VDSO_HEADER
 #include VDSO_HEADER
-#define  vdso_image_info(flags)  &vdso_image_info
+    return &vdso_image_info;
 #else
-#define  vdso_image_info(flags)  NULL
-#endif /* VDSO_HEADER */
-#endif /* vdso_image_info */
+    return NULL;
+#endif
+}
+#endif /* HAVE_VDSO_IMAGE_INFO */
 
 static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
 {
@@ -2311,7 +2288,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * Load a vdso if available, which will amongst other things contain the
      * signal trampolines.  Otherwise, allocate a separate page for them.
      */
-    const VdsoImageInfo *vdso = vdso_image_info(info->elf_flags);
+    const VdsoImageInfo *vdso = get_vdso_image_info(info->elf_flags);
     if (vdso) {
         load_elf_vdso(&vdso_info, vdso);
         info->vdso = vdso_info.load_bias;
-- 
2.43.0


