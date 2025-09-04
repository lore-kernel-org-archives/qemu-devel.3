Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B64CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu77s-000067-83; Thu, 04 Sep 2025 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77o-00005K-Oi
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77g-0005Q2-HO
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so6188975e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756981398; x=1757586198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uv1VGaAfeJc2rHFeH1ycLENFjj6GVkfaFa1r+x3eGjA=;
 b=xe90Rp06T1I9kDP+nNpnYtMTqLeZfngAZiWMXe7bBDabqVGpiA4XWe7KZ6aDm0Il/L
 bWoYcwpYc22Cz7YYQp8b0NQmnjaKJml9RgYz8lGiY4BG9wO/CYqvvO92mG5cTD/l/Trs
 jl7hMAqkXMKkWbHXzsX9K4tTA1H3YNvbHiv1dp99Wt8cUhjCD6wumbimZkjP0hS+qNFl
 a+14PFUHgcJN2uAjDkl4ONyz9hFvlJFcqDA+9KcZqkqwR1o0LjxjIPgbXNHdR2xEO1hf
 2PHPCx+H0HfNL85ZVUrOZ1sEId0155ASn29TuM5TS5ymBtkDJcdgWWEYE2Z9tWiuXUv9
 FGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756981398; x=1757586198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uv1VGaAfeJc2rHFeH1ycLENFjj6GVkfaFa1r+x3eGjA=;
 b=OU7ru57Y+DLN/Yq8LX9Omg1F+H2LvBkdFYySDAmutYPrBByiMQQ1yEaQQumHkyZrL0
 5e2qDDPZ09r9UX6pOvs/CNqmrn6PF/nJvLm6mSTRV0zaxUYKiQBL4di9uK7Nkw2d1jTo
 HcP/rJmqXxXj8z/VWbEfIlvOFICzpEMvpi4MikIQYU6R8ffi+qs+e66pwOMs81JY402I
 JUZ1hM81/7vX7+mcermRUcf4dcdUfmD7Ekmh6jy/q9rbSlh+MOmHUO1lUeM8/KbjpaBY
 x1AyFYgvgiGCeBgcZCCKaOCBIk54tDx8Rwnu9FG4svJRkYWYa7aYE5SF+Q3kVBvfK2k4
 dptw==
X-Gm-Message-State: AOJu0YzPrm71m9EGqkR+b8BsxefJc0/61egGchNUEm6jpvUi4K0EfEmF
 bWzM0Lo0QSoHSiVmtCJeaoDCCcVujNVGYQGYyzd3glekFaGm4F9bqEPPljgNlrmIGRhm2sGYcg+
 ENGpqJ4c=
X-Gm-Gg: ASbGnctQoeolJqn7oASnVRtAlP+n10wDag1QTON0Mz5KLc8muTlZSXIDYVvLFztTsGY
 Sq8bDqWow+bwFIg06jVR58tnsy+0LtUNmAp0eu0oisv01rmPIAFUZIFa/rKWrXkqaYB0TU7ma2F
 g9i6NEZFUVV70GtWKyXFYiZD9qCloCkBhiL58Sj9XQPxP5ZiXTWfn20tNXAAjKoTQxdJZdfqIxx
 rKk7s0rmfqVYeRawH3sKuyOUxCJcjTeEb1wKhXMUG/cIjXPIrju97S8bCYpADu9VGdCleip/EdY
 PK9ZG2qhDzS3dM6uC/b312fsTzfZsYzPhYwhkrF80i4bK01uCgCM9/kMTspJs9+okkEQQ8v0ZS2
 LPGRR0HWOsC8FjJHlN3URK+E1ZAGsHpvsqbYpC6drOUdJUkllJVlEfiUE
X-Google-Smtp-Source: AGHT+IGxdLSzwvA8mupWv5/wrCv1s1ayhtSbIZCuRVHl2erqeoAsQ6Sg1Q/PcKdejAT6e+hOznxP5A==
X-Received: by 2002:a05:600c:3589:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-45dd353a5b5mr5950925e9.1.1756981398200; 
 Thu, 04 Sep 2025 03:23:18 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm147699195e9.19.2025.09.04.03.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 03:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: floss@arusekk.pl
Subject: [PATCH v4 4/4] linux-user: Add syscall dispatch support
Date: Thu,  4 Sep 2025 12:23:10 +0200
Message-ID: <20250904102311.57383-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904102311.57383-1-richard.henderson@linaro.org>
References: <20250904102311.57383-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
index 7b0ccb6fd6..d8b7df4a79 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -233,6 +233,8 @@ void init_task_state(TaskState *ts)
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


