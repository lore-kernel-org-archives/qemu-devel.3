Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C748C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaXH-0008OZ-94; Thu, 15 Aug 2024 09:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1seaXE-0008KB-Dq
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:29:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1seaX9-0003tr-AL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:28:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc5296e214so9743655ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723728534; x=1724333334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ir3vOTJ8856oDCx6T8Vm86uWI2GmKSFt+QMY+9u/Psc=;
 b=nAQ6ZlHh6Bsh+5UbT0aNVvZVZul2GT2917eP7ozbhpsUMLN6J477jHumvcbzkQuKDZ
 x/nOudUyuJjzkE+DhvFkxJiIQm4mm+Sb2JbohKZvALN95gTQ8DiWfNcXg7/bcn/bGRLM
 3FmKgAcjOUBccJxDqTlrf6o1VF3dVC7Sj311vBfDZPKZ2JzX/c75Bh2/ZL+CqKjzPv6O
 qoVBom2HqiUEosMRH8IEA++U14PyaKEl6LJs0iVcgktfq1Uac4CtdcZpoWPH2nKeRJ/0
 2DISVwZzKFWy05Cj+4gObpEfBZ1Q2HyDRGpVIZbhOgAEJMQnN6+am5uwI7O+wCADNbdH
 g7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723728534; x=1724333334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ir3vOTJ8856oDCx6T8Vm86uWI2GmKSFt+QMY+9u/Psc=;
 b=vmaNqG32oyNkvuqsW4Y9Mps470gm5Ba1UxV9uYys19WzQGaxLZsu3tqHTGUsyk0Y1L
 VD7iD3cLE3ufDPUY2KxbIeqaW0JrVYFK7gaPaGRGHKVYF9fdM9rmA3KMMbc3id/x6QSX
 htdSFGA3xU4o8uVjU0tmfL4jOzicYr84pxky93raqLAV59UF/2sdRRF3bz7AAjg+Uwhb
 bHeAUmYoO6/3+Nqe3axAVKnFF3gEEAnzM5YPz8QDh+Jq3q7V72eeYbxVueogSNuKZMfE
 2vNNXc5y4up07Z9jP7FfK/dUsaF+szSFXMFDl+Oj7aFZnmX5VLvb4dGT3lyCbYTt0chr
 YetQ==
X-Gm-Message-State: AOJu0Yx8Hk9ll/giZOhUb9+e1CUsmY5eWS9UzxQN2ZaBF7thtpYc/lrk
 0aB2bnSVioc8NCTyWeq326Sbue/hTQLn0mXsjmW3UVf/JOgrolbL1wB+A2dZ
X-Google-Smtp-Source: AGHT+IEUUn+1BgEazxzpB1Chnegwo6WsI19YUUFrqzxhJK8qvhBeVanLMg4upCQMAemyTvrHbTf5Mg==
X-Received: by 2002:a17:902:ecc3:b0:1f7:123e:2c6f with SMTP id
 d9443c01a7336-201d63dc3d1mr77519345ad.37.1723728533448; 
 Thu, 15 Aug 2024 06:28:53 -0700 (PDT)
Received: from wheely.local0.net (219-90-179-190.ip.adam.com.au.
 [219.90.179.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038b455sm10014055ad.214.2024.08.15.06.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:28:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 1/2] async: rework async event API for replay
Date: Thu, 15 Aug 2024 23:28:36 +1000
Message-ID: <20240815132838.615330-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815132838.615330-1-npiggin@gmail.com>
References: <20240815132838.615330-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Replace the functions replay_bh_schedule_event() and
replay_bh_schedule_oneshot_event() with qemu_bh_schedule_event() and
aio_bh_schedule_oneshot_event(), respectively.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/replay.rst   |  7 ++++---
 include/block/aio.h     | 35 +++++++++++++++++++++++++++++++----
 include/sysemu/replay.h |  2 +-
 block/block-backend.c   | 24 ++++++++++++++----------
 block/io.c              |  5 +++--
 block/iscsi.c           |  5 +++--
 block/nfs.c             | 10 ++++++----
 block/null.c            |  4 ++--
 block/nvme.c            |  8 +++++---
 hw/ide/core.c           |  5 +++--
 stubs/replay-tools.c    |  2 +-
 util/async.c            | 40 ++++++++++++++++++++++++++++++++++++++--
 12 files changed, 111 insertions(+), 36 deletions(-)

diff --git a/docs/devel/replay.rst b/docs/devel/replay.rst
index effd856f0c..ea1ee0a008 100644
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
index 4ee81936ed..23c5543506 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -285,17 +285,30 @@ void aio_context_unref(AioContext *ctx);
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
@@ -377,6 +390,20 @@ void aio_bh_call(QEMUBH *bh);
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
index 8102fa54f0..1fb66e4254 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -128,7 +128,7 @@ void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
 /* Adds oneshot bottom half event to the queue */
-void replay_bh_schedule_oneshot_event(AioContext *ctx,
+void replay_bh_oneshot_event(AioContext *ctx,
     QEMUBHFunc *cb, void *opaque);
 /*! Adds input event to the queue */
 void replay_input_event(QemuConsole *src, InputEvent *evt);
diff --git a/block/block-backend.c b/block/block-backend.c
index db6f9b92a3..a19a32030d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1533,8 +1533,8 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
     acb->blk = blk;
     acb->ret = ret;
 
-    replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                     error_callback_bh, acb);
+    aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                  error_callback_bh, acb, QEMU_CLOCK_VIRTUAL);
     return &acb->common;
 }
 
@@ -1591,8 +1591,9 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
@@ -1897,8 +1898,9 @@ BlockAIOCB *blk_aio_zone_report(BlockBackend *blk, int64_t offset,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
@@ -1938,8 +1940,9 @@ BlockAIOCB *blk_aio_zone_mgmt(BlockBackend *blk, BlockZoneOp op,
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
-                                         blk_aio_complete_bh, acb);
+        aio_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                      blk_aio_complete_bh, acb,
+                                      QEMU_CLOCK_VIRTUAL);
     }
 
     return &acb->common;
@@ -1977,8 +1980,9 @@ BlockAIOCB *blk_aio_zone_append(BlockBackend *blk, int64_t *offset,
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
index 301514c880..fcce071082 100644
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
index 979bf90cb7..98ed86b983 100644
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
index 0500f60c08..66d9df0d89 100644
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
index 4730acc1eb..d35b42cbb4 100644
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
index 3b588b139f..4069639dc7 100644
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
index 08d9218455..fa7fee61d9 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
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
diff --git a/stubs/replay-tools.c b/stubs/replay-tools.c
index 3e8ca3212d..31985af35f 100644
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
index 3e3e4fc712..97ed40048d 100644
--- a/util/async.c
+++ b/util/async.c
@@ -35,6 +35,7 @@
 #include "qemu/coroutine_int.h"
 #include "qemu/coroutine-tls.h"
 #include "sysemu/cpu-timers.h"
+#include "sysemu/replay.h"
 #include "trace.h"
 
 /***********************************************************/
@@ -125,8 +126,8 @@ static QEMUBH *aio_bh_dequeue(BHList *head, unsigned *flags)
     return bh;
 }
 
-void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
-                                  void *opaque, const char *name)
+static void do_aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
+                                            void *opaque, const char *name)
 {
     QEMUBH *bh;
     bh = g_new(QEMUBH, 1);
@@ -139,6 +140,24 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb,
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
@@ -225,6 +244,23 @@ int aio_bh_poll(AioContext *ctx)
     return ret;
 }
 
+void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type)
+{
+    switch (clock_type) {
+    case QEMU_CLOCK_VIRTUAL:
+    case QEMU_CLOCK_VIRTUAL_RT:
+        if (replay_mode != REPLAY_MODE_NONE) {
+            /* Record/replay must intercept bh events */
+            qatomic_fetch_or(&bh->flags, BH_REPLAY);
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


