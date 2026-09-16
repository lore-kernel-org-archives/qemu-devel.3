Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8A3C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kJg-0004Qv-RZ; Wed, 16 Sep 2026 03:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJb-0004Im-3e; Wed, 16 Sep 2026 03:44:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJZ-0004vC-7w; Wed, 16 Sep 2026 03:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=z7bxXXvV/66OqYnZE1r4WylRnIdD/G5HmYgk9ZI9xc0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bAj+ibBF/BNNBH5+SY2QT1vxFGV+PB92Rk1InSE6luBWEdPovHjbAr5yPLOFs0P6Y
 TXVZRymbu7edMn0XNDN6mhdOLuAsU3C1oUFOZ53XLt9ZeBMOQco7YFblmp7R5KCimt
 4BH+QqkZuPXt8rKYkOCsU79dkIdi0ZgOIku6S1lWGyCbv60X1Ln/qVNAJn2ygTHGdu
 9H2/N2SnUep5f0V0MDGM8HAv172m6nK7vw2YiB+S+UfJhVDC7ov4dJVheL06VFmVE3
 2p1YvOISGW49isBqGlVvJViNzkfWK5NDmLW7MtANkdq7q/jJiFiNUalY5meMSF/74+
 uTR9z8IlJJmOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E1101D5594;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1926429B29;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A77235A6D3; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 09/49] migration/block-dirty-bitmap: reject bitmap
 load onto ro node
Date: Wed, 16 Sep 2026 10:42:27 +0300
Message-ID: <20260916074346.671467-9-mjt@tls.msk.ru>
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
(cherry picked from commit 3f3f5cdb929e8621699f92ee6e5018e1e6ea5bf2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index f2c352d4a71..ceec6fabf92 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -808,13 +808,6 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
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
@@ -831,6 +824,21 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
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
2.47.3


