Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C09D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 21:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQBrt-00059i-1e; Mon, 01 Dec 2025 16:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vQBrn-00058h-71; Mon, 01 Dec 2025 16:55:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vQBrl-00071a-1A; Mon, 01 Dec 2025 16:55:30 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1CHIZc010288;
 Mon, 1 Dec 2025 21:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=SYmQWauXhfvUVVpb0DAQ24TdQHZ21LptiqHQ0VAVa
 zU=; b=V9iPrgRfngdWpGBw0deBVfTB6tFb3leyuu17ltQy1kCNWchUTAS7JgPVK
 nmd7F976CdcZFVOoBzvCDd7vSEqoqeZPxT4JGx81FjlsGAVCfrYJ6RKH300o3kyD
 FPfN5kug9fCfie0ZkAq2CfOlp9tt8WlP6jFfcH7KMmAs8/UrzW6sl25h6/5BaROT
 wTqnrZrbchAk/uPYCEevszf4GGCMOD0DLsT3ANYdEUhbIqvm0iRZgUH0Ln3aw5cW
 prXs3Qu6gQkdV0AKveRuSpguBqg1tFBS1KnpdnwriBS4bkbk0MUilX5JT1BmlfIk
 ZxykfllVW5CEHS3hEauPRbosLbVcg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8psmy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 21:55:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1K1AUA029334;
 Mon, 1 Dec 2025 21:55:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv18kb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Dec 2025 21:55:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B1LtKbs47710662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Dec 2025 21:55:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A068520043;
 Mon,  1 Dec 2025 21:55:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7FFE20040;
 Mon,  1 Dec 2025 21:55:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.1.154])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Dec 2025 21:55:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC] target/s390x: Fix infinite loop during replay
Date: Mon,  1 Dec 2025 22:49:42 +0100
Message-ID: <20251201215514.1751994-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX9CftGeZgKP60
 J1OIlq/frOuUcGmsUpqXcjlhoB8GGWC341WxBpx1to3xiqSOQ6vmGkfAk5PRLh3p3bWSKUm4GKi
 jahgFRC68DoFynL0KR0ZmZ2ZSmVIwAZvvHGBX8w22tiY6uWL5XuUonx4j7XAYCoegEcYlSt0TeQ
 4HsZKLraMrwFH7l5+mBibgmeTiyRIywEqnJ5Q5qPJ3oI7kQVUpXVsUw/lGYW/3LG1u9aVNi4tLH
 KRLBgJwUbum9wEQQypqHPu9HRqFnaYWw0q7ik7iNSKoe2As22pJFdR7XVAngIHdpxJH8CoKYQS6
 54h7eHJuUswjhOlHd6XSYhdYQs9rHNYOIA69emQL9H5QzdfJPcWSgDg9cXSw5HRv9nlrBr7404h
 S+bfTa8v+CR5vf0h7fAPjMgJSy2izA==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692e0ecb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=6htAj4pN4P_zfDhBYlcA:9
X-Proofpoint-ORIG-GUID: 1nTGXiCpNZEhfheDjP-2sQSwiqPnhbLn
X-Proofpoint-GUID: 1nTGXiCpNZEhfheDjP-2sQSwiqPnhbLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

Here is my attempt to fix [1] based on the discussion in [2].

I'm sending this as an RFC, because I have definitely misunderstood a
thing or two about record-replay, missed some timer bookkeeping
intricacies, and haven't split arch-dependent and independent parts
into different patches.

This survives "make check" and "make check-tcg" with the test from [2],
both with and without extra load in background.

Please let me know what you think about the approach.

Best regards,
Ilya

[1] https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-218212818891@redhat.com/
[2] https://lore.kernel.org/qemu-devel/20251128133949.181828-1-thuth@redhat.com/

---

Replaying even trivial s390x kernels hangs, because:

- cpu_post_load() fires the TOD timer immediately.

- s390_tod_load() schedules work for firing the TOD timer.

- If rr loop sees work and then timer, we get one timer expiration.

- If rr loop sees timer and then work, we get two timer expirations.

- Record and replay may diverge due to this race.

- In this particular case divergence makes replay loop spin: it sees that
  TOD timer has expired, but cannot invoke its callback, because there
  is no recorded CHECKPOINT_CLOCK_VIRTUAL.

- The order in which rr loop sees work and timer depends on whether
  and when rr loop wakes up during load_snapshot().

- rr loop may wake up after the main thread kicks the CPU and drops
  the BQL, which may happen if it calls, e.g., qemu_cond_wait_bql().

Firing TOD timer twice is duplicate work, but it was introduced
intentionally in commit 7c12f710bad6 ("s390x/tcg: rearm the CKC timer
during migration") in order to avoid dependency on migration order.

The key culprits here are timers that are armed ready expired. They
break the ordering between timers and CPU work, because they are not
constrained by instruction execution, thus introducing non-determinism
and record-replay divergence.

Fix by converting such timer callbacks to CPU work. Also add TOD clock
updates to the save path, mirroring the load path, in order to have the
same CHECKPOINT_CLOCK_VIRTUAL during recording and replaying.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 hw/s390x/tod.c           |  5 +++++
 stubs/async-run-on-cpu.c |  7 +++++++
 stubs/cpus-queue.c       |  4 ++++
 stubs/meson.build        |  2 ++
 target/s390x/machine.c   |  4 ++++
 util/qemu-timer.c        | 30 ++++++++++++++++++++++++++++++
 6 files changed, 52 insertions(+)
 create mode 100644 stubs/async-run-on-cpu.c
 create mode 100644 stubs/cpus-queue.c

diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index 3f913cc88ab..81bce90c030 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -72,6 +72,11 @@ static void s390_tod_save(QEMUFile *f, void *opaque)
     qemu_put_byte(f, S390_TOD_CLOCK_VALUE_PRESENT);
     qemu_put_byte(f, tod.high);
     qemu_put_be64(f, tod.low);
+
+    tdc->set(td, &tod, &err);
+    if (err) {
+        warn_report_err(err);
+    }
 }
 
 static int s390_tod_load(QEMUFile *f, void *opaque, int version_id)
diff --git a/stubs/async-run-on-cpu.c b/stubs/async-run-on-cpu.c
new file mode 100644
index 00000000000..adf1867ad21
--- /dev/null
+++ b/stubs/async-run-on-cpu.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+{
+    abort();
+}
diff --git a/stubs/cpus-queue.c b/stubs/cpus-queue.c
new file mode 100644
index 00000000000..fd678f42969
--- /dev/null
+++ b/stubs/cpus-queue.c
@@ -0,0 +1,4 @@
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
diff --git a/stubs/meson.build b/stubs/meson.build
index 0b2778c568e..d3b551f4def 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -41,6 +41,8 @@ if have_block or have_ga
   stub_ss.add(files('monitor-internal.c'))
   stub_ss.add(files('qmp-command-available.c'))
   stub_ss.add(files('qmp-quit.c'))
+  stub_ss.add(files('async-run-on-cpu.c'))
+  stub_ss.add(files('cpus-queue.c'))
 endif
 
 if have_block or have_user
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 3bea6103ffb..f714834a98a 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -52,6 +52,10 @@ static int cpu_pre_save(void *opaque)
         kvm_s390_vcpu_interrupt_pre_save(cpu);
     }
 
+    if (tcg_enabled()) {
+        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
+    }
+
     return 0;
 }
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2a6be4c7f95..d93a020064f 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -30,6 +30,7 @@
 #include "exec/icount.h"
 #include "system/replay.h"
 #include "system/cpus.h"
+#include "hw/core/cpu.h"
 
 #ifdef CONFIG_POSIX
 #include <pthread.h>
@@ -387,11 +388,40 @@ static void timer_del_locked(QEMUTimerList *timer_list, QEMUTimer *ts)
     }
 }
 
+static void timer_fire(CPUState *cpu, run_on_cpu_data data)
+{
+    QEMUTimer *t = data.host_ptr;
+
+    t->cb(t->opaque);
+}
+
 static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
                                 QEMUTimer *ts, int64_t expire_time)
 {
     QEMUTimer **pt, *t;
 
+    /*
+     * Normally during record-replay virtual clock timers and CPU work are
+     * deterministically ordered. This is because the virtual clock can be
+     * advanced only by instructions running on a CPU.
+     *
+     * A notable exception are timers that are armed already expired. Their
+     * expiration is not constrained by instruction execution, and, therefore,
+     * their ordering relative to CPU work is affected by what the
+     * record-replay thread is doing when they are armed. This introduces
+     * non-determinism.
+     *
+     * Convert such timers to CPU work in order to avoid it.
+     */
+    if (replay_mode != REPLAY_MODE_NONE &&
+        timer_list->clock->type == QEMU_CLOCK_VIRTUAL &&
+        !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL) &&
+        expire_time <= qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
+        async_run_on_cpu(first_cpu, timer_fire,
+                         RUN_ON_CPU_HOST_PTR(ts));
+        return false;
+    }
+
     /* add the timer in the sorted list */
     pt = &timer_list->active_timers;
     for (;;) {
-- 
2.51.1


