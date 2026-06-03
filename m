Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C845CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUc5z-0007h3-R3; Tue, 02 Jun 2026 23:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wUc5v-0007gf-P1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:16:39 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wUc5n-0001An-Sj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780456576; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=S8+whb8iQxpiI4kt7qxVYrj0vle2FdLheLHeHgN9f6A=;
 b=Doj48sYWVqfDJpR3xZ0hIZbPchA767ZZ5ygEXOELjUIGlK986+qelQvHHjrlW/kbLtFJWagEdP+3fBhux89WQ/oSy8kInAoTvbM3azWUOpsDm032vWXsgLVoljK6mkh7hRalbYHarXuem0C8eDNnGMzOiWw7movbFeWnWNOGXyA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X461xZP_1780456573; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X461xZP_1780456573 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 11:16:13 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	infra.ai.cloud@bitdeer.com,
	kvm@vger.kernel.org
Subject: [PATCH] accel/kvm: event-driven wakeup for dirty ring reaper thread
Date: Wed,  3 Jun 2026 11:16:12 +0800
Message-ID: <20260603031612.6173-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The dirty ring reaper thread polls with a fixed sleep(1), which the
code itself flags with a TODO for a smarter timeout.  Events that
would benefit from a prompt reap must wait up to one full sleep tick
before the reaper notices them.

Replace the polling loop with an EventNotifier-based wait via
qemu_poll_ns(), kicked by paths that have first-hand evidence that
a reap is desirable.  A 1s fallback timeout is retained as a
defensive backstop.

Two kick sites are wired up:

  * dirtylimit_change(false) -- when dirty-limit is cancelled, kick
    the reaper so it resumes real reaping immediately instead of
    waiting for the next sleep tick.

    Measured with strace on the reaper TID (20 set/cancel cycles
    against a stress-ng dirty-page workload), latency from the
    cancel-vcpu-dirty-limit QMP ack to the reaper actually waking:

        before: median 530ms, max 937ms
        after:  median <1ms,  max <1ms

  * kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler -- the handler
    already reaps the exiting vCPU synchronously; the kick hints the
    reaper to also check other vCPUs whose rings are likely filling
    concurrently.

kvm_dirty_ring_reaper_kick() is exposed as a public API; multiple
kicks collapse into a single wake via the eventfd counter.
kvm_dirty_ring_reaper_init() now returns int again (it was made void
in commit 43a5e377f4) to propagate event_notifier_init() failure.
A stub is added for non-KVM builds.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 accel/kvm/kvm-all.c      | 62 +++++++++++++++++++++++++++++++++++++---
 accel/stubs/kvm-stub.c   |  4 +++
 include/system/kvm.h     |  9 ++++++
 include/system/kvm_int.h |  3 ++
 system/dirtylimit.c      |  6 ++++
 5 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb24..f964102f09 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1754,6 +1754,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     } while (size);
 }
 
+/* Fallback liveness timeout for the dirty ring reaper, in nanoseconds. */
+#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
+
 static void *kvm_dirty_ring_reaper_thread(void *data)
 {
     KVMState *s = data;
@@ -1764,12 +1767,30 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     trace_kvm_dirty_ring_reaper("init");
 
     while (true) {
+        GPollFD pfd = {
+            .fd = event_notifier_get_fd(&r->reaper_notifier),
+            .events = G_IO_IN,
+        };
+
         r->reaper_state = KVM_DIRTY_RING_REAPER_WAIT;
         trace_kvm_dirty_ring_reaper("wait");
+
         /*
-         * TODO: provide a smarter timeout rather than a constant?
+         * Event-driven wait: sleep until something kicks the reaper
+         * (vCPU ring-full exit, dirtylimit disabled, ...) or until the
+         * fallback timeout fires.  The fallback preserves the original
+         * sleep(1) worst-case behaviour as a liveness backstop in case
+         * a kick site is ever missed.
          */
-        sleep(1);
+        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
+
+        /*
+         * Drain the notifier whether or not the wakeup came from it --
+         * any pending kick is satisfied by the reap we are about to
+         * perform, so we must not leave a stale event behind that would
+         * cause the next iteration to spin without sleeping.
+         */
+        event_notifier_test_and_clear(&r->reaper_notifier);
 
         /* keep sleeping so that dirtylimit not be interfered by reaper */
         if (dirtylimit_in_service()) {
@@ -1789,13 +1810,39 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     g_assert_not_reached();
 }
 
-static void kvm_dirty_ring_reaper_init(KVMState *s)
+static int kvm_dirty_ring_reaper_init(KVMState *s, Error **errp)
 {
     struct KVMDirtyRingReaper *r = &s->reaper;
+    int ret;
+
+    ret = event_notifier_init(&r->reaper_notifier, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Failed to initialize dirty ring reaper notifier");
+        return ret;
+    }
 
     qemu_thread_create(&r->reaper_thr, "kvm-reaper",
                        kvm_dirty_ring_reaper_thread,
                        s, QEMU_THREAD_JOINABLE);
+    return 0;
+}
+
+/*
+ * Wake the dirty ring reaper thread so it performs a reap as soon as
+ * possible.  Safe to call from any thread; safe to call even when the
+ * dirty ring is not enabled (no-op in that case).  Coalescing is
+ * provided by the eventfd counter -- multiple kicks before the reaper
+ * runs collapse into a single wakeup.
+ */
+void kvm_dirty_ring_reaper_kick(void)
+{
+    KVMState *s = kvm_state;
+
+    if (!s || !s->kvm_dirty_ring_size) {
+        return;
+    }
+    event_notifier_set(&s->reaper.reaper_notifier);
 }
 
 static int kvm_dirty_ring_init(KVMState *s)
@@ -3097,7 +3144,9 @@ static int kvm_init(AccelState *as, MachineState *ms)
     }
 
     if (s->kvm_dirty_ring_size) {
-        kvm_dirty_ring_reaper_init(s);
+        if (kvm_dirty_ring_reaper_init(s, errp) < 0) {
+            goto err;
+        }
     }
 
     if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
@@ -3571,6 +3620,11 @@ int kvm_cpu_exec(CPUState *cpu)
                 kvm_dirty_ring_reap(kvm_state, NULL);
             }
             bql_unlock();
+            /*
+             * Ring-full pressure is the strongest signal that background
+             * reaping should stay hot; wake the reaper unconditionally.
+             */
+            kvm_dirty_ring_reaper_kick();
             dirtylimit_vcpu_execute(cpu);
             ret = 0;
             break;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c4617caac6..b878598552 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
     return 0;
 }
 
+void kvm_dirty_ring_reaper_kick(void)
+{
+}
+
 bool kvm_hwpoisoned_mem(void)
 {
     return false;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda..c42c8e0b74 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -553,6 +553,15 @@ bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
 
+/**
+ * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
+ *
+ * Hint that an immediate reap is desirable (e.g. ring-full pressure
+ * detected, dirtylimit disabled).  Coalesced via eventfd.  No-op when
+ * the dirty ring feature is not in use.
+ */
+void kvm_dirty_ring_reaper_kick(void);
+
 void kvm_mark_guest_state_protected(void);
 
 /**
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938..08e28d075a 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -12,6 +12,7 @@
 #include "system/memory.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/accel.h"
+#include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "system/kvm.h"
 #include "accel/accel-ops.h"
@@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
     QemuThread reaper_thr;
     volatile uint64_t reaper_iteration; /* iteration number of reaper thr */
     volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state */
+    /* Wakeup channel: kicked by ring-full vCPU exits, dirtylimit toggle, ... */
+    EventNotifier reaper_notifier;
 };
 struct KVMState
 {
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index c934ceb0de..3ee9c58479 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -393,6 +393,12 @@ void dirtylimit_change(bool start)
         qatomic_set(&dirtylimit_quit, 0);
     } else {
         qatomic_set(&dirtylimit_quit, 1);
+        /*
+         * The reaper has been short-circuiting via the
+         * dirtylimit_in_service() branch.  Kick it so it picks up the
+         * policy change immediately instead of after the next 1s tick.
+         */
+        kvm_dirty_ring_reaper_kick();
     }
 }
 
-- 
2.50.1 (Apple Git-155)


