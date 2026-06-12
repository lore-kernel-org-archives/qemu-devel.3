Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18424CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6fT-0003M7-AV; Fri, 12 Jun 2026 14:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4c34426bc906e19423e7e2389c419c2e972d9b9b@kylie.crudebyte.com>)
 id 1wY6fQ-0003LO-4i; Fri, 12 Jun 2026 14:31:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4c34426bc906e19423e7e2389c419c2e972d9b9b@kylie.crudebyte.com>)
 id 1wY6fN-00014u-W0; Fri, 12 Jun 2026 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=+XShxksSpz7jVIKWXrCLHZd5r7rA2GfVQktD6w9pGYI=; b=mB0CO
 0nmWuqvh7G+Lval3x2s8JW4NAlEE1SQXlwxBHU+PsfzCo+Fi5Nbm3H8lNv+YXZcg8OAyBIlHnKQfB
 ETVkeSPuAfV9/t4BFA8+UIxnAIPTyQvA5gUL8ytbiwaoaAdBd+Y0pYtWXjKY2BMlZE2J5m9aiKm9/
 ohzgXcL9OZPMjHS1VGU9e+6WGuCiM+xEDbdy/GhJPuF/ypRna04q2aI92/gC3EnBDKWMW/taNVwIg
 a1/j6Ppv0xYnHIKDuqyxx2nsixZBucIMCk2bRMxm2Z2DKh+BVBZAugcXAic2Jct2elG1OsKDfZ3xd
 BfMzP1cNRcy7GoxUsx6I753bxwNRPOXL/xiMK9TsNwWx+OQ5h2ZtsN/dv7VTdVzH3YS/YtgHOYKGK
 vea64lGg+Id1yC/Cy00ImGLWCw2GcTvorBcL+8NdJZez5m3jN0Os+TJpfWcOYdnc2nRAUam7p2PRl
 HVLiuBaDYArBdX5nsjTU6meu3g9SkmL9Ao2rPsZvDOX7e9gId9BJyFXoGdtlX0tLJSbH/Bj9bUGC7
 F620FCymSoUv/ScIx654YXH+YwMehTmgRXjNdbZno2yJWyktdjWbf6x9phmLWp8CnacvuTiT0aoeF
 yIiULXMekzdcsTYjz78Px4GYf0QRaT7CD1xQa+Js4lFfmOYNNTjXLUd3OrMzzA=;
Message-ID: <4c34426bc906e19423e7e2389c419c2e972d9b9b.1781287774.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 12 Jun 2026 20:22:52 +0200
Subject: [PATCH v2 2/8] 9pfs/virtio: implement msize_limit callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4c34426bc906e19423e7e2389c419c2e972d9b9b@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add and implement the msize_limit callback for the virtio transport.

This new callback function provides the theoretical maximum 'msize'
value supported by this virtio transport.

The limit is calculated as (VIRTQUEUE_MAX_SIZE - 2) * 4096 bytes,
where 2 virtio descriptors are lost exactly for:

  - 1 descriptor for the original request (typically being small)

  - 1 descriptor as indirect table pointer (when used), which just
    contains a pointer to the separate sglist containing the
    response's actual payload data

And 4096 bytes are assumed as standard page size used by Linux 9p
client. This results in a maximum 'msize' of 4186112 bytes.

Theoretically Linux client could support a much larger size, e.g. by
using multiple consecutive pages per sg entry / descriptor. However
that's currently not the case and unlikely to change any time soon.
And due to recent security issues, let's handle this limit
conservatively until really necessary to be raised.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 9f70e2338c..8c5d86cb66 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -192,12 +192,19 @@ static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     *pniov = elem->out_num;
 }
 
+static size_t virtio_9p_msize_limit(V9fsState *s)
+{
+    const size_t guestPageSize = 4096;
+    return (VIRTQUEUE_MAX_SIZE - 2) * guestPageSize;
+}
+
 static const V9fsTransport virtio_9p_transport = {
     .pdu_vmarshal = virtio_pdu_vmarshal,
     .pdu_vunmarshal = virtio_pdu_vunmarshal,
     .init_in_iov_from_pdu = virtio_init_in_iov_from_pdu,
     .init_out_iov_from_pdu = virtio_init_out_iov_from_pdu,
     .push_and_notify = virtio_9p_push_and_notify,
+    .msize_limit = virtio_9p_msize_limit,
 };
 
 static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.3


