Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FF4C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcse-0007XG-6b; Fri, 07 Mar 2025 13:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsS-0007SP-K5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:57 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsQ-0007me-7f
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:56 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so3599481a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373812; x=1741978612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4u5PBwHEPecUaxrqA3yTEFMGllvxnHxvoZEJcDTq3Zs=;
 b=a4iDSzYSuNBtLPs7rpIbeNUmuvOPz5m5Kb52cduEsfGKb4jkc2+uGkMOWYC/P45ywM
 1BAFXsVHUPzBIS4k0hvvy/5AJRsUvqtn43QTVFkt3GNgPE9wv0VIv0jX5aaAlI98rb21
 3/ZuDjCkihwvu1dQkGnkHR1bqzkJvSiljOwiy8pLlQc7TSGwrFuoJM4smmIt1D3mheum
 ObLZv3w3TpuAPt5Eru9oAq0bhRtEmdcocioBXOYUpnAYC/o77w59yXVwCprXgq7ANYSS
 Db4IVgY3W6jriL3bQKPhuxMbH9JJ0I55NnrUCnc7Ke45KFQARLMpGtnA9nUMAtIJAOsn
 U2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373812; x=1741978612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4u5PBwHEPecUaxrqA3yTEFMGllvxnHxvoZEJcDTq3Zs=;
 b=Svsou+rXqxInIyTPPus9aytMrNk0AFo3YVagqZEqDFnaZ6VLzuvtFvMaYOLFl+cC7n
 mZreIBVnsE2VP9VwIZMotI9rkaLL2Nz984xdGD7aMZa2Qv/4dG1qRRE7FugjR9CvCR0Y
 0p5jETNoFiji4Z0ZOGazIfO1jRsJfv9zhswn4lYSP9U2363OTnpXFngb/MDnTdoihlbk
 Uw7X6+yBwQ9cULBJKIHQmj7DAr70+hTdaJldNCCi5+KYNOD8Ot5TlDZvAmtNyHLaRqpd
 cjVCU97KqHoALpOoKvClrXBaQ2MRMYyf4R63HymcgGfYCUcrhttYJVV4PsrnW9PLNp4o
 jUFw==
X-Gm-Message-State: AOJu0YzsADAz8aEEpY5yAT7wHt8kVr/fb/JU4ftGlV9GZdqhDKUrbgnC
 z/MW8J0JEc/04rGDDSx/TQI3zXln+loRmCbgE2LQYPZ/LUYC1paHijUoXefkgakgEP9kxDrwzKb
 5
X-Gm-Gg: ASbGncsl78Z9n01uKkcJ59Kl6b3otF7/51xYQxar4kp2K4upBciBh0ezmsIasaKF/Q/
 qXQB/hZTnjcxb+MnyIONmIa3i29tMQseflkxnGn75tPZgrhogO2CVDIKr1X8I1cvfup8IOyTzXo
 r/qsxSbHESpgxO3wQEWNCuBvAK7VGbiaQRKMebrLJIVijdN6VftIkEZzL/6m3CRWhEGIobMMiqw
 xzsQjjmdU06gsdQfDKEJ9hk1g1O5nBnd2RtEAoDJFudZxpzpgkxJcqYn8XuCKhM/bAALTQbg95s
 T+0uLMN+R35qVJVP7WPx2W8e+pT4vTUEAXO4sMaCQcCtFvHoE8bXQMym/c3JDrg+17hhp8yWg8r
 k
X-Google-Smtp-Source: AGHT+IHWAcIkzpAWk8/jzv5PiqZoXlGOX+LUKRAMNAGQkv0X4GwFy2Se9h2SOhfVzp11F3Hgfnh5yg==
X-Received: by 2002:a17:90b:4a:b0:2fe:a8b1:7d8 with SMTP id
 98e67ed59e1d1-2ff7cefbc78mr7391097a91.25.1741373812397; 
 Fri, 07 Mar 2025 10:56:52 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/16] exec: Declare tlb_set_page() in 'exec/cputlb.h'
Date: Fri,  7 Mar 2025 10:56:35 -0800
Message-ID: <20250307185645.970034-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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


