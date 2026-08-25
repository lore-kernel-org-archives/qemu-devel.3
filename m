Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A1EC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyE6-0001JQ-Qh; Tue, 25 Aug 2026 16:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyE1-0001HZ-Ke; Tue, 25 Aug 2026 16:58:29 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDy-0003EF-UW; Tue, 25 Aug 2026 16:58:28 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 200404199C;
 Tue, 25 Aug 2026 20:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CA51F000E9;
 Tue, 25 Aug 2026 20:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691505;
 bh=kn7OvInryakcnhK7ztYQ924bSSICBL3RMBQHYHFt+QM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uc99Bf+ErCOLtTA49yNjDiusLBUdopI1jDlEFtCU00Y0Cypvk1hE7vz3qNwXGzdAn
 z334k2ZwFEb8ype4Ns0uwoIzD9b+zowb3UDyRWeJJkbbkLdx0sWxaHqXgXYH6Z910i
 /pVwZgin/dfjingV897bY71HfwOMnEXaWVDEiFGgwjjI/tSH9ttc5twJzy6ImZSSOZ
 NV78/TfksCxsJikkxwlQxOmM8VcI6K50qXbNsNn2O74cdqw8qtEfbirXcFi9395cvH
 BpUQjmj1cswvGUT7FxLMaquaDfGzardto/TpgwYbWmRfuzjnG965v/lBzaIZiRXlbM
 t+5NiSJAlDgSg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 11/12] file-posix: reject a zone append past the device
 capacity
Date: Tue, 25 Aug 2026 22:57:46 +0200
Message-ID: <20260825205748.679968-12-cassel@kernel.org>
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
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index e019cc3cd8..85d735c079 100644
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


