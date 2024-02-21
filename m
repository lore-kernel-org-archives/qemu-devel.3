Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05EDC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcod3-0000NL-JR; Wed, 21 Feb 2024 10:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoZI-0000Kv-CL; Wed, 21 Feb 2024 10:31:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrq-0002GZ-Tn; Wed, 21 Feb 2024 03:22:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 271344F3D1;
 Wed, 21 Feb 2024 11:21:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E7E69860B0;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142044 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 19/60] virtio-blk: avoid using ioeventfd state in irqfd
 conditional
Date: Wed, 21 Feb 2024 11:20:07 +0300
Message-Id: <20240221082058.2141850-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-15394
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240122172625.415386-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit bfa36802d1704fc413c590ebdcc4e5ae0eacf439)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup for v8.2.0-809-g3cdaf3dd4a
 "virtio-blk: rename dataplane to ioeventfd")

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a1f8e15522..31aac14581 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -65,7 +65,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->inhdr_undo);
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
-    if (s->dataplane_started && !s->dataplane_disabled) {
+    if (qemu_in_iothread()) {
         virtio_blk_data_plane_notify(s->dataplane, req->vq);
     } else {
         virtio_notify(vdev, req->vq);
-- 
2.39.2


