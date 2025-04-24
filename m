Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0095C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kr8-0002GE-FU; Wed, 23 Apr 2025 20:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqR-00010q-6S
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq3-0004hQ-0R
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so304483b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455994; x=1746060794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tycB/Ucpd1VV/Am2B/wQ8+fOjRJD7I+YEhW19LaJbw8=;
 b=TFYcdRhfmmuK+Vuje27eZeFaQciDhmAwSdUQGP8s3cKg/vGZAOiimYCVeyrXLprlW3
 nI3Lvu0j/dQJl7kBvETJbGEVzoLhHRQoEWzBXB0C5UKAMn8SXA7WmSV4ldu8J11vwnDS
 uRNQz7m1Zbd6JseGoTlBrprMufMTeQFceCWMHDKWzHUVGf0cpux5Y2kR39wfXAd5Unb3
 nHLhbK0WMQPhpR4F0Ovk8y+P+K1NWEdboNDBh3qlHqPsPizJkmbcMV47ytDisOHFKGTe
 ebR9ViZaGZ5xjAuR0HynJ1WHSBdAztfK9NDapHutx+THz7TfChFD2A4vucm+mFJ/pHJZ
 xATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455994; x=1746060794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tycB/Ucpd1VV/Am2B/wQ8+fOjRJD7I+YEhW19LaJbw8=;
 b=kUE3FytEVwwaspf338t3ifsAbXa+6dtGzFXiiHcsiEmirUUiK2bEEAKqUBjNvkTlFS
 zX4xwX3EDW9LIt0PyhmfsvgTQSHzzZLt4Z9sh2UJbdvMJCcYBpvgd17ph+RIiuyw5h8F
 FiuaCB+LnZv2Ufy5fHnaMS82qzvles/6TRhoIWfpglxqHlJAlzUwr16CVyIFMAwUufxv
 IkhwudlE9B5hn1xN8yMHngIeRVU5TcHmpv1aUFIdIe74LRrZJP+VY1ybhSdWerrqGBTG
 M2anHEp1hhbxPF1nNbLsnEBZS5vZlC/ynEq+GIUY45Jxo7M6yUFtYRICvJgYwtvNrD+C
 gtvQ==
X-Gm-Message-State: AOJu0Ywtbf9aG5RzQTaBIuq7cwShmxW+YcCcAcYmpa3qkfTDRRWXUc/A
 OXOp5eqIKCYJTeWcyioS0gTY3l3J1tsMgnmXMKy38dr1LIXmNA1oQlB1PmPyQWOwTdYkiQD0iPs
 P
X-Gm-Gg: ASbGnctBLB28cphYBFl14Jz3pnsjoU6GHtvaE0vPXTe6v4tRg+0B4oQID9i7j7p/HfM
 FXiQ7x3ovbtlwp4vQ5TrfpraB4hb6GP0R2E5SqwKRAdxUtaAP38BTnpAiHV+jPtBDNn+1X0IGtH
 pJSLPBKYX3kSdNSMUZnm5juKK/LTByGM5kZeN0/8QzV5SGCG8LZ8+PgRhmYxXewkeose/dxU1Or
 ZTBAqzNmHe7ldWYq7G1rlH+Z62SwVFqbJ5OXsS0cDYiy2VFnNCFzDckNGeFCJqkkJd7k+fd/YsS
 4ZZap9ZMzH8om1t+H1a6yguCNjY/+u7HAYMily+yOI3GJGqwMzjZTOs/b4MtrUADskjcI1VxytY
 =
X-Google-Smtp-Source: AGHT+IGg66qKuktfF5Om8JEt/izTK/gdUJu4UK4SGlhaqISbwPYXjhp9pk7WP2C0cExj6PFW3rwZwg==
X-Received: by 2002:a05:6a21:1304:b0:1f5:9024:3246 with SMTP id
 adf61e73a8af0-20444f053a4mr759198637.17.1745455990459; 
 Wed, 23 Apr 2025 17:53:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 048/148] include/exec: Split out watchpoint.h
Date: Wed, 23 Apr 2025 17:47:53 -0700
Message-ID: <20250424004934.598783-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Relatively few objects in qemu care about watchpoints, so split
out to a new header.  Removes an instance of CONFIG_USER_ONLY
from hw/core/cpu.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/watchpoint.h           | 41 +++++++++++++++++++++++++++++
 include/hw/core/cpu.h               | 30 ---------------------
 accel/tcg/tcg-accel-ops.c           |  1 +
 system/watchpoint.c                 |  1 +
 target/arm/debug_helper.c           |  1 +
 target/i386/cpu.c                   |  1 +
 target/i386/machine.c               |  2 +-
 target/i386/tcg/system/bpt_helper.c |  1 +
 target/ppc/cpu.c                    |  1 +
 target/ppc/cpu_init.c               |  2 +-
 target/riscv/debug.c                |  1 +
 target/s390x/helper.c               |  1 +
 target/s390x/tcg/excp_helper.c      |  1 +
 target/xtensa/dbg_helper.c          |  1 +
 14 files changed, 53 insertions(+), 32 deletions(-)
 create mode 100644 include/exec/watchpoint.h

diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
new file mode 100644
index 0000000000..4b6668826c
--- /dev/null
+++ b/include/exec/watchpoint.h
@@ -0,0 +1,41 @@
+/*
+ * CPU watchpoints
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef EXEC_WATCHPOINT_H
+#define EXEC_WATCHPOINT_H
+
+#if defined(CONFIG_USER_ONLY)
+static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                                        int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                                        vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
+                                                CPUWatchpoint *wp)
+{
+}
+
+static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
+#else
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint);
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                          vaddr len, int flags);
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+#endif
+
+#endif /* EXEC_WATCHPOINT_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index abd8764e83..37cb7d1531 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1109,36 +1109,6 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
     return false;
 }
 
-#if defined(CONFIG_USER_ONLY)
-static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                                        int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-
-static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                                        vaddr len, int flags)
-{
-    return -ENOSYS;
-}
-
-static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
-                                                CPUWatchpoint *wp)
-{
-}
-
-static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-{
-}
-#else
-int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint);
-int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags);
-void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-#endif
-
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index d9b662efe3..5c88056157 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -37,6 +37,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
+#include "exec/watchpoint.h"
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 08dbd8483d..21d0bb36ca 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "exec/watchpoint.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index a9a619ba6b..473ee2af38 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -13,6 +13,7 @@
 #include "cpregs.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/watchpoint.h"
 #include "system/tcg.h"
 
 #ifdef CONFIG_TCG
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5c9f80b4cc..c596e2174d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -35,6 +35,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
+#include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 70f632a36f..6cb561c632 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,7 +7,7 @@
 #include "hw/i386/x86.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-
+#include "exec/watchpoint.h"
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
 #include "system/tcg.h"
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index be232c1ca9..08ccd3f5e6 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/watchpoint.h"
 #include "tcg/helper-tcg.h"
 
 
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index bfcc695de7..4d8faaddee 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 #include "exec/log.h"
+#include "exec/watchpoint.h"
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f81cb680fc..17f0f3d3ff 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -40,7 +40,7 @@
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
-
+#include "exec/watchpoint.h"
 #include "helper_regs.h"
 #include "internal.h"
 #include "spr_common.h"
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 9db4048523..fea989afe9 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/watchpoint.h"
 #include "system/cpu-timers.h"
 
 /*
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index c689e11b46..e660c69f60 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -27,6 +27,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
 #include "system/runstate.h"
+#include "exec/watchpoint.h"
 
 void s390x_tod_timer(void *opaque)
 {
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index ac733f407f..1d51043e88 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/exec-all.h"
+#include "exec/watchpoint.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 163a1ffc7b..c4f4298a50 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -31,6 +31,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
+#include "exec/watchpoint.h"
 #include "system/address-spaces.h"
 
 void HELPER(wsr_ibreakenable)(CPUXtensaState *env, uint32_t v)
-- 
2.43.0


