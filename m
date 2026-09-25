Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86EC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8Vz-0002Pf-LW; Fri, 25 Sep 2026 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dj-0007vG-6Q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:19 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitrii.omelchenko@ionos.com>)
 id 1xA8Dh-00060B-6c
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:52:18 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so6548965e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1790351536; x=1790956336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PEbTPI/qyKxqRmY+I5qxg6KvizpRcLX6eTefYNr+pp4=;
 b=QbRcjVxoULheVtHPe94enQ2c1U+2OFJpv5g+BytqSwL4vQuj9yHVsajhM4wDO0Jwp8
 cExFBBjTrxYzh1QcPfVF4dLz6tZqCK+npWkqWqXLiKxtCrNWtg0SrukGiwMQ27YPWnNV
 jl/7HIFEB8oaI6HuHX/L0cWCsNx/ZZZRmRoAYZWQjpR5Ko1nciIfG/km9DVvsXsDnoPp
 ppj7zf0wPC4wrslwsYAZaX3odBfGcZ2YM/BVxJIlK/b4KaAVUPYLYj/8xjM4/niBKeKg
 oNzdkGLAXg1QoCvzBMBeGn07W7OJPzTitEOLK0clCPThWkH3OCife/vZw2KvRsTc8Lt0
 yq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790351536; x=1790956336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PEbTPI/qyKxqRmY+I5qxg6KvizpRcLX6eTefYNr+pp4=;
 b=WW3nyM6UKa0bfqmL4IRlHItr8UpqXpb/wL2CMYL1xAhaApw1agMdPGLsesiknt11Ni
 We1SZCAJiTsOwxVdg+ZM6V+d+MAAgMEJ3MSceb7LQ+xqbcGEXEdSkFlwEmYAMCF5ehXs
 v5+4dxAq6vXW+S309DhujJR1WFp59NZsu9IxiODGYj6V8zhNJEO/7xZOT0V6EE9ecwVN
 MXtzGB0RMOE0cLHRmxCsNIuLJqUxB0O1Jjm8I5hdV0hZfgFYZCPBwKNuF3Ld6qqFyqDS
 p0zeXIlfAnW/zwljvGYHQW4EhSFellP2+P21q54iSIx2bSM1Il0fiFjF2mfjC9nWAYvm
 +eFA==
X-Gm-Message-State: AFuF++lhelBHuxYJNp/sa03zPAFwAAUwJlYEGMDXsj8Jv+g7Tgi/EOXS
 SRsFyBuLv2zN7FRxRpUTl3MwFchUyGb9vBneZjC/wVvmKybW3NnT40NOzHWg1Y3g7JWW6gyyd5+
 TtuWe/r7LQQ==
X-Gm-Gg: AYBFou3nI3rVu9ZPtPCKDROBjQKhJpdth/QYyJj4UoH0XyjHao48Ul2lTdmLGTTAOhf
 ntz0eyGIt1xxDdn0tmV5ZtF6/itxKBICnX+9Tac2N3iHm0hD3v+rAZEaJz7pxSTgmz+SpCVHRGs
 5ibOkxDz+tGEMMUHZhaNcKI9DRkMQYUv50zCnC5kcWkvwc6ZZZnDVXVKyS9v7ztSOv5Bw5DwiIG
 D7fK/TjzwudcL0na/j2Scl+/GPUNXDttXm8QBk6jgslH11OBCZ1lICq8tukyvi8WEincPq2NOZt
 f/L0wI3SjMz4+eUaw/nu5vTZTi1wGiPQL9DzbB6Y1K8sukKhYB++v+gOQirBc1/FvWsoXD4X/ZO
 f/8Lyc/RK4dSMrk07bxoIqyhHIfNllbd4jlDUXZbX+T7cdNUSOO/DPmMZ4SjA9Vtr7A6lA5nwJg
 WQSg8FLLewFfzuah1q479gDfqLtAb5SCuH7G3WIfi8UtXWL2vipOGKekWbz6nns04Q+GEEjkYA1
 IWuapAls5twAvSe0mFT1uryXK4VQD5X+uHTdaKBJg==
X-Received: by 2002:a05:600c:6986:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49fe66f147bmr108555135e9.18.1790351535869; 
 Fri, 25 Sep 2026 08:52:15 -0700 (PDT)
Received: from PF-5Z7P7F.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0f1f2e3sm112435875e9.0.2026.09.25.08.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:52:15 -0700 (PDT)
From: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
Subject: [RFC PATCH 09/13] migration/rdma: drain the send ring in batches
Date: Fri, 25 Sep 2026 17:51:44 +0200
Message-ID: <20260925155149.843870-10-dmitrii.omelchenko@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
References: <20260925155149.843870-1-dmitrii.omelchenko@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:31::11;
 envelope-from=dmitrii.omelchenko@ionos.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The consumer snapshots ring occupancy, processes up to
RDMA_CONSUMER_BATCH_MAX commands, and advances the tail once per batch
instead of once per command.

Signed-off-by: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>
---
 migration/rdma.c | 81 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 628afaccaf..db1f1e3fc6 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -67,6 +67,9 @@ static inline uint64_t rdma_merge_max(void)
 #define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
 #define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
 
+/* Max WRITE commands the consumer drains per pass. */
+#define RDMA_CONSUMER_BATCH_MAX 128
+
 #define RDMA_CONTROL_VERSION_CURRENT 1
 /*
  * Capabilities for negotiation.
@@ -2688,6 +2691,12 @@ static bool ring_empty(RDMASendRing *r)
     return (qatomic_load_acquire(&r->head) - r->tail) == 0;
 }
 
+/* Consumer-side count of published, unconsumed commands. */
+static unsigned ring_avail(RDMASendRing *r)
+{
+    return qatomic_load_acquire(&r->head) - r->tail;
+}
+
 /* Producer-side snapshot of queued-but-unprocessed commands in the ring. */
 static unsigned ring_occupancy(RDMAContext *rdma)
 {
@@ -2879,18 +2888,10 @@ static int ring_barrier(RDMAContext *rdma, RDMACmdType type, uint64_t flags,
     return ret;
 }
 
-static bool ring_pop(RDMASendRing *r, RDMACmd *cmd)
+/* Consumer: release n drained slots at once, waking a blocked producer once. */
+static void ring_advance_tail_by(RDMASendRing *r, unsigned n)
 {
-    if (ring_empty(r)) {
-        return false;
-    }
-    *cmd = r->ring[r->tail & RDMA_SEND_RING_MASK];   /* after load_acquire */
-    return true;
-}
-
-static void ring_advance_tail(RDMASendRing *r)
-{
-    qatomic_store_release(&r->tail, r->tail + 1);
+    qatomic_store_release(&r->tail, r->tail + n);
     ring_wake_producer(r);
 }
 
@@ -2986,29 +2987,63 @@ static void *rdma_consumer_thread(void *opaque)
     trace_rdma_consumer_thread_start();
 
     while (!qatomic_read(&r->abort) && !stop) {
-        RDMACmd cmd;
+        unsigned avail = ring_avail(r);
+        unsigned batch, processed = 0;
+
+        if (avail == 0) {
+            /*
+             * Ring empty: reap ready completions without blocking, then
+             * sleep until the next push so a new command wakes us at once.
+             * Round draining is handled by RDMA_CMD_FLUSH.
+             */
+            while (rdma->nb_sent > 0) {
+                uint64_t wr_id;
+
+                if (qemu_rdma_poll(rdma, rdma->send_cq, &wr_id, NULL) < 0) {
+                    ring_set_abort(rdma);
+                    break;
+                }
+                if (wr_id == RDMA_WRID_NONE) {
+                    break;              /* nothing more ready right now */
+                }
+            }
+            if (qatomic_read(&r->abort)) {
+                break;
+            }
+            ring_idle_wait(r);
+            continue;
+        }
+
+        /*
+         * Drain up to RDMA_CONSUMER_BATCH_MAX commands, or fewer if that is
+         * all that is queued, then publish tail once for the whole batch.
+         */
+        batch = avail < RDMA_CONSUMER_BATCH_MAX ? avail
+                                                : RDMA_CONSUMER_BATCH_MAX;
+
+        while (processed < batch) {
+            unsigned idx = r->tail + processed;
+            RDMACmd cmd = r->ring[idx & RDMA_SEND_RING_MASK];
 
-        if (ring_pop(r, &cmd)) {
             if (rdma_consumer_dispatch(rdma, &cmd, &stop) < 0) {
                 ring_set_abort(rdma);
                 break;
             }
+            processed++;
             if (cmd.seq) {
                 ring_barrier_complete(r, cmd.seq);
             }
-            ring_advance_tail(r);
-            continue;
-        }
-        if (rdma->nb_sent > 0) {
-            /* Ring empty but writes in flight: reap (bounded, error-aware). */
-            if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE,
-                                         NULL) < 0) {
-                ring_set_abort(rdma);
+            if (stop) {
                 break;
             }
-            continue;
         }
-        ring_idle_wait(r);
+
+        if (processed) {
+            ring_advance_tail_by(r, processed);
+        }
+        if (qatomic_read(&r->abort)) {
+            break;
+        }
     }
 
     if (qatomic_read(&r->abort)) {
-- 
2.39.5


