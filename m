Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA996C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugud4-0001LB-Ag; Tue, 29 Jul 2025 20:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJF-0004p2-Au
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJC-0004fu-K0
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:40 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-769a21bd4d5so1284548b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833877; x=1754438677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YZoq+hHfPevFxCSDdOA+glZMG/9hobef5ggmN7qr+g0=;
 b=g5lYZWMpud47Ax/oeSfAOFn2iI7zPyWyQIJvhRAyFn7cvrpo27Ftrma3Awn583j1oJ
 pv8VJi7HTVaXvKDakKBcGlw3n92e8t/rm1gBel9jBxliVP+J2gQBYNKhNOdyoVCZikuG
 OipqjqncQrvbBUQoxRzS+6763tGtFh0BSjIt4mvl1UxVq/PvWAZJAa77nq7vnoiGmHim
 AJfKr9SFX1tWymTPeWKfddxJl3thFjg/bDmbnVsjsjBVHQKJ/WcI+fWIXHl8wZWzDbWh
 UbMEUPSPI5/x/uvVe2OrCNyviB44ghIZTeb7Ay6lCePZ1aJTzTlDOkoB5aVsmsTM/8+c
 rlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833877; x=1754438677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZoq+hHfPevFxCSDdOA+glZMG/9hobef5ggmN7qr+g0=;
 b=f8WLRshFqqVDpRBxZ+wNu6w9tpJ7wrba2Cv8/UnjDjK8BNkllBId21QH2TMH8GLpoV
 psqDVMuCzzbUr/k02bInevUBQozjk/hgQiE++/9aEMrDY3S1YD9LSEN8/+vLqXJj1mKp
 55klbfMOvARWA3QYlnBTQkAzNl9Mf4texj+p5bqfPyz/Epv7f/ZlKVHmlE3TGZExGV0x
 cPpmhHaOdOroj0PLUg2W8qCF0eoobGXEfmiB0yqhPkkQh7YOpr1UV8ieldulREju+izg
 q5zBG0SYiyDgNbuailgNCjNTNp9kFx6nD1yK0CovuSELfMM/MqXoBjLvgethQGuHi56u
 +/bQ==
X-Gm-Message-State: AOJu0YwywqWCY2r89ih8qKlkr+twnmTFVBFU2QQtKddMcoF3KlNM9VOB
 7gV3KTGBujrszlkjQDBKAH9BXftzs090wIcpztgD4Kxhsy0U6Oj/tMC0nIKVETtwk/lf66YJflS
 WmR4r
X-Gm-Gg: ASbGncs9NYCavfxcVzHkL6MC02Y9NVFeJBqtmF2gkoE7KIfZBq1VjpXGIJFVLm+l5jW
 oFb8b9P0vir2PyC48OnKQFFlZZpksZy8MgjkiAIEZpS9CC0OS8p8Vn1OQ2gA7Att+XsAj4Q6q7U
 QKC0aBn2caMrR88d7EWhS7Ri4m281CrKtqQYzI1BtoffMOG6b3bd/dEigY21Pj9VSCcZ+n/F0Kl
 lB7Qa6ZEV6fZQ0oSnUDxdxCjadPnTbWyteX97axCL2AHbUmMK3JtgCALu7ExwEtsJ9jvrENsSoW
 dzI1Mv8vOIueH3on4JFS2UvSrSGKPHrfQx2OoExgRlvBCkYofjHQSNn/LfIMxzQ3angmINJBjkB
 dBhbGPOY7TEilzK3s10ZW0Sy9zOdTeSMVtId84rh2TvKVg2XqvxnC38nRsOxuHG2kAwuUv9Fxr3
 Inr8H2K+5GUg==
X-Google-Smtp-Source: AGHT+IGoiE3ynd5lFvhbbq8vh9IePg+V5TJ/kHISWgVu9kw9tyniczkzXdDPJux1phOUiQ207Gu3oA==
X-Received: by 2002:a05:6a20:7283:b0:233:d150:77b0 with SMTP id
 adf61e73a8af0-23dc0ed4106mr1817001637.28.1753833877086; 
 Tue, 29 Jul 2025 17:04:37 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 63/89] linux-user: Move elf parameters to {i386,
 x86_64}/target_elf.h
Date: Tue, 29 Jul 2025 13:59:36 -1000
Message-ID: <20250730000003.599084-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 linux-user/i386/target_elf.h   | 23 +++++++++++++++++++
 linux-user/x86_64/target_elf.h |  5 +++++
 linux-user/elfload.c           | 41 +---------------------------------
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index e6f0d8fa4e..032abe5d24 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -8,4 +8,27 @@
 #ifndef I386_TARGET_ELF_H
 #define I386_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_386
+#define EXSTACK_DEFAULT         true
+#define VDSO_HEADER             "vdso.c.inc"
+#define USE_ELF_CORE_DUMP
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) ( ((x) == EM_386) || ((x) == EM_486) )
+
+/*
+ * i386 is the only target which supplies AT_SYSINFO for the vdso.
+ * All others only supply AT_SYSINFO_EHDR.
+ */
+#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        if (vdso_info) {                                \
+            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
+        }                                               \
+    } while (0)
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 5849f96350..7eac11e338 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -8,4 +8,9 @@
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_X86_64
+#define VDSO_HEADER             "vdso.c.inc"
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 70bfd18de6..d071bca660 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -28,6 +28,7 @@
 #include "qemu/lockable.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "target_elf.h"
 #include "target_signal.h"
 #include "tcg/debuginfo.h"
 
@@ -137,46 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_I386
-
-#ifdef TARGET_X86_64
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_X86_64
-#else
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) ( ((x) == EM_386) || ((x) == EM_486) )
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_386
-
-#define EXSTACK_DEFAULT true
-
-/*
- * i386 is the only target which supplies AT_SYSINFO for the vdso.
- * All others only supply AT_SYSINFO_EHDR.
- */
-#define DLINFO_ARCH_ITEMS (vdso_info != NULL)
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        if (vdso_info) {                                \
-            NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);  \
-        }                                               \
-    } while (0)
-
-#endif /* TARGET_X86_64 */
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#define USE_ELF_CORE_DUMP
-
-#endif /* TARGET_I386 */
-
 #ifdef TARGET_ARM
 
 #ifndef TARGET_AARCH64
-- 
2.43.0


