Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE3DC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKB2-0002RV-R2; Thu, 16 Jul 2026 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKB0-0002Ko-FQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKAy-0005E6-0E
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so24108725e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784200966; x=1784805766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jUbV7alaeVOad4qQ8VoPOBfCbDLvwGK/15GYJMqehXk=;
 b=tzv2cKgNYralEw6f8GJDT5UipxQ0u9xxXkkTwDKr4wSg5Z6liuRky1VSYBIfb+Ug0m
 8PGItIHaGWeF8ECL45sf3xvyOyFjJIJpOi5tGJsr1L16nGal9JdgB9+F9uygvHZCEpDQ
 +2DwMVGpBjUMaekobHu2AznLh2eiJ0Tdzf8lK/wkGQTfKMMh7gGzXdeum6Kv+n1rMlJm
 1e4K3G3T2r5B6tKX2HeEXxtAMSxXzraSViv63lKlebyfDzoj8i1PhyZtNpa5vCeqBAvg
 1ke0k0uUJ/bRq1cBnYlKbx/MyM5my/8OKTMXk4N3WmDSS3QHYDdUX1dxewzXjii+Z+md
 H6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784200966; x=1784805766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jUbV7alaeVOad4qQ8VoPOBfCbDLvwGK/15GYJMqehXk=;
 b=nsE0TynWHoTkX96aKaNuYRCN+kkQiWxyBqvjxJbsv3nXI95kU1/h01Fq3i/lPSvkXm
 i46okbeqphiF5G0g5jBfjjBZM/QYftm0zrFs+4whuFYLaJiLd9+bc+ix8AdxmKuNUx9Z
 aPUf2h1d95XnIYPIfphMZ1276fa8YsdT53Cn1me30GRBbq2l9PdnieYq/firqto9CfwW
 YqJD5AFZoAd+A0zrJn/kabX6wFV2VgC3HgA/Hc9vk1pBi6GCNDbOKXKG1cy2qUAMvihz
 eW4Sl1BINXWa6kUJbfRei8eUIhirTXiUt8OiJcxzouiIIxukBGeoF99ewldFj99ft2JG
 gCng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4ffi1rfV4LpWN1T4TRINUTf8PzkBmrSAZObk8TkC5OsKnqCB/QfgGHH2Sg5wCMN1LA/3h70tBRgAL@nongnu.org
X-Gm-Message-State: AOJu0YxXPwoQSy9QI5+1jQR2Ji2xWn85JcGleGQzQJs+kscETDNiy3Sm
 LZ2ZTX56A2/Nc2rw3BVyIbILcFyd3OQwzHHv9ggl7YJWZ7lIG0e0NfZW2z79Nq1Qc74=
X-Gm-Gg: AfdE7cmiEqplZnCG7+rDL98UKiZzcuB4HADUPuHf7GNQzZyat88I/D675LhqXru041X
 9PvGed2Tm0h3TlilU0bg8mDs0zZdgJ4sz+T4+8OstGXKESvetnZjJcbUAUypvO7AbxOjEGEmwkt
 1WTkg9FsRHPfACTY+yqN7Yhl7wM6nxHX3yEL7f86XmAS1nmpMxMwo4alxZhuVYeU5btKURntzMT
 x67rvS1JlwmCeRUunQnNvGChc20VL9HhNU68JWjYFZs0tfcQ/x4yanvAjuQhRfXTWAmnEe0Vw5K
 lmfe1U7gpZqZXh7HYhWWfttUGlXaOXgz0PJm5GpbFKuCIJJ7gjtLDYivpJuG1NSLnI4AqMkwi/B
 uNh6II2zHnC+D7PrRBe1pcu0kWXnAEIp4N40a1BqjJB7O1eDNMjVj8pZru8vzh37WVpP+4Z5qj5
 I=
X-Received: by 2002:a05:600c:4fc3:b0:495:4598:6e13 with SMTP id
 5b1f17b1804b1-49545986eaemr6603995e9.17.1784200966198; 
 Thu, 16 Jul 2026 04:22:46 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4ca9:146f:3485:e2c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm24019672f8f.24.2026.07.16.04.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:22:45 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 1/3] block/monitor: reject persistent bitmap add on a
 read-only node
Date: Thu, 16 Jul 2026 13:22:40 +0200
Message-ID: <20260716112242.3000035-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112242.3000035-1-den@openvz.org>
References: <20260716112242.3000035-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/monitor/bitmap-qmp-cmds.c               | 15 +++++++---
 qapi/block-core.json                          |  4 ++-
 .../tests/remove-bitmap-from-backing          | 29 ++++++++++++++++++-
 .../tests/remove-bitmap-from-backing.out      | 20 +++++++++++++
 4 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index a738e7bbf7..d87ca982aa 100644
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
index 1f87b07850..199efc1e00 100644
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
index 15be32dcb9..a54984fa58 100755
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
index c28af82c75..fe105fe0a3 100644
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
2.53.0


