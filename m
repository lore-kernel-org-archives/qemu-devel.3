Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F042C87FCE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguY0-00065J-0j; Tue, 29 Jul 2025 20:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIr-0004U5-IL
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIp-0004bN-Jt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so4140690b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833854; x=1754438654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wFful4+njraM30kiF1fUAKiwVjGnj7/uyZgVnKI7MwM=;
 b=TCURIlSMGp868nDfQl+uCnRO+k2dIPRy/J1JBa0e2S5mCgfuZqvz4W+K25Jo+eqLbd
 Sn4A+hF02OfM0TVAB+Pv1B/3ANMHj5e/IMo030GS2PDRmRbkWz+8LX73uUinBSqdjCEK
 n6A25FA1TA1k22WTNk+X0FWUbHFXpjuhIeCzUjgGbkpSx2qA0Uw6eTFtS/ktov4dLEL5
 FdXO/0Riy3RUGknD6x3SQvOa5DfJEExrL7UDD9c2QGmMz8az+5AFnLkEZObq6PmnM5Gc
 7hv1ZQp/Q5/eZ0tWmoF7SFIjEN3ZZojzKGfFJnnDcWULkNfUX8kOKmVIjreBhyf1/bUL
 vlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833854; x=1754438654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFful4+njraM30kiF1fUAKiwVjGnj7/uyZgVnKI7MwM=;
 b=lqTfubfThFw5tbWkO0q1jmJHHKYGo4cKnCfh0NdGePMX+OPRvHkuGQtQ4PrHcfS1hv
 3EeKPPWT5fb/QPMufawLUtvANMrlGjM/gLpgXGFOQktbSNPg96yjZJ1h3wsGydYisNoy
 RSbuhUkcaQtSaso2+faWLwVvrsPFaFLC/Mgyz6KwSgHtiE2NZQfRjL3fseYGgT923jdZ
 D3JlJPOvHetn2cB9Tv3JmcvG3ofVeQ8BF89nutIYSC7e6wmxZ2bHFPftDqgA7WSE25Yt
 jCmW7QC0VQdCh+xSqmMuEtBEzzPFXgLF8S5Z23FgcQCs+QZcp85/HwCf0ebWNxth4PF5
 Wv7A==
X-Gm-Message-State: AOJu0Yxn1qrfIkvFbKYBp8Lw0zL+ukt5TiZJD4E7EQpS7XByHwrZVh26
 2NB98UP2knwwWLiS1q0mwPrwfZCVOhQAILsO/ClJNjAHS/S1SxtV+oD8hejvpQLV5vDpcHKFyjI
 d7qDC
X-Gm-Gg: ASbGncuX3bwyKsf8vHZPtGsMewbckmrXslY6G0wwam720K1fJLgqfvXO6GkOEOidswF
 vFbbyUSlkvzl+/mT/ksw/N4eZA3wWi19asly5vzOfSAWaaCwkCM7S8mp72XCwha3esXHi9AyGiF
 LVXYEpEuEDqcCZ1VojTclhT/SLHvI+YxfeLgFNwQ3T17hg5p3iNJb7yb/zpr/HJfbQ5RQ80MQuo
 vXjVJJqU0C42MJriKkp+g49voJvKWMdqOe+I+hmAa4IYnaAvRBEnIN9rBA1wMaxbpDDIPnprlTW
 XJgEGid9KXc2UrqfbpK5oFuf8jZm+AcodOioZWLBsLczdGYlP1mZ7OmimrW+KSbSCXA547VdReg
 KQYkRpn0fzIxhC3npt9cBNKPV5QW4CxLI2K5M+hxg2ImoySeroia7Le0MCTZqs6bLovJhtKldMq
 6POIkwLNbtzzfY1isGoq9R
X-Google-Smtp-Source: AGHT+IET+sLSTazHtZE+IjUUWWAng+lOEIpizTg4s39KCV5556s9pUxMq5xftHTQFYzwd4J19TDVCg==
X-Received: by 2002:a05:6a00:4b46:b0:769:1f94:85bd with SMTP id
 d2e1a72fcca58-76ab32fd0b3mr1843839b3a.23.1753833853903; 
 Tue, 29 Jul 2025 17:04:13 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/89] linux-user/loongarch64: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:19 -1000
Message-ID: <20250730000003.599084-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c                         | 26 +-------------------
 linux-user/loongarch64/target_coredump.c.inc | 24 ++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)
 create mode 100644 linux-user/loongarch64/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a6e4ac86bf..77730fdbaf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -400,31 +400,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-/* See linux kernel: arch/loongarch/include/asm/elf.h */
-#define ELF_NREG 45
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-enum {
-    TARGET_EF_R0 = 0,
-    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
-    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
-};
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPULoongArchState *env)
-{
-    int i;
-
-    (*regs)[TARGET_EF_R0] = 0;
-
-    for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
-    }
-
-    (*regs)[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    (*regs)[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
diff --git a/linux-user/loongarch64/target_coredump.c.inc b/linux-user/loongarch64/target_coredump.c.inc
new file mode 100644
index 0000000000..34207f9fb0
--- /dev/null
+++ b/linux-user/loongarch64/target_coredump.c.inc
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/loongarch/include/asm/elf.h */
+#define ELF_NREG 45
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+enum {
+    TARGET_EF_R0 = 0,
+    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
+    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
+};
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPULoongArchState *env)
+{
+    (*regs)[TARGET_EF_R0] = 0;
+
+    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
+        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+    }
+
+    (*regs)[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
+    (*regs)[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+}
-- 
2.43.0


