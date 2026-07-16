Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D934BC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPat-0007HB-FL; Thu, 16 Jul 2026 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPaq-0007DU-Fo
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:09:52 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPao-0007Ri-IE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:09:52 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 0426C202028A; Fri, 17 Jul 2026 02:09:24 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
Subject: [PATCH 0/4] block: Fix BlockBackend leak on unplug of empty CD-ROM
Date: Fri, 17 Jul 2026 02:09:19 +0900
Message-ID: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
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

When a CD-ROM device is created without a drive (an empty CD-ROM),
the realize function allocates an anonymous BlockBackend with
blk_new() and attaches it to the device with blk_attach_dev().

blk_new() returns the backend with refcnt == 1 (the creation
reference owned by the caller) and blk_attach_dev() takes an
additional reference for the device.  Since the creation reference
is never released, blk_detach_dev() on unplug only drops the
device's reference and the BlockBackend is leaked.

This is not just a memory leak: if a medium was inserted into the
empty drive before the unplug, the leaked BlockBackend keeps the
medium's blockdev node in use forever, so a subsequent blockdev-del
of that node fails with "Node ... is in use".

Two hot-unpluggable devices are affected, scsi-cd and the Xen
CD-ROM.  Both are fixed by releasing the creation reference right
after blk_attach_dev(), matching the idiom already used in
set_drive_helper() in hw/core/qdev-properties-system.c.

While touching xen_cdrom_realize(), patch 2 also fixes an inverted
error check on the return value of blk_attach_dev() (success was
reported as an error and failure silently ignored); since the only
failure path cannot be taken here, it is replaced with an assertion,
matching the other empty-drive realize paths.

Patch 4 adds a qtest regression test for the scsi-cd case: create an
empty scsi-cd, insert a medium, unplug the device, and verify that
the medium's node can then be deleted.  The xen-block case is not
covered because Xen devices cannot be exercised under qtest.

Note that floppy_drive_realize(), swim_drive_realize() and
ide_dev_initfn() leak the creation reference in the same way, but
these devices do not support hot unplug, so the leaked reference has
no practical consequence.  They are left as they are by this series.

Mitsuru Kariya (4):
  scsi-disk: Fix BlockBackend leak on unplug of empty CD-ROM
  xen-block: Fix inverted error check in xen_cdrom_realize()
  xen-block: Fix BlockBackend leak on unplug of empty CD-ROM
  tests/qtest: drive_del: Add regression test for empty CD-ROM
    BlockBackend leak

 hw/block/xen-block.c         |  6 ++--
 hw/scsi/scsi-disk.c          |  1 +
 tests/qtest/drive_del-test.c | 58 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)


base-commit: eca2c16212ef9dcb0871de39bb9d1c2efebe76be
-- 
2.43.0


