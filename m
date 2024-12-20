Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21429E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjO-0005fb-Ik; Fri, 20 Dec 2024 11:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfj4-00056w-Lr
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfj1-0008IS-Jk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:41 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso22678445e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711576; x=1735316376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+kDnYpOTd4dfWxW+/X15hMdJAWhfeFKf9XOLyUeeLw=;
 b=mrt/oi1/rIQV1SShi9H/P9LsX16WL0j1MpFlIMVctT3GWJz4b1bQHtd1MWWmmJHdG7
 MWUN/FqRPjKEEVH/xDwcxXYcGtTaW38Kr06nHX3lD95W2suzcNiP6WdcdjIEKArsxo13
 jPr0grolr6paf3rLrkZGi7NASX8NNTMQ35HaekOzwf5Plka7MZqDwloUX2vVnn8Rn9xt
 g+vOeBvU3o37b/U8mrA8nhGbCjWkEQa7NcXJGOYGLiXCzvODm9tv3iwa44KYAdApG5P1
 8+OqEKTNbbzCt+UZOcB5Ly2f4glw3T2fb0eYbge+5VbZ4rHWflzJ4g4KIY6fm0rGOxAi
 WTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711576; x=1735316376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+kDnYpOTd4dfWxW+/X15hMdJAWhfeFKf9XOLyUeeLw=;
 b=WBzGyVz024FsRxMZwYjzbVOYKZRxH2myGDMK504j455s0HvZ7XdrL3bPhT71mrGD3R
 UtBcCmO9tzCfDFKEGrhJtqtnEOLxiSSJCWOUq2Q/ujcL51ZhI5siMRo93rSF/NOHZrwQ
 68WgWpgpRjlfvFCFBdK6mCONTK22Hwx4Y9Yr2RIlzGqLDfeYZ/0ADZKDm4f5wUViJ3SZ
 /DHPtb+KIqH/GNDpesm7U7QsT7HIgGbilh4QI2biEI06gnH6k+5C5znPmsaVH7w01g6n
 mHcbS/xl5ZLKkwt+W4Dvo8hWBiW5Y1aaGEIfeAQRwyJp0Jp0LlYWzDNWgxgwO7ld2h/l
 hHjg==
X-Gm-Message-State: AOJu0Yxh1irrBcJor62c96Sqicbk2CG6Ub02mTZr5MExqvXI+iw3POnk
 u17ezNhd8mi2RX/yqa+PwEEHS2XfUrEmgGx2m5WaeLo9fgrdQC2OgdokSk0s9JPKOqExBOmpnjp
 A
X-Gm-Gg: ASbGncud5D9PTyhJsb23kofQ6v/5Bh3i384ybA9yrMUF6/rGddwp7UkiK3hYCkjdWMt
 gVp8ZNENiegq+mCePZRTpSwl78jCL0Wt9M9XXw2+MCstxlkI+A3wbjdq3Qcrk+ayUeQ72D5fEZA
 yrK5Aa+btvhbCm9A4oG4okVLVfy6A0tRfN/5BpOIASwmvYUavEftaqLDc2eZHXEODJOTJKEbOHv
 qZLKESd7SE2fPpcIdtSlBxfL+qNNyz1o80gwNVBvkIm3me2WsKpxyiFy6p5i+ZD08aVn83A6EQ=
X-Google-Smtp-Source: AGHT+IF+EN38ljLEqtMGr95kxQ4xgkdcFrz8TjSt11pYF7/vvzSPqudgR1wNa09ewmQhci2Pw4dLSg==
X-Received: by 2002:a5d:59ab:0:b0:385:fd31:ca31 with SMTP id
 ffacd0b85a97d-38a223fd39fmr4243403f8f.53.1734711576333; 
 Fri, 20 Dec 2024 08:19:36 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828bd3sm4349740f8f.10.2024.12.20.08.19.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 49/59] accel/tcg: Move tcg_cflags_has/set() to
 'exec/translation-block.h'
Date: Fri, 20 Dec 2024 17:15:40 +0100
Message-ID: <20241220161551.89317-50-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The TranslationBlock flags are defined in 'exec/translation-block.h'.
tcg_cflags_has/set() use them, it is more logical to declare them in
the same place. Move them there too.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212144430.66224-2-philmd@linaro.org>
---
 include/exec/cpu-common.h               | 3 ---
 include/exec/translation-block.h        | 3 +++
 accel/tcg/cpu-exec.c                    | 1 +
 accel/tcg/tcg-accel-ops.c               | 1 +
 accel/tcg/watchpoint.c                  | 1 +
 linux-user/mmap.c                       | 1 +
 linux-user/syscall.c                    | 1 +
 target/arm/cpu.c                        | 1 +
 target/avr/cpu.c                        | 1 +
 target/hexagon/cpu.c                    | 1 +
 target/hppa/cpu.c                       | 1 +
 target/i386/cpu.c                       | 1 +
 target/i386/helper.c                    | 1 +
 target/loongarch/cpu.c                  | 1 +
 target/microblaze/cpu.c                 | 1 +
 target/mips/tcg/exception.c             | 1 +
 target/mips/tcg/system/special_helper.c | 1 +
 target/openrisc/cpu.c                   | 1 +
 target/riscv/tcg/tcg-cpu.c              | 1 +
 target/rx/cpu.c                         | 1 +
 target/sh4/cpu.c                        | 1 +
 target/sparc/cpu.c                      | 1 +
 target/tricore/cpu.c                    | 1 +
 23 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74e947f3adc..b1d76d69850 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -188,9 +188,6 @@ void list_cpus(void);
 #ifdef CONFIG_TCG
 #include "qemu/atomic.h"
 
-bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
-void tcg_cflags_set(CPUState *cpu, uint32_t flags);
-
 /**
  * cpu_unwind_state_data:
  * @cpu: the cpu context
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 81299b7bdb5..3c69bc71a9f 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -154,4 +154,7 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
     return qatomic_read(&tb->cflags);
 }
 
+bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
+void tcg_cflags_set(CPUState *cpu, uint32_t flags);
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c07e59cd0b1..b507049ddbe 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -27,6 +27,7 @@
 #include "disas/disas.h"
 #include "exec/cpu-common.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "tcg/tcg.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index d9a35b7667c..6e3f1fa92b2 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -35,6 +35,7 @@
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
+#include "exec/translation-block.h"
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index fbaf45d10f2..af57d182d5b 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "system/replay.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4e0444b4cbc..6828b17a63f 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "qemu.h"
 #include "user/page-protection.h"
 #include "user-internals.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1b335688f12..78c7c0b34ef 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -26,6 +26,7 @@
 #include "tcg/startup.h"
 #include "target_mman.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include <elf.h>
 #include <endian.h>
 #include <grp.h>
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b085c068ad1..f45cd18ff7e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #ifdef CONFIG_TCG
+#include "exec/translation-block.h"
 #include "hw/core/tcg-cpu-ops.h"
 #endif /* CONFIG_TCG */
 #include "internals.h"
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a7529a1b3d9..698e0c5161f 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a70007245e4..c213ce8d889 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c1800..c9062e60b67 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 96a2608e995..f3a97dc61b1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -24,6 +24,7 @@
 #include "qemu/hw-version.h"
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
+#include "exec/translation-block.h"
 #include "system/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index a78d06c95ba..3bc15fba6ee 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -21,6 +21,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "system/runstate.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/hw_accel.h"
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fa838dce2e4..f5bc8720d1f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -15,6 +15,7 @@
 #include "system/kvm.h"
 #include "kvm/kvm_loongarch.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "cpu.h"
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0e41e39c0e2..9db5c4d2a35 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -30,6 +30,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/gdbstub.h"
+#include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 4886d087b2e..1a8902ea1bc 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -24,6 +24,7 @@
 #include "internal.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 
 target_ulong exception_resume_pc(CPUMIPSState *env)
 {
diff --git a/target/mips/tcg/system/special_helper.c b/target/mips/tcg/system/special_helper.c
index 9ce5e2ceac5..3ce3ae1e124 100644
--- a/target/mips/tcg/system/special_helper.c
+++ b/target/mips/tcg/system/special_helper.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "internal.h"
 
 /* Specials */
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 3ccf85e95f0..7913a0c3e11 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c2216961..958b8c89cbf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "tcg-cpu.h"
 #include "cpu.h"
 #include "internals.h"
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 69ec0bc7b3d..558280c7945 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -23,6 +23,7 @@
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index d5008859b8e..e9d3e12a62c 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fc0c66afecf..960ed903513 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "tcg/tcg.h"
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1a261715907..95fb546666f 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
 
-- 
2.47.1


