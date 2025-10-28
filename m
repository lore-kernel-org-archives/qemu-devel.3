Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621B4CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeD-000831-Mb; Tue, 28 Oct 2025 12:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme6-00081Z-HR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme2-0003VR-CP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR8MtG0BVWnvKf6Erh8dGKDS/UGOnXD1GBQG6hP9q5w=;
 b=cQZDziNCxPtXaUWZM6Syxd6bgPob7st1G7avoDjot5BaEQHXldg6Pu0jn6mvdcVEJyNe50
 m7nF/mCNpDWcNFU2FKE/O9nfEDJkH7IOwH0Vuq+vZYAuUFBbQHT7plZEQt0T5baZoY5u1n
 xWpk8bZgOgO643tMihJEhhDetXy6uwk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-ow11Hb1lNDuv-T3T3hluew-1; Tue, 28 Oct 2025 12:33:56 -0400
X-MC-Unique: ow11Hb1lNDuv-T3T3hluew-1
X-Mimecast-MFC-AGG-ID: ow11Hb1lNDuv-T3T3hluew_1761669236
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4278c82dce6so3733954f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669235; x=1762274035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gR8MtG0BVWnvKf6Erh8dGKDS/UGOnXD1GBQG6hP9q5w=;
 b=nErrNqI9x9uUx+bg6+bpZ5wsJVpV1hHYKltO2BiOXZV89aa4ovT+Rgx8EQIykiMmd8
 zvNtUq8eDKeRH8ctMyZLqarmOmft10+NGGHU91eJm4IsGgtCJL2kF6oxEdiT742X6dum
 SLwXFM4/iEjdp8okS9LpkUFfXEdLqynWGc0jWOTns6B9JPo4yG60cnru1uDaq02zrMsO
 66WoRA3Zoqqf8j/HnGWfrn0tk/srjDU66/T9mEsRpyOABahM1XUdGF1yJkNxWPwEWeHU
 3B6BQilaufJ8TE4Yyg3n4xMrUyskdJC/yRdzeN9N2QJ0jr0PawyEmvbPZvUl2GH8J6I3
 bqvw==
X-Gm-Message-State: AOJu0Yzq9j/Wszb5giD9xaliJEuQs9hNflxbdtI29juFvgYiwMaTN3C+
 HMsWvRlhg8cEviG41MxtTehGwai+MD7n/vEKTn/kUM2RjhGrKKh8sIKeYYzyCdHnRPDLkGFzQbD
 fvR/AQFE4hRhhIE7e87pzqQq+6GXAxNz6yXZkwCl4DPs6g2ZSYJXYtHcO
X-Gm-Gg: ASbGncuRI33GtYl38QxQNpTeRJ9z6jr8r/uf4Tgw+IvIaMy09Hjkipu7/pwztmNNfn7
 uVYiSqgpvDmB/nCvRcbW7ko80LVk3MObu2pr3bgEbSNfviZL+xTqaDvSCHzcoG1rI2DwE98kwMr
 xvsbEZAWVrtm3GSOo6VosxRFxVt0e2hexo+bTuV0dNn5YvUhNYGJ/05FT1PVT862mugCdWQtgQS
 nBuDxbJnlCEA8x6Znx2jEJhrzVyidiyZIu+fPKwYqRwNzX0+xACSdXcIGMtM1rtyC9JS5Zwo6qe
 WsMoCv5WIjOkUjXqvqSDi9jtIiTRY9/CO04c1GEMLNEpJgyUx0kt536Dt3Y3bl0zbJkX36hEErz
 7jB6tBfUv/NLR/yGS4zVJ34e8LxOap7eRdj9dwh0It17rbrGkOb/Vy7lm+A==
X-Received: by 2002:a05:6000:402b:b0:429:8b01:c08c with SMTP id
 ffacd0b85a97d-429a7e52ea1mr3155744f8f.19.1761669235570; 
 Tue, 28 Oct 2025 09:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6M7Yv6zGU7DNnVtewoLK9lznqHNtdYpMEEzLg+qT4xsSVy9OH17HuM5lRCpvl5ud6a7S0vw==
X-Received: by 2002:a05:6000:402b:b0:429:8b01:c08c with SMTP id
 ffacd0b85a97d-429a7e52ea1mr3155713f8f.19.1761669235052; 
 Tue, 28 Oct 2025 09:33:55 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7a94sm25114579f8f.5.2025.10.28.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:33:53 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 02/16] =?UTF-8?q?rbd:=20Run=20co=20BH=20CB=20in=20the=20co?=
 =?UTF-8?q?routine=E2=80=99s=20AioContext?=
Date: Tue, 28 Oct 2025 17:33:28 +0100
Message-ID: <20251028163343.116249-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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
2.51.0


