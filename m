Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C22C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpuC-0007EO-4q; Wed, 07 Feb 2024 16:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpuA-0007CX-5U
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu8-0007fu-HB
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5hLZjXPLz2i52+WyQndxjGB7fi9mqlD8TwVgMsKkE4=;
 b=SwjqBSh3o+x3NqMEu2gXL92qbUJejme3IT6V5r20EDLrqUgwaYg6TtvyuPc/3EyzsbLmFT
 11Yv9DmdiyDYpuV7aJVasW/Qh+G14PRY1J97YMi1Tm3gehE4hHorhDU+OuofKV/m50YH1m
 1LpPrjklHLP42H6GmWbcw4KgdKsx0BI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-oEWy9C-dPea95u43nFg6Fg-1; Wed, 07 Feb 2024 16:56:24 -0500
X-MC-Unique: oEWy9C-dPea95u43nFg6Fg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6360E8F4126;
 Wed,  7 Feb 2024 21:56:24 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB172492BC6;
 Wed,  7 Feb 2024 21:56:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/16] virtio-blk: avoid using ioeventfd state in irqfd
 conditional
Date: Wed,  7 Feb 2024 22:56:06 +0100
Message-ID: <20240207215606.206038-17-kwolf@redhat.com>
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
 SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Message-ID: <20240122172625.415386-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4ca5e632ea..738cb2ac36 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -66,7 +66,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
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


