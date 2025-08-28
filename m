Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7442ECA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIJ-0006v8-BS; Thu, 28 Aug 2025 13:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbas-0006hj-GF
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbaq-0000oq-7X
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:06 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7720c7cbcabso641698b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383542; x=1756988342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WjM1vxXQ4hTMsgbOuNurVqo634njinTp8OegjizR4w=;
 b=EQY0nfI1EmoGhbMEOk7NfexAluoSLDtXAdA95YU5VJrk9WF3bhaZkqWXkY0zsFxtYN
 2N781zAL6zdKb8buVjjgbUP3FJ/ohLxjcfEHcntht9d5m5HogA2SkMHP6f3cHutixcB6
 vQK9+1wNeYSnbT4DiCeIGlNI6yE1Opn0VrsrTu7vMa+2N2cDBSag36+XygsMQSlxNz5V
 AyHPqSwmXYXO0xy/LXfk6DEmDV5eQHIUic54r3t9UVjrSP/s8ch5eYjmf9MBEIU92Tlr
 Nz6Z/XurAg5bJi9LmvMEGLGI/e0DIXw1VnIiQT6eptXb8/7lnjNKf039bLXmSIyEJCvV
 KcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383542; x=1756988342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WjM1vxXQ4hTMsgbOuNurVqo634njinTp8OegjizR4w=;
 b=pfOjUFTZFqDBYVjx9kvsuESSRhYA5C6XBagYbObhY7BMwhKxC7O1WWX6VgCF91CYZ4
 mx+1hXy8QknR7nxkkTtpuetpT4oanMv2+Dq05gZsulaAAEX9OBw7IkPKqrNu0Z7kb9hR
 Y4zFDSmycFQ3ZdhpZ6FbAvntJQYB8N2hfxICmVkt4K0FGhP0GGgIL+/Cie+Av7/avemh
 C/Mn+SkhpoMSXzg9xMIgp4uux+E+MoTEcZBwOloMPO5720cd57YzVengTErBAbUDflG+
 bBEGW896hSpVuyg0ymQ76GUQ6Z+XOn2TuptcFDl5JYd0+fz7LTis0RA7A8nVXYzEhJBs
 B8mg==
X-Gm-Message-State: AOJu0YyaZCRYVv76+y0gbrwIgtO+PhQamFjHAz0+Ghsd/NY1G5FLhdT3
 C9Y4Vcgbp7a0s8Y2UF37n0z6BTWncnQafRJuUWDPa+5hjR9FNpDWMvqqRPwZLSJjwQel/TvQvsH
 JR6h4Ibs=
X-Gm-Gg: ASbGnct+lAQ/EHjzGI8iagsDuNEQsCkkcNp8UkwYiwaH7D34AaX/JNrYpmJLYSIeBRu
 FDGMe9HrQusm9TVnAwTyIawrDDMiAzONp3tJqV5OuLAtxp7TzaN8Domlwm44HhfrUXGd/CCWSYo
 RK9AOEAygwKF9WkDfa2dbZEzuGapQjk1WaFyve7DW5EXeQc4TAi28QF0Nj95JIWI6ODoN8lRLXq
 4Wp/YxBDVoUQ8Iauzb83WodvRz/RmgYrl3P+fGM57z2/kn4KV1KGPWY+DRoRWE3zj4sGPfrjQNj
 zdYyT9XLXjmB6qMMU3HCe49DEipsUltsX1o3FY8LvMx/5SvqovzDuBy8ywYk6sVOO4OWOtJ3e8u
 jJp1cPPDa7nSXj+ZYiquNYJEl7pZ5cdO2spJm
X-Google-Smtp-Source: AGHT+IGi3KS5OKPIC7SbPuHNqhAHqzheEs3zHfNBhBd9v3mUOFl2H+dqWv3Bsmk03GgLl+iu5nuNSg==
X-Received: by 2002:a17:903:94e:b0:246:ae6e:e5db with SMTP id
 d9443c01a7336-246ae6ee847mr220964005ad.42.1756383541654; 
 Thu, 28 Aug 2025 05:19:01 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 80/87] linux-user: Standardize on ELF_MACHINE not ELF_ARCH
Date: Thu, 28 Aug 2025 22:08:29 +1000
Message-ID: <20250828120836.195358-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

PowerPC was the one outlier that defined both ELF_ARCH and
ELF_MACHINE; ELF_ARCH was defined incorrectly, necessitating
the definition of elf_check_arch.

However, the elf file header field in question is called
e_machine, so ELF_MACHINE is in fact the better name.

Mechanically change most target/target_elf.h files,
then adjust ppc/target_elf.h manually.

Do not provide a default for ELF_MACHINE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h     | 2 +-
 linux-user/alpha/target_elf.h       | 2 +-
 linux-user/arm/target_elf.h         | 2 +-
 linux-user/hexagon/target_elf.h     | 2 +-
 linux-user/hppa/target_elf.h        | 2 +-
 linux-user/i386/target_elf.h        | 2 +-
 linux-user/loongarch64/target_elf.h | 2 +-
 linux-user/m68k/target_elf.h        | 2 +-
 linux-user/microblaze/target_elf.h  | 2 +-
 linux-user/mips/target_elf.h        | 2 +-
 linux-user/mips64/target_elf.h      | 2 +-
 linux-user/openrisc/target_elf.h    | 2 +-
 linux-user/ppc/target_elf.h         | 2 --
 linux-user/riscv/target_elf.h       | 2 +-
 linux-user/s390x/target_elf.h       | 2 +-
 linux-user/sh4/target_elf.h         | 2 +-
 linux-user/sparc/target_elf.h       | 4 ++--
 linux-user/x86_64/target_elf.h      | 2 +-
 linux-user/xtensa/target_elf.h      | 2 +-
 linux-user/elfload.c                | 6 +-----
 20 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 3c9fef9378..9ec51f6237 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -10,7 +10,7 @@
 
 #include "target_ptrace.h"
 
-#define ELF_ARCH                EM_AARCH64
+#define ELF_MACHINE             EM_AARCH64
 #define ELF_CLASS               ELFCLASS64
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index f9d6372c9f..864dc6e2e6 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -9,6 +9,6 @@
 #define ALPHA_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_ALPHA
+#define ELF_MACHINE             EM_ALPHA
 
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index d871d6d665..12cdc8e5a7 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -10,7 +10,7 @@
 
 #include "target_ptrace.h"
 
-#define ELF_ARCH                EM_ARM
+#define ELF_MACHINE             EM_ARM
 #define ELF_CLASS               ELFCLASS32
 #define EXSTACK_DEFAULT         true
 
diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index a9f6d77fc6..f81ae3895a 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -19,6 +19,6 @@
 #define HEXAGON_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_HEXAGON
+#define ELF_MACHINE             EM_HEXAGON
 
 #endif
diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 9b6363a0a7..76930c9369 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -9,7 +9,7 @@
 #define HPPA_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_PARISC
+#define ELF_MACHINE             EM_PARISC
 
 #define HAVE_ELF_PLATFORM       1
 
diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 99a95ee45b..bb7571f6cb 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_386
+#define ELF_MACHINE             EM_386
 #define EXSTACK_DEFAULT         true
 #define VDSO_HEADER             "vdso.c.inc"
 
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index 47bf51a41c..b988592993 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -9,7 +9,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_LOONGARCH
+#define ELF_MACHINE             EM_LOONGARCH
 #define EXSTACK_DEFAULT         true
 #define elf_check_arch(x)       ((x) == EM_LOONGARCH)
 #define VDSO_HEADER             "vdso.c.inc"
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 073c85becc..b997fa0b6d 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -9,7 +9,7 @@
 #define M68K_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_68K
+#define ELF_MACHINE             EM_68K
 
 #define HAVE_ELF_CORE_DUMP      1
 
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index a622cd8e43..1ec91ea5a9 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_MICROBLAZE
+#define ELF_MACHINE             EM_MICROBLAZE
 
 #define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index f400bc2fdb..157306f7a0 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_MIPS
+#define ELF_MACHINE             EM_MIPS
 #define EXSTACK_DEFAULT         true
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index c455985a76..061471a0f1 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_MIPS
+#define ELF_MACHINE             EM_MIPS
 #define EXSTACK_DEFAULT         true
 
 #ifdef TARGET_ABI_MIPSN32
diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index ed9739380f..e8554f5339 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -10,7 +10,7 @@
 
 #include "target_ptrace.h"
 
-#define ELF_ARCH                EM_OPENRISC
+#define ELF_MACHINE             EM_OPENRISC
 #define ELF_CLASS               ELFCLASS32
 
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 9a47f18fb8..22854cf52f 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -13,13 +13,11 @@
 #define ELF_MACHINE             PPC_ELF_MACHINE
 
 #ifdef TARGET_PPC64
-# define elf_check_arch(x)      ((x) == EM_PPC64)
 # define ELF_CLASS              ELFCLASS64
 #else
 # define ELF_CLASS              ELFCLASS32
 # define EXSTACK_DEFAULT        true
 #endif
-#define ELF_ARCH                EM_PPC
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 51b8def1d1..dbbfdf54d3 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
 
-#define ELF_ARCH                EM_RISCV
+#define ELF_MACHINE             EM_RISCV
 
 #ifdef TARGET_RISCV32
 #define ELF_CLASS               ELFCLASS32
diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index b23e46ab46..ef5edbd860 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_S390
+#define ELF_MACHINE             EM_S390
 #define VDSO_HEADER             "vdso.c.inc"
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index 61aea237c4..d9e253d425 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_SH
+#define ELF_MACHINE             EM_SH
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index f89c708c46..6b0cac3caf 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -10,13 +10,13 @@
 
 #ifndef TARGET_SPARC64
 # define ELF_CLASS              ELFCLASS32
-# define ELF_ARCH               EM_SPARC
+# define ELF_MACHINE            EM_SPARC
 #elif defined(TARGET_ABI32)
 # define ELF_CLASS              ELFCLASS32
 # define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
 # define ELF_CLASS              ELFCLASS64
-# define ELF_ARCH               EM_SPARCV9
+# define ELF_MACHINE            EM_SPARCV9
 #endif
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index f3c09bb8da..840bddf5ec 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_X86_64
+#define ELF_MACHINE             EM_X86_64
 #define VDSO_HEADER             "vdso.c.inc"
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 0689e79be5..1bf8f2a14a 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -11,7 +11,7 @@
 #include "target_ptrace.h"
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_XTENSA
+#define ELF_MACHINE             EM_XTENSA
 
 #define HAVE_ELF_CORE_DUMP      1
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 33c4214c95..c481759710 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,12 +130,8 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifndef ELF_MACHINE
-#define ELF_MACHINE ELF_ARCH
-#endif
-
 #ifndef elf_check_arch
-#define elf_check_arch(x) ((x) == ELF_ARCH)
+#define elf_check_arch(x) ((x) == ELF_MACHINE)
 #endif
 
 #ifndef elf_check_abi
-- 
2.43.0


