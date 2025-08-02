Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FD0C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIY-0000q3-IA; Sat, 02 Aug 2025 19:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIN-0000iZ-7d
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:43 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIL-000154-IB
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:42 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-619a915c65fso28509eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175940; x=1754780740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkh6QSZcv8eWN+z+za46kqtwRfzEqAI+OgnnDkHvgxw=;
 b=QTpsAeGV3TqAFZavH5q2C1T5PA8i9WI79x7zx68J4lnyL4OVq1ZkAQH3tJipMcXCQc
 rS4A6R48nGy8s3uvajVH+jd4OMo1svx05pAX3nsucmevcfaENMkejIDv/gGgMpwoAEJL
 ZKG6KQFysp6HL8Gd0a5yB8Nvgr1nVLPFkSjvHMfKKDnY87wb0vQcpkv7xOJe/wHOuhew
 PYtRJkrlvKQ27OsfOBjPO1h7SljKQWPMv3KKdzZm00fBm/T7pQRVy4rd1sWwIe5KJ0ZJ
 Vx3srTYECmBxUia8/Zgu0HGwab33ZPWfwsOCuFrnDOwkZgvBl66RomcCTr9PCrJC12v4
 l/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175940; x=1754780740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkh6QSZcv8eWN+z+za46kqtwRfzEqAI+OgnnDkHvgxw=;
 b=gL6waMJBjA/QIOcJUWDVthKyUQQEoidBCK/RvvsRV8EcAxSNI3Xuo/6vaccION4giV
 5roeXrDm2oIwiDPhKtI4vCzK5ex8q3LFwclhIH1IrqVgA67mKm5NJ+0+QPoZpE3eTypQ
 UsUgvjkvpcI8JVzpbc/+ZmLRuBINMxsrB+J93VQDM7MgTfDH1h6zdF4EkKZXvBs/r5Ki
 Rob+yMk/vw5xr0w2LTIGoDWcYGAN9Z0DgLYB6aOhM/q7/pBoK+GwPXpjgv3PfIpB3lCI
 xIqVOAMDjJskHAOjCxYlXgxvoQd7GaH1qEZUDWUNLi3HZ09iGz8j+CZqIobTACMjM1xc
 4VuA==
X-Gm-Message-State: AOJu0YwI+mqSYf1xm2Z+FXXWp1Z6+h+nINrmuzlq+YHmu/Z91Zgn/h+g
 7TR4veA6kru4tv6jO5SMZTdDLOrZZHjAd11FQVby5EFr9nZCFSTuQcBUJ1zBW74463kUy9kYOFC
 5SXowNZk=
X-Gm-Gg: ASbGncu9KoEHp9hbjPs9eyD29zL9PhqklYzOOR/Uu71NpZhO8PjHdDSY1nCMGZH9FuL
 UVI787k6fiM2HPtAjFZNY7kcXY3Rar/VERh0AFj2SRNiTyXEwmv9CPtc+G0tm64sN73QzX/xlI6
 H2OrR/McABodf6it42xbcMZdFyJKV9yoWPkY2XV9Bp2gDjLhYta3SRKbcpeyX/KgPMLs/yQVWRX
 xllEJZU6vDYyByMsX9aINIJ5M7k28zLV2SLmLXmTOYhX3Qu5MOGv6+8xwluw0UfGZwNySrGTj57
 CsErYSYUFREJlBNoCfKZrwV48FAhpJQPzUVFd/GN3RkcKaILfpuKnDnvpK3D5hsGbUq2zxnuict
 hWWWBTKT0cEjDmJ9q7+zwftIgQOdiM8ekrpBnJ5nyAmpAx3eIyxef
X-Google-Smtp-Source: AGHT+IHYZZpyVvHyS+P1TqjQ79iCEhSf6K9UkApJsM/xwoQTEbpfUSserk+EFND6w5fIqkLs87Rj8w==
X-Received: by 2002:a05:6820:984:b0:611:31a:6ff5 with SMTP id
 006d021491bc7-6198f2a454amr2447198eaf.7.1754175940015; 
 Sat, 02 Aug 2025 16:05:40 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 08/95] linux-user: Move get_elf_hwcap to sparc/elfload.c
Date: Sun,  3 Aug 2025 09:03:32 +1000
Message-ID: <20250802230459.412251-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Change the return type to abi_ulong, and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h           |  3 ++-
 linux-user/sparc/target_elf.h |  2 ++
 linux-user/elfload.c          | 30 +-----------------------------
 linux-user/sparc/elfload.c    | 27 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 151a06f5db..2c8414e0e5 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,7 +101,8 @@ extern unsigned long guest_stack_size;
 /* Note that Elf32 and Elf64 use uint32_t for e_flags. */
 const char *get_elf_cpu_model(uint32_t eflags);
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM)
+#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
+    || defined(TARGET_SPARC)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 7e46748d26..b7544db0a1 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 149d1313c0..16709865f7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -565,35 +565,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#include "elf.h"
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    /* There are not many sparc32 hwcap bits -- we have all of them. */
-    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
-                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
-
-#ifdef TARGET_SPARC64
-    CPUSPARCState *env = cpu_env(thread_cpu);
-    uint32_t features = env->def.features;
-
-    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
-    /* 32x32 multiply and divide are efficient. */
-    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
-    /* We don't have an internal feature bit for this. */
-    r |= HWCAP_SPARC_POPC;
-    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
-    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
-    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
-    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
-    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
-    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
-#endif
-
-    return r;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 243e6f9b66..32ca1b05b1 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -13,3 +14,29 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "Fujitsu MB86904";
 #endif
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /* There are not many sparc32 hwcap bits -- we have all of them. */
+    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
+                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
+
+#ifdef TARGET_SPARC64
+    CPUSPARCState *env = cpu_env(cs);
+    uint32_t features = env->def.features;
+
+    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
+    /* 32x32 multiply and divide are efficient. */
+    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
+    /* We don't have an internal feature bit for this. */
+    r |= HWCAP_SPARC_POPC;
+    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
+    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
+    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
+    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
+#endif
+
+    return r;
+}
-- 
2.43.0


