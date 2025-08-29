Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1355CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmp-0000yb-6K; Sat, 30 Aug 2025 11:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fX-0005z5-DI
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:03 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fU-0004mp-Kv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso2494489b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506839; x=1757111639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rcp3Y/ahWqBXeCFKyNRSqhcGvHiW+LHciB8CqwGC3iY=;
 b=r7N224AwoyUqDph654N2Ny80eanj3YFxQ1nS3SmDIb8kKXLGl+eJMpMQ0j7tvrLn/l
 hJOsgYKQXSLYco2Yxw2mTo3Yl+iGQEuZcF9vq/V3XoYj2KtQos/dWD6n7pAGsGIHTjCS
 PJcLO6hd38XqonaB0r+TVKBHVYd5QaLdSHdLFg4MBRfMjn2AFkOl1QM40X7riCPYCQrD
 Q+K1LUHOZM2CRpch/tveLAUNF1oYDT9EwFVPnoJQBH3RTNl/oQrMD8EmdMBzHIWH3iE6
 24WxxTP3hWCijtE3JOMM7hj62Z1uEuSQiEm419Pc5gf+DLxdD/aOGSumaqZoU9TwqhOy
 oMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506839; x=1757111639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rcp3Y/ahWqBXeCFKyNRSqhcGvHiW+LHciB8CqwGC3iY=;
 b=Kj8rY2n99Py3VkvSA/Wjs0Q7Dd53ANqXrkFkOJMV3NO9hZbgyYQBDCc8vC7gVRXyrW
 HeozI75Moo9uvjUWampRB0oNdADaZxIpzBVZZtLB1WQ6UGsp5NopebKG/swq4J5X1Wqs
 kyiFvVK4e1L9UmP/eAqVfOSymG1O7KwNW+E0zLFf2GPlDO8yH7JHLSNTga4WEAn4KdvV
 8H1O9AyRcSqkh5vdhlBAwBc6okmA0t58MfhPQETG1+ECI2vG/MVcxAx/9Ot0vklbEisa
 Y5NODa+UbxTgq3H8DiPxcsjfXlnUQ266PqOVIRrzE9MVZfuBc/NJozHlXEnZ7bWmWDDv
 7zGQ==
X-Gm-Message-State: AOJu0Yy9w/m1janEKvooL0SlJ7sUMn/4GxCzfy6ckvHRPjZ8PF5ozC7w
 KMOU+yXVhlcIgYolbo//hjJzMjHYl3MMq32ExTnGUO+90RQvd1o6bmv/PM2M3cFZrlzq/KuDG5G
 D3K1y6cI=
X-Gm-Gg: ASbGncvWoSZWhC8KJnYCuOMhwyEd7IqkZirxl6XIleXCS4qZJJ/SkVXHAzcdQNT6XLa
 9lg+Oy6U7Yz3PP2D4kQ8HbrrDuReqDBiT3QJx97HCeRlLHavUCi/PlIiM3B5e31vOSR4QtEWe8U
 CR7sdgHkYUJLpHk4UML5OmxjtsEciZbegUU9vde0CMIJJp4fqUFQG/8/CR7Wgs8NFvF0wVkZwb7
 R97sqrCrujnPNzbY9sugdXwRpjNebNLjtA2JpDJbFc1uC0VAstkqlmX/4CPSSI+XEYzouYRX5MH
 nsXfQhnO0zplMXyXV7R8FI7X1tySbCff/L47PtZZGn+uvG92IC27VZaRW1K/t9BrbzBwMMJFhnN
 ORtrj+lxuATiCIzxBQVuhG6DQPXF0jz00xP59jRn23UUJlgfOoYesf8nPH+Qx
X-Google-Smtp-Source: AGHT+IGE0EjMBe6TW7mZJDsht+u48sCGBz+zyNQHbdg7d+N0Ae/dOREfsKeBZPVfCydKyDysmdxhnQ==
X-Received: by 2002:a05:6a00:8d4:b0:76e:99fc:db8d with SMTP id
 d2e1a72fcca58-7723e1eee4amr304333b3a.3.1756506838622; 
 Fri, 29 Aug 2025 15:33:58 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:33:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 84/91] linux-user: Standardize on ELF_MACHINE not ELF_ARCH
Date: Sat, 30 Aug 2025 08:24:20 +1000
Message-ID: <20250829222427.289668-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index dc58c0017a..c3caad68b9 100644
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


