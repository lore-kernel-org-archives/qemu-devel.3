Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E505C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuqV-00076Y-CO; Fri, 02 Feb 2024 09:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVuqP-00074J-OD
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVuqK-0002of-JB
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706885315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6akKXCXv6EsoFlkIsJ766ksyO2x05Vult6oh9xmylrY=;
 b=a0b3Um5PY5IMmF4KC18e9r2jsdlmJtcyNfhNvcxlbXg6HqF/E/n1gagw4+Nta3LdrTN8S6
 /iM7M2uNC3BtyyMko8sma7HLxkbtG91UFp19tYc7boWpZg59nmbhWWX6tWM5SSOyiPtCYb
 qYaDaJcgHSWiHFRapUXfDV7G6FsjDI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-diSlojs9MLGyqGEMRXqDRw-1; Fri,
 02 Feb 2024 09:48:33 -0500
X-MC-Unique: diSlojs9MLGyqGEMRXqDRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A98DD2820B88;
 Fri,  2 Feb 2024 14:48:30 +0000 (UTC)
Received: from localhost (unknown [10.39.194.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5318B2166B33;
 Fri,  2 Feb 2024 14:48:30 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 2/2] scsi: Await request purging
Date: Fri,  2 Feb 2024 15:47:55 +0100
Message-ID: <20240202144755.671354-3-hreitz@redhat.com>
In-Reply-To: <20240202144755.671354-1-hreitz@redhat.com>
References: <20240202144755.671354-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


