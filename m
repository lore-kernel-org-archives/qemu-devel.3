Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E980C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJE-00006R-2A; Thu, 28 Aug 2025 13:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWO-00087A-75
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:33 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWF-0008KN-Hs
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2467de5160eso8784415ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383258; x=1756988058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwqnKORhrH73/9/V7Ir0ecWiuCaz2yy8YxhnqnhXci0=;
 b=cDVgSJfyyNc2Idx195xMLbqQlzmFgzlnxDlVsfA7wmeHBNa2GGncb9whFiQE87WZdt
 EFcmF8Eerv9IgErTfG145MQ5JFQf29EzAw4owrx/14/TIaktF/nP94/rg5X6AbwAP2vN
 Sq6YaZRimNnBmMzxZXrbcNMW0JZCY8Jh8ALSn74TgKMqlwxdPbLc5Q4by3PBAK/GBupY
 fcU3xlNOF6Ocky6wJ1JB6oO02lvuE98PSEebC7Oc+eviGQObM8RKCTxl8j5TegJz6wet
 Ky5yywJOIilFX/GR6MSIsvQVr1y3h+jCP3DuOQl560+WgXbnZ+fEP2VeQCEFCMfONrNK
 06Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383258; x=1756988058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwqnKORhrH73/9/V7Ir0ecWiuCaz2yy8YxhnqnhXci0=;
 b=shpdOgcnEmvDsMqqsMJ8GDr1PxA4XFOmtPABoAfLoZbcND62CaOLxFo80UBbXSXjHS
 eamI6nJUIAT15GIR3IJgZ5XOtOPUo8xW6ava+tF/h3We8uOMbis0aiRsreM/uQsr/6Kf
 mazdzV3I1OHZwl7sLVS8qOsaXtT/rc2YZRD/FQ5JD2eg+kwd0eJMzIo+nMjlnp4T+1Pc
 wnGhK+KXPqn7MU892yGM2r6UKW51k9RCmpAknNIhRV7vH3Jls09LB5lzNFqSwkH+RIi0
 fA7tPYnsF/IA6lMBDB6ZLn37WQmAyzVBhclT625EkZ7uq4fXf82GvPRWUk+YYaMl7esQ
 9tpw==
X-Gm-Message-State: AOJu0Yxk5Z1G6IMbfy7VBNIxHIodmfOPUPJURhpak5eLTgl+8ucl0CZ5
 cCFw4QqsNvo8SIXhtvrRwytdIbNlE349OrhjfG9s8pytnoGW4FDR8+zCvLkwLe9RJrSW1clVGpK
 DkyPC/3I=
X-Gm-Gg: ASbGnctt21Epqlejx13Yxk7JCr0W6OIHBpJcClb0jqF8I/XHxkV/OmbMmycpsSi3Xk+
 tfG0PqrU22x/k+W5a2Rt4Ly3Vp5FSshs+92bG+WO2tf4atNXtdBBEq70kK+c4dCpF0AkxBoS//t
 +cTyVtoTMz4e1F/fXiKFjSgQESgFEb99u10IDZvRV460hAMvV9fL3X1LnMoTSZvgIUGfgUxr5PH
 wWaaCtk18Zt1vmxHcQJTzvw2Q1DbM+uBhVtPecnIfvTzszGToxOzooYr8dqT4COYjJ0Zxc2lLym
 HQdhCFdZIFDGiyRfAVFsH2zeEX1ipgsh2tUHwMLZ14Vzpmm5pd9jQvN5l5P2iC77DgJ32/doapO
 uw8k/xuhBtLRufwjG9eC8V/2K+nj00pyK1Xev
X-Google-Smtp-Source: AGHT+IFIVaXdXC6ujBphFfabUwQ75eHqjzWYJ+o4afRguKxlXNrOaRk2h7Hy48GMO9VZ4NhA75dIng==
X-Received: by 2002:a17:903:2ec7:b0:248:74db:1bf1 with SMTP id
 d9443c01a7336-24874db1f9amr111457405ad.44.1756383257977; 
 Thu, 28 Aug 2025 05:14:17 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 57/87] linux-user: Move init_guest_commpage to
 x86_64/elfload.c
Date: Thu, 28 Aug 2025 22:08:06 +1000
Message-ID: <20250828120836.195358-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Rename INIT_GUEST_COMMPAGE to HAVE_GUEST_COMMPAGE
to match the other HAVE_* defines.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h            |  3 +++
 linux-user/x86_64/target_elf.h |  1 +
 linux-user/elfload.c           | 23 +----------------------
 linux-user/x86_64/elfload.c    | 20 ++++++++++++++++++++
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 8f4a7f69ac..98015fba7d 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,6 +105,9 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
+#if defined(TARGET_X86_64)
+bool init_guest_commpage(void);
+#endif
 
 struct target_elf_gregset_t;
 void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 32a9eec431..f05b1d4dba 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -13,6 +13,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_GUEST_COMMPAGE     1
 
 /*
  * See linux kernel: arch/x86/include/asm/elf.h, where
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 07d83c674d..0ba75a83b3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -145,27 +145,6 @@ typedef abi_int         target_pid_t;
 #define ELF_CLASS      ELFCLASS64
 #define ELF_ARCH       EM_X86_64
 
-#if ULONG_MAX > UINT32_MAX
-#define INIT_GUEST_COMMPAGE
-static bool init_guest_commpage(void)
-{
-    /*
-     * The vsyscall page is at a high negative address aka kernel space,
-     * which means that we cannot actually allocate it with target_mmap.
-     * We still should be able to use page_set_flags, unless the user
-     * has specified -R reserved_va, which would trigger an assert().
-     */
-    if (reserved_va != 0 &&
-        TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE - 1 > reserved_va) {
-        error_report("Cannot allocate vsyscall page");
-        exit(EXIT_FAILURE);
-    }
-    page_set_flags(TARGET_VSYSCALL_PAGE,
-                   TARGET_VSYSCALL_PAGE | ~TARGET_PAGE_MASK,
-                   PAGE_EXEC | PAGE_VALID);
-    return true;
-}
-#endif
 #else
 
 /*
@@ -1215,7 +1194,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #else
 #define HI_COMMPAGE 0
 #define LO_COMMPAGE -1
-#ifndef INIT_GUEST_COMMPAGE
+#ifndef HAVE_GUEST_COMMPAGE
 #define init_guest_commpage() true
 #endif
 #endif
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 12de1c54c7..1e7000c6bc 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu.h"
 #include "loader.h"
 #include "target_elf.h"
@@ -21,6 +22,25 @@ const char *get_elf_platform(CPUState *cs)
     return "x86_64";
 }
 
+bool init_guest_commpage(void)
+{
+    /*
+     * The vsyscall page is at a high negative address aka kernel space,
+     * which means that we cannot actually allocate it with target_mmap.
+     * We still should be able to use page_set_flags, unless the user
+     * has specified -R reserved_va, which would trigger an assert().
+     */
+    if (reserved_va != 0 &&
+        TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE - 1 > reserved_va) {
+        error_report("Cannot allocate vsyscall page");
+        exit(EXIT_FAILURE);
+    }
+    page_set_flags(TARGET_VSYSCALL_PAGE,
+                   TARGET_VSYSCALL_PAGE | ~TARGET_PAGE_MASK,
+                   PAGE_EXEC | PAGE_VALID);
+    return true;
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->pt.r15 = tswapal(env->regs[15]);
-- 
2.43.0


