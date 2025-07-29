Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99856C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucm-0008SV-Bb; Tue, 29 Jul 2025 20:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJC-0004oV-Cw
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ9-0004fL-6W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74b27c1481bso216750b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833874; x=1754438674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pzAo9og/LdnH6R3ajG/CQEAEEaS/KHsWi5yDM8S8I9o=;
 b=TRmgCMMBNr4XX1eFSsjo620ruZu+CGiw2mgBYkixX2+2bi/N9B3C7+JpMc6tqR2+CX
 tOXm1CZRCG8+jtZJ2PoUzBqbSlWvu8hp+bKAU4QlY2ncClNSIGTgW1P4eQZ4hi6pTwwQ
 gkRSmcl8UUNPSlM1QSDZY47zxgrBaYNkdGkkOBSKGk8p3Qo4X3zkd/kX9003Wos/yxIl
 NluIrgP+IcZVJ1PZLIiJdHwUC3d1JxjCLRnOr9cqzOKK3BrGs7BcVVZs25d1bNfptJYF
 NfWvsCUUdg3HghGqRyaCJQIUT3vxe0V+VtSY4lOR9LfqJ/54MEcylMTULa+YisUOMrC5
 xhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833874; x=1754438674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzAo9og/LdnH6R3ajG/CQEAEEaS/KHsWi5yDM8S8I9o=;
 b=KfBnh1Wpu7x3nU5u0AwYqYhmVVZaiFgeBJnNWNezrr1J/vc4iaH6pKERslI7SHrL1d
 ccYvp7c82Vp1ZOptKBDJJmX7vabCAFjDREuI4gKeVRy3Axhh6RlDOjirrHL1NV/QTKC7
 2pYhEEXi3y/bOMsVNceZazjGyu6W8J3/ZPvv++SmxRY7CnBIK6gUZU41t+qoBhJwkYHa
 005CYlkogxJjJg0YoYzMfvl+7EYPRkweQSjtUhbFpj9pZg8E606HAsySeahplrEQBEUZ
 G7ZrzWs3NjlmWRLbYv7RD1s8+CFSXhEVkPNkSyfoeOin/EI4FLz2ybeLnG/MwtEtvDC3
 lHIg==
X-Gm-Message-State: AOJu0Ywc3XdfUQ8BRZB5Z2coHWNo/n5Y6OBwD/xz1Y47zhFzlPs4zg0m
 Aur3SHyZLF0ofkj1LZxOxU8QMjLv0SbDR/xWlBjWP2N4JTGjjRsglOqPiq24eeUwcPvpGWIvxBd
 mA3eA
X-Gm-Gg: ASbGncsrvnO9Oh/3uNVzsOqKtmyox5JoNfYDWZBxPUh407pmUm5xM45HtpEl2F79mL3
 80IprcvNv+fNV+zUav76kvYj6UdpFdfVl3FtFq2v9Cx3gaaXpAklgj45hsgYoHNLBNedZd8yhfU
 yamfex6OXWJHNScipDcpYANdWr32X46vsCeJd6Bwu2zef+BeB0CLGutP2I0H9ND7XXnpcJDZGZ/
 wBbZ62iNOHQB4bqmB9iL8IvxRNh5//BuqEpmsqdnA5ZZCGqLLlz2WyCdCYl5kXZrxpa/LsirtOJ
 +T874mtPoCkehR6/jGS3XyXEhz7q7+N7+R7SvDl0r4AJkQHYvsXXs7st/nXrwfzulRPoCAD+Mf1
 aQDuARrbDjo/fKKLOED+bejG65AZ5M+rgDWhw0x5E56b0Q+/RYo+BGvDd+Oh7cnpLyLk67MhOVc
 SuM8y92ZzgCw==
X-Google-Smtp-Source: AGHT+IE7thm27I+Wyp6tDkSZc5qErXcPVsHEzS8ijDXGB41hLgcSDm4t7K/hDdzN6ho9agA9J9wsLQ==
X-Received: by 2002:aa7:88d1:0:b0:74b:4d96:d159 with SMTP id
 d2e1a72fcca58-76aad77f4d6mr1961540b3a.0.1753833873547; 
 Tue, 29 Jul 2025 17:04:33 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/89] linux-user: Move get_elf_cpu_model to target/elfload.c
Date: Tue, 29 Jul 2025 13:59:34 -1000
Message-ID: <20250730000003.599084-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Rename from cpu_get_model to emphasize that this is
an elf-specific function.  Declare the function once
in loader.h.

This frees up target_elf.h for other uses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h     |  5 +---
 linux-user/alpha/target_elf.h       |  5 +---
 linux-user/arm/target_elf.h         |  5 ----
 linux-user/hexagon/target_elf.h     | 29 ----------------------
 linux-user/hppa/target_elf.h        |  5 ----
 linux-user/i386/target_elf.h        |  5 +---
 linux-user/loader.h                 |  1 +
 linux-user/loongarch64/target_elf.h |  5 +---
 linux-user/m68k/target_elf.h        |  9 -------
 linux-user/microblaze/target_elf.h  |  5 +---
 linux-user/mips/target_elf.h        | 11 +--------
 linux-user/mips64/target_elf.h      | 27 +-------------------
 linux-user/openrisc/target_elf.h    |  5 +---
 linux-user/ppc/target_elf.h         |  9 +------
 linux-user/riscv/target_elf.h       |  5 +---
 linux-user/s390x/target_elf.h       |  5 +---
 linux-user/sh4/target_elf.h         |  5 +---
 linux-user/sparc/target_elf.h       |  9 +------
 linux-user/x86_64/target_elf.h      |  5 +---
 linux-user/xtensa/target_elf.h      |  5 ----
 linux-user/aarch64/elfload.c        |  5 ++++
 linux-user/alpha/elfload.c          | 10 ++++++++
 linux-user/arm/elfload.c            |  5 ++++
 linux-user/hexagon/elfload.c        | 34 ++++++++++++++++++++++++++
 linux-user/hppa/elfload.c           |  5 ++++
 linux-user/i386/elfload.c           |  5 ++++
 linux-user/loongarch64/elfload.c    |  5 ++++
 linux-user/m68k/elfload.c           | 17 +++++++++++++
 linux-user/main.c                   |  3 +--
 linux-user/microblaze/elfload.c     | 10 ++++++++
 linux-user/mips/elfload.c           | 38 +++++++++++++++++++++++++++++
 linux-user/openrisc/elfload.c       | 10 ++++++++
 linux-user/ppc/elfload.c            |  9 +++++++
 linux-user/riscv/elfload.c          |  5 ++++
 linux-user/s390x/elfload.c          |  5 ++++
 linux-user/sh4/elfload.c            |  5 ++++
 linux-user/sparc/elfload.c          |  9 +++++++
 linux-user/x86_64/elfload.c         |  5 ++++
 linux-user/xtensa/elfload.c         | 10 ++++++++
 39 files changed, 208 insertions(+), 147 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index a7eb962fba..d955b3d07f 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index b77d638f6d..52b68680ad 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef ALPHA_TARGET_ELF_H
 #define ALPHA_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "ev67";
-}
+
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index bb9875fa2d..209076284b 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -10,9 +10,4 @@
 
 #define HI_COMMPAGE (intptr_t)0xffff0f00u
 
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
-
 #endif
diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index 36056fc9f0..eccf207f6b 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -18,33 +18,4 @@
 #ifndef HEXAGON_TARGET_ELF_H
 #define HEXAGON_TARGET_ELF_H
 
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    static char buf[32];
-    int err;
-
-    /* For now, treat anything newer than v5 as a v73 */
-    /* FIXME - Disable instructions that are newer than the specified arch */
-    if (eflags == 0x04 ||    /* v5  */
-        eflags == 0x05 ||    /* v55 */
-        eflags == 0x60 ||    /* v60 */
-        eflags == 0x61 ||    /* v61 */
-        eflags == 0x62 ||    /* v62 */
-        eflags == 0x65 ||    /* v65 */
-        eflags == 0x66 ||    /* v66 */
-        eflags == 0x67 ||    /* v67 */
-        eflags == 0x8067 ||  /* v67t */
-        eflags == 0x68 ||    /* v68 */
-        eflags == 0x69 ||    /* v69 */
-        eflags == 0x71 ||    /* v71 */
-        eflags == 0x8071 ||  /* v71t */
-        eflags == 0x73       /* v73 */
-       ) {
-        return "v73";
-    }
-
-    err = snprintf(buf, sizeof(buf), "unknown (0x%x)", eflags);
-    return err >= 0 && err < sizeof(buf) ? buf : "unknown";
-}
-
 #endif
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 00dc2d6684..a736bb9bb3 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -10,9 +10,4 @@
 
 #define LO_COMMPAGE  0
 
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "hppa";
-}
-
 #endif
diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 238a9aba73..e6f0d8fa4e 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef I386_TARGET_ELF_H
 #define I386_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "max";
-}
+
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index db6547ea7a..a4178ce2c1 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -96,6 +96,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
+const char *get_elf_cpu_model(uint32_t eflags);
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 95c3f05a46..39a08d35d9 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -5,8 +5,5 @@
 
 #ifndef LOONGARCH_TARGET_ELF_H
 #define LOONGARCH_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "la464";
-}
+
 #endif
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 998fe0fe2f..62ff9d38d4 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -7,14 +7,5 @@
 
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    if (eflags == 0 || (eflags & EF_M68K_M68000)) {
-        /* 680x0 */
-        return "m68040";
-    }
 
-    /* Coldfire */
-    return "any";
-}
 #endif
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 8a8f1debff..bfe2997fd2 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 71a32315a8..febf710c7a 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -7,14 +7,5 @@
 
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
-        return "mips32r6-generic";
-    }
-    if (eflags & EF_MIPS_NAN2008) {
-        return "P5600";
-    }
-    return "24Kf";
-}
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 502af9d278..02e6d14840 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -7,30 +7,5 @@
 
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    switch (eflags & EF_MIPS_MACH) {
-    case EF_MIPS_MACH_OCTEON:
-    case EF_MIPS_MACH_OCTEON2:
-    case EF_MIPS_MACH_OCTEON3:
-        return "Octeon68XX";
-    case EF_MIPS_MACH_LS2E:
-        return "Loongson-2E";
-    case EF_MIPS_MACH_LS2F:
-        return "Loongson-2F";
-    case EF_MIPS_MACH_LS3A:
-        return "Loongson-3A1000";
-    default:
-        break;
-    }
-    switch (eflags & EF_MIPS_ARCH) {
-    case EF_MIPS_ARCH_64R6:
-        return "I6400";
-    case EF_MIPS_ARCH_64R2:
-        return "MIPS64R2-generic";
-    default:
-        break;
-    }
-    return "5KEf";
-}
+
 #endif
diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index 265ecd3079..b34f2ff672 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
 #endif
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 0616618854..8c0a8ea431 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -7,12 +7,5 @@
 
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-#ifdef TARGET_PPC64
-    return "POWER9";
-#else
-    return "750";
-#endif
-}
+
 #endif
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index dedd5956f3..bfe86105d0 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "max";
-}
+
 #endif
diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index 8114b59c1d..e51b053339 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef S390X_TARGET_ELF_H
 #define S390X_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "qemu";
-}
+
 #endif
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index f485e0cef2..d17011bd75 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef SH4_TARGET_ELF_H
 #define SH4_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "sh7785";
-}
+
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index a510ceb612..7e46748d26 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -7,12 +7,5 @@
 
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-#ifdef TARGET_SPARC64
-    return "TI UltraSparc II";
-#else
-    return "Fujitsu MB86904";
-#endif
-}
+
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 3f628f8d66..5849f96350 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef X86_64_TARGET_ELF_H
 #define X86_64_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "max";
-}
+
 #endif
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index a9a3fabd89..2c55c22e14 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -8,9 +8,4 @@
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return XTENSA_DEFAULT_CPU_MODEL;
-}
-
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 825be0a25a..1030cb8094 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -6,6 +6,11 @@
 #include "target/arm/cpu-features.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
+
 enum {
     ARM_HWCAP_A64_FP            = 1 << 0,
     ARM_HWCAP_A64_ASIMD         = 1 << 1,
diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
index 73fa78ef14..1e44475c47 100644
--- a/linux-user/alpha/elfload.c
+++ b/linux-user/alpha/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "ev67";
+}
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 901141ad2a..82768c437a 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -9,6 +9,11 @@
 #include "elf.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
+
 enum
 {
     ARM_HWCAP_ARM_SWP       = 1 << 0,
diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
index 73fa78ef14..d8b545032a 100644
--- a/linux-user/hexagon/elfload.c
+++ b/linux-user/hexagon/elfload.c
@@ -1 +1,35 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    static char buf[32];
+    int err;
+
+    /* For now, treat anything newer than v5 as a v73 */
+    /* FIXME - Disable instructions that are newer than the specified arch */
+    if (eflags == 0x04 ||    /* v5  */
+        eflags == 0x05 ||    /* v55 */
+        eflags == 0x60 ||    /* v60 */
+        eflags == 0x61 ||    /* v61 */
+        eflags == 0x62 ||    /* v62 */
+        eflags == 0x65 ||    /* v65 */
+        eflags == 0x66 ||    /* v66 */
+        eflags == 0x67 ||    /* v67 */
+        eflags == 0x8067 ||  /* v67t */
+        eflags == 0x68 ||    /* v68 */
+        eflags == 0x69 ||    /* v69 */
+        eflags == 0x71 ||    /* v71 */
+        eflags == 0x8071 ||  /* v71t */
+        eflags == 0x73       /* v73 */
+       ) {
+        return "v73";
+    }
+
+    err = snprintf(buf, sizeof(buf), "unknown (0x%x)", eflags);
+    return err >= 0 && err < sizeof(buf) ? buf : "unknown";
+}
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index c7e1e3952a..018034f244 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -6,6 +6,11 @@
 #include "target_elf.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "hppa";
+}
+
 const char *get_elf_platform(CPUState *cs)
 {
     return "PARISC";
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 6a79738786..ef3a6c35d2 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -5,6 +5,11 @@
 #include "loader.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "max";
+}
+
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
     return cpu_env(cs)->features[FEAT_1_EDX];
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 450e567c72..911352840f 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -5,6 +5,11 @@
 #include "loader.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "la464";
+}
+
 /* See arch/loongarch/include/uapi/asm/hwcap.h */
 enum {
     HWCAP_LOONGARCH_CPUCFG   = (1 << 0),
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 73fa78ef14..561ac5b3b3 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -1 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+#include "elf.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    if (eflags == 0 || (eflags & EF_M68K_M68000)) {
+        /* 680x0 */
+        return "m68040";
+    }
+
+    /* Coldfire */
+    return "any";
+}
diff --git a/linux-user/main.c b/linux-user/main.c
index d962f344b8..189b77b578 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -49,7 +49,6 @@
 #include "qemu/guest-random.h"
 #include "elf.h"
 #include "trace/control.h"
-#include "target_elf.h"
 #include "user/cpu_loop.h"
 #include "crypto/init.h"
 #include "fd-trans.h"
@@ -805,7 +804,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (cpu_model == NULL) {
-        cpu_model = cpu_get_model(get_elf_eflags(execfd));
+        cpu_model = get_elf_cpu_model(get_elf_eflags(execfd));
     }
     cpu_type = parse_cpu_option(cpu_model);
 
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/microblaze/elfload.c
+++ b/linux-user/microblaze/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index f2b132697e..c353ccc1ad 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -3,8 +3,46 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "elf.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_MIPS64
+    switch (eflags & EF_MIPS_MACH) {
+    case EF_MIPS_MACH_OCTEON:
+    case EF_MIPS_MACH_OCTEON2:
+    case EF_MIPS_MACH_OCTEON3:
+        return "Octeon68XX";
+    case EF_MIPS_MACH_LS2E:
+        return "Loongson-2E";
+    case EF_MIPS_MACH_LS2F:
+        return "Loongson-2F";
+    case EF_MIPS_MACH_LS3A:
+        return "Loongson-3A1000";
+    default:
+        break;
+    }
+    switch (eflags & EF_MIPS_ARCH) {
+    case EF_MIPS_ARCH_64R6:
+        return "I6400";
+    case EF_MIPS_ARCH_64R2:
+        return "MIPS64R2-generic";
+    default:
+        break;
+    }
+    return "5KEf";
+#else
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
+        return "mips32r6-generic";
+    }
+    if (eflags & EF_MIPS_NAN2008) {
+        return "P5600";
+    }
+    return "24Kf";
+#endif
+}
+
 /* See arch/mips/include/uapi/asm/hwcap.h.  */
 enum {
     HWCAP_MIPS_R6           = (1 << 0),
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "any";
+}
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 3b2dcdfc47..a214675650 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -5,6 +5,15 @@
 #include "loader.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_PPC64
+    return "POWER9";
+#else
+    return "750";
+#endif
+}
+
 /*
  * Feature masks for the Aux Vector Hardware Capabilities (AT_HWCAP).
  * See arch/powerpc/include/asm/cputable.h.
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index 4e2ec3df5b..2e7d622232 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -5,6 +5,11 @@
 #include "loader.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "max";
+}
+
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 29dab42933..79ceaba51d 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -6,6 +6,11 @@
 #include "elf.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "qemu";
+}
+
 #define GET_FEATURE(_feat, _hwcap) \
     do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
 
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 098ca44f80..99ad4f6334 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -5,6 +5,11 @@
 #include "loader.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "sh7785";
+}
+
 enum {
     SH_CPU_HAS_FPU            = 0x0001, /* Hardware FPU support */
     SH_CPU_HAS_P2_FLUSH_BUG   = 0x0002, /* Need to flush the cache in P2 area */
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index b4b8e4916e..ba6e4a38bc 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -6,6 +6,15 @@
 #include "elf.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_SPARC64
+    return "TI UltraSparc II";
+#else
+    return "Fujitsu MB86904";
+#endif
+}
+
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
     /* There are not many sparc32 hwcap bits -- we have all of them. */
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 98acca94ef..befaab7cb0 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -6,6 +6,11 @@
 #include "loader.h"
 
 
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return "max";
+}
+
 abi_ulong get_elf_hwcap(CPUState *cs)
 {
     return cpu_env(cs)->features[FEAT_1_EDX];
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index 73fa78ef14..e35ba69a10 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+    return XTENSA_DEFAULT_CPU_MODEL;
+}
-- 
2.43.0


