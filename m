Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F4C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY50O-0002zo-DJ; Wed, 15 Jan 2025 10:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1tY4VR-0001hP-C2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:36:29 -0500
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1tY4VO-0006f3-0J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:36:28 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
To: qemu-devel@nongnu.org
Cc: Arusekk <floss@arusekk.pl>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Add syscall dispatch support
Date: Wed, 15 Jan 2025 15:36:23 +0100
Message-ID: <20250115143623.8257-1-floss@arusekk.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.170; envelope-from=floss@arusekk.pl;
 helo=out-170.mta1.migadu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jan 2025 10:08:23 -0500
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
Reply-to:  Arusekk <floss@arusekk.pl>
From:  Arusekk via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds support for the `prctl(PR_SET_SYSCALL_DISPATCH)`
function in the Linux userspace emulator.

It is implemented as a fully host-independent function, by forcing a
SIGSYS early during syscall handling, if the PC is outside the allowed
range.

Tested on [uglendix][1], will probably also apply to recent versions of
Wine that use syscall dispatch.

[1]: https://sr.ht/~arusekk/uglendix

Signed-off-by: Arusekk <floss@arusekk.pl>
---
 linux-user/main.c         |  2 ++
 linux-user/qemu.h         |  5 +++
 linux-user/syscall.c      | 64 ++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  6 ++++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index b97634a32d..7e9567efc9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -230,6 +230,8 @@ void init_task_state(TaskState *ts)
         ts->start_boottime += bt.tv_nsec * (uint64_t) ticks_per_sec /
                               NANOSECONDS_PER_SECOND;
     }
+
+    ts->sys_dispatch_len = (abi_ulong)~0ULL;
 }
 
 CPUArchState *cpu_copy(CPUArchState *env)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f00750151..9b67e19542 100644
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78c7c0b34e..f65ef9b8fc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6317,6 +6317,10 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
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
@@ -6446,6 +6450,37 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
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
+                return -EINVAL;
+            }
+        }
+
     case PR_CAP_AMBIENT:
     case PR_CAPBSET_READ:
     case PR_CAPBSET_DROP:
@@ -6500,7 +6535,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_MM:
     case PR_GET_SECCOMP:
     case PR_SET_SECCOMP:
-    case PR_SET_SYSCALL_USER_DISPATCH:
     case PR_GET_THP_DISABLE:
     case PR_SET_THP_DISABLE:
     case PR_GET_TSC:
@@ -13852,12 +13886,34 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     return ret;
 }
 
+static bool sys_dispatch(abi_ulong pc, TaskState *ts)
+{
+    if (likely(ts->sys_dispatch_selector)) {
+        uint8_t sb;
+        if (get_user_u8(sb, ts->sys_dispatch_selector)) {
+            force_sig(SIGSEGV);
+            return true;
+        }
+        if (likely(sb == SYSCALL_DISPATCH_FILTER_ALLOW)) {
+            return false;
+        }
+        if (unlikely(sb != SYSCALL_DISPATCH_FILTER_BLOCK)) {
+            force_sig(SIGSYS);
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
@@ -13874,6 +13930,12 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
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
index faad9147c9..be6f6fa676 100644
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
2.47.1


