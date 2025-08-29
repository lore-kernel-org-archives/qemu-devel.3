Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A9FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkG-0001OA-UK; Sat, 30 Aug 2025 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XB-00036U-Mf
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X9-0002x8-GT
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-772301f8ae2so954541b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506321; x=1757111121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9m6A5YC5iG2ZMRgXVIU2Ixx/cYFasDyy2ZVNm3Vfvs=;
 b=VNmTywkLHolJ54oU7BX6fMahqWVpbbwyAVFfCVoptfW6WIXSFRe0kDFl9Oi3BxB3L6
 N9dw5Q5Dxb/8adhmJemekXGNU8d37uqpXULZM76EBCU76cgXV+0KKQ4PMmpOakkhKj+M
 KLkH70ZYA/T7gSh5frwESX+DJULJ5Cpjm44j0RRU2RT2hzqiu0FswgvKOSe1+WjU3i1T
 BqwVboWojXQvRpfFxGFIH5Sek5f2Tvzdmz0j7fXhUnxOLqfaD1/JTIAfsrW1zrNYSnHF
 HjEcs4ins1SzUbDgtW7FDj31+AlWkpLGTP2YfN9HoZpOjCbXzR6KmBbCEQVkY+WyiDoO
 1tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506321; x=1757111121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9m6A5YC5iG2ZMRgXVIU2Ixx/cYFasDyy2ZVNm3Vfvs=;
 b=wvqg/Ni1J8WnoK70wf6M8EQfC6kotMssOyvZ9KNYcD0S7TflnYEEcvQBkHi/lp37/Y
 6XuWErNmfe+Jf/9v54rxEHCuw9kPzA3IHFiZBVzorjPmUpulV0XenHteEG3LtGPZgZa2
 b0I6C8sIuasck4Mt7EDwicCBAdiqka76tXAif/ak7FtzMKf5h4Adz128JxtOlGt+L9Du
 pNugQ7owr4otpNjMVp8QV8SGZIzq9HtttSkJdVhwmEr66aRfSLyPreYsnvkro/PUFwvK
 L9Y+rzxwh/ox369wKXZPkx5Ecdi+FnY3Ipv2J4CCgfq8ADinuf9QYXCKeApi+24NEMnq
 xpBA==
X-Gm-Message-State: AOJu0YyT3bKmwhrLQLef9TPMbqYGWRl5sGUqMAD6aF102bYDpdJ712GH
 RGBwLkXhPuv2EZRjCQnv3LUdQ95bprSklRS4wy4m340f6lPLU6j7L1LUJb386cnG2+DvAmVNUAu
 CfEa0LIM=
X-Gm-Gg: ASbGncsTSKGVckO26cAn4i1OmxSuI38D2ygH0Kzs15OWyc0eB9K0nkYsAbmHgIEOjEs
 GABIq0gn9PTkAWs5dClGRstX2YBUUXGhkZNmTGLMw/KUdXQ5M4yXt4aDkbnAL7NB0Q4PVybrmY4
 iE8PDnkq3gYj5a6pK/eLSNRfuIOzsdJwRZB/XSogpa1pBwgmwnv5TL0GGF/tUYes1Z6ztXRbiYF
 2cXZLJV9MJftiIJ/TivKJsBvgL5BVXk2sCBs++HKkjeYPLJClA8E8TylPXU2ih++QILTKDfTTrd
 xH1JnO62L7M17YHnUfDQWS9U1EM4a60LlK+gRmpQOfdnqmi0VMqubyJsJ/MxY9X05eo6Vh2xsLm
 dT0ivNvAWktrK1b4yNH1S/haYsyUiS6KhZmCOuum6g3ZkLs/0fCjoT3+ZfqjfvYCnAzHpA4k=
X-Google-Smtp-Source: AGHT+IHUN7DT1QQRNVql5dPlF0KNRJ3sGPX1KMPjwyqTQPIujw0xFRfDZyr4x/U14aJGRCC63I6DpA==
X-Received: by 2002:a05:6a00:b96:b0:770:4d54:6234 with SMTP id
 d2e1a72fcca58-7723e1f4471mr278108b3a.3.1756506321511; 
 Fri, 29 Aug 2025 15:25:21 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/91] linux-user: Rename USE_ELF_CORE_DUMP to
 HAVE_ELF_CORE_DUMP
Date: Sat, 30 Aug 2025 08:23:16 +1000
Message-ID: <20250829222427.289668-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

The other knobs in target_elf.h are all HAVE_*.
Rename this USE_ELF_CORE_DUMP to match.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5ed5b3c544..af31a34594 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -281,7 +281,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_I386 */
@@ -309,7 +309,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
     r->regs[17] = tswapreg(env->regs[0]); /* XXX */
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 /* The commpage only exists for 32 bit kernels */
@@ -397,7 +397,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
     r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #if TARGET_BIG_ENDIAN
@@ -493,7 +493,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
     r->regs[38] = tswapreg(ccr);
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #ifndef TARGET_PPC64
@@ -540,7 +540,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
     r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_LOONGARCH64 */
@@ -606,7 +606,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
     r->regs[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_MIPS */
@@ -620,7 +620,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 
 #define ELF_EXEC_PAGESIZE        4096
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_NREG 38
 typedef struct target_elf_gregset_t {
     target_elf_greg_t regs[ELF_NREG];
@@ -649,7 +649,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
@@ -706,7 +706,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
     r->regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif
@@ -746,7 +746,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
     r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       8192
 
 #endif
@@ -797,7 +797,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUS390XState *env)
     r->regs[TARGET_REG_ORIG_R2] = 0;
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
 
 #define VDSO_HEADER "vdso.c.inc"
@@ -906,7 +906,7 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
     }
 }
 
-#define USE_ELF_CORE_DUMP
+#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #endif /* TARGET_XTENSA */
@@ -1115,9 +1115,9 @@ static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
 }
 #endif
 
-#ifdef USE_ELF_CORE_DUMP
+#ifdef HAVE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
-#endif /* USE_ELF_CORE_DUMP */
+#endif /* HAVE_ELF_CORE_DUMP */
 static void load_symbols(struct elfhdr *hdr, const ImageSource *src,
                          abi_ulong load_bias);
 
@@ -2827,14 +2827,14 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
         g_free(elf_interpreter);
     }
 
-#ifdef USE_ELF_CORE_DUMP
+#ifdef HAVE_ELF_CORE_DUMP
     bprm->core_dump = &elf_core_dump;
 #endif
 
     return 0;
 }
 
-#ifdef USE_ELF_CORE_DUMP
+#ifdef HAVE_ELF_CORE_DUMP
 
 /*
  * Definitions to generate Intel SVR4-like core files.
@@ -2850,10 +2850,10 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * Core dump code is copied from linux kernel (fs/binfmt_elf.c).
  *
  * Porting ELF coredump for target is (quite) simple process.  First you
- * define USE_ELF_CORE_DUMP in target ELF code (where init_thread() for
+ * define HAVE_ELF_CORE_DUMP in target ELF code (where init_thread() for
  * the target resides):
  *
- * #define USE_ELF_CORE_DUMP
+ * #define HAVE_ELF_CORE_DUMP
  *
  * Next you define type of register set used for dumping:
  * typedef struct target_elf_gregset_t { ... } target_elf_gregset_t;
@@ -3392,4 +3392,4 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     }
     return ret;
 }
-#endif /* USE_ELF_CORE_DUMP */
+#endif /* HAVE_ELF_CORE_DUMP */
-- 
2.43.0


