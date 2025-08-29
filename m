Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE45CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjy-0007oU-UB; Sat, 30 Aug 2025 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bI-0004PE-6c
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:40 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bG-0003bR-76
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:39 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-770530175b2so2070039b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506575; x=1757111375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/S/XybhJsScwh2XgsdTT+la9BSjFbURn2C6teEPj7h4=;
 b=YKFWkli/D6KfQLbG+XySZQ+LbVkIzCqbv5THd13TA10pY8mF4wlEAQ7JEHrQEqGHdI
 GRTRRluBYzrnsW/N36kmlGHLlvxyGraQQy/Vlx9PNHt9eqvEXeBYoeaVT2k5/oATcwlX
 PISwfM3vS3HDnU2M2ovtAB62iwCCF9ow9iuZv59I9XruuWtsIi64tUnWyZnxvJWUaVKD
 VhbvlKwvr3TCbheet+Mn+tmk8wD/OkM+flLkHWp1mHR+WzUwzJZgptslX3Lg7Gzm9JZC
 qVJ9Rm2Ffh3HhEwyqm0rmUA7UA9V9i1/h1SX/kSCngLjR/gSTNStkf1P9FiUe7WAw9Dj
 M41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506575; x=1757111375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/S/XybhJsScwh2XgsdTT+la9BSjFbURn2C6teEPj7h4=;
 b=Vvw8osPwPKRe6c7rXQ+wCzqnq/aeVl01FMfiUeBvfeJbIbo84elKbhnsyiDL7SR1hc
 zL/L9XbLHIYP0myyIWCCRwCA1IbmNIQzR4iXzps9QJ/xiKkTsYYEpdPXGAsKvnu9z52x
 +rt07Imn5hfNzn13JTOLu0r0xEszjd89leTm2HTcDlERh9uZsG3s6RzCzLNMaRKHT4aC
 MuG3/RlcGfWqj3hr2wwbD3En3H8FfdryRTJx/SBQVPzcxJ4pa1JFuIenLf3eAF/qc3CY
 rsSaSB1BdvLfrdD5crnIZ+Pi1KrtohpQjYqooBEWF53mvcmid8T4HDOCEPZjD5AwMXmM
 WFJg==
X-Gm-Message-State: AOJu0Yxi6hFPXUjYfMXkKq3PEGocOWJ13suBjD+ADkSb/TQCoPqfkL0Z
 Caji3ca3d80l6S5enVV55rHoqJQHlJZGHrxdZoy5C1FkgsrlAe93K4ro5k5XOfWQLdzTT6LqO2s
 Fa0Uujsg=
X-Gm-Gg: ASbGnctl/jpAqQxy8+s6ySjiWxpBRUDjpJ1GJrdD6iovCSnWnjs4psBibCrg3RoBRCQ
 YQ73Gd9xi6ZmeuJfVU2okQuY9tPrCjA4LdIf30Qa8xogKWRNG6Dz8IGY/ESYdhrgnX6xM/2pZw8
 ugoaNXJxXv5da31jdIPM9jo2cBeFf3oFHD/k27TRtwDKEWYWTNLvN2kh7LkHHwH+bSxl9wGoo7E
 GI3/2T1DG+wfaedb+SSnAnVicRPSv0Su6tyNDqTQ0rLxKo4eHwEmn62oiXA+CqDlptosfYwsmTq
 ZsHarccZ3yWJpcWnaCYwdVf1u8JZ8209/LStpeaW/tvP4q/Rz8UQEoO72jCb+1Q3IQMVDR8aAis
 m8mL9Y6JhVjYHXJkZo+s7o2+65yf+UDisMOPUQXCa8R4aAY+qZBTi+862/TpSc5Y=
X-Google-Smtp-Source: AGHT+IE010/6CsZCWu/yw5UNWPL1a3KMm+cdGEcmI7MFkFMtvwT/WSr+ZlZgWNhtjTuvteb/AJjRzQ==
X-Received: by 2002:a05:6a00:23ca:b0:770:57c4:e959 with SMTP id
 d2e1a72fcca58-7723e22d449mr271737b3a.9.1756506575503; 
 Fri, 29 Aug 2025 15:29:35 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 50/91] linux-user/mips: Use target_ulong for target_elf_greg_t
Date: Sat, 30 Aug 2025 08:23:46 +1000
Message-ID: <20250829222427.289668-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
The target_ulong type matches the abi_ulong/abi_ullong
selection within mips64/target_elf.h.

Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/target_elf.h   | 10 ++++---
 linux-user/mips64/target_elf.h | 14 +++++-----
 linux-user/mips/elfload.c      | 48 +++++++---------------------------
 3 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index f767767eaa..a4b7fadbd6 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,16 +8,18 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG                45
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    union {
+        abi_ulong reserved[45];
+        struct target_pt_regs pt;
+    };
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 046a165eef..67bc963134 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,20 +8,18 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
 
-#ifdef TARGET_ABI_MIPSN32
-typedef abi_ullong target_elf_greg_t;
-#else
-typedef abi_ulong target_elf_greg_t;
-#endif
-
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG                45
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    union {
+        target_ulong reserved[45];
+        struct target_pt_regs pt;
+    };
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 6e884911af..e0c50f50ed 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -124,47 +124,19 @@ const char *get_elf_base_platform(CPUState *cs)
 
 #undef MATCH_PLATFORM_INSN
 
-#ifdef TARGET_ABI_MIPSN32
-#define tswapreg(ptr)   tswap64(ptr)
-#else
-#define tswapreg(ptr)   tswapal(ptr)
-#endif
-
-/* See linux kernel: arch/mips/include/asm/reg.h.  */
-enum {
-#ifdef TARGET_MIPS64
-    TARGET_EF_R0 = 0,
-#else
-    TARGET_EF_R0 = 6,
-#endif
-    TARGET_EF_R26 = TARGET_EF_R0 + 26,
-    TARGET_EF_R27 = TARGET_EF_R0 + 27,
-    TARGET_EF_LO = TARGET_EF_R0 + 32,
-    TARGET_EF_HI = TARGET_EF_R0 + 33,
-    TARGET_EF_CP0_EPC = TARGET_EF_R0 + 34,
-    TARGET_EF_CP0_BADVADDR = TARGET_EF_R0 + 35,
-    TARGET_EF_CP0_STATUS = TARGET_EF_R0 + 36,
-    TARGET_EF_CP0_CAUSE = TARGET_EF_R0 + 37
-};
-
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
-    int i;
-
-    for (i = 0; i <= TARGET_EF_R0; i++) {
-        r->regs[i] = 0;
-    }
-    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
+    for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
+        r->pt.regs[i] = tswapl(env->active_tc.gpr[i]);
     }
 
-    r->regs[TARGET_EF_R26] = 0;
-    r->regs[TARGET_EF_R27] = 0;
-    r->regs[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
-    r->regs[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
-    r->regs[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
-    r->regs[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
-    r->regs[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
-    r->regs[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
+    r->pt.regs[26] = 0;
+    r->pt.regs[27] = 0;
+    r->pt.lo = tswapl(env->active_tc.LO[0]);
+    r->pt.hi = tswapl(env->active_tc.HI[0]);
+    r->pt.cp0_epc = tswapl(env->active_tc.PC);
+    r->pt.cp0_badvaddr = tswapl(env->CP0_BadVAddr);
+    r->pt.cp0_status = tswapl(env->CP0_Status);
+    r->pt.cp0_cause = tswapl(env->CP0_Cause);
 }
-- 
2.43.0


