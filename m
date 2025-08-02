Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D8BC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLIb-0000ty-Js; Sat, 02 Aug 2025 19:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIY-0000qC-Oq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:54 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIW-00016C-PC
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:54 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741a905439eso346084a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175951; x=1754780751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7W5Ve4shqEohSxRVdKPBvK3hz0rWOcEpZ6oE5AgP894=;
 b=i/asx9TudzOz1/5ZpGPTIl5PXsvTNcmSUjZ7xqZ7lcWYMWgbqe1qPsinBgWl/5oTAV
 Mi9X+g8IktVkrKXjheUNQlWCTlTesCfgIbgoT0Q4pvj4MI4D9ZU/LWrlOHSoCYha89w3
 NyGliY60FRZZYu2ISH9TLgv8xHkQgSa2Xk2TXh9NaEg5sD+kGm8r0qv+PVYKsIUHknAm
 OvRDJD0br1goZOydjWO0wapob2FIHi4dQmeVMF0zRr6MWXP1+TUeXAS4EFqb3TGbuADf
 cglF3e50YmVELpDjZ7EudazCydOJpiMMIeNt5C8MxY6b/ZMEhjWD/2AmDH/Mc9LyGneM
 0JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175951; x=1754780751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7W5Ve4shqEohSxRVdKPBvK3hz0rWOcEpZ6oE5AgP894=;
 b=UVDRFqgZZypwQUS69igFSa9ja726Ubt0UtSPsIHv8/2QC7+ypUcig8k1Xhp1VIBHVh
 mcOso9QUrF2vXtLtTdJwxF9U+OEVYauKuGjS9iTFJ/5djd1RpxQ99O/6fZpBL03OomFj
 IaHpe8q6zWzYtpGti1XhHwC2GfPpGCtsVF/pOWrRbOzOJShbPxS9qIB7N4rX2ow16qSx
 wRltmTRPKpC2NsAeMNP6gF5zct+UC0VFZDTMoQfsSNvzYgIwG7GCqd2lzGO0Kc+N7rZ3
 Q4sYj5TDTbSpacihVZZAWSX26MHwp5DYsaNniMBnejgChH+DqzOqo/o4n6tOSVYuD6d5
 J7wA==
X-Gm-Message-State: AOJu0YyVmAKIwjW93cg8af/UYthgCCFQ8fKMl1zjaVw27UH0UwN9kdlV
 gQU9q9l8q+OtXxTr9xX1/GChse8Psj15vxnkKupqo0Xv0lyir6xgkofy10BS9IHResPAQ/e/Gta
 xnkPC/mk=
X-Gm-Gg: ASbGncuvVhbMSqCp4eGLHUG4ea/8aX0c2bL2eHH5swYFvgdaJhI/HsQ5HXkqpQN45dL
 VScENVvm236Cxn9Cu2fHlYsE582sCNE85GbSEZmruNM7rLYogx2M4Lyui6N67z3drX18d/HbgSw
 txlVOUZn7NghpOg8XUf7aOecgeUhG2JjnEaWnA4pDvpwcWvvKanenLRTLhtd+RG4JxesFQ0Ibkt
 5R1+fe4dDh/nek9IcLNII8s6dOvf6DTMIxqieklPC1xZKeP/S5+QEh7SuFv+Toz6FusQefjwaWy
 W7ucVDJbiVBrSHnJVJF7mF2+yByp2Gs2IQtHMvquMk47d2H8bVCZtQmLL+jwtCL7PWASoLr3Zar
 zuiLNyE3YIxPp0KiklPrIpmrfzkvTXZHFqBmpg1QpSubEMetC2DHe
X-Google-Smtp-Source: AGHT+IEjMqsOyYkBh0lRAPi9VXyNFpRMHq/RcHeYA3aYoSZrLI6P0SnRabErqVEPWpHs2ap/hiiAVA==
X-Received: by 2002:a05:6820:f01:b0:619:2ef:be06 with SMTP id
 006d021491bc7-6198f2d7d20mr2745784eaf.6.1754175951392; 
 Sat, 02 Aug 2025 16:05:51 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/95] linux-user: Move get_elf_hwcap to mips/elfload.c
Date: Sun,  3 Aug 2025 09:03:35 +1000
Message-ID: <20250802230459.412251-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
 linux-user/loader.h            |  2 +-
 linux-user/mips/target_elf.h   |  2 ++
 linux-user/mips64/target_elf.h |  2 ++
 linux-user/elfload.c           | 52 +---------------------------------
 linux-user/mips/elfload.c      | 50 ++++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 92b6d41145..04457737dd 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -103,7 +103,7 @@ const char *get_elf_cpu_model(uint32_t eflags);
 
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64)
+    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index febf710c7a..877f8347d7 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 02e6d14840..c0347e5cb6 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 574b37a22c..dc3f502277 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -834,57 +834,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
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
index 04e3b76740..739f71c21b 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -42,3 +42,53 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "24Kf";
 #endif
 }
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


