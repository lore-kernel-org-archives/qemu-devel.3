Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D6C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPau-0007Hn-EY; Thu, 16 Jul 2026 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPar-0007ER-MI; Thu, 16 Jul 2026 13:09:53 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPao-0007Rg-NS; Thu, 16 Jul 2026 13:09:53 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 5766E2020242; Fri, 17 Jul 2026 02:09:24 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 3/4] xen-block: Fix BlockBackend leak on unplug of empty CD-ROM
Date: Fri, 17 Jul 2026 02:09:22 +0900
Message-ID: <20260716170923.2125858-4-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
References: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=kariyam@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When a Xen CD-ROM is created without a backing drive (an empty CD-ROM),
xen_cdrom_realize() allocates an anonymous BlockBackend for the empty
drive with blk_new() and attaches it to the device using
blk_attach_dev().

blk_new() returns the backend with refcnt == 1 (the creation reference
owned by the caller) and blk_attach_dev() takes an additional reference
for the device.  The creation reference was never released, so on
unplug blk_detach_dev() only drops the device's reference and the
BlockBackend is leaked.

Release the creation reference with blk_unref() right after
blk_attach_dev(), matching the idiom already used in set_drive_helper()
in hw/core/qdev-properties-system.c ("If we need to keep a reference,
blk_attach_dev() took it").

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 hw/block/xen-block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index abf9df2eee..e5e14e47ee 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -763,6 +763,7 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
 
         rc = blk_attach_dev(conf->blk, DEVICE(blockdev));
         assert(rc == 0);
+        blk_unref(conf->blk);
     }
 
     blockdev->info = VDISK_READONLY | VDISK_CDROM;
-- 
2.43.0


