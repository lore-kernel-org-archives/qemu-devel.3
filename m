Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C88C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cp8-0000gm-3i; Sun, 28 Apr 2024 18:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cov-0000Nn-IQ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cot-0005gr-Jf
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:29 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5723edf0ae5so3973282a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342585; x=1714947385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxBbrax01pE31M/V9b7kPXje3fQe3SttCsF8VW1iSMw=;
 b=sn7uLHoVIuJ7f5oGukIKrFwHZAui5vBKajxuxUrmf2hJp3jlRAc4xGzzIiS3VrdYQE
 CmrXP1//rEC270A3qxz4d+ZO9Qt8da4hzucOFJqAHM6P8qYzGg1Masg+jx4X91HR3kZB
 V04i2yeenLVy3clcFn8FVqRHDPalz5ILqccuDjpabGsNeGgyhjTerFeQTL2E7zYNI80o
 t/x2iSi+3YDVIIMFDtpnVru3cm+ENcVmg1AD6lncLDKCKGcN2DJ4lwVp2w1amlJ2EkaM
 fbkdnMaxOGx5fG7tHJJm+txf0JrnPwXgDK+H+1PPvKinGoEc4yTyNn0nVBTjAXfuRfmo
 MIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342585; x=1714947385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxBbrax01pE31M/V9b7kPXje3fQe3SttCsF8VW1iSMw=;
 b=L7S1kZAsTSnN1GDLJH7UuqhJbNYsW6hhnyhe/3JNypSGR9uv6wMhZw7WJ2Z3Za/OTA
 MPmTuU4dGIiKdxss7mRzX2mFeCx7hOBD5gqXfJmTP8BRVhsV/O7+tUjPvJe+gXCugngL
 L61EszkUvTtsKJqMhnhGMYHgPjFycnHMXICU7m/s0C82ur1Z0HNk2ko6s7LyuL3jFHQd
 DzyL9wr5o2EZnRQrFMWF+cZULqoRCL15JnzT2uGdN+SA8Ag70UH+Mt5H3XexNzyw/Po0
 RzbFGXVbij1I7h61Jp5HgvrsXhHRxjw0waquOs2KXjhTg6sHY1ptLNpBhoHMu42IJQAP
 52ag==
X-Gm-Message-State: AOJu0Yw7ntkbdczSxGPS/4En9UZ9S98vTtfqIotpfQZuF4StgITEOant
 5NLFySrfCxB5JpcvdfAwqgPKBwO/lzjv1qbJBhroxACqpa8KHNYRT49w7eK4XLDY1iaQO4BYVQ3
 I
X-Google-Smtp-Source: AGHT+IEwKbGt/KJgJOk2cC+wY3ZXaHfJmOTT64v11MyhSj17OwgjlSz3I0X5Nuga+YQYjJCunmcjVQ==
X-Received: by 2002:a50:d51c:0:b0:572:7e54:a970 with SMTP id
 u28-20020a50d51c000000b005727e54a970mr1592309edi.39.1714342584946; 
 Sun, 28 Apr 2024 15:16:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 29-20020a50875d000000b00572872bf891sm143283edv.52.2024.04.28.15.16.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/24] accel/tcg: Move @mem_io_pc from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:43 +0200
Message-ID: <20240428221450.26460-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

@mem_io_pc is specific to TCG system emulation, move it to
AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h    | 3 +++
 include/hw/core/cpu.h     | 2 --
 accel/tcg/cputlb.c        | 2 +-
 accel/tcg/tcg-accel-ops.c | 1 +
 hw/core/cpu-common.c      | 1 -
 hw/misc/mips_itu.c        | 3 ++-
 target/i386/helper.c      | 3 ++-
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index cb06f0412b..d1f989c625 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -10,12 +10,15 @@
 
 /**
  * AccelCPUState:
+ * @mem_io_pc: Host Program Counter at which the memory was accessed.
  */
 struct AccelCPUState {
     sigjmp_buf jmp_env;
 
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
+#else
+    uintptr_t mem_io_pc;
 #endif
 };
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6d3716f619..4df9bfeba9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -423,7 +423,6 @@ struct qemu_work_item;
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
  * @node: QTAILQ of CPUs sharing TB cache.
  * @opaque: User data.
- * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
@@ -502,7 +501,6 @@ struct CPUState {
     /* In order to avoid passing too many arguments to the MMIO helpers,
      * we store some rarely used information in the CPU context.
      */
-    uintptr_t mem_io_pc;
 
     /* Only used in KVM */
     int kvm_fd;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdb3e12dfb..e9d6faf78f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1383,7 +1383,7 @@ io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
 
     section = iotlb_to_section(cpu, xlat, attrs);
     mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
-    cpu->mem_io_pc = retaddr;
+    cpu->accel->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 56bbad9fcd..dfa0357558 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -89,6 +89,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
     cpu->neg.can_do_io = true;
+    cpu->accel->mem_io_pc = 0;
 }
 
 /* mask must never be zero, except for A20 change call */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 3e00ea94be..21151f5634 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -117,7 +117,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 
     cpu->interrupt_request = 0;
     cpu->halted = cpu->start_powered_off;
-    cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index f8acfb3ee2..aa11548e71 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -26,6 +26,7 @@
 #include "hw/misc/mips_itu.h"
 #include "hw/qdev-properties.h"
 #include "target/mips/cpu.h"
+#include "accel/tcg/vcpu-state.h"
 
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
 /* Initialize as 4kB area to fit all 32 cells with default 128B grain.
@@ -185,7 +186,7 @@ void block_thread_and_exit(ITCStorageCell *c)
     c->blocked_threads |= 1ULL << current_cpu->cpu_index;
     current_cpu->halted = 1;
     current_cpu->exception_index = EXCP_HLT;
-    cpu_loop_exit_restore(current_cpu, current_cpu->mem_io_pc);
+    cpu_loop_exit_restore(current_cpu, current_cpu->accel->mem_io_pc);
 }
 
 /* ITC Bypass View */
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 48d1513a35..6c188ea94c 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -30,6 +30,7 @@
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
 #include "tcg/insn-start-words.h"
+#include "accel/tcg/vcpu-state.h" // ???
 #endif
 
 void cpu_sync_avx_hflag(CPUX86State *env)
@@ -518,7 +519,7 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
     uint64_t data[TARGET_INSN_START_WORDS];
     CPUState *cs = env_cpu(env);
 
-    if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
+    if (!cpu_unwind_state_data(cs, cs->accel->mem_io_pc, data)) {
         return env->eip;
     }
 
-- 
2.41.0


