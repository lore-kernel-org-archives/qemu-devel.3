Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A1C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti97V-0004g2-OZ; Wed, 12 Feb 2025 04:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1ti97U-0004fk-17
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1ti97S-0002Mf-Ds
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739352801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dM4qgsIF6U4mDOzau3DxdvWZ8GDbkl7HhtwJP+9kAKI=;
 b=f7OkRuOziapXd4A4SeZSmptPOtDoWCIUsAhZXKSEY3feNqaYYtTUT5VfJAaLWnpWLcShKg
 3x8cSa3qleiMpJQ4KHgpujx+5/c6jYUzQJuFltkQdMLndNV5JGLQAJwv6+MWs7m5Sk7vLI
 mkvgX2S05PNdIGX419aL1s4aebRhdeQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-FsNp1KMbMW6kuRSBrn5r6Q-1; Wed, 12 Feb 2025 04:33:16 -0500
X-MC-Unique: FsNp1KMbMW6kuRSBrn5r6Q-1
X-Mimecast-MFC-AGG-ID: FsNp1KMbMW6kuRSBrn5r6Q
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-54502917fd6so2066670e87.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 01:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739352793; x=1739957593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dM4qgsIF6U4mDOzau3DxdvWZ8GDbkl7HhtwJP+9kAKI=;
 b=XiLjzlcTzD1PXOc4K4MLjtV5O/KJbbWpk6gBlCMpt78PEyiHJ2jHn3grAiCjyrVdPi
 lqPDBa9gFcbxI98qfmhnNtJzf4vob+6qBuYyWi96QStOJJsfbNoFf/OW8OZ/GxAf/ZqP
 7lecXUrRrc1NeaFPZokfzegmdAKG38RkehmnwwH7X4pNZMt6wH5eAmYeygzYjgaDdIEE
 ekeEJ6XMXHnolVm0htX+mV+C2orjigPzK4CaJul6eKG8m7ajY6aAnNzgrj0zuTjAaLMO
 vRt8/gh+9yHbhZswU0kKlKqGif1ySPGmw3fdXicQFM6aboGVYGjN1YkhQIyctt0CcNjH
 sGZQ==
X-Gm-Message-State: AOJu0Yyr2LLAPf3rVqULOzNgHQrAzmBr5dDbn4DbNROsmHi6lGeZWmNV
 5vtNE9QR1SAnlxJ59g3VSI1wka9WO5kkhcwZlngrpa/S9s4hv4K4bP6+x04pXhVfSzj1oJ8bHzz
 1mFrZZQJExPkvKDykUBU92sIejQXLiFihGXnp6zggPq3Etkiif0K9spjjcG6y
X-Gm-Gg: ASbGncuDKfS2FudK7FvTSEe/vM0isV8PcoMF4Bbz2b4xeoTJOxf473F5eWJmZ8PxDDV
 zunh5Y3DD+lU4J4MRQHe8xTk3wO2djnWbS5zJkg5zNUtKpggBU30+EGnOHtjfL0d1yaG0zq3Wu/
 /hgcusL/MCWJQw3WWcL5DDCCYo092AUQCmr4lOAIE391QBHkyEJR3X+xubW0LpyIcPDgSGALBYL
 nMGoWkm84Ow7I6EnfvkLIb2QWDv2fwZI0kuQdfb0viaP6o05mO+PyvnR2uzSkz4NAzUqNcXF5Oz
 wDZa+0GF3P3GU8VrvmLWCKMLeWdCZnaWzamdwQdpZBN2iOyRTH5+sRCnMD0y9Yo=
X-Received: by 2002:a05:6512:6d6:b0:545:ff1:bcd4 with SMTP id
 2adb3069b0e04-545180ea0d0mr981241e87.3.1739352793027; 
 Wed, 12 Feb 2025 01:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg7jKjS16TlpMz1PvpZDkXHnxfAzqdr8v9z22DRpTeZSkFFrEj9iRCSiaB+LS3bIq/WliV+g==
X-Received: by 2002:a05:600c:4e8d:b0:439:4a1f:cf8b with SMTP id
 5b1f17b1804b1-439580e73femr25127495e9.0.1739352765805; 
 Wed, 12 Feb 2025 01:32:45 -0800 (PST)
Received: from localhost
 (p200300cfd712443f6a1fdb8bc80f66e5.dip0.t-ipconnect.de.
 [2003:cf:d712:443f:6a1f:db8b:c80f:66e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd49d2cafsm11492165f8f.16.2025.02.12.01.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 01:32:44 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] block/rbd: Do not use BDS's AioContext
Date: Wed, 12 Feb 2025 10:32:38 +0100
Message-ID: <20250212093238.32312-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RBD schedules the request completion code (qemu_rbd_finish_bh()) to run
in the BDS's AioContext.  The intent seems to be to run it in the same
context that the original request coroutine ran in, i.e. the thread on
whose stack the RBDTask object exists (see qemu_rbd_start_co()).

However, with multiqueue, that thread is not necessarily the same as the
BDS's AioContext.  Instead, we need to remember the actual AioContext
and schedule the completion BH there.

Buglink: https://issues.redhat.com/browse/RHEL-67115
Reported-by: Junyao Zhao <junzhao@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
I think I could also drop RBDTask.ctx and just use
`qemu_coroutine_get_aio_context(RBDTask.co)` instead, but this is the
version of the patch that was tested and confirmed to fix the issue (I
don't have a local reproducer), so I thought I'll post this first.
---
 block/rbd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index af984fb7db..9d4e0817e0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -102,7 +102,7 @@ typedef struct BDRVRBDState {
 } BDRVRBDState;
 
 typedef struct RBDTask {
-    BlockDriverState *bs;
+    AioContext *ctx;
     Coroutine *co;
     bool complete;
     int64_t ret;
@@ -1269,8 +1269,7 @@ static void qemu_rbd_completion_cb(rbd_completion_t c, RBDTask *task)
 {
     task->ret = rbd_aio_get_return_value(c);
     rbd_aio_release(c);
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(task->bs),
-                            qemu_rbd_finish_bh, task);
+    aio_bh_schedule_oneshot(task->ctx, qemu_rbd_finish_bh, task);
 }
 
 static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
@@ -1281,7 +1280,10 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
                                           RBDAIOCmd cmd)
 {
     BDRVRBDState *s = bs->opaque;
-    RBDTask task = { .bs = bs, .co = qemu_coroutine_self() };
+    RBDTask task = {
+        .ctx = qemu_get_current_aio_context(),
+        .co = qemu_coroutine_self(),
+    };
     rbd_completion_t c;
     int r;
 
-- 
2.48.1


