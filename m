Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B27CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkQl-0007ou-Ks; Thu, 12 Dec 2024 09:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkQk-0007od-DM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:44:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLkQi-0004DW-8D
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:44:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so5041035e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734014678; x=1734619478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qp4hT6KANxF5mFm0n9MmO+6Us3wInf0FaD8+gtby53Q=;
 b=LqUp9Tkm2BWPVAqM4wuaekHbcpWBpCJMNOBZ3ffMXxcXPr1Kd+2aP3PImUPW6cqZTT
 NJN1eHdriQ1XXZGY3rf6wUYr8OgJizJV8p1RzK2KBudaV4UisTV2w6js0TS3eCf7bb0c
 KkrJOKi+4boX/nyQP4LLoP+V8MoXyfnkhjbMd2jEtOHbQi39uG1A0dfF/B6UIAk4WCQ/
 mlDurHE+oMtqw4BALDbaB6IzFA+bd1/THYrB114tWKPgGobj+9/YyuVptWJi2DvHW7x8
 jo3oA9bTOWqj7VZKGsNkJyJ3218X62oERdPHyvcl34EDB2uEkWXe8Bdvb4bwlb2McZKl
 GrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014678; x=1734619478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qp4hT6KANxF5mFm0n9MmO+6Us3wInf0FaD8+gtby53Q=;
 b=E0zdOhWY5/TcfY+HE56kqc4wNGYKHVCyoCbSmjCuVUEisgCRUzDAwzI4OtyvEzUzdW
 PA7nEdZ5vL3AKZ4IH7vMU9x/xoNammw0XDGklnd4jU/4hlarVLQIpNmKWljzjo6YVpFQ
 H1n5d3hpleQpgnxJ9C+G8lIp+PoLs3cIqgGFe5fmTx6movuy3Ccm9tN+yRQpr13LgumF
 wJu3AHbXnB28eHl8gxtk4Olr456m/XMi5osIr4AMhmEs8fdpijBbuJkXEad00e2fhMQO
 fzE6rrxbm8OuG+4XMV7GhBFbVHOzigwyrAs1w2gbMwL9M19RwR+5By7Z+2i4m1gY/WQB
 cFCQ==
X-Gm-Message-State: AOJu0Yyc335a7GrseDhYtb2qESFhlMZvKDlXA0Y0xdVTl6/32+brecGM
 X//30v5aocmP0S5Rikn9lDU8ssxN+9xPhgK223CgC2z+PSG4PfOuEwYyj+yrfa8un9BAkdHGMUl
 W
X-Gm-Gg: ASbGncubTzwXdV60JQUrnBtFatSXDcSP5TC5DWzQmqU99m0gCON8YO5Ct7bF8uxey1u
 YaLEtrUTZPVaK0Wq3HaxdsL4M4MU7I/qjPC+VtP1SSSeJMAPH10kq/x9Wl5yt/UzUDKRax2BJ+L
 tjNiVoR2RFUM4RqzQQLrYSNEY+BCJ62mZJdpI1YWuUJLRtBYGGjXacgBItbDlei1MMZNV59eyk4
 tpE1N4pmK1nHIbeo76FNPsGHzUnepKavyfSgabItRUkCb+MROXxbX1MBXf59hg/PeU8CR3skpFj
 xXHuA0hdz3X8gAiOSDsZMVs7++U5kKc=
X-Google-Smtp-Source: AGHT+IFh/YaZ++JtIjDPk2cfA3YL/zyL8e1m63PpvjniXfw0rBm+zZcWTFGrg6yP/b3zhLIUhHgRkg==
X-Received: by 2002:a05:600c:1c14:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-4361c396c09mr59484235e9.2.1734014677700; 
 Thu, 12 Dec 2024 06:44:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514e86sm4274742f8f.72.2024.12.12.06.44.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:44:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] accel/tcg: Move tcg_cflags_has/set() to
 'exec/translation-block.h'
Date: Thu, 12 Dec 2024 15:44:29 +0100
Message-ID: <20241212144430.66224-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212144430.66224-1-philmd@linaro.org>
References: <20241212144430.66224-1-philmd@linaro.org>
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
tcg_cflags_has/set() and curr_cflags() use them, it is more logical
to declare them in the same place. Move them there too.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h               | 6 ------
 include/exec/translation-block.h        | 6 ++++++
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
 target/mips/tcg/sysemu/special_helper.c | 1 +
 target/openrisc/cpu.c                   | 1 +
 target/riscv/tcg/tcg-cpu.c              | 1 +
 target/rx/cpu.c                         | 1 +
 target/sh4/cpu.c                        | 1 +
 target/sparc/cpu.c                      | 1 +
 target/tricore/cpu.c                    | 1 +
 23 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5f..bdeb9d68f32 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -187,12 +187,6 @@ void list_cpus(void);
 
 #ifdef CONFIG_TCG
 
-bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
-void tcg_cflags_set(CPUState *cpu, uint32_t flags);
-
-/* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
-
 /**
  * cpu_unwind_state_data:
  * @cpu: the cpu context
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index b99afb00779..c1e48a48aab 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -153,4 +153,10 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
     return qatomic_read(&tb->cflags);
 }
 
+bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
+void tcg_cflags_set(CPUState *cpu, uint32_t flags);
+
+/* current cflags for hashing/comparison */
+uint32_t curr_cflags(CPUState *cpu);
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c13f4a7cbbf..91e742933fa 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
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
index ca641eb95cf..facff4175a8 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
+#include "exec/translation-block.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e4bf5d5f39c..a2f8766b5c6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "exec/log.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "qemu.h"
 #include "user-internals.h"
 #include "user-mmap.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1ce4c79784f..5830014b657 100644
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
index 237f35c861a..e5be73d420a 100644
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
index 3132842d565..dda63f913ca 100644
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
index 020038fc490..489d68dc50e 100644
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
index c5edf58421d..8bbf914c579 100644
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
index 078766feafc..dfdd1f78602 100644
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
index 710eb1146c1..a5658f1aae0 100644
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
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/sysemu/special_helper.c
index 9ce5e2ceac5..3ce3ae1e124 100644
--- a/target/mips/tcg/sysemu/special_helper.c
+++ b/target/mips/tcg/sysemu/special_helper.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "internal.h"
 
 /* Specials */
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f26..c11a09cd062 100644
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
index 65a74ce720f..945ae6e9e50 100644
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
index 8f07261dcfd..2a51d9e35c7 100644
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
index dd7af86de73..1480571a1bf 100644
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
2.45.2


