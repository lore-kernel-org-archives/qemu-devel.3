Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30600C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucb-0007kF-Ak; Tue, 29 Jul 2025 20:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIz-0004d1-G1
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:25 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIx-0004cz-O9
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:25 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5934019b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833862; x=1754438662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q8Yxvmp3guLi2a7gDpc/dLGiNxULKQFwfP2Y3CipvTA=;
 b=RtD1TYNt/tR8C/7fg4P2UePUOLmtm8O0SGCqrjRGASuYraAM2pn/UYbEpihz9ZntJy
 jxDhedOs3t9pY5QOy+yXiHf9tmc6NEV4jxBBWPIpm3AWVHsWnRDCaUzzVhZsKNpyD/rA
 MU0tcdawLzI4HsOoQhYzInjQN4zJVuB7CYoBQDZv9xldrMSEIcK34ClGm2K9O/Py7n71
 2A70oixhw0nTbnbqv0IgR3xrUOQhaxXi6PmWnzPIefY3ATIeBQ8o62E+/sfZ8UJK7wzz
 o9zwKPAOP+fzofO2Oh4hUgyRdQ37TeGwU+iYc84qj0c5gDQNDhGzIh7DNiG2JDAb8Y5j
 KN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833862; x=1754438662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8Yxvmp3guLi2a7gDpc/dLGiNxULKQFwfP2Y3CipvTA=;
 b=aFun6+qByUmbeRvJJQl22b4WBjCxsViVEUey+U4bxvwUILcvA20GLEcwji+lQjYaGI
 SqJVTNnsfwY34BWaQoBrafPGru3D0v7mIqaicIGOIUehDeZreI0USIEugj8lVIekEuwG
 9he0wq/GOXEtF4VsgMZXfQX2eCRGIAdTgEMT/z+d1GEenYxcBMYuf/gdNL5gLveJodXx
 lKZdfWSbRVDFsC3FYG0kCIWAUC9QW4uUShAMoi11Va0WCfWdEEl+iZ+gIq+dC1qAcR9C
 dks0Pmye8QSbHfXdJfnCOBsjbDgEWqhAZPDR9Fx23sqWsUYNaNddLH3K1m6+IrHnn6pl
 CbQg==
X-Gm-Message-State: AOJu0YyqIkrHrdZ8YcFWjcl7QuXOU0VHsgAQdhKEuiBnDfR1XSFqhvB1
 v5dL6F2e5U2N3c0Mz4G69f0aEJnNg78fSnoztkAQ9uS5voqXY6ywarVK0cqG4X4GJpDrCMk+NDQ
 GcLD5
X-Gm-Gg: ASbGnctPp+Yhti0BPK6ifXGGE3hdrmwnNXHe0VgSMHgip+nQxjHok0SVCxvVVTt8Pav
 OH/DqBnlhrsxWUIGxZ7l9Ev/OBbKJefP3XFclCSr9eZth8cW/2vNk3uLlKwBy2NbBevcfR1vOwL
 m2aFr0Q+DaDrv/FoBZHCtgAdEEYZ77mtk0o5IzRUnm2MoNJl5rtqXK7KWCmNuE6MM2F0jmkqyq6
 76GOnMH+PdrkfgIYWzQ07O/Amniv82iTtcMR4jsj1Lgv6PwHShqhWRRUl0PwY/MJi0CK7y92Rfv
 O+zUn8IDeUGgp1ZHVzTTXYBZ9X4PfQrr/XwUhjsOI5DWCKJl62QwiUO2nwnqFJ8Bf7ooIn4sDNY
 GNhqfphtKLlIBTH+NWS52qV3bv7xz3JSw19nIk5MfOmJob+64L9W4TA4YYB66WvdnD1TXLYdcfv
 iQt9MvWxUkTH6GrS8biLQf
X-Google-Smtp-Source: AGHT+IG0IZK8/vmKIVAviwuTbVPVtGueKTBM/ojhCB4S6EanByjghcmvPxlLqPBz7IcRuGIqbi0FAA==
X-Received: by 2002:a05:6a21:998f:b0:232:813b:8331 with SMTP id
 adf61e73a8af0-23dc0cfd1b2mr2047282637.2.1753833862369; 
 Tue, 29 Jul 2025 17:04:22 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/89] linux-user/s390x: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:25 -1000
Message-ID: <20250730000003.599084-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c                   | 31 +-------------------------
 linux-user/s390x/target_coredump.c.inc | 31 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 30 deletions(-)
 create mode 100644 linux-user/s390x/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d9def102e3..7cd0d5e7db 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -490,36 +490,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
-#define ELF_NREG 27
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-enum {
-    TARGET_REG_PSWM = 0,
-    TARGET_REG_PSWA = 1,
-    TARGET_REG_GPRS = 2,
-    TARGET_REG_ARS = 18,
-    TARGET_REG_ORIG_R2 = 26,
-};
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUS390XState *env)
-{
-    int i;
-    uint32_t *aregs;
-
-    (*regs)[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
-    (*regs)[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
-    for (i = 0; i < 16; i++) {
-        (*regs)[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
-    }
-    aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
-    for (i = 0; i < 16; i++) {
-        aregs[i] = tswap32(env->aregs[i]);
-    }
-    (*regs)[TARGET_REG_ORIG_R2] = 0;
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
 
diff --git a/linux-user/s390x/target_coredump.c.inc b/linux-user/s390x/target_coredump.c.inc
new file mode 100644
index 0000000000..bc8cd9d6c6
--- /dev/null
+++ b/linux-user/s390x/target_coredump.c.inc
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
+#define ELF_NREG 27
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+enum {
+    TARGET_REG_PSWM = 0,
+    TARGET_REG_PSWA = 1,
+    TARGET_REG_GPRS = 2,
+    TARGET_REG_ARS = 18,
+    TARGET_REG_ORIG_R2 = 26,
+};
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUS390XState *env)
+{
+    int i;
+    uint32_t *aregs;
+
+    (*regs)[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
+    (*regs)[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
+    for (i = 0; i < 16; i++) {
+        (*regs)[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
+    }
+    aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
+    for (i = 0; i < 16; i++) {
+        aregs[i] = tswap32(env->aregs[i]);
+    }
+    (*regs)[TARGET_REG_ORIG_R2] = 0;
+}
-- 
2.43.0


