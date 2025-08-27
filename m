Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A246CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRs-0001i9-Kk; Wed, 27 Aug 2025 19:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRr-0001gn-EK
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRo-00049o-Vx
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so1211856b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336855; x=1756941655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2SfyAZc4XoY8CMkOgazi0gSdP78GuSA69fV6HrxMHw=;
 b=j1p4UlJwU0ZX+DEPUeXA16W0Av9xPfTwYT1UqqpJfko9osWK/53o2t8/GeUBmdiiNr
 5r5b0hiIbF4WKP1cd2RLku9ch1CHOUqCWblW+RBlFGBlqDWLGTO+mRAbH+TBYNCr4/Gs
 nuTk8ase+TZi4vdxBHsmuJMGl1ukC5gnLlriLF0vVLH8Tzo9VGnYZigA4x9kIglkRAWB
 yUEnApMcQiU/qgmni7wmync2X+YwD7wKJ3xkGHLRNNeRXiGc1LHFRZdOuFFs1TaoKUTz
 vVaLAbes6LaUuWM4tIoBmJfYQOJw0AYrfWo7QCyBQ+2Vbtud23w81NnmYbOd05PYmb16
 ICrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336855; x=1756941655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2SfyAZc4XoY8CMkOgazi0gSdP78GuSA69fV6HrxMHw=;
 b=Rcc9TGAS4j7eUCJO21Td7q4amQj7bE0mIP1NIEemasQcLFUhbjojIknIXdh8MBRgpT
 PwiXMjKxl7qs3SqceI1BlUUm6JcZzdfHuYlgIbxHbxoHlz+WdtU6MJYf6yQWlavih3EL
 EeZz+45GOPOQK/0S9IVCaNcxMbMcKmIXE8TLDPX1MFvPeF5zb8Nfsbr58rYx/3T4ur74
 5bflU5JBl+cXCAU9QB+CwzdWvoGbpUwOoqXGTuwe1ws/Gv3jj+FURqNDifKLMGDyiU1Q
 9jgBaMClYLWVGxj4fyiRULzQAkiLGRKP8Gxuo28X8DnEJHy6Wrcinn7iPyK+NDEyDC5m
 U5KQ==
X-Gm-Message-State: AOJu0YzWXuoWs6w8JXHtR7kMOW8XSgez6zROyYsAtZsQeE8xGOltBtUd
 ViA2Yjeg59XJKwz9g1cWrk5bI2itqARZ29AUDmcdsF7V1O3+6sp/PeG8PFs9EeD0kfees/xMxrG
 yx3B3VW0=
X-Gm-Gg: ASbGncsnvM+ZFRRNJhsSidJcAqIX6YhKQ4c09spCnNdqKkfbdG8i59Zp8unQ3yetcv4
 VPPwyNej87NVObVRodejtLhGcWCNtKip1TEgcDVq5TVmXpPk7FJPEwKnGCEbEzoEnNq34SFZuVU
 i5ciQf+Pwh/g8p1ZBjM4jX2EkhsInLARtSoz1ZK6pgWHqJOCbmNVGXSQYQ4wpEufCsD3XWLw1nm
 SFX4etVfBay/3p5ywXtvj2BTGbdp1/nLWi2W3xpzzEgExmPoU7JP42IGG8WDy6Ib0SqR7+2rsuX
 tVLJi38vig5+tsZYjcEma76iylwjj1cJolzi8VlpMWWI5WCo1Z+o2ANiafL6T+0dWVD7K+JFOxC
 wSa8t3kO2ClTnHP8Uqkw9Mg+upw==
X-Google-Smtp-Source: AGHT+IF51ODkI01nYC7F1UJEdR/ZzPcTIjz5TZ9r0jxcd4axT6kbOoqV5l3LWNEisgXm24l8fgwIhA==
X-Received: by 2002:a05:6a20:bb08:b0:243:9587:a774 with SMTP id
 adf61e73a8af0-2439587aa2fmr6653604637.28.1756336855074; 
 Wed, 27 Aug 2025 16:20:55 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/46] linux-user: Move hwcap functions to ppc/elfload.c
Date: Thu, 28 Aug 2025 09:19:46 +1000
Message-ID: <20250827232023.50398-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
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

Change the return type to abi_ulong, and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h         |   2 +-
 linux-user/ppc/target_elf.h |   3 +
 linux-user/elfload.c        | 116 +-----------------------------------
 linux-user/ppc/elfload.c    | 116 ++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 115 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 2c8414e0e5..818c5e6d7d 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,7 +102,7 @@ extern unsigned long guest_stack_size;
 const char *get_elf_cpu_model(uint32_t eflags);
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC)
+    || defined(TARGET_SPARC) || defined(TARGET_PPC)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 8c0a8ea431..4203a89d66 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_HWCAP2         1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 16709865f7..843b1f7b6c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -598,120 +598,8 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_ARCH        EM_PPC
 
-/* Feature masks for the Aux Vector Hardware Capabilities (AT_HWCAP).
-   See arch/powerpc/include/asm/cputable.h.  */
-enum {
-    QEMU_PPC_FEATURE_32 = 0x80000000,
-    QEMU_PPC_FEATURE_64 = 0x40000000,
-    QEMU_PPC_FEATURE_601_INSTR = 0x20000000,
-    QEMU_PPC_FEATURE_HAS_ALTIVEC = 0x10000000,
-    QEMU_PPC_FEATURE_HAS_FPU = 0x08000000,
-    QEMU_PPC_FEATURE_HAS_MMU = 0x04000000,
-    QEMU_PPC_FEATURE_HAS_4xxMAC = 0x02000000,
-    QEMU_PPC_FEATURE_UNIFIED_CACHE = 0x01000000,
-    QEMU_PPC_FEATURE_HAS_SPE = 0x00800000,
-    QEMU_PPC_FEATURE_HAS_EFP_SINGLE = 0x00400000,
-    QEMU_PPC_FEATURE_HAS_EFP_DOUBLE = 0x00200000,
-    QEMU_PPC_FEATURE_NO_TB = 0x00100000,
-    QEMU_PPC_FEATURE_POWER4 = 0x00080000,
-    QEMU_PPC_FEATURE_POWER5 = 0x00040000,
-    QEMU_PPC_FEATURE_POWER5_PLUS = 0x00020000,
-    QEMU_PPC_FEATURE_CELL = 0x00010000,
-    QEMU_PPC_FEATURE_BOOKE = 0x00008000,
-    QEMU_PPC_FEATURE_SMT = 0x00004000,
-    QEMU_PPC_FEATURE_ICACHE_SNOOP = 0x00002000,
-    QEMU_PPC_FEATURE_ARCH_2_05 = 0x00001000,
-    QEMU_PPC_FEATURE_PA6T = 0x00000800,
-    QEMU_PPC_FEATURE_HAS_DFP = 0x00000400,
-    QEMU_PPC_FEATURE_POWER6_EXT = 0x00000200,
-    QEMU_PPC_FEATURE_ARCH_2_06 = 0x00000100,
-    QEMU_PPC_FEATURE_HAS_VSX = 0x00000080,
-    QEMU_PPC_FEATURE_PSERIES_PERFMON_COMPAT = 0x00000040,
-
-    QEMU_PPC_FEATURE_TRUE_LE = 0x00000002,
-    QEMU_PPC_FEATURE_PPC_LE = 0x00000001,
-
-    /* Feature definitions in AT_HWCAP2.  */
-    QEMU_PPC_FEATURE2_ARCH_2_07 = 0x80000000, /* ISA 2.07 */
-    QEMU_PPC_FEATURE2_HAS_HTM = 0x40000000, /* Hardware Transactional Memory */
-    QEMU_PPC_FEATURE2_HAS_DSCR = 0x20000000, /* Data Stream Control Register */
-    QEMU_PPC_FEATURE2_HAS_EBB = 0x10000000, /* Event Base Branching */
-    QEMU_PPC_FEATURE2_HAS_ISEL = 0x08000000, /* Integer Select */
-    QEMU_PPC_FEATURE2_HAS_TAR = 0x04000000, /* Target Address Register */
-    QEMU_PPC_FEATURE2_VEC_CRYPTO = 0x02000000,
-    QEMU_PPC_FEATURE2_HTM_NOSC = 0x01000000,
-    QEMU_PPC_FEATURE2_ARCH_3_00 = 0x00800000, /* ISA 3.00 */
-    QEMU_PPC_FEATURE2_HAS_IEEE128 = 0x00400000, /* VSX IEEE Bin Float 128-bit */
-    QEMU_PPC_FEATURE2_DARN = 0x00200000, /* darn random number insn */
-    QEMU_PPC_FEATURE2_SCV = 0x00100000, /* scv syscall */
-    QEMU_PPC_FEATURE2_HTM_NO_SUSPEND = 0x00080000, /* TM w/o suspended state */
-    QEMU_PPC_FEATURE2_ARCH_3_1 = 0x00040000, /* ISA 3.1 */
-    QEMU_PPC_FEATURE2_MMA = 0x00020000, /* Matrix-Multiply Assist */
-};
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);
-    uint32_t features = 0;
-
-    /* We don't have to be terribly complete here; the high points are
-       Altivec/FP/SPE support.  Anything else is just a bonus.  */
-#define GET_FEATURE(flag, feature)                                      \
-    do { if (cpu->env.insns_flags & flag) { features |= feature; } } while (0)
-#define GET_FEATURE2(flags, feature) \
-    do { \
-        if ((cpu->env.insns_flags2 & flags) == flags) { \
-            features |= feature; \
-        } \
-    } while (0)
-    GET_FEATURE(PPC_64B, QEMU_PPC_FEATURE_64);
-    GET_FEATURE(PPC_FLOAT, QEMU_PPC_FEATURE_HAS_FPU);
-    GET_FEATURE(PPC_ALTIVEC, QEMU_PPC_FEATURE_HAS_ALTIVEC);
-    GET_FEATURE(PPC_SPE, QEMU_PPC_FEATURE_HAS_SPE);
-    GET_FEATURE(PPC_SPE_SINGLE, QEMU_PPC_FEATURE_HAS_EFP_SINGLE);
-    GET_FEATURE(PPC_SPE_DOUBLE, QEMU_PPC_FEATURE_HAS_EFP_DOUBLE);
-    GET_FEATURE(PPC_BOOKE, QEMU_PPC_FEATURE_BOOKE);
-    GET_FEATURE(PPC_405_MAC, QEMU_PPC_FEATURE_HAS_4xxMAC);
-    GET_FEATURE2(PPC2_DFP, QEMU_PPC_FEATURE_HAS_DFP);
-    GET_FEATURE2(PPC2_VSX, QEMU_PPC_FEATURE_HAS_VSX);
-    GET_FEATURE2((PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |
-                  PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206),
-                  QEMU_PPC_FEATURE_ARCH_2_06);
-#undef GET_FEATURE
-#undef GET_FEATURE2
-
-    return features;
-}
-
-#define ELF_HWCAP2 get_elf_hwcap2()
-
-static uint32_t get_elf_hwcap2(void)
-{
-    PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);
-    uint32_t features = 0;
-
-#define GET_FEATURE(flag, feature)                                      \
-    do { if (cpu->env.insns_flags & flag) { features |= feature; } } while (0)
-#define GET_FEATURE2(flag, feature)                                      \
-    do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
-
-    GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
-    GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
-    GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07 |
-                  QEMU_PPC_FEATURE2_VEC_CRYPTO);
-    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
-                 QEMU_PPC_FEATURE2_DARN | QEMU_PPC_FEATURE2_HAS_IEEE128);
-    GET_FEATURE2(PPC2_ISA310, QEMU_PPC_FEATURE2_ARCH_3_1 |
-                 QEMU_PPC_FEATURE2_MMA);
-
-#undef GET_FEATURE
-#undef GET_FEATURE2
-
-    return features;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
+#define ELF_HWCAP2 get_elf_hwcap2(thread_cpu)
 
 /*
  * The requirements here are:
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 7775dc06fa..a214675650 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -13,3 +13,119 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "750";
 #endif
 }
+
+/*
+ * Feature masks for the Aux Vector Hardware Capabilities (AT_HWCAP).
+ * See arch/powerpc/include/asm/cputable.h.
+ */
+enum {
+    QEMU_PPC_FEATURE_32 = 0x80000000,
+    QEMU_PPC_FEATURE_64 = 0x40000000,
+    QEMU_PPC_FEATURE_601_INSTR = 0x20000000,
+    QEMU_PPC_FEATURE_HAS_ALTIVEC = 0x10000000,
+    QEMU_PPC_FEATURE_HAS_FPU = 0x08000000,
+    QEMU_PPC_FEATURE_HAS_MMU = 0x04000000,
+    QEMU_PPC_FEATURE_HAS_4xxMAC = 0x02000000,
+    QEMU_PPC_FEATURE_UNIFIED_CACHE = 0x01000000,
+    QEMU_PPC_FEATURE_HAS_SPE = 0x00800000,
+    QEMU_PPC_FEATURE_HAS_EFP_SINGLE = 0x00400000,
+    QEMU_PPC_FEATURE_HAS_EFP_DOUBLE = 0x00200000,
+    QEMU_PPC_FEATURE_NO_TB = 0x00100000,
+    QEMU_PPC_FEATURE_POWER4 = 0x00080000,
+    QEMU_PPC_FEATURE_POWER5 = 0x00040000,
+    QEMU_PPC_FEATURE_POWER5_PLUS = 0x00020000,
+    QEMU_PPC_FEATURE_CELL = 0x00010000,
+    QEMU_PPC_FEATURE_BOOKE = 0x00008000,
+    QEMU_PPC_FEATURE_SMT = 0x00004000,
+    QEMU_PPC_FEATURE_ICACHE_SNOOP = 0x00002000,
+    QEMU_PPC_FEATURE_ARCH_2_05 = 0x00001000,
+    QEMU_PPC_FEATURE_PA6T = 0x00000800,
+    QEMU_PPC_FEATURE_HAS_DFP = 0x00000400,
+    QEMU_PPC_FEATURE_POWER6_EXT = 0x00000200,
+    QEMU_PPC_FEATURE_ARCH_2_06 = 0x00000100,
+    QEMU_PPC_FEATURE_HAS_VSX = 0x00000080,
+    QEMU_PPC_FEATURE_PSERIES_PERFMON_COMPAT = 0x00000040,
+
+    QEMU_PPC_FEATURE_TRUE_LE = 0x00000002,
+    QEMU_PPC_FEATURE_PPC_LE = 0x00000001,
+
+    /* Feature definitions in AT_HWCAP2.  */
+    QEMU_PPC_FEATURE2_ARCH_2_07 = 0x80000000, /* ISA 2.07 */
+    QEMU_PPC_FEATURE2_HAS_HTM = 0x40000000, /* Hardware Transactional Memory */
+    QEMU_PPC_FEATURE2_HAS_DSCR = 0x20000000, /* Data Stream Control Register */
+    QEMU_PPC_FEATURE2_HAS_EBB = 0x10000000, /* Event Base Branching */
+    QEMU_PPC_FEATURE2_HAS_ISEL = 0x08000000, /* Integer Select */
+    QEMU_PPC_FEATURE2_HAS_TAR = 0x04000000, /* Target Address Register */
+    QEMU_PPC_FEATURE2_VEC_CRYPTO = 0x02000000,
+    QEMU_PPC_FEATURE2_HTM_NOSC = 0x01000000,
+    QEMU_PPC_FEATURE2_ARCH_3_00 = 0x00800000, /* ISA 3.00 */
+    QEMU_PPC_FEATURE2_HAS_IEEE128 = 0x00400000, /* VSX IEEE Bin Float 128-bit */
+    QEMU_PPC_FEATURE2_DARN = 0x00200000, /* darn random number insn */
+    QEMU_PPC_FEATURE2_SCV = 0x00100000, /* scv syscall */
+    QEMU_PPC_FEATURE2_HTM_NO_SUSPEND = 0x00080000, /* TM w/o suspended state */
+    QEMU_PPC_FEATURE2_ARCH_3_1 = 0x00040000, /* ISA 3.1 */
+    QEMU_PPC_FEATURE2_MMA = 0x00020000, /* Matrix-Multiply Assist */
+};
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    uint32_t features = 0;
+
+    /*
+     * We don't have to be terribly complete here; the high points are
+     * Altivec/FP/SPE support.  Anything else is just a bonus.
+     */
+#define GET_FEATURE(flag, feature)                                      \
+    do { if (cpu->env.insns_flags & flag) { features |= feature; } } while (0)
+#define GET_FEATURE2(flags, feature) \
+    do { \
+        if ((cpu->env.insns_flags2 & flags) == flags) { \
+            features |= feature; \
+        } \
+    } while (0)
+    GET_FEATURE(PPC_64B, QEMU_PPC_FEATURE_64);
+    GET_FEATURE(PPC_FLOAT, QEMU_PPC_FEATURE_HAS_FPU);
+    GET_FEATURE(PPC_ALTIVEC, QEMU_PPC_FEATURE_HAS_ALTIVEC);
+    GET_FEATURE(PPC_SPE, QEMU_PPC_FEATURE_HAS_SPE);
+    GET_FEATURE(PPC_SPE_SINGLE, QEMU_PPC_FEATURE_HAS_EFP_SINGLE);
+    GET_FEATURE(PPC_SPE_DOUBLE, QEMU_PPC_FEATURE_HAS_EFP_DOUBLE);
+    GET_FEATURE(PPC_BOOKE, QEMU_PPC_FEATURE_BOOKE);
+    GET_FEATURE(PPC_405_MAC, QEMU_PPC_FEATURE_HAS_4xxMAC);
+    GET_FEATURE2(PPC2_DFP, QEMU_PPC_FEATURE_HAS_DFP);
+    GET_FEATURE2(PPC2_VSX, QEMU_PPC_FEATURE_HAS_VSX);
+    GET_FEATURE2((PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |
+                  PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206),
+                  QEMU_PPC_FEATURE_ARCH_2_06);
+
+#undef GET_FEATURE
+#undef GET_FEATURE2
+
+    return features;
+}
+
+abi_ulong get_elf_hwcap2(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    uint32_t features = 0;
+
+#define GET_FEATURE(flag, feature)                                      \
+    do { if (cpu->env.insns_flags & flag) { features |= feature; } } while (0)
+#define GET_FEATURE2(flag, feature)                                      \
+    do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
+
+    GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
+    GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
+    GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07 |
+                  QEMU_PPC_FEATURE2_VEC_CRYPTO);
+    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
+                 QEMU_PPC_FEATURE2_DARN | QEMU_PPC_FEATURE2_HAS_IEEE128);
+    GET_FEATURE2(PPC2_ISA310, QEMU_PPC_FEATURE2_ARCH_3_1 |
+                 QEMU_PPC_FEATURE2_MMA);
+
+#undef GET_FEATURE
+#undef GET_FEATURE2
+
+    return features;
+}
-- 
2.43.0


