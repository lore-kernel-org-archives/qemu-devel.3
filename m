Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A38AC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRG-0001hD-Hf; Tue, 29 Jul 2025 20:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF5-0001Qy-54
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF1-00040b-Dq
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so431349b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833618; x=1754438418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcXMnoM8855Ab0a5FsBNiJYSLFuOESZ80c0GBEOmfs0=;
 b=i8sxDOdIjOL5v7gq+O7M5ZcdNgLbKA2H0ZQawVseDSG/MfCbS60BshjR1r5Pu/8qDX
 VYd/d4of3sZ7meKA6+7KYyEO00iq4fqBB7zsp4DLFEXKmB/xDQs0PvfmtCde8Zom0seP
 Zvk2p5Qktrh9bMfArMnalMCxWGMGzd+uzllFbbKhlNWkhFk97tFC5tzUiziIehGBf9Ze
 fuDyQcxJiI8e4jgcxtYnzU5taiJe+KiUxl76fEWkQPG1YPdW03iDbnKHWgfJR9tX/tRO
 AQZsjT5cMciSKFma1OBcLmjFR0YzmAP1ZRfIA1MgW1sQBkQuCQeFtGgrlD3srn1WcJgB
 zSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833618; x=1754438418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcXMnoM8855Ab0a5FsBNiJYSLFuOESZ80c0GBEOmfs0=;
 b=uEh8FMe1p9oSl+3qpk2SY70QdUEHPXJZ+EJDZVCkojC6LRq6saGcSI99thbAWXudci
 Hi2Qq5b27R/nn5sAlwJmgibSu5eoL3vGe7nWUPJgjiZO4IeK5SkDTabmS9/oY1Kf1+JW
 JYNhexZ8Damrp7aAHVnhlNK5n9GR4z9slCPX5xnYlsvYP0b2agTfZ8cPgwP6hKuwr4sn
 3adUI4X7x7noNCTNufVor85x0+gceUaK6jQ85dofR8CDBSPLGoPO9fTBZKl4+Ta6p4sx
 YJ/sPwdRLgJKER3bDg/iZZYNYBz5E873Z32K20FK6z0vqRzWExPegdOaAdtleyV3TMjV
 TgAg==
X-Gm-Message-State: AOJu0YxZvTtxHvybCnq4LPcZ+BL5+6Rn9yXc2AOWmRn/895MxMmUKkYF
 Zyd0l6Nla/GP41nsbEo4gAwpF1pouX2S3/kowKMmyesvm5TSAl7ppTQOCR8kYMqwHYvcNhVC7Be
 DDJwc
X-Gm-Gg: ASbGnctWthFqzcE90NfahePSH4oufpaFj+0jRR5Rw85z0Qqd3AaBjcq9dkSADVIu8eL
 vAWDtwRyEmNUsTylXiq47iuzerfF+Dpx/eXRm7QUkhI4TbqhaQyNODsm/sBrqlpesWRbH6cbTUv
 BCVx/5iUFZRKokta+PntOE9vbIJfKURK5sgeUkcIC1CgovRzrlidx546Gdd6r9oKTG6lV9AfH85
 WwYZmi0gly4Nt1v0oCwvfg/HFt1gta7XO7zsrd6VHTPLA6JKLrhlVD4CXu/jKRxoNKGgApVnmz2
 qgRbOzmjLaSy3+v67i6BGLRPZzXU5FgwsZVo7l5sC8vL3JXP9p2MKTLxQhCfQ5z6z80Y3LV1wbK
 NtFAd1Y++ttkOeraKb2UbqZSsn6u8+Nin/W8WECrSUnl76la5+9Mw17308Z4GWZCpvZDMlPc1Ez
 UtUNIF8IfN8w==
X-Google-Smtp-Source: AGHT+IG5WJJoSwuaaYFe8mfI45vXtIpw19bjwbck1VwzxN18hXP9UEpR25WmH6UHaQVJwN3XeJu8Xg==
X-Received: by 2002:a05:6a00:22ca:b0:742:ae7e:7da1 with SMTP id
 d2e1a72fcca58-76ab3643b0fmr1959308b3a.0.1753833617586; 
 Tue, 29 Jul 2025 17:00:17 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/89] linux-user: Move get_elf_hwcap to mips/elfload.c
Date: Tue, 29 Jul 2025 13:58:40 -1000
Message-ID: <20250730000003.599084-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 linux-user/loader.h       |  2 +-
 linux-user/elfload.c      | 52 +-----------------------------------
 linux-user/mips/elfload.c | 55 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 786482e68a..0544ab3398 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -100,7 +100,7 @@ extern unsigned long guest_stack_size;
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f173a4f5b8..c6d42afde7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -844,57 +844,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
-/* See arch/mips/include/uapi/asm/hwcap.h.  */
-enum {
-    HWCAP_MIPS_R6           = (1 << 0),
-    HWCAP_MIPS_MSA          = (1 << 1),
-    HWCAP_MIPS_CRC32        = (1 << 2),
-    HWCAP_MIPS_MIPS16       = (1 << 3),
-    HWCAP_MIPS_MDMX         = (1 << 4),
-    HWCAP_MIPS_MIPS3D       = (1 << 5),
-    HWCAP_MIPS_SMARTMIPS    = (1 << 6),
-    HWCAP_MIPS_DSP          = (1 << 7),
-    HWCAP_MIPS_DSP2         = (1 << 8),
-    HWCAP_MIPS_DSP3         = (1 << 9),
-    HWCAP_MIPS_MIPS16E2     = (1 << 10),
-    HWCAP_LOONGSON_MMI      = (1 << 11),
-    HWCAP_LOONGSON_EXT      = (1 << 12),
-    HWCAP_LOONGSON_EXT2     = (1 << 13),
-    HWCAP_LOONGSON_CPUCFG   = (1 << 14),
-};
-
-#define ELF_HWCAP get_elf_hwcap()
-
-#define GET_FEATURE_INSN(_flag, _hwcap) \
-    do { if (cpu->env.insn_flags & (_flag)) { hwcaps |= _hwcap; } } while (0)
-
-#define GET_FEATURE_REG_SET(_reg, _mask, _hwcap) \
-    do { if (cpu->env._reg & (_mask)) { hwcaps |= _hwcap; } } while (0)
-
-#define GET_FEATURE_REG_EQU(_reg, _start, _length, _val, _hwcap) \
-    do { \
-        if (extract32(cpu->env._reg, (_start), (_length)) == (_val)) { \
-            hwcaps |= _hwcap; \
-        } \
-    } while (0)
-
-static uint32_t get_elf_hwcap(void)
-{
-    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
-
-    GET_FEATURE_REG_EQU(CP0_Config0, CP0C0_AR, CP0C0_AR_LENGTH,
-                        2, HWCAP_MIPS_R6);
-    GET_FEATURE_REG_SET(CP0_Config3, 1 << CP0C3_MSAP, HWCAP_MIPS_MSA);
-    GET_FEATURE_INSN(ASE_LMMI, HWCAP_LOONGSON_MMI);
-    GET_FEATURE_INSN(ASE_LEXT, HWCAP_LOONGSON_EXT);
-
-    return hwcaps;
-}
-
-#undef GET_FEATURE_REG_EQU
-#undef GET_FEATURE_REG_SET
-#undef GET_FEATURE_INSN
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 #endif /* TARGET_MIPS */
 
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 73fa78ef14..07c30b5f4c 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -1 +1,56 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+/* See arch/mips/include/uapi/asm/hwcap.h.  */
+enum {
+    HWCAP_MIPS_R6           = (1 << 0),
+    HWCAP_MIPS_MSA          = (1 << 1),
+    HWCAP_MIPS_CRC32        = (1 << 2),
+    HWCAP_MIPS_MIPS16       = (1 << 3),
+    HWCAP_MIPS_MDMX         = (1 << 4),
+    HWCAP_MIPS_MIPS3D       = (1 << 5),
+    HWCAP_MIPS_SMARTMIPS    = (1 << 6),
+    HWCAP_MIPS_DSP          = (1 << 7),
+    HWCAP_MIPS_DSP2         = (1 << 8),
+    HWCAP_MIPS_DSP3         = (1 << 9),
+    HWCAP_MIPS_MIPS16E2     = (1 << 10),
+    HWCAP_LOONGSON_MMI      = (1 << 11),
+    HWCAP_LOONGSON_EXT      = (1 << 12),
+    HWCAP_LOONGSON_EXT2     = (1 << 13),
+    HWCAP_LOONGSON_CPUCFG   = (1 << 14),
+};
+
+#define GET_FEATURE_INSN(_flag, _hwcap) \
+    do { if (cpu->env.insn_flags & (_flag)) { hwcaps |= _hwcap; } } while (0)
+
+#define GET_FEATURE_REG_SET(_reg, _mask, _hwcap) \
+    do { if (cpu->env._reg & (_mask)) { hwcaps |= _hwcap; } } while (0)
+
+#define GET_FEATURE_REG_EQU(_reg, _start, _length, _val, _hwcap) \
+    do { \
+        if (extract32(cpu->env._reg, (_start), (_length)) == (_val)) { \
+            hwcaps |= _hwcap; \
+        } \
+    } while (0)
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+    abi_ulong hwcaps = 0;
+
+    GET_FEATURE_REG_EQU(CP0_Config0, CP0C0_AR, CP0C0_AR_LENGTH,
+                        2, HWCAP_MIPS_R6);
+    GET_FEATURE_REG_SET(CP0_Config3, 1 << CP0C3_MSAP, HWCAP_MIPS_MSA);
+    GET_FEATURE_INSN(ASE_LMMI, HWCAP_LOONGSON_MMI);
+    GET_FEATURE_INSN(ASE_LEXT, HWCAP_LOONGSON_EXT);
+
+    return hwcaps;
+}
+
+#undef GET_FEATURE_REG_EQU
+#undef GET_FEATURE_REG_SET
+#undef GET_FEATURE_INSN
-- 
2.43.0


