Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A637DE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfip-0004E5-SP; Fri, 20 Dec 2024 11:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiO-0001fT-LA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiL-0008DG-SQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso15465945e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711536; x=1735316336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSg6nJkqBZOFefSO7//FjeQFGjAGcvh8KtA7IGaHfG0=;
 b=bNU3BjPinX6AxBSNTJAknNlfn8PmjvV0zmibo8W8ZtcmB7WKLx252PQUnlUVt1WHPZ
 e1UQFk+MVJrXCcHgRky/5Ub9PYS5ppzZNAZUBgD0HX/OErzSHYrNTYLC1+7Y9ck22Yhz
 NaRjyHhqKg6msA0O/BlcFqFlgLnqewoc8ATvQcn+9pO/Uuoy+1Cqf0I1aXLsHYUNZHW1
 uGom+DSG86/gU8nFd28rVgabSXuzPAezlROfl4HKMszhl2V56us7OLLCMVqDw+W/AQ59
 hTf9j7I3VkUBCSrnKGsV9Oxd0HYTgIHUTT4gpv4N50SI1MOgcfqfM2tdoAWlfbYQww8y
 DO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711536; x=1735316336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSg6nJkqBZOFefSO7//FjeQFGjAGcvh8KtA7IGaHfG0=;
 b=rOycnoC+VsRcj4bD5Fneiub37E+YyVTsQ25lo1jop8V0C8P387lydSOBujk2nVE9jk
 HxNf8sPcfZFGT5cgiTl/zUtwh+bnB+h/JZgEL5nu102NwxyJ3xLxQtzclxxx5iGs1zA9
 ElLAMuWON8gF2WNpfzEPmO+xmlNsQq1tZFsqyYCrutuUiYMCx7HRAio3o0lSgPT7olRt
 wBWp7Y00AdJYqwXfEdr23HcDtqDKZi6w46PDv8Aut929dNZ1gRyxDJQO5/ajR2peXNNj
 FdV70g00ZKWN2+SNZ/emZqdvQiZZYlgUFEaZGOelSTR0esu9T44VoNs/JCHqXrFhL7iP
 nusg==
X-Gm-Message-State: AOJu0YwOkgDgr9n0ZMjCdVB6fIVZEyocmzghguizgh/VAKpoDuHTgFye
 hItkiFzZ/HJl8j354GmsJ5ytR8QmkHZVJZR1xMOQjXIXguEIFhy9xG2xkVNPOTk9DdwVv8Y76Fm
 S
X-Gm-Gg: ASbGncsTVw58vlNHsiu3zbNXO3SSZA02bxs5pHiHk3Q4/9fwHQruIKLbbOHtPZqQhgA
 q96Iua0Xm9WBpfWvUQOO/xHnbcXfErOeMN5YY/fenmwnkcUHiRS1Vyg+CVyKegXojuJcFH5j8DC
 HUvwcQyfZOAsPa2Kc344XwKd+ymZMmJgrDatm2gNATzYD05iVD8A+t11EP6LW5mUENLF4R5zAGn
 QWl2VU+zCDj+8c9DsVdQLJp7RDUDS65LYDwsZPt6p3RcMuRe0/jfZfVJJVIjExbSEXizYYzyzQ=
X-Google-Smtp-Source: AGHT+IEIqfiMdUQOCfXwmuOVJaohcJJO8jOufyX5KNuTqO/PkffGYBy2wiF5LvhBiyFwtN+3Y164ew==
X-Received: by 2002:a05:600c:1994:b0:435:306:e5dd with SMTP id
 5b1f17b1804b1-43668b5dfaamr28292085e9.22.1734711536005; 
 Fri, 20 Dec 2024 08:18:56 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm85137395e9.28.2024.12.20.08.18.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 40/59] user: Move various declarations out of 'exec/exec-all.h'
Date: Fri, 20 Dec 2024 17:15:31 +0100
Message-ID: <20241220161551.89317-41-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-19-philmd@linaro.org>
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
index b0d4704018d..589c66543fc 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -20,9 +20,63 @@
 #ifndef USER_CPU_LOOP_H
 #define USER_CPU_LOOP_H
 
+#include "exec/abi_ptr.h"
+#include "exec/mmu-access-type.h"
 #include "exec/log.h"
+#include "exec/target_long.h"
 #include "special-errno.h"
 
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
 G_NORETURN void cpu_loop(CPUArchState *env);
 
 void target_exception_dump(CPUArchState *env, const char *fmt, int code);
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
index 7943ae2d608..f72ce2ae0d4 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_USER_ONLY
+#include "user/cpu_loop.h"
 #include "user/page-protection.h"
 #else
 #include "exec/ram_addr.h"
-- 
2.47.1


