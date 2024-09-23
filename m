Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F089CCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpu-0007Ou-Ez; Mon, 23 Sep 2024 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpZ-0006XS-Nt
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpV-0000cN-OS
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7Sq2L013386;
 Mon, 23 Sep 2024 16:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=lpKHUhaN9P+Pk
 xEJc8MSZinB2goxOOchK5QboD4Rig0=; b=me3oomKha/r+OyQzZAK6ffHIvUjKU
 TAsdQvonOQ+/23LZDxzISlDdWKpZeMlKMnpCcAIJeAVPaj1tGtQQhbTWiUm2SHHF
 nFqA26l7x3arMWP6FBzJKP575A+zVgao1aKZUv7ZCxZ2xHSGfByT7Rvn0BCKgky7
 OiCdRz9MrwFRW88AZF0oYyWGG7vWkfJBpg9tQLoimSWZeRtdYS4wpEtX9pdNWYtu
 vDCOfqyW/4lq/TGi4hw5rtj3Q4F2NkrmSXjAIN+rsUbG0Nf77AXNdfRulj3wL0he
 98nXOqwP9nIxM7Zkyh5CO82u/b6T6rhekIF3xPoso73IQox9JkJgT6zAw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjmwdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:26 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMQ9g026049;
 Mon, 23 Sep 2024 16:22:26 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjmwdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDl7Gx000643;
 Mon, 23 Sep 2024 16:22:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fufp6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMNNk49611238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0B882004B;
 Mon, 23 Sep 2024 16:22:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 475FA20043;
 Mon, 23 Sep 2024 16:22:23 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 16/18] cpu: Allow pausing and resuming CPUs in qemu-user
Date: Mon, 23 Sep 2024 18:13:11 +0200
Message-ID: <20240923162208.90745-17-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GI3W6SA473lnD0rzaWwzoJqifIH-YqbJ
X-Proofpoint-GUID: qkdC50Bh6vpbPCnsf5TAjf9f_SoXEMCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230121
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

Move the respective functions from sysemu to cpu-common.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec-stub.c |   4 --
 accel/tcg/user-exec.c      |  11 +++-
 cpu-common.c               | 115 +++++++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h  |   7 +++
 include/sysemu/cpus.h      |   5 --
 system/cpus.c              | 108 ----------------------------------
 6 files changed, 132 insertions(+), 118 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc88..e79f2e88498 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -2,10 +2,6 @@
 #include "hw/core/cpu.h"
 #include "exec/replay-core.h"
 
-void cpu_resume(CPUState *cpu)
-{
-}
-
 void cpu_remove_sync(CPUState *cpu)
 {
 }
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index de4753cded7..3399b074485 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1293,12 +1293,19 @@ int cpu_exec_user(CPUState *cs)
 {
     int trapnr;
 
+    do {
+        qemu_wait_io_event(cs);
+    } while (!cpu_can_run(cs));
+
     bql_unlock();
     cpu_exec_start(cs);
     trapnr = cpu_exec(cs);
     cpu_exec_end(cs);
     bql_lock();
-    process_queued_cpu_work(cs);
+
+    do {
+        qemu_wait_io_event(cs);
+    } while (!cpu_can_run(cs));
 
     return trapnr;
 }
@@ -1306,11 +1313,13 @@ int cpu_exec_user(CPUState *cs)
 void qemu_cpu_kick(CPUState *cpu)
 {
     cpu_exit(cpu);
+    qemu_cond_broadcast(cpu->halt_cond);
 }
 
 void cpu_enter_syscall(CPUState *cs)
 {
     cs->in_syscall = true;
+    qemu_pause_cond_broadcast();
 }
 
 void cpu_exit_syscall(CPUState *cs)
diff --git a/cpu-common.c b/cpu-common.c
index 2822ee9373d..979e3fe8806 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -24,6 +24,8 @@
 #include "sysemu/cpus.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
+#include "exec/replay-core.h"
+#include "qemu/plugin.h"
 
 QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -456,6 +458,9 @@ void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
 /* The Big QEMU Lock (BQL) */
 static QemuMutex bql = QEMU_MUTEX_INITIALIZER;
 
+/* system init */
+static QemuCond qemu_pause_cond = QEMU_COND_INITIALIZER;
+
 QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
 
 bool bql_locked(void)
@@ -498,6 +503,105 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     do_run_on_cpu(cpu, func, data, &bql);
 }
 
+static bool all_vcpus_paused(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (!cpu_is_paused(cpu)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+void pause_all_vcpus(void)
+{
+    CPUState *cpu;
+
+    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
+    CPU_FOREACH(cpu) {
+        cpu_pause(cpu);
+    }
+
+    /* We need to drop the replay_lock so any vCPU threads woken up
+     * can finish their replay tasks
+     */
+    replay_mutex_unlock();
+
+    while (!all_vcpus_paused()) {
+        qemu_cond_wait_bql(&qemu_pause_cond);
+        CPU_FOREACH(cpu) {
+            qemu_cpu_kick(cpu);
+        }
+    }
+
+    bql_unlock();
+    replay_mutex_lock();
+    bql_lock();
+}
+
+void qemu_pause_cond_broadcast(void)
+{
+    qemu_cond_broadcast(&qemu_pause_cond);
+}
+
+static void qemu_cpu_stop(CPUState *cpu, bool exit)
+{
+    g_assert(qemu_cpu_is_self(cpu));
+    cpu->stop = false;
+    cpu->stopped = true;
+    if (exit) {
+        cpu_exit(cpu);
+    }
+    qemu_pause_cond_broadcast();
+}
+
+void qemu_wait_io_event_common(CPUState *cpu)
+{
+    qatomic_set_mb(&cpu->thread_kicked, false);
+    if (cpu->stop) {
+        qemu_cpu_stop(cpu, false);
+    }
+    process_queued_cpu_work(cpu);
+}
+
+void qemu_wait_io_event(CPUState *cpu)
+{
+    bool slept = false;
+
+    while (cpu_thread_is_idle(cpu)) {
+        if (!slept) {
+            slept = true;
+            qemu_plugin_vcpu_idle_cb(cpu);
+        }
+        qemu_cond_wait_bql(cpu->halt_cond);
+    }
+    if (slept) {
+        qemu_plugin_vcpu_resume_cb(cpu);
+    }
+
+    qemu_wait_io_event_common(cpu);
+}
+
+void cpu_pause(CPUState *cpu)
+{
+    if (qemu_cpu_is_self(cpu)) {
+        qemu_cpu_stop(cpu, true);
+    } else {
+        cpu->stop = true;
+        qemu_cpu_kick(cpu);
+    }
+}
+
+void cpu_resume(CPUState *cpu)
+{
+    cpu->stop = false;
+    cpu->stopped = false;
+    qemu_cpu_kick(cpu);
+}
+
 bool cpu_work_list_empty(CPUState *cpu)
 {
     return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list);
@@ -516,3 +620,14 @@ int cpu_thread_is_idle_common(CPUState *cpu)
     }
     return -1;
 }
+
+bool cpu_can_run(CPUState *cpu)
+{
+    if (cpu->stop) {
+        return false;
+    }
+    if (cpu_is_stopped(cpu)) {
+        return false;
+    }
+    return true;
+}
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e8b530ed889..a54368c5b69 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -234,6 +234,13 @@ void cpu_exit_syscall(CPUState *cs);
 int cpu_thread_is_idle_common(CPUState *cpu);
 bool cpu_thread_is_idle(CPUState *cpu);
 bool cpu_is_paused(CPUState *cpu);
+bool cpu_can_run(CPUState *cpu);
+void qemu_wait_io_event_common(CPUState *cpu);
+void qemu_wait_io_event(CPUState *cpu);
+void pause_all_vcpus(void);
+void qemu_pause_cond_broadcast(void);
+bool cpu_work_list_empty(CPUState *cpu);
+
 
 /**
  * env_archcpu(env)
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index bfa3fd45650..ebfd0b77bcd 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -20,11 +20,7 @@ void dummy_start_vcpu_thread(CPUState *);
 #define VCPU_THREAD_NAME_SIZE 16
 
 void cpus_kick_thread(CPUState *cpu);
-bool cpu_work_list_empty(CPUState *cpu);
 bool all_cpu_threads_idle(void);
-bool cpu_can_run(CPUState *cpu);
-void qemu_wait_io_event_common(CPUState *cpu);
-void qemu_wait_io_event(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
 void cpu_handle_guest_debug(CPUState *cpu);
@@ -34,7 +30,6 @@ void cpu_handle_guest_debug(CPUState *cpu);
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
-void pause_all_vcpus(void);
 void cpu_stop_current(void);
 
 extern int icount_align_option;
diff --git a/system/cpus.c b/system/cpus.c
index 407140c41f6..9ad7bae056e 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -307,17 +307,6 @@ int vm_shutdown(void)
     return do_vm_stop(RUN_STATE_SHUTDOWN, false);
 }
 
-bool cpu_can_run(CPUState *cpu)
-{
-    if (cpu->stop) {
-        return false;
-    }
-    if (cpu_is_stopped(cpu)) {
-        return false;
-    }
-    return true;
-}
-
 void cpu_handle_guest_debug(CPUState *cpu)
 {
     if (replay_running_debug()) {
@@ -400,56 +389,15 @@ static QemuThread io_thread;
 
 /* cpu creation */
 static QemuCond qemu_cpu_cond;
-/* system init */
-static QemuCond qemu_pause_cond;
 
 void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
     qemu_cond_init(&qemu_cpu_cond);
-    qemu_cond_init(&qemu_pause_cond);
 
     qemu_thread_get_self(&io_thread);
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
-{
-    g_assert(qemu_cpu_is_self(cpu));
-    cpu->stop = false;
-    cpu->stopped = true;
-    if (exit) {
-        cpu_exit(cpu);
-    }
-    qemu_cond_broadcast(&qemu_pause_cond);
-}
-
-void qemu_wait_io_event_common(CPUState *cpu)
-{
-    qatomic_set_mb(&cpu->thread_kicked, false);
-    if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
-    }
-    process_queued_cpu_work(cpu);
-}
-
-void qemu_wait_io_event(CPUState *cpu)
-{
-    bool slept = false;
-
-    while (cpu_thread_is_idle(cpu)) {
-        if (!slept) {
-            slept = true;
-            qemu_plugin_vcpu_idle_cb(cpu);
-        }
-        qemu_cond_wait_bql(cpu->halt_cond);
-    }
-    if (slept) {
-        qemu_plugin_vcpu_resume_cb(cpu);
-    }
-
-    qemu_wait_io_event_common(cpu);
-}
-
 void cpus_kick_thread(CPUState *cpu)
 {
     if (cpu->thread_kicked) {
@@ -513,67 +461,11 @@ void cpu_thread_signal_destroyed(CPUState *cpu)
     qemu_cond_signal(&qemu_cpu_cond);
 }
 
-void cpu_pause(CPUState *cpu)
-{
-    if (qemu_cpu_is_self(cpu)) {
-        qemu_cpu_stop(cpu, true);
-    } else {
-        cpu->stop = true;
-        qemu_cpu_kick(cpu);
-    }
-}
-
-void cpu_resume(CPUState *cpu)
-{
-    cpu->stop = false;
-    cpu->stopped = false;
-    qemu_cpu_kick(cpu);
-}
-
 bool cpu_is_paused(CPUState *cpu)
 {
     return cpu->stopped;
 }
 
-static bool all_vcpus_paused(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (!cpu_is_paused(cpu)) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
-void pause_all_vcpus(void)
-{
-    CPUState *cpu;
-
-    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
-    CPU_FOREACH(cpu) {
-        cpu_pause(cpu);
-    }
-
-    /* We need to drop the replay_lock so any vCPU threads woken up
-     * can finish their replay tasks
-     */
-    replay_mutex_unlock();
-
-    while (!all_vcpus_paused()) {
-        qemu_cond_wait_bql(&qemu_pause_cond);
-        CPU_FOREACH(cpu) {
-            qemu_cpu_kick(cpu);
-        }
-    }
-
-    bql_unlock();
-    replay_mutex_lock();
-    bql_lock();
-}
-
 void resume_all_vcpus(void)
 {
     CPUState *cpu;
-- 
2.46.0


