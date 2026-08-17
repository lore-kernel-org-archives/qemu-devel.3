Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7793CC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww33N-0003Il-M1; Mon, 17 Aug 2026 15:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww331-0003E6-Hn; Mon, 17 Aug 2026 15:31:03 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww32y-00032i-IB; Mon, 17 Aug 2026 15:31:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 31C5A80B0F;
 Mon, 17 Aug 2026 22:30:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rUaw3t0XVW20-rL4r7NGk; Mon, 17 Aug 2026 22:30:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786995057;
 bh=3OpG9sABXUmzwyfNcO80xtzm/M5/oFBiNMWndqUczu0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jZQgv3OWB/UZa4UX0cunod557MH57CMQeMMK18hbPGiR6HRzB3PmtCd1RZLkfujxw
 5Mh9YoHCvZtMFnKSLnT+yD3J/XhcRFcJB5GZkieNETY0kkmWytnHrM+MJKsfvFaHO8
 e3ltgTG/V8NpsNz3Qyd3cUzsnKcMPKLJeOALjwN4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PULL 5/6] block/monitor: allow dropping a bitmap never stored on disk
Date: Mon, 17 Aug 2026 22:29:47 +0300
Message-ID: <20260817192948.1743452-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
References: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 block/monitor/bitmap-qmp-cmds.c                         | 4 ++--
 block/qcow2-bitmap.c                                    | 9 +++++++++
 tests/qemu-iotests/tests/remove-bitmap-from-backing.out | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

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
2.43.0


