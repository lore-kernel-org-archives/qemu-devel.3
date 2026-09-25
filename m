Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02ECC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8QG-000599-7K; Fri, 25 Sep 2026 12:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Di-0007um-7K
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:18 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Df-0005zP-0F
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:17 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so6410155e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351533; x=1790956333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9NETAQlR/XFiQLgadgf42XnVl/ITfeWvA2y/lQhR7CA=;
 b=MNikOVIuV59tip0GYqh+IC4htvZX/T27taREF2paIFt8Tl0Tq5YwSqUZMgbVsE2ooV
 0XRlg8q9eEv8QzVDsrhwH9nrqoXanJQtgB6BJYDzsnl3nmCUOLp09Cfqli9SDbULt30L
 qa1nFuxmSz7KYEQ4ixvQeYIwqKQIlt1UVJI2aOw7ORuXHKd2QJWkksPr1ROZ1NT1riJ1
 M6BzV42JrsjIMPgdKFfE5XSljxrH8TjxUw9Firb+MPy6lSZK+4pY9G52DsGR6Pi+aMdv
 BW7YRniBy+exv/olZOjWzbmp5IguN8RP+c7ZYSIyjIsLRNC6R3FcNVO3CnRGS+wWKzd2
 jiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351533; x=1790956333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9NETAQlR/XFiQLgadgf42XnVl/ITfeWvA2y/lQhR7CA=;
 b=jwoxSXrMXJrcJ3UZ2bBRZ/nX+FnhL9P9QqWQlnKHAuviY7AwKu9TOmTvEfQ6c79DI3
 wLSxYeLHDn0Sg6386cd2XgTCHI2yQ1KUZkP+v9UGipZaQ3SLfDbQJDXQgHrU5UhOlQtm
 ktWkHp/qaeWB0n1s0hHS70JmbA02WqcHTMKtYoEK8IKE4/CYM3H0rEtzoaBJpZIgh26x
 3JKi20rOshH1DF9Mm6Wt2SCHgjD6Rv+5ttYnXVpuVPY/D+SzwacE98FeqxmcigO/I/E8
 XxwEmAPN/qmceJI9so+Pbl1OcpncrBoAxJWGF3DJYT3OCyfITxYFQBdn3Nm4Sbn1SAbp
 lOgQ==
X-Gm-Message-State: AFuF++nqlh5lfd5LexQ0Nb7FHYhA0BB/daN/b1t7dEgM2yU3JAkLtgw5
 k7h0Ea8mmtKw/pEJ83yl6Ca6BPPbVL9feDyws1BmDucS5leHsi+Wb4YYEsr8lWLMSvC6m+2RcVH
 E+P7/VI0VAA==
X-Gm-Gg: AYBFou1zkjdT3cu2qcKsyPwpgipjryl2m0X91JfVjyTOdaYngzEcaOU5AvWScvp1AgE
 MgnutUE1aHFvKZNLFY1DMwRspNIWRiBRT+rflskTdZK26kGwH8beoSKvxiRsqL51VbvzAqTxB6Z
 +CxEtpXeRbpOPU+sbElRZgEHfaHLyp6yqt1Qzep2bGLJ/t00kR60psTUaXBqf8crxQlZ7HEZYtk
 vP7cE/Do8iAWzJUR6YU8ACnSKNfxwgSdOGYqLgj76/GCVUc9jKcb7khbfDYxa4Lhm29h47VvIgZ
 vU/xDsrtL63qYxllacKkxHOAXVmz6FtQK/t8Wux4Hlf+z30Vfx6w8yx3wZvbUWXs3pbRCsm/jfr
 57uD1dgG6TOnZItqtL717XGsqiifW2tWfjcP5j9uxSjZ4XULiK/wwwyDgAD/1kmUOY5qUY+vxIr
 yxvHjgtzJY/5HEKgFLSiiiFNMWgVJBwxdhE7exJERcZLJpcAmTi6QDfvRSoNBn1oT31oTgHznLV
 ZgYGvCM1Ctm4CknZQi6f8cfTEPFVrxJe/BCby42/w==
X-Received: by 2002:a05:600c:19d3:b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49fe66fb4a7mr101046365e9.26.1790351533636; 
 Fri, 25 Sep 2026 08:52:13 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:13 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 08/13] migration/rdma: Add producer/consumer tuning
 instrumentation
Date: Fri, 25 Sep 2026 17:51:43 +0200
Message-ID: <20260925155149.843870-9-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::10;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:02 -0400
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

Add producer full-wait, ring occupancy and consumer idle counters, the
per-migration prodcons stats dump, and trace events for ring push,
barrier, wake, dispatch and consumer lifecycle.  Observability only; the
transfer path is unchanged.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c       | 75 +++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events | 13 ++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a0ff73e313..628afaccaf 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -32,6 +32,7 @@
 #include "qemu/thread.h"
 #include "qemu/sockets.h"
 #include "qemu/coroutine.h"
+#include "qemu/timer.h"
 #include "system/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
@@ -1213,7 +1214,9 @@ static int producer_flush_pending(RDMAContext *rdma);
 static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
                         const struct iovec *iov, size_t niov);
 static void ring_set_abort(RDMAContext *rdma);
+static unsigned ring_occupancy(RDMAContext *rdma);
 static void rdma_nbsent_stats_dump(RDMAContext *rdma);
+static void rdma_prodcons_stats_dump(RDMASendRing *r);
 
 /*
  * Consult the connection manager to see a work request
@@ -2616,6 +2619,7 @@ static int rdma_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
     }
 
     /* Complete all chunks in the ring before the next round. */
+    trace_rdma_ram_round_notify(ring_occupancy(rdma));
     if (ring_barrier(rdma, RDMA_CMD_FLUSH, 0, NULL, 0) < 0) {
         error_setg(errp, "RDMA consumer aborted during round drain");
         return -1;
@@ -2684,6 +2688,14 @@ static bool ring_empty(RDMASendRing *r)
     return (qatomic_load_acquire(&r->head) - r->tail) == 0;
 }
 
+/* Producer-side snapshot of queued-but-unprocessed commands in the ring. */
+static unsigned ring_occupancy(RDMAContext *rdma)
+{
+    RDMASendRing *r = rdma->send_ring;
+
+    return r->head - qatomic_read(&r->tail);
+}
+
 static void ring_set_abort(RDMAContext *rdma)
 {
     RDMASendRing *r = rdma->send_ring;
@@ -2703,6 +2715,7 @@ static void ring_wake_producer(RDMASendRing *r)
 {
     smp_mb();   /* order the *_waiting load below vs the sleeper's store */
     if (qatomic_read(&r->producer_waiting)) {
+        trace_rdma_ring_wake_producer();
         qemu_mutex_lock(&r->wait_lock);
         qemu_cond_broadcast(&r->not_full);
         qemu_cond_broadcast(&r->barrier_cv);
@@ -2715,20 +2728,38 @@ static void ring_wake_consumer(RDMASendRing *r)
 {
     smp_mb();   /* order the *_waiting load below vs the sleeper's store */
     if (qatomic_read(&r->consumer_waiting)) {
+        trace_rdma_ring_wake_consumer();
         qemu_mutex_lock(&r->wait_lock);
         qemu_cond_signal(&r->not_empty);
         qemu_mutex_unlock(&r->wait_lock);
     }
 }
 
+static const char *rdma_cmd_type_str(RDMACmdType type)
+{
+    switch (type) {
+    case RDMA_CMD_WRITE:    return "WRITE";
+    case RDMA_CMD_FLUSH:    return "FLUSH";
+    case RDMA_CMD_REG_STOP: return "REG_STOP";
+    case RDMA_CMD_FILE:     return "FILE";
+    case RDMA_CMD_FINISH:   return "FINISH";
+    default:                return "UNKNOWN";
+    }
+}
+
 static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
 {
     RDMASendRing *r = rdma->send_ring;
+    unsigned occupancy;
 
     /* SETUP starts the consumer before any WRITE/FLUSH/REG_STOP/FILE. */
     assert(r);
+    trace_rdma_ring_push_begin(rdma_cmd_type_str(cmd->type),
+                               cmd->chunk_index);
 
     if (ring_full(r)) {
+        int64_t wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+
         qemu_mutex_lock(&r->wait_lock);
         r->producer_waiting = true;
         smp_mb();                       /* pair with ring_wake_producer() */
@@ -2737,12 +2768,23 @@ static int ring_push(RDMAContext *rdma, const RDMACmd *cmd)
         }
         r->producer_waiting = false;
         qemu_mutex_unlock(&r->wait_lock);
+
+        wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - wait_ns;
+        r->pushwait_total_ns += wait_ns;
+        if ((uint64_t)wait_ns > r->pushwait_max_ns) {
+            r->pushwait_max_ns = wait_ns;
+        }
+        trace_rdma_ring_push_full_wait(cmd->type, wait_ns);
     }
     if (qatomic_read(&r->abort)) {
         return -1;
     }
     r->ring[r->head & RDMA_SEND_RING_MASK] = *cmd;
     qatomic_store_release(&r->head, r->head + 1);   /* publish payload+slot */
+    occupancy = r->head - qatomic_read(&r->tail);
+    if (occupancy > r->occupancy_max) {
+        r->occupancy_max = occupancy;
+    }
     ring_wake_consumer(r);
     return 0;
 }
@@ -2798,8 +2840,10 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
                         const struct iovec *iov, size_t niov)
 {
     RDMASendRing *r = rdma->send_ring;
+    int64_t wait_ns;
     unsigned seq;
     RDMACmd cmd;
+    int ret;
 
     assert(r);          /* consumer started at SETUP; see ring_push() */
 
@@ -2813,6 +2857,7 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
     if (seq == 0) {                 /* seq 0 is the "no barrier" sentinel */
         seq = ++r->barrier_next_seq;
     }
+    trace_rdma_ring_barrier_begin(type, seq);
     cmd = (RDMACmd){
         .type = type,
         .flags = flags,
@@ -2822,10 +2867,16 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
     };
 
     if (ring_push(rdma, &cmd) < 0) {
+        trace_rdma_ring_barrier_end(type, seq, 0, -1);
         return -1;
     }
 
-    return ring_wait_barrier(r, seq);
+    /* time spent blocked waiting for the consumer to complete the barrier */
+    wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    ret = ring_wait_barrier(r, seq);
+    wait_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - wait_ns;
+    trace_rdma_ring_barrier_end(type, seq, wait_ns, ret);
+    return ret;
 }
 
 static bool ring_pop(RDMASendRing *r, RDMACmd *cmd)
@@ -2853,12 +2904,21 @@ static void ring_barrier_complete(RDMASendRing *r, unsigned seq)
 /* Consumer: sleep until the ring is non-empty or aborted. */
 static void ring_idle_wait(RDMASendRing *r)
 {
+    int64_t start_ns, idle_ns;
+
     qemu_mutex_lock(&r->wait_lock);
     r->consumer_waiting = true;
     smp_mb();                           /* pair with ring_wake_consumer() */
+    start_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    trace_rdma_consumer_idle_begin();
     while (ring_empty(r) && !r->abort) {
         qemu_cond_wait(&r->not_empty, &r->wait_lock);
     }
+    idle_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_ns;
+    trace_rdma_consumer_idle_end(idle_ns);
+    if ((uint64_t)idle_ns > r->idle_max_ns) {
+        r->idle_max_ns = idle_ns;
+    }
     r->consumer_waiting = false;
     qemu_mutex_unlock(&r->wait_lock);
 }
@@ -2876,6 +2936,7 @@ static int rdma_consumer_reg_stop(RDMAContext *rdma, uint64_t flags,
             return -1;
         }
         rdma_nbsent_stats_dump(rdma);
+        rdma_prodcons_stats_dump(rdma->send_ring);
     }
     return qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, errp);
 }
@@ -2886,6 +2947,9 @@ static int rdma_consumer_dispatch(RDMAContext *rdma, const RDMACmd *cmd,
     Error *err = NULL;
     int ret = 0;
 
+    trace_rdma_consumer_dispatch(cmd->type, cmd->block_index,
+                                 cmd->chunk_index, cmd->seq);
+
     switch (cmd->type) {
     case RDMA_CMD_WRITE:
         ret = qemu_rdma_write_chunk(rdma, cmd->block_index,
@@ -2919,6 +2983,7 @@ static void *rdma_consumer_thread(void *opaque)
     bool stop = false;
 
     rcu_register_thread();
+    trace_rdma_consumer_thread_start();
 
     while (!qatomic_read(&r->abort) && !stop) {
         RDMACmd cmd;
@@ -2950,6 +3015,7 @@ static void *rdma_consumer_thread(void *opaque)
         /* make the failure visible to the producer's rdma_errored() checks */
         rdma->errored = true;
     }
+    trace_rdma_consumer_thread_stop(qatomic_read(&r->abort));
     rcu_unregister_thread();
     return NULL;
 }
@@ -3363,6 +3429,13 @@ static void rdma_nbsent_stats_dump(RDMAContext *rdma)
                             rdma->nbsent_full_hits, rdma->nbsent_zero_hits);
 }
 
+/* Producer/consumer ring stats for the whole migration (consumer at FINISH). */
+static void rdma_prodcons_stats_dump(RDMASendRing *r)
+{
+    trace_rdma_prodcons_stats(r->idle_max_ns, r->pushwait_max_ns,
+                              r->pushwait_total_ns, r->occupancy_max);
+}
+
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
diff --git a/migration/trace-events b/migration/trace-events
index f8ed6a7250..833351a03f 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -246,6 +246,19 @@ rdma_write_flush(int sent) "sent total: %d"
 rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 rdma_post_send_queue_full(uint64_t wr_id, int sent) "send queue full, wr_id=%" PRIu64 ", outstanding writes=%d"
 rdma_nbsent_stats(uint64_t max, uint64_t posts, uint64_t full_hits, uint64_t zero_hits) "nb_sent max %" PRIu64 " posts %" PRIu64 " full-queue hits %" PRIu64 " drains to zero %" PRIu64
+rdma_consumer_dispatch(int type, uint32_t bidx, uint32_t cidx, uint32_t seq) "cmd type=%d block=%" PRIu32 " chunk=%" PRIu32 " seq=%" PRIu32
+rdma_ring_wake_producer(void) "waking blocked producer"
+rdma_ring_wake_consumer(void) "waking idle consumer"
+rdma_ring_push_begin(const char *type, uint32_t chunk_index) "push begin type=%s chunk_index=%" PRIu32
+rdma_ring_push_full_wait(int type, int64_t wait_ns) "push full-wait type=%d wait=%" PRId64 " ns"
+rdma_ring_barrier_begin(int type, uint32_t seq) "barrier begin type=%d seq=%" PRIu32
+rdma_ring_barrier_end(int type, uint32_t seq, int64_t wait_ns, int ret) "barrier end type=%d seq=%" PRIu32 " wait=%" PRId64 " ns ret=%d"
+rdma_consumer_thread_start(void) "consumer thread started"
+rdma_consumer_thread_stop(bool aborted) "consumer thread stopped, aborted=%d"
+rdma_consumer_idle_begin(void) "consumer idle: waiting for commands"
+rdma_consumer_idle_end(int64_t idle_ns) "consumer idle: woke after %" PRId64 " ns"
+rdma_ram_round_notify(uint32_t occupancy) "ram round notify: ring occupancy=%" PRIu32
+rdma_prodcons_stats(uint64_t idle_max, uint64_t pushwait_max, uint64_t pushwait_total, uint64_t occupancy_max) "idle max %" PRIu64 " ns, push full-wait max %" PRIu64 " ns total %" PRIu64 " ns, ring occupancy max %" PRIu64
 rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
-- 
2.39.5


