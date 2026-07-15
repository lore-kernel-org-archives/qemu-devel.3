Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B0FC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjy8c-0000Np-L1; Wed, 15 Jul 2026 07:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wjy8a-0000NJ-SS
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 07:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wjy8Y-0006IH-TZ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 07:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784116250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iBkS4SONdzYHjteBaBsxoOo8C76vZJfa+IvjxQCZ5j4=;
 b=bWQq7S8T6KQzSfSNirTv/J6OHbvCWQ6zmWwxeNqWGV8HOAxfTVW+LV0Z6QYCTrtBIBZ7l9
 uO7nKkMnlMDMIc+Mn6FVBMPxeJkdQF18Mb+JJxTIt4o26mtqnyHhCW8LUkbiYa21++EqUs
 ski7Xys+i1sTFgoR+Q6HHwsGnFSRnu0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-mKQd3PWuNka5h6HJBh8dTA-1; Wed,
 15 Jul 2026 07:50:45 -0400
X-MC-Unique: mKQd3PWuNka5h6HJBh8dTA-1
X-Mimecast-MFC-AGG-ID: mKQd3PWuNka5h6HJBh8dTA_1784116244
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E754C1956061; Wed, 15 Jul 2026 11:50:43 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30A32180036E; Wed, 15 Jul 2026 11:50:41 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 jasowangio@gmail.com, qemu-stable@nongnu.org
Subject: [PATCH] hw/virtio: reject zero-length packed indirect descriptor table
Date: Wed, 15 Jul 2026 13:50:40 +0200
Message-ID: <20260715115040.2186274-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The split-ring path already rejects a zero-length indirect descriptor
table since commit 7423192912af ("virtio: add checks for the size of
the indirect table"). The packed-ring path is missing the same check,
allowing a guest to trigger an assertion in address_space_cache_init()
with a packed indirect descriptor that has len=0.

Add the same !desc.len check to the packed-ring indirect validation
in both virtqueue_packed_get_avail_bytes() and virtqueue_packed_pop().

Fixes: 86044b24e865 ("virtio: basic packed virtqueue support")
Cc: jasowangio@gmail.com
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3984
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a365530..1b86c7f41fa8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1475,7 +1475,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
         }
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingPackedDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -1927,7 +1927,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
     id = desc.id;
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingPackedDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
2.54.0


