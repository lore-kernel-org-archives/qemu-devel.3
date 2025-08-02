Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05B7C87FDA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOy-0004YR-BK; Sat, 02 Aug 2025 19:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOc-0003r4-3c
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:11 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOY-0001qC-Jr
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:08 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61997c8e2a1so388438eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176325; x=1754781125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTx1fj5rdrYNDuo5F88JtxGg2c6LutUZmN3zw6hV3I8=;
 b=bTxzJ0jJ5xkpj6iMqxnStAxzFVT6mYNL8lWusMrN1gpmEOfJZHL1X/tM5HhXUAwPPA
 3P+aSDYZ5d6atfEN+5Xngw1HeC2S958yWskk29UUmK15eTGOMh2mz8gQm6RWvMVHXxrq
 jxhjhd4WlhfNqwiHwrN7U8plpBOIHmMbe9dXv5DQqiN6MQydoh3wAO8TqBtPQjH6FOT5
 gDZqv4HZ22qELwGzJiCGD0ZSnKibJVCC1Z5C2t0eHeavg5PEUVdbrSgEVRVeijagPfVX
 FwYJMoVjE+jPnjAskfgfYnFVbAilK9rxoOIGjxW2sKOhb9mw+T+QjUWyEuOrYFX7zlRJ
 6ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176325; x=1754781125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTx1fj5rdrYNDuo5F88JtxGg2c6LutUZmN3zw6hV3I8=;
 b=q/I4jWNXaIuTkRFbSQQpkH2WwhuDH2NQ/lBmsYu9V8JuklJYO+AESsqQ2kMga5mYL9
 Sb2vIJPkzTRo303YL5BwG0PKor+qU0hcwFgc4pn8N0ejsAutddRvBKa1efQYlGa73UbW
 TUfiBLwM16hvOEGUFZ16nT+hEufdWe3/GmYbZ3a+p42JErX1sV9KlBDCCstwpOhW/SDc
 XHxhhpAOpHB9UunaGnsUaKE/Brq8Wiih1s4f7DdFDiBlK3WAwa/cBWNBtw9DjXevfMLz
 8xmIFcCzbk7X7xbkvVRnvZvpfGyVPPDSBqfAShb3YbQGV2kGZ4E80pMI8MP5pefi5Qnf
 cJyA==
X-Gm-Message-State: AOJu0YxoLg2osQNgZt2sk/n2NbqAHPrwor4foKqLCpkKZl6E8S8iMm3R
 RqMdOL0+S2iY5Wvlj7zKDbvT+PXDGOfe1inBNOLZMnKW262zaUDA113/7KcI/UrtaxoYkE8f9hL
 6tCkbslo=
X-Gm-Gg: ASbGnctJvHjCI60gle1mEFLRV55JB9upe1fyfmhz6urmAKeCeo8oDomLLzPuR9DSPxu
 9SOY8GcZ11hVsj/amqgEL7CuCmzNGiih2maImN1hPYRihP0+7byZE/w3jHBwyVD3GAOJayRNV6s
 sIAYSeBBmYtqiQ9NL9TW/sPD7NHUGYhsMPCfTqrr01v+KtdSpc50y0iXuPwdreCTWejrhHZwnR7
 ffsxRwlT0DyCkgkspGlSLXaJ0Ny7EsHM8QCpU8T0PaVwla6NC7ngz00UT1Gsepve8wWBmoQZAgE
 7VZC2KJz+oRwmvluaAB+lg+VeQFk2e27naNcbFBmcAXe3UUj9NQI5lKS4a3xupXF+HhKxtg8dy6
 WToi9H30RvRvU4PyvkkB7g52bjW1S/2rDQnQrBB27SAxNYbNHwJUn
X-Google-Smtp-Source: AGHT+IHUIcsJSVKhKnDdCnkkkPIX87msEy+jgnOcTGvMvR5pDNjV3yuYeptWpw53i9308+K5Ipz40g==
X-Received: by 2002:a4a:ef86:0:b0:611:758f:1fa4 with SMTP id
 006d021491bc7-619703746fdmr3858693eaf.0.1754176325518; 
 Sat, 02 Aug 2025 16:12:05 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 66/95] linux-user: Move get_vdso_image_info to arm/elfload.c
Date: Sun,  3 Aug 2025 09:04:30 +1000
Message-ID: <20250802230459.412251-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
index c98d48745c..0fbeffae64 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -11,6 +11,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_VDSO_IMAGE_INFO    1
 
 #define ELF_NREG                18
 #define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 4ef46fba5c..7fad9e7b4a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -108,4 +108,16 @@ const char *get_elf_base_platform(CPUState *cs);
 bool init_guest_commpage(void);
 void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
 
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
index 0c18cde12e..99123de503 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -6,6 +6,7 @@
 #include "user-internals.h"
 #include "target_elf.h"
 #include "target/arm/cpu-features.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -254,3 +255,22 @@ void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
     regs[16] = tswapl(cpsr_read((CPUARMState *)env));
     regs[17] = tswapl(env->regs[0]); /* XXX */
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
index 0299bb852b..8cf9a1d77f 100644
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


