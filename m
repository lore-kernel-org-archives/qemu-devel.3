Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BE9C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucb-0007mM-Ui; Tue, 29 Jul 2025 20:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ8-0004m5-Em
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ6-0004eq-KG
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:34 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so318692b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833871; x=1754438671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VlbWwV3nxGhn1Ze57y00uhJHUwo3dhORAor2v/a3Spk=;
 b=C0XBmlInVDkFXLaIforgF8jYO9VwihJFLp9m5oYFM/aBbrGDSRV0zlzhMrPvZ9LvOV
 37sYeg7hW/+hzsQjLgnQSZqwpuXb12//vjMRVQsBzderZO3f53JGXDnuo60kokKZSQMu
 kwqBHEM9aS5ClN+hUnia76AB2Ym8R3AVhqfR3TJ6SY3lgFgHqvXG0N4aC973G/cjA5bs
 MPrrlO/iQ7TgXrxVuRxl+ihCCGly9FU03B4kXBWi4M+LTXzNaTG/J9BUIBO2fEdApPi7
 P1DgqhFhRx/QRF1c3vZ6/qMqIckk5D84NUs3J8F5okOePUywXutULYZI8QRNMyWNaSUk
 YblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833871; x=1754438671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlbWwV3nxGhn1Ze57y00uhJHUwo3dhORAor2v/a3Spk=;
 b=Y5+sINH5xUO4CXqRUrGeL2TzwQubh4+d+IDFOc9WreT9CagUpPBdjPXdcE4W567q0q
 nIIww9oUIgh90YR90PBQJBGin3y0XpqSvSAKmyweNEotdXpO+YElx1EyoZltmEdx+ivi
 se0NLscCwCOqTDMeIrlpKv+cv7Z9oHvwcHjQ+R1gmc++lceHaTtzGJKhQA3+3ZT+7niJ
 Be9zFn5q+zy1pA328X/ByxJc+G++pB+u6YF1yA05hqrpd4bz1wg/IzgvO7UclxAsYmd/
 wQGsRN6f4fpWZcwkIvJu8oShBYBdaORlxnj1swy9P3LaS7NUdP2W7itO5dfWTljLOowm
 kYdA==
X-Gm-Message-State: AOJu0YyijNOOxB76P1SSY/TxJULE/jwhXGALOConipQObFRfvMP5tNpm
 pvbKY4edLtgjkWYahBvpTb9gf6KTOzgLgTVO2a9I99ZnhiZBCFbnCjQOHZnjPRT/A87/Z5S/A4r
 z3Lo8
X-Gm-Gg: ASbGncsFOLO4fu9S4n8TYxX/HQEtavZWZCQFAUmT/b29u0tea9/EGmQC1VkKsfTzSA7
 xtSYT9uYwD1KfRLnMz30SKYdLFMfIBBQYmEhQCCwo3b7SDrdH0WqhT44OZKmqFor7+WfSjupjdi
 Hhq6ADfVe3p6x6/j2IFShM9DCj/42MVobB68uOog4N8K9NxVE8Q+kRUtE3Qr6rsX75B3UaQjMOh
 ED4lN3f14lrdJRfgKPHx3657qEHacOgQQ2zXaqUx6xgCNvTmjkPxpwzynsKGYN4DZUTNwA6dXGR
 7MC4xYkqHQnVXjHR4n1N89DosUcC3eWVKXIc2MTzRQmnYT/rxYCz5w8k8r2gu+NxWqhvYXxkz9e
 v/+Ay1XapRiDoOLPg7HZsM0zg+J8qM2O38qaHRO732Da1pxk5WGJtUSPbIk/P5sHt1pQkDLEzy/
 GbNDCrpQ5vy0V5zPFnD2UZ
X-Google-Smtp-Source: AGHT+IF9U2DEPGn5FLj06t2IzLSHakR/uipI+U49wCHlcmZU2CfVuRKEfZE0UAbpoApR8XXIXUfEXg==
X-Received: by 2002:a05:6a00:848:b0:742:aecc:c46b with SMTP id
 d2e1a72fcca58-76ab2319688mr1812800b3a.15.1753833870819; 
 Tue, 29 Jul 2025 17:04:30 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/89] linux-user: Move get_vdso_image_info to arm/elfload.c
Date: Tue, 29 Jul 2025 13:59:32 -1000
Message-ID: <20250730000003.599084-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Rename from vdso_image_info to avoid a symbol clash.
Provide fallback versions for other targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h      | 12 ++++++++++++
 linux-user/arm/elfload.c | 20 ++++++++++++++++++++
 linux-user/elfload.c     | 41 ++++++++++------------------------------
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index e6d02d186e..db6547ea7a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -104,4 +104,16 @@ const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
 bool init_guest_commpage(void);
 
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
index ad0d88a7e0..901141ad2a 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -6,6 +6,7 @@
 #include "user-internals.h"
 #include "target_elf.h"
 #include "target/arm/cpu-features.h"
+#include "elf.h"
 
 
 enum
@@ -240,3 +241,22 @@ bool init_guest_commpage(void)
                    PAGE_READ | PAGE_EXEC | PAGE_VALID);
     return true;
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
index 01c39bf456..10fbe71e35 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -46,15 +46,6 @@
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
@@ -206,23 +197,6 @@ typedef abi_int         target_pid_t;
 #define USE_ELF_CORE_DUMP
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
 
@@ -2011,14 +1985,19 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
-#ifndef vdso_image_info
 #ifdef VDSO_HEADER
 #include VDSO_HEADER
-#define  vdso_image_info(flags)  &vdso_image_info
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
+    return &vdso_image_info;
+}
 #else
-#define  vdso_image_info(flags)  NULL
+const VdsoImageInfo * __attribute__((weak))
+get_vdso_image_info(uint32_t elf_flags)
+{
+    return NULL;
+}
 #endif /* VDSO_HEADER */
-#endif /* vdso_image_info */
 
 static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
 {
@@ -2349,7 +2328,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
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


