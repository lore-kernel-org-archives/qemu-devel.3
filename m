Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0807FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww33t-0003Os-Se; Mon, 17 Aug 2026 15:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww330-0003E1-G2; Mon, 17 Aug 2026 15:31:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww32x-00032T-RV; Mon, 17 Aug 2026 15:31:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 8E46080B0E;
 Mon, 17 Aug 2026 22:30:57 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rUaw3t0XVW20-4gj4S6Z3; Mon, 17 Aug 2026 22:30:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786995056;
 bh=5RnyRJmuwjgpDZyKGCFUOKKFq8Hlu6VvFptd9ZcPzz8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Db9E6VZGQDAFouCiKHpf5vpKzakWE/ho0KQe8mJvR7ld5JmoJu7IujCkAuptECKL/
 lVf9Ff8sCwecOex/TERa2/IE4dbVPzXuTYs/w50BAPxpbrujRqQ9/YiwCwnSauM7ue
 SIUN+JprWWTESRrSw4e1IqG+yqXYkG8Ft5vqPGh4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PULL 4/6] migration/block-dirty-bitmap: reject bitmap load onto ro
 node
Date: Mon, 17 Aug 2026 22:29:46 +0300
Message-ID: <20260817192948.1743452-5-vsementsov@yandex-team.ru>
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

dirty_bitmap_load_start() creates an incoming migrated bitmap with
bdrv_create_dirty_bitmap() and, if the source marked it persistent,
calls bdrv_dirty_bitmap_set_persistence() without checking whether
the destination node can be written to. Same gap as
qmp_block_dirty_bitmap_add(), reached via incoming migration: a
persistent bitmap for a read-only destination (e.g. a migrated
CD-ROM-class attachment with dirty-bitmaps migration enabled) ends
up writable in memory on a node that can never store it.

Reject it the same way, with one difference from the QMP path:
every destination node is BDRV_O_INACTIVE until migration completes,
so bdrv_is_writable() would reject every incoming persistent
bitmap, not just read-only ones. Check bdrv_is_read_only() alone.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260716112242.3000035-3-den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/block-dirty-bitmap.c                | 22 +++++++++----
 tests/qemu-iotests/tests/migrate-bitmaps-test | 33 +++++++++++++++++++
 .../tests/migrate-bitmaps-test.out            |  4 +--
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index cba54e25cd5..1b8f39c12bb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -812,13 +812,6 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
         error_report("Bitmap with the same name ('%s') already exists on "
                      "destination", bdrv_dirty_bitmap_name(s->bitmap));
         return -EINVAL;
-    } else {
-        s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
-                                             s->bitmap_name, &local_err);
-        if (!s->bitmap) {
-            error_report_err(local_err);
-            return -EINVAL;
-        }
     }
 
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK) {
@@ -835,6 +828,21 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
         persistent = flags & DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
     }
 
+    /* Not bdrv_is_writable(): nodes stay inactive until migration ends. */
+    if (persistent && bdrv_is_read_only(s->bs)) {
+        error_report("Cannot make migrated bitmap '%s' persistent "
+                     "on read-only node '%s'", s->bitmap_name,
+                     bdrv_get_node_name(s->bs));
+        return -EINVAL;
+    }
+
+    s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
+                                         s->bitmap_name, &local_err);
+    if (!s->bitmap) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
     if (persistent) {
         bdrv_dirty_bitmap_set_persistence(s->bitmap, true);
     }
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index 8fb4099201d..cb9154ca8d7 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -206,6 +206,39 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.vm_b.launch()
             self.check_bitmap(self.vm_b, sha256 if persistent else False)
 
+    def test_migration_to_readonly_destination(self):
+        granularity = 512
+        mig_caps = [{'capability': 'events', 'state': True},
+                   {'capability': 'dirty-bitmaps', 'state': True}]
+
+        self.vm_b.add_incoming("defer")
+        self.vm_b.add_drive(disk_b, 'read-only=on')
+
+        self.add_bitmap(self.vm_a, granularity, True)
+        self.vm_a.hmp_qemu_io('drive0', 'write 0 4096')
+
+        self.vm_a.cmd('migrate-set-capabilities', capabilities=mig_caps)
+        self.vm_a.cmd('migrate', uri=mig_cmd)
+        while True:
+            event = self.vm_a.event_wait('MIGRATION')
+            if event['data']['status'] == 'completed':
+                break
+        self.vm_a.shutdown()
+
+        self.vm_b.launch()
+        self.vm_b.cmd('migrate-set-capabilities', capabilities=mig_caps)
+        self.vm_b.cmd('migrate-incoming', uri=incoming_cmd)
+        while True:
+            event = self.vm_b.event_wait('MIGRATION')
+            if event['data']['status'] in ('completed', 'failed'):
+                break
+
+        self.assert_qmp(event, 'data/status', 'failed')
+
+        # A failed incoming load makes the destination process exit on
+        # its own; reap it so tearDown()'s shutdown() is a clean no-op.
+        self.vm_b.wait()
+
 
 def inject_test_case(klass, suffix, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
index cafb8161f7b..73e375a9d74 100644
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test.out
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
@@ -1,5 +1,5 @@
-.....................................
+......................................
 ----------------------------------------------------------------------
-Ran 37 tests
+Ran 38 tests
 
 OK
-- 
2.43.0


