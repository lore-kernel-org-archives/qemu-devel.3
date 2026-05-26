Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5559ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRu2o-0004EE-4x; Tue, 26 May 2026 11:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRu2m-0004AO-Dr
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRu2j-00012P-DO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779810607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1qEl1OZmTnlLK0noGKjdEgn6K16qJWjoPhXb8McoxmA=;
 b=aYgR2RRtIUDvw/hzhHlmupc5qJ9xYmAwK8mWo0bFFreQfC3920ZiB4Lhbev0FoOTcCWTCe
 b5CnUv+alDOgQ4DK4SrANYO+BQe5y6atM+KWiVsq+tlv2+AhMh/84AcbC/5ayZmt7n1C+V
 1O9MXF+QMEuK3ORLIWaCuz+wJT2wW68=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-rkJkL7D2MWaHOHBVEO4guw-1; Tue,
 26 May 2026 11:50:03 -0400
X-MC-Unique: rkJkL7D2MWaHOHBVEO4guw-1
X-Mimecast-MFC-AGG-ID: rkJkL7D2MWaHOHBVEO4guw_1779810602
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 072D4180120A; Tue, 26 May 2026 15:50:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9627D19560A3; Tue, 26 May 2026 15:49:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: [PATCH] virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check
 (CVE-2026-48914)
Date: Tue, 26 May 2026 11:49:57 -0400
Message-ID: <20260526154957.1741622-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check that the iovec containing struct virtio_scsi_inhdr is large enough
before storing an error value there.

Feifan Qian <bea1e@proton.me> pointed out that this can be used to
corrupt heap memory when the descriptor uses an MMIO address and a
length of 1, forcing QEMU to allocate a 1-byte heap bounce buffer.
virtio_stl_p() stores 4 bytes and therefore corrupts whatever is beyond
the bounce buffer.

Fixes: CVE-2026-48914
Fixes: f34e73cd69bd ("virtio-blk: report non-zero status when failing SG_IO requests")
Reported-by: Feifan Qian <bea1e@proton.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2b..6b92066aff 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -199,10 +199,16 @@ static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
 
     /*
      * The scsi inhdr is placed in the second-to-last input segment, just
-     * before the regular inhdr.
+     * before the regular inhdr. VIRTIO implementations normally do not rely on
+     * the precise message framing, but legacy implementations did and so we do
+     * too for the legacy virtio-blk SCSI request type.
      *
      * Just put anything nonzero so that the ioctl fails in the guest.
      */
+    if (elem->in_sg[elem->in_num - 2].iov_len != sizeof(*scsi)) {
+        status = VIRTIO_BLK_S_IOERR;
+        goto fail;
+    }
     scsi = (void *)elem->in_sg[elem->in_num - 2].iov_base;
     virtio_stl_p(vdev, &scsi->errors, 255);
     status = VIRTIO_BLK_S_UNSUPP;
-- 
2.54.0


