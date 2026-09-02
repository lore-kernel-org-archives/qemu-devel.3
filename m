Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8D5C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qtX-0000bK-L2; Wed, 02 Sep 2026 15:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtU-0000Yk-6S; Wed, 02 Sep 2026 15:45:13 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x1qtS-0006F2-HH; Wed, 02 Sep 2026 15:45:11 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98F1F600D4;
 Wed,  2 Sep 2026 19:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477D61F000E9;
 Wed,  2 Sep 2026 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378309;
 bh=ftPopcfHae1aDSaoCzebEkqZIeJfOQJs19QFUP36+xI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MmPVBYE29e+CKZEzJt8GCQJLmrxVU7Oa/73iBsf46qrEjQ38QQMofkNmamfLhNRmV
 ObwYxj6YR0p7nvVusUG4/qlgi6NERfYp9mcHbbqL0fEAkt+xSII180RGRXmrwDuRre
 9QS+6KQwsNnzdZ+G/UJnA9ow9F1fFf/RgRh9XENQe7+izjBxdVXEMAAUkNDc40xDxY
 KcHayCK1VsOuPw+qe/cXrkmBUZQi+e6LiWlyF/wOOJcUl6DNJXMNXNftA3K+6kYFCp
 3u1mV9Ih2Sui4EJoRlmnysuDT+2kB4odKaekwB4XdzJkQShZFwUj1M+S5ZDekgQwk5
 AVH3YWvZKh9pA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 11/11] file-posix: reject a zone append to a full or
 conventional zone
Date: Wed,  2 Sep 2026 21:44:22 +0200
Message-ID: <20260902194423.759355-12-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194423.759355-1-cassel@kernel.org>
References: <20260902194423.759355-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

raw_co_prw() replaces the offset of a zone append with the write pointer
of the addressed zone, which assumes that the stored value names a
position inside that zone. It does not in two cases.

A full zone has its write pointer recorded at the end of the zone, since
get_zones_wp() stores start + len for BLK_ZONE_COND_FULL. That is the
first sector of the following zone, so the append is submitted there. The
kernel accepts it whenever that zone is empty, because it is a legal
write at its write pointer, and the completion path advances the wrong
zone because it recomputes the zone index from the replaced offset. The
data is written to a zone that was never addressed and success is
returned:

  zone 2 finished, then a 4 KiB append to zone 2:
  After zap done, the append sector is 0x180000     <- zone 3
  zone 2: wptr 0x180000, zcond:14 (full)
  zone 3: wptr 0x180008                             <- advanced

A conventional zone has no write pointer at all, and its array entry
carries only the type marker in the top bit, so the offset becomes
negative and the write fails with EINVAL. That is harmless but it reports
nothing about the actual mistake.

Reject both while the write pointer lock is held, since the state has to
be read and acted on atomically. check_zoned_request() in virtio-blk
refuses an append to a conventional zone, so that case needs a caller
that goes to the driver directly, but nothing there examines whether a
zone is full, so a guest can reach the misdirected write.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c       | 27 +++++++++++++++++++++++++--
 block/io.c               |  9 +++++++++
 include/block/block-io.h |  6 ++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 85d735c079..57ba8dde64 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2565,8 +2565,31 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
         bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
         if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = offset / bs->bl.zone_size;
-            offset = bs->wps->wp[index];
+            uint32_t index = offset / bs->bl.zone_size;
+            uint64_t wp = bs->wps->wp[index];
+
+            /*
+             * The write pointer of the addressed zone becomes the offset of
+             * the write, so it has to name a position inside that zone. It
+             * does not for a conventional zone, which has no write pointer and
+             * stores a type marker in the top bit instead, and it does not for
+             * a full zone, whose write pointer is reported at the zone end.
+             * Either would send the data to a zone that was never addressed.
+             */
+            if (BDRV_ZT_IS_CONV(wp)) {
+                error_report("zone append at offset 0x%" PRIx64 " addresses a "
+                             "conventional zone", offset);
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                return -EINVAL;
+            }
+            if (bdrv_zone_is_full(bs, index)) {
+                error_report("zone append at offset 0x%" PRIx64 " addresses a "
+                             "full zone", offset);
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                return -ENOSPC;
+            }
+
+            offset = wp;
         }
     }
 #endif
diff --git a/block/io.c b/block/io.c
index 705dc73d76..3574e15a55 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3371,6 +3371,15 @@ out:
     return co.ret;
 }
 
+bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index)
+{
+    uint64_t zone_end = MIN((uint64_t)(index + 1) * bs->bl.zone_size,
+                            (uint64_t)bs->total_sectors << BDRV_SECTOR_BITS);
+    IO_CODE();
+
+    return bs->wps->wp[index] >= zone_end;
+}
+
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
 {
     IO_CODE();
diff --git a/include/block/block-io.h b/include/block/block-io.h
index d34d846bb2..2a9505312a 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -126,6 +126,12 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   int64_t *offset,
                                                   QEMUIOVector *qiov,
                                                   BdrvRequestFlags flags);
+/*
+ * True when the write pointer of a zone has reached the end of the writable
+ * part of that zone, so that nothing more can be written to it until it is
+ * reset. The write pointer lock must be held when called.
+ */
+bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 
-- 
2.55.0


