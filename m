Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18738CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpu-0007OY-F1; Mon, 23 Sep 2024 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpZ-0006XT-O1
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpT-0000bf-SH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBUNKT004290;
 Mon, 23 Sep 2024 16:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=ne7ty8+8by6hh
 4QQH+LzVTzQiJNeSI1v+LbvHsFyDGw=; b=bS7hUTlgdk39Zqw6XYRjrAA5/nz01
 AYa3A1G7s11MwXSUhTOcCAz97GTx1Q32QeTRzXKB0h8ah5A6hgaXOY86iF9n78kb
 s0MQRGGl9pNy1uX6zV5zWIc2gqQPXqgNlNeGTFB6VMRJk2zwuFHW50SPCdw4GvUt
 EODZ4FkZrwQ82su7Qe+HEQORc3KxaDMAiPBUFlDMTgM/vq7uei05inWYd680tXP8
 XDYJy6RGwGKqxYmz6XTfIaI3617M0Ws6mklq48R86hyee/frB5fFThZ+olxUqWBx
 2xSZw85fdFM7d9oRVN6vn06RRLfclb0z46HyoeHpqLZE46rs/pMG03yAg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrd0em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMN0M024482;
 Mon, 23 Sep 2024 16:22:23 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrd0ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFxshT020824;
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62y41j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMLK221496144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 131D020040;
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B02AF20043;
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 10/18] cpu: Use BQL in qemu-user
Date: Mon, 23 Sep 2024 18:13:05 +0200
Message-ID: <20240923162208.90745-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z4y0NKpUX9agzDfXjMm4q2HEVZLcz8TK
X-Proofpoint-ORIG-GUID: lkP0S_xSyUNRdZww_YsNBeJEOZO9QuBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=908 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently BQL is stubbed out in qemu-user. However, enabling the
ability to pause and resume CPUs requires BQL, so introduce it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c         |  2 ++
 bsd-user/freebsd/os-syscall.c |  6 ++++
 bsd-user/main.c               |  2 ++
 cpu-common.c                  | 45 ++++++++++++++++++++++++++++++
 gdbstub/user.c                |  5 ++++
 linux-user/main.c             |  3 ++
 linux-user/syscall.c          |  6 ++++
 system/cpus.c                 | 52 ++---------------------------------
 8 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ca3e8e988ee..d56882c87f3 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1293,9 +1293,11 @@ int cpu_exec_user(CPUState *cs)
 {
     int trapnr;
 
+    bql_unlock();
     cpu_exec_start(cs);
     trapnr = cpu_exec(cs);
     cpu_exec_end(cs);
+    bql_lock();
     process_queued_cpu_work(cs);
 
     return trapnr;
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ca2f6fdb66e..c2849d43223 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -32,6 +32,7 @@
 #include "qemu.h"
 #include "signal-common.h"
 #include "user/syscall-trace.h"
+#include "qemu/main-loop.h"
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
@@ -935,16 +936,21 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 {
     abi_long ret;
 
+    bql_unlock();
+
     if (do_strace) {
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
     ret = freebsd_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6,
                           arg7, arg8);
+
     if (do_strace) {
         print_freebsd_syscall_ret(num, ret);
     }
 
+    bql_lock();
+
     return ret;
 }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index cc980e6f401..ba5b54c228d 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -48,6 +48,7 @@
 #include "qemu/guest-random.h"
 #include "gdbstub/user.h"
 #include "exec/page-vary.h"
+#include "qemu/main-loop.h"
 
 #include "host-os.h"
 #include "target_arch_cpu.h"
@@ -616,6 +617,7 @@ int main(int argc, char **argv)
 
     target_cpu_init(env, regs);
 
+    bql_lock();
     if (gdbstub) {
         gdbserver_start(gdbstub);
         gdb_handlesig(cpu, 0, NULL, NULL, 0);
diff --git a/cpu-common.c b/cpu-common.c
index 6b262233a3b..cb7c10a3915 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -452,3 +452,48 @@ void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
         }
     }
 }
+
+/* The Big QEMU Lock (BQL) */
+static QemuMutex bql = QEMU_MUTEX_INITIALIZER;
+
+QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
+
+bool bql_locked(void)
+{
+    return get_bql_locked();
+}
+
+/*
+ * The BQL is taken from so many places that it is worth profiling the
+ * callers directly, instead of funneling them all through a single function.
+ */
+void bql_lock_impl(const char *file, int line)
+{
+    QemuMutexLockFunc bql_lock_fn = qatomic_read(&bql_mutex_lock_func);
+
+    g_assert(!bql_locked());
+    bql_lock_fn(&bql, file, line);
+    set_bql_locked(true);
+}
+
+void bql_unlock(void)
+{
+    g_assert(bql_locked());
+    set_bql_locked(false);
+    qemu_mutex_unlock(&bql);
+}
+
+void qemu_cond_wait_bql(QemuCond *cond)
+{
+    qemu_cond_wait(cond, &bql);
+}
+
+void qemu_cond_timedwait_bql(QemuCond *cond, int ms)
+{
+    qemu_cond_timedwait(cond, &bql, ms);
+}
+
+void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+{
+    do_run_on_cpu(cpu, func, data, &bql);
+}
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 77ba227fc3b..82007b09db6 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
@@ -169,6 +170,8 @@ void gdb_exit(int code)
 {
     char buf[4];
 
+    BQL_LOCK_GUARD();
+
     if (!gdbserver_state.init) {
         return;
     }
@@ -464,6 +467,8 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
     char b;
     int fd;
 
+    BQL_LOCK_GUARD();
+
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b02..016f60bf3dc 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -57,6 +57,7 @@
 #include "user-mmap.h"
 #include "tcg/perf.h"
 #include "exec/page-vary.h"
+#include "qemu/main-loop.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
@@ -1011,6 +1012,8 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
+    bql_lock();
+
     if (gdbstub) {
         if (gdbserver_start(gdbstub) < 0) {
             fprintf(stderr, "qemu: could not open gdbserver on %s\n",
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b693aeff5bb..ff34ae11340 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -144,6 +144,7 @@
 #include "qapi/error.h"
 #include "fd-trans.h"
 #include "cpu_loop-common.h"
+#include "qemu/main-loop.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -6529,6 +6530,7 @@ static void *clone_func(void *arg)
     /* Wait until the parent has finished initializing the tls state.  */
     pthread_mutex_lock(&clone_lock);
     pthread_mutex_unlock(&clone_lock);
+    bql_lock();
     cpu_loop(env);
     /* never exits */
     return NULL;
@@ -13772,6 +13774,8 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
+    bql_unlock();
+
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
@@ -13784,6 +13788,8 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
                           arg3, arg4, arg5, arg6);
     }
 
+    bql_lock();
+
     record_syscall_return(cpu, num, ret);
     return ret;
 }
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828..fe84b822798 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -65,9 +65,6 @@
 
 #endif /* CONFIG_LINUX */
 
-/* The Big QEMU Lock (BQL) */
-static QemuMutex bql;
-
 /*
  * The chosen accelerator is supposed to register this.
  */
@@ -420,16 +417,10 @@ void qemu_init_cpu_loop(void)
     qemu_init_sigbus();
     qemu_cond_init(&qemu_cpu_cond);
     qemu_cond_init(&qemu_pause_cond);
-    qemu_mutex_init(&bql);
 
     qemu_thread_get_self(&io_thread);
 }
 
-void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
-{
-    do_run_on_cpu(cpu, func, data, &bql);
-}
-
 static void qemu_cpu_stop(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
@@ -459,7 +450,7 @@ void qemu_wait_io_event(CPUState *cpu)
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &bql);
+        qemu_cond_wait_bql(cpu->halt_cond);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
@@ -512,48 +503,11 @@ bool qemu_in_vcpu_thread(void)
     return current_cpu && qemu_cpu_is_self(current_cpu);
 }
 
-QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
-
-bool bql_locked(void)
-{
-    return get_bql_locked();
-}
-
 bool qemu_in_main_thread(void)
 {
     return bql_locked();
 }
 
-/*
- * The BQL is taken from so many places that it is worth profiling the
- * callers directly, instead of funneling them all through a single function.
- */
-void bql_lock_impl(const char *file, int line)
-{
-    QemuMutexLockFunc bql_lock_fn = qatomic_read(&bql_mutex_lock_func);
-
-    g_assert(!bql_locked());
-    bql_lock_fn(&bql, file, line);
-    set_bql_locked(true);
-}
-
-void bql_unlock(void)
-{
-    g_assert(bql_locked());
-    set_bql_locked(false);
-    qemu_mutex_unlock(&bql);
-}
-
-void qemu_cond_wait_bql(QemuCond *cond)
-{
-    qemu_cond_wait(cond, &bql);
-}
-
-void qemu_cond_timedwait_bql(QemuCond *cond, int ms)
-{
-    qemu_cond_timedwait(cond, &bql, ms);
-}
-
 /* signal CPU creation */
 void cpu_thread_signal_created(CPUState *cpu)
 {
@@ -613,7 +567,7 @@ void pause_all_vcpus(void)
     replay_mutex_unlock();
 
     while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &bql);
+        qemu_cond_wait_bql(&qemu_pause_cond);
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
         }
@@ -684,7 +638,7 @@ void qemu_init_vcpu(CPUState *cpu)
     cpus_accel->create_vcpu_thread(cpu);
 
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &bql);
+        qemu_cond_wait_bql(&qemu_cpu_cond);
     }
 }
 
-- 
2.46.0


