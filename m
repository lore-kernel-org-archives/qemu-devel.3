Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE7CCEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6v-0008VW-J9; Tue, 18 Nov 2025 12:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6r-0008TI-Ci
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6p-0004hy-KZ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBhYvMC67Yz7V5PNg7MV9AAPG5B0Oexzst2JFw7trkA=;
 b=PqSl8MVv42nlZWCwv/2TDagnxMuW1vjvsaNkPlBSHs+do9NqLUh2RfwOXcEs/N6N4lZzkC
 cM02MuZxc3WOSBo+21Q3fEVMb4GqGFUIAlXNwFOMRLROTnGwQ5Uf3897gKCTyDN2kW0ZZ4
 luxJ3LsLQv/xwLMSX97rjcYmGOZTt/Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-25nbrAgMOl2P_cqj1IZZOQ-1; Tue,
 18 Nov 2025 12:03:11 -0500
X-MC-Unique: 25nbrAgMOl2P_cqj1IZZOQ-1
X-Mimecast-MFC-AGG-ID: 25nbrAgMOl2P_cqj1IZZOQ_1763485389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 716BD1956068; Tue, 18 Nov 2025 17:03:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F643300A88D; Tue, 18 Nov 2025 17:03:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/19] =?UTF-8?q?rbd:=20Run=20co=20BH=20CB=20in=20the=20cor?=
 =?UTF-8?q?outine=E2=80=99s=20AioContext?=
Date: Tue, 18 Nov 2025 18:02:39 +0100
Message-ID: <20251118170256.272087-3-kwolf@redhat.com>
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

qemu_rbd_completion_cb() schedules the request completion code
(qemu_rbd_finish_bh()) to run in the BDS’s AioContext, assuming that
this is the same thread in which qemu_rbd_start_co() runs.

To explain, this is how both latter functions interact:

In qemu_rbd_start_co():

    while (!task.complete)
        qemu_coroutine_yield();

In qemu_rbd_finish_bh():

    task->complete = true;
    aio_co_wake(task->co); // task->co is qemu_rbd_start_co()

For this interaction to work reliably, both must run in the same thread
so that qemu_rbd_finish_bh() can only run once the coroutine yields.
Otherwise, finish_bh() may run before start_co() checks task.complete,
which will result in the latter seeing .complete as true immediately and
skipping the yield altogether, even though finish_bh() still wakes it.

With multiqueue, the BDS’s AioContext is not necessarily the thread
start_co() runs in, and so finish_bh() may be scheduled to run in a
different thread than start_co().  With the right timing, this will
cause the problems described above; waking a non-yielding coroutine is
not good, as can be reproduced by putting e.g. a usleep(100000) above
the while loop in start_co() (and using multiqueue), giving finish_bh()
a much better chance at exiting before start_co() can yield.

So instead of scheduling finish_bh() in the BDS’s AioContext, schedule
finish_bh() in task->co’s AioContext.

In addition, we can get rid of task.complete altogether because we will
get woken exactly once, when the task is indeed complete, no need to
check.

(We could go further and drop the BH, running aio_co_wake() directly in
qemu_rbd_completion_cb() because we are allowed to do that even if the
coroutine isn’t yet yielding and we’re in a different thread – but the
doc comment on qemu_rbd_completion_cb() says to be careful, so I decided
not to go so far here.)

Buglink: https://issues.redhat.com/browse/RHEL-67115
Reported-by: Junyao Zhao <junzhao@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-3-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 3611dc81cf..2a70b5a983 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -110,9 +110,7 @@ typedef struct BDRVRBDState {
 } BDRVRBDState;
 
 typedef struct RBDTask {
-    BlockDriverState *bs;
     Coroutine *co;
-    bool complete;
     int64_t ret;
 } RBDTask;
 
@@ -1309,7 +1307,6 @@ static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
 static void qemu_rbd_finish_bh(void *opaque)
 {
     RBDTask *task = opaque;
-    task->complete = true;
     aio_co_wake(task->co);
 }
 
@@ -1326,7 +1323,7 @@ static void qemu_rbd_completion_cb(rbd_completion_t c, RBDTask *task)
 {
     task->ret = rbd_aio_get_return_value(c);
     rbd_aio_release(c);
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(task->bs),
+    aio_bh_schedule_oneshot(qemu_coroutine_get_aio_context(task->co),
                             qemu_rbd_finish_bh, task);
 }
 
@@ -1338,7 +1335,7 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
                                           RBDAIOCmd cmd)
 {
     BDRVRBDState *s = bs->opaque;
-    RBDTask task = { .bs = bs, .co = qemu_coroutine_self() };
+    RBDTask task = { .co = qemu_coroutine_self() };
     rbd_completion_t c;
     int r;
 
@@ -1401,9 +1398,8 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
         return r;
     }
 
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    /* Expect exactly a single wake from qemu_rbd_finish_bh() */
+    qemu_coroutine_yield();
 
     if (task.ret < 0) {
         error_report("rbd request failed: cmd %d offset %" PRIu64 " bytes %"
-- 
2.51.1


