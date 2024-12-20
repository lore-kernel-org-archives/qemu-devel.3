Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABCE7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaTL-000260-VS; Fri, 20 Dec 2024 05:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTE-0001xf-Gp; Fri, 20 Dec 2024 05:43:00 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTC-0005E7-3B; Fri, 20 Dec 2024 05:43:00 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so1387630a91.2; 
 Fri, 20 Dec 2024 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691376; x=1735296176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7UjIHOVv+OKh4Jj/WPmNrW7ybF61f5r2ui4Jn5w6rc=;
 b=eAfZ8oj1JI5QOaKdSP9jZA+pU4ZK2fm5QZIVdel+4sPtM9pDxuw+ClN3CFLQRuLwWJ
 VfQngWOyligW03Vq+xp0754O94JOH0xYzWZmf1+x4aZh6QmAjldheVVEHsoQfEcv2Goz
 Xu2loBFjLNqSG5aZM2KXfwMM9jBqRQKKe7rXHP49FJQYrX9Gl6jQl0lEfmjpL7F9j3fG
 2K/7zUpYQErNGFQQOH45KDUa+yJq1vRj2L0YKgljgKcm1jHlb6K9Ygl80s2zd+nvqJfi
 1qxtrADroIEXvgIqClFs5id7lVJ0vnoOZTFCbqOsa5gFV3Fdi3PgEIxJI/LjFPxeVXkJ
 /trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691376; x=1735296176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7UjIHOVv+OKh4Jj/WPmNrW7ybF61f5r2ui4Jn5w6rc=;
 b=r/sVQTPWEE3XbjGKAZPb/dHFwhGU3YNEm5HuRiUP5SaHJxM1NCIQi/K70iGd2Z0Iy/
 e8rXcJGBZg97rVgBGSbTgRC5wqbvc8ngfnG9xBPUXH7Mk3HI2dLfwyhBQkjjsgm9IsiH
 KhEGkOvkouiW3OnRpuRwjyn0G8oWQJfCzvGH70jr1Mq9IzVJFhqQXMxJ+Igvk0Z2Qt2B
 MyVC4Q3RQnn7zCwFio2DsK1MXvVPXZvR3z9f36jPueez0Xh/sqC9/ZbRkaDLOrleebwT
 1Kb8Xuu9ofMGH7TqD5rNUMuFltfl8Uq5SrzYHYae5djJJzD89oiyFzd9yA14aLrUIKvi
 +zPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzxBagxVmck8t+TG+rZRbOoVAqupXqnXvYATDPhcc7uWsFIzYgkcHE1hBOZWvPBo0SxHVjIz8cey3V@nongnu.org
X-Gm-Message-State: AOJu0Yx64PfN0nh95Z6SgA+rrJ42UudzrPsWjrLmWibBfYZgGek/giMX
 v1pcJ+RY0t4TwiUBTfUbLu2qjpDnnz+t5end4JPGDKlJhOGdW7AgtQyccg==
X-Gm-Gg: ASbGncsK8DN2sgfxYwBDcE1YwzU6tsDkeXfV+2pBAF4+1tivaM61Ux9Muts9Tn89/Yk
 aGcIYqPrHA2ZT0PxcDlcGxmr2j606FcGsowVtcAmg8UvqJioIEWmiwGg4YALhB0JUuR+TkeXYgX
 epJzF+quaG0BrGGP+L0K69aZEVFfkOdSVWuB4E+daojkKLvf6QOtPXrK8jLjWelT9xXUhEFmYDH
 Inn4CHkfRk8OiZGZok2qSWK40wS8vomLpafVxcxS0O5pd1ai6Ocpn1cVIA4AGEmcF2/3nAy0hEL
 cTtjQAQZ+Q==
X-Google-Smtp-Source: AGHT+IFpEO2mU3YazmwaSvwTXh5RjLvdXAy/gg0immkL7bGmAtb+tnPhxDRh5ieZbEDB5u8m3z1bpg==
X-Received: by 2002:a17:90b:2cc3:b0:2ee:693e:ed7c with SMTP id
 98e67ed59e1d1-2f452eeb5ffmr3909648a91.33.1734691376160; 
 Fri, 20 Dec 2024 02:42:56 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:42:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 03/17] async: rework async event API for replay
Date: Fri, 20 Dec 2024 20:42:05 +1000
Message-ID: <20241220104220.2007786-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the functions replay_bh_schedule_event() and
replay_bh_schedule_oneshot_event() with qemu_bh_schedule_event() and
aio_bh_schedule_oneshot_event(), respectively.

Direct API conversions use QEMU_CLOCK_VIRTUAL, because the virtual
clocks then go via the replay path when replay is enabled.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/replay.rst   |  7 ++++---
 include/block/aio.h     | 35 +++++++++++++++++++++++++++++++----
 include/sysemu/replay.h |  2 +-
 backends/rng-builtin.c  |  2 +-
 block/block-backend.c   | 24 ++++++++++++++----------
 block/io.c              |  5 +++--
 block/iscsi.c           |  5 +++--
 block/nfs.c             | 10 ++++++----
 block/null.c            |  4 ++--
 block/nvme.c            |  8 +++++---
 hw/ide/core.c           |  7 ++++---
 hw/net/virtio-net.c     | 14 +++++++-------
 replay/replay-events.c  |  2 +-
 stubs/replay-tools.c    |  2 +-
 util/async.c            | 39 +++++++++++++++++++++++++++++++++++++--
 15 files changed, 120 insertions(+), 46 deletions(-)

diff --git a/docs/devel/replay.rst b/docs/devel/replay.rst
index 40f58d9d4fc..ca816d87587 100644
--- a/docs/devel/replay.rst
+++ b/docs/devel/replay.rst
@@ -171,9 +171,10 @@ Bottom halves
 -------------
 
 Bottom half callbacks, that affect the guest state, should be invoked through
-``replay_bh_schedule_event`` or ``replay_bh_schedule_oneshot_event`` functions.
-Their invocations are saved in record mode and synchronized with the existing
-log in replay mode.
+``qemu_bh_schedule_event`` or ``aio_bh_schedule_oneshot_event`` functions
+the with the appropriate clock type (e.g., QEMU_CLOCK_VIRTUAL. Their
+invocations are saved in record mode and synchronized with the existing log in
+replay mode.
 
 Disk I/O events are completely deterministic in our model, because
 in both record and replay modes we start virtual machine from the same
diff --git a/include/block/aio.h b/include/block/aio.h
index 43883a8a33a..bc323b0d936 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -286,17 +286,30 @@ void aio_context_unref(AioContext *ctx);
  * @name: A human-readable identifier for debugging purposes.
  */
 void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
-                                  const char *name);
+                                  const char *name, QEMUClockType clock_type);
 
 /**
- * aio_bh_schedule_oneshot: Allocate a new bottom half structure that will run
- * only once and as soon as possible.
+ * aio_bh_schedule_oneshot_event: Allocate a new bottom half structure that
+ * will run only once and as soon as possible.
  *
  * A convenience wrapper for aio_bh_schedule_oneshot_full() that uses cb as the
  * name string.
  */
+#define aio_bh_schedule_oneshot_event(ctx, cb, opaque, clock_type) \
+    aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)), \
+                                 clock_type)
+
+/**
+ * aio_bh_schedule_oneshot: Allocate a new bottom half structure that will run
+ * only once and as soon as possible.
+ *
+ * A legacy wrapper for aio_bh_schedule_oneshot_event() that uses realtime
+ * as the clock type. Callers should specify the clock time in order to be
+ * compatible with record/replay.
+ */
 #define aio_bh_schedule_oneshot(ctx, cb, opaque) \
-    aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)))
+    aio_bh_schedule_oneshot_full((ctx), (cb), (opaque), (stringify(cb)), \
+                                 QEMU_CLOCK_REALTIME)
 
 /**
  * aio_bh_new_full: Allocate a new bottom half structure.
@@ -378,6 +391,20 @@ void aio_bh_call(QEMUBH *bh);
  */
 int aio_bh_poll(AioContext *ctx);
 
+/**
+ * qemu_bh_schedule_event: Schedule a bottom half.
+ *
+ * Scheduling a bottom half interrupts the main loop and causes the
+ * execution of the callback that was passed to qemu_bh_new.
+ *
+ * Bottom halves that are scheduled from a bottom half handler are instantly
+ * invoked.  This can create an infinite loop if a bottom half handler
+ * schedules itself.
+ *
+ * @bh: The bottom half to be scheduled.
+ */
+void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type);
+
 /**
  * qemu_bh_schedule: Schedule a bottom half.
  *
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index cba74fa9bce..30a7ae47518 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -126,7 +126,7 @@ void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
 /* Adds oneshot bottom half event to the queue */
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
+void replay_bh_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque);
 /*! Adds input event to the queue */
 void replay_input_event(QemuConsole *src, InputEvent *evt);
diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
index f367eb665cf..eef5c61f4f5 100644
--- a/backends/rng-builtin.c
+++ b/backends/rng-builtin.c
@@ -38,7 +38,7 @@ static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
 {
     RngBuiltin *s = RNG_BUILTIN(b);
 
-    replay_bh_schedule_event(s->bh);
+    qemu_bh_schedule_event(s->bh, QEMU_CLOCK_VIRTUAL);
 }
 
 static void rng_builtin_init(Object *obj)
diff --git a/block/block-backend.c b/block/block-backend.c
index 85bcdedcef6..2168729340d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1530,8 +1530,8 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
     acb->blk = blk;
     acb->ret = ret;
 
-    replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                     error_callback_bh, acb);
+    aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                  error_callback_bh, acb, QEMU_CLOCK_VIRTUAL);
     return &acb->common;
 }
 
@@ -1588,8 +1588,9 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
@@ -1894,8 +1895,9 @@ BlockAIOCB *blk_aio_zone_report(BlockBackend *blk, int64_t offset,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
@@ -1935,8 +1937,9 @@ BlockAIOCB *blk_aio_zone_mgmt(BlockBackend *blk, BlockZoneOp op,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
@@ -1974,8 +1977,9 @@ BlockAIOCB *blk_aio_zone_append(BlockBackend *blk, int64_t *offset,
     aio_co_enter(qemu_get_current_aio_context(), co);
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
diff --git a/block/io.c b/block/io.c
index 301514c8808..fcce0710824 100644
--- a/block/io.c
+++ b/block/io.c
@@ -335,8 +335,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
         bdrv_inc_in_flight(bs);
     }
 
-    replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
-                                     bdrv_co_drain_bh_cb, &data);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                  bdrv_co_drain_bh_cb, &data,
+                                  QEMU_CLOCK_VIRTUAL);
 
     qemu_coroutine_yield();
     /* If we are resumed from some other event (such as an aio completion or a
diff --git a/block/iscsi.c b/block/iscsi.c
index 979bf90cb79..98ed86b9831 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -285,8 +285,9 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
     }
 
     if (iTask->co) {
-        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
-                                         iscsi_co_generic_bh_cb, iTask);
+        aio_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
+                                      iscsi_co_generic_bh_cb, iTask,
+                                      QEMU_CLOCK_VIRTUAL);
     } else {
         iTask->complete = 1;
     }
diff --git a/block/nfs.c b/block/nfs.c
index 0500f60c08f..66d9df0d89b 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -256,8 +256,9 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+    aio_bh_schedule_oneshot_event(task->client->aio_context,
+                                  nfs_co_generic_bh_cb, task,
+                                  QEMU_CLOCK_VIRTUAL);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -723,8 +724,9 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+    aio_bh_schedule_oneshot_event(task->client->aio_context,
+                                  nfs_co_generic_bh_cb, task,
+                                  QEMU_CLOCK_VIRTUAL);
 }
 
 static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
diff --git a/block/null.c b/block/null.c
index 4730acc1eb2..d35b42cbb44 100644
--- a/block/null.c
+++ b/block/null.c
@@ -183,8 +183,8 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
         timer_mod_ns(&acb->timer,
                      qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + s->latency_ns);
     } else {
-        replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
-                                         null_bh_cb, acb);
+        aio_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
+                                      null_bh_cb, acb, QEMU_CLOCK_VIRTUAL);
     }
     return &acb->common;
 }
diff --git a/block/nvme.c b/block/nvme.c
index 3b588b139f6..4069639dc7a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -344,8 +344,9 @@ static void nvme_put_free_req_locked(NVMeQueuePair *q, NVMeRequest *req)
 static void nvme_wake_free_req_locked(NVMeQueuePair *q)
 {
     if (!qemu_co_queue_empty(&q->free_req_queue)) {
-        replay_bh_schedule_oneshot_event(q->s->aio_context,
-                nvme_free_req_queue_cb, q);
+        aio_bh_schedule_oneshot_event(q->s->aio_context,
+                                      nvme_free_req_queue_cb, q,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 }
 
@@ -1177,7 +1178,8 @@ static void nvme_rw_cb(void *opaque, int ret)
         /* The rw coroutine hasn't yielded, don't try to enter. */
         return;
     }
-    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
+    aio_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data,
+                                  QEMU_CLOCK_VIRTUAL);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 08d92184554..c527caf3d69 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -516,7 +516,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
 done:
     iocb->aiocb = NULL;
     if (iocb->bh) {
-        replay_bh_schedule_event(iocb->bh);
+        qemu_bh_schedule_event(iocb->bh, QEMU_CLOCK_VIRTUAL);
     }
 }
 
@@ -2368,8 +2368,9 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
             s = &bus->ifs[i];
             s->status |= BUSY_STAT;
         }
-        replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
-                                         ide_bus_perform_srst, bus);
+        aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                      ide_bus_perform_srst, bus,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     bus->cmd = val;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4fd1f9accab..ecbf274cb04 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -415,10 +415,10 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
 
         if (queue_started) {
             if (q->tx_timer) {
-                timer_mod(q->tx_timer,
-                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                timer_mod(q->tx_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                                       n->tx_timeout);
             } else {
-                replay_bh_schedule_event(q->tx_bh);
+                qemu_bh_schedule_event(q->tx_bh, QEMU_CLOCK_VIRTUAL);
             }
         } else {
             if (q->tx_timer) {
@@ -2705,7 +2705,7 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
          */
         virtio_queue_set_notification(q->tx_vq, 0);
         if (q->tx_bh) {
-            replay_bh_schedule_event(q->tx_bh);
+            qemu_bh_schedule_event(q->tx_bh, QEMU_CLOCK_VIRTUAL);
         } else {
             timer_mod(q->tx_timer,
                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
@@ -2871,7 +2871,7 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
     virtio_queue_set_notification(vq, 0);
-    replay_bh_schedule_event(q->tx_bh);
+    qemu_bh_schedule_event(q->tx_bh, QEMU_CLOCK_VIRTUAL);
 }
 
 static void virtio_net_tx_timer(void *opaque)
@@ -2954,7 +2954,7 @@ static void virtio_net_tx_bh(void *opaque)
     /* If we flush a full burst of packets, assume there are
      * more coming and immediately reschedule */
     if (ret >= n->tx_burst) {
-        replay_bh_schedule_event(q->tx_bh);
+        qemu_bh_schedule_event(q->tx_bh, QEMU_CLOCK_VIRTUAL);
         q->tx_waiting = 1;
         return;
     }
@@ -2968,7 +2968,7 @@ static void virtio_net_tx_bh(void *opaque)
         return;
     } else if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
-        replay_bh_schedule_event(q->tx_bh);
+        qemu_bh_schedule_event(q->tx_bh, QEMU_CLOCK_VIRTUAL);
         q->tx_waiting = 1;
     }
 }
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 2e46eda6bf8..d4b095b2097 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -131,7 +131,7 @@ void replay_bh_schedule_event(QEMUBH *bh)
     }
 }
 
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
+void replay_bh_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque)
 {
     if (events_enabled) {
diff --git a/stubs/replay-tools.c b/stubs/replay-tools.c
index 3e8ca3212d9..31985af35f7 100644
--- a/stubs/replay-tools.c
+++ b/stubs/replay-tools.c
@@ -30,7 +30,7 @@ void replay_bh_schedule_event(QEMUBH *bh)
     qemu_bh_schedule(bh);
 }
 
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
+void replay_bh_oneshot_event(AioContext *ctx,
      QEMUBHFunc *cb, void *opaque)
 {
     aio_bh_schedule_oneshot(ctx, cb, opaque);
diff --git a/util/async.c b/util/async.c
index 99db28389f6..b88083ecbe7 100644
--- a/util/async.c
+++ b/util/async.c
@@ -36,6 +36,7 @@
 #include "qemu/coroutine_int.h"
 #include "qemu/coroutine-tls.h"
 #include "sysemu/cpu-timers.h"
+#include "sysemu/replay.h"
 #include "trace.h"
 
 /***********************************************************/
@@ -126,8 +127,8 @@ static QEMUBH *aio_bh_dequeue(BHList *head, unsigned *flags)
     return bh;
 }
 
-void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
-                                  void *opaque, const char *name)
+static void do_aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
+                                            void *opaque, const char *name)
 {
     QEMUBH *bh;
     bh = g_new(QEMUBH, 1);
@@ -140,6 +141,24 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
     aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
 }
 
+void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
+                                  void *opaque, const char *name,
+                                  QEMUClockType clock_type)
+{
+    switch (clock_type) {
+    case QEMU_CLOCK_VIRTUAL:
+    case QEMU_CLOCK_VIRTUAL_RT:
+        if (replay_mode != REPLAY_MODE_NONE) {
+            /* Record/replay must intercept bh events */
+            replay_bh_oneshot_event(ctx, cb, opaque);
+            break;
+        }
+        /* fallthrough */
+    default:
+        do_aio_bh_schedule_oneshot_full(ctx, cb, opaque, name);
+    }
+}
+
 QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
                         const char *name, MemReentrancyGuard *reentrancy_guard)
 {
@@ -226,6 +245,22 @@ int aio_bh_poll(AioContext *ctx)
     return ret;
 }
 
+void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type)
+{
+    switch (clock_type) {
+    case QEMU_CLOCK_VIRTUAL:
+    case QEMU_CLOCK_VIRTUAL_RT:
+        if (replay_mode != REPLAY_MODE_NONE) {
+            /* Record/replay must intercept bh events */
+            replay_bh_schedule_event(bh);
+            break;
+        }
+        /* fallthrough */
+    default:
+        aio_bh_enqueue(bh, BH_SCHEDULED);
+    }
+}
+
 void qemu_bh_schedule_idle(QEMUBH *bh)
 {
     aio_bh_enqueue(bh, BH_SCHEDULED | BH_IDLE);
-- 
2.45.2


