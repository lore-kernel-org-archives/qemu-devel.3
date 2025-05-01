Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0082C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLs-00014a-SE; Thu, 01 May 2025 17:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLe-0000rs-V3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:39 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLb-0001WE-Mi
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so1181066a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134494; x=1746739294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYlB/hdthsZsiNz/pGKUzFCgJM+f0Tn0SC8QpO7LBr0=;
 b=sde7V2HsSJkNcdRm1tx5Ue0tbgogWSXX+WBXvfhMnPcc+mh1i8nAfw6lcyPL0HcXFV
 fKXNMPcOsYQfVMQOoxvdK49JiIo5N7vzXV1eydrgL4ZJ0RmxFx0bzFtb/GwumxDyGkrG
 ZULDdH3pLvNQdKvTJ52KQ0ALXWf2sMid11J/IsR9wozipuJr0Nt4kIwCy35MBNWLqyDV
 JS9dIcuMG+2l55e9+pxFX8GUtg/6ADCUPmPDGWx81Ivm5hBvqXzX1ak04aP4MmZ1EBaR
 jVqpzOH6wJeSKs9HuNpfcjsQpY5DbHVHKmdNaWBTftnkZd+IdrwpMF8UEjOqIDXjas+8
 0q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134494; x=1746739294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYlB/hdthsZsiNz/pGKUzFCgJM+f0Tn0SC8QpO7LBr0=;
 b=xJgbSsEc4x/9EIdEBgA48+RfRJ9QpkI2yjL83YpR+q/UgLVebzgHwlut81akjgiN2s
 hIv4qxTooiMEhp/iBYHck5FXkNvxmC+wSz+kJneJJrsCanCMyndCjE9mmiVBrBBkZ/9x
 NKLTwb2KO2cimrZCUjbEhf1EXJVG4koUFO3GHGL7PlkL0QprSynuere/jedhtkD8EKUi
 kSNF/98GE66JiHmDA1NXjRO0rNAFxxMcxPEmnye0HhBrhXujGFptu6+44L6mUhdCD03C
 LzdlzluBDi6jZolMDii1TYP+tfr6f405Tob8YrrOTNzLYiAynJRgvmt2QucwdJ8pGhxW
 t6ZA==
X-Gm-Message-State: AOJu0YyYjFdEVAwoBCauObNFoZL0W4jTbW8JiEmGTlc/ZYSjFwN3KrJn
 1j4MaUZTO8iaXpIuHu577fUuFGWYEJquVQPI+fWKtqfF8O4C5eY4+y90sIdbkXAuKOLkwLKoche
 6
X-Gm-Gg: ASbGnct938v4GSz3eYDldG3fQu06k676t8fTOqEdruc+df84nFpJ1waiMLaUwpOpGAw
 RciGTzurcSJuAJNdIwbiGdD9ItpONvwb/UbQthYzpIXDr9CJhMLP0mqulUx+P53FcNMWSk3qqtg
 9fjQssNig739FCp7/UeTOTvbTFt9DWrj7tY1oPavd9EG79eRthWucLvE4AYpV7BwzhbHjPwC9kk
 /BZIEZ9DV5y9OsfJyPQKVkfbU8C6GxNF6vfAptdCRxFdTZPTMj2XfhSUtjhoQHx9SLANg7STIys
 zSGwEUw5ZtmWet1ZtgNCcXcIpNvUwge9uWOzzn5ohw9ThhK23gz9cyO/kYG8CMC4PVdcksWe0s8
 =
X-Google-Smtp-Source: AGHT+IGP5wuCz6yc6JnzqjHAHq1nerW7cb/r00stE8rg5IGKHKQvoYi2+RuqkPEvHoiGkzR7Ruhmjw==
X-Received: by 2002:a17:90b:2d48:b0:301:1c29:a1d9 with SMTP id
 98e67ed59e1d1-30a4e5be430mr795403a91.21.1746134493669; 
 Thu, 01 May 2025 14:21:33 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 22/59] accel/tcg: Extract probe API out of 'exec/exec-all.h'
Date: Thu,  1 May 2025 14:20:36 -0700
Message-ID: <20250501212113.2961531-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Declare probe methods in "accel/tcg/probe.h" to emphasize
they are specific to TCG accelerator.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-13-philmd@linaro.org>
---
 include/accel/tcg/probe.h            | 106 +++++++++++++++++++++++++++
 include/exec/exec-all.h              | 100 -------------------------
 target/hexagon/mmvec/macros.h        |   1 +
 accel/tcg/cputlb.c                   |   1 +
 accel/tcg/user-exec.c                |   1 +
 semihosting/uaccess.c                |   1 +
 target/arm/helper.c                  |   1 +
 target/arm/ptw.c                     |   1 +
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
 24 files changed, 128 insertions(+), 100 deletions(-)
 create mode 100644 include/accel/tcg/probe.h

diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
new file mode 100644
index 0000000000..177bd1608d
--- /dev/null
+++ b/include/accel/tcg/probe.h
@@ -0,0 +1,106 @@
+/*
+ * Probe guest virtual addresses for access permissions.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef ACCEL_TCG_PROBE_H
+#define ACCEL_TCG_PROBE_H
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
index b9eb9bc4b6..9ef7569a0b 100644
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
index c1a88392c0..c7840fbf2e 100644
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
index d11989f567..b346af942a 100644
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
index 43d005e24e..697fdf1824 100644
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
index 81ffecaaba..ebbb300f86 100644
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
index c6fd290012..2f039b2db3 100644
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
index e0e82ae507..87d707b592 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -14,6 +14,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#include "accel/tcg/probe.h"
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 842d9e6000..cfe5faba19 100644
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
index 7dc5fb776b..8fbdcc8fb9 100644
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
index 38d49cbb9d..d50b8720ad 100644
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
index 87b6b4b3e6..50aca54eaa 100644
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
index 3f3d86db2b..dd726b4318 100644
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
index 554d7bf4d1..a5f73aedf8 100644
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
index 2398ce2c64..32207c1a4c 100644
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
index 0fdd587edd..ee5b451459 100644
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
index 3af902e0ec..e45d71fa1a 100644
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
index 93614aa3e5..c162621587 100644
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
index e349344647..fde34a39e1 100644
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
index d7e8d678f4..50f05a915e 100644
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
index 5b0db2c45a..abb1d284dc 100644
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
index b8ae704457..5ccb294e31 100644
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
index 0cdfd380ce..9e77cde81b 100644
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
index a7dd810055..182c6e35c1 100644
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
2.43.0


