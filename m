Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA543C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHXl-00049o-Tz; Wed, 31 Jan 2024 15:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHXj-00049S-IE
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHXg-0004OH-TJ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:50:47 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VJW6JS006967; Wed, 31 Jan 2024 20:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5zyehzTRf2Nijf5aJ3rDg4vBNHwI4XE6X9W1Hh0thkg=;
 b=b53mzJ3gKYytIKUQA4ZdvNwy9Fzq/a1zWv5GJjViCNpByYMfrFiJlAiM1ye8d+b6ofgp
 FStDbwerPFl7XiSFOQgqCZhsNiXXGW7OPawpCOOgVJ+O4RmTmrWQK5NXcTF1d1sPDCg3
 7HLLv7XpZj9LJnHhskcrFe14ffW01JIdYlpR+iWoWFqH8q7cNw4fBc9qJ5mHlzyvyYTV
 Cpk+FTYU9edjLTH0DfI7hi6r3K7UyLzJq2dpIgGHjRPsp9f9WgNWyE5KjLiscKR8kIb1
 DzzVvTWkmPQRc/GctVl0ELhaAOIvWORyXLr/GGvK9j1lzdtf96SkavJF3oyO3xY3iVuI Wg== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vytx8vqra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VJQRXi007189; Wed, 31 Jan 2024 20:50:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2fbhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VKoeVw17564348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 20:50:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A27220040;
 Wed, 31 Jan 2024 20:50:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E67E20043;
 Wed, 31 Jan 2024 20:50:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 20:50:39 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] gdbstub: Refactor fork() handling
Date: Wed, 31 Jan 2024 21:43:39 +0100
Message-ID: <20240131205031.144607-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131205031.144607-1-iii@linux.ibm.com>
References: <20240131205031.144607-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NObOGJR_BPq1rZkBNfede-mh6WYqOilt
X-Proofpoint-GUID: NObOGJR_BPq1rZkBNfede-mh6WYqOilt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=866 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prepare for implementing follow-fork-mode child:
* Introduce gdbserver_fork_start(), which for now is a no-op.
* Rename gdbserver_fork() to gdbserver_fork_end(), call it in both
  parent and child processes, and pass the fork()'s return value to it.
* Factor out disable_gdbstub().
* Update ts_tid in the forked child.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/freebsd/os-proc.h  |  6 +++---
 bsd-user/main.c             |  8 ++++++--
 bsd-user/qemu.h             |  2 +-
 gdbstub/user.c              | 25 +++++++++++++++++++------
 include/gdbstub/user.h      | 11 ++++++++---
 linux-user/main.c           |  8 ++++++--
 linux-user/syscall.c        |  4 ++--
 linux-user/user-internals.h |  2 +-
 8 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index d6418780344..3003c8cb637 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -208,7 +208,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
      */
     set_second_rval(cpu_env, child_flag);
 
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
@@ -252,7 +252,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 
@@ -285,7 +285,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
diff --git a/bsd-user/main.c b/bsd-user/main.c
index e5efb7b8458..8ecfa395cc5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -106,10 +106,13 @@ void fork_start(void)
     start_exclusive();
     cpu_list_lock();
     mmap_fork_start();
+    gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(abi_long pid)
 {
+    int child = pid == 0;
+
     if (child) {
         CPUState *cpu, *next_cpu;
         /*
@@ -127,10 +130,11 @@ void fork_end(int child)
          * state, so we don't need to end_exclusive() here.
          */
         qemu_init_cpu_list();
-        gdbserver_fork(thread_cpu);
+        gdbserver_fork_end(pid);
     } else {
         mmap_fork_end(child);
         cpu_list_unlock();
+        gdbserver_fork_end(pid);
         end_exclusive();
     }
 }
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index dc842fffa7d..2414a87559b 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -180,7 +180,7 @@ void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(abi_long pid);
 
 #include "qemu/log.h"
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 766f7c08848..120eb7fc117 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,16 +356,29 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+void gdbserver_fork_start(void)
+{
+}
+
+static void disable_gdbstub(void)
+{
+    CPUState *cpu;
+
+    close(gdbserver_user_state.fd);
+    gdbserver_user_state.fd = -1;
+    CPU_FOREACH(cpu) {
+        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        /* no cpu_watchpoint_remove_all for user-mode */
+    }
+}
+
 /* Disable gdb stub for child processes.  */
-void gdbserver_fork(CPUState *cpu)
+void gdbserver_fork_end(pid_t pid)
 {
-    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
-    close(gdbserver_user_state.fd);
-    gdbserver_user_state.fd = -1;
-    cpu_breakpoint_remove_all(cpu, BP_GDB);
-    /* no cpu_watchpoint_remove_all for user-mode */
+    disable_gdbstub();
 }
 
 /*
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 68b6534130c..1694d4fd330 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -46,10 +46,15 @@ static inline int gdb_handlesig(CPUState *cpu, int sig)
 void gdb_signalled(CPUArchState *as, int sig);
 
 /**
- * gdbserver_fork() - disable gdb stub for child processes.
- * @cs: CPU
+ * gdbserver_fork_start() - inform gdb of the upcoming fork()
+ */
+void gdbserver_fork_start(void);
+
+/**
+ * gdbserver_fork_end() - disable gdb stub for child processes.
+ * @pid: 0 if in child process, -1 if fork failed, child process pid otherwise
  */
-void gdbserver_fork(CPUState *cs);
+void gdbserver_fork_end(pid_t pid);
 
 /**
  * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
diff --git a/linux-user/main.c b/linux-user/main.c
index c9470eeccfc..b42c8f36a1d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -144,10 +144,13 @@ void fork_start(void)
     mmap_fork_start();
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
+    gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(abi_long pid)
 {
+    int child = pid == 0;
+
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
@@ -160,10 +163,11 @@ void fork_end(int child)
             }
         }
         qemu_init_cpu_list();
-        gdbserver_fork(thread_cpu);
+        ((TaskState *)thread_cpu->opaque)->ts_tid = (pid_t)syscall(SYS_gettid);
     } else {
         cpu_list_unlock();
     }
+    gdbserver_fork_end(pid);
     /*
      * qemu_init_cpu_list() reinitialized the child exclusive state, but we
      * also need to keep current_cpu consistent, so call end_exclusive() for
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e142489..8be0bb57778 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6669,7 +6669,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         if (ret == 0) {
             /* Child Process.  */
             cpu_clone_regs_child(env, newsp, flags);
-            fork_end(1);
+            fork_end(ret);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
                tid is set.  This would require using either ptrace
@@ -6701,7 +6701,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
 #endif
                 put_user_u32(pid_fd, parent_tidptr);
                 }
-            fork_end(0);
+            fork_end(ret);
         }
         g_assert(!cpu_in_exclusive_context(cpu));
     }
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index c63ef45fc78..9014014d920 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -71,7 +71,7 @@ const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(abi_long pid);
 
 /**
  * probe_guest_base:
-- 
2.43.0


