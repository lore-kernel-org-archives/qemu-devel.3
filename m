Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27EFC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7cS1-0007NO-LI; Fri, 18 Sep 2026 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cPa-0004lc-UJ; Fri, 18 Sep 2026 13:30:12 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cPY-0000Vf-RY; Fri, 18 Sep 2026 13:30:10 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EAC840F24;
 Fri, 18 Sep 2026 17:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897491F000FF;
 Fri, 18 Sep 2026 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789752607;
 bh=aJ4D99PRE9FsrB0XYN1JFXE/oB3XRrxb2xhanlbrQFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ATyu0SAeIXzY1Walxg2RQA4UlYrAJH6qh3ESu+gXaYbvCCFx1BB0i4LdaHWZkZbbk
 2ePGKOVGkUMCKs9P6+ZHtqKY38vBTr1mUV2h0LkujIqQ11455dcCUq8p4+Dp68lO7W
 FWfbPJGEIfilsKKTXQzAL4Mzek2i0WSboFZQFT3UlFjtmiKsElZHUG9Zn4BNmpwGqr
 5Lw0+YrgaIkplBRySMhLk+2mFRzKXnNOxGoaChIJ7T9A1+SkS4ByTpvXN8OnhzWM0r
 1VzDJ+SKaZBSoXaAcy3x7R3p1mmqaQdlNNQcyc8rM3bgkrG/bwkdWJ02xdrafDWg83
 8bn+dCZ0pZ6SQ==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 12/15] block: remove BlockLimits.max_append_sectors
Date: Fri, 18 Sep 2026 19:29:20 +0200
Message-ID: <20260918172925.2640888-13-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918172925.2640888-1-cassel@kernel.org>
References: <20260918172925.2640888-1-cassel@kernel.org>
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

The field described the largest zone append that a backend accepts. It
had one writer and one reader, and neither is left.

file-posix filled it from the zone_append_max_bytes queue attribute,
which bounds REQ_OP_ZONE_APPEND, an operation it never issues: Linux has
no userspace interface for one, so raw_co_zone_append() substitutes the
write pointer of the zone for the offset and the request reaches the
host as a plain pwritev().

The transfer limit does not apply either, no more than it does to an
ordinary write. This driver reports max_hw_transfer but never sets
BlockLimits.max_transfer, which is what bdrv_aligned_pwritev() splits
by, so a request of any size goes to the host kernel whole and is split
there: on a null_blk device whose zone_append_max_bytes is 130560, a
16 MiB append completes and advances the write pointer by 16 MiB. That
is safe for a sequential zone, as Linux issues the fragments of a split
write in order, with zone write plugging since 6.10 and zone write
locking before that.

virtio-blk was the reader, and now takes what it reports to a guest from
a property instead.

Remove the field and the assignment that filled it. Keeping it would be
worse than not having it: a driver that set it, believing something
enforced it, would be silently ignored.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c               | 5 -----
 include/block/block_int-common.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c1ac49d23d..1a4ca9d942 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1488,11 +1488,6 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     }
     bs->bl.nr_zones = ret;
 
-    ret = get_sysfs_long_val(st, "zone_append_max_bytes");
-    if (ret > 0) {
-        bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
-    }
-
     ret = get_sysfs_long_val(st, "zone_write_granularity");
     if (ret >= 0) {
         bs->bl.write_granularity = ret;
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 7abd2b12bb..cfc7b0f427 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -913,9 +913,6 @@ typedef struct BlockLimits {
     /* total number of zones */
     uint32_t nr_zones;
 
-    /* maximum sectors of a zone append write operation */
-    uint32_t max_append_sectors;
-
     /* maximum number of open zones */
     uint32_t max_open_zones;
 
-- 
2.55.0


