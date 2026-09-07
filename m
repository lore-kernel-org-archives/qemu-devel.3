Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7488DC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XDV-0004SW-NL; Mon, 07 Sep 2026 07:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XDS-0004PP-Um; Mon, 07 Sep 2026 07:08:46 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XDR-000430-Hm; Mon, 07 Sep 2026 07:08:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14605601F9;
 Mon,  7 Sep 2026 11:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7F31F00A3A;
 Mon,  7 Sep 2026 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788779323;
 bh=IAylABn7oLGfAoGAzMO/VfimbEFQhqIDJ1ttcIrqSqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c7wsxu+ZqhKeKQeAcuGH7yroBKJQQoQA6ggxOOzgkDZXCTXD4YTE/IAeMp5LY+E0y
 dmhBAC1l05RfCox3KrRdmCnQhXz8XqcuugJwIG+zhsvi5YliXKM3rMfw603TqeJ+68
 tF6Ab+IRMBlXMltD7WjjiIi4JpQvo1hLIs+vdbBsWEprBmbTpI44YO+MShTiW+n/vd
 fU+osIjywF4wDiFCDPX7ILVjvpLh8I+YNy1OPjcq+6NlfLJHIGh3joXflYCeeg1usq
 onMC62y54rmjZTCaaOcicdIXfNN/CpNymL1p9KkdH1uA+61dKU5swD8Vm1fQ0Pt2Nl
 fKM1JM0tyuaIg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 11/12] file-posix: reject a zone append past the device
 capacity
Date: Mon,  7 Sep 2026 13:07:46 +0200
Message-ID: <20260907110748.1868714-12-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907110748.1868714-1-cassel@kernel.org>
References: <20260907110748.1868714-1-cassel@kernel.org>
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

raw_co_zone_append() checks that the offset it is given is aligned to the
zone size, but not that it names a zone of the device. raw_co_prw() then
derives a zone index from it and reads that entry of the write pointer
array, so an offset past the end of the device reads past the end of the
array.

bdrv_co_zone_append() does not catch it either: bdrv_check_qiov_request()
bounds the request against BDRV_MAX_LENGTH, which has nothing to do with
the size of this device. A guest cannot reach it, because
check_zoned_request() in virtio-blk rejects an out of range offset first,
but qemu-io and any other caller of blk_co_zone_append() can:

  $ qemu-io --image-opts -n driver=host_device,filename=/dev/nullb0 \
        -c "zap -p 0x100000000000 0x1000"
  Segmentation fault

On a null_blk device with 1000 zones of 256 MiB, that offset yields zone
index 65536 and reads 512 KiB beyond an 8000 byte allocation.

Reject an offset that lies outside the device. That also bounds the
zone index that raw_co_prw() derives from it, so its write pointer
lookup stays inside the array.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0e92ff8414..0e8ffe91c4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3597,8 +3597,15 @@ raw_co_zone_append(BlockDriverState *bs,
                    QEMUIOVector *qiov,
                    BdrvRequestFlags flags) {
     assert(flags == 0);
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
     int64_t zone_size_mask = bs->bl.zone_size - 1;
 
+    if (*offset >= capacity) {
+        error_report("*offset %" PRId64 " is equal to or greater than the "
+                     "device capacity %" PRId64 "", *offset, capacity);
+        return -ENOSPC;
+    }
+
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
                      "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
-- 
2.55.0


