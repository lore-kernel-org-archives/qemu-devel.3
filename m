Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A15FCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYH-0005FR-Ol; Tue, 12 May 2026 02:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXo-0003O5-5t
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXl-0006Vh-6f
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so3936263f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567075; x=1779171875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gpqMw9xzJUg2xwtQ6X1M1U6pkAxJFkLGShNka8IQ03c=;
 b=mYytlnCSVNM8GyKkA+ZbxBb6x08Ath3AkI71J0TDh0IK4JpUp6bzTcir3veXgf4mA/
 MVVhxwbOxQlHJq008HR1jnMrhJQ6hwh7Jw/CaA1C6NzH9G5TjoCQFJdgoVANm27endcD
 0PrsUuRDOBVxg7lLksWj0ovqjew8gQpKf/4zRd0VLi5Gnoleix5jdy3hIsvyXlxuOaPl
 QhziWa9HkXEGriGrq7LSF2Pl8PgWIEC42f/Kde53VjONWC9XnmMytGYImX3XWTiBGAko
 1LK8NmkjwxoqxRhLS/tgcJaVbtHXIBJfBhg7oUW2L3cLc2m5orz/XLntPOKRu9v2/BO8
 j3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567075; x=1779171875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gpqMw9xzJUg2xwtQ6X1M1U6pkAxJFkLGShNka8IQ03c=;
 b=sfy+eQJ+y9uEyI+jptEo7MoUtsHJycaWltjy85o8/fEpWDLeP9kAn0UsnKCs02EbDw
 4+YRLl3DKa/vPr3gBn7VoXrCGMBMdH0DNEbc6nSWcCmdDzOkGDwicVx5sRaqNRgja2yf
 s7Hv9BRAmj9LPWGxf2T7Tsi3AsFSkT2kfClx4M2EyNZq6c7LzzupHCsg36rFcmW1vGfz
 01ypjeWVkR17OJ5mwP0WBOfykABROG7Aclj4xCOxt9DtRnKIcfiUwng7a2H5rxQtUfTq
 F9e9K1BqER+ELMew9dPs8gNT9/qhRtKyf3uuVBPuyLm2hS7OKypChYlpWKY1PMV2Q47m
 H/7Q==
X-Gm-Message-State: AOJu0YwSXeF4DP+SYcB1/W8Wtu/zTbyWYF+/hWm2eqREiLMNDs/QjKA1
 0pF8Q8Kjtnj9khsHA8lY7Rz8efPCO1J+asP9M5sVJo4qkCWIx2rczd/n606q2f9+4YGA1W0jZFe
 oRjRVOUc=
X-Gm-Gg: Acq92OH97elCw6jb8CaLoA1+RqUj20Xa+JS7f3D+B3RnbP1tsaXhSuLzVW5jzh+G/hz
 9dLncED0N0RW9nHLxzPoTBj7mgjp6+CD+14uFE4t+p33Ori3eooXEcFny+ATJJjo/cy37xArNeL
 c5vebmXKtChBITp8hxN7wTF3s4VyW58f2XRnNheepQ35zX/qv5KnYyrSQw1T7JqDPROz9dSK4L9
 h99a3CULa/6Vrls96E8jzqKykifPk/JDAFX7agxE4tRRToKaQ9h8J7QfqnuwQwj3DNkbH9CMzyB
 sdOpgpLAxGDvWe+zm2CuKz/Nc3jq9pGw920oizw7KMC946L8zVHlMLPPm9N0JqAaICZSVtU+0Fr
 sZcNEbONd8jTds0Vj6I3Vzacfiz62MQRN1irTqEVlNrLy3X0vm/igka+3N8sXQsSwNL/wUtU38I
 rqaiq37FoR3xbbxIeJH4Q9tA0sAwGj8qpNTD9X/+YSvLiWgAApYv3j08tdvmfQS7lZWIw6Hzx/
X-Received: by 2002:a05:6000:18a4:b0:43e:531f:720c with SMTP id
 ffacd0b85a97d-45ac2a0cb0amr3462099f8f.11.1778567074374; 
 Mon, 11 May 2026 23:24:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491da03a7sm30775352f8f.33.2026.05.11.23.24.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] hw/core: Implement new cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:25 +0200
Message-ID: <20260512062142.67998-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

In cpu_memory_rw_debug() we need to do a virtual-to-physical address
translation for debug access.  Currently we assume that the
translation is valid for an entire guest page, but this may not be
true if the target implements some protection regions that have
sub-page granularity. (Currently the only such target is the Arm
CPUs when using an MPU, as in R-profile and M-profile.)

For TCG's emulated accesses, we handle sub-page granularity by the
CPU filling in the lg_page_size field of the CPUTLBEntryFull struct
to tell us how large the region covered by the result is.  But we
didn't extend this to the debug-access code path, with the result
that debug accesses might incorrectly fail because they are looking
at the mapping for the address rounded down to a page boundary.

Provide a cpu_translate_for_debug() function which reports to the
caller not just the physical address and attributes of the
translation but also the lg_page_size for which it is valid.  The
fallback implementation calls cpu_get_phys_addr_attrs_debug() and
assumes target-page-sized validity.

NB: the "return true on valid access, false on failure" follows
the same convention as TCGCPUOps::tlb_fill_align() (though it
is the opposite of what we use in some other places, e.g.
in target/arm's get_phys_addr_* functions).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-15-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260430093810.2762539-16-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h            | 32 ++++++++++++++++++++++++++++++++
 include/hw/core/sysemu-cpu-ops.h | 27 +++++++++++++++++++++++++--
 hw/core/cpu-system.c             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e3436a1766f..a7256aeb9dc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -772,6 +772,38 @@ hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
  */
 hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
+/**
+ * TranslateForDebugResult: gives result of cpu_translate_for_debug()
+ *
+ * @physaddr: the physical address corresponding to the virtual address
+ * @attrs: the transaction attributes for this access
+ * @lg_page_size: log2 of the size of the aligned block of memory
+ * that this physaddr and attrs are valid for.
+ */
+typedef struct TranslateForDebugResult {
+    hwaddr physaddr;
+    MemTxAttrs attrs;
+    uint8_t lg_page_size;
+} TranslateForDebugResult;
+
+/**
+ * cpu_translate_for_debug:
+ * @cpu: The CPU use for the virtual-to-physical translation
+ * @addr: The virtual address
+ * @result: Struct filled in with results of translation
+ *
+ * Perform a virtual-to-physical address translation for debug accesses.
+ * Use it only for debugging because no protection checks are done.
+ *
+ * The address need not be page-aligned; the returned address in @result
+ * will be the physical address corresponding to that virtual address.
+ *
+ * Returns: false on translation failure; true on successful translation
+ * and fills in the fields of @result.
+ */
+bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                             TranslateForDebugResult *result);
+
 /** cpu_asidx_from_attrs:
  * @cpu: CPU
  * @attrs: memory transaction attributes
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index c0e9e726708..441901fae8e 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -33,19 +33,42 @@ typedef struct SysemuCPUOps {
      * @get_phys_addr_debug: Callback for obtaining a physical address.
      * This must be able to handle a non-page-aligned address, and will
      * return the physical address corresponding to that address.
+     *
+     * CPUs should prefer to implement translate_for_debug instead of
+     * this (and must do so if their translations are not always valid
+     * for a complete target page or they use memory attributes).
      */
     hwaddr (*get_phys_addr_debug)(CPUState *cpu, vaddr addr);
     /**
      * @get_phys_addr_attrs_debug: Callback for obtaining a physical address
      *       and the associated memory transaction attributes to use for the
      *       access.
-     * CPUs which use memory transaction attributes should implement this
-     * instead of get_phys_addr_debug.
+     *
      * This must be able to handle a non-page-aligned address, and will
      * return the physical address corresponding to that address.
+     *
+     * CPUs should prefer to implement translate_for_debug instead of
+     * this (and must do so if their translations are not always valid
+     * for a complete target page).
      */
     hwaddr (*get_phys_addr_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
+    /**
+     * @translate_for_debug: Callback for translating a virtual address into
+     * a physical address for debug purposes.
+     * The implementation should fill in @result with the physical address,
+     * transaction attributes, and log2 of the size of the aligned block of
+     * memory that the translation is valid for.
+     * This must be able to handle a non-page-aligned address, and will
+     * return the physical address corresponding to that address.
+     * The attributes must include the debug flag being set.
+     * Returns false on translation failure; on success returns true and
+     * fills in @result.
+     *
+     * This is the preferred method to implement for new CPUs.
+     */
+    bool (*translate_for_debug)(CPUState *cpu, vaddr addr,
+                                TranslateForDebugResult *result);
     /**
      * @asidx_from_attrs: Callback to return the CPU AddressSpace to use for
      *       a memory access with the specified memory transaction attributes.
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 05c126ecb6b..252e90c8fdf 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "exec/cputlb.h"
+#include "exec/target_page.h"
 #include "system/memory.h"
 #include "qemu/target-info.h"
 #include "hw/core/qdev.h"
@@ -55,6 +56,37 @@ bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
     return false;
 }
 
+bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                             TranslateForDebugResult *result)
+{
+    if (cpu->cc->sysemu_ops->translate_for_debug) {
+        return cpu->cc->sysemu_ops->translate_for_debug(cpu, addr, result);
+    } else {
+        /* Fallbacks for CPUs which don't implement translate_for_debug */
+        if (cpu->cc->sysemu_ops->get_phys_addr_attrs_debug) {
+            result->physaddr =
+                cpu->cc->sysemu_ops->get_phys_addr_attrs_debug(cpu, addr,
+                                                               &result->attrs);
+        } else {
+            result->physaddr
+                = cpu->cc->sysemu_ops->get_phys_addr_debug(cpu, addr);
+            result->attrs = MEMTXATTRS_UNSPECIFIED;
+        }
+        if (result->physaddr == -1) {
+            return false;
+        }
+        /* Indicate that this is a debug access. */
+        result->attrs.debug = 1;
+        /*
+         * Assume memory access permissions are valid for the whole page.
+         * Targets where this isn't true should implement the
+         * translate_for_debug method.
+         */
+        result->lg_page_size = TARGET_PAGE_BITS;
+        return true;
+    }
+}
+
 hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
-- 
2.53.0


