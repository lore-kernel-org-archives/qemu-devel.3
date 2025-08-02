Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56FAC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIZ-0000r6-O5; Sat, 02 Aug 2025 19:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIS-0000lk-Dz
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:49 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIQ-00015c-0C
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:48 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-615950642d9so927419eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175944; x=1754780744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2SfyAZc4XoY8CMkOgazi0gSdP78GuSA69fV6HrxMHw=;
 b=Z1KTQCOKDBKZwZUhUkQqSed41+Ad/FLrtut0UgAIJgrukZ+CdhoWSDbt1rIwYV+9iK
 Z5cGf0O8d7AZOQILao5eJkNTXShDQY/+ysVXWLeB+lh3d5XO8T4CiO4ujyXg45qfaAnz
 ag6H1FBxJEkEA9cBZ6KMWNBJnUaQnC8ChiML6eMkZjZVsTxaVpJppXprnD+gCYIx6wLe
 c2T4+JPIEo7l4VILR4Qafchl5pi//XlKrDHBIWV7XIzzvCG+srDWC+csv82pP/y6Vs23
 A4r2v6Mhl0iJ6eBORpIxlmuG3RtUOJkbJYbpunMI7h+Lfnn4kYENbxXt8VdMjPN55qXr
 5VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175944; x=1754780744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2SfyAZc4XoY8CMkOgazi0gSdP78GuSA69fV6HrxMHw=;
 b=cvSA1vkDWSEoQwiRM87EFOrbzsGzeBodnCfCDfWsWJ7jSpALSXRo6w880P7YUgN5Gv
 ATpqTkSyMFh6Ltsjjz5KWLq+FwgneNA0iwsbe3Gg4feFDEkQcB636y81c2nMjDRHlmB3
 8Agqa3/NI8Ua+C3NOowp/2GB7apj9+e7CJOgfSidWqlBAviaLMHjvo0tLX6XJKdRDmSS
 BP1ayAyKvYg07eq1MwsrogdhaKj5heLOZaVOXElWs/lXFmmY35sfydiXWURcdBB7jI7s
 iVO4QmTwkUw2wWJiFvuTTaWfxOXoVJ4QVB/HcvLKFFKtVuD2j2C7D2VJyxFn6rTalTTI
 OO4A==
X-Gm-Message-State: AOJu0YxMZGpD6Bl0iEMa3OzJTVNnHAZQIKzwEKzEnlunZUS+YnJoAqZr
 fdYeNjV05p6PwKYyDPvkIwdep4cRoxcyElsyWhc0K76PgeO/0lN1hAX6HgvO5jUZ9mh5QPpMNuO
 TaZq1A9o=
X-Gm-Gg: ASbGncvbdMGeq7z5K11AktTXbLUINGnLEvIl5tzxBpI2E2K+zGVHkbdSgWi5X8ioE8T
 Oz1CvrjasQQOJG4HSnGcZ6o34WRzCJsSjSn1DVgYGGYPbisiPMKpvOd+6QWsJTzJ6HJo2O0tZYN
 wu5jviYyI2Xt8HmGc1Q3DrQLQidKxqrIB8rSJXBTQ2Njw8MwFbEpvwc9ymLxKbQ8exbDgRPkH5k
 m0Z0N8bJEowmPTz8eo4RmMKbdO/5Dtbzc9g9uDKVML96n7Zw5+47Cws74Xr/st6t8lLI8Y0KJog
 J14udKLaS/DPsHbqlMIjGVIQsrDRmdz3A1D6Xr74X+Gb6C3FS7eoXRAikWyPJozwt7t6K8gP6Pe
 CxsZ3O2sdDdR5duBZW72k+D99QO07cStQRrXTF7BOoITI4qB9/B3+Vuxin0GMcS8=
X-Google-Smtp-Source: AGHT+IGYCHMlcdLpCIHU7YtXdLVfGzhZp/DY2K8Jqadpygd1hJJU1AUuOJPxa5RHtVR8vO3eo3A7Rg==
X-Received: by 2002:a05:6820:3093:b0:619:a34b:3e32 with SMTP id
 006d021491bc7-619a34b4375mr797315eaf.0.1754175943768; 
 Sat, 02 Aug 2025 16:05:43 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/95] linux-user: Move hwcap functions to ppc/elfload.c
Date: Sun,  3 Aug 2025 09:03:33 +1000
Message-ID: <20250802230459.412251-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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


