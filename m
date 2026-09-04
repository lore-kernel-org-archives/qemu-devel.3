Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FE8C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Wce-0000qW-Uy; Fri, 04 Sep 2026 12:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2Wcd-0000q6-Kn; Fri, 04 Sep 2026 12:18:35 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2Wcb-0001RV-SU; Fri, 04 Sep 2026 12:18:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5FFB4113F;
 Fri,  4 Sep 2026 16:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF03C1F00A3D;
 Fri,  4 Sep 2026 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788538712;
 bh=+7pxwgh6LD+wSfDu1pHYn5P69cuWbxjndwby/KCvoJY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XDGExTQA79/LfAeYg4Lf5uFiVLDNqZsZXU7pqAc25xGbmd0EDMiG7FvQE60PPjdGG
 aVytw+0x4ITs8O9S/srQMeVJNkJEF6rPoonAowahGVscPf8PloOXfTX216gQ3pm8QA
 N3STuIA+OgSLoP43PLqXoM/XK8ABvAGy0Fe06COAs3xZmbug0tbrkvgy2Utm0pcunO
 +MEQbtjWTUn7CkRpO5tOL0ID1GeLma/IIgPp0ObWSJlZidDT6ZdbqJfRaKwKIX6/QZ
 P2TQktPQVrCv7JUIHSPb8u4dwp8NwnobeelUQ0M8U7Cm1bN2OyOfNkNTvxCO0HjZlr
 0+0M+t/Xm6gJA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 09/12] file-posix: base the zone append limit on the
 transfer limit
Date: Fri,  4 Sep 2026 18:17:57 +0200
Message-ID: <20260904161801.1568841-10-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904161801.1568841-1-cassel@kernel.org>
References: <20260904161801.1568841-1-cassel@kernel.org>
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

The zone_append_max_bytes queue attribute is the largest
REQ_OP_ZONE_APPEND that the device accepts, and Linux has no interface
for issuing one from userspace: include/uapi has no such operation, and
every submitter of REQ_OP_ZONE_APPEND is in the kernel. Userspace writes
to a sequential zone with an ordinary write at the write pointer.

That is what this driver does. raw_co_zone_append() substitutes the write
pointer of the zone for the offset and hands the request to raw_co_prw(),
which reaches handle_aiocb_rw_vector() and issues a plain pwritev(). The
kernel never sees a zone append, so the attribute describes a limit on an
operation that is never issued.

Nor is it a limit that this driver runs into. The kernel splits a write
that exceeds the transfer limit rather than refusing it, so a larger
append succeeds: on a null_blk device whose zone_append_max_bytes is
130560, a 16 MiB append completes and advances the write pointer by
16 MiB. Reporting the attribute only understates what the driver can do,
because Linux derives it as a minimum that already includes max_sectors
and chunk_sectors.

Report max_hw_transfer instead, the limit that governs the write the
driver actually issues. There is no use in telling a guest that it may
append more than the device carries in one command, and a frontend then
does not have to reason about how this driver implements an append in
order to bound the value it advertises.

On a null_blk device with max_hw_sectors_kb of 127 and
zone_append_max_bytes of 130560, virtio-blk reports 255 sectors before
and after.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c1ac49d23d..0e92ff8414 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1488,10 +1488,15 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     }
     bs->bl.nr_zones = ret;
 
-    ret = get_sysfs_long_val(st, "zone_append_max_bytes");
-    if (ret > 0) {
-        bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
-    }
+    /*
+     * raw_co_zone_append() carries out an append as an ordinary write at the
+     * write pointer, so the zone_append_max_bytes attribute, which bounds an
+     * operation that this driver never issues, does not apply. The kernel
+     * splits a write that is larger than the transfer limit rather than
+     * refusing it, but there is no use in telling a guest that it may append
+     * more than the device carries in one command.
+     */
+    bs->bl.max_append_sectors = bs->bl.max_hw_transfer >> BDRV_SECTOR_BITS;
 
     ret = get_sysfs_long_val(st, "zone_write_granularity");
     if (ret >= 0) {
-- 
2.55.0


