Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027A606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=Z9VaDfkX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOQJS-0007Dc-MW; Tue, 03 Nov 2026 21:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md1762E48BC8=lirongqing@baidu.com>)
 id 1xOQJQ-0007DD-7Y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 21:01:16 -0500
Received: from outbound.baidu.com ([180.76.5.236])
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md1762E48BC8=lirongqing@baidu.com>)
 id 1xOQJL-0003QP-L9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 21:01:15 -0500
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: <eperezma@redhat.com>, <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, <qemu-devel@nongnu.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio: Reset free_head on shadow virtqueue start
Date: Wed, 4 Nov 2026 10:00:53 +0800
Message-ID: <20261104020053.2548-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1793757662;
 bh=HmNXJnJakzF+agSM7PBFoIpbOPfctNHD2b33l/K7Q8o=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=Z9VaDfkX2kg2DsD+0nrJq4q7yf7hn8tAvGl0Ut+5tHFRFFLg78rWUe5FYnZc3kWhO
 6Gsr2dLqqz6U+ufev3gGMgEQy/joP2IWdhG11FOokbdDolNPY0rxAh2uzFcQpjw9Sn
 VegYmkctong493RB8BtXxSpIYDw+NSLOAeDaK/kzvuDQn7jwnsDHZba9+m5KVFwteP
 wkDnZ3VOIIBCM9kO46Wcw57fESp7rW5hFwddwIYdJrA/lORiOoN4eHJbhYJB4hzFVZ
 oQTwmpc0fBQXEOaJHOi1S4rXRQy/tmzZYvcToMJRgCBWxC80aZM77Ibtgp/jJxzmAt
 vOFYPDQLNCL8g==
Received-SPF: pass client-ip=180.76.5.236;
 envelope-from=prvs=md1762E48BC8=lirongqing@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Li RongQing <lirongqing@baidu.com>

free_head tracks the index of the next free descriptor in the SVQ
descriptor ring.  It is used by vhost_svq_vring_write_descs() to
choose where to place new descriptors, and is updated as descriptors
are allocated and recycled.

free_head is zero-initialized when the SVQ is created through
vhost_svq_new() (g_new0), but it is not reset in vhost_svq_start().
The start function already resets the rest of the ring state
(shadow_avail_idx, shadow_used_idx, last_used, last_used_idx and
num_free), yet free_head is left untouched.

Since an SVQ can be stopped and restarted on the same object, for
example across vDPA device migration or control virtqueue processing,
a stale free_head from the previous run survives into the new one.
This causes new descriptors to be written at the wrong position of
the SVQ descriptor ring, corrupting it.

Reset free_head to 0 in vhost_svq_start() so that descriptor
allocation always begins from the head of a fresh ring.

Fixes: 100890f7cad5 ("vhost: Shadow virtqueue buffers forwarding")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index c97bd9f..462c86d 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -857,6 +857,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->shadow_used_idx = 0;
     memset(&svq->batch_last, 0, sizeof(svq->batch_last));
     svq->last_used = 0;
+    svq->free_head = 0;
     svq->last_used_idx = 0;
     svq->vdev = vdev;
     svq->vq = vq;
-- 
2.9.4


