Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11ADC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnOa-00019v-0e; Wed, 04 Jun 2025 08:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1uMnOX-00019B-G7
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:39:02 -0400
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1uMnOR-0006Yd-J8
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:39:01 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arusekk.pl; s=key1;
 t=1749040722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l5jsADXAOJj+hrMKuX8k7ZfQBToHXSxweK9QDsTLCNY=;
 b=fZHowNdcxpZYLswseg18z/mqxMlR01/xP8hkwd6SE5X2JrahKl/9rC33mRjyuyrJU7TcUO
 aLYEd63iEHz2SipsTJieEmqWMfbTpbj6C+3b1j4XLsEwjv/i8siVweyEN0XiupmMh/EjMI
 i+fSIIupMoM1xKGLPBLkauSj0ab0nvdP32M7hIVTamSndV0RmEX4JMSM50T/h1U0iH3Os+
 EllmFInRpYXRvH7mG2dqrZJo/60Kx+sk3pH/7r+N3eFH9Vd8Q+yB3gS8OjvWHVnkVQ5EyM
 XPWnAOldcL4miqGCREZQTg0Ra5iDsSWc4u7wVHjSxE1xJdmewiH96Ej9SRiyOQ==
From: Arusekk <floss@arusekk.pl>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Arusekk <floss@arusekk.pl>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2] linux-user: Add syscall dispatch support
Date: Wed,  4 Jun 2025 14:00:15 +0200
Message-ID: <20250604121437.28176-4-floss@arusekk.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b3;
 envelope-from=floss@arusekk.pl; helo=out-179.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This commit adds support for syscall user dispatch (SUD),
the `prctl(PR_SET_SYSCALL_USER_DISPATCH)` function,
in the Linux userspace emulator.

It is implemented as a fully host-independent function, by forcing
a SIGSYS early during syscall handling, if the PC is outside the
allowed range and is not invoked by a vdso sigreturn trampoline.

Actual kernel only does the vdso sigreturn bypass for x86 ia32 ABI.
Other architectures just follow the normal pc range for vdso.
The kernel support is also limited to architectures with
CONFIG_GENERIC_ENTRY (currently x86, s390, riscv and loongarch).
For simplicity and consistency, all architectures are made to behave
the same way, in case the kernel implements SUD for some other
architectures one day.

Tested on [uglendix][1], will probably also apply to software like
tiny-wine, rpcsx, limbo, lazypoline, vicar, sysfail and endokernel,
to name a few.

[1]: https://sr.ht/~arusekk/uglendix

Signed-off-by: Arusekk <floss@arusekk.pl>
---
Changes from v1: rebase, reword, use TARGET_* consts,
add vdso sigreturn bypass.

Not sure, is it better to have wider support, or to precisely follow
kernel logic?
I did the most laborous version, in case wider support is desired.
And I think it is.
In the other case, all the added functions can just return false,
and the prctl needs to return EINVAL on unsupported architectures.

The files are not in the alphabetic order, architecture-specific
changes are moved to top for easier review.

v1: https://lore.kernel.org/qemu-devel/20250115143623.8257-1-floss@arusekk.pl/

 linux-user/aarch64/signal.c     |  5 +++
 linux-user/alpha/signal.c       |  6 +++
 linux-user/arm/signal.c         |  5 +++
 linux-user/hexagon/signal.c     |  5 +++
 linux-user/hppa/signal.c        |  5 +++
 linux-user/i386/signal.c        |  9 +++++
 linux-user/loongarch64/signal.c |  5 +++
 linux-user/m68k/signal.c        |  5 +++
 linux-user/microblaze/signal.c  |  5 +++
 linux-user/mips/signal.c        |  9 +++++
 linux-user/openrisc/signal.c    |  5 +++
 linux-user/ppc/signal.c         |  9 +++++
 linux-user/riscv/signal.c       |  5 +++
 linux-user/s390x/signal.c       |  5 +++
 linux-user/sh4/signal.c         |  5 +++
 linux-user/sparc/signal.c       |  9 +++++
 linux-user/xtensa/signal.c      |  5 +++
 linux-user/main.c               |  2 +
 linux-user/qemu.h               |  5 +++
 linux-user/signal-common.h      |  1 +
 linux-user/syscall.c            | 67 ++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h       |  6 +++
 22 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index bc7a13800d..f15548b0d7 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -746,3 +746,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     default_rt_sigreturn = sigtramp_page;
     unlock_user(tramp, sigtramp_page, 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/alpha/signal.c b/linux-user/alpha/signal.c
index 896c2c148a..48d6e4f790 100644
--- a/linux-user/alpha/signal.c
+++ b/linux-user/alpha/signal.c
@@ -275,3 +275,9 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 6 * 4);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_sigreturn + 3 * 4
+        || pc == default_rt_sigreturn + 3 * 4;
+}
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 8db1c4b233..53430908cd 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -644,3 +644,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, total_size);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return (abi_ulong)(pc - default_sigreturn) <= 8 * RETCODE_BYTES;
+}
diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
index 492b51f155..751155006e 100644
--- a/linux-user/hexagon/signal.c
+++ b/linux-user/hexagon/signal.c
@@ -291,3 +291,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 4 * 2);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 4 * 2;
+}
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index f6f094c960..e17e3527b4 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -216,3 +216,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     default_rt_sigreturn = (sigtramp_page + 8) | 3;
     unlock_user(tramp, sigtramp_page, 6*4);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == (default_rt_sigreturn & ~3) + 4*4;
+}
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 0f11dba831..63f0d2562d 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -865,3 +865,12 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     unlock_user(tramp, sigtramp_page, 2 * 8);
 }
 #endif
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+#ifndef TARGET_X86_64
+    if (pc == default_sigreturn + 8 || pc == default_rt_sigreturn + 7)
+        return true;
+#endif
+    return false;
+}
diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 1a322f9697..fedf297ca8 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -452,3 +452,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     default_rt_sigreturn = sigtramp_page;
     unlock_user(tramp, sigtramp_page, 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
index 77555781aa..c6af2baee9 100644
--- a/linux-user/m68k/signal.c
+++ b/linux-user/m68k/signal.c
@@ -408,3 +408,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 4 + 6);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_sigreturn + 4 || pc == default_rt_sigreturn + 6;
+}
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index f6d47d76ff..2027858025 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -230,3 +230,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     default_rt_sigreturn = sigtramp_page;
     unlock_user(tramp, sigtramp_page, 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index d69a5d73dd..88cbb081bf 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -393,3 +393,12 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 2 * 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+#ifdef TARGET_ARCH_HAS_SETUP_FRAME
+    if (pc == default_sigreturn + 8)
+        return true;
+#endif
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index cb74a9fe5e..c368069980 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -175,3 +175,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     default_rt_sigreturn = sigtramp_page;
     unlock_user(tramp, sigtramp_page, 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 24e5a02a78..b116aac415 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -730,3 +730,12 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 2 * 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+#ifdef TARGET_ARCH_HAS_SETUP_FRAME
+    if (pc == default_sigreturn + 8)
+        return true;
+#endif
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 358fa1d82d..5ae889e8b9 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -213,3 +213,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     default_rt_sigreturn = sigtramp_page;
     unlock_user(tramp, sigtramp_page, 8);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 8;
+}
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index df49c24708..17a194104f 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -419,3 +419,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 2 + 2);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_sigreturn + 2 || pc == default_rt_sigreturn + 2;
+}
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index 9ecc026fae..1c34dd27c1 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -346,3 +346,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
 
     unlock_user(tramp, sigtramp_page, 2 * 6);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_sigreturn + 6 || pc == default_rt_sigreturn + 6;
+}
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 8181b8b92c..e06b5ad2a2 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -789,3 +789,12 @@ do_sigsegv:
     force_sig(TARGET_SIGSEGV);
 }
 #endif /* TARGET_SPARC64 */
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+#ifdef TARGET_ABI32
+    if (pc == default_sigreturn + 8 || pc == default_rt_sigreturn + 8)
+        return true;
+#endif
+    return false;
+}
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index ef8b0c3a27..0ce3d826d7 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -303,3 +303,8 @@ void setup_sigtramp(abi_ulong sigtramp_page)
     install_sigtramp(tramp);
     unlock_user(tramp, sigtramp_page, 6);
 }
+
+bool is_vdso_sigreturn(abi_ulong pc)
+{
+    return pc == default_rt_sigreturn + 6;
+}
diff --git a/linux-user/main.c b/linux-user/main.c
index 5ac5b55dc6..4f40ec5a94 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -231,6 +231,8 @@ void init_task_state(TaskState *ts)
         ts->start_boottime += bt.tv_nsec * (uint64_t) ticks_per_sec /
                               NANOSECONDS_PER_SECOND;
     }
+
+    ts->sys_dispatch_len = (abi_ulong)~0ULL;
 }
 
 CPUArchState *cpu_copy(CPUArchState *env)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 0b19fa43e6..52cf9d67bd 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -161,6 +161,11 @@ struct TaskState {
     /* This thread's sigaltstack, if it has one */
     struct target_sigaltstack sigaltstack_used;
 
+    /* This thread's SYSCALL_USER_DISPATCH state, len=~0 means disabled */
+    abi_ulong sys_dispatch;
+    abi_ulong sys_dispatch_len;
+    abi_ulong sys_dispatch_selector;
+
     /* Start time of task after system boot in clock ticks */
     uint64_t start_boottime;
 };
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 196d2406f8..7b17ac3221 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -27,6 +27,7 @@ extern abi_ulong default_sigreturn;
 extern abi_ulong default_rt_sigreturn;
 
 void setup_sigtramp(abi_ulong tramp_page);
+bool is_vdso_sigreturn(abi_ulong pc);
 
 int on_sig_stack(unsigned long sp);
 int sas_ss_flags(unsigned long sp);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597..027e4237b9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6340,6 +6340,10 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
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
@@ -6469,6 +6473,37 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_UNALIGN:
         return do_prctl_set_unalign(env, arg2);
 
+    case PR_SET_SYSCALL_USER_DISPATCH:
+        {
+            TaskState *ts = get_task_state(env_cpu(env));
+            switch (arg2) {
+            case PR_SYS_DISPATCH_OFF:
+                if (arg3 || arg4 || arg5) {
+                    return -TARGET_EINVAL;
+                }
+                ts->sys_dispatch_len = (abi_ulong)~0ULL;
+                return 0;
+            case PR_SYS_DISPATCH_ON:
+                {
+                    uint8_t sb;
+
+                    if (arg3 && arg3 + arg4 <= arg3) {
+                        return -TARGET_EINVAL;
+                    }
+                    if (arg5 && get_user_u8(sb, arg5)) {
+                        return -TARGET_EFAULT;
+                    }
+                    (void)sb;  /* used later, only checked for access */
+                    ts->sys_dispatch = arg3;
+                    ts->sys_dispatch_len = arg4;
+                    ts->sys_dispatch_selector = arg5;
+                    return 0;
+                }
+            default:
+                return -TARGET_EINVAL;
+            }
+        }
+
     case PR_CAP_AMBIENT:
     case PR_CAPBSET_READ:
     case PR_CAPBSET_DROP:
@@ -6523,7 +6558,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_MM:
     case PR_GET_SECCOMP:
     case PR_SET_SECCOMP:
-    case PR_SET_SYSCALL_USER_DISPATCH:
     case PR_GET_THP_DISABLE:
     case PR_SET_THP_DISABLE:
     case PR_GET_TSC:
@@ -13881,12 +13915,37 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     return ret;
 }
 
+static bool sys_dispatch(abi_ulong pc, TaskState *ts)
+{
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
+    vaddr pc = cpu->cc->get_pc(cpu);
     abi_long ret;
 
 #ifdef DEBUG_ERESTARTSYS
@@ -13903,6 +13962,12 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+    if (unlikely(pc - ts->sys_dispatch >= ts->sys_dispatch_len)) {
+        if (sys_dispatch(pc, ts)) {
+            return -QEMU_ESIGRETURN;
+        }
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5d22759992..7812253455 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -693,6 +693,12 @@ typedef struct target_siginfo {
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
-- 
2.49.0


