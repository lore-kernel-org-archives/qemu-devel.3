Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD2BCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzpk-0005bg-1U; Tue, 23 Jun 2026 08:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wbzpX-0005Wh-F5; Tue, 23 Jun 2026 08:02:21 -0400
Received: from sourceandstack.com ([159.223.220.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wbzpM-0007KY-FB; Tue, 23 Jun 2026 08:02:15 -0400
Received: from fedora-3.home (apoitiers-157-1-11-96.w90-5.abo.wanadoo.fr
 [90.5.14.96])
 by sourceandstack.com (Postfix) with ESMTPSA id EFA14480393B;
 Tue, 23 Jun 2026 12:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceandstack.com EFA14480393B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sourceandstack.com;
 s=mail; t=1782216117;
 bh=mOIXntCtGY2tNJg+SNyxis1KwpQJ54ZyjQzCTQ7i6Qg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FZe0buTYPbP420WazdFWfVf5exqp/jL+5NkHmqojA5yqQqZwB/uaBWiBS+F1lv7OU
 kWENM7/SEt5SzIKcPYSkFI2XqtDoRIfH6JOtiOCf7wNfIifWe5TdQlMDhGrYr7q3Ff
 CNGQ+ba1AD5BD9r2qIwvMKRJUKp17Wou4I9dXTtc=
From: Christian Hergert <christian@sourceandstack.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Christian Hergert <christian@sourceandstack.com>
Subject: [PATCH 1/1] block/vvfat: defer write commits to half-second timer
Date: Tue, 23 Jun 2026 14:01:47 +0200
Message-ID: <20260623120147.1626479-2-christian@sourceandstack.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623120147.1626479-1-christian@sourceandstack.com>
References: <20260623120147.1626479-1-christian@sourceandstack.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFA14480393B
X-Spamd-Result: default: False [1.40 / 15.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RSPAMD_EMAILBL_FAIL(0.00)[christian.sourceandstack.com:server
 fail,christian@sourceandstack.com:server fail]; 
 ASN(0.00)[asn:3215, ipnet:90.5.0.0/17, country:FR];
 ARC_NA(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: sourceandstack.com
Received-SPF: pass client-ip=159.223.220.208;
 envelope-from=christian@sourceandstack.com; helo=sourceandstack.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This keeps consistent reads but defers writes to a half-second timer by
implementing the suggested TODO in block/vvfat.c.

I noticed slow boot performance when testing a UKI image. It was roughly
18 seconds to a login prompt with a simple userspace. I profiled quickly
with Sysprof which showed an overwhelming amount of time spent in
check_directory_consistency().

The -drive in question here is the following:

 file=fat:rw:/tmp/machines-uki-esp-HVCXP3,format=raw,media=disk

which has a temporary NvVars in it for quick throwaway VM testing which
I use in conjunction with mkosi. Tests were updated to ensure that we
flush before checking stored contents.

With this commit in place, boot to login reduces from 18 seconds to 6.

Signed-off-by: Christian Hergert <christian@sourceandstack.com>
---
 block/vvfat.c                  | 130 +++++++++++++++++++++++++++++++--
 tests/qemu-iotests/tests/vvfat |  15 ++++
 2 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index e334b9febb..49756ac5e0 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -32,6 +32,7 @@
 #include "block/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/timer.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
 #include "qobject/qdict.h"
@@ -53,8 +54,6 @@
     Note that DOS assumes the system files to be the first files in the
     file system (test if the boot sector still relies on that fact)! */
 /* MAYBE TODO: write block-visofs.c */
-/* TODO: call try_commit() only after a timeout */
-
 /* #define DEBUG */
 
 #ifdef DEBUG
@@ -80,6 +79,8 @@ static void checkpoint(void);
 #define DIR_KANJI_FAKE 0x05
 #define DIR_FREE 0x00
 
+#define VVFAT_COMMIT_DELAY_NS (NANOSECONDS_PER_SECOND / 2)
+
 /* dynamic array functions */
 typedef struct array_t {
     char* pointer;
@@ -332,6 +333,8 @@ typedef struct BDRVVVFATState {
     void* fat2;
     char* used_clusters;
     array_t commits;
+    QEMUTimer *commit_timer;
+    bool commit_pending;
     const char* path;
     int downcase_short_names;
 
@@ -1052,6 +1055,8 @@ static BDRVVVFATState *vvv = NULL;
 
 static int enable_write_target(BlockDriverState *bs, Error **errp);
 static int coroutine_fn is_consistent(BDRVVVFATState *s);
+static void vvfat_attach_aio_context(BlockDriverState *bs,
+                                     AioContext *new_context);
 
 static QemuOptsList runtime_opts = {
     .name = "vvfat",
@@ -1278,6 +1283,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     qemu_co_mutex_init(&s->lock);
+    vvfat_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
     qemu_opts_del(opts);
 
@@ -2973,6 +2979,60 @@ DLOG(checkpoint());
     return do_commit(s);
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+vvfat_commit_now(BDRVVVFATState *s)
+{
+    int ret;
+
+    if (s->commit_timer) {
+        timer_del(s->commit_timer);
+    }
+    if (!s->commit_pending) {
+        return 0;
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = try_commit(s);
+    qemu_co_mutex_unlock(&s->lock);
+
+    if (ret == 0) {
+        s->commit_pending = false;
+    }
+
+    return ret;
+}
+
+static void coroutine_fn vvfat_commit_timer_entry(void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    BDRVVVFATState *s = bs->opaque;
+    GRAPH_RDLOCK_GUARD();
+
+    vvfat_commit_now(s);
+    bdrv_dec_in_flight(bs);
+}
+
+static void vvfat_commit_timer_cb(void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    Coroutine *co;
+
+    co = qemu_coroutine_create(vvfat_commit_timer_entry, bs);
+    bdrv_inc_in_flight(bs);
+    qemu_coroutine_enter(co);
+}
+
+static void vvfat_schedule_commit(BDRVVVFATState *s)
+{
+    s->commit_pending = true;
+
+    if (s->commit_timer) {
+        timer_mod_ns(s->commit_timer,
+                     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                     VVFAT_COMMIT_DELAY_NS);
+    }
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 vvfat_write(BlockDriverState *bs, int64_t sector_num,
             const uint8_t *buf, int nb_sectors)
@@ -3098,8 +3158,7 @@ DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sec
     }
 
 DLOG(checkpoint());
-    /* TODO: add timeout */
-    try_commit(s);
+    vvfat_schedule_commit(s);
 
 DLOG(checkpoint());
     return 0;
@@ -3133,6 +3192,34 @@ vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return ret;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+vvfat_co_flush(BlockDriverState *bs)
+{
+    BDRVVVFATState *s = bs->opaque;
+
+    if (s->qcow == NULL) {
+        return 0;
+    }
+
+    return vvfat_commit_now(s);
+}
+
+static void vvfat_drain_begin(BlockDriverState *bs)
+{
+    BDRVVVFATState *s = bs->opaque;
+    Coroutine *co;
+
+    if (!s->commit_timer || !timer_pending(s->commit_timer)) {
+        return;
+    }
+
+    timer_del(s->commit_timer);
+
+    co = qemu_coroutine_create(vvfat_commit_timer_entry, bs);
+    bdrv_inc_in_flight(bs);
+    aio_co_enter(bdrv_get_aio_context(bs), co);
+}
+
 static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
                                               unsigned int mode,
                                               int64_t offset, int64_t bytes,
@@ -3229,6 +3316,11 @@ static void vvfat_close(BlockDriverState *bs)
 {
     BDRVVVFATState *s = bs->opaque;
 
+    if (s->commit_timer) {
+        timer_free(s->commit_timer);
+        s->commit_timer = NULL;
+    }
+
     vvfat_close_current_file(s);
     array_free(&(s->fat));
     array_free(&(s->directory));
@@ -3240,6 +3332,30 @@ static void vvfat_close(BlockDriverState *bs)
     }
 }
 
+static void vvfat_detach_aio_context(BlockDriverState *bs)
+{
+    BDRVVVFATState *s = bs->opaque;
+
+    if (s->commit_timer) {
+        timer_free(s->commit_timer);
+        s->commit_timer = NULL;
+    }
+}
+
+static void vvfat_attach_aio_context(BlockDriverState *bs,
+                                     AioContext *new_context)
+{
+    BDRVVVFATState *s = bs->opaque;
+
+    if (s->qcow) {
+        s->commit_timer = aio_timer_new(new_context, QEMU_CLOCK_VIRTUAL,
+                                        SCALE_NS, vvfat_commit_timer_cb, bs);
+        if (s->commit_pending) {
+            vvfat_schedule_commit(s);
+        }
+    }
+}
+
 static const char *const vvfat_strong_runtime_opts[] = {
     "dir",
     "fat-type",
@@ -3263,7 +3379,11 @@ static BlockDriver bdrv_vvfat = {
 
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
-    .bdrv_co_block_status   = vvfat_co_block_status,
+    .bdrv_co_flush          = vvfat_co_flush,
+    .bdrv_drain_begin       = vvfat_drain_begin,
+    .bdrv_co_block_status    = vvfat_co_block_status,
+    .bdrv_detach_aio_context = vvfat_detach_aio_context,
+    .bdrv_attach_aio_context = vvfat_attach_aio_context,
 
     .strong_runtime_opts    = vvfat_strong_runtime_opts,
 };
diff --git a/tests/qemu-iotests/tests/vvfat b/tests/qemu-iotests/tests/vvfat
index acdc6ce8ff..1f67b4b200 100755
--- a/tests/qemu-iotests/tests/vvfat
+++ b/tests/qemu-iotests/tests/vvfat
@@ -148,6 +148,9 @@ class TestVVFatDriver(QMPTestCase):
 
         os.remove(temp_file)
 
+    def flush(self) -> None:
+        self.qio.cmd("flush")
+
     def init_fat16(self):
         mbr = MBR(self.read_sectors(0))
         return Fat16(
@@ -260,6 +263,7 @@ class TestVVFatDriver(QMPTestCase):
         data = fat16.read_cluster(file.cluster)
         fat16.write_cluster(file.cluster, data)
 
+        self.flush()
         with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
             self.assertEqual(fat16.read_file(file), f.read())
 
@@ -277,6 +281,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, b"Hello, world! 0\n")
         self.assertEqual(fat16.read_file(file), b"Hello, world! 0\n")
 
+        self.flush()
         with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
             self.assertEqual(f.read(), b"Hello, world! 0\n")
 
@@ -296,6 +301,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, new_content)
         self.assertEqual(fat16.read_file(file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -315,6 +321,7 @@ class TestVVFatDriver(QMPTestCase):
         new_content = fat16.read_file(file)
         self.assertEqual(new_content, b"Hello")
 
+        self.flush()
         with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -339,6 +346,7 @@ class TestVVFatDriver(QMPTestCase):
         self.assertEqual(new_content[:16], b"Hello, world! 0\n")
         self.assertEqual(len(new_content), 20)
 
+        self.flush()
         with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -358,6 +366,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, new_content)
         self.assertEqual(fat16.read_file(file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -373,6 +382,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.truncate_file(file, 1)
         self.assertEqual(fat16.read_file(file), b"A")
 
+        self.flush()
         with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
             self.assertEqual(f.read(), b"A")
 
@@ -389,6 +399,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, new_content)
         self.assertEqual(fat16.read_file(file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -411,6 +422,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, new_content)
         self.assertEqual(fat16.read_file(file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -431,6 +443,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, new_content)
         self.assertEqual(fat16.read_file(file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -456,6 +469,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(file, new_content)
         self.assertEqual(fat16.read_file(file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
@@ -474,6 +488,7 @@ class TestVVFatDriver(QMPTestCase):
         fat16.write_file(new_file, new_content)
         self.assertEqual(fat16.read_file(new_file), new_content)
 
+        self.flush()
         with open(os.path.join(filesystem, "newfile.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
 
-- 
2.54.0


