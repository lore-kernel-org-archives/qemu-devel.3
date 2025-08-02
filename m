Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B27C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLU1-0006AQ-Qg; Sat, 02 Aug 2025 19:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTM-0004zh-Fk
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:17:06 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTK-0002ha-3v
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:17:04 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7416d362e7aso1688488a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176620; x=1754781420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQogNm5ZECiw1tt/T2fhoBqBr+ViP56B0DF9NHMiKqs=;
 b=YiAcomUTfmKnYG+SDwYIdT3/PHIUXy1D+q+GjhJ4WHAuKZ9rWbqhFZwfmC4kInCJ9r
 DiRBsyGqsRhy1raEXgJitrhXsGgrE0T6oqQH8dFvDT+C2N6DfCIG9XJt3/pcNXkBbhjF
 BgPg30YRHiYdwde9cVDzdbeeUoCtLk96IAoPbaccHmRDXlCUubv3XhcAgRGeqhqCFjTf
 GlxiqDubofCxRAyLZYMnAOhhZj5Iyej40kyVB9LKbvr0ts19JOvKFlfXHWHfDEIcsiwx
 MTPJThk5vjS/8EywyHPgljMGqk5deW0IaVis2ttazf/ZuFm69lEnAGxP+XhXX7j1PtCa
 Pk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176620; x=1754781420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQogNm5ZECiw1tt/T2fhoBqBr+ViP56B0DF9NHMiKqs=;
 b=AcY4iDfZFoJtZFjHMAEc3gC1MLGG87d1hjuhhLsyYgA/Y2InZpciPINhpwEX8gEjyS
 OzfU1k6DDdY/QMRFFD6xagRvozDEdl6jNPc/0HNM1CbxP+P30OborVSUnRbvwkCP/qic
 Qrl764iCbuYRLBYxC0VXL4RJoOfD0K1jeeOe3d9FAIS0v6QjF+AtzSpbiH5b1P7DU32G
 u145E4zzIlZwkV+ke4d0s623LxpDUvIlai+FZE6iwkde2w8whci4IpFYshx2ibwOBJQ9
 U8Uq3SA5IaeCaYizJh3XbHoAVIlZipFT31q9VBxAbtNNuMwCnLGA52biNCHtAajKhtFb
 lQRA==
X-Gm-Message-State: AOJu0Yzuz6VPmQ5EAKeMYLsWAXg9Av4Vb735mGuAv1iPY1uXTdrTdd9K
 IwQWbaIXgC7XtijPzISBJqKHIsrleSL8C3QURvMMf9MfC736sqC9ASSHSlaspFQFsti8avBOHUH
 ++gMlWwc=
X-Gm-Gg: ASbGnctOcH8ftKFnHNknvjBRgTCDz26SmIUw5gM6kw/uWkXVQDCHOsKMQEr25ia3ZHY
 oaVBNL/yH+mVodWJxdRTJ2n9P7lE4KvSZhC4Bd0iMhgoFDALqJDKkheTXc79HQjhz6qwwB88MzJ
 4n6s6GGyRgWy8YWMlcsZ/D49LM3EYBeONtYuJZOmCugi8cVarEoAEeN+D82Q8KWQsxD9V5+YQGa
 JXZkqfffzoHYySvVOCsGgtQdJmxA16c8xr6hTawkPk/i0b7mpPPaUhiENeTFyYqay0SUQzQvhQy
 VciIesaORJk4ctSOd6FrkV0bS1eWh/yzhc+pOcrR6bGI/nSbHPoelT0jsD0lNkFT85fn4Q42cup
 7ZKosany7KsmiOsaM0YtjiJamFi8xSn8QA6EF2nF9rCo4lUBxhl0w4c662yucBms=
X-Google-Smtp-Source: AGHT+IGT5x6HGXEuQg9Qp/sQf0QrLwpK6gplBM7txkopYk4NmGEfdvj/pi02F+oIfgexfoyjvSZpDA==
X-Received: by 2002:a05:6830:4423:b0:741:90c1:5f with SMTP id
 46e09a7af769-7419d289248mr2489571a34.24.1754176619963; 
 Sat, 02 Aug 2025 16:16:59 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 95/95] linux-user: Remove struct target_pt_regs from
 target_syscall.h
Date: Sun,  3 Aug 2025 09:04:59 +1000
Message-ID: <20250802230459.412251-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

This structure is unused, and would only ever be used for the
ptrace syscall, which we will never implement for linux-user.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h     |  7 -----
 linux-user/alpha/target_syscall.h       | 40 -------------------------
 linux-user/arm/target_syscall.h         |  8 -----
 linux-user/hexagon/target_syscall.h     |  5 ----
 linux-user/hppa/target_syscall.h        | 18 -----------
 linux-user/i386/target_syscall.h        | 18 -----------
 linux-user/loongarch64/target_syscall.h | 23 --------------
 linux-user/m68k/target_syscall.h        | 16 ----------
 linux-user/mips/target_syscall.h        | 19 ------------
 linux-user/mips64/target_syscall.h      | 16 ----------
 linux-user/ppc/target_syscall.h         | 28 -----------------
 linux-user/riscv/target_syscall.h       | 35 ----------------------
 linux-user/sh4/target_syscall.h         | 11 -------
 linux-user/x86_64/target_syscall.h      | 28 -----------------
 linux-user/xtensa/target_syscall.h      | 35 ----------------------
 15 files changed, 307 deletions(-)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index c055133725..bd05f6c7fe 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -1,13 +1,6 @@
 #ifndef AARCH64_TARGET_SYSCALL_H
 #define AARCH64_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    uint64_t        regs[31];
-    uint64_t        sp;
-    uint64_t        pc;
-    uint64_t        pstate;
-};
-
 #if TARGET_BIG_ENDIAN
 #define UNAME_MACHINE "aarch64_be"
 #else
diff --git a/linux-user/alpha/target_syscall.h b/linux-user/alpha/target_syscall.h
index fda3a49f29..53706b749f 100644
--- a/linux-user/alpha/target_syscall.h
+++ b/linux-user/alpha/target_syscall.h
@@ -1,46 +1,6 @@
 #ifndef ALPHA_TARGET_SYSCALL_H
 #define ALPHA_TARGET_SYSCALL_H
 
-/* default linux values for the selectors */
-#define __USER_DS	(1)
-
-struct target_pt_regs {
-	abi_ulong r0;
-	abi_ulong r1;
-	abi_ulong r2;
-	abi_ulong r3;
-	abi_ulong r4;
-	abi_ulong r5;
-	abi_ulong r6;
-	abi_ulong r7;
-	abi_ulong r8;
-	abi_ulong r19;
-	abi_ulong r20;
-	abi_ulong r21;
-	abi_ulong r22;
-	abi_ulong r23;
-	abi_ulong r24;
-	abi_ulong r25;
-	abi_ulong r26;
-	abi_ulong r27;
-	abi_ulong r28;
-	abi_ulong hae;
-/* JRP - These are the values provided to a0-a2 by PALcode */
-	abi_ulong trap_a0;
-	abi_ulong trap_a1;
-	abi_ulong trap_a2;
-/* These are saved by PAL-code: */
-	abi_ulong ps;
-	abi_ulong pc;
-	abi_ulong gp;
-	abi_ulong r16;
-	abi_ulong r17;
-	abi_ulong r18;
-/* Those is needed by qemu to temporary store the user stack pointer */
-        abi_ulong usp;
-        abi_ulong unique;
-};
-
 #define UNAME_MACHINE "alpha"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index 412ad434cf..8c4ddba717 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -1,14 +1,6 @@
 #ifndef ARM_TARGET_SYSCALL_H
 #define ARM_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-/* uregs[0..15] are r0 to r15; uregs[16] is CPSR; uregs[17] is ORIG_r0 */
-struct target_pt_regs {
-    abi_long uregs[18];
-};
-
 #define ARM_SYSCALL_BASE	0x900000
 #define ARM_THUMB_SYSCALL	0
 
diff --git a/linux-user/hexagon/target_syscall.h b/linux-user/hexagon/target_syscall.h
index 7f91a4abc7..d9c94737a5 100644
--- a/linux-user/hexagon/target_syscall.h
+++ b/linux-user/hexagon/target_syscall.h
@@ -18,11 +18,6 @@
 #ifndef HEXAGON_TARGET_SYSCALL_H
 #define HEXAGON_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    abi_long sepc;
-    abi_long sp;
-};
-
 #define UNAME_MACHINE "hexagon"
 #define UNAME_MINIMUM_RELEASE "4.15.0"
 
diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
index 9a8f8ca628..4b21e85371 100644
--- a/linux-user/hppa/target_syscall.h
+++ b/linux-user/hppa/target_syscall.h
@@ -1,24 +1,6 @@
 #ifndef HPPA_TARGET_SYSCALL_H
 #define HPPA_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    target_ulong gr[32];
-    uint64_t     fr[32];
-    target_ulong sr[8];
-    target_ulong iasq[2];
-    target_ulong iaoq[2];
-    target_ulong cr27;
-    target_ulong __pad0;
-    target_ulong orig_r28;
-    target_ulong ksp;
-    target_ulong kpc;
-    target_ulong sar;
-    target_ulong iir;
-    target_ulong isr;
-    target_ulong ior;
-    target_ulong ipsw;
-};
-
 #define UNAME_MACHINE "parisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 #define TARGET_CLONE_BACKWARDS
diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
index aaade06b13..c214a909a6 100644
--- a/linux-user/i386/target_syscall.h
+++ b/linux-user/i386/target_syscall.h
@@ -5,24 +5,6 @@
 #define __USER_CS	(0x23)
 #define __USER_DS	(0x2B)
 
-struct target_pt_regs {
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	int  xds;
-	int  xes;
-	long orig_eax;
-	long eip;
-	int  xcs;
-	long eflags;
-	long esp;
-	int  xss;
-};
-
 /* ioctls */
 
 #define TARGET_LDT_ENTRIES      8192
diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
index 39f229bb9c..f7ced7b2be 100644
--- a/linux-user/loongarch64/target_syscall.h
+++ b/linux-user/loongarch64/target_syscall.h
@@ -8,29 +8,6 @@
 
 #include "qemu/units.h"
 
-/*
- * this struct defines the way the registers are stored on the
- * stack during a system call.
- */
-
-struct target_pt_regs {
-    /* Saved main processor registers. */
-    target_ulong regs[32];
-
-    /* Saved special registers. */
-    struct {
-        target_ulong era;
-        target_ulong badv;
-        target_ulong crmd;
-        target_ulong prmd;
-        target_ulong euen;
-        target_ulong ecfg;
-        target_ulong estat;
-    } csr;
-    target_ulong orig_a0;
-    target_ulong __last[0];
-};
-
 #define UNAME_MACHINE "loongarch64"
 #define UNAME_MINIMUM_RELEASE "5.19.0"
 
diff --git a/linux-user/m68k/target_syscall.h b/linux-user/m68k/target_syscall.h
index 8d4ddbd76c..3ca0231c70 100644
--- a/linux-user/m68k/target_syscall.h
+++ b/linux-user/m68k/target_syscall.h
@@ -1,22 +1,6 @@
 #ifndef M68K_TARGET_SYSCALL_H
 #define M68K_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct target_pt_regs {
-    abi_long d1, d2, d3, d4, d5, d6, d7;
-    abi_long a0, a1, a2, a3, a4, a5, a6;
-    abi_ulong d0;
-    abi_ulong usp;
-    abi_ulong orig_d0;
-    int16_t stkadj;
-    uint16_t sr;
-    abi_ulong pc;
-    uint16_t fntvex;
-    uint16_t __fill;
-};
-
 #define UNAME_MACHINE "m68k"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 08ead67810..dfcdf320b7 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -1,25 +1,6 @@
 #ifndef MIPS_TARGET_SYSCALL_H
 #define MIPS_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct target_pt_regs {
-	/* Pad bytes for argument save space on the stack. */
-	abi_ulong pad0[6];
-
-	/* Saved main processor registers. */
-	abi_ulong regs[32];
-
-	/* Saved special registers. */
-	abi_ulong cp0_status;
-	abi_ulong lo;
-	abi_ulong hi;
-	abi_ulong cp0_badvaddr;
-	abi_ulong cp0_cause;
-	abi_ulong cp0_epc;
-};
-
 #define UNAME_MACHINE "mips"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 358dc2d64c..9135bf5e8b 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -1,22 +1,6 @@
 #ifndef MIPS64_TARGET_SYSCALL_H
 #define MIPS64_TARGET_SYSCALL_H
 
-/* this struct defines the way the registers are stored on the
-   stack during a system call. */
-
-struct target_pt_regs {
-        /* Saved main processor registers. */
-        target_ulong regs[32];
-
-        /* Saved special registers. */
-        target_ulong cp0_status;
-        target_ulong lo;
-        target_ulong hi;
-        target_ulong cp0_badvaddr;
-        target_ulong cp0_cause;
-        target_ulong cp0_epc;
-};
-
 #define UNAME_MACHINE "mips64"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
index 77b36d0b46..976b4bb7e9 100644
--- a/linux-user/ppc/target_syscall.h
+++ b/linux-user/ppc/target_syscall.h
@@ -20,34 +20,6 @@
 #ifndef PPC_TARGET_SYSCALL_H
 #define PPC_TARGET_SYSCALL_H
 
-/* XXX: ABSOLUTELY BUGGY:
- * for now, this is quite just a cut-and-paste from i386 target...
- */
-
-/* default linux values for the selectors */
-#define __USER_DS	(1)
-
-struct target_pt_regs {
-	abi_ulong gpr[32];
-	abi_ulong nip;
-	abi_ulong msr;
-	abi_ulong orig_gpr3;	/* Used for restarting system calls */
-	abi_ulong ctr;
-	abi_ulong link;
-	abi_ulong xer;
-	abi_ulong ccr;
-#if defined(TARGET_PPC64)
-        abi_ulong softe;
-#else
-	abi_ulong mq;		/* 601 only (not used at present) */
-#endif
-					/* Used on APUS to hold IPL value. */
-	abi_ulong trap;		/* Reason for being here */
-	abi_ulong dar;		/* Fault registers */
-	abi_ulong dsisr;
-	abi_ulong result; 		/* Result of a system call */
-};
-
 /* ioctls */
 struct target_revectored_struct {
 	abi_ulong __map[8];			/* 256 bits */
diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
index 7601f10c28..69a7b753eb 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -8,41 +8,6 @@
 #ifndef LINUX_USER_RISCV_TARGET_SYSCALL_H
 #define LINUX_USER_RISCV_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    abi_long sepc;
-    abi_long ra;
-    abi_long sp;
-    abi_long gp;
-    abi_long tp;
-    abi_long t0;
-    abi_long t1;
-    abi_long t2;
-    abi_long s0;
-    abi_long s1;
-    abi_long a0;
-    abi_long a1;
-    abi_long a2;
-    abi_long a3;
-    abi_long a4;
-    abi_long a5;
-    abi_long a6;
-    abi_long a7;
-    abi_long s2;
-    abi_long s3;
-    abi_long s4;
-    abi_long s5;
-    abi_long s6;
-    abi_long s7;
-    abi_long s8;
-    abi_long s9;
-    abi_long s10;
-    abi_long s11;
-    abi_long t3;
-    abi_long t4;
-    abi_long t5;
-    abi_long t6;
-};
-
 #ifdef TARGET_RISCV32
 #define UNAME_MACHINE "riscv32"
 #define UNAME_MINIMUM_RELEASE "5.4.0"
diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
index 148398855d..2f3557742d 100644
--- a/linux-user/sh4/target_syscall.h
+++ b/linux-user/sh4/target_syscall.h
@@ -1,17 +1,6 @@
 #ifndef SH4_TARGET_SYSCALL_H
 #define SH4_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-        unsigned long regs[16];
-        unsigned long pc;
-        unsigned long pr;
-        unsigned long sr;
-        unsigned long gbr;
-        unsigned long mach;
-        unsigned long macl;
-        long tra;
-};
-
 #define UNAME_MACHINE "sh4"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
index fb558345d3..68f55f8e7b 100644
--- a/linux-user/x86_64/target_syscall.h
+++ b/linux-user/x86_64/target_syscall.h
@@ -4,34 +4,6 @@
 #define __USER_CS	(0x33)
 #define __USER_DS	(0x2B)
 
-struct target_pt_regs {
-	abi_ulong r15;
-	abi_ulong r14;
-	abi_ulong r13;
-	abi_ulong r12;
-	abi_ulong rbp;
-	abi_ulong rbx;
-/* arguments: non interrupts/non tracing syscalls only save up to here */
-	abi_ulong r11;
-	abi_ulong r10;
-	abi_ulong r9;
-	abi_ulong r8;
-	abi_ulong rax;
-	abi_ulong rcx;
-	abi_ulong rdx;
-	abi_ulong rsi;
-	abi_ulong rdi;
-	abi_ulong orig_rax;
-/* end of arguments */
-/* cpu exception frame or undefined */
-	abi_ulong rip;
-	abi_ulong cs;
-	abi_ulong eflags;
-	abi_ulong rsp;
-	abi_ulong ss;
-/* top of stack page */
-};
-
 /* Maximum number of LDT entries supported. */
 #define TARGET_LDT_ENTRIES	8192
 /* The size of each LDT entry. */
diff --git a/linux-user/xtensa/target_syscall.h b/linux-user/xtensa/target_syscall.h
index afc86a153f..5d4352a4d1 100644
--- a/linux-user/xtensa/target_syscall.h
+++ b/linux-user/xtensa/target_syscall.h
@@ -8,41 +8,6 @@
 
 #define MMAP_SHIFT TARGET_PAGE_BITS
 
-typedef uint32_t xtensa_reg_t;
-typedef struct {
-} xtregs_opt_t; /* TODO */
-
-struct target_pt_regs {
-    xtensa_reg_t pc;            /*   4 */
-    xtensa_reg_t ps;            /*   8 */
-    xtensa_reg_t depc;          /*  12 */
-    xtensa_reg_t exccause;      /*  16 */
-    xtensa_reg_t excvaddr;      /*  20 */
-    xtensa_reg_t debugcause;    /*  24 */
-    xtensa_reg_t wmask;         /*  28 */
-    xtensa_reg_t lbeg;          /*  32 */
-    xtensa_reg_t lend;          /*  36 */
-    xtensa_reg_t lcount;        /*  40 */
-    xtensa_reg_t sar;           /*  44 */
-    xtensa_reg_t windowbase;    /*  48 */
-    xtensa_reg_t windowstart;   /*  52 */
-    xtensa_reg_t syscall;       /*  56 */
-    xtensa_reg_t icountlevel;   /*  60 */
-    xtensa_reg_t scompare1;     /*  64 */
-    xtensa_reg_t threadptr;     /*  68 */
-
-    /* Additional configurable registers that are used by the compiler. */
-    xtregs_opt_t xtregs_opt;
-
-    /* Make sure the areg field is 16 bytes aligned. */
-    int align[0] __attribute__ ((aligned(16)));
-
-    /* current register frame.
-     * Note: The ESF for kernel exceptions ends after 16 registers!
-     */
-    xtensa_reg_t areg[16];
-};
-
 #define TARGET_MCL_CURRENT 1
 #define TARGET_MCL_FUTURE  2
 #define TARGET_MCL_ONFAULT 4
-- 
2.43.0


