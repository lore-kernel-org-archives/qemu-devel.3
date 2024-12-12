Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99873E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoNH-0004of-2X; Thu, 12 Dec 2024 13:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoN6-0003T7-5W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:57:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoN4-0006wD-4H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:57:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a736518eso12507085e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029828; x=1734634628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoaiN8fGbAdoZl91RstCXbOrdj9RzBIlWptTLfxPGQw=;
 b=HNYLi/szYbPQjuuFSC0A3aRyKVOkuUFuThdF3h2fjqKXs3RzgcTTdq/LrZovOvr2IO
 ITPSF0Bu381MPFAgZY5R46l42w/E+VWeXVghtpLl3gtdH/TsAofFhAq3LPB2i17HvjuR
 lS+5atKhZJzfblqjrQ12N7Q1tc31UATJVXJ4sxFUrWORYOqWBlFTaqnPViHt767Gn2mf
 UwifhWwpF3hLVHybg/ShiaYEnvVLSr3cby/gs+6M3w5i+eaetky+y311lzLqgWAfXkDT
 sN/OZH4YUVMQn1RRK2JHptNa/HweTl9JLGA0C+m48F0JK4o8CBgR1KrsclG+yAH8ZnD1
 VuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029828; x=1734634628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoaiN8fGbAdoZl91RstCXbOrdj9RzBIlWptTLfxPGQw=;
 b=oF2jaPECk4zvov8styU2qK2v0peR7z7A8s4DL252jd3HwqRKNJVZshPhcKsk5zTUC9
 3S89PdF3xS1GxQ15QdrztAIKEOtmqmbRBfGuqB14TFwWs3MzrckE4ePz6pYHuQX5+7zp
 wH0IEUpeycha49JGJD0PmRRoHN5rOTS4nMOJxVrK4zHiu80kGIyYzhOwazE0n/rA8tBe
 Gw+uPjVVrnI55l25W2qknYxPM2lvDq7apEHvmNbyYEBSSAMnIUR0RrNKb7hAZ/gZDtK7
 Hff8GlL/WkBjQB7IYWmfY+etr7P1DilbFj8fXDQhIBF6iHez4Fnyu9WTG4HNJAXgqWga
 Ot5w==
X-Gm-Message-State: AOJu0YzIV6E/y7jFUz7fs+qFssHvsXLMZOivC30+vs7i6jY+m+ZSTOxI
 CxF0SrEFrZ976VvVPzvuGFmaWlwhzE7WCg/NA6BaI23jvcBz/8kBNgy0WpnhIDCTjUKI3dMPoNI
 0
X-Gm-Gg: ASbGncsA8LRM+AQ8z79i8LESYsUWU4MDkW7lQK3fnAV9b7RKw3tq+N1y1PhnJFEHE6m
 lST/3bXwShzzmpGEp4IKptu7cRxfNOkv63P0mbVk/JUbBuZ2EWkHHRNRKNjKghEMUn3af5XoO7y
 qbPdFdZRAc9b52RbeJ7ehktceMVFfkWyS0xG5LfgRcGFWo5TrIHPmjbuVHdatcLT/pdFGEbmWTW
 gicyG2anuU6BKz6J+k+/l5AOrQqp0nr0EkyMGPeJhq5I3ZcqRE1vN4Gk7AFIKTUyZFm3YkQlTdP
 tFPbxhUILC7bW4VvhfwDF+fBEEk8Hxo=
X-Google-Smtp-Source: AGHT+IFmtSaV5uAU6WSntpqzBJroIIONvvk3AgSYOZjG4xeSg/NFjpm1g5beMkkHrJjXYGtmleVkTg==
X-Received: by 2002:a05:600c:5122:b0:434:f586:7520 with SMTP id
 5b1f17b1804b1-4361c393894mr70283425e9.6.1734029827803; 
 Thu, 12 Dec 2024 10:57:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531dasm24469585e9.8.2024.12.12.10.57.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:57:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/18] user: Move various declarations out of 'exec/exec-all.h'
Date: Thu, 12 Dec 2024 19:53:41 +0100
Message-ID: <20241212185341.2857-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Move various declarations related to user emulation
from "exec/exec-all.h" to "user/cpu_loop.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h     | 55 +------------------------------------
 include/user/cpu_loop.h     | 54 ++++++++++++++++++++++++++++++++++++
 accel/tcg/user-exec.c       |  1 +
 bsd-user/signal.c           |  1 +
 linux-user/signal.c         |  1 +
 target/arm/tcg/mte_helper.c |  1 +
 6 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b5ea607cf45..c4a6ad3af2d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,7 +22,6 @@
 
 #include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
-#include "exec/abi_ptr.h"
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/mmu-access-type.h"
@@ -518,60 +517,8 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
     return get_page_addr_code_hostp(env, addr, NULL);
 }
 
-#if defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY)
 
-/**
- * adjust_signal_pc:
- * @pc: raw pc from the host signal ucontext_t.
- * @is_write: host memory operation was write, or read-modify-write.
- *
- * Alter @pc as required for unwinding.  Return the type of the
- * guest memory access -- host reads may be for guest execution.
- */
-MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write);
-
-/**
- * handle_sigsegv_accerr_write:
- * @cpu: the cpu context
- * @old_set: the sigset_t from the signal ucontext_t
- * @host_pc: the host pc, adjusted for the signal
- * @host_addr: the host address of the fault
- *
- * Return true if the write fault has been handled, and should be re-tried.
- */
-bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr);
-
-/**
- * cpu_loop_exit_sigsegv:
- * @cpu: the cpu context
- * @addr: the guest address of the fault
- * @access_type: access was read/write/execute
- * @maperr: true for invalid page, false for permission fault
- * @ra: host pc for unwinding
- *
- * Use the TCGCPUOps hook to record cpu state, do guest operating system
- * specific things to raise SIGSEGV, and jump to the main cpu loop.
- */
-G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
-                                      MMUAccessType access_type,
-                                      bool maperr, uintptr_t ra);
-
-/**
- * cpu_loop_exit_sigbus:
- * @cpu: the cpu context
- * @addr: the guest address of the alignment fault
- * @access_type: access was read/write/execute
- * @ra: host pc for unwinding
- *
- * Use the TCGCPUOps hook to record cpu state, do guest operating system
- * specific things to raise SIGBUS, and jump to the main cpu loop.
- */
-G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
-                                     MMUAccessType access_type,
-                                     uintptr_t ra);
-
-#else
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index b0d4704018d..2f93575e2f4 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -20,7 +20,10 @@
 #ifndef USER_CPU_LOOP_H
 #define USER_CPU_LOOP_H
 
+#include "exec/abi_ptr.h"
+#include "exec/mmu-access-type.h"
 #include "exec/log.h"
+#include "exec/target_long.h"
 #include "special-errno.h"
 
 G_NORETURN void cpu_loop(CPUArchState *env);
@@ -33,4 +36,55 @@ typedef struct target_pt_regs target_pt_regs;
 
 void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
 
+/**
+ * adjust_signal_pc:
+ * @pc: raw pc from the host signal ucontext_t.
+ * @is_write: host memory operation was write, or read-modify-write.
+ *
+ * Alter @pc as required for unwinding.  Return the type of the
+ * guest memory access -- host reads may be for guest execution.
+ */
+MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write);
+
+/**
+ * handle_sigsegv_accerr_write:
+ * @cpu: the cpu context
+ * @old_set: the sigset_t from the signal ucontext_t
+ * @host_pc: the host pc, adjusted for the signal
+ * @host_addr: the host address of the fault
+ *
+ * Return true if the write fault has been handled, and should be re-tried.
+ */
+bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
+                                 uintptr_t host_pc, abi_ptr guest_addr);
+
+/**
+ * cpu_loop_exit_sigsegv:
+ * @cpu: the cpu context
+ * @addr: the guest address of the fault
+ * @access_type: access was read/write/execute
+ * @maperr: true for invalid page, false for permission fault
+ * @ra: host pc for unwinding
+ *
+ * Use the TCGCPUOps hook to record cpu state, do guest operating system
+ * specific things to raise SIGSEGV, and jump to the main cpu loop.
+ */
+G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+                                      MMUAccessType access_type,
+                                      bool maperr, uintptr_t ra);
+
+/**
+ * cpu_loop_exit_sigbus:
+ * @cpu: the cpu context
+ * @addr: the guest address of the alignment fault
+ * @access_type: access was read/write/execute
+ * @ra: host pc for unwinding
+ *
+ * Use the TCGCPUOps hook to record cpu state, do guest operating system
+ * specific things to raise SIGBUS, and jump to the main cpu loop.
+ */
+G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+                                     MMUAccessType access_type,
+                                     uintptr_t ra);
+
 #endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 815a39503f3..0561c4f6dc7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -24,6 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "exec/cpu_ldst.h"
+#include "user/cpu_loop.h"
 #include "qemu/main-loop.h"
 #include "user/page-protection.h"
 #include "exec/page-protection.h"
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index edbcd461bfa..b4e1458237a 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu.h"
+#include "user/cpu_loop.h"
 #include "exec/page-protection.h"
 #include "user/page-protection.h"
 #include "user/tswap-target.h"
diff --git a/linux-user/signal.c b/linux-user/signal.c
index a191e9b26f2..087c4d270e4 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "signal-common.h"
 #include "host-signal.h"
+#include "user/cpu_loop.h"
 #include "user/page-protection.h"
 #include "user/safe-syscall.h"
 #include "tcg/tcg.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index ae037dc9143..846d659ff77 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -25,6 +25,7 @@
 #include "exec/page-protection.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
+#include "user/cpu_loop.h"
 #endif
 #include "exec/ram_addr.h"
 #include "exec/cpu_ldst.h"
-- 
2.45.2


