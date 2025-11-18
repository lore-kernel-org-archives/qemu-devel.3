Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEF3CEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6w-0008Vh-3I; Tue, 18 Nov 2025 12:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6r-0008TJ-DS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6p-0004hp-6N
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCvu3m6behBI0xlN37XmW3xr42QDpfreZQOlOAJmYQs=;
 b=YdeaRPSWC+Q0NAWDqnfN4u4p1DWOfoEx0gxcbiIUVZafNsqhlin1QTX8rEdwtA3z31G/db
 x8alDzIqXhXCxoAc5AwCzjSD1/glUnpmUgGUsoIGnlAGs5LvJImXH2Xl+nW4jpiO6GOqf6
 ouDVl0uN64nJ5O7JCJ5xpu47Fu/e3l4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-CPiYh4zRM7ybeNDlw6_XTQ-1; Tue,
 18 Nov 2025 12:03:12 -0500
X-MC-Unique: CPiYh4zRM7ybeNDlw6_XTQ-1
X-Mimecast-MFC-AGG-ID: CPiYh4zRM7ybeNDlw6_XTQ_1763485391
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E36919560A1; Tue, 18 Nov 2025 17:03:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E90EB300A88D; Tue, 18 Nov 2025 17:03:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 03/19] =?UTF-8?q?iscsi:=20Run=20co=20BH=20CB=20in=20the=20c?=
 =?UTF-8?q?oroutine=E2=80=99s=20AioContext?=
Date: Tue, 18 Nov 2025 18:02:40 +0100
Message-ID: <20251118170256.272087-4-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

For rbd (and others), as described in “rbd: Run co BH CB in the
coroutine’s AioContext”, the pattern of setting a completion flag and
waking a coroutine that yields while the flag is not set can only work
when both run in the same thread.

iscsi has the same pattern, but the details are a bit different:
iscsi_co_generic_cb() can (as far as I understand) only run through
iscsi_service(), not just from a random thread at a random time.
iscsi_service() in turn can only be run after iscsi_set_events() set up
an FD event handler, which is done in iscsi_co_wait_for_task().

As a result, iscsi_co_wait_for_task() will always yield exactly once,
because iscsi_co_generic_cb() can only run after iscsi_set_events(),
after the completion flag has already been checked, and the yielding
coroutine will then be woken only once the completion flag was set to
true.  So as far as I can tell, iscsi has no bug and already works fine.

Still, we don’t need the completion flag because we know we have to
yield exactly once, so we can drop it.  This simplifies the code and
makes it more obvious that the “rbd bug” isn’t present here.

This makes iscsi_co_generic_bh_cb() and iscsi_retry_timer_expired() a
bit boring, so at least the former we can drop and call aio_co_wake()
directly from scsi_co_generic_cb() to the same effect.  As for the
latter, the timer needs a CB, so we can’t drop it (I suppose we could
technically use aio_co_wake directly as the CB, but that would be
nasty), but we can put it into the coroutine’s AioContext to make its
aio_co_wake() a simple wrapper around qemu_coroutine_enter() without a
further BH indirection.

Finally, remove the iTask->co != NULL checks: This field is set by
iscsi_co_init_iscsitask(), which all users of IscsiTask run before even
setting up iscsi_co_generic_cb() as the callback, and it is never set or
cleared elsewhere, so it is impossible to not be set in
iscsi_co_generic_cb().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-4-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 56 +++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 15b96ee880..852ecccf0d 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -107,7 +107,6 @@ typedef struct IscsiLun {
 
 typedef struct IscsiTask {
     int status;
-    int complete;
     int retries;
     int do_retry;
     struct scsi_task *task;
@@ -180,21 +179,10 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
 
 #endif
 
-static void iscsi_co_generic_bh_cb(void *opaque)
-{
-    struct IscsiTask *iTask = opaque;
-
-    iTask->complete = 1;
-    aio_co_wake(iTask->co);
-}
-
 static void iscsi_retry_timer_expired(void *opaque)
 {
     struct IscsiTask *iTask = opaque;
-    iTask->complete = 1;
-    if (iTask->co) {
-        aio_co_wake(iTask->co);
-    }
+    aio_co_wake(iTask->co);
 }
 
 static inline unsigned exp_random(double mean)
@@ -239,6 +227,8 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 {
     struct IscsiTask *iTask = opaque;
     struct scsi_task *task = command_data;
+    IscsiLun *iscsilun = iTask->iscsilun;
+    AioContext *itask_ctx = qemu_coroutine_get_aio_context(iTask->co);
 
     iTask->status = status;
     iTask->do_retry = 0;
@@ -263,9 +253,9 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                              " (retry #%u in %u ms): %s",
                              iTask->retries, retry_time,
                              iscsi_get_error(iscsi));
-                aio_timer_init(iTask->iscsilun->aio_context,
-                               &iTask->retry_timer, QEMU_CLOCK_REALTIME,
-                               SCALE_MS, iscsi_retry_timer_expired, iTask);
+                aio_timer_init(itask_ctx, &iTask->retry_timer,
+                               QEMU_CLOCK_REALTIME, SCALE_MS,
+                               iscsi_retry_timer_expired, iTask);
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
@@ -284,12 +274,17 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
         }
     }
 
-    if (iTask->co) {
-        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
-                                         iscsi_co_generic_bh_cb, iTask);
-    } else {
-        iTask->complete = 1;
-    }
+    /*
+     * aio_co_wake() is safe to call: iscsi_service(), which called us, is only
+     * run from the event_timer and/or the FD handlers, never from the request
+     * coroutine.  The request coroutine in turn will yield unconditionally.
+     * We must release the lock, though, in case we enter the coroutine
+     * directly.  (Note that if do we enter the coroutine, iTask will probably
+     * be dangling once aio_co_wake() returns.)
+     */
+    qemu_mutex_unlock(&iscsilun->mutex);
+    aio_co_wake(iTask->co);
+    qemu_mutex_lock(&iscsilun->mutex);
 }
 
 static void coroutine_fn
@@ -592,12 +587,10 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
 static void coroutine_fn iscsi_co_wait_for_task(IscsiTask *iTask,
                                                 IscsiLun *iscsilun)
 {
-    while (!iTask->complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_set_events(iscsilun);
+    qemu_mutex_unlock(&iscsilun->mutex);
+    qemu_coroutine_yield();
+    qemu_mutex_lock(&iscsilun->mutex);
 }
 
 static int coroutine_fn
@@ -669,7 +662,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -740,7 +732,6 @@ retry:
             scsi_free_scsi_task(iTask.task);
             iTask.task = NULL;
         }
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -902,7 +893,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -940,7 +930,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -1184,7 +1173,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -1301,7 +1289,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -2390,7 +2377,6 @@ retry:
     iscsi_co_wait_for_task(&iscsi_task, dst_lun);
 
     if (iscsi_task.do_retry) {
-        iscsi_task.complete = 0;
         goto retry;
     }
 
-- 
2.51.1


