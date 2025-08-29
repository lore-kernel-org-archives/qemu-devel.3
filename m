Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0C0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkF-0001Dj-WE; Sat, 30 Aug 2025 11:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bk-0004lr-68
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bh-0003po-E3
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so2552711b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506603; x=1757111403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKxMYOztX3yzcXwsVljsK6LJXRCdoI1IIVbZGiH0hNo=;
 b=I0vAozCzejMpjIWRhezJ7fufE7YQf4aDul2YKe6rPDRSVFw2TsJe9BJgQpVajxCmvI
 DAhaUkr7e9l5kwkodumbuuzugwcT7eZwx2+xi1wA7NCc4f4PjkV6jyneOiRlq+yD8AuM
 IUioVIyes7lW/onpIPeZsLcyjfti2gzBcNz9PoOrmLPj1iJL+ULvSVrThbWaUpgP4ckN
 zINytd6uHKhvaAwRWo1yq546+i6ZKZdeOUd4k9ip3vBcSCtwZ5smf5frQNvaZ0qrSTgD
 N6B0K7EoRNMe55iYJjPLTn/E8LCqjsTIn/QL0M/oLF7h8hT8OvhgLcwE/hQczcVO8ho9
 EZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506603; x=1757111403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKxMYOztX3yzcXwsVljsK6LJXRCdoI1IIVbZGiH0hNo=;
 b=SCkIS4gmbcK+uCfvSIh/E34L/vsdeCO6ii/1p8OBsBFRaTEmnC7pYhhgPpLKspRax0
 i85VKA+lBszQOJufitCMu1qhz5bxE/hNCd/FwVm45aWlrYIXUMhbrZeNjyK4lItMWaFB
 magmvH1FOIRo8oaYDbw+eQDeQWdzVN8shpm07ei6jKlzUt2OVJOKW7hWozAGgD6SdkG4
 xC7eoABpHAM8/v7ZN8B1Yb+AjRbn5t+JwBITxh0td7I9pEvVLouI/uuBJhuTT0mys5W7
 v4A4kP44OMDei/QKK0BWUJMWcyMcXf25iMRGKS1Bx6hoxEoiALFU3ytehmYHqMFRNXVZ
 m3LA==
X-Gm-Message-State: AOJu0YydojApRvH+xFJNFDyLtGY/P2UT8feHROeAvgB8uqn8RUA8Tz3P
 bilFbWM3gm9HMTAxoDOqkiGBoBNOuSQIZdCq4yW3OzuAj8/7ZlwkBipbLttSkNXQ4+F58WYAD93
 hh7oyj/g=
X-Gm-Gg: ASbGncvYTxjNJBLmAJO4kKoQ1liVDUvHcdJQstlv9dLmfnp31TxRgMC5ZEKHkaRfptM
 B5Bmc3oAGLjRSJiLorN0eD6x2cW5ctkucBVilCIVomF1N9CaPO5Cf5hJQhkLp3qgWoxBgNsTGKV
 /8O3og3wZzsFZa71S8U99G7vXCg4rWzPQupDnMANroJxEWQFsW5WDJdAgH6Gpvz+7MdFCY73gfY
 PC3+mEVePMZfFXIm4uIXg+D4N56sgoELt4NKH7HonSie8BNaqg7kpfDmTgoe83Il6KtAs/rgAXY
 j4lnVPIL9I/uKEA2paLHkrFtjpovcZyiZ61MOvsy9SDmJPLO/J8jgH5A7SGfCgVul3XwZPATYiZ
 BQRVl5NDFINPAvdRl6gj56J1jRhwdzyGRI7XFiH8FcAfSNoi0YT9hE0V2gGgCF40=
X-Google-Smtp-Source: AGHT+IEdmH8gDzbPE7uBp5Nvdn1uSzcedWmXetOh73odoiu+kw1t+SpOeZQ7mc+G9DSQ7QKsCX5oEg==
X-Received: by 2002:a05:6a21:3396:b0:243:15b9:7655 with SMTP id
 adf61e73a8af0-243d6f40f0dmr271666637.47.1756506603628; 
 Fri, 29 Aug 2025 15:30:03 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 62/91] linux-user: Move init_guest_commpage to arm/elfload.c
Date: Sat, 30 Aug 2025 08:23:58 +1000
Message-ID: <20250829222427.289668-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  2 ++
 linux-user/loader.h         |  2 +-
 linux-user/arm/elfload.c    | 46 +++++++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 48 -------------------------------------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index fa8f8af2f3..5f81a43efb 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -15,6 +15,8 @@
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
+#define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
+
 /*
  * See linux kernel: arch/arm/include/asm/elf.h, where
  * elf_gregset_t is mapped to struct pt_regs via sizeof.
diff --git a/linux-user/loader.h b/linux-user/loader.h
index 98015fba7d..0c2cc556c3 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,7 +105,7 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
-#if defined(TARGET_X86_64)
+#if defined(TARGET_X86_64) || defined(TARGET_ARM)
 bool init_guest_commpage(void);
 #endif
 
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index f811c2f07a..1205687976 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -3,6 +3,8 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "user-internals.h"
+#include "target_elf.h"
 #include "target/arm/cpu-features.h"
 #include "target_elf.h"
 
@@ -201,6 +203,50 @@ const char *get_elf_platform(CPUState *cs)
 #undef END
 }
 
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
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
     for (int i = 0; i < 16; ++i) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0ba75a83b3..2281853c57 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -191,54 +191,6 @@ typedef abi_int         target_pid_t;
 
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


