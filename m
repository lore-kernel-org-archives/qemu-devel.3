Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AAAFE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDwW-0002eS-W1; Fri, 24 Apr 2026 06:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGDwU-0002bB-AP; Fri, 24 Apr 2026 06:39:26 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGDwR-000201-AZ; Fri, 24 Apr 2026 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=uNSdOJEhtNrcgxDuLoQOyJZjT8cwzLWmaavcB1WJkGU=; b=SR4mYlt8Juoe
 IYaRkuOOH2WVVDHdqA/tOgLy0KGLut6PTzMqkxI8jwE6MWpUujtiFMromHzfCWU6aJeqi8OHUK0wp
 e9gs1eRL/R5DiQ4W2MLSsVR0jzqecxLrhAaedURl9mXg06UyPjQBVx5wEiaSV0sUU4HEQLUhqeD2V
 qIWGzQSmAnOUC1FxbCxc1KH/gHtJGARY6ZOdttROTCqcxo/aqAczbcF3Gx+bFfDA+9aQ9SqrK5bG0
 0nerrFqoTBc36H17sGlU5eUrNZSJ9tXRqpSlXJDrdmxyccoPC4sOB8g13XeZOQ1jzUQlj2oqp3mvK
 CazAkI0JQX57IOTQuBDqmw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wGDtf-00F3Ps-2L;
 Fri, 24 Apr 2026 12:39:15 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/2] block/qcow2: fix hangup in cache_clean_timer cancellation
Date: Fri, 24 Apr 2026 12:39:17 +0200
Message-ID: <20260424103917.248668-3-den@openvz.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424103917.248668-1-den@openvz.org>
References: <20260424103917.248668-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

cache_clean_timer_del_and_wait() cancels the cache-cleaner coroutine
by setting s->cache_clean_interval = 0 and calling qemu_co_sleep_wake()
to cut short its qemu_co_sleep_ns_wakeable(). qemu_co_sleep_wake() is
fire-and-forget: it reads w->to_wake and silently returns when it is
NULL. A sleeper that is between two iterations -- has just released
s->lock but has not yet set w->to_wake inside qemu_co_sleep() -- loses
the wake:

  iothread0 timer coroutine           main thread (qcow2 close)
  -------------------------           -------------------------
  while-body (holding s->lock):
    read interval = 600
    wait_ns = 600 * NS
    release s->lock
                                      take s->lock
                                      interval = 0
                                      qemu_co_sleep_wake(w):
                                        w->to_wake == NULL -> skip
                                        return
                                      qemu_co_queue_wait(exit, s->lock):
                                        release s->lock
                                        yield
  qemu_co_sleep_ns_wakeable:
    aio_timer_init(+600 s)
    qemu_co_sleep:
      cas scheduled NULL -> "qsns"
      w->to_wake = co
      yield  [sleeps 600 s]

cache_clean_timer_del_and_wait() is now stuck waiting for
cache_clean_timer_exit; the timer will not signal it until its
original 600 s expiry fires. qcow2_close() is on the main thread
holding BQL, so RCU, VCPUs and every iothread path that needs BQL
stall behind it.

qemu_co_sleep_wake() has always been a hint: it has no way to
rendezvous with a sleeper still arming. Rather than mutate it (which
would change semantics for every other user -- mirror, stream,
backup), fix the caller.

Split the sleep in cache_clean_timer() into steps of at most one
second and move the s->cache_clean_interval check to the top of the
loop so it is re-evaluated under s->lock between steps. The
loop/wait structure itself is unchanged. The stop decision is now
made under the same lock that the teardown caller holds to set
cache_clean_interval = 0, so it cannot be missed.
qemu_co_sleep_wake() is still called opportunistically to cut short
the current step; if it misses, the next 1 s tick catches the change.
Worst-case cancellation latency is bounded at 1 s, independent of
cache_clean_interval.

Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index f6461743d2..3e249970d6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -838,24 +838,30 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
 static void coroutine_fn cache_clean_timer(void *opaque)
 {
     BDRVQcow2State *s = opaque;
-    uint64_t wait_ns;
+    uint64_t remaining_ns = 0;
 
-    WITH_QEMU_LOCK_GUARD(&s->lock) {
-        wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
-    }
-
-    while (wait_ns > 0) {
-        qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
-                                  QEMU_CLOCK_REALTIME, wait_ns);
+    for (;;) {
+        bool stop = false;
+        uint64_t step;
 
         WITH_QEMU_LOCK_GUARD(&s->lock) {
-            if (s->cache_clean_interval > 0) {
+            if (s->cache_clean_interval == 0) {
+                stop = true;
+            } else if (remaining_ns == 0) {
                 qcow2_cache_clean_unused(s->l2_table_cache);
                 qcow2_cache_clean_unused(s->refcount_block_cache);
+                remaining_ns = s->cache_clean_interval
+                               * (uint64_t)NANOSECONDS_PER_SECOND;
             }
-
-            wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
         }
+        if (stop) {
+            break;
+        }
+
+        step = MIN(remaining_ns, (uint64_t)NANOSECONDS_PER_SECOND);
+        qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
+                                  QEMU_CLOCK_REALTIME, step);
+        remaining_ns -= step;
     }
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
-- 
2.51.0


