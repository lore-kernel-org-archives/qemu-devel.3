Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F6AC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu2-0006zx-4L; Wed, 07 Feb 2024 16:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpty-0006vm-Ar
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptw-0007b8-4t
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ulCP5y1bPV8WD14M42aT1AWi4MtKmD+olFOV6aACBU=;
 b=beBGTWl8RtHDENHfL/pf9OAi1NS0gZW0aghrtSnqZ8mux4jIDdFy1B6tvKEV4d9PWy9Kp8
 B0VdgYqJvi/VCK+9kRHd/mqjzqi+8PPX2iH5a0irMu95hi3tyMY/VG5YYsj7keDAQl+E9H
 Q9lN7FnoY3Q6ysU6REhl8zSBJS8tM6Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-MmW3uiGkO66nrsAXKpVFHg-1; Wed, 07 Feb 2024 16:56:12 -0500
X-MC-Unique: MmW3uiGkO66nrsAXKpVFHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 219B684AE41;
 Wed,  7 Feb 2024 21:56:12 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87E13492BC7;
 Wed,  7 Feb 2024 21:56:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/16] virtio-blk: add vq_rq[] bounds check in
 virtio_blk_dma_restart_cb()
Date: Wed,  7 Feb 2024 22:55:53 +0100
Message-ID: <20240207215606.206038-4-kwolf@redhat.com>
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

Hanna Czenczek <hreitz@redhat.com> noted that the array index in
virtio_blk_dma_restart_cb() is not bounds-checked:

  g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
  ...
  while (rq) {
      VirtIOBlockReq *next = rq->next;
      uint16_t idx = virtio_get_queue_index(rq->vq);

      rq->next = vq_rq[idx];
                 ^^^^^^^^^^

The code is correct because both rq->vq and vq_rq[] depend on
num_queues, but this is indirect and not 100% obvious. Add an assertion.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240206190610.107963-4-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index e430ba583c..31212506ca 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1209,6 +1209,8 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
         VirtIOBlockReq *next = rq->next;
         uint16_t idx = virtio_get_queue_index(rq->vq);
 
+        /* Only num_queues vqs were created so vq_rq[idx] is within bounds */
+        assert(idx < num_queues);
         rq->next = vq_rq[idx];
         vq_rq[idx] = rq;
         rq = next;
-- 
2.43.0


