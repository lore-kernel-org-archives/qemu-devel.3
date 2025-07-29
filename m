Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E8CC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRI-0001j7-H5; Tue, 29 Jul 2025 20:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF6-0001TF-Hm
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF3-000416-TC
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso5543640b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833620; x=1754438420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tAy4LWos7CMMDi7rFBFr+ma/sLuxtrhncFZL3m8MVY8=;
 b=ohv0DgFYYjSA8p7qHvZL0PmS2pcfseuV7EC3j1b+csKd6KI5ZxQ4ieKzqm/DVrlu2w
 5HOJxEL0fQCuGE9YecQ4VDiGAsymYOufJDtX0vXuZw3fyEJAra+rQJO4DufHykN48BRy
 a8u2vrBbOHCiLG0w/kQ99/wtHtSYvrSBMisq8srexOl1jCBf2Gy4df3dQTn8wEyNS4fk
 YS3bryqFnKfNeZ5NSkFRczNQyt4jyW3k20Y3TE0QS1BP2aQ4iHZ5d6qO+G+VXzeyAyUh
 aYjhoj6qkvQU9co7eXq1b+mRjb1RFXFMVrprWkSr6P0k3W7Gt6v86+03YjWIRH4NsiZm
 Amjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833620; x=1754438420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAy4LWos7CMMDi7rFBFr+ma/sLuxtrhncFZL3m8MVY8=;
 b=BM0JzR2StSkL73Z0V/U0/R9vLIfNPTUxSCfKxAIzD4vNPlY5er1e5feVeOYyO0MPn7
 IT2HpAApSK1+WfRzcIu8oS6npBRv96YIcx3YlkFf/D66c43oixQ8KfBzHtWOKOmAtFns
 yKEiMJnNe8Qgk36LN4HLbm2tnoRu+FmZjtg9bN79HzNVJuX6OblZL+A1IFPXrYJxg0Mf
 cJ+uPc41OzzsYGGo4xb3XbdktVZkpEhBc9qNl/L5MKUyPeu/eTUS8NzV6EKeamSW4a1Y
 7LIc/Ws3EMEBB0IpMaoM6tvHpGVt1+2nq3KUsJ+izV96zLIldiEW4ZkfXRtupH2ybrn8
 BvwA==
X-Gm-Message-State: AOJu0YzPL8iwnJUQ+xinKobMNqEGMCqdlE+6HM2xDman7mRDJDDk6Jgr
 eOlsvCMh+RgxDv69AOmHYKBfu0Rs6EXLW+PMRjow0zVZv4imj5kL0EdHkSDKR9D1ZpzK0ShamBJ
 Jyick
X-Gm-Gg: ASbGncvkT/fH2+/L8C5WC9rRWEv7sFFq7EWmSfM3snUD4rj+sObW6MeTGz4pxMZUK1B
 FTQQvs1h22zUB9CE26DET95xvGwWR6btpl0gnrgM/JKHpLFHUkfZrMcUlnJ7PX0Ucpz6oyba0Iy
 SIZe8fqfvyMcxeAXp9Hx8sWmOHiVeZFh8kQtleFsM2NEwqVdmz9YfQX2eircsR5W74kWwULPLTa
 HGEC7jWBPIWbGLVyniEwT0ip5cYRmvdgaiZQOvbZWAFT/RBBK2h70/EakLSkpBczztpdQ48ly+J
 jDy+iNjvVgFQRY30k7Mwwxt5N/222xjQciLo6XUkfu0r3CagaO6uDF6Du4xnXH83enB1ClHoiEQ
 jJEeCli4fLRq3O0/h6RZz8ARL9xHQMPORAQozIQxX310AgLL9Phpzg/87wVoZWJGr3pgTSllIdC
 BiPUoIhj3RJ4g/l7wUwwzP
X-Google-Smtp-Source: AGHT+IEwu0eWkNkO7jEaS6wWkYdQ1f+vvYX3s8nCb4UCDKd5ziJl3UjQN8SNCttIBVYwmjBbOdokQQ==
X-Received: by 2002:a05:6a00:288a:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-76ab2b576aemr1636367b3a.14.1753833619542; 
 Tue, 29 Jul 2025 17:00:19 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/89] linux-user: Move get_elf_hwcap to sh4/elfload.c
Date: Tue, 29 Jul 2025 13:58:41 -1000
Message-ID: <20250730000003.599084-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/loader.h      |  3 ++-
 linux-user/elfload.c     | 29 +----------------------------
 linux-user/sh4/elfload.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 0544ab3398..cfb474e257 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -100,7 +100,8 @@ extern unsigned long guest_stack_size;
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS) \
+    || defined(TARGET_SH4)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c6d42afde7..1e855713b6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -973,34 +973,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-enum {
-    SH_CPU_HAS_FPU            = 0x0001, /* Hardware FPU support */
-    SH_CPU_HAS_P2_FLUSH_BUG   = 0x0002, /* Need to flush the cache in P2 area */
-    SH_CPU_HAS_MMU_PAGE_ASSOC = 0x0004, /* SH3: TLB way selection bit support */
-    SH_CPU_HAS_DSP            = 0x0008, /* SH-DSP: DSP support */
-    SH_CPU_HAS_PERF_COUNTER   = 0x0010, /* Hardware performance counters */
-    SH_CPU_HAS_PTEA           = 0x0020, /* PTEA register */
-    SH_CPU_HAS_LLSC           = 0x0040, /* movli.l/movco.l */
-    SH_CPU_HAS_L2_CACHE       = 0x0080, /* Secondary cache / URAM */
-    SH_CPU_HAS_OP32           = 0x0100, /* 32-bit instruction support */
-    SH_CPU_HAS_PTEAEX         = 0x0200, /* PTE ASID Extension support */
-};
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    SuperHCPU *cpu = SUPERH_CPU(thread_cpu);
-    uint32_t hwcap = 0;
-
-    hwcap |= SH_CPU_HAS_FPU;
-
-    if (cpu->env.features & SH_FEATURE_SH4A) {
-        hwcap |= SH_CPU_HAS_LLSC;
-    }
-
-    return hwcap;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #endif
 
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
index 73fa78ef14..098ca44f80 100644
--- a/linux-user/sh4/elfload.c
+++ b/linux-user/sh4/elfload.c
@@ -1 +1,33 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+enum {
+    SH_CPU_HAS_FPU            = 0x0001, /* Hardware FPU support */
+    SH_CPU_HAS_P2_FLUSH_BUG   = 0x0002, /* Need to flush the cache in P2 area */
+    SH_CPU_HAS_MMU_PAGE_ASSOC = 0x0004, /* SH3: TLB way selection bit support */
+    SH_CPU_HAS_DSP            = 0x0008, /* SH-DSP: DSP support */
+    SH_CPU_HAS_PERF_COUNTER   = 0x0010, /* Hardware performance counters */
+    SH_CPU_HAS_PTEA           = 0x0020, /* PTEA register */
+    SH_CPU_HAS_LLSC           = 0x0040, /* movli.l/movco.l */
+    SH_CPU_HAS_L2_CACHE       = 0x0080, /* Secondary cache / URAM */
+    SH_CPU_HAS_OP32           = 0x0100, /* 32-bit instruction support */
+    SH_CPU_HAS_PTEAEX         = 0x0200, /* PTE ASID Extension support */
+};
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+    abi_ulong hwcap = 0;
+
+    hwcap |= SH_CPU_HAS_FPU;
+
+    if (cpu->env.features & SH_FEATURE_SH4A) {
+        hwcap |= SH_CPU_HAS_LLSC;
+    }
+
+    return hwcap;
+}
-- 
2.43.0


