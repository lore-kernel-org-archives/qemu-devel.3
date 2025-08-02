Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC6CC87FDA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJI-0002QK-HN; Sat, 02 Aug 2025 19:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJF-0002DV-3W
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:37 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJD-0001AN-9G
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:36 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40a4de175a3so1989550b6e.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175994; x=1754780794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnH7EpbfqSiddTyYEjwsuEsAObJWFo46bJT3sgyKWcQ=;
 b=opSDz+bYFJAI+/3Lm82p2iZ7OfSXSKNzb46bQO+ul9krisO5kmaVR5N6mllN23Aqn4
 LPzB1XCk7ClPvEXwgaCkxJ8BecVJxNhnpZQWiWmmjS3mPkYVc5mJl6MR0tpWfZz9Atxt
 oV5TW7LetSxvA5F9NY7sBxHGOXMl8X+8lEhT5bV6tQJM0z3rTOQ0KDkJuRoal7sL5coW
 +RlT2lN/oTAjTZmQhaxnz+aTjbkwuB/V6qTmBBNDS1GshW7OeSiPRWNbs92fLoN5kqkC
 fVG4UkCvdfPx7/0jZ+vdUWY48g6EGgl1/JbdJMRlaooYbwIEzwvC54IsWJsaa1s7qv4a
 lAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175994; x=1754780794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnH7EpbfqSiddTyYEjwsuEsAObJWFo46bJT3sgyKWcQ=;
 b=QZbdRgxhD0Qn3XHO66VFM7CdEgfQEHYGOszbHxDDUwkR8X9/IVZnE24BEiuz5Cr4LE
 8VmqEDFixiB0hscNABbrRA4dMOp3gCe8KWF5+L3cqIa9IFqdell3pOwRgEwihKa+4m0x
 niq6j/5GthUYj/ugupKWMm/KUZJ6+ZyIAAEE/hzZOaSDYVypqsZpBTyvIaPspWElngkY
 aunij+d+XDxWHchNNueYfmp6ecPfShUyzw4Xkk6PyAUhuzZ2vtSrK0SbLeFL84mApB2e
 f837rFr35DlMnhDLgbfF9IOXGNICKjTcYIHgLFdyPe5XPavX5Za+TBE3/BmaOsFNyeom
 0Dmw==
X-Gm-Message-State: AOJu0Yxbcl2Zt5PcamuaY4sxqZmS/fTIIxd1ve1LP0JhVwpnRpv8NCVR
 doioHrUlPLAfO50DWB9UvtnHDsqKFXPbDhPMkDVe42oYadZNl/eY9NWrxFfajpcyeAuBhm25THf
 s6mtjGWY=
X-Gm-Gg: ASbGncuCqMV7c7ZGSdYA4v+Yjzi/82M8/D0z34k3nSEN1Qw/5iV/t5DJd0qZzZj5Zwa
 YfT6hVH1fY3Uoap7vqYcGl83aE0H8PECpNczrEr8ip6KnMTUNs1Mcm251GU+wa2b4mo8bJTMLzP
 4ElXXmWEc8e5fV0oLzZCzmXrSAyNKLVT5O8giPdHIIh4aZPQzzq3TI3mf+VRBz1ka3HqmkNZ6+L
 RIaSs6rAmaQEevbAW6RfUYRE8AoIAZV5oDJLsn4yBI+8DE+Oe0NwOsP6a1Kpg8ywprbgM6TgY48
 PCYYbL7NnRO0eOvVX/jv9J9hVC3pt5uL60LuLVQwtE7SVX6egvwQWbY6AyismvmREIbE9N7/P+/
 wpsYz1awqtUwtO9nJixRJcluH3GGT750gOcn3zN+9sP96oilTs/eP
X-Google-Smtp-Source: AGHT+IFQIROxNVEh2+5Os34J9FLzqiG2KZR4RedDUoApNpE+IVABsnJs+MjJ2ohnnjo9VxBr/KMmtA==
X-Received: by 2002:a05:6808:21a4:b0:434:24e:c4f6 with SMTP id
 5614622812f47-434024ec5demr301917b6e.18.1754175994057; 
 Sat, 02 Aug 2025 16:06:34 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 23/95] linux-user: Move get_elf_base_platform to
 mips/elfload.c
Date: Sun,  3 Aug 2025 09:03:47 +1000
Message-ID: <20250802230459.412251-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Pass in CPUState; define HAVE_ELF_BASE_PLATFORM.
Since this was the only instance of ELF_BASE_PLATFORM, go ahead and
provide the stub definition for other platforms.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  1 +
 linux-user/mips/target_elf.h   |  1 +
 linux-user/mips64/target_elf.h |  1 +
 linux-user/elfload.c           | 40 ++++------------------------------
 linux-user/mips/elfload.c      | 30 +++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 440871466c..42cba90dea 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -106,5 +106,6 @@ abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
+const char *get_elf_base_platform(CPUState *cs);
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 877f8347d7..08e699c085 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -9,5 +9,6 @@
 #define MIPS_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_BASE_PLATFORM  1
 
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index c0347e5cb6..24bb7fcd3f 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,5 +9,6 @@
 #define MIPS64_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_BASE_PLATFORM  1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d2d73b06fc..4facaa7e27 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -679,37 +679,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define ELF_BASE_PLATFORM get_elf_base_platform()
-
-#define MATCH_PLATFORM_INSN(_flags, _base_platform)      \
-    do { if ((cpu->env.insn_flags & (_flags)) == _flags) \
-    { return _base_platform; } } while (0)
-
-static const char *get_elf_base_platform(void)
-{
-    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
-
-    /* 64 bit ISAs goes first */
-    MATCH_PLATFORM_INSN(CPU_MIPS64R6, "mips64r6");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R5, "mips64r5");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R2, "mips64r2");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R1, "mips64");
-    MATCH_PLATFORM_INSN(CPU_MIPS5, "mips5");
-    MATCH_PLATFORM_INSN(CPU_MIPS4, "mips4");
-    MATCH_PLATFORM_INSN(CPU_MIPS3, "mips3");
-
-    /* 32 bit ISAs */
-    MATCH_PLATFORM_INSN(CPU_MIPS32R6, "mips32r6");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R5, "mips32r5");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R2, "mips32r2");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R1, "mips32");
-    MATCH_PLATFORM_INSN(CPU_MIPS2, "mips2");
-
-    /* Fallback */
-    return "mips";
-}
-#undef MATCH_PLATFORM_INSN
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1169,10 +1138,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif /* TARGET_HEXAGON */
 
-#ifndef ELF_BASE_PLATFORM
-#define ELF_BASE_PLATFORM (NULL)
-#endif
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
@@ -1219,6 +1184,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs) { g_assert_not_reached(); }
 #ifndef HAVE_ELF_PLATFORM
 const char *get_elf_platform(CPUState *cs) { return NULL; }
 #endif
+#ifndef HAVE_ELF_BASE_PLATFORM
+const char *get_elf_base_platform(CPUState *cs) { return NULL; }
+#endif
 
 #include "elf.h"
 
@@ -1673,7 +1641,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     u_base_platform = 0;
-    k_base_platform = ELF_BASE_PLATFORM;
+    k_base_platform = get_elf_base_platform(thread_cpu);
     if (k_base_platform) {
         size_t len = strlen(k_base_platform) + 1;
         if (STACK_GROWS_DOWN) {
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 739f71c21b..c353ccc1ad 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -92,3 +92,33 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 #undef GET_FEATURE_REG_EQU
 #undef GET_FEATURE_REG_SET
 #undef GET_FEATURE_INSN
+
+#define MATCH_PLATFORM_INSN(_flags, _base_platform)      \
+    do { if ((cpu->env.insn_flags & (_flags)) == _flags) \
+    { return _base_platform; } } while (0)
+
+const char *get_elf_base_platform(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+
+    /* 64 bit ISAs goes first */
+    MATCH_PLATFORM_INSN(CPU_MIPS64R6, "mips64r6");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R5, "mips64r5");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R2, "mips64r2");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R1, "mips64");
+    MATCH_PLATFORM_INSN(CPU_MIPS5, "mips5");
+    MATCH_PLATFORM_INSN(CPU_MIPS4, "mips4");
+    MATCH_PLATFORM_INSN(CPU_MIPS3, "mips3");
+
+    /* 32 bit ISAs */
+    MATCH_PLATFORM_INSN(CPU_MIPS32R6, "mips32r6");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R5, "mips32r5");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R2, "mips32r2");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R1, "mips32");
+    MATCH_PLATFORM_INSN(CPU_MIPS2, "mips2");
+
+    /* Fallback */
+    return "mips";
+}
+
+#undef MATCH_PLATFORM_INSN
-- 
2.43.0


