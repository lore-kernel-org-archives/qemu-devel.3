Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+DlUeUd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMD0e-0001Om-Sk; Wed, 28 Oct 2026 19:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMD0G-0001MU-Ck
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMD0E-0003bM-FE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793229857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EjBs/hEO3GPPBiAKxBtyso4NOxnnH42689CeC0JyZ/Q=;
 b=H+DlUeUdnvwRLYdAty1RvEghN6SOyTUQ1dxulyLLvnw0aY/1wk1OLKV7wzDofqIvciMlks
 Pa0PQ19SX1dTkIgz+CkDGQbkS2UZk5BH3HkTx+G+XqGTvP7p5j2M/wBjazebt+hLvuOqFr
 rCL1I1SPDKDJTPRtyG8h+fcmx2p6C58=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-ItrBR4rAMbmafaE8Dp5ebQ-1; Wed,
 28 Oct 2026 19:24:16 -0400
X-MC-Unique: ItrBR4rAMbmafaE8Dp5ebQ-1
X-Mimecast-MFC-AGG-ID: ItrBR4rAMbmafaE8Dp5ebQ_1793229855
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 612DF18005A2; Wed, 28 Oct 2026 23:24:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4502F180057F; Wed, 28 Oct 2026 23:24:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: [PATCH 1/5] virtio-blk: Implement full NUL padding for GET_ID
Date: Thu, 29 Oct 2026 00:23:56 +0100
Message-ID: <20261028232400.222535-2-kwolf@redhat.com>
In-Reply-To: <20261028232400.222535-1-kwolf@redhat.com>
References: <20261028232400.222535-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The spec requires not only NUL termination of the device ID string, but
NUL padding:

    VIRTIO_BLK_T_GET_ID requests fetch the device ID string from the
    device into data. The device ID string is a NUL-padded ASCII string
    up to 20 bytes long. If the string is 20 bytes long then there is no
    NUL terminator.

Zero out all of the remaining bytes in the request buffer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 536d71a91ad..3f236f22d57 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1011,14 +1011,18 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
     case VIRTIO_BLK_T_GET_ID:
     {
         /*
-         * NB: per existing s/n string convention the string is
+         * The spec requires NUL-padding for the output. The string is
          * terminated by '\0' only when shorter than buffer.
          */
         const char *serial = s->conf.serial ? s->conf.serial : "";
-        size_t size = MIN(strlen(serial) + 1,
-                          MIN(iov_size(in_iov, in_num),
-                              VIRTIO_BLK_ID_BYTES));
+        size_t req_size = MIN(iov_size(in_iov, in_num), VIRTIO_BLK_ID_BYTES);
+        size_t size = MIN(strlen(serial), req_size);
+        size_t padding = req_size - size;
+
         iov_from_buf(in_iov, in_num, 0, serial, size);
+        if (padding) {
+            iov_memset(in_iov, in_num, size, 0, padding);
+        }
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
         g_free(req);
         break;
-- 
2.56.0


