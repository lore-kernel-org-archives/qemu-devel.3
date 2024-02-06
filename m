Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD8FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNQ8-0000S1-HH; Tue, 06 Feb 2024 10:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXNPz-0000QU-Qw
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXNPm-0007BE-28
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707233473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUTV/wovauE7Tui+188fiXIF9jqKdUW/0L9A0Jj4GT4=;
 b=FK+A+7ZPckyZ9HWo96r2ViAHiHrloav/NGNVAVo3mr+F6zcyAFa/JswhWio2keBXXjAGFd
 B18tN3QVA87iBIxAz6hlZYjHPqqTzpAh6VSSvORp82jQ/0wx9CgccHBwwg2YYToPU/yT5C
 VaghpOyjjnmSnc2Y4XcCNIiHkIbF724=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Qhd7dZnqPuWKM1ztQ_9ZIQ-1; Tue, 06 Feb 2024 10:31:10 -0500
X-MC-Unique: Qhd7dZnqPuWKM1ztQ_9ZIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 420AF828CE9;
 Tue,  6 Feb 2024 15:31:10 +0000 (UTC)
Received: from localhost (unknown [10.39.195.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF232166B31;
 Tue,  6 Feb 2024 15:31:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 1/1] virtio-blk: avoid using ioeventfd state in irqfd
 conditional
Date: Tue,  6 Feb 2024 10:31:05 -0500
Message-ID: <20240206153105.81868-2-stefanha@redhat.com>
In-Reply-To: <20240206153105.81868-1-stefanha@redhat.com>
References: <20240206153105.81868-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Requests that complete in an IOThread use irqfd to notify the guest
while requests that complete in the main loop thread use the traditional
qdev irq code path. The reason for this conditional is that the irq code
path requires the BQL:

  if (s->ioeventfd_started && !s->ioeventfd_disabled) {
      virtio_notify_irqfd(vdev, req->vq);
  } else {
      virtio_notify(vdev, req->vq);
  }

There is a corner case where the conditional invokes the irq code path
instead of the irqfd code path:

  static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
  {
      ...
      /*
       * Set ->ioeventfd_started to false before draining so that host notifiers
       * are not detached/attached anymore.
       */
      s->ioeventfd_started = false;

      /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
      blk_drain(s->conf.conf.blk);

During blk_drain() the conditional produces the wrong result because
ioeventfd_started is false.

Use qemu_in_iothread() instead of checking the ioeventfd state.

Buglink: https://issues.redhat.com/browse/RHEL-15394
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20240122172625.415386-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 227d83569f..287c31ee3c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -64,7 +64,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->inhdr_undo);
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
-    if (s->ioeventfd_started && !s->ioeventfd_disabled) {
+    if (qemu_in_iothread()) {
         virtio_notify_irqfd(vdev, req->vq);
     } else {
         virtio_notify(vdev, req->vq);
-- 
2.43.0


