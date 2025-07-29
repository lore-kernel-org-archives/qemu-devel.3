Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E35C87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRO-0001oy-8F; Tue, 29 Jul 2025 20:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF8-0001Xj-EH
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:26 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguF5-00041f-Tr
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5930868b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833622; x=1754438422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=niYjP4HNi20ORlTyteNDCGDWejJsTAgXuRZuniRDlAY=;
 b=wi5V9EroshTzfXiIgKHBOs3QsJxzxsutGrAZS1ZC7FvUV3EwqUHKby/WO+49Qx5znX
 mFuW5cnfqaxVp19cnX3wXUrqw3drItA66pxk9F9qpCQqWUfBDvigjhS/dzvKyRon3B4t
 379Klx1BGg0rtrqUZFhrS4nKpJ4U+NxDOvzoMmHgUHxpDtqoiPdBL/7r6UWK6CduXszD
 v0TuaT/7FTcvLZ2+DKu6SwGswtRkirKpmSSC8Ck12Y1MzfFhPuE9gBoLFdffhZTjNoN5
 r0SyewR2oGecBum1Ucw3E19wQ+pz0Me6d2vIM0gDrqNUeEEu1GJcdsxJbzimQJ3HauuQ
 TEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833622; x=1754438422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niYjP4HNi20ORlTyteNDCGDWejJsTAgXuRZuniRDlAY=;
 b=JmvKm1gfBVbpbilcLb4K9TCJxXManePO7y6uEr49UVXEFmS4a95JKYepoO71FpQr6i
 1tk2T259B1Cp/86up+he704M77yRaq6SMT5eo2V9+n7YO/fIfUq2e/984o0ZA84hnLIO
 5Kf3do/Fs5DPugEErGvSc/WfJK01DkKBDvfVgc/8WuQt1o0UNbn1zOVeh/8to7zzLkEM
 yJts5R1M/UtQqi3W8LVm3wzsq9Sy3g+aOct6YYS871e6d5Bclku60ueRdKNBJtD0HIOg
 TtL5I19H/QTxwC/0NZCCY3oD1TgTQccPHjzmymz4kxgf90fYe1TrF3HE4qXrRhazIMSu
 hxeg==
X-Gm-Message-State: AOJu0YyMgV/TTzVCqDhYyqm3p2O+7iA5c/0Xn2FX/A3RxgpvXA4YY46Q
 EfhFGmYMhJ+J4POJVlWt0r1twDb77awGiN7l+1QId0pkvePX+WlsUj/L1LVeybvEL98nRiBMZVD
 8Ulso
X-Gm-Gg: ASbGncsvY4yliZ07h6c7jB2YaHcic14CZ5ymw2qGuq1SLMtYaU+erzJn3oM0NL5is4D
 QK1JXl+o1M6qOx6dlPBMj7BDsoGcRciXfWGAD00juFPd4QCVEGukIinfRXP3YLgIlglCTr/J4EW
 mYdnWNxiERXwDJyHuU7IGtnF9nIaP/fhIJxKaMHBYKUv2L+2W6B2UFX7CDkSbd/hPq0t0s2yI+x
 zZJ5X2d4irKlnxZnQoeSODPkwH/gpiiXH4/i2W3cQ2RbysfKbqlmS1Qs4EMKWW7m5DdF5QmIcsm
 9nhf7+CVmyAJ0qlOMbgbCk2Oy2uU7IzlWxof52j3lXdZ+itj2mTgINeepqSJQp7e2iq6atdMBja
 VbIwJWJuyP9Pw2aXezA7oX66rSQjIkHKzAPK1X0LkTT90yzAR61vH0WfqXiVdESxBhyemyLrw2v
 CDLW+o4JBkZQ==
X-Google-Smtp-Source: AGHT+IGGciwtfEAJPAaabB1WdNQ2DPrgCMY0U6HqNz6xSpFq1l27crZPOKJy6EbMp2dzbIJqPiOwGA==
X-Received: by 2002:a05:6a20:3949:b0:222:d817:2f4a with SMTP id
 adf61e73a8af0-23dc0d59042mr1791411637.17.1753833621540; 
 Tue, 29 Jul 2025 17:00:21 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/89] linux-user: Move hwcap functions to s390x/elfload.c
Date: Tue, 29 Jul 2025 13:58:42 -1000
Message-ID: <20250730000003.599084-10-richard.henderson@linaro.org>
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

For get_elf_hwcap, change the return type to abi_ulong
and pass in the cpu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  5 +--
 linux-user/s390x/target_proc.h |  2 +-
 linux-user/elfload.c           | 60 +-------------------------------
 linux-user/s390x/elfload.c     | 62 ++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 64 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index cfb474e257..72eb3e68cb 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,13 +101,10 @@ extern unsigned long guest_stack_size;
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
index 1e855713b6..8d4429242f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1049,65 +1049,7 @@ static inline void init_thread(struct target_pt_regs *regs,
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
index 73fa78ef14..29dab42933 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -1 +1,63 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+#include "elf.h"
+
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


