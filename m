Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D0BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kJc-0004Ja-N3; Wed, 16 Sep 2026 03:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJa-0004Ie-RJ; Wed, 16 Sep 2026 03:44:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJY-0004v4-R4; Wed, 16 Sep 2026 03:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=IAzQZJLwIKGFokbBZGLR0vv6pMoi1pWhHw4arXbRyhQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FLyfhJPGe6v1rkD12QlfIJzfANHzPhwCZ1pAP8t13qaqHwdVP8I5zsW/7zLzcHXb3
 l99v1jX9yU2g3t/HPLfBf0StYyuVrAu//45w1RwTbNH4Uz0RoGlkKNws4IkxuiTBH9
 1Bs07IIZMfmseH4P5A3AeiiMIfWFpGGe0WfqGXDVuWA0fYkT4yrtrFbhQktWa1Fb5W
 1Jme3S+3emT03BgHZn4+iBOJiYP271DrWjwtK8nYw1lqdUjO6jWHPTTrTrGNU/QLze
 rjyWMAtUDABXIbsvxfoBSNwOMTqFsQDk2P8g03LE649/CGUpjNbUghuy7+MXqA4a/M
 swoK/3/QDCVig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3916B1D5593;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BC9D3429B28;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A44125A6D1; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 08/49] block/monitor: reject persistent bitmap add on
 a read-only node
Date: Wed, 16 Sep 2026 10:42:26 +0300
Message-ID: <20260916074346.671467-8-mjt@tls.msk.ru>
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

qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
checking write access to its node. bdrv_create_dirty_bitmap() always
creates bitmaps writable, so a persistent bitmap added to an
already read-only node stays writable in memory on a node that can
never store it, and the next global inactivation fails:

  Lost persistent bitmaps during inactivation of node '<node>': No write access
  migration_block_inactivate: bdrv_inactivate_all() failed: -22

Forcing it read-only instead does not help: it was never stored,
so it stays unpromotable on the next reopen to read-write and can
trip bdrv_set_dirty()'s readonly assert on the first write. Reject
the add instead, for both read-only and inactive nodes -- an
already-inactive node skips qcow2_inactivate() on close, so a
bitmap added during that window would never get stored either.
Wrapped in a transaction, this denies the whole transaction, since
qmp_transaction() is already all-or-none.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260716112242.3000035-2-den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 59ecd8a1ac3f05f572155a2d7a81fbeec397e2d3)
(Mjt: trivial fixup in qapi/block-core.json)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index a738e7bbf7a..d87ca982aa9 100644
--- a/block/monitor/bitmap-qmp-cmds.c
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -125,10 +125,17 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         disabled = false;
     }
 
-    if (persistent &&
-        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
-    {
-        return;
+    if (persistent) {
+        if (!bdrv_is_writable(bs)) {
+            error_setg(errp, "Cannot add a persistent bitmap to "
+                       "read-only or inactive node '%s'",
+                       bdrv_get_node_name(bs));
+            return;
+        }
+
+        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp)) {
+            return;
+        }
     }
 
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 09059b0a080..47b5f164864 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2263,7 +2263,9 @@
 # @persistent: the bitmap is persistent, i.e. it will be saved to the
 #     corresponding block device image file on its close.  For now
 #     only Qcow2 disks support persistent bitmaps.  Default is false
-#     for block-dirty-bitmap-add.  (Since: 2.10)
+#     for block-dirty-bitmap-add.  This fails if the node is
+#     read-only or inactive, since such a bitmap could never be
+#     stored.  (Since: 2.10)
 #
 # @disabled: the bitmap is created in the disabled state, which means
 #     that it will not track drive changes.  The bitmap may be enabled
diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing b/tests/qemu-iotests/tests/remove-bitmap-from-backing
index 15be32dcb96..a54984fa58e 100755
--- a/tests/qemu-iotests/tests/remove-bitmap-from-backing
+++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing
@@ -35,7 +35,7 @@ qemu_img('bitmap', '--add', base, 'bitmap0')
 # Just assert that our method of checking bitmaps in the image works.
 assert 'bitmaps' in qemu_img_info(base)['format-specific']['data']
 
-vm = iotests.VM().add_drive(top, 'backing.node-name=base')
+vm = iotests.VM().add_drive(top, 'node-name=top,backing.node-name=base')
 vm.launch()
 
 log('Trying to remove persistent bitmap from r-o base node, should fail:')
@@ -66,6 +66,33 @@ result = vm.qmp('blockdev-reopen', **new_base_opts)
 if result != {'return': {}}:
     log('Failed to reopen: ' + str(result))
 
+log('Adding a persistent bitmap to the r-o base node, should fail:')
+vm.qmp_log('block-dirty-bitmap-add', node='base', name='bitmap1',
+          persistent=True)
+
+log('Same add inside a transaction, preceded by an otherwise valid')
+log('action: the whole transaction must fail and roll back the')
+log('already-succeeded first action too:')
+vm.qmp_log('transaction', actions=[
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'top', 'name': 'bitmap2', 'persistent': True}},
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'base', 'name': 'bitmap1', 'persistent': True}},
+])
+
+log('bitmap2 on the rw top node must not have survived the rollback:')
+vm.qmp_log('block-dirty-bitmap-remove', node='top', name='bitmap2')
+
+log('Marking the rw top node inactive:')
+vm.qmp_log('blockdev-set-active', **{'node-name': 'top', 'active': False})
+
+log('Adding a persistent bitmap to a rw but inactive node, should fail:')
+vm.qmp_log('block-dirty-bitmap-add', node='top', name='bitmap3',
+          persistent=True)
+
+log('Reactivating the top node:')
+vm.qmp_log('blockdev-set-active', **{'node-name': 'top', 'active': True})
+
 vm.shutdown()
 
 if 'bitmaps' in qemu_img_info(base)['format-specific']['data']:
diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
index c28af82c752..fe105fe0a38 100644
--- a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
+++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
@@ -4,3 +4,23 @@ Trying to remove persistent bitmap from r-o base node, should fail:
 Remove persistent bitmap from base node reopened to RW:
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
 {"return": {}}
+Adding a persistent bitmap to the r-o base node, should fail:
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap1", "node": "base", "persistent": true}}
+{"error": {"class": "GenericError", "desc": "Cannot add a persistent bitmap to read-only or inactive node 'base'"}}
+Same add inside a transaction, preceded by an otherwise valid
+action: the whole transaction must fail and roll back the
+already-succeeded first action too:
+{"execute": "transaction", "arguments": {"actions": [{"data": {"name": "bitmap2", "node": "top", "persistent": true}, "type": "block-dirty-bitmap-add"}, {"data": {"name": "bitmap1", "node": "base", "persistent": true}, "type": "block-dirty-bitmap-add"}]}}
+{"error": {"class": "GenericError", "desc": "Cannot add a persistent bitmap to read-only or inactive node 'base'"}}
+bitmap2 on the rw top node must not have survived the rollback:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap2", "node": "top"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap2' not found"}}
+Marking the rw top node inactive:
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "top"}}
+{"return": {}}
+Adding a persistent bitmap to a rw but inactive node, should fail:
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap3", "node": "top", "persistent": true}}
+{"error": {"class": "GenericError", "desc": "Cannot add a persistent bitmap to read-only or inactive node 'top'"}}
+Reactivating the top node:
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "top"}}
+{"return": {}}
-- 
2.47.3


