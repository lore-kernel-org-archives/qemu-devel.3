Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B2CD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV24v-0002JW-CC; Thu, 04 Jun 2026 03:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV24i-0002HV-3A
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:01:10 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV24Y-0005SX-Ga
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 03:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780556431; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=N/wmenlWZj0voABROW3OovXPJqUV5xK6krbUpzP9YSY=;
 b=W3z133pDJqawZW3zKE6qVhqCdy7+m3Ps1/RQLzLYgZxgc8mTQBCdBZsbQESwiHLg0sKX6Vb2XQvH8ImtmK8gcDC/8bsrmLJj5e/r/P6g8clji5h2r2tKlVQbwm61syuJ8ItDmLMTCWRquUJpSA6ZoRfTcVP58XAK1JF9ZQgmHLk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X49Tjcr_1780556430; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X49Tjcr_1780556430 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 04 Jun 2026 15:00:31 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper thread
Date: Thu,  4 Jun 2026 15:00:29 +0800
Message-ID: <20260604070029.34982-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=guobin@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

The reaper polls with sleep(1) (TODO in the code) and only notices
dirty-limit teardown at the next 1s tick.

Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
from dirtylimit_state_finalize() after dirtylimit_state has been
cleared.  The kick must follow the NULL assignment: kicking earlier
wakes the reaper while dirtylimit_in_service() still returns true,
so it just loops back to wait.  A 1s fallback timeout remains as a
liveness backstop.

20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
cancel-ack| measured with strace on the reaper TID:

    before: median 255 ms, max 502 ms
    after:  median 0.6 ms, max  27 ms

kvm_dirty_ring_reaper_init() returns int again (was made void in
commit 43a5e377f4) to propagate event_notifier_init() failure.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
Changes in v2:
- Fix compilation error: kvm_init() has no Error **errp parameter, so
  kvm_dirty_ring_reaper_init() now uses error_report() directly and
  no longer accepts an errp argument.
- Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler:
  it already reaps synchronously (all vCPUs or the ring-full one), so
  a background reaper kick would only be redundant or a no-op.
- Move kick site from dirtylimit_change(false) to
  dirtylimit_state_finalize() after dirtylimit_state = NULL, ensuring
  the reaper actually proceeds past the dirtylimit_in_service() check.

 accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
 accel/stubs/kvm-stub.c   |  4 ++++
 include/system/kvm.h     |  7 +++++++
 include/system/kvm_int.h |  3 +++
 system/dirtylimit.c      |  2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb24..be005832bc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     } while (size);
 }
 
+#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
+
 static void *kvm_dirty_ring_reaper_thread(void *data)
 {
     KVMState *s = data;
@@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     trace_kvm_dirty_ring_reaper("init");
 
     while (true) {
+        GPollFD pfd = {
+            .fd = event_notifier_get_fd(&r->reaper_notifier),
+            .events = G_IO_IN,
+        };
+
         r->reaper_state = KVM_DIRTY_RING_REAPER_WAIT;
         trace_kvm_dirty_ring_reaper("wait");
-        /*
-         * TODO: provide a smarter timeout rather than a constant?
-         */
-        sleep(1);
+
+        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
+
+        /* Drain unconditionally so a stale event can't spin the next loop. */
+        event_notifier_test_and_clear(&r->reaper_notifier);
 
         /* keep sleeping so that dirtylimit not be interfered by reaper */
         if (dirtylimit_in_service()) {
@@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     g_assert_not_reached();
 }
 
-static void kvm_dirty_ring_reaper_init(KVMState *s)
+static int kvm_dirty_ring_reaper_init(KVMState *s)
 {
     struct KVMDirtyRingReaper *r = &s->reaper;
+    int ret;
+
+    ret = event_notifier_init(&r->reaper_notifier, 0);
+    if (ret < 0) {
+        error_report("Failed to initialize dirty ring reaper notifier: %s",
+                     strerror(-ret));
+        return ret;
+    }
 
     qemu_thread_create(&r->reaper_thr, "kvm-reaper",
                        kvm_dirty_ring_reaper_thread,
                        s, QEMU_THREAD_JOINABLE);
+    return 0;
+}
+
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
@@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
     }
 
     if (s->kvm_dirty_ring_size) {
-        kvm_dirty_ring_reaper_init(s);
+        ret = kvm_dirty_ring_reaper_init(s);
+        if (ret < 0) {
+            goto err;
+        }
     }
 
     if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
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
index 5fa33eddda..e127a5eb37 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
 
+/**
+ * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
+ *
+ * Safe from any thread; no-op when the dirty ring is not in use.
+ */
+void kvm_dirty_ring_reaper_kick(void);
+
 void kvm_mark_guest_state_protected(void);
 
 /**
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938..c14ebc927f 100644
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
+    /* Wakeup channel: kicked when dirty-limit is torn down. */
+    EventNotifier reaper_notifier;
 };
 struct KVMState
 {
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index c934ceb0de..a33256ade7 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
     g_free(dirtylimit_state);
     dirtylimit_state = NULL;
 
+    kvm_dirty_ring_reaper_kick();
+
     trace_dirtylimit_state_finalize();
 }
 
-- 
2.50.1 (Apple Git-155)


