Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FE606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLx1tCd4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzTv-0006Rd-3L; Fri, 27 Nov 2026 12:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xWzTp-0006P5-Qb; Fri, 27 Nov 2026 12:11:27 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xWzTn-0001x4-S4; Fri, 27 Nov 2026 12:11:25 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EF256241D;
 Fri, 27 Nov 2026 17:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DD41F0089B;
 Fri, 27 Nov 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795799482;
 bh=YwKtfFOYZRYmpG1d/OIFWX2zgawqwY2QiDnt6ebLoxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BLx1tCd4Fy56DoVd0z9/Z0DLuxdhKNqs6AucnPGSBJ3uE0zDr2QUcqBZuoldJfWz3
 O6ezQC9pmxB0PYFasxWeRyTznMXqJbqKxMQJuZy6nrgZb0wmlAdrmDZ5ku2Z9Nfloa
 i1+yHZZIB/i2xYpsLCpCxDTFRtvUFwfYQaOsI9bjNPOc+X0+g3hq8xi45Tf7qn4D+I
 e/dCS13TrpQSv1MphN/vXSRzdhhdeeRD9lXZCt34gB//hGOgBBUpj0CR/hU2C6xcmQ
 x2V8hNo4xLZadeT+s9F+6pD8GcHLaz9eh5CFNIDioXTtFYz8H3FaC7JzWzIPLyH6aZ
 1jPeb97iDOsOw==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v19 01/11] block: write zeroes to a host managed device
 through the write path
Date: Fri, 27 Nov 2026 18:10:58 +0100
Message-ID: <20261127171108.3256778-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127171108.3256778-1-cassel@kernel.org>
References: <20261127171108.3256778-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a host managed zoned device, a write zeroes request moves the write
pointer, like a write. For a write zeroes request, however, file-posix
does not update the copy of the write pointer that it keeps for zone
appends, so the next zone append, also after a zero write that
detect-zeroes converts, fails with EIO.

Write the zeroes through the write path of the driver instead, which
updates the write pointer, and extend the zoned test.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Reported-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/io.c                         | 10 +++++++---
 tests/qemu-iotests/tests/zoned     |  9 +++++++++
 tests/qemu-iotests/tests/zoned.out | 12 ++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 0f81b7e6bb..7ee5598d43 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1918,15 +1918,19 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
         }
 
         ret = -ENOTSUP;
-        /* First try the efficient write zeroes operation */
-        if (drv->bdrv_co_pwrite_zeroes) {
+        /*
+         * First try the efficient write zeroes operation, except on a host
+         * managed zoned device, where only the write path checks and moves
+         * the write pointer: there, the zeroes are written as data below.
+         */
+        if (drv->bdrv_co_pwrite_zeroes && bs->bl.zoned != BLK_Z_HM) {
             ret = drv->bdrv_co_pwrite_zeroes(bs, offset, num,
                                              flags & bs->supported_zero_flags);
             if (ret != -ENOTSUP && (flags & BDRV_REQ_FUA) &&
                 !(bs->supported_zero_flags & BDRV_REQ_FUA)) {
                 need_flush = true;
             }
-        } else {
+        } else if (!drv->bdrv_co_pwrite_zeroes) {
             assert(!bs->supported_zero_flags);
         }
 
diff --git a/tests/qemu-iotests/tests/zoned b/tests/qemu-iotests/tests/zoned
index 3d23ce9cc1..c52e1f7fb4 100755
--- a/tests/qemu-iotests/tests/zoned
+++ b/tests/qemu-iotests/tests/zoned
@@ -99,6 +99,15 @@ $QEMU_IO $IMG -c "zap -p 268435456 0x1000 0x2000"
 echo "After appending the second zone secondly:"
 $QEMU_IO $IMG -c "zrp 268435456 1"
 
+echo
+echo "(7) append write after a zero write"
+$QEMU_IO $IMG -c "write -z 536870912 0x1000" -c "zap -p 536870912 0x1000" \
+    -c "zrp 536870912 1" | _filter_qemu_io
+echo
+echo "(8) append write after a zero write with detect-zeroes"
+$QEMU_IO $IMG,detect-zeroes=on -c "write -P 0 805306368 0x1000" \
+    -c "zap -p 805306368 0x1000" -c "zrp 805306368 1" | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/zoned.out b/tests/qemu-iotests/tests/zoned.out
index fe53ba4744..8a64676e38 100644
--- a/tests/qemu-iotests/tests/zoned.out
+++ b/tests/qemu-iotests/tests/zoned.out
@@ -66,4 +66,16 @@ start: 0x80000, len 0x80000, cap 0x80000, wptr 0x80018, zcond:2, [type: 2]
 After zap done, the append sector is 0x80018
 After appending the second zone secondly:
 start: 0x80000, len 0x80000, cap 0x80000, wptr 0x80030, zcond:2, [type: 2]
+
+(7) append write after a zero write
+wrote 4096/4096 bytes at offset 536870912
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+After zap done, the append sector is 0x100008
+start: 0x100000, len 0x80000, cap 0x80000, wptr 0x100010, zcond:2, [type: 2]
+
+(8) append write after a zero write with detect-zeroes
+wrote 4096/4096 bytes at offset 805306368
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+After zap done, the append sector is 0x180008
+start: 0x180000, len 0x80000, cap 0x80000, wptr 0x180010, zcond:2, [type: 2]
 *** done
-- 
2.56.1


