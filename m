Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5E0F8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn30-0007He-Ci; Fri, 17 Apr 2026 13:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2i-0006v4-Im
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2d-0002L5-6a
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7605ec91so794039f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447102; x=1777051902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1XLnzDD++kcgvvN+mJ7kGySfBQkB+0ZpLjBuZfsQOc=;
 b=nd3kD9WYhfSwEHrxEgF8A2n9dTYsOl8zZRb3zMzBON8DT1cgJvbydfcyPWNEeXI/OY
 vnT3OHyhcULRGvNuDMQDsZ8fUNevFsS7MOzqGF/EX4jKz1MORgp/mIt0uvWf9Np2N7hi
 AkQ7vLMi5FXSPCTuh+iTFBhi86r7QZOJz9Gz1zlELASMdyaxGKzW6VmHOlnZdaby18AI
 su4rELSc+g+HaEyLgIVPaZE0ixZQOxt2jeWazpYqMIZXO10c42hMFCSprZHdbammcub3
 /Z+HelNM8FMYwYQnsp5vIWgb4HwQTEurX4YOlKVll3r/Oz3tp+U4Om30GviMLfT/E1Yc
 woPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447102; x=1777051902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1XLnzDD++kcgvvN+mJ7kGySfBQkB+0ZpLjBuZfsQOc=;
 b=fng7SW5S8RtYzkcBSoTM9gWx2awGZJi3kHYgJ21y5fXe1pk1dyj6lAfDZm/zVI73LS
 6FmCka3kI5ud23S55bTbl68iQgMZ0Dr3LKwdBGfxI7jmuqJ6b4L4zEp/kBtpVP2wIXry
 slIpnUtFDbIBpN80DD1tM6mJupGbLhmx4mMQpM3R1qu87sBjvKRLKZjMdcSJTtq0C855
 Lte6JeHg2qsL3Ov3GK9+5lQsiYChYR9vjxXbxGpDzuTRblJcH0CZRLv7+2lHA1iUcaLB
 jDobB3/rT76+Yy7IiYp+cOz9byiGzdYyQFjgqroKsUw3aCacE+lGvfIRY4BDrYaqBRtN
 fGnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lWllCAHqZ+GuKRyPD+TwfyVANz9jhEYcD6lNLC1t6g5PuQcaq/m/Ax26H2qBn6v/jCj8ifs7t6pOG@nongnu.org
X-Gm-Message-State: AOJu0YzNaeTCE2S9mnjwscB09CHXqU4zDKeuu+6QIsiFSN6DI4gJw6hP
 pT363LMx3iDjUzWxGOiNfESfjQgkUvTOrPeq5SgElMkpbqbJpsehOEVkQcimPt/Cqnw=
X-Gm-Gg: AeBDiesqSbB37MPHzNV4wIwVKiu5aaD7sfTK0NuwWE1uGE2LbCOSqAFiBd8YzEh9klZ
 yjnTS6i+u8Z1nAJMtY5/Pw43ySnQXHgNasCQonkZ6hNaSLEys0431Thkdv/RNm3TCEkj5DcBrP2
 SbEYA+WpmPagI+yIRVg+XmyLShQYomFU46Sz/304+srWdBgh5WrYU5tCpu7Vx+lDa2cE8lHKIzi
 XpJivFG9Op9Zab0IRQMdLb+paLXBR4iACEBzj7N8Z1lngfTnypVGGzzjnLRYCQfuFJ40DYwPEI6
 /mz3e4ylW1wNkkaEnXrY6eLRD4N2WgbvE699LlGSUkQ70wBs/JvymoVugfTflRMno0ZAPijWtSN
 sUbB0tOZNkBievpqP8APnju97P3tjGBi76PjjXPB1VP8M+nNIq6qI+15K/Yc0nHlLFfZMOSnxxP
 lGCVVgOgchbHuupjn9hBxen8kyb59HzwGJLyMRh6wxEv8Dyl7GOJP4drTv7W2LfW+gnb81VlSFg
 zi42W2Sx1z4fsMNERlEAokf5ngR77b2EXCp1b8kjQ==
X-Received: by 2002:a05:6000:25c7:b0:43d:71b:204b with SMTP id
 ffacd0b85a97d-43fe3e1433emr6138994f8f.39.1776447101514; 
 Fri, 17 Apr 2026 10:31:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 14/17] hw/core: Implement new cpu_translate_for_debug()
Date: Fri, 17 Apr 2026 18:31:02 +0100
Message-ID: <20260417173105.1648172-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
---
 hw/core/cpu-system.c             | 32 ++++++++++++++++++++++++++++++++
 include/hw/core/cpu.h            | 32 ++++++++++++++++++++++++++++++++
 include/hw/core/sysemu-cpu-ops.h | 27 +++++++++++++++++++++++++--
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 05c126ecb6..cab65d549a 100644
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
+        result->lg_page_size = TARGET_PAGE_SIZE;
+        return true;
+    }
+}
+
 hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 0941757c55..084d691e6c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -778,6 +778,38 @@ hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
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
index a87c55d922..8625ebb564 100644
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
-- 
2.43.0


