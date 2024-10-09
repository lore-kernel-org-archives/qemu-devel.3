Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF368CEE322
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYmr-00024O-Om; Wed, 09 Oct 2024 11:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syYmg-00021l-AZ; Wed, 09 Oct 2024 11:39:30 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syYme-0002xr-9E; Wed, 09 Oct 2024 11:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=a16rOx8Mx7X4vUpIortFX+Xm8EX1pnThfnQkZVTCJe0=; b=qKJct4BQoF1u
 E2TSTuc2060ymafIOjCfUMk7kUTMr1ACNh8smOq2OfR5uT9IEVGZZ1xSZ1NbF1sWt/F1FQuIQW56V
 HYwJ946IfM75p5p6efXfBSCAdoeTArC2i4zFjzRw4Dfcppi3CDbaGfD2M7sPvSNlJnl1PY7h68NwB
 YsQAOuLJUYA09oYfGjIE3f6t6w7n3fPieTQiyYAobNM9ArxaByFeaFdCvmzUdwoRkihWciSPBWJRk
 Ua7W1f1QT+Zpf6fcOHzEIVYn3IvyQRwwPkGmHNseqIBpt4+hF8EwVMS4lYnX/PeCplXivuK3puKny
 g9dzzPbcreaRfjKR35pX7w==;
Received: from [130.117.225.1] (helo=dev007.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1syYj2-00AZwM-2i;
 Wed, 09 Oct 2024 17:39:11 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/2] block/preallocate: fix image truncation logic
Date: Wed,  9 Oct 2024 18:37:37 +0300
Message-ID: <20241009153924.158721-3-den@openvz.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241009153924.158721-1-den@openvz.org>
References: <20241009153924.158721-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Recent QEMU changes around preallocate_set_perm mandates that it is not
possible to poll on aio_context inside this function anymore. Thus
truncate operation has been moved inside bottom half. This bottom half
is scheduled from preallocate_set_perm() and that is all.

This approach proven to be problematic in a lot of places once
additional operations are executed over preallocate filter in
production. The code validates that permissions have been really changed
just after the call to the set operation.

All permissions operations or block driver graph changes are performed
inside the quiscent state in terms of the block layer. This means that
there are no in-flight packets which is guaranteed by the passing
through bdrv_drain() section.

The idea is that we should effectively disable preallocate filter inside
bdrv_drain() and unblock permission changes. This section is definitely
not on the hot path and additional single truncate operation will not
hurt.

Unfortunately bdrv_drain_begin() callback according to the documentation
also disallow waiting inside. Thus original approach with the bottom
half is not changed. bdrv_drain_begin() schedules the operation and in
order to ensure that it has been really executed before completion of
the section increments the amount of in-flight requests.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Kevin Wolf <kwolf@redhat.com>
---
 block/preallocate.c    | 42 ++++++++++++++++++++++++++++++++++++++----
 tests/qemu-iotests/298 |  6 ++++--
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 1016c511cb..16a92a2e0d 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -78,6 +78,7 @@ typedef struct BDRVPreallocateState {
 
     /* Gives up the resize permission on children when parents don't need it */
     QEMUBH *drop_resize_bh;
+    bool    drop_resize_armed;
 } BDRVPreallocateState;
 
 static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
@@ -151,6 +152,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
      */
     s->file_end = s->zero_start = s->data_end = -EINVAL;
     s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
+    s->drop_resize_armed = false;
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
@@ -208,7 +210,7 @@ static void preallocate_close(BlockDriverState *bs)
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    qemu_bh_cancel(s->drop_resize_bh);
+    assert(!s->drop_resize_armed);
     qemu_bh_delete(s->drop_resize_bh);
 
     if (s->data_end >= 0) {
@@ -516,6 +518,8 @@ preallocate_drop_resize(BlockDriverState *bs, Error **errp)
     BDRVPreallocateState *s = bs->opaque;
     int ret;
 
+    s->drop_resize_armed = false;
+
     if (s->data_end < 0) {
         return 0;
     }
@@ -544,6 +548,12 @@ preallocate_drop_resize(BlockDriverState *bs, Error **errp)
 
 static void preallocate_drop_resize_bh(void *opaque)
 {
+    BlockDriverState *bs = opaque;
+
+     /*
+      * In case of errors, we'll simply keep the exclusive lock on the image
+      * indefinitely.
+      */
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
@@ -551,7 +561,9 @@ static void preallocate_drop_resize_bh(void *opaque)
      * In case of errors, we'll simply keep the exclusive lock on the image
      * indefinitely.
      */
-    preallocate_drop_resize(opaque, NULL);
+    preallocate_drop_resize(bs, NULL);
+
+    bdrv_dec_in_flight(bs);
 }
 
 static void GRAPH_RDLOCK
@@ -560,13 +572,13 @@ preallocate_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
     BDRVPreallocateState *s = bs->opaque;
 
     if (can_write_resize(perm)) {
-        qemu_bh_cancel(s->drop_resize_bh);
         if (s->data_end < 0) {
             s->data_end = s->file_end = s->zero_start =
                 bs->file->bs->total_sectors * BDRV_SECTOR_SIZE;
         }
     } else {
-        qemu_bh_schedule(s->drop_resize_bh);
+        assert(!s->drop_resize_armed);
+        assert(s->data_end < 0);
     }
 }
 
@@ -605,6 +617,26 @@ static int preallocate_check_perm(BlockDriverState *bs, uint64_t perm,
     return 0;
 }
 
+static void preallocate_drain_begin(BlockDriverState *bs)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (s->data_end < 0) {
+        return;
+    }
+    if (s->drop_resize_armed) {
+        return;
+    }
+    if (s->data_end == s->file_end) {
+        s->file_end = s->zero_start = s->data_end = -EINVAL;
+        return;
+    }
+
+    s->drop_resize_armed = true;
+    bdrv_inc_in_flight(bs);
+    qemu_bh_schedule(s->drop_resize_bh);
+}
+
 static BlockDriver bdrv_preallocate_filter = {
     .format_name = "preallocate",
     .instance_size = sizeof(BDRVPreallocateState),
@@ -613,6 +645,8 @@ static BlockDriver bdrv_preallocate_filter = {
     .bdrv_open            = preallocate_open,
     .bdrv_close           = preallocate_close,
 
+    .bdrv_drain_begin     = preallocate_drain_begin,
+
     .bdrv_reopen_prepare  = preallocate_reopen_prepare,
     .bdrv_reopen_commit   = preallocate_reopen_commit,
     .bdrv_reopen_abort    = preallocate_reopen_abort,
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index 09c9290711..fe03d29802 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -92,8 +92,10 @@ class TestPreallocateFilter(TestPreallocateBase):
         self.vm.cmd('block-commit', device='overlay')
         self.complete_and_wait()
 
-        # commit of new megabyte should trigger preallocation
-        self.check_big()
+        # commit of new megabyte should trigger preallocation, but drain
+        # will make file smaller
+        self.check_small()
+
 
     def test_reopen_opts(self):
         self.vm.cmd('blockdev-reopen', options=[{
-- 
2.43.5


