Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC7C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38d-0004di-7b; Sat, 08 Mar 2025 17:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38T-0004Zu-En
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:13 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38R-0005Lu-86
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:12 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223959039f4so60749495ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474750; x=1742079550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4u5PBwHEPecUaxrqA3yTEFMGllvxnHxvoZEJcDTq3Zs=;
 b=D4ndGY7BtFWutR9tk1CMKnVIuFIwVa1Bvdu7mOH3sTk141TqOJYXO1/JWBt47g5i6j
 5wYMyW+hCfGEAAoOcCZ84Eh3j7xotuJUIm6r1PITOAmIBdb5nQYTQXfpGxbNvc+VcE7P
 Mdsdk3L9zrcPeJmHqbM4CufyX5UkU6xdcSjAmqs4kyOrT0sZMlf93iGB2Xqbirv6B4fm
 REhFNwsK+Q3obvQqm02SN7pgZtYEkkRnhdweHdL/H3hZ7l0BXkU0fx0bz7BRJiagUjL/
 N+N80I/CXm3fDfVAebAfBp8yqRgI0AFBQ3dq2jn4dHdtUDwl1uVFZI1X6uJ5L/ejg1oy
 Cw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474750; x=1742079550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4u5PBwHEPecUaxrqA3yTEFMGllvxnHxvoZEJcDTq3Zs=;
 b=VUZOrrAAInW12MH3DQE8giEaF6bmKI3+aaG22D2Z56ZNLnI+Lsmd1EHBnh2d8jHoRb
 nl4uPJHUCno0bwAS8HBYqu/8B0iPUG+mHqG8a/aH8yj1NCb1U96XtbRGzC+Z7l6nDL23
 eEZ5YUd+ZIGq3aq+/mjjz0FbP94+jX7lQMkNviCX1yGd/t8xsat+v0hVSKALGzUAwqih
 CUP7RJFX/o/7pUzdpVc5z/k3bmH3nWVODvTgt5KE4Z0sMuCRu57rvvoG0Sm0gMTsjQkx
 WS9WQ3jUaXnRRfkb6GuZSVqr8cipWCu0YLCJwIRejCz656fPy9gUWWDfwBdjorEDwL0A
 KiKg==
X-Gm-Message-State: AOJu0Yy36Ty49G7KR9tmEDrsHnmS21NCYPnGf4f4FGx6UiYQirgomZ5r
 filJGUCtCUTdfsWrh26USJJhBALYHtH/eoJl42kG1X1gnMnJQ+WiSrrNl2nUvUm7AqjlxV72C6T
 j
X-Gm-Gg: ASbGncsNRN8EaeMyJB3SiQmpYG6JdLMZf/fpo1Up0fwbUweRJ3CVDDQsjXRTbwu6jmS
 C0+xf8a96RhHp48HqNg/OcZHgfgCB1C8NsoU+N3ewL61PrCUc+glG/tByzAh3OqNAiD4xwlVU9f
 nplD+0AOTQ9w8faz7tgaoOwH5jTlWL9nh82JGk/87SzWARo+ifE6I+BniONumcB8ZVHjSLoQAzI
 X1rNpoUBW4+194RLtp3RCGiLKWwxtPUYkl/MNGRx8Ps57jZO5LUwtCW6g6upgN0RnvrazwFEVAA
 VbPMh66KuHGHdIbVwVU7ZXNscuI4p+/wkyHdRJeYBwRCI5Mb5c688xkldu82gzgnaXZtvx8iRSz
 q
X-Google-Smtp-Source: AGHT+IHkcp12zRGYST6rP7g60xgT2DJu0QbKhCD1443sluPBgq0OzC7BmkUFpwQydTJzENI4ZmWqhg==
X-Received: by 2002:a17:902:ec89:b0:224:10a2:cad9 with SMTP id
 d9443c01a7336-22428bd5852mr161238565ad.41.1741474749910; 
 Sat, 08 Mar 2025 14:59:09 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/23] exec: Declare tlb_set_page() in 'exec/cputlb.h'
Date: Sat,  8 Mar 2025 14:58:48 -0800
Message-ID: <20250308225902.1208237-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241114011310.3615-18-philmd@linaro.org>
---
 include/exec/cputlb.h               | 11 +++++++++++
 include/exec/exec-all.h             |  9 ---------
 target/alpha/helper.c               |  2 +-
 target/avr/helper.c                 |  2 +-
 target/loongarch/tcg/tlb_helper.c   |  1 +
 target/m68k/helper.c                |  1 +
 target/mips/tcg/system/tlb_helper.c |  1 +
 target/openrisc/mmu.c               |  2 +-
 target/ppc/mmu_helper.c             |  1 +
 target/riscv/cpu_helper.c           |  1 +
 target/rx/cpu.c                     |  2 +-
 target/s390x/tcg/excp_helper.c      |  1 +
 target/sh4/helper.c                 |  1 +
 target/tricore/helper.c             |  2 +-
 target/xtensa/helper.c              |  2 +-
 15 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 56dd05a148..cdfaf17403 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -90,4 +90,15 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs,
                              int prot, int mmu_idx, vaddr size);
 
+/**
+ * tlb_set_page:
+ *
+ * This function is equivalent to calling tlb_set_page_with_attrs()
+ * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
+ * as a convenience for CPUs which don't use memory transaction attributes.
+ */
+void tlb_set_page(CPUState *cpu, vaddr addr,
+                  hwaddr paddr, int prot,
+                  int mmu_idx, vaddr size);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 62d6300752..a3aa8448d0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -156,15 +156,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                uint16_t idxmap,
                                                unsigned bits);
 
-/* tlb_set_page:
- *
- * This function is equivalent to calling tlb_set_page_with_attrs()
- * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
- * as a convenience for CPUs which don't use memory transaction attributes.
- */
-void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
-                  int mmu_idx, vaddr size);
 #else
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f1000c99f..57cefcba14 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 9ea6870e44..3412312ad5 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a323606e5a..f6b63c7224 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/helper-proto.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index beefeb7069..0bf574830f 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/gdbstub.h"
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index e98bb95951..ca4d6b27bc 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -21,6 +21,7 @@
 
 #include "cpu.h"
 #include "internal.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index c632d5230b..47ac783c52 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index a802bc9c62..ad9ba8294c 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -24,6 +24,7 @@
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/log.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 34092f372d..6c4391d96b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "pmu.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "instmap.h"
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 1c40c8977e..f01e069a90 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "migration/vmstate.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
 #include "hw/loader.h"
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 4c0b692c9e..f969850f87 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b8774e046e..7567e6c8b6 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/log.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 9898752eb0..a64412e6bd 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -19,7 +19,7 @@
 #include "qemu/log.h"
 #include "hw/registerfields.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f64699b116..4824b97e37 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
-- 
2.43.0


