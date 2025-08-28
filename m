Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29036CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbSn-000414-GU; Thu, 28 Aug 2025 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRU-0002Qg-NW
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRS-0007EC-PR
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2445827be70so10105395ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382961; x=1756987761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjOAYz6KTtpZIgXmQSqo2WH3mmuF1FrSZppcDhCyxeM=;
 b=v+OziQesFg9hEzPru4bxtLe5fd5CvUf3WgJh9d4jmSUq8J9nwdtt5j+HtV2aaRjX7T
 RVPb431iJ5AHCOFbUKTG8qikMh89ao8BJCIomUX8Wbd0eQvaYELTkW+QKqS7YW9XM9vc
 NFcwpKHNn7PYdLLbRiVHxww8gfCJfZYQdqV4O9Wm51tVf5Bass9WKjYdB15eM1p+vJjB
 SgUNihMhb1FILmtWVgFyWc03emO7lHEbKl4z6mC/nP8T9mGVScvUEIXdS7eIw3fSE3OK
 VgRjtUAKeWZVICJ87z/gGTcWdMsc5oFn7qW0EG3dCmehKAyrXb95e8s0FA9bBlZi+BA4
 GPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382961; x=1756987761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjOAYz6KTtpZIgXmQSqo2WH3mmuF1FrSZppcDhCyxeM=;
 b=oq2Iq9+e+CEPqJ9kWwQ2diSPHYiU6H5v8b+/A7909qe6KHK9Q9cUIfS2vqEIAMGLEh
 hxPmJNpKDH3ixAAnKxbItL297arvgu45V+HlvGoXBWDXX7QKOry7rlLD6dT2d+c7YKx8
 bHIDjAdxZ6UlTqKUWFpG8WTa8BFgW+Xdh6OKdb+RryHv5dgCLiYvulu3RyiM7MvYbHv+
 B2g8ymhxuUSHp8iLvTTthito117TVt6sw4BPB+/N7BTX76ATwPLqNXP4nXvZ2Jtfzroh
 8dLEUNSVOl66gKuD/rtRGXbIx2aRwM+SG/+6WBHxbbcOM8o9EA2rGxNfzmKISTntzfr8
 Z+VA==
X-Gm-Message-State: AOJu0YyleHpAmiGjylhaS3TVsKSQRxli8NKl9ACdE447Z58q+I+ETDx6
 tRdgfxcQuMu1HdCfLf2r6ceiLEU5/2u0mv+JDeZOxAF79a6OhjqtVdbavkaxJRDaB+AuDArx57r
 bC5vmBVk=
X-Gm-Gg: ASbGncvujpNSp7LjHH2QwHPDBF3zyIWdOphdUKBaGl5vC/IIVYJH53O7mlkP6MAGwX/
 eDqhsshZXRcE4ZueVYg72q6JvLwaqHANKXxKCpj2g2SnSih4/e+FArlARReQcdZ9nGkx79gUGxq
 VEHjT1p8NMpFUU5niyFV2cdNHRIRhJV6fpwXPn6IuFJcN+S+13SEE5c5sLdvPRtdOPiAQYTxP+M
 cuJLeGZTkC6QObPmEtvaPoQWZHU6ZJpiCfrZ2dB+7xR+/erHVXhvg+RiSaAValay85DTNdnwvps
 NlrSEzTq/9qErYQEd+i6GsIOM0BBdpP0UWuSgHnWLzHlXs1wDHnT4nXb4j1c7zJbnO7+1h0xQcO
 +c2GKDpNueng8ZxQ7mXWB4mHxtlVVK/kRIuJ9
X-Google-Smtp-Source: AGHT+IGjYrHkL4I8gBfnQSotV9uB86QSmOsITPeOuz02W3WGFp6Y8sZ3E1bR1mE2L48/NhyAwbkQFA==
X-Received: by 2002:a17:903:2441:b0:245:f2c2:64ed with SMTP id
 d9443c01a7336-2462ee13160mr321037795ad.24.1756382961182; 
 Thu, 28 Aug 2025 05:09:21 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 16/87] linux-user: Rename USE_ELF_CORE_DUMP to
 HAVE_ELF_CORE_DUMP
Date: Thu, 28 Aug 2025 22:07:25 +1000
Message-ID: <20250828120836.195358-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


