Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED6ACD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShJB-00033P-P0; Thu, 28 May 2026 16:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShIU-0001r2-53
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShIP-0005Xo-3d
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso64875385e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999934; x=1780604734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BDOgqoOGucIqtzn9iaM6xKaLbloEdhZE8KyBivwE2Ug=;
 b=HkWZpgJ+rJb//25/T7YJ6tfkNbFuqR8b1koadqdhRoNZIznxylLhul7cQ6hVk6tTyf
 BL1YxIYRPEs/jc20xvjdJegVxcDEPbzYHjg6OAiOtdVRPZ/pjBZWguL97QJzg1AWurYM
 Ww5AM0etCaxiEg3lxBSqMQ0DpWwD+WgQm2JYy1qMzSc6ZXPV7S4NF3qTYVy1ivRmSxIl
 1EOHl9KDQEVu8c4tbM9DARMI+NsW757qIHAZ1O/PsvXsQ/BoszQJ9BGOr46TGE+Z9V93
 itzVdhW3FnFsrWLhgDCdtZcH83SVhwbSFHqagD7EUwsRMFtf82o2DBszctUmedL3MFWf
 5QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999934; x=1780604734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BDOgqoOGucIqtzn9iaM6xKaLbloEdhZE8KyBivwE2Ug=;
 b=Hn5cYoPcCgJ0RdT2tf17HGyp3GxXUEyz75TFwb8CV9HChG7YuAO8Dt9QzMOgcf/hOx
 QelINQ0GV4isd2EB2dv7zVH/dWS83mK7hGDOqpU5mOYaXANIjNsPBFZDsAL4Ph7UeNXc
 Foq+zZivaPzjvj3NLKjS4o/KgPdvER+l94j3H1NPUYVKO9wGKiAQKxK2TaeHzyPiEIrk
 TYCe0Kb//NwYJQkyyA5k/iJR44zZNFT+DxfgbORhOc3rY6piWKGOW5M3BuIq3wiXo0ms
 KtvPoyLWPiWVGqDHz/o38jeWQjPZDYzEXVBKOiZxPvrhSFoKhTQ/7V5M4hyodtACtazt
 ygog==
X-Gm-Message-State: AOJu0Yw05pbTK7fIWuplKUGSWhZbf0hOfjVEEw4rKy9PBVyKE0jTyIfw
 qSL4Td7k2kpb1gcMIHsg3/6GYxgSpC7OixBgSm2ZatrbCqH0FvGkhwlUXl5w9AEBFSAMQmkXeD2
 JuyJutzeYaQ==
X-Gm-Gg: Acq92OGd8Y88IkCuSF31AZ7w/GJ3zscB/3xZYMbfCwV0/MiHvmYBQJTFS5WEzT7bqHx
 sowpD3uvfN7l2c4pZV/m2820lQdVqST2SN66XYUwLa29m3mKn2uWbLL80zfdvlg195ZaLCLyYr6
 OJUnDLw0K6+ogk7ug1PsJK1qRP4rHp9RHo1XXOkHKDtcT7jdxUNGM2R4sF4xk/LWwzECXH8e33H
 QaJEx/lEU0zFlwnjwbTJshDpf55BC15PBnHqd2+kamfxwwKQvcY3QU2I5b2cg/pgPWmGOWUS9Z0
 Og/ZBwEiQP+m56kiq41fcM/vYlvtT2LFWFMGsGXrnh2kHd2dMtazAnENd1yLd48YzoOvXWutFDP
 LMQ5boT2ZjIgfeU4of4sH3HS3108CiZOgaxQ/CyCuC6EEa74c9ac0Ys6qq0AejgnZ1MZu1gN4CG
 4m7PY9GutIdSEZJ5OZp0Dy6mOzwMr3uwIWUXv/qhkdr4CLEIayb0J0I9v/CcmFK7nQnw==
X-Received: by 2002:a05:600c:1d28:b0:490:3fa2:1b93 with SMTP id
 5b1f17b1804b1-4909c0aa2a7mr713705e9.13.1779999934272; 
 Thu, 28 May 2026 13:25:34 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed496112sm3923319f8f.15.2026.05.28.13.25.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:25:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/22] target/i386: Convert to translate_for_debug
Date: Thu, 28 May 2026 22:22:51 +0200
Message-ID: <20260528202253.49122-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
x86 and microblaze.  Convert x86 to the newer translate_for_debug
method, as a step towards being able to remove
get_phys_addr_attrs_debug.

The new API allows us to tell the caller the actual size of the
mapping via lg_page_size, so we do that, although no caller will care
since it's always at least TARGET_PAGE_BITS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528161450.3564396-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h           |  4 ++--
 target/i386/cpu.c           |  2 +-
 target/i386/helper.c        | 31 +++++++++++++++++--------------
 target/i386/whpx/whpx-all.c |  2 +-
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bdd4fff89d6..67e2ecf3251 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2581,8 +2581,8 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env);
 #ifndef CONFIG_USER_ONLY
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
 
-hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                         MemTxAttrs *attrs);
+bool x86_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                 TranslateForDebugResult *result);
 int cpu_get_pic_interrupt(CPUX86State *s);
 
 /* MS-DOS compatibility mode FPU exception support */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7248720a0eb..8929a75c7c9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10877,7 +10877,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
-    .get_phys_addr_attrs_debug = x86_cpu_get_phys_addr_attrs_debug,
+    .translate_for_debug = x86_cpu_translate_for_debug,
     .asidx_from_attrs = x86_asidx_from_attrs,
     .get_crash_info = x86_cpu_get_crash_info,
     .write_elf32_note = x86_cpu_write_elf32_note,
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 8cc73f619a9..30f1fa41b32 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -252,8 +252,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
-                                         MemTxAttrs *attrs)
+bool x86_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                 TranslateForDebugResult *result)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -263,8 +263,6 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     uint32_t page_offset;
     int page_size;
 
-    *attrs = cpu_get_mem_attrs(env);
-
     a20_mask = x86_get_a20_mask(env);
     if (!(env->cr[0] & CR0_PG_MASK)) {
         pte = addr & a20_mask;
@@ -283,7 +281,7 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
             /* test virtual address sign extension */
             sext = la57 ? (int64_t)addr >> 56 : (int64_t)addr >> 47;
             if (sext != 0 && sext != -1) {
-                return -1;
+                return false;
             }
 
             if (la57) {
@@ -291,7 +289,7 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
-                    return -1;
+                    return false;
                 }
             } else {
                 pml5e = env->cr[3];
@@ -301,13 +299,13 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                     (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
             pml4e = x86_ldq_phys(cs, pml4e_addr);
             if (!(pml4e & PG_PRESENT_MASK)) {
-                return -1;
+                return false;
             }
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) +
                          (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
             pdpe = x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
-                return -1;
+                return false;
             }
             if (pdpe & PG_PSE_MASK) {
                 page_size = 1024 * 1024 * 1024;
@@ -322,14 +320,14 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
                 a20_mask;
             pdpe = x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK))
-                return -1;
+                return false;
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
         pde = x86_ldq_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
-            return -1;
+            return false;
         }
         if (pde & PG_PSE_MASK) {
             /* 2 MB page */
@@ -343,7 +341,7 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
             pte = x86_ldq_phys(cs, pte_addr);
         }
         if (!(pte & PG_PRESENT_MASK)) {
-            return -1;
+            return false;
         }
     } else {
         uint32_t pde;
@@ -352,7 +350,7 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
         pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
         pde = x86_ldl_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK))
-            return -1;
+            return false;
         if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
             pte = pde | ((pde & 0x1fe000LL) << (32 - 13));
             page_size = 4096 * 1024;
@@ -361,7 +359,7 @@ hwaddr x86_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
             pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & a20_mask;
             pte = x86_ldl_phys(cs, pte_addr);
             if (!(pte & PG_PRESENT_MASK)) {
-                return -1;
+                return false;
             }
             page_size = 4096;
         }
@@ -373,7 +371,12 @@ out:
 #endif
     pte &= PG_ADDRESS_MASK & ~(page_size - 1);
     page_offset = addr & (page_size - 1);
-    return pte | page_offset;
+
+    result->attrs = cpu_get_mem_attrs(env);
+    result->attrs.debug = 1;
+    result->physaddr = pte | page_offset;
+    result->lg_page_size = ctz64(page_size);
+    return true;
 }
 
 typedef struct MCEInjectionParams {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7943adb93fe..e626acef2f0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -247,7 +247,7 @@ struct whpx_register_set {
  *          e. Let the affected CPU run in the exclusive mode.
  *          f. Restore the original handler and the exception exit bitmap.
  *        Note that handling all corner cases related to IDT/GDT is harder
- *        than it may seem. See x86_cpu_get_phys_addr_attrs_debug() for a
+ *        than it may seem. See x86_cpu_translate_for_debug() for a
  *        rough idea.
  *
  *     3. In order to properly support guest-level debugging in parallel with
-- 
2.53.0


