Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64114E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYDu-000558-No; Tue, 17 Dec 2024 09:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYDt-00054j-Kl
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:06:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYDr-00012J-Pn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:06:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f796586so59480545e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734444410; x=1735049210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=74gRFMianHMsIWZDOBz6aYywOh8vp8qmdUQzHnxSF2o=;
 b=Iz+WMUEE010sDUqyCKEyFfWDhpGSi4MC7X85/YlpaLZILCHH0UGU3f//GJjNzSVk/T
 zN6eDTzpLcr+51HF6SNUCz7wuZD6WhAnFno4x6vUm8X5YCzUQK77v6dnsXk6RxaxjBar
 Cq0G8r545EAt0C7R3LQv+qbjK4hgcOk3dVQmcoAbuu14nsCioqfO57N1XwXAG31O4Sa9
 ynIo3aCfmO6RhTDHiGjdnL7gLUnYzQO2Ob2C9zSePFj3DYYFu8QfkPcNVufaKS6rKtRl
 eTSeSxgTi0TgtpKbj7HKYaAZ86irwke11rv+JImZQq/lTcUe3KR4W7ydpXvr/6kyTmd1
 jG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444410; x=1735049210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=74gRFMianHMsIWZDOBz6aYywOh8vp8qmdUQzHnxSF2o=;
 b=M6Roz+4ljUP3QRcGnPgptcOlbAs56kP2hDhbpoumCNJcKCpliM3b0Vic0xUKhear05
 lWrO9dsVI4gDzNfKP5qvjAPlM46sNF1Wg3TxlyC/8bniZkL64S6ayDzPs2OLMaXLnowU
 F90qASUSecn48g5SCoo23FJwuO71X+zZE2ESkpr6u1uFfxVrxhnfzX4YUZ35VRBw5pxv
 3SG1l8YuIPT3sVwOqcdF0dirQ+V3JXcuJPjoa7HtMxVWR3G6kobiSnrQ/4bOkL3VGPkJ
 Bdsqls/dv+NWohcIl6BiXFXmQ84D8cNfMkOVixRCMRv7HczwfQfPtkq26/zSMzV6Bkan
 AUrw==
X-Gm-Message-State: AOJu0YyPZGO7dkw4BSPxv2SP3aMRuzqEBxuAxH72z3AoGW/lVvS/CrRj
 clh3BBn9aGqrjRv/yeUiaqn2XI4GSsBs4IPtJNz5HZXaqyECrUj/Q89DvB3gJpEhgozXAM7OHAh
 i
X-Gm-Gg: ASbGncs8nwC5ZB6BO41CtvSXk5aV1IPRRMeXN60+t19tJ1uYv5x6lN38WvgwiR/Ahzh
 1vsTUVeAqcU/GxjOuN6zKkFjYHDkTWWQansxb1KlqFBZkUQt08543LOT65sEdekQ+xZW+KrrF9A
 eQf/XDFRLkVLM+XESeAptPQmQhtA//jIltuvHb4WnzGP2hhqjQZBMlDwwwiM+5JvGQzLcZSaBic
 A5dWWpMnUve7Vg31omI/FQfo+MKYda2BJaFziEV4EsHBIjESnqAWFsKXOZX4XBh2Qlmv72XCMY+
 GBUv
X-Google-Smtp-Source: AGHT+IFulEUYgnSbs0uZvf3vSHRgGudBKkYF8mJuGEg43/jsofPNbWv+QTYv6r7BVmsisGHYLrPf0w==
X-Received: by 2002:a05:600c:6549:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-4362aa1b061mr185727495e9.2.1734444409806; 
 Tue, 17 Dec 2024 06:06:49 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4363606f030sm118380655e9.26.2024.12.17.06.06.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 06:06:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Declare cpu_loop_exit_requested() in
 'exec/cpu-common.h'
Date: Tue, 17 Dec 2024 15:06:48 +0100
Message-ID: <20241217140648.98538-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Move cpu_loop_exit_requested() declaration to "exec/cpu-common.h",
along with the related cpu_loop_exit_noexc(), cpu_loop_exit(),
cpu_loop_exit_atomic() and cpu_loop_exit_restore() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20241212185341.2857-19-philmd@linaro.org>
---
 include/exec/cpu-common.h     | 18 ++++++++++++++++++
 include/exec/exec-all.h       | 17 -----------------
 accel/tcg/cpu-exec.c          |  2 +-
 target/arm/tcg/helper-a64.c   |  1 +
 target/s390x/tcg/mem_helper.c |  1 +
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5f..0cf9a3d369c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -186,6 +186,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 void list_cpus(void);
 
 #ifdef CONFIG_TCG
+#include "qemu/atomic.h"
 
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
 void tcg_cflags_set(CPUState *cpu, uint32_t flags);
@@ -218,6 +219,23 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
  */
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
 
+/**
+ * cpu_loop_exit_requested:
+ * @cpu: The CPU state to be tested
+ *
+ * Indicate if somebody asked for a return of the CPU to the main loop
+ * (e.g., via cpu_exit() or cpu_interrupt()).
+ *
+ * This is helpful for architectures that support interruptible
+ * instructions. After writing back all state to registers/memory, this
+ * call can be used to check if it makes sense to return to the main loop
+ * or to continue executing the interruptible instruction.
+ */
+static inline bool cpu_loop_exit_requested(CPUState *cpu)
+{
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
+}
+
 G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 #endif /* CONFIG_TCG */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c4a6ad3af2d..d9045c9ac4c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,23 +27,6 @@
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
-/**
- * cpu_loop_exit_requested:
- * @cpu: The CPU state to be tested
- *
- * Indicate if somebody asked for a return of the CPU to the main loop
- * (e.g., via cpu_exit() or cpu_interrupt()).
- *
- * This is helpful for architectures that support interruptible
- * instructions. After writing back all state to registers/memory, this
- * call can be used to check if it makes sense to return to the main loop
- * or to continue executing the interruptible instruction.
- */
-static inline bool cpu_loop_exit_requested(CPUState *cpu)
-{
-    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
-}
-
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e9eaab223f9..c07e59cd0b1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -25,7 +25,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 #include "exec/page-protection.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 58eaca66012..95e46071cab 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -29,6 +29,7 @@
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 307388e5bd1..b617f78204f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -25,6 +25,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "hw/core/tcg-cpu-ops.h"
-- 
2.45.2


