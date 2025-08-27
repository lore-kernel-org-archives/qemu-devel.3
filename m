Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9701ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRj-0001Xu-0k; Wed, 27 Aug 2025 19:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRg-0001WH-Ss
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRd-00048G-P6
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so418533b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336844; x=1756941644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoPWka5IGjXwmhHjvxnZ9KVWvPEaQtzh37FeYd1Lbz4=;
 b=KruK0YPb2Idd7X64GTsEMV+HokaTvyBsMPdfqpIffapZZ9ssvHPIdnR/tpvxvr5FUM
 pYjpkedaF18mLBNGFnEjcrvIfRZtCAKMMIt9LH3R2+OKCyIMI/Drv4cT588x1CG6tSIf
 qF/Yq0rm6fw7PWxseDQqxc1n49OLraHi3xwz9uK52AGMZP9DvRfQASOiuDTXqlB6BbzI
 HLZIYX3IVP+xyrvHWpQTXLBpgJ0CHQrT1JPkv5yGm852WobzOT3yAXfjuXolw5I0xJSh
 Hs7H3qeguqf4vX2s5ByhyQKvedoEABuPzfz7blh60a9pvzx3x1gXuMc5Z96pRmzUzoat
 6fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336844; x=1756941644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoPWka5IGjXwmhHjvxnZ9KVWvPEaQtzh37FeYd1Lbz4=;
 b=W+/36eajrgjNZptKHi6btV+xoLyQpp3JcII4shnEqfkaXAcjWDhzvE1dPdSrF07Y6j
 70x7k7PgPsphwDxU3RdX+nNzo1QhYqsb03ems8A0ZDtQhQursTNPr/QwDDr/rySaoRHB
 qS+01h4yruLSnY7Xlofp9dZFF5vH2/4+CPYIULtPJYktWmyTWd/Wo37bS2xFe7yM6h9c
 /ezt7udlfofUVu709kZgniYJPjjwF88YKzOwu8o4vANdMLYHK7DxsjvDzHxXJx5rpgmC
 H/dzwD6C5nZMJ02DiP1ggWsky55Oe06dUvfKCPtq0q+DG/ca2BB6WnhRexAVlC5ocCgj
 5jJg==
X-Gm-Message-State: AOJu0Yw8csQVFlfl4bCaxejuLQ8jeKw2VrFPgDQC6kn5zg4Dy8lXFzMm
 JK9bHrz4fgUljFnZdfGOSlol4yUSafzUh5VtnfVK7jT0LR9CrIJZTF3U9sUiJGU6PacZhRyLFmt
 GNtccAio=
X-Gm-Gg: ASbGnctXGjvVcI+CplQAv6qsZuqrYM9Mty9HG/zK/K5LOHSqfECUIm6JYNm1Q074kMD
 7XncBadJldMyF21MY/zuHjbvAQ6kW8j0WTRtXWQhQFgbi7CRazS4SRpApqlQxMCv6swqYjqBbv9
 4ytTezKPyZlA37u14n6XPRJ6+HuHX95/m4DiqdQnM7+qkKoUGUWTrJ0ZWci5JGCZYcfeCssauX5
 fypr7YWNFcuu1QZdCeb1z0n4VtIunQ3V/B3YBZ3kYIGgifb2scLBVm2rshanQPT3R+KKA9mnSij
 cCmjFZ+ak6GVKJ7FoYZDvdkHwE7xqLPw+S+o/QVNZqW44UP8wizTSnKCR1UrhIMq+HoOZgqg7Fl
 cMVDbOuOMnBX6UEhM+/paEzL8AA==
X-Google-Smtp-Source: AGHT+IHnsmy2kCAy/d2dMjQpqMy7BAkvYWdedIcJRhVTDW3i57VZ41yqLH02RQqNkhot+cbey6Y68A==
X-Received: by 2002:a05:6a00:3495:b0:771:fcd7:ad0 with SMTP id
 d2e1a72fcca58-771fcd710b9mr9067965b3a.22.1756336843538; 
 Wed, 27 Aug 2025 16:20:43 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/46] linux-user: Move get_elf_cpu_model to target/elfload.c
Date: Thu, 28 Aug 2025 09:19:42 +1000
Message-ID: <20250827232023.50398-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
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

Rename from cpu_get_model to emphasize that this is an elf-specific
function.  Declare the function once in loader.h.

This frees up target_elf.h for other uses.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h     |  5 +---
 linux-user/alpha/target_elf.h       |  5 +---
 linux-user/arm/target_elf.h         |  5 +---
 linux-user/hexagon/target_elf.h     | 29 -------------------
 linux-user/hppa/target_elf.h        |  5 +---
 linux-user/i386/target_elf.h        |  5 +---
 linux-user/loader.h                 |  3 ++
 linux-user/loongarch64/target_elf.h |  5 +---
 linux-user/m68k/target_elf.h        |  9 ------
 linux-user/microblaze/target_elf.h  |  5 +---
 linux-user/mips/target_elf.h        | 11 +-------
 linux-user/mips64/target_elf.h      | 27 +-----------------
 linux-user/openrisc/target_elf.h    |  5 +---
 linux-user/ppc/target_elf.h         |  9 +-----
 linux-user/riscv/target_elf.h       |  5 +---
 linux-user/s390x/target_elf.h       |  5 +---
 linux-user/sh4/target_elf.h         |  5 +---
 linux-user/sparc/target_elf.h       |  9 +-----
 linux-user/x86_64/target_elf.h      |  5 +---
 linux-user/xtensa/target_elf.h      |  5 ----
 linux-user/aarch64/elfload.c        | 10 +++++++
 linux-user/alpha/elfload.c          | 10 +++++++
 linux-user/arm/elfload.c            | 10 +++++++
 linux-user/hexagon/elfload.c        | 34 +++++++++++++++++++++++
 linux-user/hppa/elfload.c           | 10 +++++++
 linux-user/i386/elfload.c           | 10 +++++++
 linux-user/loongarch64/elfload.c    | 10 +++++++
 linux-user/m68k/elfload.c           | 17 ++++++++++++
 linux-user/main.c                   |  3 +-
 linux-user/microblaze/elfload.c     | 10 +++++++
 linux-user/mips/elfload.c           | 43 +++++++++++++++++++++++++++++
 linux-user/openrisc/elfload.c       | 10 +++++++
 linux-user/ppc/elfload.c            | 14 ++++++++++
 linux-user/riscv/elfload.c          | 10 +++++++
 linux-user/s390x/elfload.c          | 10 +++++++
 linux-user/sh4/elfload.c            | 10 +++++++
 linux-user/sparc/elfload.c          | 14 ++++++++++
 linux-user/x86_64/elfload.c         | 10 +++++++
 linux-user/xtensa/elfload.c         | 10 +++++++
 39 files changed, 272 insertions(+), 145 deletions(-)

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
index 58ff6a0986..2abb27a733 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
+
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
index 19cae8bd65..5826ca2cd2 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -7,8 +7,5 @@
 
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "hppa";
-}
+
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
index e102e6f410..75ee9975a0 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -98,6 +98,9 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
+/* Note that Elf32 and Elf64 use uint32_t for e_flags. */
+const char *get_elf_cpu_model(uint32_t eflags);
+
 #if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
 uint32_t get_elf_hwcap(void);
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
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
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
index 73fa78ef14..b92442dfeb 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
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
index 73fa78ef14..2274fcbde4 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
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
+    return "hppa";
+}
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index 73fa78ef14..f92adb7308 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
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
+    return "max";
+}
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 73fa78ef14..874dc4c230 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
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
+    return "la464";
+}
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
index 68972f00a1..ad1a29d198 100644
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
@@ -809,7 +808,7 @@ int main(int argc, char **argv, char **envp)
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
index 73fa78ef14..04e3b76740 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -1 +1,44 @@
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
index 73fa78ef14..7775dc06fa 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -1 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_PPC64
+    return "POWER9";
+#else
+    return "750";
+#endif
+}
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index 73fa78ef14..f92adb7308 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
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
+    return "max";
+}
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 73fa78ef14..989953a247 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
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
+    return "qemu";
+}
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 73fa78ef14..546034ec07 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
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
+    return "sh7785";
+}
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 73fa78ef14..243e6f9b66 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -1 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_cpu_model(uint32_t eflags)
+{
+#ifdef TARGET_SPARC64
+    return "TI UltraSparc II";
+#else
+    return "Fujitsu MB86904";
+#endif
+}
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 73fa78ef14..f92adb7308 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
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
+    return "max";
+}
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


