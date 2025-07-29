Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F43C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRZ-000219-QC; Tue, 29 Jul 2025 20:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF9-0001YS-1V
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF6-000420-QB
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-75001b1bd76so3987310b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833623; x=1754438423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b7s39CkWlMMx+G9GkxkJyc453mYEb7PcnvWNR7lcKKk=;
 b=e3azRwWZe47qsk1TEg2Hx9AC1Nc/QOysMxSdLr5PG3bv1AXsmjK2xAJBkKYZSvJNAa
 Lf0S06jhi5ppZAZkWr7MLu0u7bvvi3GLXUMql35vvKN45+JGFMaJcgIeFGiEOkGI71bV
 WTtELP9Q5dIpEF4QDGwmxP/uWbfffdsW2r5ZZxbGYvdRLfxK9bgteHNlqTxGO7lC4crL
 cTOT8Q5PyWSjNU3rv18bgujg4Mb7svnkFqUTiAwn98DPrF4jKmwbNaEMLZBmweJawuyi
 rhvMjnUmj0aCrS4Y9z7wwhWRltVIMA2JylswEmSsk9NwjlVAawlOb7W0BrpVs8tOWlNI
 G+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833623; x=1754438423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7s39CkWlMMx+G9GkxkJyc453mYEb7PcnvWNR7lcKKk=;
 b=p37LrYWuNCsR/LiiM/wZ9xegUeHpxBJwKdQVma86ZSwMxZWMGy/JoyZy4CdSQV9r7+
 I/b7U9LKygKyaM+Ir2BSJdwYQuBQNGqYLIOP6oZLVSkyVtvmLzigJQHgN0C4N26/drMb
 6x6r6vQCJrzk7UrVtBFyiWt/fmfD/XXZmK/W1aVhMCPNq/+kBzSFJ5lsNKdjQNA2G15f
 AO7p3CZQNZ+bQ5+WruPltoM2pr+0PEQK0nc0q6L1nHlNRotYpgKEPRwI3a8S0GDTJHQm
 X/KUsLTkH6CG1v3WWJWDnHPFKnLzIKgqQN/IuDbJ6hDROjc9uvJpGvCXZ8UNtYvAZ3BT
 rVDA==
X-Gm-Message-State: AOJu0YwKzK+mrcf2bGSCdEvKQJBRLwEnjJD+4KO0Sc0DjPJWnZGj6gRX
 v7UPDA5pmUdHYs0Vve3ss7e5v3Wmj1xGG1ljpADkPTE7oC55PTtg4oMXRTf/G2D2ZWgjeFOx3EL
 E0FaF
X-Gm-Gg: ASbGncsI8x8HhDPJSs7+LJff6lxoxHIRwMZ1CM0CdyBuTuGiH3nxXNLFBMndb3LhFOp
 hMtLLs8s8z94H+oJK6kAQlhP65CHhRRUPuEAgcRF4JcADpMF9AkIedylgjOdRsKGKV69MAW29SS
 IfEzebbYAJA2g4o8FWDa3XbdSQXYyOzU0ugyAsZrHY6fXNwzGTv2ijBBsUSc2HacSn1vi1wDbdf
 fP6PyhuM1flV59clIn5HVmhgRF+yOgTjmPNBlLI2ylHnwzPEL3f4+YXs5G58jPOyBNwxYSEZVfA
 R/pjDR4ThJDvXOLVXPE5RKJbyuzJ6n1SqZPNM/WoSp6rKBe2jqJE2JP6r1N3yPrwRsdRD7erXV9
 KNA0zSjxoI0IJ/tURJfNMxC4d88ns1qpIPMnGc2MRkxK32Xtv1BJjSPhRk/khK2kGTzbXiepwfF
 PlqE7/O5Iegg==
X-Google-Smtp-Source: AGHT+IEAfU07LECVh+lQoE9kql+jYqqM8/EiYKOgunEq4ar7ybJRpD5Tvh2Fwry28TlUcl7Sqe36sQ==
X-Received: by 2002:a05:6a00:21c5:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-76ab1611ca0mr1896383b3a.9.1753833623081; 
 Tue, 29 Jul 2025 17:00:23 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/89] linux-user: Move get_elf_hwcap to riscv/elfload.c
Date: Tue, 29 Jul 2025 13:58:43 -1000
Message-ID: <20250730000003.599084-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
As this is the last instance of get_elf_hwcap to be converted,
remove the ifdef around the declaration in loader.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h        |  5 -----
 linux-user/elfload.c       | 14 +-------------
 linux-user/riscv/elfload.c | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 72eb3e68cb..484d20aecd 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -98,13 +98,8 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS) \
-    || defined(TARGET_SH4) || defined(TARGET_S390X)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
-#endif
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8d4429242f..cd83307750 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1109,19 +1109,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-#define MISA_BIT(EXT) (1 << (EXT - 'A'))
-    RISCVCPU *cpu = RISCV_CPU(thread_cpu);
-    uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
-                    | MISA_BIT('V');
-
-    return cpu->env.misa_ext & mask;
-#undef MISA_BIT
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index 73fa78ef14..4e2ec3df5b 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -1 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+#define MISA_BIT(EXT) (1 << (EXT - 'A'))
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
+
+    return cpu->env.misa_ext & mask;
+#undef MISA_BIT
+}
-- 
2.43.0


