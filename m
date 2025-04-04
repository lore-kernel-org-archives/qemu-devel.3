Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDF9C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdx-0000nr-2v; Fri, 04 Apr 2025 18:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdu-0000nD-NQ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdo-00081e-TH
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so25180755e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806158; x=1744410958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irY319rrs0XiticUklqQmS8GpxuelJZIzQiKhO4KKuc=;
 b=GxhCizJL1Q2Cs4VxBRmY6QBcLfpDQcGP/qyZX3e8EPmOT9ImbJufcFB+M/oVyPVQA0
 jlaXbHScaMxJXL2PTv68AaWE5aoJ9/AX2WZEbwbEey5cNocxKbYFohP/qG9lRuK09/LA
 VhVEwHWTD9mVudzFZeNdhIx4ZxiC+7my+auI0b72Aeymk+2QecEm11hXzNlF2fUIj4Mb
 kKZ4wx5DkzBKoZBPwgPUaDLf6AzsguVLKGC60DWiwEQZsj+N6FUjiH99RNECLllmR6qB
 vPUOQUfAP3kN/6fhDcsAeXAz3sRmtAuw/ni9eJkYGvHA4m3XgiEnUshFNqkTiJPWiet2
 5rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806159; x=1744410959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irY319rrs0XiticUklqQmS8GpxuelJZIzQiKhO4KKuc=;
 b=hHgFlR2359ZC0JRHNarKukDO0z6FZU3I/vycNZi72UbVrCJGm1eL0g1zxE/UNTL0hf
 4nlRZGihqtEMZ4utsTJ4/XvHEx3yHB1rqWQhml5biYKv0y+vPMVpmyfnzXCN00x3rGIa
 YPj1kia0W3sU9p36Lv8wymQHorIHIfHHTGvGLWOV5GzvwLSePMY2iFtv2iVTWclXqAnF
 LoymvZOPbnpTntCt6UWhSlg8SB0lAvD9Bvs4T6ORTnIASyaHGu18ONEBaytfdhaWzB7o
 g+VwZ1yeDkFxE0I+n0ISyTa//ykn8q+WIMppFDjAFKvThBpGin6jdLnNOSV9FQHgyRie
 DWJw==
X-Gm-Message-State: AOJu0YzM01ZVUsFm+yrqBZN+CoXpz/C6SthBz4D/RM6URHbNZUCv0IjW
 Uyq3sM7WmOXR4QXXzu0lHke4Dl9BfiJTMjt49WLt+5gIktoBPlI3ZAYXWeFHRAx34A8+Fk6pU6D
 3
X-Gm-Gg: ASbGncu/l4oNARwfz0qf6fABu59YtRQIE5b+agKYjcL31s+lFMThL9vHPK00Pz5xL7u
 Q3AK/Dz5WXVCksQas+BaqPwIdv0ZjMBInh4TgmInSufSSckZXn2LG+YUrqRZkhiR0G/soBAuZ3U
 VBirAg0Gk+i5CDBmIoO1H6yXRLF7bCIRkoSn7O/JSr0GIUCrkD/Vozg+odiLiZDfa3Wbgav5D3+
 piXUIo3j58tFQKLticXsr5dWSGDyj9nLooXlol3mow80FdEsPxsa9GMjap8Ietaa5JanLxtR6FA
 5vgHuwiGglFXRUpAajwbIcOsKbGnZ7KjIhScT2CNZem999BYsfhCP6vcaf5i1zzdItHY54xmZjg
 1jO6gz1gBzUAMTz3X1nTrX0dD
X-Google-Smtp-Source: AGHT+IF/jjUKdx0KdUxc/kwq/otGXJ5PU/qkVJ+SY7vkDXE6rIZxtPtl78453GN+ygbobgGg0ImKQQ==
X-Received: by 2002:a05:600c:1c07:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43ecf84287dmr44903905e9.4.1743806158410; 
 Fri, 04 Apr 2025 15:35:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342827fsm57617575e9.6.2025.04.04.15.35.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 7/9] target/arm/mte: Restrict MTE declarations
Date: Sat,  5 Apr 2025 00:35:19 +0200
Message-ID: <20250404223521.38781-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move MTE declarations out of "internals.h" to TCG "mte.h".
Include "mte.h" when necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h             | 121 --------------------
 target/arm/tcg/mte.h               | 124 ++++++++++++++++++++
 target/arm/tcg/sve_ldst_internal.h |   1 +
 target/arm/tcg/helper-a64.c        |   1 +
 target/arm/tcg/mte.c               | 175 +++++++++++++++++++++++++++++
 target/arm/tcg/mte_helper.c        | 160 +-------------------------
 target/arm/tcg/sve_helper.c        |   1 +
 target/arm/tcg/translate-a64.c     |   1 +
 target/arm/tcg/translate-sve.c     |   1 +
 target/arm/tcg/meson.build         |   1 +
 10 files changed, 306 insertions(+), 280 deletions(-)
 create mode 100644 target/arm/tcg/mte.c

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0728e5c5348..5e549b95e14 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1624,127 +1624,6 @@ FIELD(PREDDESC, OPRSZ, 0, 6)
 FIELD(PREDDESC, ESZ, 6, 2)
 FIELD(PREDDESC, DATA, 8, 24)
 
-/*
- * The SVE simd_data field, for memory ops, contains either
- * rd (5 bits) or a shift count (2 bits).
- */
-#define SVE_MTEDESC_SHIFT 5
-
-/* Bits within a descriptor passed to the helper_mte_check* functions. */
-FIELD(MTEDESC, MIDX,  0, 4)
-FIELD(MTEDESC, TBI,   4, 2)
-FIELD(MTEDESC, TCMA,  6, 2)
-FIELD(MTEDESC, WRITE, 8, 1)
-FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
-
-bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
-uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
-
-/**
- * mte_mops_probe: Check where the next MTE failure is for a FEAT_MOPS operation
- * @env: CPU env
- * @ptr: start address of memory region (dirty pointer)
- * @size: length of region (guaranteed not to cross a page boundary)
- * @desc: MTEDESC descriptor word (0 means no MTE checks)
- * Returns: the size of the region that can be copied without hitting
- *          an MTE tag failure
- *
- * Note that we assume that the caller has already checked the TBI
- * and TCMA bits with mte_checks_needed() and an MTE check is definitely
- * required.
- */
-uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
-                        uint32_t desc);
-
-/**
- * mte_mops_probe_rev: Check where the next MTE failure is for a FEAT_MOPS
- *                     operation going in the reverse direction
- * @env: CPU env
- * @ptr: *end* address of memory region (dirty pointer)
- * @size: length of region (guaranteed not to cross a page boundary)
- * @desc: MTEDESC descriptor word (0 means no MTE checks)
- * Returns: the size of the region that can be copied without hitting
- *          an MTE tag failure
- *
- * Note that we assume that the caller has already checked the TBI
- * and TCMA bits with mte_checks_needed() and an MTE check is definitely
- * required.
- */
-uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
-                            uint32_t desc);
-
-/**
- * mte_check_fail: Record an MTE tag check failure
- * @env: CPU env
- * @desc: MTEDESC descriptor word
- * @dirty_ptr: Failing dirty address
- * @ra: TCG retaddr
- *
- * This may never return (if the MTE tag checks are configured to fault).
- */
-void mte_check_fail(CPUARMState *env, uint32_t desc,
-                    uint64_t dirty_ptr, uintptr_t ra);
-
-/**
- * mte_mops_set_tags: Set MTE tags for a portion of a FEAT_MOPS operation
- * @env: CPU env
- * @dirty_ptr: Start address of memory region (dirty pointer)
- * @size: length of region (guaranteed not to cross page boundary)
- * @desc: MTEDESC descriptor word
- */
-void mte_mops_set_tags(CPUARMState *env, uint64_t dirty_ptr, uint64_t size,
-                       uint32_t desc);
-
-static inline int allocation_tag_from_addr(uint64_t ptr)
-{
-    return extract64(ptr, 56, 4);
-}
-
-/* Return true if tbi bits mean that the access is checked.  */
-static inline bool tbi_check(uint32_t desc, int bit55)
-{
-    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
-}
-
-/* Return true if tcma bits mean that the access is unchecked.  */
-static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
-{
-    /*
-     * We had extracted bit55 and ptr_tag for other reasons, so fold
-     * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
-     */
-    bool match = ((ptr_tag + bit55) & 0xf) == 0;
-    bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
-    return tcma && match;
-}
-
-/*
- * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
- * for the tag to be present in the FAR_ELx register.  But for user-only
- * mode, we do not have a TLB with which to implement this, so we must
- * remove the top byte.
- */
-static inline uint64_t useronly_clean_ptr(uint64_t ptr)
-{
-#ifdef CONFIG_USER_ONLY
-    /* TBI0 is known to be enabled, while TBI1 is disabled. */
-    ptr &= sextract64(ptr, 0, 56);
-#endif
-    return ptr;
-}
-
-static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
-{
-#ifdef CONFIG_USER_ONLY
-    int64_t clean_ptr = sextract64(ptr, 0, 56);
-    if (tbi_check(desc, clean_ptr < 0)) {
-        ptr = clean_ptr;
-    }
-#endif
-    return ptr;
-}
-
 /* Values for M-profile PSR.ECI for MVE insns */
 enum MVEECIState {
     ECI_NONE = 0, /* No completed beats */
diff --git a/target/arm/tcg/mte.h b/target/arm/tcg/mte.h
index 1f471fb69b1..ecb0fc76b03 100644
--- a/target/arm/tcg/mte.h
+++ b/target/arm/tcg/mte.h
@@ -9,7 +9,24 @@
 #ifndef TARGET_ARM_MTE_H
 #define TARGET_ARM_MTE_H
 
+#include "qemu/bitops.h"
 #include "exec/mmu-access-type.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "hw/registerfields.h"
+
+/*
+ * The SVE simd_data field, for memory ops, contains either
+ * rd (5 bits) or a shift count (2 bits).
+ */
+#define SVE_MTEDESC_SHIFT 5
+
+/* Bits within a descriptor passed to the helper_mte_check* functions. */
+FIELD(MTEDESC, MIDX,  0, 4)
+FIELD(MTEDESC, TBI,   4, 2)
+FIELD(MTEDESC, TCMA,  6, 2)
+FIELD(MTEDESC, WRITE, 8, 1)
+FIELD(MTEDESC, ALIGN, 9, 3)
+FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
 
 /**
  * allocation_tag_mem_probe:
@@ -63,4 +80,111 @@ int load_tag1(uint64_t ptr, uint8_t *mem);
  */
 void store_tag1(uint64_t ptr, uint8_t *mem, int tag);
 
+bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
+uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
+
+/**
+ * mte_mops_probe: Check where the next MTE failure is for a FEAT_MOPS operation
+ * @env: CPU env
+ * @ptr: start address of memory region (dirty pointer)
+ * @size: length of region (guaranteed not to cross a page boundary)
+ * @desc: MTEDESC descriptor word (0 means no MTE checks)
+ * Returns: the size of the region that can be copied without hitting
+ *          an MTE tag failure
+ *
+ * Note that we assume that the caller has already checked the TBI
+ * and TCMA bits with mte_checks_needed() and an MTE check is definitely
+ * required.
+ */
+uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
+                        uint32_t desc);
+
+/**
+ * mte_mops_probe_rev: Check where the next MTE failure is for a FEAT_MOPS
+ *                     operation going in the reverse direction
+ * @env: CPU env
+ * @ptr: *end* address of memory region (dirty pointer)
+ * @size: length of region (guaranteed not to cross a page boundary)
+ * @desc: MTEDESC descriptor word (0 means no MTE checks)
+ * Returns: the size of the region that can be copied without hitting
+ *          an MTE tag failure
+ *
+ * Note that we assume that the caller has already checked the TBI
+ * and TCMA bits with mte_checks_needed() and an MTE check is definitely
+ * required.
+ */
+uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
+                            uint32_t desc);
+
+/**
+ * mte_check_fail: Record an MTE tag check failure
+ * @env: CPU env
+ * @desc: MTEDESC descriptor word
+ * @dirty_ptr: Failing dirty address
+ * @ra: TCG retaddr
+ *
+ * This may never return (if the MTE tag checks are configured to fault).
+ */
+void mte_check_fail(CPUARMState *env, uint32_t desc,
+                    uint64_t dirty_ptr, uintptr_t ra);
+
+/**
+ * mte_mops_set_tags: Set MTE tags for a portion of a FEAT_MOPS operation
+ * @env: CPU env
+ * @dirty_ptr: Start address of memory region (dirty pointer)
+ * @size: length of region (guaranteed not to cross page boundary)
+ * @desc: MTEDESC descriptor word
+ */
+void mte_mops_set_tags(CPUARMState *env, uint64_t dirty_ptr, uint64_t size,
+                       uint32_t desc);
+
+static inline int allocation_tag_from_addr(uint64_t ptr)
+{
+    return extract64(ptr, 56, 4);
+}
+
+/* Return true if tbi bits mean that the access is checked.  */
+static inline bool tbi_check(uint32_t desc, int bit55)
+{
+    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
+}
+
+/* Return true if tcma bits mean that the access is unchecked.  */
+static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
+{
+    /*
+     * We had extracted bit55 and ptr_tag for other reasons, so fold
+     * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
+     */
+    bool match = ((ptr_tag + bit55) & 0xf) == 0;
+    bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
+    return tcma && match;
+}
+
+/*
+ * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
+ * for the tag to be present in the FAR_ELx register.  But for user-only
+ * mode, we do not have a TLB with which to implement this, so we must
+ * remove the top byte.
+ */
+static inline uint64_t useronly_clean_ptr(uint64_t ptr)
+{
+#ifdef CONFIG_USER_ONLY
+    /* TBI0 is known to be enabled, while TBI1 is disabled. */
+    ptr &= sextract64(ptr, 0, 56);
+#endif
+    return ptr;
+}
+
+static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
+{
+#ifdef CONFIG_USER_ONLY
+    int64_t clean_ptr = sextract64(ptr, 0, 56);
+    if (tbi_check(desc, clean_ptr < 0)) {
+        ptr = clean_ptr;
+    }
+#endif
+    return ptr;
+}
+
 #endif /* TARGET_ARM_MTE_H */
diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index f2243daf370..a201f6b0393 100644
--- a/target/arm/tcg/sve_ldst_internal.h
+++ b/target/arm/tcg/sve_ldst_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_SVE_LDST_INTERNAL_H
 
 #include "accel/tcg/cpu-ldst.h"
+#include "mte.h"
 
 /*
  * Load one element into @vd + @reg_off from @host.
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 08d8f63ffea..bcd116e2a16 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -41,6 +41,7 @@
 #include "user/page-protection.h"
 #endif
 #include "vec_internal.h"
+#include "mte.h"
 
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
diff --git a/target/arm/tcg/mte.c b/target/arm/tcg/mte.c
new file mode 100644
index 00000000000..d80465b08e9
--- /dev/null
+++ b/target/arm/tcg/mte.c
@@ -0,0 +1,175 @@
+/*
+ * ARM v8.5-MemTag Operations
+ *
+ * Copyright (c) 2020 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "exec/exec-all.h"
+#include "exec/target_page.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/cpu_loop.h"
+#include "user/page-protection.h"
+#else
+#include "system/memory.h"
+#include "system/ram_addr.h"
+#endif
+#include "exec/tlb-flags.h"
+#include "accel/tcg/cpu-ops.h"
+#include "cpu.h"
+#include "mte.h"
+
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    uint64_t clean_ptr = useronly_clean_ptr(ptr);
+    int flags = page_get_flags(clean_ptr);
+    uint8_t *tags;
+    uintptr_t index;
+
+    assert(!(probe && ra));
+
+    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
+        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
+                              !(flags & PAGE_VALID), ra);
+    }
+
+    /* Require both MAP_ANON and PROT_MTE for the page. */
+    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
+        return NULL;
+    }
+
+    tags = page_get_target_data(clean_ptr);
+
+    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
+                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    return tags + index;
+#else
+    CPUTLBEntryFull *full;
+    MemTxAttrs attrs;
+    int in_page, flags;
+    hwaddr ptr_paddr, tag_paddr, xlat;
+    MemoryRegion *mr;
+    ARMASIdx tag_asi;
+    AddressSpace *tag_as;
+    void *host;
+
+    /*
+     * Probe the first byte of the virtual address.  This raises an
+     * exception for inaccessible pages, and resolves the virtual address
+     * into the softmmu tlb.
+     *
+     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
+     * Indicate to probe_access_flags no-fault, then either return NULL
+     * for the pure probe, or assert that we received a valid page for the
+     * no-fault-expected probe.
+     */
+    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
+                              ra == 0, &host, &full, ra);
+    if (probe && (flags & TLB_INVALID_MASK)) {
+        return NULL;
+    }
+    assert(!(flags & TLB_INVALID_MASK));
+
+    /* If the virtual page MemAttr != Tagged, access unchecked. */
+    if (full->extra.arm.pte_attrs != 0xf0) {
+        return NULL;
+    }
+
+    /*
+     * If not backed by host ram, there is no tag storage: access unchecked.
+     * This is probably a guest os bug though, so log it.
+     */
+    if (unlikely(flags & TLB_MMIO)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
+                      "but is not backed by host ram\n", ptr);
+        return NULL;
+    }
+
+    /*
+     * Remember these values across the second lookup below,
+     * which may invalidate this pointer via tlb resize.
+     */
+    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
+    attrs = full->attrs;
+    full = NULL;
+
+    /*
+     * The Normal memory access can extend to the next page.  E.g. a single
+     * 8-byte access to the last byte of a page will check only the last
+     * tag on the first page.
+     * Any page access exception has priority over tag check exception.
+     */
+    in_page = -(ptr | TARGET_PAGE_MASK);
+    if (unlikely(ptr_size > in_page)) {
+        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
+                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
+        assert(!(flags & TLB_INVALID_MASK));
+    }
+
+    /* Any debug exception has priority over a tag check exception. */
+    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
+        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+        assert(ra != 0);
+        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
+    }
+
+    /* Convert to the physical address in tag space.  */
+    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
+
+    /* Look up the address in tag space. */
+    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
+    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
+    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
+                                 tag_access == MMU_DATA_STORE, attrs);
+
+    /*
+     * Note that @mr will never be NULL.  If there is nothing in the address
+     * space at @tag_paddr, the translation will return the unallocated memory
+     * region.  For our purposes, the result must be ram.
+     */
+    if (unlikely(!memory_region_is_ram(mr))) {
+        /* ??? Failure is a board configuration error. */
+        qemu_log_mask(LOG_UNIMP,
+                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
+                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
+                      tag_paddr, ptr_paddr);
+        return NULL;
+    }
+
+    /*
+     * Ensure the tag memory is dirty on write, for migration.
+     * Tag memory can never contain code or display memory (vga).
+     */
+    if (tag_access == MMU_DATA_STORE) {
+        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
+        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
+    }
+
+    return memory_region_get_ram_ptr(mr) + xlat;
+#endif
+}
+
+int load_tag1(uint64_t ptr, uint8_t *mem)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    return extract32(*mem, ofs, 4);
+}
+
+/* For use in a non-parallel context, store to the given nibble.  */
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    *mem = deposit32(*mem, ofs, 4, tag);
+}
+
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index b70f23e2047..4ab9b858e12 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -1,5 +1,5 @@
 /*
- * ARM v8.5-MemTag Operations
+ * ARM v8.5-MemTag helpers
  *
  * Copyright (c) 2020 Linaro, Ltd.
  *
@@ -23,16 +23,9 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/target_page.h"
-#ifdef CONFIG_USER_ONLY
-#include "user/cpu_loop.h"
-#include "user/page-protection.h"
-#else
-#include "system/ram_addr.h"
-#endif
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
-#include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/getpc.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -58,144 +51,6 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
-uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                  uint64_t ptr, MMUAccessType ptr_access,
-                                  int ptr_size, MMUAccessType tag_access,
-                                  bool probe, uintptr_t ra)
-{
-#ifdef CONFIG_USER_ONLY
-    uint64_t clean_ptr = useronly_clean_ptr(ptr);
-    int flags = page_get_flags(clean_ptr);
-    uint8_t *tags;
-    uintptr_t index;
-
-    assert(!(probe && ra));
-
-    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
-        if (probe) {
-            return NULL;
-        }
-        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
-                              !(flags & PAGE_VALID), ra);
-    }
-
-    /* Require both MAP_ANON and PROT_MTE for the page. */
-    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
-        return NULL;
-    }
-
-    tags = page_get_target_data(clean_ptr);
-
-    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
-                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
-    return tags + index;
-#else
-    CPUTLBEntryFull *full;
-    MemTxAttrs attrs;
-    int in_page, flags;
-    hwaddr ptr_paddr, tag_paddr, xlat;
-    MemoryRegion *mr;
-    ARMASIdx tag_asi;
-    AddressSpace *tag_as;
-    void *host;
-
-    /*
-     * Probe the first byte of the virtual address.  This raises an
-     * exception for inaccessible pages, and resolves the virtual address
-     * into the softmmu tlb.
-     *
-     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
-     * Indicate to probe_access_flags no-fault, then either return NULL
-     * for the pure probe, or assert that we received a valid page for the
-     * no-fault-expected probe.
-     */
-    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
-                              ra == 0, &host, &full, ra);
-    if (probe && (flags & TLB_INVALID_MASK)) {
-        return NULL;
-    }
-    assert(!(flags & TLB_INVALID_MASK));
-
-    /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->extra.arm.pte_attrs != 0xf0) {
-        return NULL;
-    }
-
-    /*
-     * If not backed by host ram, there is no tag storage: access unchecked.
-     * This is probably a guest os bug though, so log it.
-     */
-    if (unlikely(flags & TLB_MMIO)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
-                      "but is not backed by host ram\n", ptr);
-        return NULL;
-    }
-
-    /*
-     * Remember these values across the second lookup below,
-     * which may invalidate this pointer via tlb resize.
-     */
-    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
-    attrs = full->attrs;
-    full = NULL;
-
-    /*
-     * The Normal memory access can extend to the next page.  E.g. a single
-     * 8-byte access to the last byte of a page will check only the last
-     * tag on the first page.
-     * Any page access exception has priority over tag check exception.
-     */
-    in_page = -(ptr | TARGET_PAGE_MASK);
-    if (unlikely(ptr_size > in_page)) {
-        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
-                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
-        assert(!(flags & TLB_INVALID_MASK));
-    }
-
-    /* Any debug exception has priority over a tag check exception. */
-    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
-        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
-        assert(ra != 0);
-        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
-    }
-
-    /* Convert to the physical address in tag space.  */
-    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
-
-    /* Look up the address in tag space. */
-    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
-    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
-    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
-                                 tag_access == MMU_DATA_STORE, attrs);
-
-    /*
-     * Note that @mr will never be NULL.  If there is nothing in the address
-     * space at @tag_paddr, the translation will return the unallocated memory
-     * region.  For our purposes, the result must be ram.
-     */
-    if (unlikely(!memory_region_is_ram(mr))) {
-        /* ??? Failure is a board configuration error. */
-        qemu_log_mask(LOG_UNIMP,
-                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
-                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
-                      tag_paddr, ptr_paddr);
-        return NULL;
-    }
-
-    /*
-     * Ensure the tag memory is dirty on write, for migration.
-     * Tag memory can never contain code or display memory (vga).
-     */
-    if (tag_access == MMU_DATA_STORE) {
-        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
-        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
-    }
-
-    return memory_region_get_ram_ptr(mr) + xlat;
-#endif
-}
-
 static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uint64_t ptr, MMUAccessType ptr_access,
                                    int ptr_size, MMUAccessType tag_access,
@@ -268,12 +123,6 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
     return address_with_allocation_tag(ptr + offset, rtag);
 }
 
-int load_tag1(uint64_t ptr, uint8_t *mem)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    return extract32(*mem, ofs, 4);
-}
-
 uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
     int mmu_idx = arm_env_mmu_index(env);
@@ -301,13 +150,6 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
     }
 }
 
-/* For use in a non-parallel context, store to the given nibble.  */
-void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    *mem = deposit32(*mem, ofs, 4, tag);
-}
-
 /* For use in a parallel context, atomically store to the given nibble.  */
 static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
 {
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 87b6b4b3e64..19b09d9f33f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -35,6 +35,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
+#include "mte.h"
 
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 43408c71bbd..c320501c507 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -25,6 +25,7 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
+#include "mte.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d23be477b4d..7f91874abd2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -21,6 +21,7 @@
 #include "translate.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
+#include "mte.h"
 
 
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t,
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index dd12ccedb18..72750d57a7d 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,6 +34,7 @@ arm_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
+  'mte.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.1


