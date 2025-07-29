Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D841EC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguUN-0007wv-FV; Tue, 29 Jul 2025 20:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFM-0001qF-GK
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFK-00043v-J3
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so4139004b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833637; x=1754438437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/tPVEI49jG2JuqrRRDF07jSceaj3c6KI2BMJtYbzoc=;
 b=mHQ68F5zAFxxe4cLnwXrzNd+C2KJzzy9aWTdzu8Wz56e/xKPfKMTOvfbl1evZZ499Y
 PFxhofYD2C6vJyye/7InAnnOpA5L+feG52L7Yu8dz9pAxN9ajhWwXYGWvePbIabpncmi
 iO/6k0n2TeE9vDl8vcj/E/VwzI7N1ec9p1W6K4mWzRICO5UgTEyobvpcgdtcRSZ5FMJB
 LVhDxDh8HRHrPSbvorI+KgtlTpfbi/b1NrARfr3NbVrMnxL667RqMmx0N1od7iune7up
 EzpLvwFBm26mDjCwvc5jHvQ03i5I+MsVYA512FyBCjDCqCAS5QacDlLpQQvEvg8YnD2G
 myDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833637; x=1754438437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/tPVEI49jG2JuqrRRDF07jSceaj3c6KI2BMJtYbzoc=;
 b=jjO2tnrW9zecPKTPR1OqVnw2SelHi4yP9A6wndaCAhhnO9LIWl1IDFOzkj9EnIpcRi
 +pGHxzgW/u7giuxtYECJ+NDQQuIGo3uG7k5VvayCMLTjqqdKoby7EprGuRGVgZmZxQRy
 TEV6C9G1+7pqmMPJA/c9b0/P0nkxagw/JsYZKcv8rgqSI+agY085gPmSfheh5NAQk/1p
 L8zztOxfg1LJ77zpEDwBTIG9jADRal/aGdLvH3dKvodFv2+J4boAtloe9D0CHOdthmsG
 vIA/jv8Y8k8oYoxOCdIE5SYL4ESGVAQdSYxDCvSeOdv4+OGSpDhn/l+5X768VTaV6mwc
 w0FA==
X-Gm-Message-State: AOJu0Yw7INH9DLIauBDu2AWYiHcHNYlM6eooyLcx/X+DGA5useTp41NX
 PuBpUQueenuDBkQuzNt6emP/E3ezQ17vaH8DlgxaNVlC0MHObqFyjQqOYJJdhi59uJMkk4VBJJT
 sOL6P
X-Gm-Gg: ASbGnctmgrztvJPvLxONvyydLtquM68s7b4h3IXZB8K00ViZbXCcZwhQ7ZMSOXS6Qjn
 e+/e6bgr904YxnRB64hr17JQt3AeluJkruv6YqxQuSe7Fk/mUcV3I2Bh+Jz60AN4f3jNYHT8Hqk
 LKvtGeHkowH3xecr38na1wNpXovOLpSW8OtSOvonchSCY3jlsD/bJIXmsqAnyefaOF8It2mjU7l
 cPI1V0Wory8c6yLIM7XFpxK396xG55ItKGC3ELcQh84qNu1tkuwsn1ow9bXOMlxBBrvgRUuis60
 sTaBsDTXMM7knj3tEIE5RU0QiPujjV3aPj0cvVgR66L/4pZ+BpunPcEC8cBmOOxkWfe8x8hGSCd
 NiOvr012X2ET93Vz3OJKyM/ZTutC7ip4ot2/wTHazqA4ODQccBii6ySuOsv8E8O9mu7tS4Y+HNW
 9Hl5FXlN3lSA==
X-Google-Smtp-Source: AGHT+IGjUuJLhZwjj1bRlyCX3I9YeFhmbK7OuwaAsuAjtDMOM+XWF2GV7dJxcUoAAhfWjAGKuTYMog==
X-Received: by 2002:a05:6a00:2e0e:b0:749:4fd7:3513 with SMTP id
 d2e1a72fcca58-76ab3096e9dmr1656782b3a.16.1753833636715; 
 Tue, 29 Jul 2025 17:00:36 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/89] linux-user: Move get_elf_base_platform to mips/elfload.c
Date: Tue, 29 Jul 2025 13:58:52 -1000
Message-ID: <20250730000003.599084-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Pass in CPUState.  Since this was the only instance of ELF_BASE_PLATFORM,
go ahead provide a weak fallback for all other targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h       |  1 +
 linux-user/elfload.c      | 42 ++++++---------------------------------
 linux-user/mips/elfload.c | 30 ++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 1cc505832b..a5eef18eff 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -103,5 +103,6 @@ abi_ulong get_elf_hwcap2(CPUState *cs);
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
+const char *get_elf_base_platform(CPUState *cs);
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7e218e8cec..b26daf925d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -685,37 +685,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-#define ELF_BASE_PLATFORM get_elf_base_platform()
-
-#define MATCH_PLATFORM_INSN(_flags, _base_platform)      \
-    do { if ((cpu->env.insn_flags & (_flags)) == _flags) \
-    { return _base_platform; } } while (0)
-
-static const char *get_elf_base_platform(void)
-{
-    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
-
-    /* 64 bit ISAs goes first */
-    MATCH_PLATFORM_INSN(CPU_MIPS64R6, "mips64r6");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R5, "mips64r5");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R2, "mips64r2");
-    MATCH_PLATFORM_INSN(CPU_MIPS64R1, "mips64");
-    MATCH_PLATFORM_INSN(CPU_MIPS5, "mips5");
-    MATCH_PLATFORM_INSN(CPU_MIPS4, "mips4");
-    MATCH_PLATFORM_INSN(CPU_MIPS3, "mips3");
-
-    /* 32 bit ISAs */
-    MATCH_PLATFORM_INSN(CPU_MIPS32R6, "mips32r6");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R5, "mips32r5");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R2, "mips32r2");
-    MATCH_PLATFORM_INSN(CPU_MIPS32R1, "mips32");
-    MATCH_PLATFORM_INSN(CPU_MIPS2, "mips2");
-
-    /* Fallback */
-    return "mips";
-}
-#undef MATCH_PLATFORM_INSN
-
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1175,10 +1144,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif /* TARGET_HEXAGON */
 
-#ifndef ELF_BASE_PLATFORM
-#define ELF_BASE_PLATFORM (NULL)
-#endif
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
@@ -1234,6 +1199,11 @@ const char * __attribute__((weak)) get_elf_platform(CPUState *cs)
     return NULL;
 }
 
+const char * __attribute__((weak)) get_elf_base_platform(CPUState *cs)
+{
+    return NULL;
+}
+
 #include "elf.h"
 
 /* We must delay the following stanzas until after "elf.h". */
@@ -1687,7 +1657,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     u_base_platform = 0;
-    k_base_platform = ELF_BASE_PLATFORM;
+    k_base_platform = get_elf_base_platform(thread_cpu);
     if (k_base_platform) {
         size_t len = strlen(k_base_platform) + 1;
         if (STACK_GROWS_DOWN) {
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 07c30b5f4c..f2b132697e 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -54,3 +54,33 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 #undef GET_FEATURE_REG_EQU
 #undef GET_FEATURE_REG_SET
 #undef GET_FEATURE_INSN
+
+#define MATCH_PLATFORM_INSN(_flags, _base_platform)      \
+    do { if ((cpu->env.insn_flags & (_flags)) == _flags) \
+    { return _base_platform; } } while (0)
+
+const char *get_elf_base_platform(CPUState *cs)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+
+    /* 64 bit ISAs goes first */
+    MATCH_PLATFORM_INSN(CPU_MIPS64R6, "mips64r6");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R5, "mips64r5");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R2, "mips64r2");
+    MATCH_PLATFORM_INSN(CPU_MIPS64R1, "mips64");
+    MATCH_PLATFORM_INSN(CPU_MIPS5, "mips5");
+    MATCH_PLATFORM_INSN(CPU_MIPS4, "mips4");
+    MATCH_PLATFORM_INSN(CPU_MIPS3, "mips3");
+
+    /* 32 bit ISAs */
+    MATCH_PLATFORM_INSN(CPU_MIPS32R6, "mips32r6");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R5, "mips32r5");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R2, "mips32r2");
+    MATCH_PLATFORM_INSN(CPU_MIPS32R1, "mips32");
+    MATCH_PLATFORM_INSN(CPU_MIPS2, "mips2");
+
+    /* Fallback */
+    return "mips";
+}
+
+#undef MATCH_PLATFORM_INSN
-- 
2.43.0


