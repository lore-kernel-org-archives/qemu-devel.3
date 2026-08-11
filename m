Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FBEC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmbU-000518-EJ; Tue, 11 Aug 2026 09:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wtmb9-0004zt-0b; Tue, 11 Aug 2026 09:32:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wtmb7-0000nu-8Y; Tue, 11 Aug 2026 09:32:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78A2E42D84;
 Tue, 11 Aug 2026 13:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AD21F000E9;
 Tue, 11 Aug 2026 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786455163;
 bh=Dus6fa5TdeyIy9yx0oWemFivbprhJ2rlQSCzJAWvIiU=;
 h=From:To:Cc:Subject:Date;
 b=DwT2ai89iOaiJ/2u5e9aw3N5QiqtbV1JxMW1sDyFG/xxTfQtFd+p+FkGz+GVnZeKu
 1UZrbPIHv3hQa3Yi5ACkK1lVjvg1Z8VzSOWNBRGF6eJVQqXFlVXdfcTiKzG4Xr8h7O
 nx2DpjLs1UdhTawLhLlfVPl76p6tfsrt5g8YJ4/XTLl252g7wMyd/a2xhCqdSB1XXW
 tDH8CXsXD72yyshNnwXqmEyA/jQAbyyWX34Kp7gBYq/2WhxQZNK/71mqWuu6tz8dQj
 g18cgby8YcRpWLSc04b+hIxZWGKUARKYMKcxyiW1EFp85qia3sAIvRfzA+OVdmsNFt
 K+dxqy28vifSw==
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] file-posix: fix zone write granularity assignment for
 zoned block devices
Date: Tue, 11 Aug 2026 15:32:36 +0200
Message-ID: <20260811133236.1290092-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

In the ZBC and ZAC specifications, the requirement is that the write
granularity matches the physical block size.

However, in the ZNS specification, the requirement is simply that the
write granularity matches the logical block size.

See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a805a4fa4fa376bbc145762bb8b09caa2fa8af48

In Linux, there is a zone_write_granularity sysfs property which abstracts
this away, so let's make use of it.

Currently, it is theoretically possible that QEMU presents an inflated
write granularity for NVMe devices where the physical block size is larger
than the logical block size.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Improved commit log.
-Picked up tag.

 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c985da94f..63c52b1044 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1495,7 +1495,7 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
         bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
     }
 
-    ret = get_sysfs_long_val(st, "physical_block_size");
+    ret = get_sysfs_long_val(st, "zone_write_granularity");
     if (ret >= 0) {
         bs->bl.write_granularity = ret;
     }
-- 
2.55.0


