Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE94C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbXh-0003Vz-CF; Fri, 22 Mar 2024 05:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXb-0003SW-7f; Fri, 22 Mar 2024 05:50:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXX-00020l-4T; Fri, 22 Mar 2024 05:50:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B199041987;
 Fri, 22 Mar 2024 10:50:14 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: [PATCH v3 1/4] block/io: accept NULL qiov in bdrv_pad_request
Date: Fri, 22 Mar 2024 10:50:06 +0100
Message-Id: <20240322095009.346989-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322095009.346989-1-f.ebner@proxmox.com>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---

No changes in v3.
No changes in v2.

 block/io.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

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
+    /*
+     * For prefetching in stream_populate(), no qiov is passed along, because
+     * only copy-on-read matters.
+     */
+    if (qiov && *qiov) {
+        sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
+                                      &sliced_head, &sliced_tail,
+                                      &sliced_niov);
 
-    /* Guaranteed by bdrv_check_request32() */
-    assert(*bytes <= SIZE_MAX);
-    ret = bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
-                                  sliced_head, *bytes);
-    if (ret < 0) {
-        bdrv_padding_finalize(pad);
-        return ret;
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
2.39.2



