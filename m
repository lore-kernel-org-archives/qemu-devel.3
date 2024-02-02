Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB9AC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvXD-00042Y-DG; Fri, 02 Feb 2024 10:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvXC-000421-6w
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVvXA-0000J2-QM
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706887972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+yEfgAn/4T2TbGdJTrV2cdbu8XKqQ9ProoQLlyE1HA=;
 b=af6bgshVp3iGNrzYHLJgJH5caDMVYpbGe51WwgwVsVNclAfdtg09RO1AhNYaDXkfy/RfE4
 SHjvXk1hgYNKjdmZNaf+TvQ527OBP7uevoTiaZ2fsQkgbpWBcz8DudZBIMftGKDSh4ZYTa
 cC8nQc0y8yPEN24+CWXC2X/1dSh3RKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-DA1TbELCPOKi2tEd2mkYeg-1; Fri, 02 Feb 2024 10:32:48 -0500
X-MC-Unique: DA1TbELCPOKi2tEd2mkYeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B39F85CBA3;
 Fri,  2 Feb 2024 15:32:48 +0000 (UTC)
Received: from localhost (unknown [10.39.194.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E566740C95AD;
 Fri,  2 Feb 2024 15:32:47 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 3/3] virtio-blk: Use ioeventfd_attach in start_ioeventfd
Date: Fri,  2 Feb 2024 16:31:58 +0100
Message-ID: <20240202153158.788922-4-hreitz@redhat.com>
In-Reply-To: <20240202153158.788922-1-hreitz@redhat.com>
References: <20240202153158.788922-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
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
---
 hw/block/virtio-blk.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 227d83569f..22b8eef69b 100644
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
@@ -1808,17 +1810,14 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
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


