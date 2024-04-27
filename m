Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9A5C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRG-00035Z-55; Sat, 27 Apr 2024 11:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRD-00034W-TC
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRA-0005U0-Bs
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso2911891f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233482; x=1714838282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bG1IiuCIsMipMG4q8jBLkK232zEBtmE1ClkZ0fh9nOE=;
 b=Je9ouGrl8a143s+vs8AHFrlsujsIRv5YBA5niWDxEMFFbsSoPg37esSKylVNb9qouB
 fQ7mIuLN2tPVMrxlloby5OCgMlcdtdJ4OLBlP4w2VRxNamTcx5Ymv0RstwTcYbjHuLko
 sHZAJjZXBJlmTRH9s5yWqk4zCVPNJfMmUs/Hz9T1hf/Wko3aq4cqcefQ6ChZ0IPGG/Lk
 qCU576V81ATZ3cFbjLThMxmCObBCmTsayF51g4gsQXPE2AY/hA2bOWYvd/iKdhlH1rO6
 WGJuFDvveni9eFDCPi5ZIM9QUcHjqT2i+yUqY3rNtgevYSfBcnHVv7VcSNwz73A5+oWB
 NQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233482; x=1714838282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bG1IiuCIsMipMG4q8jBLkK232zEBtmE1ClkZ0fh9nOE=;
 b=g9TLBBEvXK0ql5yU0Kg5++QzpwfbmCto+xxTU3mxR1zVdaOBZxf+oiXwzBSn3sfLWr
 EVzMMNeG9ZQDcQfD2c/oER3cNfd6cdq4q94JVx1chJSGcHlwHunacXPhB+ag11qF21Yt
 B/VSqdEFExrN+i+Q3vkcNb6TmwQrRqzOPtYEh3FOdDtUojta+HIm69fphID+4oXlrzEy
 sOc7E2wdWMrVmn68qaLp8CTG9P9a3gUW4n5UhVf+leUGPMiB3fXgIyAnLuvKqUWQ3mkm
 QIR8J1StubqshjwXkZw3mjXBRsinOJvhIJsU28nGGRF983SBPriBCxmgJyUVeuUX/ZpC
 /bHA==
X-Gm-Message-State: AOJu0YyjCQiedNrioPU07r3uKFgp5OwbBj99C2da2tTQf0dfakPIPNce
 rLEKrp2Gins2J8zc2fIBrutNaEuny0YUWUOFA80/2mJt+F2nqWYonNoURZd/Dyns4HCCBgxber1
 vyOU=
X-Google-Smtp-Source: AGHT+IFnThZDwHYBe744fUzekMSDxr9NQ18Lpu23n/hjD2iXxPUiZTLoyFg8xiNrwXNYx8b6YbLibA==
X-Received: by 2002:a5d:460c:0:b0:34c:4d98:d6f7 with SMTP id
 t12-20020a5d460c000000b0034c4d98d6f7mr4249789wrq.26.1714233482296; 
 Sat, 27 Apr 2024 08:58:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 m16-20020a05600c3b1000b0041496734318sm38995596wms.24.2024.04.27.08.58.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:58:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 08/14] exec/cpu: Extract page-protection definitions to
 page-prot-common.h
Date: Sat, 27 Apr 2024 17:57:08 +0200
Message-ID: <20240427155714.53669-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
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

Extract page-protection definitions from "exec/cpu-all.h"
to "exec/page-prot-common.h".

The list of files requiring the new header was generated
using:

$ git grep -wE \
  'PAGE_(READ|WRITE|EXEC|BITS|VALID|ANON|RESERVED|TARGET_.|PASSTHROUGH)'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 bsd-user/bsd-mem.h                   |  1 +
 bsd-user/qemu.h                      |  1 +
 include/exec/cpu-all.h               |  1 +
 include/exec/cpu-common.h            | 31 +--------------------
 include/exec/page-prot-common.h      | 41 ++++++++++++++++++++++++++++
 include/semihosting/uaccess.h        |  1 +
 target/arm/cpu.h                     |  1 +
 target/ppc/internal.h                |  1 +
 target/ppc/mmu-radix64.h             |  2 ++
 accel/tcg/cputlb.c                   |  1 +
 accel/tcg/tb-maint.c                 |  1 +
 accel/tcg/user-exec.c                |  1 +
 bsd-user/mmap.c                      |  1 +
 bsd-user/signal.c                    |  1 +
 cpu-target.c                         |  1 +
 hw/ppc/ppc440_bamboo.c               |  1 +
 hw/ppc/sam460ex.c                    |  1 +
 hw/ppc/virtex_ml507.c                |  1 +
 linux-user/arm/cpu_loop.c            |  1 +
 linux-user/elfload.c                 |  1 +
 linux-user/mmap.c                    |  1 +
 linux-user/signal.c                  |  1 +
 linux-user/syscall.c                 |  1 +
 system/physmem.c                     |  1 +
 target/alpha/helper.c                |  1 +
 target/arm/ptw.c                     |  1 +
 target/arm/tcg/m_helper.c            |  1 +
 target/arm/tcg/mte_helper.c          |  1 +
 target/arm/tcg/sve_helper.c          |  1 +
 target/avr/helper.c                  |  1 +
 target/cris/mmu.c                    |  1 +
 target/hppa/mem_helper.c             |  1 +
 target/hppa/translate.c              |  1 +
 target/i386/tcg/sysemu/excp_helper.c |  1 +
 target/loongarch/tcg/tlb_helper.c    |  1 +
 target/m68k/helper.c                 |  1 +
 target/microblaze/helper.c           |  1 +
 target/microblaze/mmu.c              |  1 +
 target/mips/sysemu/physaddr.c        |  1 +
 target/mips/tcg/sysemu/tlb_helper.c  |  1 +
 target/openrisc/mmu.c                |  1 +
 target/ppc/mmu-hash32.c              |  1 +
 target/ppc/mmu-hash64.c              |  1 +
 target/ppc/mmu-radix64.c             |  1 +
 target/ppc/mmu_common.c              |  1 +
 target/ppc/mmu_helper.c              |  1 +
 target/riscv/cpu_helper.c            |  1 +
 target/riscv/pmp.c                   |  1 +
 target/riscv/vector_helper.c         |  1 +
 target/rx/cpu.c                      |  1 +
 target/s390x/mmu_helper.c            |  1 +
 target/s390x/tcg/mem_helper.c        |  1 +
 target/sh4/helper.c                  |  1 +
 target/sparc/ldst_helper.c           |  1 +
 target/sparc/mmu_helper.c            |  1 +
 target/tricore/helper.c              |  1 +
 target/xtensa/mmu_helper.c           |  1 +
 target/xtensa/op_helper.c            |  1 +
 58 files changed, 99 insertions(+), 30 deletions(-)
 create mode 100644 include/exec/page-prot-common.h

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 21d9bab889..f95472bcab 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -56,6 +56,7 @@
 #include <fcntl.h>
 
 #include "qemu-bsd.h"
+#include "exec/page-prot-common.h"
 
 extern struct bsd_shm_regions bsd_shm_regions[];
 extern abi_ulong target_brk;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 8629f0dcde..4631a3e23b 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -34,6 +34,7 @@ extern char **environ;
 #include "target_os_signal.h"
 #include "target.h"
 #include "exec/gdbstub.h"
+#include "exec/page-prot-common.h"
 #include "qemu/clang-tsa.h"
 
 #include "qemu-os.h"
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8c3ad7153d..563827b8ec 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,6 +19,7 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
+#include "exec/page-prot-common.h"
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 8812ba744d..ced0b1c886 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -14,6 +14,7 @@
 #endif
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
+#include "exec/page-prot-common.h"
 
 #define EXCP_INTERRUPT  0x10000 /* async interruption */
 #define EXCP_HLT        0x10001 /* hlt instruction reached */
@@ -208,36 +209,6 @@ G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
-/* same as PROT_xxx */
-#define PAGE_READ      0x0001
-#define PAGE_WRITE     0x0002
-#define PAGE_EXEC      0x0004
-#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
-#define PAGE_VALID     0x0008
-/*
- * Original state of the write flag (used when tracking self-modifying code)
- */
-#define PAGE_WRITE_ORG 0x0010
-/*
- * Invalidate the TLB entry immediately, helpful for s390x
- * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
- */
-#define PAGE_WRITE_INV 0x0020
-/* For use with page_set_flags: page is being replaced; target_data cleared. */
-#define PAGE_RESET     0x0040
-/* For linux-user, indicates that the page is MAP_ANON. */
-#define PAGE_ANON      0x0080
-
-/* Target-specific bits that will be used via page_get_flags().  */
-#define PAGE_TARGET_1  0x0200
-#define PAGE_TARGET_2  0x0400
-
-/*
- * For linux-user, indicates that the page is mapped with the same semantics
- * in both guest and host.
- */
-#define PAGE_PASSTHROUGH 0x0800
-
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
 
diff --git a/include/exec/page-prot-common.h b/include/exec/page-prot-common.h
new file mode 100644
index 0000000000..2722ded724
--- /dev/null
+++ b/include/exec/page-prot-common.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU page protection definitions.
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
+#ifndef EXEC_PAGE_PROT_COMMON_H
+#define EXEC_PAGE_PROT_COMMON_H
+
+/* same as PROT_xxx */
+#define PAGE_READ      0x0001
+#define PAGE_WRITE     0x0002
+#define PAGE_EXEC      0x0004
+#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
+#define PAGE_VALID     0x0008
+/*
+ * Original state of the write flag (used when tracking self-modifying code)
+ */
+#define PAGE_WRITE_ORG 0x0010
+/*
+ * Invalidate the TLB entry immediately, helpful for s390x
+ * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
+ */
+#define PAGE_WRITE_INV 0x0020
+/* For use with page_set_flags: page is being replaced; target_data cleared. */
+#define PAGE_RESET     0x0040
+/* For linux-user, indicates that the page is MAP_ANON. */
+#define PAGE_ANON      0x0080
+
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0200
+#define PAGE_TARGET_2  0x0400
+
+/*
+ * For linux-user, indicates that the page is mapped with the same semantics
+ * in both guest and host.
+ */
+#define PAGE_PASSTHROUGH 0x0800
+
+#endif
diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index dd289af8dd..9873157170 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -17,6 +17,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/tswap.h"
+#include "exec/page-prot-common.h"
 
 #define get_user_u64(val, addr)                                         \
     ({ uint64_t val_ = 0;                                               \
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 17efc5d565..82b88b4883 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -26,6 +26,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "exec/gdbstub.h"
+#include "exec/page-prot-common.h"
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 601c0b533f..2af5f9549d 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -20,6 +20,7 @@
 
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
+#include "exec/page-prot-common.h"
 
 /* PM instructions */
 typedef enum {
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 4c768aa5cc..1a3fd8f65b 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -3,6 +3,8 @@
 
 #ifndef CONFIG_USER_ONLY
 
+#include "exec/page-prot-common.h"
+
 /* Radix Quadrants */
 #define R_EADDR_MASK            0x3FFFFFFFFFFFFFFF
 #define R_EADDR_VALID_MASK      0xC00FFFFFFFFFFFFF
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 953c437ba9..fd5234792c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -21,6 +21,7 @@
 #include "qemu/main-loop.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/memory.h"
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index da39a43bd8..717e31e602 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/log.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/tb-flush.h"
 #include "exec/translate-all.h"
 #include "sysemu/tcg.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..cb29c4d01b 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,6 +25,7 @@
 #include "qemu/rcu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translate-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic128.h"
 #include "trace/trace-root.h"
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 3ef11b2807..deb384605e 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "exec/page-prot-common.h"
 
 #include "qemu.h"
 
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b2faf1d0dd..b19b8dd2e7 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu.h"
+#include "exec/page-prot-common.h"
 #include "user/tswap-target.h"
 #include "gdbstub/user.h"
 #include "signal-common.h"
diff --git a/cpu-target.c b/cpu-target.c
index f88649c299..4744b00a8d 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 
 #include "exec/target_page.h"
+#include "exec/page-prot-common.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index e18f57efce..88a271f725 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -15,6 +15,7 @@
 #include "qemu/units.h"
 #include "qemu/datadir.h"
 #include "qemu/error-report.h"
+#include "exec/page-prot-common.h"
 #include "net/net.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d42b677898..70278c0472 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -21,6 +21,7 @@
 #include "kvm_ppc.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/block-backend.h"
+#include "exec/page-prot-common.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "exec/memory.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index d02f330650..e2da13c064 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "exec/page-prot-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index db1a41e27f..81bd7fac29 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -24,6 +24,7 @@
 #include "cpu_loop-common.h"
 #include "signal-common.h"
 #include "semihosting/common-semi.h"
+#include "exec/page-prot-common.h"
 #include "target/arm/syndrome.h"
 
 #define get_user_code_u32(x, gaddr, env)                \
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f9461d2844..554251dc02 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -8,6 +8,7 @@
 
 #include "qemu.h"
 #include "user/tswap-target.h"
+#include "exec/page-prot-common.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
 #include "signal-common.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index be3b9a68eb..ecde6b8812 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -20,6 +20,7 @@
 #include <sys/shm.h>
 #include "trace.h"
 #include "exec/log.h"
+#include "exec/page-prot-common.h"
 #include "qemu.h"
 #include "user-internals.h"
 #include "user-mmap.h"
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 05dc4afb52..14abeb0641 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "gdbstub/user.h"
+#include "exec/page-prot-common.h"
 #include "hw/core/tcg-cpu-ops.h"
 
 #include <sys/ucontext.h>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 41659b63f5..096694faab 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -25,6 +25,7 @@
 #include "qemu/plugin.h"
 #include "tcg/startup.h"
 #include "target_mman.h"
+#include "exec/page-prot-common.h"
 #include <elf.h>
 #include <endian.h>
 #include <grp.h>
diff --git a/system/physmem.c b/system/physmem.c
index 1a81c226ba..66e61990d2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -31,6 +31,7 @@
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/target_page.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index d6d4353edd..bd8f8bce60 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 31ae43f60e..cc97f1d74a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -11,6 +11,7 @@
 #include "qemu/range.h"
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index d1f1e02acc..c702781768 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -16,6 +16,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
 #include "semihosting/common-semi.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index d971b81370..8ed5cf7bb6 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/ram_addr.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 6853f58c19..add7704bf5 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index eeca415c43..aad92520ae 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index b574ec6e5b..dee485419d 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "mmu.h"
 
 #ifdef DEBUG
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 84785b5a5c..1a9b6d4fb5 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
 #include "trace.h"
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 42fa480950..5a121db6b0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -22,6 +22,7 @@
 #include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-proto.h"
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 7a57b7dd10..be5c69cc26 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 57f5308632..8344562888 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -13,6 +13,7 @@
 #include "internals.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "cpu-csr.h"
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 7a91f33b17..d314296622 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
 #include "gdbstub/helpers.h"
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index d25c9eb4d3..e2f17d4848 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 234006634e..db2b12a49e 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
 {
diff --git a/target/mips/sysemu/physaddr.c b/target/mips/sysemu/physaddr.c
index 5c5184e136..d0ea1d4aab 100644
--- a/target/mips/sysemu/physaddr.c
+++ b/target/mips/sysemu/physaddr.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "../internal.h"
 
 static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 119eae771e..302117bb30 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 603c26715e..6ca7cc023e 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #include "hw/loader.h"
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 3976416840..da446632c9 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "internal.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d645c0bb94..1633a0e5d0 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/hw_accel.h"
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 690dff7a49..5977f98689 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 751403f1c8..03713e0a90 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -25,6 +25,7 @@
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c071b4d5e2..db2dd8c76a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -25,6 +25,7 @@
 #include "mmu-hash64.h"
 #include "mmu-hash32.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..6f0f8ab0b9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -24,6 +24,7 @@
 #include "internals.h"
 #include "pmu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
 #include "trace.h"
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a76b611a0..4eff14b3f8 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
                           uint8_t val);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fa139040f8..c6716cfd30 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -23,6 +23,7 @@
 #include "exec/memop.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/page-prot-common.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index e3dfb09722..b45957c43a 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index fbb2f1b4d4..0b2240e39a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -24,6 +24,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "trace.h"
 #include "hw/hw.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 557831def4..290f84e97c 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -25,6 +25,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/cpu_ldst.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "qemu/int128.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 7c6f9d374a..21889caaaa 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -21,6 +21,7 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/log.h"
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2846a86cc4..b5fd600754 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -23,6 +23,7 @@
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "exec/cpu_ldst.h"
 #include "asi.h"
 
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index ad1591d9fd..7ff000e820 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
 
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 76bd226370..92312e5b95 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,6 +20,7 @@
 #include "hw/registerfields.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
 
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 47063b0a57..453fd37193 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -33,6 +33,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "exec/page-prot-common.h"
 
 #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
 #define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 496754ba57..a9048ad6ac 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "exec/page-prot-common.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "qemu/atomic.h"
-- 
2.41.0


