Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BAFC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJC-00020e-7Q; Sat, 02 Aug 2025 19:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIg-00014E-LE
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:15 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLId-00016n-9j
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:00 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-433fcc4f28cso13318b6e.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175958; x=1754780758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUiZ/Sv7EV/5D3y8AipMsR5HBvNmhQjnrAQjoZSkkls=;
 b=iUr0Gq5n1npwtaeelkyRFAL9cNOyQ6EjjAax/YzfKYyod+SH9IBEw7voU8rLkspkYf
 u8NCbZhDplctVDnx/VW4uS/9TYyQPeKidDCu5gfXMDtzXj9azDDyZLZL+2ZLyPxjXCcA
 tvhgB4+ICHkSC6jPTg0Y6HG1TSbLyeTxmajdw3mvVcQEMDnYhJVS12dpGmI/OKuXG5nS
 S90yGiUmC3xAL70GRxXBDt19DG6YI0F5lTifVFCyJCVF+WyvoEUnqTz4vN4Lx/BGZZU7
 K27VD+6bpCI5ohA8K99rDHlOYSWiobh6rfwRL8QWtp4BvwAj65zpIF+b+u3KZCj/lUXR
 yQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175958; x=1754780758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUiZ/Sv7EV/5D3y8AipMsR5HBvNmhQjnrAQjoZSkkls=;
 b=Gf6VXdYQojG//9qaNAzBoZUMwgUwywbX5lxYQaDwTKJwtw31m4/gZvoLqxaiSRpbKo
 ZP9a76yi+mYKkrXqgkZUXuT9F0WS3/1a2o1ILJ3Yu7/kNUUeQlb2t4eC8WxcSHv2kH0P
 AP3tt+aEpUDBmoiry8OhaSlaeUvIXgrXF0aS2Xbm7QSdSSrGkNNsMe+9L0BD2OppzIYT
 OM3KH3o964E5vZrrDwDjxOJexJ00epjJGvW+Rmyenixi4jMAevPaPFgcBr2k9KbFM0tL
 dvaIo/LaKtOm7LjkRJDuXBY+yv7WX3pd05DjyFzT0SRRC5gEo4NOrqba8q5bkJywvfEw
 LwhA==
X-Gm-Message-State: AOJu0Yzgg7mNhvtMhEcn1BK+XKDddR+ni0+ngpf41+Qi7M+KzhbElNam
 EQIOyYomlD9DdfQ04Ex+Ej0tQUQaYwPkN0w9upHJDjyTopBBb/DByuIIF55lc15mb1A8KDeXU40
 MrR8Vk+A=
X-Gm-Gg: ASbGnctJSA/FLpuN1Uv24fkqP3kGvaeu3qRzc9803iXewzN8oJFGPdg+w/IJ5tvd9Bm
 m8HYhxjxrCn7zkn+1QosBHGhVts/l5J1RHsInKLgcjaMAbxIOvaDDXBrT/JQe7jgC0TLqfhNEt6
 JKexoFCCjm9S6XDtDIIEqOJ3vi53BbnYtB+uzuPsV6NiLm8lJDWZsqWSEF7XZ50g0AfyeIkI1WX
 GB2A3LB4WElXAn/TgJlf1+Ex1wh+flQk6vgBGmk1QoQWz4+mkZ2lY5S1UCDtn8dNDGpD0+ASr9m
 It7B2F+w2EAAJGzZ7Zvk/Gn8corV5CliAcG6Cj67A85MlPjVp+2I20VgcyvQvHdtsh0fcGee04m
 HxMCJ2/FNSxDQANrRKUwavKIA1rcLsrFbeDbOZnGSpaw5ikOu0tam
X-Google-Smtp-Source: AGHT+IH0IxhNpm0oeTbD4uvmoqSM637YpMFZfRkM8ewrx2JPUOFLPt764OpkHzduti0V0qtmt5iR4g==
X-Received: by 2002:a05:6808:1818:b0:40a:a8ad:bc11 with SMTP id
 5614622812f47-433f0259d35mr2598012b6e.17.1754175957809; 
 Sat, 02 Aug 2025 16:05:57 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/95] linux-user: Move hwcap functions to s390x/elfload.c
Date: Sun,  3 Aug 2025 09:03:37 +1000
Message-ID: <20250802230459.412251-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

For get_elf_hwcap, change the return type to abi_ulong
and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  5 +--
 linux-user/s390x/target_elf.h  |  2 ++
 linux-user/s390x/target_proc.h |  2 +-
 linux-user/elfload.c           | 60 +---------------------------------
 linux-user/s390x/elfload.c     | 57 ++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index d8a9399807..c14e69f551 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -104,13 +104,10 @@ const char *get_elf_cpu_model(uint32_t eflags);
 #if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
     || defined(TARGET_SPARC) || defined(TARGET_PPC) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS) \
-    || defined(TARGET_SH4)
+    || defined(TARGET_SH4) || defined(TARGET_S390X)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
-#if defined(TARGET_S390X)
-uint32_t get_elf_hwcap(void);
-#endif
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 
diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index e51b053339..cebace949a 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef S390X_TARGET_ELF_H
 #define S390X_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/s390x/target_proc.h b/linux-user/s390x/target_proc.h
index a4a4821ea5..60cc22d3b4 100644
--- a/linux-user/s390x/target_proc.h
+++ b/linux-user/s390x/target_proc.h
@@ -48,7 +48,7 @@ static void show_cpu_summary(CPUArchState *cpu_env, int fd)
 {
     S390CPUModel *model = env_archcpu(cpu_env)->model;
     int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-    uint32_t elf_hwcap = get_elf_hwcap();
+    uint32_t elf_hwcap = get_elf_hwcap(env_cpu(cpu_env));
     const char *hwcap_str;
     int i;
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7e1c11c39f..ba8593368d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1039,65 +1039,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-#include "elf.h"
-
-#define ELF_HWCAP get_elf_hwcap()
-
-#define GET_FEATURE(_feat, _hwcap) \
-    do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
-
-uint32_t get_elf_hwcap(void)
-{
-    /*
-     * Let's assume we always have esan3 and zarch.
-     * 31-bit processes can use 64-bit registers (high gprs).
-     */
-    uint32_t hwcap = HWCAP_S390_ESAN3 | HWCAP_S390_ZARCH | HWCAP_S390_HIGH_GPRS;
-
-    GET_FEATURE(S390_FEAT_STFLE, HWCAP_S390_STFLE);
-    GET_FEATURE(S390_FEAT_MSA, HWCAP_S390_MSA);
-    GET_FEATURE(S390_FEAT_LONG_DISPLACEMENT, HWCAP_S390_LDISP);
-    GET_FEATURE(S390_FEAT_EXTENDED_IMMEDIATE, HWCAP_S390_EIMM);
-    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
-        s390_has_feat(S390_FEAT_ETF3_ENH)) {
-        hwcap |= HWCAP_S390_ETF3EH;
-    }
-    GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
-    GET_FEATURE(S390_FEAT_VECTOR_ENH, HWCAP_S390_VXRS_EXT);
-    GET_FEATURE(S390_FEAT_VECTOR_ENH2, HWCAP_S390_VXRS_EXT2);
-
-    return hwcap;
-}
-
-const char *elf_hwcap_str(uint32_t bit)
-{
-    static const char *hwcap_str[] = {
-        [HWCAP_S390_NR_ESAN3]     = "esan3",
-        [HWCAP_S390_NR_ZARCH]     = "zarch",
-        [HWCAP_S390_NR_STFLE]     = "stfle",
-        [HWCAP_S390_NR_MSA]       = "msa",
-        [HWCAP_S390_NR_LDISP]     = "ldisp",
-        [HWCAP_S390_NR_EIMM]      = "eimm",
-        [HWCAP_S390_NR_DFP]       = "dfp",
-        [HWCAP_S390_NR_HPAGE]     = "edat",
-        [HWCAP_S390_NR_ETF3EH]    = "etf3eh",
-        [HWCAP_S390_NR_HIGH_GPRS] = "highgprs",
-        [HWCAP_S390_NR_TE]        = "te",
-        [HWCAP_S390_NR_VXRS]      = "vx",
-        [HWCAP_S390_NR_VXRS_BCD]  = "vxd",
-        [HWCAP_S390_NR_VXRS_EXT]  = "vxe",
-        [HWCAP_S390_NR_GS]        = "gs",
-        [HWCAP_S390_NR_VXRS_EXT2] = "vxe2",
-        [HWCAP_S390_NR_VXRS_PDE]  = "vxp",
-        [HWCAP_S390_NR_SORT]      = "sort",
-        [HWCAP_S390_NR_DFLT]      = "dflt",
-        [HWCAP_S390_NR_NNPA]      = "nnpa",
-        [HWCAP_S390_NR_PCI_MIO]   = "pcimio",
-        [HWCAP_S390_NR_SIE]       = "sie",
-    };
-
-    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 989953a247..79ceaba51d 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -3,9 +3,66 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "qemu";
 }
+
+#define GET_FEATURE(_feat, _hwcap) \
+    do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /*
+     * Let's assume we always have esan3 and zarch.
+     * 31-bit processes can use 64-bit registers (high gprs).
+     */
+    uint32_t hwcap = HWCAP_S390_ESAN3 | HWCAP_S390_ZARCH | HWCAP_S390_HIGH_GPRS;
+
+    GET_FEATURE(S390_FEAT_STFLE, HWCAP_S390_STFLE);
+    GET_FEATURE(S390_FEAT_MSA, HWCAP_S390_MSA);
+    GET_FEATURE(S390_FEAT_LONG_DISPLACEMENT, HWCAP_S390_LDISP);
+    GET_FEATURE(S390_FEAT_EXTENDED_IMMEDIATE, HWCAP_S390_EIMM);
+    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
+        s390_has_feat(S390_FEAT_ETF3_ENH)) {
+        hwcap |= HWCAP_S390_ETF3EH;
+    }
+    GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
+    GET_FEATURE(S390_FEAT_VECTOR_ENH, HWCAP_S390_VXRS_EXT);
+    GET_FEATURE(S390_FEAT_VECTOR_ENH2, HWCAP_S390_VXRS_EXT2);
+
+    return hwcap;
+}
+
+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+        [HWCAP_S390_NR_ESAN3]     = "esan3",
+        [HWCAP_S390_NR_ZARCH]     = "zarch",
+        [HWCAP_S390_NR_STFLE]     = "stfle",
+        [HWCAP_S390_NR_MSA]       = "msa",
+        [HWCAP_S390_NR_LDISP]     = "ldisp",
+        [HWCAP_S390_NR_EIMM]      = "eimm",
+        [HWCAP_S390_NR_DFP]       = "dfp",
+        [HWCAP_S390_NR_HPAGE]     = "edat",
+        [HWCAP_S390_NR_ETF3EH]    = "etf3eh",
+        [HWCAP_S390_NR_HIGH_GPRS] = "highgprs",
+        [HWCAP_S390_NR_TE]        = "te",
+        [HWCAP_S390_NR_VXRS]      = "vx",
+        [HWCAP_S390_NR_VXRS_BCD]  = "vxd",
+        [HWCAP_S390_NR_VXRS_EXT]  = "vxe",
+        [HWCAP_S390_NR_GS]        = "gs",
+        [HWCAP_S390_NR_VXRS_EXT2] = "vxe2",
+        [HWCAP_S390_NR_VXRS_PDE]  = "vxp",
+        [HWCAP_S390_NR_SORT]      = "sort",
+        [HWCAP_S390_NR_DFLT]      = "dflt",
+        [HWCAP_S390_NR_NNPA]      = "nnpa",
+        [HWCAP_S390_NR_PCI_MIO]   = "pcimio",
+        [HWCAP_S390_NR_SIE]       = "sie",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
-- 
2.43.0


