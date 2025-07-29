Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9AFC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucW-0007He-3g; Tue, 29 Jul 2025 20:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ4-0004h7-Mj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:31 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJ2-0004du-Kz
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:30 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76a3818eb9bso859745b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833867; x=1754438667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=24GqgpfMUaaInHcHXkfkkXfG4qIE7avpsYSgsPmLIU8=;
 b=JFtJ1uZx+kicRwHM/o3TfzkTBnle8jgmgERFbbwa+hyKGDqG0KOXdQvXoUD0Z1kcsk
 MCaquWoyi65j9vN9UIqfRLdMvPBSaR1iD6DXlRETvtLtUKamwO3yKc3gvjriABMrw9YK
 08kIna81NvFCcut4+fwuUqG4WXI0gRxtRXPkvEetWLb7QaSo5dc7eEpEtjITnZtdXqPe
 QLvWjpkjyDAONUDHNx7yqJiUayrbXER5l+9LcgnLrcFgngv8IP5Ro20jnlk5X6Phkmtt
 T086Xli3I+bXq3H/0O0zKlcgZjkl0kDbIhJMljvUy04XRagc319RQ3FVmfQFs5eCePIa
 9yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833867; x=1754438667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24GqgpfMUaaInHcHXkfkkXfG4qIE7avpsYSgsPmLIU8=;
 b=dTsveLuIhwlc0yzufS9FDbVuxQMfAZfJqc68g8/x1ZHJb5Cica+Li7nbZ9MsXYVDuh
 pouX21p9cuVVrfg+jCzoMV+voQwS/cWrQKtJeWIutCjLaNhkJ+mZuUXx16gbChjatveW
 z7tYI0N2CL6pgbthCM0k9UsVOqnvZouW/1TAEXFXZSCPCcPJfYIFPvCYWGmV5rO8SY7o
 O/0ejCZlyYyvpGeNWtTBwn4JlNxZ7e7KlzbwlfidFsHdVNeb/sY3yka9fuEMvtja/T3r
 VXjFcPBj4tdTcmO1QbXJTmlVO3EqjTa3ayPtU8/pGoc5qGfrw13Pn8/9jfC5CG8rpSj7
 oTJg==
X-Gm-Message-State: AOJu0YyyfCntPvj3vpbbXa1KV1aE4e/8HbmFrLEY45Ra0keTHd8w9BKZ
 WxyIWJha5HdThC/uOc11fC5FiEJQaY+226iSxZt5tuXTbS9n5pB/Eva04bj2anZPwvOWACXI6yY
 HQd2G
X-Gm-Gg: ASbGncvWCbJgv93vGJsKOmsqiSLACwUppqwb0ghsv5ozWOKT0OmSniO5p7T5C88wi9z
 VZ6EaChRqq/aFhp9yIYn8CZKcIXlyLMTVksCqvlYewjz0rgUgs2yIQ6NZcuBF2tedDH2r34Ns72
 UDYH77CX69g7mxguVkMCVdniG4KjEnd91zZrZmzlJHbxTh9gBLSuvlOA69XuK2AfYhx5wciwWaF
 64w1kTUEOJYz76LZZeWgC8Wswo5WVCqk+KoWJdDL+14w0woJ3F6g39fC32lCLcOM9oyRoW96x/n
 qO/pNBuvdZ/U0VGHJlcYWR4+V7gcWezDPrV5uL1gMXSZJNu5EgNaAG1jcAculaR5MevT1/fCQwx
 gPg2skl9uocSQDz3ogJQBp0oY/DzIBTpWnGoNSr4aN4TzP8yg6SPAx8rqyYXKssZVmVB+ZSE9Vl
 uxKmBtBpYZGw==
X-Google-Smtp-Source: AGHT+IEJVAQ7bwhDf1wJriOJJkiQVhmOgk/k6LNJdPRUZNdWFRynfQJ1PGYfbQDh6UmKE5eFxUxH3Q==
X-Received: by 2002:a05:6a20:4327:b0:222:1802:2dd7 with SMTP id
 adf61e73a8af0-23dc0d57e5bmr2172966637.13.1753833867142; 
 Tue, 29 Jul 2025 17:04:27 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/89] linux-user: Move init_guest_commpage to arm/elfload.c
Date: Tue, 29 Jul 2025 13:59:29 -1000
Message-ID: <20250730000003.599084-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  4 ++++
 linux-user/loader.h         |  2 +-
 linux-user/arm/elfload.c    | 46 +++++++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 48 -------------------------------------
 4 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 58ff6a0986..bb9875fa2d 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -7,8 +7,12 @@
 
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
+
+#define HI_COMMPAGE (intptr_t)0xffff0f00u
+
 static inline const char *cpu_get_model(uint32_t eflags)
 {
     return "any";
 }
+
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index e5e317ab76..28eebf2f0b 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -102,7 +102,7 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
-#if defined(TARGET_X86_64)
+#if defined(TARGET_X86_64) || defined(TARGET_ARM)
 bool init_guest_commpage(void);
 #endif
 
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 8573e46f2c..ad0d88a7e0 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -3,6 +3,8 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "user-internals.h"
+#include "target_elf.h"
 #include "target/arm/cpu-features.h"
 
 
@@ -194,3 +196,47 @@ const char *get_elf_platform(CPUState *cs)
 
 #undef END
 }
+
+bool init_guest_commpage(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    int host_page_size = qemu_real_host_page_size();
+    abi_ptr commpage;
+    void *want;
+    void *addr;
+
+    /*
+     * M-profile allocates maximum of 2GB address space, so can never
+     * allocate the commpage.  Skip it.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        return true;
+    }
+
+    commpage = HI_COMMPAGE & -host_page_size;
+    want = g2h_untagged(commpage);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
+
+    if (addr == MAP_FAILED) {
+        perror("Allocating guest commpage");
+        exit(EXIT_FAILURE);
+    }
+    if (addr != want) {
+        return false;
+    }
+
+    /* Set kernel helper versions; rest of page is 0.  */
+    __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
+
+    if (mprotect(addr, host_page_size, PROT_READ)) {
+        perror("Protecting guest commpage");
+        exit(EXIT_FAILURE);
+    }
+
+    page_set_flags(commpage, commpage | (host_page_size - 1),
+                   PAGE_READ | PAGE_EXEC | PAGE_VALID);
+    return true;
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 297151e4fa..714b70757c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -208,54 +208,6 @@ typedef abi_int         target_pid_t;
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
-/* The commpage only exists for 32 bit kernels */
-
-#define HI_COMMPAGE (intptr_t)0xffff0f00u
-
-static bool init_guest_commpage(void)
-{
-    ARMCPU *cpu = ARM_CPU(thread_cpu);
-    int host_page_size = qemu_real_host_page_size();
-    abi_ptr commpage;
-    void *want;
-    void *addr;
-
-    /*
-     * M-profile allocates maximum of 2GB address space, so can never
-     * allocate the commpage.  Skip it.
-     */
-    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        return true;
-    }
-
-    commpage = HI_COMMPAGE & -host_page_size;
-    want = g2h_untagged(commpage);
-    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
-                MAP_ANONYMOUS | MAP_PRIVATE |
-                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
-                -1, 0);
-
-    if (addr == MAP_FAILED) {
-        perror("Allocating guest commpage");
-        exit(EXIT_FAILURE);
-    }
-    if (addr != want) {
-        return false;
-    }
-
-    /* Set kernel helper versions; rest of page is 0.  */
-    __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
-
-    if (mprotect(addr, host_page_size, PROT_READ)) {
-        perror("Protecting guest commpage");
-        exit(EXIT_FAILURE);
-    }
-
-    page_set_flags(commpage, commpage | (host_page_size - 1),
-                   PAGE_READ | PAGE_EXEC | PAGE_VALID);
-    return true;
-}
-
 #if TARGET_BIG_ENDIAN
 #include "elf.h"
 #include "vdso-be8.c.inc"
-- 
2.43.0


