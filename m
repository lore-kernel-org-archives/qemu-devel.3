Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4377CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GS-0004A1-Ng; Tue, 26 Mar 2024 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GQ-00048b-Ry
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GO-0001OI-RD
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxieEArCi0NDQMAtUawPdx+iKrN+HtIvUn0JLn9V9qU=;
 b=a0GeI/uPNWpY/BNVdC+MlQkjRJjZ3f8dxLzkW3K4hTPdCYCdAeGcwqI5tBOHvOaZNqm4Kb
 SgiF999WbCXu+RkyxujCaxUkVziVCEgV5NRwDzvfwtyBL/hifWi2WhZbRkSRmgr4skEhVJ
 jFbD78dcvAm8jkzIROk6rS6rBXSUTMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-PBajGdvwPXi0YyzqJ9x8uw-1; Tue, 26 Mar 2024 09:54:50 -0400
X-MC-Unique: PBajGdvwPXi0YyzqJ9x8uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C0488007B5;
 Tue, 26 Mar 2024 13:54:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A60751121312;
 Tue, 26 Mar 2024 13:54:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 3/6] block/io: accept NULL qiov in bdrv_pad_request
Date: Tue, 26 Mar 2024 14:54:37 +0100
Message-ID: <20240326135440.421609-4-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
References: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Reiter <s.reiter@proxmox.com>

Some operations, e.g. block-stream, perform reads while discarding the
results (only copy-on-read matters). In this case, they will pass NULL
as the target QEMUIOVector, which will however trip bdrv_pad_request,
since it wants to extend its passed vector. In particular, this is the
case for the blk_co_preadv() call in stream_populate().

If there is no qiov, no operation can be done with it, but the bytes
and offset still need to be updated, so the subsequent aligned read
will actually be aligned and not run into an assertion failure.

In particular, this can happen when the request alignment of the top
node is larger than the allocated part of the bottom node, in which
case padding becomes necessary. For example:

> ./qemu-img create /tmp/backing.qcow2 -f qcow2 64M -o cluster_size=32768
> ./qemu-io -c "write -P42 0x0 0x1" /tmp/backing.qcow2
> ./qemu-img create /tmp/top.qcow2 -f qcow2 64M -b /tmp/backing.qcow2 -F qcow2
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/top.qcow2 \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "blockdev-add", "arguments": { "driver": "compress", "file": "node0", "node-name": "node1" } }
> {"execute": "block-stream", "arguments": { "job-id": "stream0", "device": "node1" } }
> EOF

Originally-by: Stefan Reiter <s.reiter@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
[FE: do update bytes and offset in any case
     add reproducer to commit message]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240322095009.346989-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index 33150c0359..395bea3bac 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1726,22 +1726,29 @@ static int bdrv_pad_request(BlockDriverState *bs,
         return 0;
     }
 
-    sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
-                                  &sliced_head, &sliced_tail,
-                                  &sliced_niov);
-
-    /* Guaranteed by bdrv_check_request32() */
-    assert(*bytes <= SIZE_MAX);
-    ret = bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
-                                  sliced_head, *bytes);
-    if (ret < 0) {
-        bdrv_padding_finalize(pad);
-        return ret;
+    /*
+     * For prefetching in stream_populate(), no qiov is passed along, because
+     * only copy-on-read matters.
+     */
+    if (qiov && *qiov) {
+        sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
+                                      &sliced_head, &sliced_tail,
+                                      &sliced_niov);
+
+        /* Guaranteed by bdrv_check_request32() */
+        assert(*bytes <= SIZE_MAX);
+        ret = bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
+                                      sliced_head, *bytes);
+        if (ret < 0) {
+            bdrv_padding_finalize(pad);
+            return ret;
+        }
+        *qiov = &pad->local_qiov;
+        *qiov_offset = 0;
     }
+
     *bytes += pad->head + pad->tail;
     *offset -= pad->head;
-    *qiov = &pad->local_qiov;
-    *qiov_offset = 0;
     if (padded) {
         *padded = true;
     }
-- 
2.44.0


