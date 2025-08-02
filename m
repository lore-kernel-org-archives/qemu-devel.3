Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1F4C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOo-00045S-PC; Sat, 02 Aug 2025 19:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLON-0003lQ-05
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:01 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOK-0001nb-Kv
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:54 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-306e88f0b0aso891995fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176310; x=1754781110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7h47KFm+1VQ/a1EaPtWlthuxLynK8yu1DHI+lj2hiJ4=;
 b=Wc9ug8e09/TJIZJ0lcvYZcyhX03ARNKo8xQVQ4zOv9hxxwO+/2qUvp3O/FmXCvia8B
 PsBwXdaUgOL9gsixRCpG8smlkN2wxrQKJ0mP9V/oobtLNLMrBoln5fqzXR0QZ0Qr3bcU
 mxolbs2aqYtyR3xtisR/0pL79sgPgbpbGzrTcQhGCwShp9o8Vuupgm0NqQmYKn5L39BH
 osCDL+7upnGTey/KsB7zrwTJOpeF4ZOFnMLaSHNgctpz3V11CJ5nKUANmSF7l8wDjfv3
 j6SEyxoiANK7LHmKfA1FTSS9q54JMfyxGwRkRp/6RPmEVrqUgZw+7nVE5S82C+aVzcpi
 hKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176310; x=1754781110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7h47KFm+1VQ/a1EaPtWlthuxLynK8yu1DHI+lj2hiJ4=;
 b=BLv6Cfgu0s/LPq/FnlD/Wb9uo5JIJobHNp2yx7jmkl17q9RDXcX2z7g7jwZkILNpO4
 i1mXNmRXWxEUSpdwafK3VGZcP3aDA0hXCjlpJuWH3zBW9OLgQn9mOGb/SzCvU83Rv38u
 ZePJGHQWQ6E/Sy/04ts+Oe7E9BgZGjp5WDUbPhdl86cbO4sJsKeyeqHbskHNaRxi4vLX
 nUqm3Jqp1uJAi/8F8PHZzg7PvGkoqruZvMxm7R/J/S3h4Nap08y6TMYubD9HSB8+GIFr
 t+msVqAYBaJRLT3RkGEtq7rVRI+ffotjF6TdWworKfZX8GrSbKNvtYd4b5SvlautEniP
 6gcg==
X-Gm-Message-State: AOJu0YyC1ICslEiL3ieGSd0MdrTd2aFd7QVNIiWHDGUxXi/j459UlJh6
 M8cbWsVkmPFlSWZBpl7VN1ZZDq/WS/uCemmwodO1EcJB1Fkpsqtf4egAFiIXGyzn8pPoahoTIZE
 1p9+CTvk=
X-Gm-Gg: ASbGncvMhmkv9bgjIx0+Pkc5vK6QCgatVjXQhk+JFMqw+Kj5CuKaaFHrqktzoYSxu/4
 OfVNCi4eYpLLoJCdvj8vTmCTnCReyKOkeAwtrbmgScq1yaTSDARZ7Go9Dvi4B3MmrS4ho34fi1+
 pTp8+52X8U9/fdFENwL+4RnfJLRk9f9rDwUsah1julFP6pPNBsn8TjrBrWUGabKExaDOgPyQkrj
 lwjeCmDYOCVfemxvcxXWgtXBwXO3ZlbnzsRSi7reABcmVt/cJffIKxyP4ekY+Glbpo2bBHiLoPD
 O+d1gE/d9bxs1WVTJIqgQ2QGO2LjZJLCiGZPct+SgTI6enDjJjiP2MaFscFcEwkwsfnybzsgnwJ
 5VrjBniS4/IHVmMAdC1ittadrtLPwj0A4N5qGPYqlpRwJKge8IM/v
X-Google-Smtp-Source: AGHT+IFjWExOUGAZ7E5Q16dnQQb4DLhXrll4O8lWlmzaFOUmDdF3XKcB9ec977Gme4WyyBtu5GRxxQ==
X-Received: by 2002:a05:6820:2187:b0:619:950f:1d5e with SMTP id
 006d021491bc7-619950f267bmr1885822eaf.2.1754176310413; 
 Sat, 02 Aug 2025 16:11:50 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 62/95] linux-user: Move init_guest_commpage to
 x86_64/elfload.c
Date: Sun,  3 Aug 2025 09:04:26 +1000
Message-ID: <20250802230459.412251-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
index 84bb04f9fd..efa7f9b64a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,6 +105,9 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
+#if defined(TARGET_X86_64)
+bool init_guest_commpage(void);
+#endif
 void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/x86_64/target_elf.h b/linux-user/x86_64/target_elf.h
index 3ab10a6328..8c4bd9a3d8 100644
--- a/linux-user/x86_64/target_elf.h
+++ b/linux-user/x86_64/target_elf.h
@@ -10,6 +10,7 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_GUEST_COMMPAGE     1
 
 /*
  * Note that ELF_NREG should be 29 as there should be place for
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3ac0f89931..4ff360b43c 100644
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
index cd7aeb9743..1652a4243d 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu.h"
 #include "loader.h"
 
@@ -20,6 +21,25 @@ const char *get_elf_platform(CPUState *cs)
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
 void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 {
     regs[0] = tswapl(env->regs[15]);
-- 
2.43.0


