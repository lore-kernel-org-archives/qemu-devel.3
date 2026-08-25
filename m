Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E8DC61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyDn-00018t-Pa; Tue, 25 Aug 2026 16:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDg-00016T-FT; Tue, 25 Aug 2026 16:58:08 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDe-0003A3-SA; Tue, 25 Aug 2026 16:58:08 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 636B841996;
 Tue, 25 Aug 2026 20:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8615F1F000E9;
 Tue, 25 Aug 2026 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691485;
 bh=L793T09DHu/KWT0lp5U50ovDLcAH53XzTINX6JLT98k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HYY+R/8lAIHZl3H7IS2tciWh8TgiWf5KB9QiT61hH1VmYWLgVcdjmso4gdkQ+EuEY
 yjADd7TYyxGJc8AFd18DXXNk/gO9a08xzbVXkWL+e353iwp5mrpyUKP4/Oop8Dkzw3
 srniLUhn69/1xmrPL1tc5RAoHg7LrX+nmEkq008qX68G5NmZkjeCLIzqDJteCe2PFi
 vA7dNTU0UiZuCgXwtw2zQD3l1ZHTyQqI7cJnZk7JpPW76APQJaQaAUskopc2oj6KIC
 EhRbUjGRQDL0/9VAQXuvbRsxrXoPPb/EKR70fwXidDzWmxoGQPoh59yPK9UX1REAdK
 tp29SC6vohCKw==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 03/12] file-posix: fix zone write granularity assignment for
 zoned block devices
Date: Tue, 25 Aug 2026 22:57:38 +0200
Message-ID: <20260825205748.679968-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825205748.679968-1-cassel@kernel.org>
References: <20260825205748.679968-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: a3c41f06d5a8 ("file-posix: add tracking of the zone write pointers")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index dd9e3d4c37..c0d6ee30e4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1493,7 +1493,7 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
         bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
     }
 
-    ret = get_sysfs_long_val(st, "physical_block_size");
+    ret = get_sysfs_long_val(st, "zone_write_granularity");
     if (ret >= 0) {
         bs->bl.write_granularity = ret;
     }
-- 
2.55.0


