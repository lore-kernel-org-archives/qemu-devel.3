Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE82C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyy-0006X0-SU; Tue, 19 Mar 2024 02:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyw-0006Mp-TT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyh-0005gL-Ib
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41461c256c4so5250535e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829777; x=1711434577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcBm1WCPymqKaSwa7fzwzI3+ewkz+Zw4jwIqPMQqMRg=;
 b=W7OcNObLAT1qv5oSj4Lvp4rPID97WylZ1KXmKJOGcK21H13v9FkkMLH4gllWemOenr
 U1f9BKLEIAf7bO0gynpf/CsJH/tk7nf0CuNmSSi/3XLm1VZyGwmA+lrFQ4VkJpAK4IhG
 dJTkVKqNFE0O6lyXM1XJHCtSuBgtj1Sz30fTdxUQJU224hIGck4rHGFaIOpQHqKMJRmC
 98MKHE4b3YF6EXi6ArKBv8wKsiD2ixOmNT/VZiGqDmgg43rPvnE/kdEZhmu81dXVjqFB
 20DuOE5DshAsAJVBaEWeiQSbp9ksmK5341O9bqBfFIEkahJnoYGy5Bb/XWiCUXHlwX4z
 Gb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829777; x=1711434577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcBm1WCPymqKaSwa7fzwzI3+ewkz+Zw4jwIqPMQqMRg=;
 b=W6Ih8otiw/ZUHW97AD8iH75W/Zt4RFtbBue+aCaeJtYEaq0sekRZJLHnD72Ci4S/VG
 4wO6f21Gi1xUBmD+xysXIIP55H8yJCf4VSBW/52CFYqEjpqQ6ruPvoqJFDB+Ant68Xz0
 TYMcGRiMM/AO0iSQn4ambWC9HXM6UXojWukB7oB3BPfqetcD8XyQ57mIU/C++ga47cMm
 Enq0GzQNQjV7FeDeHntOcHFyjsCxiHB3V98izQ5O5AXWAUeIvGJuJTCQwPs29igPiL2w
 swd8If0VmXyanPewolZwKYaYohXdvW4nNRNZiUGIYG9N9EUmnRVEitU7dKqD/XMtHTJZ
 iI4w==
X-Gm-Message-State: AOJu0Yy4gxZF7VCTePEUFHBuTPyru/337ubFk7YmT8I7lg6r95I1Q7ig
 ur5Dehqbrzkw3FHav9gr1mcn5zJT7X+vhuSyXDPcAtKUdnKYs8AW3TflCcPbtZa1XjWSngWGKFF
 w
X-Google-Smtp-Source: AGHT+IFA9Pc4RYrnUJoxJSw4zZvp9hFZUiqVU/oZX3Uj7ejQzCg1KvulmHGK9Q04q0jvZnFtdSmFXg==
X-Received: by 2002:a5d:4112:0:b0:33e:48f9:169d with SMTP id
 l18-20020a5d4112000000b0033e48f9169dmr944178wrp.31.1710829777460; 
 Mon, 18 Mar 2024 23:29:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a5d4704000000b0033e7603987dsm11513647wrq.12.2024.03.18.23.29.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 7/8] target/microblaze: Move MMU helpers to
 sys_helper.c
Date: Tue, 19 Mar 2024 07:28:54 +0100
Message-ID: <20240319062855.8025-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MMU helpers are only used during system emulation,
move them to sys_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/op_helper.c  | 48 ----------------------------------
 target/microblaze/sys_helper.c | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f6378030b7..45dbed4aaa 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -381,51 +381,3 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
         cpu_loop_exit_restore(cs, GETPC());
     }
 }
-
-#if !defined(CONFIG_USER_ONLY)
-/* Writes/reads to the MMU's special regs end up here.  */
-uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
-{
-    return mmu_read(env, ext, rn);
-}
-
-void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
-{
-    mmu_write(env, ext, rn, v);
-}
-
-void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
-                               unsigned size, MMUAccessType access_type,
-                               int mmu_idx, MemTxAttrs attrs,
-                               MemTxResult response, uintptr_t retaddr)
-{
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
-
-    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
-                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
-                  addr, physaddr, size,
-                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
-                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
-
-    if (!(env->msr & MSR_EE)) {
-        return;
-    }
-
-    if (access_type == MMU_INST_FETCH) {
-        if (!cpu->cfg.iopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_INSN_BUS;
-    } else {
-        if (!cpu->cfg.dopb_bus_exception) {
-            return;
-        }
-        env->esr = ESR_EC_DATA_BUS;
-    }
-
-    env->ear = addr;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-#endif
diff --git a/target/microblaze/sys_helper.c b/target/microblaze/sys_helper.c
index 5180500354..7531f95ca7 100644
--- a/target/microblaze/sys_helper.c
+++ b/target/microblaze/sys_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
@@ -292,3 +293,49 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cs->exception_index = EXCP_HW_EXCP;
     cpu_loop_exit(cs);
 }
+
+/* Writes/reads to the MMU's special regs end up here.  */
+uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
+{
+    return mmu_read(env, ext, rn);
+}
+
+void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
+{
+    mmu_write(env, ext, rn, v);
+}
+
+void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                               unsigned size, MMUAccessType access_type,
+                               int mmu_idx, MemTxAttrs attrs,
+                               MemTxResult response, uintptr_t retaddr)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUMBState *env = &cpu->env;
+
+    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
+                  " physaddr 0x" HWADDR_FMT_plx " size %d access type %s\n",
+                  addr, physaddr, size,
+                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
+                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
+
+    if (!(env->msr & MSR_EE)) {
+        return;
+    }
+
+    if (access_type == MMU_INST_FETCH) {
+        if (!cpu->cfg.iopb_bus_exception) {
+            return;
+        }
+        env->esr = ESR_EC_INSN_BUS;
+    } else {
+        if (!cpu->cfg.dopb_bus_exception) {
+            return;
+        }
+        env->esr = ESR_EC_DATA_BUS;
+    }
+
+    env->ear = addr;
+    cs->exception_index = EXCP_HW_EXCP;
+    cpu_loop_exit_restore(cs, retaddr);
+}
-- 
2.41.0


