Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419F0CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNs6i-00063M-VY; Fri, 15 May 2026 08:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6i-000632-6q
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNs6f-0000VL-Lx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:57:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so101468785e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778849852; x=1779454652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUZU6u71aCwD/4KUkNLJfoAqg471k8NpUAI/K5qb+F4=;
 b=Upc0J5Q81cFquhN8mJHvqeZIHtvNO7RzJZcJLZHRqeljdZ4Ahq1MYmL/YBawsDu1qB
 8sKs3Gy4ILWjYWB5JBBKwX/EkKip4u8kTVPggZjZxMsLVy6oxyXYCHgfsBQ/3KqJxHGO
 JTMrYHISIvqW5lK+1OG4nmeeiGuVeiqOrzWjpTdrCZu/FNUP9UAdGGNX578pwaZ0WjUm
 KHteXICZvwa1eliKXvXOUXBR3nI/9zHQ7kNuiAw9u1tWu5Ewb7eBIcZb7Oe2PIA8Ic3c
 m6g5gy2+T/cLQ6q57KvWOECSnJXqFavH41xS2dU9JUH0L04WWV0MyQbWi84F2azQdknj
 oIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849852; x=1779454652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qUZU6u71aCwD/4KUkNLJfoAqg471k8NpUAI/K5qb+F4=;
 b=g80487rpVLI+EnqArgpiooiTjM5IWQLGAX0Ei2ldzbAxkhg6NIZLIA0K6ddSSV0iz/
 m+ADziNmAcO9sxjTtbTBCPmZ7zRbjJybIHpkY4iUuqEbEmGGjQSQcDlAz2XiTRSqSyYG
 c8x9uBlG+sfYwO4lb6VQDdpfQVQQg9icvhxEi06tDTP8lkSg//EpAeQVJlIl6xZWBHMF
 MwnIdcUxXCwsdqyYMX+OnmYJ47G3o3Q7wQj6odvXJEl1gqRZ3QzgIJIi0QvI8LSc1cOy
 /T1ym3BBfleaFm4E5H/AwbWUaD5sL5d35j3lhCGKzax+Usemd8UzsHv+X2l/rYj4csA9
 iPkA==
X-Gm-Message-State: AOJu0YyXUYoYwlpyZiaXZHGsr6R4CWSdKvLtrEXUvFQhzzx4q/kr/yRG
 VRR2k1Y03f5zI2RW14m1R7s4L/koKGRFBeKFSEGEFS7xMpDo4yCZjI7KcElwNhGrcYmHvlk1njl
 96Mxh
X-Gm-Gg: Acq92OFaqp39LTlOumnJnuPWQVdXZL5dX31F57A40OiX2UiSqRdNWGgag9cIKBcrPnV
 KGTj1w4KtzBl/BnPzhvmUTLMcGoC0Pa7BX/y2ZOECoi7gysEh13vovhPdnL6+Zowzto298oQTrV
 z/IJusjUdIv8I+fMw52idsn82DNcOlU/0PmHcL8eTnoUKxkQVdE4YKtW8WxBY7GQ+AP93e3drma
 cKuWjeyMzMtsQCgN+S3Xo6T/Mmrt4LDHdvW0pNWl2cIhESHnUz9heI2Hcb3EdcNmfXEuATFEeUP
 yvC1Qs+X7UsU+BxVl1/fvG5H7Cv9LhEvEA8g1xDM0j56E/PfQp7z3xOO0eGMZTr8hsecYIyD8mJ
 b0EhXH+Me4KlqLp44tFiC7Misjc3KEoPSGRxD3Nj8XDU3NPDGvSKBYAq07jlzFwE3Zs/q4uRg/y
 5v/Q/nmiWE36/C0U2igJUnX1SscVgisABPcnsRWmtoshe8CF21xOUcBL8VBj+OPY1qQJPPpwyRm
 A8Qd2U7PzJh+tbrAB8Hk5bemfwJbTk=
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48fe60e7d79mr47207735e9.8.1778849852153; 
 Fri, 15 May 2026 05:57:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm57526515e9.2.2026.05.15.05.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:57:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 2/3] target/i386: Convert to translate_for_debug
Date: Fri, 15 May 2026 13:57:26 +0100
Message-ID: <20260515125727.349675-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515125727.349675-1-peter.maydell@linaro.org>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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


