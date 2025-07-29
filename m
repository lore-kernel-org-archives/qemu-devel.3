Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D0DC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRM-0001mz-FS; Tue, 29 Jul 2025 20:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF7-0001Uh-3W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF4-00041H-QS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso5505547b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833621; x=1754438421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z14+ncrrtBacm1BII08CHh5DW5WRhwfvgysAfiPyqfs=;
 b=mwsjqsJhf4U40LB4TATKIr6bCuodJmPf/vgL+RPtXHnZS9DO/b0gyEk4kDTxCB9B6J
 1rHyNexJSsrm21lULuF7RZg19Rg8APETEQ6h3oKcFk4+0Gcer5qJDA6HtlGODPtxPqUX
 RYsnefMiDQ33bUpV1wJRtFbBKxJHWXHJLYzrWerLqqiPxsgNTXZCja4LuH8E4UCM9zY1
 chvgdkDdilGBEnwzV30/epY/40ZQ94qUAHc0mFStjqhWpGy+gZsY7/CfcmiqHazyS18+
 xmdI+kBqGC947PsFdVmSq9J+gM/GNcX6pubnVkhy96Zsu23xSCvnXGKbcwi4qHOsTtS+
 /CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833621; x=1754438421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z14+ncrrtBacm1BII08CHh5DW5WRhwfvgysAfiPyqfs=;
 b=gd7nOWW4k8CHvpfufjJca/2T+BJVYyRocJmurIgnEcWRVcsOIJtSHLrgAyvnQWQRJW
 TzRCvp61dqiXPNsN4otwvozMQdr8z4pwgFgbwDUisgaxDdpQ/gwZdId09UH3Bh+lbSxt
 lPDF7yCfLbKhWeeKm+aRJjzfem8FWBVXEocuCvwEKjYIPlbdofiAxkCRhY94ZDGH4A92
 mW49bn0GApFmvEqxLaFlpq75IJtiyl9WPWSWYURulSyitRGcLCFUuOHg0s+Aziy12VPo
 frjjwGwqd1SjNbU7kT6+FHjNps5q2xtydS1RbYIkuGcpjeGoX5caVXBiGrJuHXdvj4lx
 xpcA==
X-Gm-Message-State: AOJu0Yzh+XLW10mHMGi4REk0GKXzTJmeQeKYxNCzZBznM2DE9vHN56S7
 8gU8EQUTicGXHuzSYmiR3wMOcYsq0aXKsodifOrwYTaDlyERKocQCa0I4sZdJi0OQvjsuW2RXh9
 1sD+I
X-Gm-Gg: ASbGncvovsQFwx2rUF2WN6cTa922ouvrIWACXkAkjwrZxKU3YGc0SQlNL2szipZAv/G
 35R2kdh7uFz1w94IztHUz8dcG3R3Lk+c3DcZb8sF+fUgxiNcWRKHiVJfDk0A7rbo0n6harAwmFq
 0uQOiDhSTzvQDkg9UQ8O/v40yJwmgM7hCyLVD11fqDkJS5P3AO1GZk5rTc2ieGAcGVHmkVx+Xbr
 59fDBVTMH+pEeWNQMSlWqbOFQwzoM7KpL4OKxgrBR1Z0clnHe7hmjtOvbnjzS3wT72xG/JTpaGs
 njHU8DYT66tvQFD/KNomsnMRjngg6xyUeQ3WV9qU0Xl61zZhDXTV1cfJjrbfY9PIrmvDW74tJv6
 8mjHCxLhX35qaEYOqHTitlOH5ct+1zCaapdEjUL86YBHrlJ0vsw2Nc6vpjCv/fweMprp26+Nf8E
 BAUnIMuaLLZQ==
X-Google-Smtp-Source: AGHT+IFMINcsneEIBydrNsuxAhhSm6UiPbGma2UBLZq2Np70EPm+3nxpx0dcEnEfBs62CxKVOh+ijw==
X-Received: by 2002:a05:6a00:3912:b0:749:b41:2976 with SMTP id
 d2e1a72fcca58-76ab0a39280mr2127219b3a.3.1753833615805; 
 Tue, 29 Jul 2025 17:00:15 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/89] linux-user: Move get_elf_hwcap to loongarch64/elfload.c
Date: Tue, 29 Jul 2025 13:58:39 -1000
Message-ID: <20250730000003.599084-7-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h              |  3 +-
 linux-user/elfload.c             | 49 +-----------------------------
 linux-user/loongarch64/elfload.c | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 781bf89e88..786482e68a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -99,7 +99,8 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 extern unsigned long guest_stack_size;
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC) || defined(TARGET_PPC)
+    || defined(TARGET_SPARC) || defined(TARGET_PPC) \
+    || defined(TARGET_LOONGARCH64)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 32cf2db718..f173a4f5b8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -735,54 +735,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-#define ELF_HWCAP get_elf_hwcap()
-
-/* See arch/loongarch/include/uapi/asm/hwcap.h */
-enum {
-    HWCAP_LOONGARCH_CPUCFG   = (1 << 0),
-    HWCAP_LOONGARCH_LAM      = (1 << 1),
-    HWCAP_LOONGARCH_UAL      = (1 << 2),
-    HWCAP_LOONGARCH_FPU      = (1 << 3),
-    HWCAP_LOONGARCH_LSX      = (1 << 4),
-    HWCAP_LOONGARCH_LASX     = (1 << 5),
-    HWCAP_LOONGARCH_CRC32    = (1 << 6),
-    HWCAP_LOONGARCH_COMPLEX  = (1 << 7),
-    HWCAP_LOONGARCH_CRYPTO   = (1 << 8),
-    HWCAP_LOONGARCH_LVZ      = (1 << 9),
-    HWCAP_LOONGARCH_LBT_X86  = (1 << 10),
-    HWCAP_LOONGARCH_LBT_ARM  = (1 << 11),
-    HWCAP_LOONGARCH_LBT_MIPS = (1 << 12),
-};
-
-static uint32_t get_elf_hwcap(void)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
-
-    hwcaps |= HWCAP_LOONGARCH_CRC32;
-
-    if (FIELD_EX32(cpu->env.cpucfg[1], CPUCFG1, UAL)) {
-        hwcaps |= HWCAP_LOONGARCH_UAL;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, FP)) {
-        hwcaps |= HWCAP_LOONGARCH_FPU;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LAM)) {
-        hwcaps |= HWCAP_LOONGARCH_LAM;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
-        hwcaps |= HWCAP_LOONGARCH_LSX;
-    }
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
-        hwcaps |= HWCAP_LOONGARCH_LASX;
-    }
-
-    return hwcaps;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #define ELF_PLATFORM "loongarch"
 
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 73fa78ef14..f27992459b 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -1 +1,53 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+/* See arch/loongarch/include/uapi/asm/hwcap.h */
+enum {
+    HWCAP_LOONGARCH_CPUCFG   = (1 << 0),
+    HWCAP_LOONGARCH_LAM      = (1 << 1),
+    HWCAP_LOONGARCH_UAL      = (1 << 2),
+    HWCAP_LOONGARCH_FPU      = (1 << 3),
+    HWCAP_LOONGARCH_LSX      = (1 << 4),
+    HWCAP_LOONGARCH_LASX     = (1 << 5),
+    HWCAP_LOONGARCH_CRC32    = (1 << 6),
+    HWCAP_LOONGARCH_COMPLEX  = (1 << 7),
+    HWCAP_LOONGARCH_CRYPTO   = (1 << 8),
+    HWCAP_LOONGARCH_LVZ      = (1 << 9),
+    HWCAP_LOONGARCH_LBT_X86  = (1 << 10),
+    HWCAP_LOONGARCH_LBT_ARM  = (1 << 11),
+    HWCAP_LOONGARCH_LBT_MIPS = (1 << 12),
+};
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    abi_ulong hwcaps = 0;
+
+    hwcaps |= HWCAP_LOONGARCH_CRC32;
+
+    if (FIELD_EX32(cpu->env.cpucfg[1], CPUCFG1, UAL)) {
+        hwcaps |= HWCAP_LOONGARCH_UAL;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, FP)) {
+        hwcaps |= HWCAP_LOONGARCH_FPU;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LAM)) {
+        hwcaps |= HWCAP_LOONGARCH_LAM;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
+        hwcaps |= HWCAP_LOONGARCH_LSX;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
+        hwcaps |= HWCAP_LOONGARCH_LASX;
+    }
+
+    return hwcaps;
+}
-- 
2.43.0


