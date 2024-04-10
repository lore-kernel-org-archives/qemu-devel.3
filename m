Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6123ECD129A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNf-00047a-7Z; Wed, 10 Apr 2024 03:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNS-0003Te-NL; Wed, 10 Apr 2024 03:28:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNQ-0004uK-Tk; Wed, 10 Apr 2024 03:28:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 727F75D6A7;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1268CB02E7;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191814 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Reiter <s.reiter@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 55/87] block/io: accept NULL qiov in bdrv_pad_request
Date: Wed, 10 Apr 2024 10:22:28 +0300
Message-Id: <20240410072303.4191455-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
(cherry picked from commit 3f934817c82c2f1bf1c238f8d1065a3be10a3c9e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io.c b/block/io.c
index d202987770..8a75da704b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1756,22 +1756,29 @@ static int bdrv_pad_request(BlockDriverState *bs,
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
2.39.2


