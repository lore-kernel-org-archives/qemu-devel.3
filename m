Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87ECC43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEcp-0005hx-Dz; Sun, 05 Jul 2026 00:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbw-0004my-Fx
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbn-000435-1G
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso3365415ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226253; x=1783831053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0F3fk8w9xyY/qTXkRVeJjfw3GEmLZW+XiteX2I3+/OU=;
 b=U6/MMxrQYDGwqzNcEZwXroaUYvFgmsTIaHUKbh/hxVCJr6T6pcbyvVEvsrQXbRGsT1
 ZusbAJmbeqYeHcbY4KXYsgfLHHkG2PA+FRLB3X+yDc5MNM0YdfV3X56rYnjaqfdxBK0h
 F2humGvGco5JW9rwxcNYoinY3sSmPFp/mF9VXBEygFtPqmmnkQiVmiooSxiJAkctq2XG
 kBnbGocVM2+pGvNuGvyNZWJqc3eds391nxKn9BgDRJ0zQ8LQWP+BiYfdRwZal/O9b77d
 J9hfCOGDzLL4rXqr+OmYW10ZRgBUb6vO8Spa8288sdpWOj55pGd0Ze/5Lrojl55XWa7G
 Qy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226253; x=1783831053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0F3fk8w9xyY/qTXkRVeJjfw3GEmLZW+XiteX2I3+/OU=;
 b=JQie/cPG8Np0w0o/QsiFXEh4YHTTpih9kQGEIMxIxTYjtfZ+aIOcG8Hu0+OsLPhZWx
 0/6a5vspmrTU0Ot/Q0saAhY8B7rCT4n2UFm10O2EutyHKn1+LfIsvDMKkPqjPgLICGQo
 bOmnK9/avrQ8+UIzPXGIccHzd4cbWdS3F2Qw+Hxn5LG+dbqstkhylUPxVNhlNoQ3HSOs
 szF3Qqbjt/rRTZAh+yoHYLJrp3z8gOAZd/5FWBK23Q3RZCy8feDnu2iH+4njKevu6gPp
 N1nng0nL1AZhN94W3sZcVl3kgYNi1WJGoi0Yit5i4JwGL0nZeaq8hs3bJ4On0hNDvonu
 Tjsw==
X-Gm-Message-State: AOJu0YzETrRzFeg0tG1xy37ujC5mZcznpvKmTPpfqX9rBK40TxGvr0cw
 ISCGvDpRa8s5XUF5NXMyBMDB1SQHQTg/iAXUtMvrSU1SPsKd/EJnWyl6PEfFMilWgBrdVI74+Y6
 XRDbV
X-Gm-Gg: AfdE7ckESvZMvZJ+wVxiSUiWgve5J/G8HmJYrm9zcmKPSqmSjLyTXn2EUIUbJ4U1YHn
 sDyI8aDtjU8oKJnWnmb90ewIF/xlYqtfLRWRUFvoLugtsPsWXoLKWsF8+jSnux/MwmMAL0roj9X
 RIs2kjxImycRbvR2D/0upHybMvTjNlCRvG7VppQdreJXNED4MXw5vlsviGbg6QLWBuTEiL9F7vP
 HVgFWQLkomlobZdGrpooPN+ackcYVpoSDEjocz/Yy7Kcl9uQyuzEcaFbznL2/O4035es/lQs/ZV
 w4YGRlj7FL3gyUduoZKsJOBQp7e+/spUSwtNAJsRfpZ9hJ6YNioGkykc9qd/Bi1XSqagIBk/g3K
 qrMsEbZZXqW20LOoWiUGp8jz3/ITqcNTnjINtljVw01+Z+/lB7m+Ykj49P+OjpOXpCAmRZl5Q6R
 PPNmKH/1BeON0kNtgiLo+zDG2hV5hXj7zfbYJuxPibj9rBR9c=
X-Received: by 2002:a17:903:41ca:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2cbb9c39bd4mr53629515ad.14.1783226253221; 
 Sat, 04 Jul 2026 21:37:33 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 07/46] exec/breakpoint: Merge watchpoint.h
Date: Sat,  4 Jul 2026 21:36:46 -0700
Message-ID: <20260705043725.1373137-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Move the contents of watchpoint.h into breakpoint.h.
Adjust all users of exec/watchpoint.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h           |  7 +++++++
 include/exec/watchpoint.h           | 20 --------------------
 accel/tcg/tcg-accel-ops.c           |  2 +-
 accel/tcg/user-exec-stub.c          |  2 +-
 system/watchpoint.c                 |  2 +-
 target/arm/debug_helper.c           |  2 +-
 target/arm/tcg/debug.c              |  2 +-
 target/i386/cpu.c                   |  2 +-
 target/i386/machine.c               |  2 +-
 target/i386/tcg/system/bpt_helper.c |  2 +-
 target/ppc/cpu.c                    |  2 +-
 target/ppc/cpu_init.c               |  2 +-
 target/riscv/debug.c                |  2 +-
 target/s390x/helper.c               |  1 -
 target/s390x/tcg/debug.c            |  1 -
 target/xtensa/dbg_helper.c          |  2 +-
 16 files changed, 19 insertions(+), 34 deletions(-)
 delete mode 100644 include/exec/watchpoint.h

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index b06d7ed3c3..4a025edc96 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -49,4 +49,11 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                          vaddr len, BreakpointFlags flags);
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
+
 #endif
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
deleted file mode 100644
index a09daf47f1..0000000000
--- a/include/exec/watchpoint.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * CPU watchpoints
- *
- * Copyright (c) 2012 SUSE LINUX Products GmbH
- * SPDX-License-Identifier: LGPL-2.1-or-later
- */
-
-#ifndef EXEC_WATCHPOINT_H
-#define EXEC_WATCHPOINT_H
-
-#include "exec/breakpoint.h"
-
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, BreakpointFlags flags);
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
-void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
-
-#endif /* EXEC_WATCHPOINT_H */
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 7ba682592c..38e0a038c4 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -39,7 +39,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index a10ff03922..973bdbcd7a 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -2,7 +2,7 @@
 #include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "exec/replay-core.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "internal-common.h"
 
 void cpu_resume(CPUState *cpu)
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 3785ffff46..67e4560e78 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 8477ca5def..2c3a56c7d5 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,7 +11,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "system/tcg.h"
 
 /*
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 7171501d40..f245d5b072 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -12,7 +12,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "system/tcg.h"
 
 /* Return the Exception Level targeted by debug exceptions. */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..7a7cd38b14 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -39,7 +39,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/i386/topology.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
 #include "monitor/hmp.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 1f5c517e56..cc1974126e 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,7 +7,7 @@
 #include "hw/i386/x86.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
 #include "system/tcg.h"
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index 2feea69c8a..0ba2f01016 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -21,7 +21,7 @@
 #include "accel/tcg/cpu-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "tcg/helper-tcg.h"
 
 
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 913920d55b..0306e2f57a 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -22,7 +22,7 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 #include "exec/log.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a02187ce5a..6211a586e7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -41,7 +41,7 @@
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
 #include "exec/page-protection.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "helper_regs.h"
 #include "internal.h"
 #include "spr_common.h"
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index fa47b2724e..b8fea64bec 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -31,7 +31,7 @@
 #include "target/riscv/debug.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "system/cpu-timers.h"
 #include "exec/icount.h"
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 1a2658eaf9..dabf8571cd 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -27,7 +27,6 @@
 #include "system/memory.h"
 #include "system/runstate.h"
 #include "exec/target_page.h"
-#include "exec/watchpoint.h"
 
 void s390x_tod_timer(void *opaque)
 {
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index d10e9ed892..7a838775ec 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -6,7 +6,6 @@
 
 #include "qemu/osdep.h"
 #include "exec/breakpoint.h"
-#include "exec/watchpoint.h"
 #include "accel/tcg/cpu-loop.h"
 #include "target/s390x/cpu.h"
 #include "target/s390x/s390x-internal.h"
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 990012f60e..e180096b42 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -30,7 +30,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#include "exec/watchpoint.h"
+#include "exec/breakpoint.h"
 #include "system/address-spaces.h"
 
 void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
-- 
2.43.0


