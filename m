Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE8AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxy8-0003IN-GP; Fri, 01 Mar 2024 03:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxy5-0003Hh-D2
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxy2-0006lA-NO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709280606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTEFAo3xmxDm8Q3byKcEbCr6cTkdhZCw58j4909TGwM=;
 b=YxmS+BHroRZ2x8phXqnmf2xmjm3xNoCYDaxfe2h4MbLHESiCX+T3zBpFycld/75UX1qFIZ
 YnVQ3f8fKpTGyZE8mJlh5iaMfXg7JFwdPrjpDgG/Ar9pWWC7qeRIFt6qIPCJxdxa91MqXw
 qzkGbGPpWiBLlrRHc+ZqaaHcUAgjI5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Zh0qmV8QPy-n6sEFvy7LIw-1; Fri, 01 Mar 2024 03:09:58 -0500
X-MC-Unique: Zh0qmV8QPy-n6sEFvy7LIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4246848C21;
 Fri,  1 Mar 2024 08:09:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F42D2015B7D;
 Fri,  1 Mar 2024 08:09:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/6] libqos/virtio.c: fix 'avail_event' offset in qvring_init()
Date: Fri,  1 Mar 2024 09:09:49 +0100
Message-ID: <20240301080953.66448-3-thuth@redhat.com>
In-Reply-To: <20240301080953.66448-1-thuth@redhat.com>
References: <20240301080953.66448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

In qvring_init() we're writing vq->used->avail_event at "vq->used + 2 +
array_size".  The struct pointed by vq->used is, from virtio_ring.h
Linux header):

 *	// A ring of used descriptor heads with free-running index.
 *	__virtio16 used_flags;
 *	__virtio16 used_idx;
 *	struct vring_used_elem used[num];
 *	__virtio16 avail_event_idx;

So 'flags' is the word right at vq->used. 'idx' is vq->used + 2. We need
to skip 'used_idx' by adding + 2 bytes, and then sum the vector size, to
reach avail_event_idx. An example on how to properly access this field
can be found in qvirtqueue_kick():

avail_event = qvirtio_readw(d, qts, vq->used + 4 +
                            sizeof(struct vring_used_elem) * vq->size);

This error was detected when enabling the RISC-V 'virt' libqos machine.
The 'idx' test from vhost-user-blk-test.c errors out with a timeout in
qvirtio_wait_used_elem(). The timeout happens because when processing
the first element, 'avail_event' is read in qvirtqueue_kick() as non-zero
because we didn't initialize it properly (and the memory at that point
happened to be non-zero). 'idx' is 0.

All of this makes this condition fail because "idx - avail_event" will
overflow and be non-zero:

/* < 1 because we add elements to avail queue one by one */
if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
                        (!vq->event || (uint16_t)(idx-avail_event) < 1)) {
    d->bus->virtqueue_kick(d, vq);
}

As a result the virtqueue is never kicked and we'll timeout waiting for it.

Fixes: 1053587c3f ("libqos: Added EVENT_IDX support")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240217192607.32565-3-dbarboza@ventanamicro.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 4f39124eba..82a6e122bf 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -265,7 +265,7 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
     /* vq->used->idx */
     qvirtio_writew(vq->vdev, qts, vq->used + 2, 0);
     /* vq->used->avail_event */
-    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
+    qvirtio_writew(vq->vdev, qts, vq->used + 4 +
                    sizeof(struct vring_used_elem) * vq->size, 0);
 }
 
-- 
2.44.0


