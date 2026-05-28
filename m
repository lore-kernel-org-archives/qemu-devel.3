Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623BECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdNr-000762-U3; Thu, 28 May 2026 12:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNq-00075p-KF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSdNo-0000nQ-Kf
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:14:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903974854dso64287295e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779984895; x=1780589695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FebKDM9BNc5NH/k9G4cK7/ELRPFbVUO7PRK0NV49w/U=;
 b=IXqXKdfMBdo9pJEJpEAuGHCp+3/GWxpFhMHXUO1IIafSjWsKtaXHmjf34Y2uZUVih0
 0d3/8+V+3sJWTDy/+wrK3xYTlz9v0kBAz6ksuS9VQGCZFHQSZ/XaJu13ehiX1FSHdlIM
 fhwI25/IRb5TNgj78+9S+4ddhlui2NUZ+xokELVksFhD+qAG//zLMIwsWN4SakxMMKRf
 NngXY+/FIMqhgF3+hyCwaljD15HSBPS1l7F/8Q4/E/L13OSYIhPIskKl0PY3ztXMzFel
 SXUz5dwG+Iph/LpMrNCUv9/3dy/WhzxIl7dbtnSgIHgInzbwQNfVrkUTjJjbBhp9JNZM
 t9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984895; x=1780589695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FebKDM9BNc5NH/k9G4cK7/ELRPFbVUO7PRK0NV49w/U=;
 b=GBIPAscnUgfOqhjrbqOHcNoTVV+PT/2dnqlEZDgndZnJ2g64ZvTjuA5n2YkA3MGgQF
 pbRMm3/0dWHviSSDRle8wYTzYn8HbcAHaZbmtT+u57oZqTB8Oyddf6NoBVKzBIyAOaQv
 7Itkd8et7oHJYWrCK58Bw6mKAn9lgit7ZNW6pJXvcyESgOTU6dDkIehhvxmhD9ry4BvP
 VvRmOiC200jXv0RmFHMhW3hDA0Oj0LZyRQwJN2LrKNI9ZjhuBYZMQyh/u2+7LGOae2nv
 9gfDYAv0krfT+b5MUkEkFtlqTIkoOORYhhsBkRXsOqpMiuBJO8qnnvO2ktx+nxCn3g9H
 5j3Q==
X-Gm-Message-State: AOJu0YzEPmIGpR9nCDqStm4UwBLheR0NvHKA1QT0Ocr10cwRueG4hNjK
 vYI3RLYh7B2nSRRHGxloUBCd2B4RBbrLRifbb5iJRzJcXyv1sYQc39YUZ2rh6WS+fHMFwCqscJi
 FJwpD
X-Gm-Gg: Acq92OGoI9ojOXjNbeMLdkKW76WE+464pN4cqEZ0F2MkZowVZtwiTmxsG7tkIxJl1uw
 HEr0d+FzaGkdd9lyG+cTFao7RA5Nv2yl3kK3BvaxV9oVKWWudIB6pqn/FctEmbeGlhhUu8mlAnh
 0PA+lWlRC5ca59TVt1asS1rHBG0YOpP2DPiONDUrKp3Cu9Ydm3O07JbjfMfV8f9gzN1NQVU77r8
 0R5OdmOVJ7+1ZUjoBxY6YWL/wGMCOexaT/riwQWxOJeU/MPVQgJf9BhWpxdhM7lHb6qtMc9kGL8
 N9J6/OvA9S3i8taDbdXO6BwW1ddUM6mLS1EszUwJxsLLXdlw/zCmJW1qC4jkvIxZWQaICQGrZdL
 JbPb3U14KkQ0ng7UI9FWcAFTiqOdqzmCUHWq+JWjcBkAyR9JddBx9t0iup+i8V2LZ74RQ+XWMgm
 fvhvJKdkWdJaiEFGAYJhGHXTXjfmxbIcKkBWAaPpFMX3Y4v5LX/M2jv2FXkQxBEIjFXnQ8cawhU
 etHUMGvDTm/blJ4OOSTdGHoiQ8JBvsnYK4XdkPz7A==
X-Received: by 2002:a05:600c:a106:b0:48e:635a:18d2 with SMTP id
 5b1f17b1804b1-490424a0d41mr313867285e9.2.1779984895083; 
 Thu, 28 May 2026 09:14:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b5a618dsm19378805e9.8.2026.05.28.09.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:14:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 2/3] target/i386: Convert to translate_for_debug
Date: Thu, 28 May 2026 17:14:49 +0100
Message-ID: <20260528161450.3564396-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528161450.3564396-1-peter.maydell@linaro.org>
References: <20260528161450.3564396-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
---
 target/i386/cpu.c           |  2 +-
 target/i386/cpu.h           |  4 ++--
 target/i386/helper.c        | 31 +++++++++++++++++--------------
 target/i386/whpx/whpx-all.c |  2 +-
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7248720a0e..8929a75c7c 100644
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
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bdd4fff89d..67e2ecf325 100644
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
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 8cc73f619a..30f1fa41b3 100644
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
index 7943adb93f..e626acef2f 100644
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
2.43.0


