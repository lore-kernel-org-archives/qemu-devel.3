Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6422CCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 22:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0obs-0005r4-9b; Mon, 22 Sep 2025 18:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obp-0005nl-CI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obn-0001u8-Gj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758578526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8pxt9v6z846eVxTQNs696Qb0T/nfnbXitLcSBp+icI=;
 b=LKs7MATkZ89O8/QK3+8vknNrDwvXScOJ9uoIJV2iu9qgbFpFFoMNLwVG6+/9qbW1uruSWE
 1RAOskgRkQB7I2MdXQEJmp3mTe+uZQlfPVwg5Jind5ZqrVh9eGwN4aJqZ+7A9cOJnQxdOm
 2EyC64Q0gMgCsP9TKj73WaofkvKIrC0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-nw7VmPm1Pcm-hl9yFnE2Lw-1; Mon,
 22 Sep 2025 18:02:03 -0400
X-MC-Unique: nw7VmPm1Pcm-hl9yFnE2Lw-1
X-Mimecast-MFC-AGG-ID: nw7VmPm1Pcm-hl9yFnE2Lw_1758578522
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CD481955F26; Mon, 22 Sep 2025 22:02:02 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1077D1800452; Mon, 22 Sep 2025 22:02:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 4/5] tests/libqos: extract qvirtqueue_set_avail_idx()
Date: Mon, 22 Sep 2025 18:01:48 -0400
Message-ID: <20250922220149.498967-5-stefanha@redhat.com>
In-Reply-To: <20250922220149.498967-1-stefanha@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Setting the vring's avail.idx can be useful for low-level VIRTIO tests,
especially for testing error scenarios with invalid vrings. Extract it
into a new function so that the next commit can add a test that uses
this new test API.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/libqos/virtio.h |  2 ++
 tests/qtest/libqos/virtio.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/virtio.h b/tests/qtest/libqos/virtio.h
index 7adc7cbd10..e238f1726f 100644
--- a/tests/qtest/libqos/virtio.h
+++ b/tests/qtest/libqos/virtio.h
@@ -143,6 +143,8 @@ uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
                         uint32_t len, bool write, bool next);
 uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
                                  QVRingIndirectDesc *indirect);
+void qvirtqueue_set_avail_idx(QTestState *qts, QVirtioDevice *d,
+                              QVirtQueue *vq, uint16_t idx);
 void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
                      uint32_t free_head);
 bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 5a709d0bc5..010ff40834 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -265,8 +265,9 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
 
     /* vq->avail->flags */
     qvirtio_writew(vq->vdev, qts, vq->avail, 0);
-    /* vq->avail->idx */
-    qvirtio_writew(vq->vdev, qts, vq->avail + 2, 0);
+
+    qvirtqueue_set_avail_idx(qts, vq->vdev, vq, 0);
+
     /* vq->avail->used_event */
     qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), 0);
 
@@ -388,6 +389,13 @@ uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
     return vq->free_head++; /* Return and increase, in this order */
 }
 
+void qvirtqueue_set_avail_idx(QTestState *qts, QVirtioDevice *d,
+                              QVirtQueue *vq, uint16_t idx)
+{
+    /* vq->avail->idx */
+    qvirtio_writew(d, qts, vq->avail + 2, idx);
+}
+
 void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
                      uint32_t free_head)
 {
@@ -400,8 +408,8 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
 
     /* vq->avail->ring[idx % vq->size] */
     qvirtio_writew(d, qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
-    /* vq->avail->idx */
-    qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
+
+    qvirtqueue_set_avail_idx(qts, d, vq, idx + 1);
 
     /* Must read after idx is updated */
     flags = qvirtio_readw(d, qts, vq->used);
-- 
2.51.0


