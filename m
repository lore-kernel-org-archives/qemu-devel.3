Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C704BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEm-0001C8-54; Fri, 10 Jul 2026 16:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEh-00016u-8L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEb-0000cH-Jl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1161417b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716848; x=1784321648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fk3aaqwEL447TLAUxQvRMrNROG8iRdVw/mnS/h1SzDM=;
 b=l94OAmaKL0EIKtarLCm8pkrzcHzJ7IUidHjNxh6HjPu0R71u1cnXbhaZQSuWIy0yr6
 73Jm0GW5S6+0eeEkQc0arLgI9vHfiJxHgnnhf078xQCz2CNB5f0f+vlmYcMKlTUGECSr
 v/l0gR6Iqr3PBOA+AkRaD9i/PptYVZys7THM97b6Ko+rCXoDTjeeb/Ojru4//QR6rHh/
 VhXqmhvp3TxiMhFpKL0M34yS9bv1Rjfv6IfzrCxhI1mb72vw3zWTSnITi5pe27OM4wJ0
 IZoGKCLQk49UFQVjjd/y4/PCeuEBtYZQw+tFusOIoGpnoncbJA6gu1lu2JrWhKA6z0Ng
 wyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716848; x=1784321648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fk3aaqwEL447TLAUxQvRMrNROG8iRdVw/mnS/h1SzDM=;
 b=d83G8viNEYtcOMQJnCuFOlzVqiCmwkoKDPQKGXWvPmYlpW1cZkjYLnzFOuaNq9yRif
 /+WgTmXwdCfdSDPnjIQwYn2wYtKWwgKaSwowaq0IJN52wmara9FJG/cpvNqhZLjGXuB6
 7oZSfc8bUaoKYRKDgpk40YkYqLTCyxfBWshYxhAicoGn/Asnq22zm91zKBgHMZ7/eDjG
 BcUO/y6sIOAXGkid7md6euLa0QYWgPD8qDNGUfz/0PXJj0lqelKZ/DDQCON+EnGKair/
 icI6wo5zZhdQ15OnH1mhItfMwoTVNHOk2Peyn8HFuw76GkOKfMORgGciOvfkuDdwixgq
 YXhg==
X-Gm-Message-State: AOJu0YyysHdIYPB9Ba+MUrp7e5aWAugj1svYa3vsocjS2+jlK6TkM9cB
 69zzuklsvsXrDIVKMyNsjm2DW4Lm1jEaSmbKd1zdx6fuwXjNVKnSVSbKZR9GtxkWTmKBRXbFm4a
 Nx5Z8
X-Gm-Gg: AfdE7cl6daIbIPEbBoGTSS/1rZ4Txyh0anxkSX/3If1uv7jWGio1Zgkb6JsJZTmjSRW
 5JjIKVtukgpgiSZRyk32OejJfzGRSxN+4Q6Uh2yXOBPwUac+RvCX41rmC/o+sq66Qzcq+7QH0LC
 BntsKnZrKkDYicGRZcAW+A3fmCBg/a9IPLuL3arFwRGaFiJjV+IAqlFQVoCfg+FElkveu8HRdG6
 SejRJqTDBVpODK6ccPP+Qv8bUpQZdqBCAiwj2e3/Z5ohEl5ydIItt2XPg66oYtaC6jJACEn9ZPm
 Yntt/X7t8PiBfyvlC/zOuD3D+ymEesWlPBM7GLbVKteb3goZfTAucbQfpwcRF8babEqHEC+ua0k
 qDt8SVIqiyPZaDjZfcB/KysM6Zf/nPzSDDwJ8PV5jsfrdYyHisgSLCgAvU9T/J15UR/0fI7VBRe
 n4WaHUUJ3uanEn3BWEKA==
X-Received: by 2002:aa7:88c8:0:b0:842:5bf3:c53c with SMTP id
 d2e1a72fcca58-848895db20bmr576161b3a.2.1783716847914; 
 Fri, 10 Jul 2026 13:54:07 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 03/51] exec/breakpoint: Merge watchpoint.h
Date: Fri, 10 Jul 2026 13:53:13 -0700
Message-ID: <20260710205401.836304-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index e6aa630d17..c886f3afb7 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -50,4 +50,11 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
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
index 0aba254b81..c59ab85606 100644
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
index df0e0c178e..390ccfa3f8 100644
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
index 36e1209119..7ff352b11b 100644
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
index f404c7e549..9dd91ae95a 100644
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


