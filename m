Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC1FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnW-0007yA-15; Wed, 24 Sep 2025 15:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ult-0006uw-TK
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujq-0007nQ-R4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:15 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f2e621ef8so243136b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740470; x=1759345270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlkqS35JxZy3ncaxHOMPx7RygOfL9wEkWQNVBqkOmNg=;
 b=S2S87yJLAJWUI4jrX96gA3E3275YPGhpX6Jd8RxabnhQSrwk0hw0mJOrIYKUcYQh7F
 B6ZYyzwNXh2k6PYPj274YbAP+rgxtMDkrZVx2epmgR3kB73SI3DMMyxW29yJ6Odp5+Eu
 kZPQvz3KXWq2KD0YGKVP4hdg5MQtHDHpR1qpePOcA00nCDvBlArnJdbGAY/JuQcA2TDM
 W/FJDxrk3Z8ilEpMzmTA8OOvQCLLVlB2Zs+G3woIL+Bh+Se2men6JyZfog8D6rKzNbys
 joM586j97NMBV9GGJpqH8C0JupLuxgRCJDw9xZ42DaHZKBbWaZuReT2rIxQqfPxCPFYE
 6ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740470; x=1759345270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlkqS35JxZy3ncaxHOMPx7RygOfL9wEkWQNVBqkOmNg=;
 b=vRf9eMQYVkziFXQ4tFtLDB5a8n6fJxGMktuKV6KhIFwzL/MntjpWJZwXshe9zknr2L
 gL2bADaFBjPxJ8PxC8q26RmBdIgCuEHCOKSrygtaWxb91CYPMeFdVLNRsOdz4reho73S
 UIFX5iDEc3M6nYlPITCxoTLxPI3AVBNzUXViru743uEvy9wlgCfyLgBwQYSylYEMZ+8e
 9MYskRVgFY+c9sKuw0UI18kAf/S7a7UD1VN8Wep5w0lSjEmATX8Hq1NBKCNYZV9JeJ/v
 1AeexTwG5/vp4MerW5mkxxc1bpjgrwMxG2G5h5RHvbIMpit5tAJRju0Rq9Rz7QVU+wXs
 g/PA==
X-Gm-Message-State: AOJu0YzjIo/sLt9suG1O9jhx7iVzXeafz4hIq0dR6HZK+ECyPsGZeMYQ
 MNNpkolAYKeVThrninxPCZ669ZUY+GsavfIaT7Ua58HGbd2hsgulkQmeUAKkOF5h36No5mVQr/3
 7/U6Q
X-Gm-Gg: ASbGncv3E8bwK2MDA/1fM2135q5wXM+owyu0E30nxVCw8FF9jXT8HLDq2/y0EO+d/CK
 D5XMtZBT0s4V/vIQemGsedaatAyNjUwTbV3ohmOW3VLybGmUbfV/vPbt9xhlx+E9/OsQg36T/4o
 M0GLWPa7pYeecmFSdoTfxQffzTvqEtrJj5z2bq7dAKyHSF91N5sSbjrawwgXiVDc4Ip0yAseZQe
 vytG4D8fkOT/su9WYGkTuQGk0leW8QNd79MFMpEQs5U8x6Hb2HYrgaceaJx1/xtbuUs62H1ufpX
 GAjz2zCb8cw4eKrzSzRjDyJEMsjsMwGoxkvucrfKxdyU6U7rUz0mPv1cvWh7VUwZx9j+dQOw7g2
 l0Pxjp8wjx6KzIPDqIurY6tpzDGEJ
X-Google-Smtp-Source: AGHT+IFDNmUegVgKnuoYzOCJEJEFrZUCkR4mmeLdNJMuYashXkYvOjQ0iAUVYlGpGa48duP2dRs8Yw==
X-Received: by 2002:a17:90b:3a91:b0:332:793e:c2d1 with SMTP id
 98e67ed59e1d1-3342a2e560cmr702895a91.36.1758740470090; 
 Wed, 24 Sep 2025 12:01:10 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Arusekk <floss@arusekk.pl>
Subject: [PULL 04/32] linux-user: Add syscall dispatch support
Date: Wed, 24 Sep 2025 12:00:37 -0700
Message-ID: <20250924190106.7089-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Arusekk <floss@arusekk.pl>

This commit adds support for the `prctl(PR_SET_SYSCALL_USER_DISPATCH)`
function in the Linux userspace emulator.

It is implemented as a fully host-independent function, by forcing
a SIGSYS early during syscall handling, if the PC is outside the
allowed range.

Since disabled SUD is indistinguishable from enabled SUD with
always-allowed region length == ~0, this encoding is used
instead of introducing a new flag.

Tested on [uglendix][1], will probably also apply to software like
tiny-wine, rpcsx, limbo, lazypoline, vicar, sysfail and endokernel,
to name a few.

[1]: https://sr.ht/~arusekk/uglendix

Signed-off-by: Arusekk <floss@arusekk.pl>
Message-ID: <20250711225226.14652-1-floss@arusekk.pl>
[rth: Split out is_vdso_sigreturn region matching and other minor tweaks.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h          |  5 +++
 linux-user/signal-common.h |  5 +++
 linux-user/syscall_defs.h  |  6 +++
 linux-user/main.c          |  2 +
 linux-user/syscall.c       | 76 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index e4dca0c20f..cabb7bd6a8 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -155,6 +155,11 @@ struct TaskState {
     /* This thread's sigaltstack, if it has one */
     struct target_sigaltstack sigaltstack_used;
 
+    /* This thread's SYSCALL_USER_DISPATCH state, len=~0 means disabled */
+    vaddr sys_dispatch;
+    vaddr sys_dispatch_selector;
+    abi_ulong sys_dispatch_len;
+
     /* Start time of task after system boot in clock ticks */
     uint64_t start_boottime;
 };
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 0b04868727..8a44714251 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -28,6 +28,11 @@ extern abi_ulong default_rt_sigreturn;
 extern abi_ulong vdso_sigreturn_region_start;
 extern abi_ulong vdso_sigreturn_region_end;
 
+static inline bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc >= vdso_sigreturn_region_start && pc < vdso_sigreturn_region_end;
+}
+
 void setup_sigtramp(abi_ulong tramp_page);
 
 int on_sig_stack(unsigned long sp);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index df26a2d28f..cd9ff709b8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -689,6 +689,12 @@ typedef struct target_siginfo {
 #define TARGET_TRAP_HWBKPT      (4)     /* hardware breakpoint/watchpoint */
 #define TARGET_TRAP_UNK         (5)     /* undiagnosed trap */
 
+/*
+ * SIGSYS si_codes
+ */
+#define TARGET_SYS_SECCOMP       (1)  /* seccomp triggered */
+#define TARGET_SYS_USER_DISPATCH (2)  /* syscall user dispatch triggered */
+
 /*
  * SIGEMT si_codes
  */
diff --git a/linux-user/main.c b/linux-user/main.c
index 4ddfc9a619..db751c0757 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -228,6 +228,8 @@ void init_task_state(TaskState *ts)
         ts->start_boottime += bt.tv_nsec * (uint64_t) ticks_per_sec /
                               NANOSECONDS_PER_SECOND;
     }
+
+    ts->sys_dispatch_len = -1;
 }
 
 CPUArchState *cpu_copy(CPUArchState *env)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..9098cdb9fa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6344,6 +6344,10 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 #endif
 #ifndef PR_SET_SYSCALL_USER_DISPATCH
 # define PR_SET_SYSCALL_USER_DISPATCH 59
+# define PR_SYS_DISPATCH_OFF 0
+# define PR_SYS_DISPATCH_ON 1
+# define SYSCALL_DISPATCH_FILTER_ALLOW 0
+# define SYSCALL_DISPATCH_FILTER_BLOCK 1
 #endif
 #ifndef PR_SME_SET_VL
 # define PR_SME_SET_VL  63
@@ -6398,6 +6402,36 @@ static abi_long do_prctl_inval1(CPUArchState *env, abi_long arg2)
 #define do_prctl_sme_set_vl do_prctl_inval1
 #endif
 
+static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
+                                               abi_ulong arg2, abi_ulong arg3,
+                                               abi_ulong arg4, abi_ulong arg5)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *ts = get_task_state(cpu);
+
+    switch (arg2) {
+    case PR_SYS_DISPATCH_OFF:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        ts->sys_dispatch_len = -1;
+        return 0;
+    case PR_SYS_DISPATCH_ON:
+        if (arg3 && arg3 + arg4 <= arg3) {
+            return -TARGET_EINVAL;
+        }
+        if (arg5 && !access_ok(cpu, VERIFY_READ, arg5, 1)) {
+            return -TARGET_EFAULT;
+        }
+        ts->sys_dispatch = arg3;
+        ts->sys_dispatch_len = arg4;
+        ts->sys_dispatch_selector = arg5;
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -6473,6 +6507,9 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_UNALIGN:
         return do_prctl_set_unalign(env, arg2);
 
+    case PR_SET_SYSCALL_USER_DISPATCH:
+        return do_prctl_syscall_user_dispatch(env, arg2, arg3, arg4, arg5);
+
     case PR_CAP_AMBIENT:
     case PR_CAPBSET_READ:
     case PR_CAPBSET_DROP:
@@ -6527,7 +6564,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_MM:
     case PR_GET_SECCOMP:
     case PR_SET_SECCOMP:
-    case PR_SET_SYSCALL_USER_DISPATCH:
     case PR_GET_THP_DISABLE:
     case PR_SET_THP_DISABLE:
     case PR_GET_TSC:
@@ -13897,12 +13933,46 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     return ret;
 }
 
+static bool sys_dispatch(CPUState *cpu, TaskState *ts)
+{
+    abi_ptr pc;
+
+    if (likely(ts->sys_dispatch_len == -1)) {
+        return false;
+    }
+
+    pc = cpu->cc->get_pc(cpu);
+    if (likely(pc - ts->sys_dispatch < ts->sys_dispatch_len)) {
+        return false;
+    }
+    if (unlikely(is_vdso_sigreturn(pc))) {
+        return false;
+    }
+    if (likely(ts->sys_dispatch_selector)) {
+        uint8_t sb;
+        if (get_user_u8(sb, ts->sys_dispatch_selector)) {
+            force_sig(TARGET_SIGSEGV);
+            return true;
+        }
+        if (likely(sb == SYSCALL_DISPATCH_FILTER_ALLOW)) {
+            return false;
+        }
+        if (unlikely(sb != SYSCALL_DISPATCH_FILTER_BLOCK)) {
+            force_sig(TARGET_SIGSYS);
+            return true;
+        }
+    }
+    force_sig_fault(TARGET_SIGSYS, TARGET_SYS_USER_DISPATCH, pc);
+    return true;
+}
+
 abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8)
 {
     CPUState *cpu = env_cpu(cpu_env);
+    TaskState *ts = get_task_state(cpu);
     abi_long ret;
 
 #ifdef DEBUG_ERESTARTSYS
@@ -13919,6 +13989,10 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+    if (sys_dispatch(cpu, ts)) {
+        return -QEMU_ESIGRETURN;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
-- 
2.43.0


