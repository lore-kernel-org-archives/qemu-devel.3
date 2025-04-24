Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD1C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tBZ-0000dC-1q; Thu, 24 Apr 2025 05:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBV-0000Mc-2c
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBS-0002bk-0h
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso7715265e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488072; x=1746092872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSjBpDqqccDDSqyByKqT/sgEReyZnqYYvG3Sgb4WXuQ=;
 b=DnpTxx311h8PpZwZoK+2Kq8k6wXNmnzSZP/e+JVICqalEgWYYDIR50lkFwU97csdpk
 j6zP+I0HfTYjmPdXVcGSjyM+9gbsVKakmYMyQAsiotuY3cKcnRWE6fCYG51IkOmZfvBq
 y2sBD6YHoeQz+33VjcFrAcVWejm5n6qUAmzrHD4t4BshVcWzlLyYlLjSy2zbj0RL0E5a
 ectGpRRVUSCx94bmWUjX9mZir7YQke0fa7OUn+X/4pcRTCBc61PrFl7HpLO6y06zIQCx
 kUnV/idu5W9VDc2JUUL2VD5zQo5f3aW9k0pL785XOltSXFJ1LFDhDOXdhFAEECOBQe/x
 4Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488072; x=1746092872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSjBpDqqccDDSqyByKqT/sgEReyZnqYYvG3Sgb4WXuQ=;
 b=uVl2GbwtQQqmCwc8YMsf71dDxyHg1gZE1zbhwKjl/pEYcKOPCfJvS/Y1DLyWXSA7fU
 mgcWbqNo4dXuzp/6s19rRV5rTebFoHvvn4niSE4SXZg7iAbyLuvuEeQmGb4s5CS0dUuO
 4GJorkhRPpfjzFXuRRRgdwnbATKY1BdxlN5BeaRiS42Smu4rDGzAjjW9VgwrWjhxbKld
 Go4yxSCxnOeZHg/UFBqaNpMXTjvsAXuymVZaI5IdrVnfgXkIaHmwxZp68lZiSPaYK5Cv
 gNJ45L3f2xdgHRcxuuCHsylufhSrpjXoc9+U9DZpDHaRIXNK0PM6QL/uF1hUmRtPF8op
 GpvQ==
X-Gm-Message-State: AOJu0YzGWQNJ/ryeMTizI2wcNpWAh1QTMOMqZkZfhGcd12Lwyhio4yS9
 Ke2QY8Ncfg1x1fxPsiVWMt8UakbZ54L6qLAR8IQTkScqfRIBfX+ALovS/+aNe3nSVjNHuRtkvB2
 G
X-Gm-Gg: ASbGnctl8IZWNUo899J2r4caq5jTfZlpZ33rx4gYQ7R6HmA+VJXimks7KI7PRiXNmK2
 sgn5/9kd9356qNPkxzjElVaLXcvOnC0up4VjN33ObhPiwn8ly32yar1x+YpCpmXI/9oxYf6Yuxf
 Zl3Izh577IQVJsNRZDZLND6+s+2U9hzti2xvBZazvEMbXK7NCR3/TS9LioLO7qqmHKlPo2PzP3d
 8q1dUBeHtIlLHU1QjItIuz5s6d9sd54Hc8NBDSf5O2jsuiR4noPYcD3nESCFpgMkyQ3jsG6RYdA
 1OhKcbiJHEtav+7ybEB8FT836b6S8NdUJsBV29vf2Urk3NTHBoTeqDzSuNes0zor0RLfuuLGEeX
 VlkRHVUaRXCfwkCHCe5H8
X-Google-Smtp-Source: AGHT+IGsvXbAm4zH1eU8c5JvFJz08y2NKd4wC/ZCoKZ3ZL92zbltN7jPccaBVDKnNZLbJ+SRv83TSg==
X-Received: by 2002:a05:600c:3b8c:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-4409bd8bd4amr14421365e9.33.1745488071811; 
 Thu, 24 Apr 2025 02:47:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e0414sm13937315e9.40.2025.04.24.02.47.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/13] accel/tcg: Extract probe API out of 'exec/exec-all.h'
Date: Thu, 24 Apr 2025 11:46:52 +0200
Message-ID: <20250424094653.35932-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Declare probe methods in "accel/tcg/probe.h" to emphasize
they are specific to TCG accelerator.

target/arm/ptw.c is the only non-TCG specific file, its
call to the probe API is already guarded within CONFIG_TCG
checks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/probe.h            | 110 +++++++++++++++++++++++++++
 include/exec/exec-all.h              | 100 ------------------------
 target/hexagon/mmvec/macros.h        |   1 +
 accel/tcg/cputlb.c                   |   1 +
 accel/tcg/user-exec.c                |   1 +
 semihosting/uaccess.c                |   1 +
 target/arm/helper.c                  |   1 +
 target/arm/ptw.c                     |   3 +
 target/arm/tcg/helper-a64.c          |   1 +
 target/arm/tcg/mte_helper.c          |   1 +
 target/arm/tcg/op_helper.c           |   1 +
 target/arm/tcg/sve_helper.c          |   1 +
 target/hexagon/op_helper.c           |   1 +
 target/hppa/mem_helper.c             |   1 +
 target/hppa/op_helper.c              |   1 +
 target/i386/tcg/access.c             |   1 +
 target/i386/tcg/seg_helper.c         |   1 +
 target/i386/tcg/system/excp_helper.c |   1 +
 target/mips/tcg/msa_helper.c         |   1 +
 target/ppc/mem_helper.c              |   1 +
 target/riscv/op_helper.c             |   1 +
 target/riscv/vector_helper.c         |   1 +
 target/s390x/tcg/mem_helper.c        |   1 +
 target/xtensa/mmu_helper.c           |   1 +
 24 files changed, 134 insertions(+), 100 deletions(-)
 create mode 100644 include/accel/tcg/probe.h

diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
new file mode 100644
index 00000000000..b748c00ba96
--- /dev/null
+++ b/include/accel/tcg/probe.h
@@ -0,0 +1,110 @@
+/*
+ * Probe guest virtual addresses for access permissions.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef ACCEL_TCG_PROBE_H
+#define ACCEL_TCG_PROBE_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+#include "exec/mmu-access-type.h"
+#include "exec/vaddr.h"
+
+/**
+ * probe_access:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @size: size of the access
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @retaddr: return address for unwinding
+ *
+ * Look up the guest virtual address @addr.  Raise an exception if the
+ * page does not satisfy @access_type.  Raise an exception if the
+ * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
+ * page as dirty.
+ *
+ * Finally, return the host address for a page that is backed by RAM,
+ * or NULL if the page requires I/O.
+ */
+void *probe_access(CPUArchState *env, vaddr addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
+
+static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
+}
+
+static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
+                               int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+}
+
+/**
+ * probe_access_flags:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @size: size of the access
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @nonfault: suppress the fault
+ * @phost: return value for host address
+ * @retaddr: return address for unwinding
+ *
+ * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
+ * the page, and storing the host address for RAM in @phost.
+ *
+ * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
+ * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
+ * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
+ * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
+ */
+int probe_access_flags(CPUArchState *env, vaddr addr, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool nonfault, void **phost, uintptr_t retaddr);
+
+#ifndef CONFIG_USER_ONLY
+
+/**
+ * probe_access_full:
+ * Like probe_access_flags, except also return into @pfull.
+ *
+ * The CPUTLBEntryFull structure returned via @pfull is transient
+ * and must be consumed or copied immediately, before any further
+ * access or changes to TLB @mmu_idx.
+ *
+ * This function will not fault if @nonfault is set, but will
+ * return TLB_INVALID_MASK if the page is not mapped, or is not
+ * accessible with @access_type.
+ *
+ * This function will return TLB_MMIO in order to force the access
+ * to be handled out-of-line if plugins wish to instrument the access.
+ */
+int probe_access_full(CPUArchState *env, vaddr addr, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool nonfault, void **phost,
+                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
+
+/**
+ * probe_access_full_mmu:
+ * Like probe_access_full, except:
+ *
+ * This function is intended to be used for page table accesses by
+ * the target mmu itself.  Since such page walking happens while
+ * handling another potential mmu fault, this function never raises
+ * exceptions (akin to @nonfault true for probe_access_full).
+ * Likewise this function does not trigger plugin instrumentation.
+ */
+int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          void **phost, CPUTLBEntryFull **pfull);
+
+#endif /* !CONFIG_USER_ONLY */
+
+#endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b9eb9bc4b63..9ef7569a0b8 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,104 +20,4 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#include "exec/hwaddr.h"
-#include "exec/mmu-access-type.h"
-#include "exec/vaddr.h"
-
-#if defined(CONFIG_TCG)
-
-/**
- * probe_access:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @size: size of the access
- * @access_type: read, write or execute permission
- * @mmu_idx: MMU index to use for lookup
- * @retaddr: return address for unwinding
- *
- * Look up the guest virtual address @addr.  Raise an exception if the
- * page does not satisfy @access_type.  Raise an exception if the
- * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
- * page as dirty.
- *
- * Finally, return the host address for a page that is backed by RAM,
- * or NULL if the page requires I/O.
- */
-void *probe_access(CPUArchState *env, vaddr addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
-
-static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
-                                int mmu_idx, uintptr_t retaddr)
-{
-    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
-}
-
-static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
-                               int mmu_idx, uintptr_t retaddr)
-{
-    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
-}
-
-/**
- * probe_access_flags:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @size: size of the access
- * @access_type: read, write or execute permission
- * @mmu_idx: MMU index to use for lookup
- * @nonfault: suppress the fault
- * @phost: return value for host address
- * @retaddr: return address for unwinding
- *
- * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
- * the page, and storing the host address for RAM in @phost.
- *
- * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
- * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
- * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
- * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
- */
-int probe_access_flags(CPUArchState *env, vaddr addr, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool nonfault, void **phost, uintptr_t retaddr);
-
-#ifndef CONFIG_USER_ONLY
-
-/**
- * probe_access_full:
- * Like probe_access_flags, except also return into @pfull.
- *
- * The CPUTLBEntryFull structure returned via @pfull is transient
- * and must be consumed or copied immediately, before any further
- * access or changes to TLB @mmu_idx.
- *
- * This function will not fault if @nonfault is set, but will
- * return TLB_INVALID_MASK if the page is not mapped, or is not
- * accessible with @access_type.
- *
- * This function will return TLB_MMIO in order to force the access
- * to be handled out-of-line if plugins wish to instrument the access.
- */
-int probe_access_full(CPUArchState *env, vaddr addr, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool nonfault, void **phost,
-                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
-
-/**
- * probe_access_full_mmu:
- * Like probe_access_full, except:
- *
- * This function is intended to be used for page table accesses by
- * the target mmu itself.  Since such page walking happens while
- * handling another potential mmu fault, this function never raises
- * exceptions (akin to @nonfault true for probe_access_full).
- * Likewise this function does not trigger plugin instrumentation.
- */
-int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
-                          MMUAccessType access_type, int mmu_idx,
-                          void **phost, CPUTLBEntryFull **pfull);
-
-#endif /* !CONFIG_USER_ONLY */
-#endif /* CONFIG_TCG */
-
 #endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index c1a88392c05..c7840fbf2e1 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -22,6 +22,7 @@
 #include "arch.h"
 #include "mmvec/system_ext_mmvec.h"
 #include "accel/tcg/getpc.h"
+#include "accel/tcg/probe.h"
 
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d11989f5674..b346af942a0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -21,6 +21,7 @@
 #include "qemu/main-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/iommu.h"
+#include "accel/tcg/probe.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 43d005e24e4..697fdf18241 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -27,6 +27,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
 #include "qemu/main-loop.h"
 #include "user/page-protection.h"
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 81ffecaaba4..ebbb300f86a 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/probe.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c6fd2900126..2f039b2db33 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
+#include "accel/tcg/probe.h"
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e0e82ae507f..58f1cd0b34c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -14,6 +14,9 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#ifdef CONFIG_TCG
+#include "accel/tcg/probe.h"
+#endif
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 08d8f63ffea..ac86629432a 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -31,6 +31,7 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "qemu/int128.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 7dc5fb776b3..8fbdcc8fb95 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -30,6 +30,7 @@
 #include "system/ram_addr.h"
 #endif
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38d49cbb9d8..d50b8720ad6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "cpu-features.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "cpregs.h"
 
 #define SIGNBIT (uint32_t)0x80000000
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 87b6b4b3e64..50aca54eaa3 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -32,6 +32,7 @@
 #include "sve_ldst_internal.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/probe.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 3f3d86db2b2..dd726b43187 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/log.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "cpu.h"
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 554d7bf4d14..a5f73aedf82 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/helper-proto.h"
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 2398ce2c648..32207c1a4c8 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "qemu/timer.h"
 #include "trace.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index 0fdd587eddf..ee5b4514597 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -4,6 +4,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "access.h"
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 3af902e0ec5..e45d71fa1ad 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/log.h"
 #include "helper-tcg.h"
 #include "seg_helper.h"
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 93614aa3e54..c1626215877 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 14de4a71ff6..4d9a4468e53 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "exec/target_page.h"
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index d7e8d678f4b..50f05a915ed 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "internal.h"
 #include "qemu/atomic128.h"
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5b0db2c45ab..abb1d284dce 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
 #include "trace.h"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b8ae7044578..5ccb294e319 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -23,6 +23,7 @@
 #include "exec/memop.h"
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 0cdfd380ce4..9e77cde81bd 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -29,6 +29,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/probe.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index a7dd8100555..182c6e35c17 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -34,6 +34,7 @@
 #include "qemu/host-utils.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/probe.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-- 
2.47.1


