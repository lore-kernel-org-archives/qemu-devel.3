Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67651C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguR9-0001a5-Iq; Tue, 29 Jul 2025 20:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF1-0001MF-IW
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEy-0003zu-8W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7600271f3e9so395818b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833615; x=1754438415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KK0MFTf+PrVtNntZlwBJtPx6XUJHay93y6cPNjvRi4k=;
 b=weV404GtMwtg7VPg3gpd+KtXILhLX8kyWZpiX7m84qtULKFhN6zKCkQavNJaYD/XRm
 IOBmE9qoLNtZ0AODMmQof1fM9W4D9NSfpFl2zOLTAUTc2ob50lIVYOStYvleKFnc6DVY
 TYcc7Z6BKLvu98DUT+4Q7BA7ef6PvSXmZbj0PZTtOXpAyt+rDiS3jtCrre2rzai+OfEJ
 Wg5Ft4ONWXZgqFWsp9HYhBR31F1C1f/jniwvJnK5Erlf0psqER5sN90eV3v2zvCzQ5/5
 BP9+jlSi1F/1XhBcL+LCal4g2XnAbU6O0p40084EjFTgDf9s0wdGl9Oszhbvh1NzaByE
 LIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833615; x=1754438415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KK0MFTf+PrVtNntZlwBJtPx6XUJHay93y6cPNjvRi4k=;
 b=G15V7K2Uxy94ONrzfsRD3svrCO9ReI+i4mk/RtDMhgbiBxqi5lhr4zilJg1J+b2iaS
 mvHXXulKdxvbw5wVRKSBXyxdledtRPh5PRiqlnWkQo6cfkpL2ZYwn2lTWyBzSX8A4G5K
 9KxQ0W0gglZzhO/074Mrmd6eC35yU8ZZnCQHiHACbYe79YwKuaPPbz6IMn/mOr0vNQVo
 14jClVSAzXzmCovjKFT7pcSkZ2H7bRCiyCoZdBXDwHmgKd8gl2nfLMBQf4mJgVc15dWW
 uBjPYaaGbjWtGVXR2vi6Cun5DACyJNwX4NGRp62J72Miy41WdC/hdfY3GDeZNivyFTVp
 ZoaA==
X-Gm-Message-State: AOJu0YxJyQF+CkYE8KXF+a3G+bwmJeznzFE+vpRGWI0XW8eba4zufjzk
 N2IKN8y5RXKTPj+lTaHty2TnY4IUyYBaAf9ojnFG5P4yzZYU2SThKsebzbRSdQIZbxtjv3BAiXp
 Vdgbh
X-Gm-Gg: ASbGnctEB8s99QzDXifUe/8/lXIWmrhPiM8ODaoV5VrMkbTkSO7NPQysSw32OO4WZXt
 z1xIdlbUA1e1G3s5qIGlMu8uvtopFgcPDMUYfF7FAkvu69u9OR7K1VNSbSqN+sb86NpjAorEzEt
 lZdn7k9a1PrcjbE9d9coFN5Aj1gNKLqaU45u/6e+FhyWG3TURp5HP1W36gjtdA3z8N+bNzeOxGJ
 yjPCi46NDz8zrIxsQpm+3LECdGrLqVSwQuK2kYwsjGjx+FM3EdLsDyLtLqRTeYa563EgG8OSQWC
 FMS1lzhzkwN8md6BUMHN6fiiz2++LEpZTdtTvx+jEzvkRYTQ0+fuUuTK7KPT09XLhvtRnyaCVrp
 6nYCVgipM7Bnp1wMZJzZ88qkLchCCZo+YtWMeHNhVgi22gmm6ib1430mrzAM7IGkxCmEjBUPjLF
 w672dEipFEgPEQGy+l8b0y
X-Google-Smtp-Source: AGHT+IERxMphqVvr1ftASMYdIuSlQYZB0LmbRiApdJLFxGp91A5VkpAxJyBHJs57lKNBlDtr92Ckuw==
X-Received: by 2002:a05:6a00:4654:b0:744:a240:fb1b with SMTP id
 d2e1a72fcca58-76ab6a50c14mr1996187b3a.5.1753833613038; 
 Tue, 29 Jul 2025 17:00:13 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/89] linux-user: Move get_elf_hwcap to sparc/elfload.c
Date: Tue, 29 Jul 2025 13:58:37 -1000
Message-ID: <20250730000003.599084-5-richard.henderson@linaro.org>
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
 linux-user/loader.h        |  3 ++-
 linux-user/elfload.c       | 30 +-----------------------------
 linux-user/sparc/elfload.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index be92207c2b..d2f0bea2b2 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -98,7 +98,8 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM)
+#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
+    || defined(TARGET_SPARC)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3a4f68f503..220af18cb8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -575,35 +575,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#include "elf.h"
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    /* There are not many sparc32 hwcap bits -- we have all of them. */
-    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
-                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
-
-#ifdef TARGET_SPARC64
-    CPUSPARCState *env = cpu_env(thread_cpu);
-    uint32_t features = env->def.features;
-
-    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
-    /* 32x32 multiply and divide are efficient. */
-    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
-    /* We don't have an internal feature bit for this. */
-    r |= HWCAP_SPARC_POPC;
-    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
-    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
-    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
-    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
-    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
-    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
-#endif
-
-    return r;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 73fa78ef14..b4b8e4916e 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -1 +1,33 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+#include "elf.h"
+
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /* There are not many sparc32 hwcap bits -- we have all of them. */
+    abi_ulong r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
+                  HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
+
+#ifdef TARGET_SPARC64
+    CPUSPARCState *env = cpu_env(cs);
+    uint32_t features = env->def.features;
+
+    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
+    /* 32x32 multiply and divide are efficient. */
+    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
+    /* We don't have an internal feature bit for this. */
+    r |= HWCAP_SPARC_POPC;
+    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
+    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
+    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
+    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
+#endif
+
+    return r;
+}
-- 
2.43.0


