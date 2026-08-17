Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EFEC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww33x-0003UX-7j; Mon, 17 Aug 2026 15:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww331-0003E8-QH; Mon, 17 Aug 2026 15:31:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww32x-00032O-Ta; Mon, 17 Aug 2026 15:31:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id C4D8B80B09;
 Mon, 17 Aug 2026 22:30:56 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rUaw3t0XVW20-LtnBpLII; Mon, 17 Aug 2026 22:30:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786995056;
 bh=rWTw2RiDpf/4J2CrXlG+TnOzcZJf+4Zlq07OFSZhshQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=k263rtlMU69VDOtmzvDFAbJeU4YXxSs2s0Eg0QAnAJ0tAz9nY66N+449nLaDzITLy
 0RUER0cGsTAdr1K1DFhIuExYJnYxjZgGfhMMetvEbQ96Nncav2S54JbmvVqOkML5EY
 vzChLCFOOc0g8Y1xGbY3pdZZbbeoIF2glSSzIQ58=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PULL 3/6] block/monitor: reject persistent bitmap add on a read-only
 node
Date: Mon, 17 Aug 2026 22:29:45 +0300
Message-ID: <20260817192948.1743452-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
References: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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
---
 block/monitor/bitmap-qmp-cmds.c               | 15 +++++++---
 qapi/block-core.json                          |  4 ++-
 .../tests/remove-bitmap-from-backing          | 29 ++++++++++++++++++-
 .../tests/remove-bitmap-from-backing.out      | 20 +++++++++++++
 4 files changed, 62 insertions(+), 6 deletions(-)

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
index 1f87b078505..199efc1e008 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2353,7 +2353,9 @@
 # @persistent: the bitmap is persistent, i.e. it will be saved to the
 #     corresponding block device image file on its close.  For now
 #     only Qcow2 disks support persistent bitmaps.  Default is false
-#     for `block-dirty-bitmap-add`.  (Since: 2.10)
+#     for `block-dirty-bitmap-add`.  This fails if the node is
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
2.43.0


