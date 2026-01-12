Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC591C9EC88
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHp4-0003jk-07; Mon, 12 Jan 2026 08:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlk-0001c5-VK
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHli-0002cc-Vy
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ask/kaEfsqPjdW7TMeUlFhRmQNDQ/cdJ4fFt3gBuhLA=;
 b=Wznzj/QjSjBO4V0C96aLYb54GPCYwUDbRC3w5e8KPvOos5PUIwjW4fLOJe6DqWF8wwfSoQ
 vsC2VUM0D7w8zLijUWq06jhIq0vRFeBr6HdLP9rrdZE9Bk29Sm2zyQVchwfr94qLN4pL9p
 SW3ZpOdr/Vda0dOR7tecvftAvTEUXnA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-PU4PMbrYPZeFZxksfoRnVw-1; Mon,
 12 Jan 2026 08:15:33 -0500
X-MC-Unique: PU4PMbrYPZeFZxksfoRnVw-1
X-Mimecast-MFC-AGG-ID: PU4PMbrYPZeFZxksfoRnVw_1768223733
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA6E9195605B; Mon, 12 Jan 2026 13:15:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BC7630001A2; Mon, 12 Jan 2026 13:15:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 14/15] target/s390x: Fix infinite loop during replay
Date: Mon, 12 Jan 2026 14:14:56 +0100
Message-ID: <20260112131457.67128-15-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

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

Link: https://lore.kernel.org/qemu-devel/20251128133949.181828-1-thuth@redhat.com/
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251201215514.1751994-1-iii@linux.ibm.com>
[thuth: Add SPDX license identifiers to the new stubs files]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/tod.c           |  5 +++++
 stubs/async-run-on-cpu.c | 11 +++++++++++
 stubs/cpus-queue.c       |  8 ++++++++
 target/s390x/machine.c   |  4 ++++
 util/qemu-timer.c        | 30 ++++++++++++++++++++++++++++++
 stubs/meson.build        |  2 ++
 6 files changed, 60 insertions(+)
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
index 00000000000..b8975bf5a8a
--- /dev/null
+++ b/stubs/async-run-on-cpu.c
@@ -0,0 +1,11 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+{
+    abort();
+}
diff --git a/stubs/cpus-queue.c b/stubs/cpus-queue.c
new file mode 100644
index 00000000000..c59fb76a108
--- /dev/null
+++ b/stubs/cpus-queue.c
@@ -0,0 +1,8 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+
+CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
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
-- 
2.52.0


