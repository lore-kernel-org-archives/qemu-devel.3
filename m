Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6542BC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugubu-00067L-MU; Tue, 29 Jul 2025 20:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIl-0004MA-1o
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIh-0004a4-TF
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so434987b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833846; x=1754438646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MV6Ro9mWnxqsPjREdWaA08BESU+z4GHTfrZvTcc6ukI=;
 b=UQSQBbXtgHbQXKsDrSizutMEXsaMTjARhHtrVU7gpNN4kr7mXcn7Dl7o2mshfNdgaq
 CYsfrRstWtwYYrsu35gUBdtWPqwnpwddhSika5YMpRrsnAG7h3NfDIBWIFqVQfeF3HGO
 U8K4RwVs9WITV1wUpcZHX/6HhKTQzLT4NhVgpFUhigAHcWS2FfsyW5w/SRk6knFac2ww
 fd3f1lAGBx3BjzZDTFyAeK6h4oWIvWREGQhqs9x3MBzS55bHwPxUAIOlU+TjkCATFP4J
 daa79fEe1XhDdQ137B4kycX0L+vW8IMcyfxugm8/01JaPGnjTemVk/h1TvcQ2v+/ompS
 hWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833846; x=1754438646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MV6Ro9mWnxqsPjREdWaA08BESU+z4GHTfrZvTcc6ukI=;
 b=A3tSNCNcRcfAJkBb08Ep7qPIBEdNR0RLWYzWpiPc+kV3FUmApOHoP3ZtMw9rTjjeQ1
 HYBnryvTBGuaVL7mazCTarAAVeZvIB9R/fLPOhB+cGdPJQ/qnI2yzptUDXBRi0QVA15k
 9wTkKaV6Ff1zaULJmJENcIE6zhFyHIUwA1SO9u97I3mrLSItv6STyOcN9mgKj+mx1Yqr
 8t5ooUUqFdvum2bkbQNA5rXqNNV18Zpow4xlXt6kXgUevQSN+UgWNGoXrJnhis1B6X2L
 TScrie15mmhj4WOkDRiTuL9J3DuzMxUSzCCS3125+USEyDAV5k2agF/8UXhZOcHpy0Hs
 lDPw==
X-Gm-Message-State: AOJu0YyCbXezYZrcCcMz0C0JKuyP2T6mXUIqadQkXAo2ZPEq/4bRSiVB
 /QBTb0+t9q0YV2QAEyT9DbOfPeWUZkhzjlaMglLU+FYF5nnePnAbWopkg3okkXQRuCpR86x+lqS
 IVIv7
X-Gm-Gg: ASbGncubZVs2VPL9f+Md+PiaqBXI5wSv3aSIyDm0ASotLcOD7+RnADOQYhjopFve8Ux
 DfB+5fA/0Axw/2yulXbg4Rp638lHuIKQblJLNG/sHxlyNMIJ02VUhgKIHn66/W50VFhp5hk/WmK
 yVl3n0RC5++yO3hEVADj6STmI59CRbgUgAb/B/mYcuMy8mjjuabpBuQcXKwBlwz2TjgNQSmfClS
 9kJnA94laEKMvujEAkI6Mmu56pw3deSdNQSED6oABRdahv12GFTkWpAhiJRPqJpTQ6i4f3uVZy2
 +xHon2PRPt16MAluHi19W93Y/JHv40KDKCfHm39e6+V91LCTYr1NPEInwaZe3pIlCYRQKsAPSOs
 Z4f4HAgApmjarz/t+99TYX7ZWejRLdlyIUinQuNlNrRGhZkWuQcwnM26DbtQ8jy7d+qnSKmnnnk
 rIZbm+IgeKaA==
X-Google-Smtp-Source: AGHT+IEM5/IN+jBJAMZuZcticFfJG0J5bMtQ0ePurMPet/8gjbdmKjAqATohEnZQhOMotFyYCXOJOA==
X-Received: by 2002:a05:6a00:3283:b0:76b:2834:8c5c with SMTP id
 d2e1a72fcca58-76b28348e14mr97759b3a.6.1753833846139; 
 Tue, 29 Jul 2025 17:04:06 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/89] linux-user: Remove do_init_main_thread
Date: Tue, 29 Jul 2025 13:59:13 -1000
Message-ID: <20250730000003.599084-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

All targets have been converted, so we can call init_main_thread
directly.  Remove do_init_main_thread and HAVE_INIT_MAIN_THREAD.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h  |  1 -
 linux-user/qemu.h    |  2 --
 linux-user/elfload.c | 46 --------------------------------------------
 linux-user/main.c    |  2 +-
 4 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index b7dceb4abe..700bbdb02e 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -82,7 +82,6 @@ struct linux_binprm {
     int (*core_dump)(int, const CPUArchState *); /* coredump routine */
 };
 
-void do_init_main_thread(CPUState *cs, struct image_info *infop);
 abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
                               abi_ulong stringp, int push_ptr);
 int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 475b11e4c4..4c626f270c 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -365,8 +365,6 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
-typedef struct target_pt_regs target_pt_regs;
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
 void init_main_thread(CPUState *cs, struct image_info *info);
 
 #endif /* QEMU_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1276b57f0d..27682f0c81 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -155,8 +155,6 @@ typedef abi_int         target_pid_t;
 
 #ifdef TARGET_I386
 
-#define HAVE_INIT_MAIN_THREAD
-
 #ifdef TARGET_X86_64
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
@@ -299,8 +297,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_NREG    18
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -401,8 +397,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_NREG    34
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
 
@@ -444,8 +438,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#define HAVE_INIT_MAIN_THREAD
-
 #endif /* TARGET_SPARC */
 
 #ifdef TARGET_PPC
@@ -491,8 +483,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -539,8 +529,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -587,8 +575,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -646,8 +632,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define ELF_CLASS   ELFCLASS32
 #define ELF_ARCH    EM_MICROBLAZE
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_EXEC_PAGESIZE        4096
 
 #define USE_ELF_CORE_DUMP
@@ -679,8 +663,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
@@ -707,8 +689,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -752,8 +732,6 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -792,8 +770,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_ALPHA
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_EXEC_PAGESIZE        8192
 
 #endif /* TARGET_ALPHA */
@@ -804,8 +780,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -855,8 +829,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define ELF_EXEC_PAGESIZE 4096
 
 #endif /* TARGET_RISCV */
@@ -870,8 +842,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define HAVE_INIT_MAIN_THREAD
-
 #define LO_COMMPAGE  0
 
 static bool init_guest_commpage(void)
@@ -911,8 +881,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_XTENSA
 
-#define HAVE_INIT_MAIN_THREAD
-
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
 typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
@@ -960,8 +928,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
-#define HAVE_INIT_MAIN_THREAD
-
 #endif /* TARGET_HEXAGON */
 
 #ifndef ELF_MACHINE
@@ -3454,15 +3420,3 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     return ret;
 }
 #endif /* USE_ELF_CORE_DUMP */
-
-void do_init_main_thread(CPUState *cs, struct image_info *infop)
-{
-#ifdef HAVE_INIT_MAIN_THREAD
-    init_main_thread(cs, infop);
-#else
-    target_pt_regs regs = { };
-
-    init_thread(&regs, infop);
-    target_cpu_copy_regs(cpu_env(cs), &regs);
-#endif
-}
diff --git a/linux-user/main.c b/linux-user/main.c
index 121dc4a0e6..d962f344b8 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1038,7 +1038,7 @@ int main(int argc, char **argv, char **envp)
        the real value of GUEST_BASE into account.  */
     tcg_prologue_init();
 
-    do_init_main_thread(cpu, info);
+    init_main_thread(cpu, info);
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-- 
2.43.0


