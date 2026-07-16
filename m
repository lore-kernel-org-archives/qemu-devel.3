Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06943C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPau-0007HG-0y; Thu, 16 Jul 2026 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPar-0007EF-KG; Thu, 16 Jul 2026 13:09:53 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPao-0007Rj-Mz; Thu, 16 Jul 2026 13:09:53 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 3B36E2020241; Fri, 17 Jul 2026 02:09:24 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 2/4] xen-block: Fix inverted error check in xen_cdrom_realize()
Date: Fri, 17 Jul 2026 02:09:21 +0900
Message-ID: <20260716170923.2125858-3-Mitsuru.Kariya@oss.nttdata.com>
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

xen_cdrom_realize() checks the return value of blk_attach_dev() with

    if (!rc) {
        error_setg_errno(errp, -rc, "failed to create drive");
        return;
    }

but blk_attach_dev() returns 0 on success and a negative errno on
failure.  The condition is inverted: a successful attach (rc == 0) is
reported as an error and fails realize, while a real failure (rc < 0)
is silently ignored.

Here blk_attach_dev() is called on a BlockBackend just created by
blk_new(), so blk->dev is NULL and its only failure path (-EBUSY)
cannot be taken.  Replace the bogus check with an assertion, matching
the other empty-drive realize paths (scsi-disk, ide, fdc, swim).

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 hw/block/xen-block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 474c12fe4a..abf9df2eee 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -762,10 +762,7 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
         conf->blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
 
         rc = blk_attach_dev(conf->blk, DEVICE(blockdev));
-        if (!rc) {
-            error_setg_errno(errp, -rc, "failed to create drive");
-            return;
-        }
+        assert(rc == 0);
     }
 
     blockdev->info = VDISK_READONLY | VDISK_CDROM;
-- 
2.43.0


