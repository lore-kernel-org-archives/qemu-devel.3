Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32322CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmh-0000TC-Tn; Sat, 30 Aug 2025 11:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fY-000603-Vm
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fX-0004mz-75
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so1833982b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506841; x=1757111641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dFA+iOgaYu1Yp+iyHb7dj9EIpfvh5RMeLLnbPXUmtU=;
 b=pdK+0CVD4Vd8lY7PLZCLhOeAy8jGM/TkMjk6E4po/GOV8AFDMPuyC/3bG3NHCmFAgY
 +qotGSWMpAfiIMlHGe6w78bcWjzknf4tf9+qk3EMedStBH0/Gvkz7Zk7B7bD/0TSuOTw
 hyqEJHR0SzYVXjDgxwaVNWgYB3Ta2VKopJ/eItmgXBP4DIeJZFUyn7XkOombK47N+0jc
 C9UZg1WUMcVoPn47hRVddao9Wwrdp1iJNeo7FMzpn8ihtYy4kNlhcBZjzCZrCCIpZnAx
 NQ8kVZG9UbC6AK9KknnROk5BtCSEi4xGEjZisTl7UH9f5RPffqmklFmg4hvz/+Coho8A
 QtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506841; x=1757111641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dFA+iOgaYu1Yp+iyHb7dj9EIpfvh5RMeLLnbPXUmtU=;
 b=SiDm9gwiPTHQ+oOm0FaFKOLGScQOOigML0ZeH2Hva4pGaXYgsAvQKAuJoC3kH5hn4Y
 mMBu3JhWZ0gXrLO5G6jUabWtqlmbzKvh+l6UVie4FfmYc8DrpZIdQic09U42M+auDCCY
 0AJv8vugyx8CQQscADnxxSg0UX6tCiwi6cIee52n2Zrg+D+lzcOCeVpPDa7rP9hu7XU+
 wqdeQK4xcHnMBpVr3XRPqe4/OBdtRcuKaX0JCZiKMgNnEPSGqpN1EaIQq2/FXpCXPncH
 nO97V4ssuBkH1e+vRKEFce2YG+IQE66I3g+DVcYVoh36ZAjkufDcBGXDNbIo53zC4AA9
 0nsQ==
X-Gm-Message-State: AOJu0Yw1bXYpYiVMA1XcvA4OJVxzWKzGXVDafnKFOXFrMXqgwu2XH6V4
 npX9u0I3YWSnXzDBxLePE1GjdPIvzmgxjqd1FQe4BUyAVuD2H2uwzHPc8NUuKN3Qg6ujwj9RxpB
 SfV6RKvM=
X-Gm-Gg: ASbGncsYDYgJe8FS+kXeUrlfW18G7O68H5mPKUrNNiWe1tLg/2EUu3KZBImnlX9vljr
 VCNPolbrXmcVq3ps0NtlJkbw5mkRP44ELnq0bU797GpTyM9gocU7spJG1tIPJ/2yTgKf2dxYZ5f
 OLuTWOjXmXcXCwlHI+oMXjgM6X7g2HQqvQlUuaf/U9ytWuzIE1e/LX+c2fmairOY48ThInqbRmP
 7s+UtDw0Wi2zB/mokK2k4T/jHTtjKCyibOKu48hi8B+vB+jRHUoLTW3bzuBANK/zadwgJIImCX1
 rkkApeCdLU2D5dC4VyjyFl2LaCu7Z1daH3ceW1hpZEgxnPqHusG+8xlAuMvtuVJlBUDvUS3CBPq
 Q1GpqJPfNuUe9BTjtSjXEdbyNd12o8J6+VLkgjqG19dEG7l/wSw6q/bxbDOqX
X-Google-Smtp-Source: AGHT+IGHwmLrN8Ei8WzENk1GQIFxs6KAS0rOJ+63Vy6tXOQMwBAa/MgwddHf4kvawFD6YuWm1oPfVw==
X-Received: by 2002:aa7:88c8:0:b0:76b:e936:607 with SMTP id
 d2e1a72fcca58-7723e0d3420mr260921b3a.0.1756506841051; 
 Fri, 29 Aug 2025 15:34:01 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 85/91] linux-user: Rename elf_check_arch
Date: Sat, 30 Aug 2025 08:24:21 +1000
Message-ID: <20250829222427.289668-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index c3caad68b9..eafac8f382 100644
--- a/linux-user/i386/target_elf.h
+++ b/linux-user/i386/target_elf.h
@@ -30,7 +30,7 @@ typedef struct target_elf_gregset_t {
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


