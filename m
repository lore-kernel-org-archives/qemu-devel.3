Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150DB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ouhr67ZE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTKj-0005SF-LM; Thu, 12 Nov 2026 06:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xRTJw-0004aV-Tx; Thu, 12 Nov 2026 06:50:25 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xRTJv-0001bn-1A; Thu, 12 Nov 2026 06:50:24 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B73141F35;
 Thu, 12 Nov 2026 11:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055E91F00A05;
 Thu, 12 Nov 2026 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794484221;
 bh=Esw70AkxNjTsmKH8cQHI6dH7Fui24yncSQmZ2LGzH5A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ouhr67ZEv6Z02fve0lRnJ+GS2qIK6TFKsEmV0KfTri0CCOl6iaEpruLO31NArHLMs
 RAfV/DexgWlI/Q+r6goppxkQ7abIexBWHWSZfztt8Q9hT7JdoZA++AXuoNOpXNk7sP
 orXCva/WA7+TogzIyTr75Zew7haTysqULT4reP9nSKXVfvSzVQsrWzcEzddlOIgWFa
 5kzQbwGBuPTtLVCxD5dGQLXQOpNMgF32EOG4aVzwgtCP8LDWGxVNmEhS8LGmceiaqO
 mNY9px21TdN6Nzlcgr/QuvE97eof2so6lLlkO6DqTFSJOGEHn72GIEDh0UZToTUkad
 giUQYZUzdPnQw==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v17 7/9] virtio-blk: report zone errors with their zone status
 codes
Date: Thu, 12 Nov 2026 12:49:16 +0100
Message-ID: <20261112114918.1269168-8-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112114918.1269168-1-cassel@kernel.org>
References: <20261112114918.1269168-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio-blk completes a failed write with VIRTIO_BLK_S_IOERR, and a
failed zone append or zone management request with
VIRTIO_BLK_S_ZONE_INVALID_CMD. It never reports the zone status codes
that virtio 1.4 (5.2.6.2) requires for a write off the write pointer
or for a request that exceeds a zone resource limit.

When VIRTIO_BLK_F_ZONED is negotiated, map the zone errors of the block
layer to them:

  BLK_ZE_UNALIGNED_WRITE  VIRTIO_BLK_S_ZONE_UNALIGNED_WP
  BLK_ZE_BOUNDARY         VIRTIO_BLK_S_ZONE_INVALID_CMD
  BLK_ZE_OPEN_RESOURCE    VIRTIO_BLK_S_ZONE_OPEN_RESOURCE
  BLK_ZE_ACTIVE_RESOURCE  VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
  BLK_ZE_FULL             VIRTIO_BLK_S_ZONE_INVALID_CMD

Other errors keep their status code. A FINISH that exceeds a zone
resource limit also gets a zone resource status code, which 5.2.6
defines for any zone operation. Zone errors of writes are reported
regardless of the rerror/werror policy, as they are the deterministic
result of the request.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c | 49 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9b7c84fda6..81c68b0ee3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -78,11 +78,45 @@ void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     virtio_notify(vdev, req->vq);
 }
 
+/*
+ * Map a zone error (see include/block/block-common.h) to its virtio-blk
+ * status, or return VIRTIO_BLK_S_OK if @error is not one.
+ */
+static uint8_t virtio_blk_zone_status(VirtIOBlock *s, int error)
+{
+    if (!virtio_vdev_has_feature(VIRTIO_DEVICE(s), VIRTIO_BLK_F_ZONED)) {
+        return VIRTIO_BLK_S_OK;
+    }
+
+    switch (error) {
+    case BLK_ZE_UNALIGNED_WRITE:
+        return VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
+    case BLK_ZE_BOUNDARY:
+    case BLK_ZE_FULL:
+        return VIRTIO_BLK_S_ZONE_INVALID_CMD;
+    case BLK_ZE_OPEN_RESOURCE:
+        return VIRTIO_BLK_S_ZONE_OPEN_RESOURCE;
+    case BLK_ZE_ACTIVE_RESOURCE:
+        return VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE;
+    default:
+        return VIRTIO_BLK_S_OK;
+    }
+}
+
 static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
                                       bool is_read)
 {
     VirtIOBlock *s = req->dev;
-    BlockErrorAction action = blk_get_error_action(s->blk, is_read, error);
+    uint8_t zone_status = virtio_blk_zone_status(s, error);
+    /*
+     * Zone errors are the deterministic result of the request, so they are
+     * reported whatever the rerror/werror policy: stopping the VM would only
+     * make the request fail the same way again when it is retried on resume,
+     * and ignoring the error would hide the failure from the guest.
+     */
+    BlockErrorAction action = zone_status != VIRTIO_BLK_S_OK ?
+                              BLOCK_ERROR_ACTION_REPORT :
+                              blk_get_error_action(s->blk, is_read, error);
 
     if (action == BLOCK_ERROR_ACTION_STOP) {
         /* Break the link as the next request is going to be parsed from the
@@ -94,7 +128,8 @@ static int virtio_blk_handle_rw_error(VirtIOBlockReq *req, int error,
             s->rq = req;
         }
     } else if (action == BLOCK_ERROR_ACTION_REPORT) {
-        virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
+        virtio_blk_req_complete(req, zone_status != VIRTIO_BLK_S_OK ?
+                                     zone_status : VIRTIO_BLK_S_IOERR);
         block_acct_failed(blk_get_stats(s->blk), &req->acct);
         g_free(req);
     }
@@ -781,7 +816,10 @@ static void virtio_blk_zone_mgmt_complete(void *opaque, int ret)
     trace_virtio_blk_zone_mgmt_complete(vdev, req,ret);
 
     if (ret) {
-        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        err_status = virtio_blk_zone_status(s, -ret);
+        if (err_status == VIRTIO_BLK_S_OK) {
+            err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        }
     }
 
     virtio_blk_req_complete(req, err_status);
@@ -841,7 +879,10 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
     uint8_t err_status = VIRTIO_BLK_S_OK;
 
     if (ret) {
-        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        err_status = virtio_blk_zone_status(s, -ret);
+        if (err_status == VIRTIO_BLK_S_OK) {
+            err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        }
         goto out;
     }
 
-- 
2.56.0


