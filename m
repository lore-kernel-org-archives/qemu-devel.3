Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU8r-0005uz-Q0; Mon, 10 Nov 2025 10:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8q-0005re-A1
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8o-0000rT-Ig
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4Z1tFL1FBJQybM45OX2q6ObGdIa2Hwwgev/yb60mMs=;
 b=ieMWZEEAUBUKEKoy9Gmb/0uUjQYFxpXBbb2BTKmgCCVDlkXRiPoQRdP21MQYxGZeP/cbMR
 M99SASYJXrnoNt34lj3Lh1cWRapkvGhbhrZkIutyVNPm1qgQFYiYFSAAsC2oI8mEaWjTsh
 SfiCe9yluKXwy0M0UJeEPDHCeg/ozhI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-jB-BVaM9PGK4w4_M9awe_A-1; Mon, 10 Nov 2025 10:49:12 -0500
X-MC-Unique: jB-BVaM9PGK4w4_M9awe_A-1
X-Mimecast-MFC-AGG-ID: jB-BVaM9PGK4w4_M9awe_A_1762789751
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477771366cbso9862315e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789751; x=1763394551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4Z1tFL1FBJQybM45OX2q6ObGdIa2Hwwgev/yb60mMs=;
 b=BC5Y1Sl9mID6Wu+mCX+A5FtyetgEj0zivIeZeaNiXDe9rz9ZvxUR1tQ26l6vN+NsUC
 +pgKDPcPoU7g/bm9+Cf/TVFHCGEZYyv/yC+cZUmJH+C4PMOrtugajLLkt39xqwx9piJ8
 R1YV5b6G8hYJWNpy8y7B9fID0P5zLjlN81/wG0JDiu3igGuMuxk8kGJAp0ChsU6SlkS5
 VlEd3cdLBLjOblayVJDur3WZgsDv3zm6laLiTSwWBYUpIlowJ6GR52l3FHrVEYPc9kge
 bVYSfGNYmpkTYPumnkoBsHSzNrs9ULBK52dX3qAtFW2RIeplZ5ZSHQscV/UH4yBo/xNu
 sD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789751; x=1763394551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4Z1tFL1FBJQybM45OX2q6ObGdIa2Hwwgev/yb60mMs=;
 b=Ps3n7WMWqVN1DZN2A+J99mX1NWfYoFHmvhZqGqz8e5fF/SxPth3raCsecnfldlSk+H
 qaCt+9HyGtviUAXoa+i+dco9uYtmxI8oFBLxpmejLE60h+QGQCRBwu1JFS0DCbOKXpye
 nrLk4lSr/qxqTTdn+gN+eZIgX90hZAriTtraCC4PLG6ycvUzgTaJ+6fIy6owd5bVrihs
 7Y+RDH0ID9o9/sqt1q+W3mHdCvOv+f5lXzj/M5+XVl7SJJKTeoLyEK5bpk7auqbmpdPc
 Qa6J82KFKzykwBSbTn1W23zBi1riu41sf3GdqXkhr+dsX/2pNAvAVsc7Pq8csp5V+4my
 3c+A==
X-Gm-Message-State: AOJu0YzfjQIltVEIwYJsvXHqVoW6zTJkPTs5kVQ6NXwg3USWR+KAKZ/E
 qPVZvqQEstpqDqr4ywFGsYJCnriSQIFzfsBLMi0Lor/fa6SfDxqWmR/yr+El2xj/ZSG6HNnUXR3
 SKx/B+06EnHvzpyxxntlI+SvipoQYHXm7pw7hPck4amehkr6M3t/dLTIR
X-Gm-Gg: ASbGncu6+VA1thOuAv064/WdtSl7X3NUdKjSG6tOc59uyr0nxosiHc8L2t4a8Wwhegi
 foxUyA1TxzX9uI9CfKFo043yUT5njfFcGfqpWXdwLsoCyBWofbzJW9toHCe+drUl4n+YkutKv8j
 n31C9mQBEHbeP1sfgxBZlGkMoaQK0HzPvqq87s6XeKkfiW8TdWJykpZjY4scjxYgyftncOxkRgF
 iQHICW72hrgVydGp6T0Ii1W9rPZYdR/e7CqrO96C8pkl4EX2xYxstamkMRt1YHSTgHvMsxgYOzW
 UbhWoVnSzbzU67DQuZRh6J1lZlHiEivhHtroqIG2zmOXYLT3B3HbFHF3ANxvuJJJb1yRRDtQYhm
 TmLgJv/4iuiFJ+MSj231GN1IusSGJaDzSKsBJAH2PL0y0lpO732leXPos+Q==
X-Received: by 2002:a05:600c:4ecd:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-4777327c110mr76294895e9.22.1762789751014; 
 Mon, 10 Nov 2025 07:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKtTriYcA3TD9cazAT91fTSNcEad6mGbprJQniVFFySmu05jY53M7004+Ny/PXZd9i4wrUfg==
X-Received: by 2002:a05:600c:4ecd:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-4777327c110mr76294555e9.22.1762789750604; 
 Mon, 10 Nov 2025 07:49:10 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47761c2fe2asm270305485e9.5.2025.11.10.07.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:09 -0800 (PST)
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
Subject: [PATCH v2 02/19] =?UTF-8?q?rbd:=20Run=20co=20BH=20CB=20in=20the?=
 =?UTF-8?q?=20coroutine=E2=80=99s=20AioContext?=
Date: Mon, 10 Nov 2025 16:48:37 +0100
Message-ID: <20251110154854.151484-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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
2.51.1


