Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1419C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kJi-0004Uq-PW; Wed, 16 Sep 2026 03:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJg-0004SM-Uu; Wed, 16 Sep 2026 03:44:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJc-0004va-9o; Wed, 16 Sep 2026 03:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=wkr2SScfAHSFGujK19QskNfiVQUy+bDd6XfkKA8UHuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HhzciEVLMOC0T8h8T1+OHk+tCD3+mpvTQeJARQo/AZ0ugASkfUvSaAiqdJHmlBfij
 sf7YDTLaq3CZrP7lzOeSYL8QVMwvdoKJEDUbB/+AlVSi3lKE8CDVWH/AuUrt4V9r+n
 YiTzf4I2HM2QDdd50OyhV2VN9gzV8wFDsr4/sCOEPukDArNkfg7RrNCYy7PUZbp0p+
 b77+1GyQZRTOYe2opBf4zYBbeczwKxA/8QkpqRUtmWrJNQcNc6DFf7ajtkiSiXNjuU
 P2KL4eIN2fI78cbovY2ZwVtZc8LTEE7lCuUixz7c6/JUTPNM5xWRuxenFD2jawuMMm
 FE0Zyr+85yvag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 44D951D5595;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C61D6429B2A;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AAA165A6D5; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 10/49] block/monitor: allow dropping a bitmap never
 stored on disk
Date: Wed, 16 Sep 2026 10:42:28 +0300
Message-ID: <20260916074346.671467-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

block-dirty-bitmap-remove refuses any readonly bitmap outright, via
the generic BDRV_BITMAP_RO check in bdrv_dirty_bitmap_check(). That
check cannot tell whether the bitmap is actually on disk, so it also
blocks dropping one that only ever existed in memory, which needs no
write at all.

Drop the blanket check and let qcow2 decide: bdrv_remove_persistent_
dirty_bitmap() already treats an absent on-disk entry as a no-op, so
such a bitmap is now released with no write attempted. For one that
is genuinely stored, qcow2_co_remove_persistent_dirty_bitmap_locked()
now checks can_write() before it would update the on-disk directory,
so removal still fails there, with a message naming the actual
reason instead of just the bitmap's readonly flag.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260716112242.3000035-4-den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 9a77ef813f5f915bda408f4e53c11d0ca17c5d70)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index d87ca982aa9..aabf2790b67 100644
--- a/block/monitor/bitmap-qmp-cmds.c
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -165,11 +165,11 @@ BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
-                                errp)) {
+    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY, errp)) {
         return NULL;
     }
 
+    /* Dropping a bitmap needs no write access unless it is actually stored. */
     if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
         bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
     {
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 256ec998788..ac5a7245885 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1487,6 +1487,15 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
         goto out;
     }
 
+    if (!can_write(bs)) {
+        error_setg(errp, "Cannot remove persistent bitmap '%s': "
+                   "no write access to node '%s'", name,
+                   bdrv_get_node_name(bs));
+        ret = -EACCES;
+        bm = NULL;
+        goto out;
+    }
+
     QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
 
     ret = update_ext_header_and_dir(bs, bm_list);
diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
index fe105fe0a38..628fa737d97 100644
--- a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
+++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
@@ -1,6 +1,6 @@
 Trying to remove persistent bitmap from r-o base node, should fail:
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
-{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap0' is readonly and cannot be modified"}}
+{"error": {"class": "GenericError", "desc": "Cannot remove persistent bitmap 'bitmap0': no write access to node 'base'"}}
 Remove persistent bitmap from base node reopened to RW:
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
 {"return": {}}
-- 
2.47.3


