Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEBAC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLP6-0005Gw-3m; Sat, 02 Aug 2025 19:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOQ-0003mo-9U
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:06 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLON-0001oC-F2
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:56 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-617744621acso485753eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176314; x=1754781114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gziFnQYyx9mUDdCD6TJ2eXiHZRA/1XfntIJ0wwd6/FA=;
 b=bzOyLLDNZdncHH8mS/Mnm2w8OzEuYhr5/22UIoPKA5tLq2nWtT2UESPVG25MuA9Fc8
 0Wu42sqgMsgaWeYDLQ+pK6UX4nqpGqG6QIbzsQLLetijVmR4tSKL5cmvOtPdMpspb5oq
 50b6roMH0LeasG70sqtmYYHcUKUmqNxizRKe6nUf60P4A75FccbHYiQIut8xnu5WTB/t
 SOAkMGBvzZ0AXkE4uTUoaDwAJ3WM7cFpFo8wF4ddPUc5X9pMak1PDCyLUx/Bybc4DGuw
 q/SjgN/5FKpIxOquTG1Kpo6GRqB3VhgU25axAWb97p2oglPspSx3DLtH+gz+CqlrdOO8
 RaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176314; x=1754781114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gziFnQYyx9mUDdCD6TJ2eXiHZRA/1XfntIJ0wwd6/FA=;
 b=R7z8+iQsJ5hguaul1GWxk30M5BNpXCRV/mULoXtQO+7JxHzxQrRellF2wqDs8rZgot
 0J+ZuDtxU+poa4nBpnZ1rxF47jTKhRaJoff3H8OvnZMFT8bnonRzG5oaRYO2bf50AsGt
 4bTp3fCTYK3vvaUEzMb/wYulARG+HDuTkgNJBO2oVSpjkdElG+zl3dnOBljGTWAmdjrl
 Kfnhm/JSF7QtOHd28Q7g9r20H3yEf7XYSEZGpZPH1Yhmq9hXaUi1nSTuxaRaTidWs/R6
 jWUpg2HWa6v3fKL9wUt9sKaLO+CNQ2nblGllaGwE33dcBrDVnwioysEexowVkdit89O9
 LrBQ==
X-Gm-Message-State: AOJu0Yxd+XOodMB/k+awXUpjdEQPRRtWUXzSlJ+npbaB1l9hmTwi7wLr
 xs5bGoaoit/t6+8EI26vz/K2q3pYWsKhO0dMZeiL/hKteJi2CBJnN0UwZfN2/CeSOvJFLo/qG/5
 +nqsHaWA=
X-Gm-Gg: ASbGncvluNa6lQIRcH3E2DIHwWVmrE6RHdHknUBpvgvVOn6dzAcj7z9kVoygGfAJwFN
 iZSYfXxPIdv3EaCMpsFn5wfUQqyQGv8Fa+azH++E7SmhRRxlp5aUhSq0PObrYqaMsklrislttYi
 gk2jAXd6HeOskS46sBpp7cTv+ukj21RZTT7WHVw6n8TqGCjx07IN+07XOesSfJ7OE6j7LV+gcRs
 Fu8VxWOGtUIJEax1pommzXe9DnMFZQh8XGMYFemjKgDx7GBW/2rnHC3zF4PhRJzuNPrXfcyqfFS
 a41nbm+ZUG5OXEsecj22TW8T8hf0HQy3cGa0a2YwbOOpxyrOwBzyx8WZohuHMe4JF+ByeqtnLji
 lm0sAZu5e8BJsqhbX0bYM1+sfI07XLoBIRr4uE71AScTACsxgdBwnKTg6FmQAwPo=
X-Google-Smtp-Source: AGHT+IFMjXmjiW2jUQDmHMyo/aapxNzJiDlMUwM8EagOH+d7TieHYqGSUE/eghmYlUQ+/TTAv/DPIw==
X-Received: by 2002:a05:6820:2187:b0:619:9530:87e3 with SMTP id
 006d021491bc7-619953089e1mr2297948eaf.1.1754176314241; 
 Sat, 02 Aug 2025 16:11:54 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 63/95] linux-user: Move init_guest_commpage to arm/elfload.c
Date: Sun,  3 Aug 2025 09:04:27 +1000
Message-ID: <20250802230459.412251-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 linux-user/arm/target_elf.h |  1 +
 linux-user/loader.h         |  2 +-
 linux-user/arm/elfload.c    | 46 +++++++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 48 -------------------------------------
 4 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 84c7950ace..c98d48745c 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -13,5 +13,6 @@
 #define HAVE_ELF_PLATFORM       1
 
 #define ELF_NREG                18
+#define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
 
 #endif
diff --git a/linux-user/loader.h b/linux-user/loader.h
index efa7f9b64a..a12a07039a 100644
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
 void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index b0d4dea591..0c18cde12e 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -3,6 +3,8 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "user-internals.h"
+#include "target_elf.h"
 #include "target/arm/cpu-features.h"
 
 
@@ -200,6 +202,50 @@ const char *get_elf_platform(CPUState *cs)
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
 void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 {
     for (int i = 0; i < 16; i++) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4ff360b43c..6cc2c498c8 100644
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


