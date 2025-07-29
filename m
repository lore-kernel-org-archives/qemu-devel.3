Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D6EC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRA-0001bF-Ty; Tue, 29 Jul 2025 20:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF1-0001MG-Ii
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEx-0003zr-Tx
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3a1so3619849b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833614; x=1754438414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qDwAhn1y64UvWd8oXhTDOOr80IEy8W5OXfYifq7jEVQ=;
 b=GvnGL+XLfuSu5ISlkAIy7fiIFS+WCpDroLZ4ktZi3+5hcdXX7il5b3IFWGbhHpa7Qh
 mghtGqJ5Y9nxnwLyIjQIwA0pEbL6mr56OqDS8hR3tD1NdO8E6IOuCFziTFhyNQ5cDJCH
 I9qNYRK1nY1T815Ij2tZujMTsWWCaeGntL7GFAwiNtgz2TX1tYLAkrz3Ll8QeRC3vlAK
 KanqQqXyXbxWuC3gUi2KRhz66vZ9FN6cm91/z7BIvOZdJnx/a69kbcvEtJUA+0h5dSjj
 sf6At8GG3QP/twO1ozy+QMIH0FrdTE9oEz8v5yzsbaRloC3kwOl6rnWlkvVts4RAcoDE
 id2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833614; x=1754438414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDwAhn1y64UvWd8oXhTDOOr80IEy8W5OXfYifq7jEVQ=;
 b=aCqI5H5XaprQ/5KnzE/ALumei295k2zNsM7ZSoSM7q9Hyi4w/qidL2Oa4ME6JVGNbB
 0dhiejG1d9yiV1aaZ74BJqxV38edd1L335QqPHn2Hj0G30D+FnbzxaAWkr+VsL0tOyHW
 zFZjxn9dGUA7D1fAMSfDzO/qF3kSWxAQ2nSXvO+DL3hHeUp7kSGd18O4yxnwdDS3rf6N
 WB126UT/k8UDHXBOytEu8wUoFfALGj0Az4EDs6dtLxQTo1YQ4s3A4a/ZgH5zLle2swiF
 zJByPogdqhGifRahVghaxTAgcGihRihnb8aKu1yvjF2defQXUqOz93uTCT+FaqpATz9t
 O/hg==
X-Gm-Message-State: AOJu0Yw/deF+z8wQusJh6/ew3701TraAL01XvNJHbHmwW8FIOSB8/tzx
 XM3uC8oJrOx0GbR2Olwb9WtHx8MjtFOxB6BOtSfn74BLgUjRRjRDDLCSPhYyIj2agT4qaMsq50+
 X14D9
X-Gm-Gg: ASbGncscVJU3WXBEjHHemAC9aYdqkrtwY5jUFzKxi8yHwNRb+6d3DijFIdf/ZykLRbH
 RbBnAuGmlDLthDQILVKiafo3wcKCmprDedGxDyur3j+P62gNRnyrUi6MVoDc197O735MAEA84oW
 x6zxxo+QMf7JivYuMJt1UICS/uEtl2NEgMU7xC4UxrznrUzo15RtNowugIwywflcaxG6++2BvM1
 UFfJ+0YPgP54ewITIJYkyAJ+tkNNMYMp6G8b0rd9vyEVC8VG45MoV4mU8zuyA/a9PMiBY6gHQnt
 0JX7Zg6qMgBNFsDkt7cgPjmp6agvk4qZnI/BlGQQEXGOPAjPRY9UwWMwLbAN6c8wwDWi/FaI+pF
 o6qnFNaJ49296pcDZDJRn/xvIVYI0510dV2KIFnxpodMhWNaI5p4tFX+qouKeyWng2p6uUEYgQi
 zPSoWhjgPDLRq5ddrqLNDu
X-Google-Smtp-Source: AGHT+IGfvPV3cVg4x6jTwvm+KqBmiXzKQeOxwpZUHW1lhS/fNYjlOGUWinA+BRuwg8Bo8ZAhMPlryg==
X-Received: by 2002:a05:6a00:2443:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-76ab1612400mr2030601b3a.7.1753833614342; 
 Tue, 29 Jul 2025 17:00:14 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/89] linux-user: Move hwcap functions to ppc/elfload.c
Date: Tue, 29 Jul 2025 13:58:38 -1000
Message-ID: <20250730000003.599084-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h      |   2 +-
 linux-user/elfload.c     | 116 +------------------------------------
 linux-user/ppc/elfload.c | 121 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 115 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index d2f0bea2b2..781bf89e88 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -99,7 +99,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 extern unsigned long guest_stack_size;
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC)
+    || defined(TARGET_SPARC) || defined(TARGET_PPC)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 220af18cb8..32cf2db718 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -608,120 +608,8 @@ static inline void init_thread(struct target_pt_regs *regs,
 
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
index 73fa78ef14..3b2dcdfc47 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -1 +1,122 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
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


