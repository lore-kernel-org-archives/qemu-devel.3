Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DEC36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOPM-0002QH-JC; Thu, 20 Mar 2025 18:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPD-0002Lx-0n
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP5-00076t-Iw
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso28032135ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509816; x=1743114616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7atg1QNlMwiRcOtfC+g1XTGtA+tIvR9K19RwCptDexg=;
 b=O/qLIgyXmI6mxLNQCmrJw+ag2lUXC+5IshxHv5ZzQE+q7tecuLIwRyYhMxGTrYqtn9
 EX6ikIMcmsQ5w2Y19QhK1XKREmP/VZOhIvyKPCt+0I7IcCO4r5sLHO8QYvoywuX5xztZ
 Xs46WUPLA7x92f+XIqGR+rMv7TgMHEE4RBwih35WxCOhu/9dix3+bGHR6Xm/4rluhFIy
 cLutzV6ef6OxnsClXGRFI4gQkrwOumA0yY57i3b1Hqi7aIzVH81T82vM8jP0YmyhgutE
 btsCIPvoLuioWAbMmpTVe7Ovzo7JN9wtOg090ry6+iCj8kPggqZ8GDxT1uteK8YOG8+z
 J3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509816; x=1743114616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7atg1QNlMwiRcOtfC+g1XTGtA+tIvR9K19RwCptDexg=;
 b=NT1kJ1fuNDjx/Nj0CnZSHjO9sBMsEAj5JznthMJKqtbuS5fMhMuJe2gXPJwKsN8lrn
 qLpdRLpRnvyb6wVImQmB68MrjRfDVzOPyBExmaXwKOLSXQchn68GHnxZ8RA+YcRaGqSK
 JmvElupGRU3ZiQgF9TIhX+hkIDGT4xHMzOkhta397hS313E75iKNMA//CsUfwAt9Bva6
 EzykSSoq7QCGPRfgIyBY3F3w8UnWpPJ8W3w/Oy0exjtHOoGYizI7lA40qOTbA0CuGZCo
 Q/2VmqNCbBO/8FrJYgzajHsjDOyMIcqK0MRV20HFJ2cW61VrKw72zu7aX06IgHBRczeP
 G8Pw==
X-Gm-Message-State: AOJu0YwtckI62Pj3N3rfITmx0LnJvSigAjf46jgsewyujCQQYt5TDRM8
 g2qa41MVeCGBVRlqUXlgMxhJNKhw7fA1xFocSS8uTHJkSexqz7UArv9J5GQ17rgxISQuFJsIukH
 G
X-Gm-Gg: ASbGncvdm5bZH9y6FRVtWXOOL74MOCiNpLvfMGhsxHB7Qwpm4XSmLZPN8ins1VPmiP7
 WStqMfwKirFp7Tykbv2mFIPbDysRYMYHpvLo7cDrvgYjKKT+P6v3Z+Nb9O3jbMujgN6pOzrUzNs
 L5aN8ipBHqsPbgV9LwY0KGZ9Vgtqf2ubTI16CyVUFuduKzIy36nmlqTme8HgY/6nlyrdmd7uzNQ
 1WRwuCcEkvmKcqtKbbkWyZqUp0BgFnTjEGyQI4SbLka1xfqQZ21vSs1zoZc+DZO58lWTFk146mp
 BQYrVVYXZbmQDhxF98gOeuWZqyv+jAiK1uRbkar9ALsX
X-Google-Smtp-Source: AGHT+IFhrj0Ju18mZ4zB7Xxugx+gQPBMv57HUAn1z52UjX2P86odC+k4hNfGzhAwTQWLPYDhPHuNiQ==
X-Received: by 2002:a17:902:e951:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-22780c54e1amr15128535ad.11.1742509816076; 
 Thu, 20 Mar 2025 15:30:16 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/30] exec/cpu-all: extract tlb flags defines to
 exec/tlb-flags.h
Date: Thu, 20 Mar 2025 15:29:34 -0700
Message-Id: <20250320223002.2915728-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h               | 63 --------------------
 include/exec/tlb-flags.h             | 87 ++++++++++++++++++++++++++++
 accel/tcg/cputlb.c                   |  1 +
 accel/tcg/user-exec.c                |  1 +
 semihosting/uaccess.c                |  1 +
 target/arm/ptw.c                     |  1 +
 target/arm/tcg/helper-a64.c          |  1 +
 target/arm/tcg/mte_helper.c          |  1 +
 target/arm/tcg/sve_helper.c          |  1 +
 target/i386/tcg/system/excp_helper.c |  1 +
 target/riscv/op_helper.c             |  1 +
 target/riscv/vector_helper.c         |  1 +
 target/s390x/tcg/mem_helper.c        |  1 +
 target/sparc/mmu_helper.c            |  1 +
 14 files changed, 99 insertions(+), 63 deletions(-)
 create mode 100644 include/exec/tlb-flags.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 013fcc9412a..d2895fb55b1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -36,69 +36,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #include "cpu.h"
 
-#ifdef CONFIG_USER_ONLY
-
-/*
- * Allow some level of source compatibility with softmmu.  We do not
- * support any of the more exotic features, so only invalid pages may
- * be signaled by probe_access_flags().
- */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
-#define TLB_WATCHPOINT      0
-
-#else
-
-/*
- * Flags stored in the low bits of the TLB virtual address.
- * These are defined so that fast path ram access is all zeros.
- * The flags all must be between TARGET_PAGE_BITS and
- * maximum address alignment bit.
- *
- * Use TARGET_PAGE_BITS_MIN so that these bits are constant
- * when TARGET_PAGE_BITS_VARY is in effect.
- *
- * The count, if not the placement of these bits is known
- * to tcg/tcg-op-ldst.c, check_max_alignment().
- */
-/* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-/* Set if TLB entry references a clean RAM page.  The iotlb entry will
-   contain the page physical address.  */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
-/* Set if TLB entry writes ignored.  */
-#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
-/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
-
-/*
- * Use this mask to check interception with an alignment mask
- * in a TCG backend.
- */
-#define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
-
-/*
- * Flags stored in CPUTLBEntryFull.slow_flags[x].
- * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
- */
-/* Set if TLB entry requires byte swap.  */
-#define TLB_BSWAP            (1 << 0)
-/* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT       (1 << 1)
-/* Set if TLB entry requires aligned accesses.  */
-#define TLB_CHECK_ALIGNED    (1 << 2)
-
-#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
-
-/* The two sets of flags must not overlap. */
-QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
-
-#endif /* !CONFIG_USER_ONLY */
-
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
new file mode 100644
index 00000000000..c371ae77602
--- /dev/null
+++ b/include/exec/tlb-flags.h
@@ -0,0 +1,87 @@
+/*
+ * TLB flags definition
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef TLB_FLAGS_H
+#define TLB_FLAGS_H
+
+#include "exec/cpu-defs.h"
+
+#ifdef CONFIG_USER_ONLY
+
+/*
+ * Allow some level of source compatibility with softmmu.  We do not
+ * support any of the more exotic features, so only invalid pages may
+ * be signaled by probe_access_flags().
+ */
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
+#define TLB_WATCHPOINT      0
+
+#else
+
+/*
+ * Flags stored in the low bits of the TLB virtual address.
+ * These are defined so that fast path ram access is all zeros.
+ * The flags all must be between TARGET_PAGE_BITS and
+ * maximum address alignment bit.
+ *
+ * Use TARGET_PAGE_BITS_MIN so that these bits are constant
+ * when TARGET_PAGE_BITS_VARY is in effect.
+ *
+ * The count, if not the placement of these bits is known
+ * to tcg/tcg-op-ldst.c, check_max_alignment().
+ */
+/* Zero if TLB entry is valid.  */
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
+/* Set if TLB entry references a clean RAM page.  The iotlb entry will
+   contain the page physical address.  */
+#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
+/* Set if TLB entry is an IO callback.  */
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
+/* Set if TLB entry writes ignored.  */
+#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
+/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
+
+/*
+ * Use this mask to check interception with an alignment mask
+ * in a TCG backend.
+ */
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
+    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+
+/*
+ * Flags stored in CPUTLBEntryFull.slow_flags[x].
+ * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
+ */
+/* Set if TLB entry requires byte swap.  */
+#define TLB_BSWAP            (1 << 0)
+/* Set if TLB entry contains a watchpoint.  */
+#define TLB_WATCHPOINT       (1 << 1)
+/* Set if TLB entry requires aligned accesses.  */
+#define TLB_CHECK_ALIGNED    (1 << 2)
+
+#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
+
+/* The two sets of flags must not overlap. */
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
+
+#endif /* !CONFIG_USER_ONLY */
+
+#endif /* TLB_FLAGS_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 613f919fffb..b2db49e305e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "exec/log.h"
 #include "exec/helper-proto-common.h"
+#include "exec/tlb-flags.h"
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "tb-internal.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ebc7c3ecf54..667c5e03543 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -21,6 +21,7 @@
 #include "disas/disas.h"
 #include "exec/vaddr.h"
 #include "exec/exec-all.h"
+#include "exec/tlb-flags.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index a9578911669..cb64725a37c 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -11,6 +11,7 @@
 #include "exec/cpu-all.h"
 #include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
+#include "exec/tlb-flags.h"
 #include "semihosting/uaccess.h"
 
 void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 43309003486..8d4e9e07a94 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -12,6 +12,7 @@
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/tlb-flags.h"
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9244848efed..fa79d19425f 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -31,6 +31,7 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tlb-flags.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 80164a80504..888c6707547 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d786b4b1118..e3bed77b48e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 6876329de21..b0b74df72fd 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -22,6 +22,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
+#include "exec/tlb-flags.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 0d4220ba93b..8208bec078a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "trace.h"
 
 /* Exceptions processing helpers */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7773df6a7c7..ff05390baef 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -25,6 +25,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
+#include "exec/tlb-flags.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 8187b917ba1..0ff2e10d816 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -29,6 +29,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tlb-flags.h"
 #include "accel/tcg/cpu-ops.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 4a0cedd9e21..cce3046b694 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
+#include "exec/tlb-flags.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
 
-- 
2.39.5


