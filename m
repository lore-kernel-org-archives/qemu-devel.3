Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA66C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsOuX-00080N-Iz; Fri, 07 Aug 2026 14:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wsOuT-0007zM-KJ; Fri, 07 Aug 2026 14:03:09 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wsOuQ-0000AH-Jq; Fri, 07 Aug 2026 14:03:08 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6394A600B0;
 Fri,  7 Aug 2026 18:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8421F000E9;
 Fri,  7 Aug 2026 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786125784;
 bh=yW4YctkCmo0esiPBvmbW/KoACm1wpa+UXfXy2VMPFco=;
 h=From:To:Cc:Subject:Date;
 b=PDjSdwDNle/OXUTreL/EhDni9GrOc+Kw56LKbXw12w2D+Rx2E6rQnVo028+4/cbd7
 kdhVwyrReZ22NZ/AHLk16BqbQrH/NShpQd+Lsv/8crEmA4cEMjqhVgnBpiZt8Y5Xt2
 Xx9M6FF4xoP6b8T+wNlIBZTSZY5/oC8iyERyFVQlajnmrbC1TJRU9kyjCz4LuqcB/S
 Sb5vLt+YPVHvddUObZ5W6bj0LJakGpihRyUv5UlJvfLsB7qNmU9wyCVXzsMCXcxKBD
 Xncy9I50U5EqxrMJr3k9NLRIKQpnjDEXhvheAugwll1NzJzoIZfP91ayY3EIVrnnue
 cz5f8j6DSx5kQ==
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] file-posix: fix zone write granularity assignment for zoned
 block devices
Date: Fri,  7 Aug 2026 20:02:57 +0200
Message-ID: <20260807180257.813627-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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
this away by providing, so let's make use of it.

Currently, it is theoretically possible that QEMU presents an inflated
write granularity for NVMe devices where the physical block size is larger
than the logical block size.

Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
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


