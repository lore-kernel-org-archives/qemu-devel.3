Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0697C87FCE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguaG-0001oC-9s; Tue, 29 Jul 2025 20:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJd-00056s-I0
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:05:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJb-0004kE-CX
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:05:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so319010b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833902; x=1754438702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TNcO9hPdoq7RaFvEUV80wvvmqUSlcX+cteAzXkSonr0=;
 b=HmSRZgAxvEHmDZ5q45/v9GKrPRqokyfGCeGvLo35sc8r7oBWSE64VJgt2sAgAfNHsw
 M2mk+oPZLtHbUlabOEsdLRdrrwoVa1bGOGvv6bnn+Y6QmGAgPZPAwfNAMyINx21Cqx2Y
 eVs8L1vDBga0VbMjQg0iraciXcbQLbtzIq7ZRAuPw5BsZbQw2PBfXKEHBDKg89l/BHxd
 feH1npoqAaQfnJLfk5ybWepfmvH8FDLRzGmhPOfJbkKtfw04XLPsQSquepYRukqJUjtK
 XdkM7SS5OWu/7HwIGk4hmyVgwDvsCDVO4RSVyu9A57bqsUpd65e7ISZTvNfJj3BSIdWZ
 LWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833902; x=1754438702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNcO9hPdoq7RaFvEUV80wvvmqUSlcX+cteAzXkSonr0=;
 b=nppbyD0wxoPta3eRIfyz/YAyDeHXQm/8VP5v0M+aUl+PTS4FijfJHmGozn/CwCbIkq
 jAm+oh9HU8+F4WPy92lqUd7Fo/FUpuG67BF7DtB6x84ody7lCm3dSbmFssnMYb/1BCeW
 mvUBZIhRwvWb1IenqoBYvp6v5OdLESufsZAuE3GCh3xisyY+mPPqzpbBCHmEur7+x0sJ
 vI6d69Sn1sfs6tRzXrhkDj+MHRU5o20479ZNy1b0lW0smxNj5SI+ze9e4PK8TVCnZnN0
 9bqiDIRi00VG8OvIG2daNiZhQ+Ce/CWItTllGsxengYrrckRxiox9GodmSWvd1CH8Vat
 L5DA==
X-Gm-Message-State: AOJu0YwWzlNxacvkYERI03tqnbhmbxuUa5HbFe0TAqE9SNVfHVOTf41l
 Rst9efMOW8DL5WwvNuosqf2kqlL8l0UJwZT16kCg2nZ1ZTw0GfCqowuCprnb6W0GcuzjODSLCqe
 8NeQ7
X-Gm-Gg: ASbGncsD7uGywvysVjlaWDI3fqT+ELyERdUpygSd+PNDXKn7Tzm4zxFRkAtrlsSPfdA
 2XH2FCkwIPWqpQHo4GZhoX5JENt2qMSDMBkvWtlWZKTLRSlGpwoYSwSVaFCCaOleHpbJ05QaIiz
 YKke1z60IBe3aZYuMRQimcc8CEbV8JoZNZfbP8wgJkr5a6zpeTEnYQmtgnPz/JTUlnfNQmI9My3
 SmS5ZqXEY60BXTcj5Ph63gOdVuw370un0AhaWk9kDCg6RSuocuSEnm1FbPrj7NZdxc0HlMVw1RO
 zkd1LlIZCaHih8mwoKhlBLzt5wBfMUdh2eIiWm2LylBszmmUMPmbnW1UGjE78rg4HPhfQ41cLxB
 u0QnLGm5s2871UzSAml/Bp8naELYv4sKvEKVsCRyY/CXrYQrXv2LdJ/EsvFwcvwaoKqvpqZ7BhP
 HY7/Pp7LD2kA==
X-Google-Smtp-Source: AGHT+IHcTdv0aQ0XCS6XkQRjvNCNvXOuyKbJha7hxss/pFLAOAkgmsijQn16MN6L/pXVDt5LxG4a1w==
X-Received: by 2002:a05:6a00:6d58:20b0:748:f1ba:9af8 with SMTP id
 d2e1a72fcca58-76ab2d56a7dmr1551727b3a.21.1753833896635; 
 Tue, 29 Jul 2025 17:04:56 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 79/89] linux-user: Standardize on ELF_MACHINE not ELF_ARCH
Date: Tue, 29 Jul 2025 13:59:52 -1000
Message-ID: <20250730000003.599084-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

PowerPC was the one outlier that defined both ELF_ARCH and
ELF_MACHINE; ELF_ARCH was defined incorrectly, necessitating
the definition of elf_check_arch.

However, the elf file header field in question is called
e_machine, so ELF_MACHINE is in fact the better name.

Mechanically change most target/target_elf.h files,
then adjust ppc/target_elf.h manually.

Do not provide a default for ELF_MACHINE.

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
 linux-user/ppc/target_elf.h         | 5 +----
 linux-user/riscv/target_elf.h       | 2 +-
 linux-user/s390x/target_elf.h       | 2 +-
 linux-user/sh4/target_elf.h         | 2 +-
 linux-user/sparc/target_elf.h       | 4 ++--
 linux-user/x86_64/target_elf.h      | 2 +-
 linux-user/xtensa/target_elf.h      | 2 +-
 linux-user/elfload.c                | 6 +-----
 20 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 8f704055ec..16acf6d47f 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
 
-#define ELF_ARCH                EM_AARCH64
+#define ELF_MACHINE             EM_AARCH64
 #define ELF_CLASS               ELFCLASS64
 #define USE_ELF_CORE_DUMP
 
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
index 2f8564a484..f769108adb 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
 
-#define ELF_ARCH                EM_ARM
+#define ELF_MACHINE             EM_ARM
 #define ELF_CLASS               ELFCLASS32
 #define EXSTACK_DEFAULT         true
 #define USE_ELF_CORE_DUMP
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
index ed2ce895f5..c2484230b0 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -9,7 +9,7 @@
 #define HPPA_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_PARISC
+#define ELF_MACHINE             EM_PARISC
 #define STACK_GROWS_DOWN        0
 #define STACK_ALIGNMENT         64
 #define VDSO_HEADER             "vdso.c.inc"
diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index 032abe5d24..f5eeb36b31 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -9,7 +9,7 @@
 #define I386_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_386
+#define ELF_MACHINE             EM_386
 #define EXSTACK_DEFAULT         true
 #define VDSO_HEADER             "vdso.c.inc"
 #define USE_ELF_CORE_DUMP
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index e99aa3df4c..a76aa9f56c 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -7,7 +7,7 @@
 #define LOONGARCH_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_LOONGARCH
+#define ELF_MACHINE             EM_LOONGARCH
 #define EXSTACK_DEFAULT         true
 #define elf_check_arch(x)       ((x) == EM_LOONGARCH)
 #define VDSO_HEADER             "vdso.c.inc"
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index baabc1c040..77533a9086 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -9,7 +9,7 @@
 #define M68K_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_68K
+#define ELF_MACHINE             EM_68K
 #define USE_ELF_CORE_DUMP
 
 #endif
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 738a101f67..037ff595b6 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -9,7 +9,7 @@
 #define MICROBLAZE_TARGET_ELF_H
 
 #define ELF_CLASS           ELFCLASS32
-#define ELF_ARCH            EM_MICROBLAZE
+#define ELF_MACHINE         EM_MICROBLAZE
 #define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 #define USE_ELF_CORE_DUMP
 
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 850a6d83cc..06a88fe254 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -9,7 +9,7 @@
 #define MIPS_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_MIPS
+#define ELF_MACHINE             EM_MIPS
 #define EXSTACK_DEFAULT         true
 #define USE_ELF_CORE_DUMP
 
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 77f3b4685a..c0c7f3e97c 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,7 +9,7 @@
 #define MIPS64_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_MIPS
+#define ELF_MACHINE             EM_MIPS
 #define EXSTACK_DEFAULT         true
 
 #ifdef TARGET_ABI_MIPSN32
diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index 0a2b3ef762..d7a85cc0d0 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
-#define ELF_ARCH                EM_OPENRISC
+#define ELF_MACHINE             EM_OPENRISC
 #define ELF_CLASS               ELFCLASS32
 #define USE_ELF_CORE_DUMP
 
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index d42b9dc9cb..c4cc40a4aa 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -8,16 +8,13 @@
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 
-#define ELF_MACHINE             PPC_ELF_MACHINE
-
 #ifdef TARGET_PPC64
-# define elf_check_arch(x)      ((x) == EM_PPC64)
 # define ELF_CLASS              ELFCLASS64
 #else
 # define ELF_CLASS              ELFCLASS32
 # define EXSTACK_DEFAULT        true
 #endif
-#define ELF_ARCH                EM_PPC
+#define ELF_MACHINE             PPC_ELF_MACHINE
 
 /*
  * The requirements here are:
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 61446dd945..ce8df23cd7 100644
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
index aa12ecf36b..a7c6e33300 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -10,7 +10,7 @@
 
 #define ELF_CLASS               ELFCLASS64
 #define ELF_DATA                ELFDATA2MSB
-#define ELF_ARCH                EM_S390
+#define ELF_MACHINE             EM_S390
 #define VDSO_HEADER             "vdso.c.inc"
 #define USE_ELF_CORE_DUMP
 
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index 68b58beaa4..053ea53aa8 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -9,7 +9,7 @@
 #define SH4_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_SH
+#define ELF_MACHINE             EM_SH
 #define USE_ELF_CORE_DUMP
 
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 8bd6e3e427..8071638e18 100644
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
 
 #endif
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 7eac11e338..13035a7a5b 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -9,7 +9,7 @@
 #define X86_64_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_X86_64
+#define ELF_MACHINE             EM_X86_64
 #define VDSO_HEADER             "vdso.c.inc"
 #define USE_ELF_CORE_DUMP
 
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index cacfb6e81a..d8ecce6a96 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -9,7 +9,7 @@
 #define XTENSA_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_XTENSA
+#define ELF_MACHINE             EM_XTENSA
 #define USE_ELF_CORE_DUMP
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 25a3d5c9cb..41f022569b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,12 +138,8 @@ typedef abi_uint        target_gid_t;
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


