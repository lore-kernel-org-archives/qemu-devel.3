Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA48C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyE9-0001Kq-CH; Tue, 25 Aug 2026 16:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyE3-0001Ia-HZ; Tue, 25 Aug 2026 16:58:31 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyE0-0003FC-8Z; Tue, 25 Aug 2026 16:58:30 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E48E4005A;
 Tue, 25 Aug 2026 20:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814561F000E9;
 Tue, 25 Aug 2026 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691507;
 bh=M7wb7uQGpFZypS1kuI5SudHeCe6U3M7sNK42IUiMtfc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Iu6ScVBp4P14oVPfVSyRL8UY0WLmxLpuN+sgFwXqO6YQOWTwZIRvCLEStNo6WBuXT
 +3BdBoOz/gjHpM+i41shsV5Kv8nQdKGV1ZmeG3xJAYW9EgnlnUyvQTDUjPhpHqW1RK
 FY6o1EatU47eSQjKxNBSS54bIdx86h6wHQk2rdguRGYXkZAFXt16VfVge+UIeYT/yE
 BvHbr8PKmw+g+BcEzzmb5wL4wBXnWe2Vauq6NoHdLIW19WnNbnT3S8mJAFEr3lkTgd
 859Ynnsk6QF54kvihs087J05tGiMfZ+c0OwOco+s92ZOcqrSthl2pun/SGABnN6eEc
 kCOEH6PHR4q7g==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 12/12] file-posix: reject a zone append to a full or
 conventional zone
Date: Tue, 25 Aug 2026 22:57:47 +0200
Message-ID: <20260825205748.679968-13-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825205748.679968-1-cassel@kernel.org>
References: <20260825205748.679968-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
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
 block/file-posix.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 85d735c079..135e60751f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2565,8 +2565,34 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
         bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
         if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = offset / bs->bl.zone_size;
-            offset = bs->wps->wp[index];
+            uint32_t index = offset / bs->bl.zone_size;
+            uint64_t wp = bs->wps->wp[index];
+            uint64_t zone_end =
+                MIN((uint64_t)(index + 1) * bs->bl.zone_size,
+                    (uint64_t)bs->total_sectors << BDRV_SECTOR_BITS);
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
+            if (wp >= zone_end) {
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
-- 
2.55.0


