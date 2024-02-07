Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D41C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu2-00070G-9b; Wed, 07 Feb 2024 16:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu0-0006ye-UF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptz-0007cK-BM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDIzmmWE/ZB05/go2POBMcN6FbyjA18O7Soilm/47Zg=;
 b=YceXCv6/XpYm/Lk+T+I3d6vJSl41jKDy6H8gl2uj0lpqUlfIhLHD+ZN/ucRNOq0Jqmx2j/
 614i/DeiR66hhSLXe3NO29GC7I9spuamUXbK+Qlaes50u68JFBk4vBHMp3lRhuPoR5IcqW
 CZbmkHoOcfDskdifIBzDsWAhFkbN5PQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-6WX5j1NCOBOROVPL2k1TLw-1; Wed,
 07 Feb 2024 16:56:16 -0500
X-MC-Unique: 6WX5j1NCOBOROVPL2k1TLw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47AEA29AC00E;
 Wed,  7 Feb 2024 21:56:16 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF64F492BC6;
 Wed,  7 Feb 2024 21:56:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/16] scsi: Await request purging
Date: Wed,  7 Feb 2024 22:55:57 +0100
Message-ID: <20240207215606.206038-8-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

scsi_device_for_each_req_async() currently does not provide any way to
be awaited.  One of its callers is scsi_device_purge_requests(), which
therefore currently does not guarantee that all requests are fully
settled when it returns.

We want all requests to be settled, because scsi_device_purge_requests()
is called through the unrealize path, including the one invoked by
virtio_scsi_hotunplug() through qdev_simple_device_unplug_cb(), which
most likely assumes that all SCSI requests are done then.

In fact, scsi_device_purge_requests() already contains a blk_drain(),
but this will not fully await scsi_device_for_each_req_async(), only the
I/O requests it potentially cancels (not the non-I/O requests).
However, we can have scsi_device_for_each_req_async() increment the BB
in-flight counter, and have scsi_device_for_each_req_async_bh()
decrement it when it is done.  This way, the blk_drain() will fully
await all SCSI requests to be purged.

This also removes the need for scsi_device_for_each_req_async_bh() to
double-check the current context and potentially re-schedule itself,
should it now differ from the BB's context: Changing a BB's AioContext
with a root node is done through bdrv_try_change_aio_context(), which
creates a drained section.  With this patch, we keep the BB in-flight
counter elevated throughout, so we know the BB's context cannot change.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20240202144755.671354-3-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-bus.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 0a2eb11c56..230313022c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -120,17 +120,13 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
     SCSIRequest *next;
 
     /*
-     * If the AioContext changed before this BH was called then reschedule into
-     * the new AioContext before accessing ->requests. This can happen when
-     * scsi_device_for_each_req_async() is called and then the AioContext is
-     * changed before BHs are run.
+     * The BB cannot have changed contexts between this BH being scheduled and
+     * now: BBs' AioContexts, when they have a node attached, can only be
+     * changed via bdrv_try_change_aio_context(), in a drained section.  While
+     * we have the in-flight counter incremented, that drain must block.
      */
     ctx = blk_get_aio_context(s->conf.blk);
-    if (ctx != qemu_get_current_aio_context()) {
-        aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh,
-                                g_steal_pointer(&data));
-        return;
-    }
+    assert(ctx == qemu_get_current_aio_context());
 
     QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
         data->fn(req, data->fn_opaque);
@@ -138,11 +134,16 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
 
     /* Drop the reference taken by scsi_device_for_each_req_async() */
     object_unref(OBJECT(s));
+
+    /* Paired with blk_inc_in_flight() in scsi_device_for_each_req_async() */
+    blk_dec_in_flight(s->conf.blk);
 }
 
 /*
  * Schedule @fn() to be invoked for each enqueued request in device @s. @fn()
  * runs in the AioContext that is executing the request.
+ * Keeps the BlockBackend's in-flight counter incremented until everything is
+ * done, so draining it will settle all scheduled @fn() calls.
  */
 static void scsi_device_for_each_req_async(SCSIDevice *s,
                                            void (*fn)(SCSIRequest *, void *),
@@ -163,6 +164,8 @@ static void scsi_device_for_each_req_async(SCSIDevice *s,
      */
     object_ref(OBJECT(s));
 
+    /* Paired with blk_dec_in_flight() in scsi_device_for_each_req_async_bh() */
+    blk_inc_in_flight(s->conf.blk);
     aio_bh_schedule_oneshot(blk_get_aio_context(s->conf.blk),
                             scsi_device_for_each_req_async_bh,
                             data);
@@ -1728,11 +1731,20 @@ static void scsi_device_purge_one_req(SCSIRequest *req, void *opaque)
     scsi_req_cancel_async(req, NULL);
 }
 
+/**
+ * Cancel all requests, and block until they are deleted.
+ */
 void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
 {
     scsi_device_for_each_req_async(sdev, scsi_device_purge_one_req, NULL);
 
+    /*
+     * Await all the scsi_device_purge_one_req() calls scheduled by
+     * scsi_device_for_each_req_async(), and all I/O requests that were
+     * cancelled this way, but may still take a bit of time to settle.
+     */
     blk_drain(sdev->conf.blk);
+
     scsi_device_set_ua(sdev, sense);
 }
 
-- 
2.43.0


