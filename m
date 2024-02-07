Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5383C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpuB-0007E9-35; Wed, 07 Feb 2024 16:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu9-0007BR-35
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu7-0007ff-MM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GLF3wa8P9xkb87QUi5+BupCGdFUx0NiGcKNyw5i1Qo=;
 b=A9+B7mOc0LfXmw2kNGlFhRoFTIE9P3FPqFUf1q08H9LfpjSvrhmB7+N6On1KUmtEYz+taB
 DwXdputpqOSBdU3hFndedYqmjjzDruAcabXKLHCUgG5xFawz6L1o+wazzKy/IhEyttIIkI
 9hdkL7B9cEJjnRfDAKwk3t2Pu5RVg4c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-CZEDogdCOCSS-1XeEANisQ-1; Wed,
 07 Feb 2024 16:56:23 -0500
X-MC-Unique: CZEDogdCOCSS-1XeEANisQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97BB338143B2;
 Wed,  7 Feb 2024 21:56:23 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE2F492BC6;
 Wed,  7 Feb 2024 21:56:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/16] virtio-blk: Use ioeventfd_attach in start_ioeventfd
Date: Wed,  7 Feb 2024 22:56:05 +0100
Message-ID: <20240207215606.206038-16-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit d3f6f294aeadd5f88caf0155e4360808c95b3146 ("virtio-blk: always set
ioeventfd during startup") has made virtio_blk_start_ioeventfd() always
kick the virtqueue (set the ioeventfd), regardless of whether the BB is
drained.  That is no longer necessary, because attaching the host
notifier will now set the ioeventfd, too; this happens either
immediately right here in virtio_blk_start_ioeventfd(), or later when
the drain ends, in virtio_blk_ioeventfd_attach().

With event_notifier_set() removed, the code becomes the same as the one
in virtio_blk_ioeventfd_attach(), so we can reuse that function.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20240202153158.788922-4-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index bda5c117d4..4ca5e632ea 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -37,6 +37,8 @@
 #include "hw/virtio/virtio-blk-common.h"
 #include "qemu/coroutine.h"
 
+static void virtio_blk_ioeventfd_attach(VirtIOBlock *s);
+
 static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
                                     VirtIOBlockReq *req)
 {
@@ -1847,17 +1849,14 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
     s->ioeventfd_started = true;
     smp_wmb(); /* paired with aio_notify_accept() on the read side */
 
-    /* Get this show started by hooking up our callbacks */
-    for (i = 0; i < nvqs; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        AioContext *ctx = s->vq_aio_context[i];
-
-        /* Kick right away to begin processing requests already in vring */
-        event_notifier_set(virtio_queue_get_host_notifier(vq));
-
-        if (!blk_in_drain(s->conf.conf.blk)) {
-            virtio_queue_aio_attach_host_notifier(vq, ctx);
-        }
+    /*
+     * Get this show started by hooking up our callbacks.  If drained now,
+     * virtio_blk_drained_end() will do this later.
+     * Attaching the notifier also kicks the virtqueues, processing any requests
+     * they may already have.
+     */
+    if (!blk_in_drain(s->conf.conf.blk)) {
+        virtio_blk_ioeventfd_attach(s);
     }
     return 0;
 
-- 
2.43.0


