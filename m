Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47706C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIN-00072Y-Fa; Thu, 28 Aug 2025 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbat-0006kC-6s
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:09 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbar-0000pA-Gw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24622df0d95so6564965ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383544; x=1756988344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoVMQWkfhaQ7L6Kax3GY1GgkjInKIWLCkTwFOcDdNSI=;
 b=IVLtatyMrFDoMi+Da/R4v++B/+sOST3sfDJB9+N6QVyTR9sP5ObIiEdoysxGnY1E52
 xGCILf4eVXq75qcbjBcTM5w/awp3W2FawNlUiir2xDJGQWm/FGEukm25jq7OJGjTPUj0
 qAE430J2L3d0KwkGo1MPWJ3E86egH2Hd/at+GTPLHdgEuqT2UYnB6MBKMTDybUud7aU6
 V0SdoIRxKWXVfyjZS1wMeqEfF5DQRJxKzzfB17widSeJ1xHaU+tb/5V83djus8DnqF+2
 Gv7hZ2g3JOP2Oen/77kvmhm53NPeDc2/e5Be3Kq+nG1iia1G/Kl34v48j6If6T1EPGYc
 E4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383544; x=1756988344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BoVMQWkfhaQ7L6Kax3GY1GgkjInKIWLCkTwFOcDdNSI=;
 b=rOjLsbAt7efDXXTZWv8xyEXN9w73QUJmUmwLysFM8lcs6pE5DpewjtUdtMI/3yWWLA
 QM3BB5eJQ032OXMjNaHFGSw4D5ub689xnNcgjapOoxHj6xPAwMZJiicabQ/RM72+4015
 cTqoLgA6VVAZvEC3aizTQd6WAr0IqADVrLjgd5LIzErZRzNeZMvgxBwSeE8tPSdqNwmj
 4Wdi/+MmQH8tEQ1iDDsmRZLzYFil/LXtFgbHgqLJ4dhwGMDAeqSQ67Zhbw8QsjMKmBUt
 rovidq01KPWcZ/JppXL2+d5NrgdQ9b5cQGrrVm/gKUghlaR/mBDAvI0+WLCU7G2hPWC9
 fHUw==
X-Gm-Message-State: AOJu0Yyadl2xNHxync4Xg8cu7+8CN86bQIBIel9e+u8KNrI8y6XD8Mm2
 RUxPGQ72p3vTP535NdK8QMj1WymslhDeCNumKEk+pGpr8jLNSE4PXUEP5Z2kKh0vVq9KKBaRphM
 HRPWZVf4=
X-Gm-Gg: ASbGncsFosEUENd13TQ1UwF7peeLARz0pct6zq3TqqUkfe5yHLt8Auj5f+E1+FGMzX6
 VDJYqVQFPE6g0uO9P5Boq7RlGDYDbNiV8EKd8Lu8RV7GKReyEdrLNw6MauAHVMKpdqx/sGmQnWl
 35pXqAnnDxiSWZul5d5Q+KZnm87nemHpJC55+yzHdV6ewPPb4Ob3hHuZrg/mhdNRKMPaI4VriHD
 ljm74w2pFk2JQCiENWnZ0OtWQHcxk/m22z4kjJsmghrShp1hpZbeWlQEfbFksJd6f7FjjnLTY3m
 fSG+8IuF+SnPIMsqKLiK1UM3LATosq+M3gm4MoqNef3gfiyYO2pbmCGNcEWso5z07SSFBe4i/uM
 eNxJZRlLbMSlEPjlbiRO2gv4ySgUiEuuyEvBV
X-Google-Smtp-Source: AGHT+IGpSfQR6cNz0bGNy3Qe1mdFU6ZPIL+Qw/uyuJR5DSjeSQWFXm8z1NoUQYn16AI53Z43mCGZjw==
X-Received: by 2002:a17:902:e788:b0:246:80ef:87fc with SMTP id
 d9443c01a7336-24680ef8bc7mr251621355ad.45.1756383543941; 
 Thu, 28 Aug 2025 05:19:03 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 81/87] linux-user: Rename elf_check_arch
Date: Thu, 28 Aug 2025 22:08:30 +1000
Message-ID: <20250828120836.195358-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Rename to elf_check_machine to match ELF_MACHINE.
Remove the unnecessary definition for loongarch64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_elf.h        | 2 +-
 linux-user/loongarch64/target_elf.h | 1 -
 linux-user/microblaze/target_elf.h  | 2 +-
 linux-user/sparc/target_elf.h       | 2 +-
 linux-user/elfload.c                | 6 +++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/i386/target_elf.h b/linux-user/i386/target_elf.h
index bb7571f6cb..33ce82ab2f 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -31,7 +31,7 @@ typedef struct target_elf_gregset_t {
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x)       ((x) == EM_386 || (x) == EM_486)
+#define elf_check_machine(x)    ((x) == EM_386 || (x) == EM_486)
 
 /*
  * i386 is the only target which supplies AT_SYSINFO for the vdso.
diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index b988592993..3aa8c83958 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -11,7 +11,6 @@
 #define ELF_CLASS               ELFCLASS64
 #define ELF_MACHINE             EM_LOONGARCH
 #define EXSTACK_DEFAULT         true
-#define elf_check_arch(x)       ((x) == EM_LOONGARCH)
 #define VDSO_HEADER             "vdso.c.inc"
 
 #define HAVE_ELF_HWCAP          1
diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 1ec91ea5a9..7b3ef70d23 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -13,7 +13,7 @@
 #define ELF_CLASS               ELFCLASS32
 #define ELF_MACHINE             EM_MICROBLAZE
 
-#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+#define elf_check_machine(x) ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 
 #define HAVE_ELF_CORE_DUMP      1
 
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 6b0cac3caf..7827767bcb 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -13,7 +13,7 @@
 # define ELF_MACHINE            EM_SPARC
 #elif defined(TARGET_ABI32)
 # define ELF_CLASS              ELFCLASS32
-# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+# define elf_check_machine(x)   ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
 #else
 # define ELF_CLASS              ELFCLASS64
 # define ELF_MACHINE            EM_SPARCV9
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c481759710..aa0eed6dea 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,8 +130,8 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifndef elf_check_arch
-#define elf_check_arch(x) ((x) == ELF_MACHINE)
+#ifndef elf_check_machine
+#define elf_check_machine(x) ((x) == ELF_MACHINE)
 #endif
 
 #ifndef elf_check_abi
@@ -346,7 +346,7 @@ static bool elf_check_ident(struct elfhdr *ehdr)
    This has to wait until after bswapping the header.  */
 static bool elf_check_ehdr(struct elfhdr *ehdr)
 {
-    return (elf_check_arch(ehdr->e_machine)
+    return (elf_check_machine(ehdr->e_machine)
             && elf_check_abi(ehdr->e_flags)
             && ehdr->e_ehsize == sizeof(struct elfhdr)
             && ehdr->e_phentsize == sizeof(struct elf_phdr)
-- 
2.43.0


