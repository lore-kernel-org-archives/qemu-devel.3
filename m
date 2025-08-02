Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865CAC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTB-000433-Rr; Sat, 02 Aug 2025 19:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSk-0003hu-GC
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:27 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSh-0002Yb-A9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:25 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-306e88f0b0aso892592fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176582; x=1754781382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r1zS+vdBf5qqwTnjiIFu+XSyk+iJWSbk/UdFjJJmVo=;
 b=g6PhcDGcJxTiWRkup1p6A6U29zhF/XkbTzbqliQSE50vVxL+StEThqxHWw9LEcNatk
 qUijHXQIBJ/QpoqJ3ObnXT+wnmhDl0UT+MvpZ5CJyVY7r6P92p20TbXB9Ri4UEzuSmdz
 1xG1XO50sYVm9U8pOEa74s26NlWNe6HJJgR4yfHX1zEYHXLZzM69lfK96H0hmhADZ8kH
 QzST7vRzT4g1xnSYgCM2oAVjiccz1055E/xG69Xa4JmLErFzaSF28utMz8FPb+9af9uy
 277kQjhc5F/FXUd919YH2wEwOH1CMzcM8zVwlUU89qEVWBDLdX7RarnLe6ckUpyOmI3X
 YZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176582; x=1754781382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6r1zS+vdBf5qqwTnjiIFu+XSyk+iJWSbk/UdFjJJmVo=;
 b=YdTTzR43MMNRiDCN3eWY5vysNIY9XWp9AyZ9na0N33VzIhS6b0Mpu0Kl5LCBrNDvuC
 DGDvokjcSpiyD8rB1r2mcz71z2U0IpNMOxNgMwmjUkSrVMrv0cHVTWj9c652tnr9HcUL
 R3PsHj+2s+/f3u0O5T4ZTWf2ru4OjNMGOE3Di6rB5QA/Mg19vfY2CN9dp8T4YqpjtpzD
 C6CJnfUWXHVoeX9ZwIu9q5SvoVJA6qDWNbiRlRfmax8z/92Pgc59StScRVyALerr8yau
 WD8a6fiMYRO4QnlPVULym0T5KfCn9iL7x+DNra7N9I8kZa9vf/XtnyI8YOBXwooqTP6u
 qddw==
X-Gm-Message-State: AOJu0YwQYPC6lcrOYjQwtQJ7lE8aE62kNpNVjyq7yIuUNh/wZkn8dHiR
 QTStbfdUV8LcrPVQSlqMIW2FXFV59W+uZWPZefJfMjBf2hy9+oGy78K13aa7CKhhwPpZDqKpZkJ
 KGBTT9cA=
X-Gm-Gg: ASbGnctZTPpnj6Uo0HQXl1qEC1c2fvYMFEb97/9AeDUZPlrH/DQwuUS82CNurUdQvKP
 UFHLbmNzI49bOH5mfuPyLTyfCcOePg88hZJccuW1UEZEwxoHivMopojtM2WoPb5tbXMETfzGaSI
 E86ZsxO32CaHfpFWVdpesd77mqCDUi7l6L7shJ0mCYTcPPmGDkNl6up/Cj6vWhZPz88J0jO1XT+
 MZKKMTE9/llyNDsldDTi7ozTaSdM0phx+y6HScAtP5rknlvVpbY04KOpSbTTcs8CKPGayj6qPnS
 gPRhCJL6oqesvZ5yRhtSy61e+pno7cl9nBt0amXZjXhNkOD3BBF8Vn2HM1hW7H04SHnAtP5Eu5A
 WRsUka+E1bfbO1POoEyYRmRnR6wByeV/8XkHXVw00RjVx5IA9jI1u
X-Google-Smtp-Source: AGHT+IGqIr4thH1cyBx0ulkrhwSrfxwx8omkVegiJTeD0AhqECVr4RWaYi8pdUj05ctST3F4LjcpjQ==
X-Received: by 2002:a05:6870:6989:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-30b676bd72cmr2403037fac.12.1754176582043; 
 Sat, 02 Aug 2025 16:16:22 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 85/95] linux-user: Standardize on ELF_MACHINE not ELF_ARCH
Date: Sun,  3 Aug 2025 09:04:49 +1000
Message-ID: <20250802230459.412251-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
index 9e09bfbf12..5d41bf4ec6 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
 
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
index 4614acb7c0..b3e9604407 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
 
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
index 9acac275b8..bfd0040a79 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -9,7 +9,7 @@
 #define I386_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_386
+#define ELF_MACHINE             EM_386
 #define EXSTACK_DEFAULT         true
 #define VDSO_HEADER             "vdso.c.inc"
 
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index e121e409d7..93e71dbb16 100644
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
index 568b7be389..762f07c47c 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -9,7 +9,7 @@
 #define M68K_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_68K
+#define ELF_MACHINE             EM_68K
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG                20
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 7ce4c10d00..45146ae102 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -9,7 +9,7 @@
 #define MICROBLAZE_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_MICROBLAZE
+#define ELF_MACHINE             EM_MICROBLAZE
 
 #define ELF_NREG                38
 
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 0433de4529..dabf6b1261 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -9,7 +9,7 @@
 #define MIPS_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_MIPS
+#define ELF_MACHINE             EM_MIPS
 #define EXSTACK_DEFAULT         true
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 60ecb4d0ae..e722179af8 100644
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
index 1d3c00c83d..ddeac77efc 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,7 +8,7 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
-#define ELF_ARCH                EM_OPENRISC
+#define ELF_MACHINE             EM_OPENRISC
 #define ELF_CLASS               ELFCLASS32
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 6bfe27fc45..fbcb869a57 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -11,13 +11,11 @@
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
index 3d6317d14f..a46ba42e33 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -9,7 +9,7 @@
 #define S390X_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_S390
+#define ELF_MACHINE             EM_S390
 #define VDSO_HEADER             "vdso.c.inc"
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/sh4/target_elf.h b/linux-user/sh4/target_elf.h
index b305cac5b0..5bd72a9602 100644
--- a/linux-user/sh4/target_elf.h
+++ b/linux-user/sh4/target_elf.h
@@ -9,7 +9,7 @@
 #define SH4_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_SH
+#define ELF_MACHINE             EM_SH
 
 #define HAVE_ELF_HWCAP          1
 
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
index d924314679..c7c2f3b6a1 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -9,7 +9,7 @@
 #define X86_64_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_ARCH                EM_X86_64
+#define ELF_MACHINE             EM_X86_64
 #define VDSO_HEADER             "vdso.c.inc"
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 011a77a1d7..c2ea12cb84 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -9,7 +9,7 @@
 #define XTENSA_TARGET_ELF_H
 
 #define ELF_CLASS               ELFCLASS32
-#define ELF_ARCH                EM_XTENSA
+#define ELF_MACHINE             EM_XTENSA
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG                128
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fdbc55ebc2..3343058865 100644
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


