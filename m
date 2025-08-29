Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62676CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkB-0000pt-FM; Sat, 30 Aug 2025 11:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bh-0004aH-Jt
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bf-0003hD-E0
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7722f2f2aa4so1416251b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506601; x=1757111401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwqnKORhrH73/9/V7Ir0ecWiuCaz2yy8YxhnqnhXci0=;
 b=afZpGtMvN9lDvQA3QQCc5iXqrf18+g9Ndd7w8CCBzgGqc5ZqGqND1BG8sUMa7td4AZ
 4eLgsMA6NfMZzbuIrfvPEvVLwbyMBPXwNu5xZojwW4OHbdh7uuvo24E4oPOghhp/rZfC
 5lyZkwhAgHJAUiofB/x64y+8nKM897vnQ8umjBh40UJPH11Jhd4LRZihDY1j0hBPKfsC
 bRQPYDU0FrxaAlQUojcTLppjWqucBRaViBhGWITIsnOnr5lh8kPaxYzZjOevYgSgM1Rv
 cu225QjWUe/+J9ck8NhfJErucI2BHybuy3fbIMS5AvpOoN9lrEqpKUHou4R/7F5Sq+LW
 1NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506601; x=1757111401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwqnKORhrH73/9/V7Ir0ecWiuCaz2yy8YxhnqnhXci0=;
 b=gM1Bax5KkQhzS+y98/BgUiVXS4Cyw5i4JqyGMjSWVEBb/kM3BhGOdkfjuuq1eq8sKm
 gbFxVxtTA6y8PM2WXO6Qxs0YgvOp4NXyZAiImp6RwN6lLgms7sNU3osQ6M51K7XVSpsa
 bSRFrHYZO83OJRpg7g7pCVRLblgUtacLEMQBeECFjKtt5Bb9oRNn39WsiPJQiHbWDlzO
 qbHWLdJnZl8znBPXOo8gqIfjyDJZMpqW5B0BaauoF8rXET+g9F17kDsu1+BWsbJs5Z/m
 2d2jpOqujqo1hRewUHAdfKzTXnoxgDNcxg+V/QsI/82ivOpCA3H/ESxl4m72oaXC56JO
 tvNQ==
X-Gm-Message-State: AOJu0YwEiLqg4j7YjZ9Fj263I6Jwo7PWnKfAqbaat3JhZd4zJqF3IewP
 kKvadeag9Ky4OWkrHHJ5ILGf/LaQxvvE9HRPftmKGEUWUyxFsb8F+CRo0OGliO2TKXvsI8SzuO5
 oDMatsHA=
X-Gm-Gg: ASbGnctjyM5jWRFHi2BCaTWGs5qFmBIjVcya5MvER57BAZjPxabW9LlEwns8WOvT/Kb
 rHWXC5iOitwZRz8sUctmaH6oEkZrhZE//ospPh+eXUfgnOwDOCzAtyD+O+rECoHSu/8dRR8jfAp
 uynGqKA4kNwdze/I6JbMKQA5/ScJzBQLfVWulzyF6AvacoQR7YPe9AFLC5X24gNY/27smq00bzF
 DE9GNO25oA9pZ/MrCsZohGJCIG40uyLP+FqhT/LH4lT4KtMINfnE7Ftkg9r+7vMy9RZV01zsVV7
 vWzLm/THIwwkrJqDa8LaqUBGydHi3TGGYLgwhnXwMuAjlBbdbZPvd+dZM6dflmdqgxJyhmIZ5vX
 lX1+uKT7qnrwE6JrD62Ue2scGXU8BJjeemRgv+lzStAx9GPADUt2HMgD/jSjOVrg=
X-Google-Smtp-Source: AGHT+IEYCYqgou01c8+SK+LIwu5csiILMNPNa+WFuTFTsMuBmPq+SeluHW0/Wg5/sLHlfklGMUfBBw==
X-Received: by 2002:a05:6a00:1786:b0:76e:7ae5:ec91 with SMTP id
 d2e1a72fcca58-7723e3bf26bmr267594b3a.27.1756506601470; 
 Fri, 29 Aug 2025 15:30:01 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 61/91] linux-user: Move init_guest_commpage to x86_64/elfload.c
Date: Sat, 30 Aug 2025 08:23:57 +1000
Message-ID: <20250829222427.289668-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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


