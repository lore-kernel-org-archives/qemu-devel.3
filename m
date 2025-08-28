Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F709C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJC-00005T-N6; Thu, 28 Aug 2025 13:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWS-000889-Ud
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:37 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWI-0008Kx-7H
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:27 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b4c53892a56so802825a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383260; x=1756988060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQHCDU/pTSK07tMwn49XfZ5g/Bp/iGqsx66exuLr2Ek=;
 b=lbqO+yw0I6CRnStSmJny8wentHQ3Q+DhVbxJCydyx9GkgDmkiYxdULvLjxr21tWqtu
 lkZOrBqkd9QZRbeEEJI2A6js3cSrMseYtnVMPgMF7TnQ9N7qJh6AMKaDmMZBz355D5tN
 Pkzc14+W0TKH0JCdZgKR/mt+MTGD0mu4YHBNL1SpqqQBtcpSqrkVqbdpXm4oUF+v8s4p
 tcDWzHfdepY0T8TxdcivsSXhPO6vxwzzANwMGw2zEt8ne/duPXn0c8NdPJvl6Cy8IeS7
 90qhgMNPkeNiXlsaL+S2sw449m6ghAoK6Pr7tMxKSBq2nvhllXpzdxl5N6zAwAJRLhAl
 UbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383260; x=1756988060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQHCDU/pTSK07tMwn49XfZ5g/Bp/iGqsx66exuLr2Ek=;
 b=hk1hL2l4RnKnec53oczzXreCcOAxOPwdlYze8C5FAsZEOUcdaiEfeRFPjVNj+OsfL6
 6IvA16DzznjWfWmetQUN54Pg9k3qx5zI0mKDqPojP3my82mMskgNeQH0Uh4SaqpuzNnH
 A9yUveIj53m4htawAMG5SCsFR+xCe1Ma0OdW0hesIQ8lx6XUyqHTuOdsHnMxkaanTWFW
 VktLG3tqlzo4H15eDmoq1PbhP04VPnYKsy9K5dZAZwqmWAYL5ePD7toO5mHrpjqbba8L
 xcbJJOrj1xOeOql2VKN4uIYX7Now1if1JEXcL9UdhX7Zmcdv9Dii7MrHC10zJVNKX6p1
 Sj+A==
X-Gm-Message-State: AOJu0Yz88ohNfDbXPHcUsn+FiTuzn8fBYx/V1Ai3ka6EAWgW7NTCIR2W
 nOuNjs8GvUS8PmUki7IhR5d6NtSA0Ihc6f++A6c1wIcEdRV9Ixin9AaOwTILoD56LEu8kp84iug
 HUiKRpO4=
X-Gm-Gg: ASbGncunIQvQBb6L3sPoJo54h1xoIG1k3DUzSt7NmaKsWmf2YFPdzCSVA8B3biWQGod
 FoX0e7rqFPj5WlRmN3rLSEdNPt+TXkZ7FWi0x+pXJ7h+rAknCUpmzWcyy4UG78istiu6oj0cFTk
 Wd1xw7SJ/zAWZdEwfdbcf86Vl+vzM8tYOaLuhnJoPtxxj2E1c5RIPJN8109k62T2VFsT4Vxns+7
 0TNf9j1IlNZYBcOR3FTivO9QX6ueSvhBiMVyn7AjX6zsOwcApjNP52mfYVCK7Qk2DjRHqvPwAya
 y3Wy2E2ThPmyH+sUZJmaRCXJasYmbwlq0qmn7XyU7E6oQlKezfqTrxGCZiqkWAfxuIGC7jm8kdu
 SwQkIhBvW9PRN+c0Vbd5xncwYdaXyh50AVU51r4obu10JL+0=
X-Google-Smtp-Source: AGHT+IHF81uD5MsSVSTAEayLAIRktmabSGF+w2l8vVTuCiTaHgrSJ+KfYyXh0U3Gsl5q+2afIgXOMA==
X-Received: by 2002:a17:902:e745:b0:248:9429:363a with SMTP id
 d9443c01a7336-24894293a0dmr77462765ad.9.1756383260600; 
 Thu, 28 Aug 2025 05:14:20 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 58/87] linux-user: Move init_guest_commpage to arm/elfload.c
Date: Thu, 28 Aug 2025 22:08:07 +1000
Message-ID: <20250828120836.195358-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
index 726d3ec25c..a3f14af691 100644
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


