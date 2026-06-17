Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B99CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZqSN-0002R7-UB; Wed, 17 Jun 2026 09:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wZqS5-0002OI-Jd; Wed, 17 Jun 2026 09:37:12 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wZqS4-0002ge-1S; Wed, 17 Jun 2026 09:37:09 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D349142CED;
 Wed, 17 Jun 2026 13:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF2F1F000E9;
 Wed, 17 Jun 2026 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781703423;
 bh=bqTjn+8mllyHOP3DqA6ddPTOZuBQZL6QBGqU+zfuRN8=;
 h=From:To:Cc:Subject:Date;
 b=cOuizgnJMdteZXgs5g7msqCs/cq4dZ8DL9a040LiFQ8l/s7Dwx2LHcmaY578iL8Ur
 URZeHSgHffwovI1pIaTiBKbZefjsndIyTQjlunnPUWscn4YF1pnBSUlB3H9Ms+d510
 k3VwvghDklj1EF16jWgHUY1mYWb4wMIGbFJgtNFZ2vkjkA31Q29w4NpHR2XXeq4RsS
 60yCNsGmwN+aXjThQlZjuFMKiJwmXUcylIb8sr5XfYAAVrTxQJDNaiiyhHZd5ulzHp
 mDxYXwLV/8o7ukcMDaOQKZDY5Chv7VD4quT7LehgVHTeRwD/DOb95gbj4C3cuGJZxB
 6qECxOw2v9xHQ==
From: Niklas Cassel <cassel@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] file-posix: fix cache.direct=on check for zoned block
 devices
Date: Wed, 17 Jun 2026 15:36:58 +0200
Message-ID: <20260617133658.2022750-1-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

For zoned block devices with SWR zones, the order of the writes must be
maintained to avoid write not at write pointer errors.
Thus, cache.direct=on must be used to bypass the page cache, since the
page cache uses write-back caching, where the physical order of the writes
is not guaranteed.

There is already a check for cache.direct=on in raw_open_common(),
however, this check is done before raw_refresh_zoned_limits() has been
called (which initializes bs->bl.zoned), so it is currently dead code.

Fix this by moving the check to raw_refresh_zoned_limits(), such that the
check is done after bs->bl.zoned has been initialized.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Fixes: 774c726ceb2a ("block: add zoned BlockDriver check to block layer")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Picked up tags from Damien and Dmitry
-Modified existing code comment to use plural instead of singular

 block/file-posix.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5019ddade9..32750ac509 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -800,18 +800,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
             goto fail;
         }
     }
-#ifdef CONFIG_BLKZONED
-    /*
-     * The kernel page cache does not reliably work for writes to SWR zones
-     * of zoned block device because it can not guarantee the order of writes.
-     */
-    if ((bs->bl.zoned != BLK_Z_NONE) &&
-        (!(s->open_flags & O_DIRECT))) {
-        error_setg(errp, "The driver supports zoned devices, and it requires "
-                         "cache.direct=on, which was not specified.");
-        return -EINVAL; /* No host kernel page cache */
-    }
-#endif
 
 #ifdef __FreeBSD__
     if (S_ISCHR(st.st_mode)) {
@@ -1462,6 +1450,16 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     }
     bs->bl.zoned = zoned;
 
+    /*
+     * The kernel page cache does not reliably work for writes to SWR zones of
+     * zoned block devices because it can not guarantee the order of writes.
+     */
+    if (!(s->open_flags & O_DIRECT)) {
+        error_setg(errp, "The driver supports zoned devices, and it requires "
+                         "cache.direct=on, which was not specified.");
+        goto no_zoned;
+    }
+
     ret = get_sysfs_long_val(st, "max_open_zones");
     if (ret >= 0) {
         bs->bl.max_open_zones = ret;
-- 
2.54.0


