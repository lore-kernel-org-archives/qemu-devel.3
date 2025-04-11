Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78959C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32sG-0006PL-G8; Thu, 10 Apr 2025 21:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s2-0006Jl-Nb
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s0-0004Hu-PG
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744333666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EASWrraCDe2OY7CxlBPxAydbR9lQkSoQFeo8vUUvJb4=;
 b=SEpGqHn+VodU23PVQgSoYQtYPTdB48fuiNQ2/B6WF+JBH8vZblmcM13BYiMtdG1J5HPWHE
 59yoDQ0XTiXULV0gLuHlwMpJN3aZStQtnu+I1/YCOxVxQD/pfU+rho1M6KZ8G6v8pqxx87
 5+TkhGuzjeXO+5X79TrP7vTX0fE0AbQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-gD-KAv3mNcqU5ZwMMNK7xw-1; Thu,
 10 Apr 2025 21:07:43 -0400
X-MC-Unique: gD-KAv3mNcqU5ZwMMNK7xw-1
X-Mimecast-MFC-AGG-ID: gD-KAv3mNcqU5ZwMMNK7xw_1744333662
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EBD7180035E; Fri, 11 Apr 2025 01:07:42 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71C0A180174E; Fri, 11 Apr 2025 01:07:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PATCH 1/6] mirror: Skip pre-zeroing destination if it is already zero
Date: Thu, 10 Apr 2025 20:04:51 -0500
Message-ID: <20250411010732.358817-9-eblake@redhat.com>
In-Reply-To: <20250411010732.358817-8-eblake@redhat.com>
References: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When doing a sync=full mirroring, QMP drive-mirror requests full
zeroing if it did not just create the destination, and blockdev-mirror
requests full zeroing unconditionally.  This is because during a full
sync, we must ensure that the portions of the disk that are not
otherwise touched by the source still read as zero upon completion.

However, in mirror_dirty_init(), we were blindly assuming that if the
destination allows punching holes, we should pre-zero the entire
image; and if it does not allow punching holes, then treat the entire
source as dirty rather than mirroring just the allocated portions of
the source.  Without the ability to punch holes, this results in the
destination file being fully allocated; and even when punching holes
is supported, it causes duplicate I/O to the portions of the
destination corresponding to chunks of the source that are allocated
but read as zero.

Smarter is to avoid the pre-zeroing pass over the destination if it
can be proved the destination already reads as zero.  Note that a
later patch will then further improve things to skip writing to the
destination for parts of the image where the source is zero; but even
with just this patch, it is possible to see a difference for any BDS
that can quickly report that it already reads as zero.  Iotest 194 is
proof of this: instead of mirroring a completely sparse file, change
it to pre-populate some data.  When run with './check -file 194', the
full 1G is still allocated, but with './check -qcow2 194', only the 1M
of pre-populated data is now mirrored; this in turn requires an
additional log filter.

Note that there are still BDS layers that do not quickly report
reading as all zero; for example, the file-posix code implementation
for fast block status currently blindly reports the entire image as
allocated and non-zero without even consulting lseek(SEEK_DATA)); that
will be addressed in later patches.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/mirror.c             | 10 ++++++++--
 tests/qemu-iotests/194     | 15 +++++++++++++--
 tests/qemu-iotests/194.out |  4 ++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a53582f17bb..2e1e14c8e7e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -841,14 +841,20 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     int64_t offset;
     BlockDriverState *bs;
     BlockDriverState *target_bs = blk_bs(s->target);
-    int ret = -1;
+    int ret;
     int64_t count;

     bdrv_graph_co_rdlock();
     bs = s->mirror_top_bs->backing->bs;
+    if (s->zero_target) {
+        ret = bdrv_co_is_zero_fast(target_bs, 0, s->bdev_length);
+    }
     bdrv_graph_co_rdunlock();

-    if (s->zero_target) {
+    if (s->zero_target && ret <= 0) {
+        if (ret < 0) {
+            return ret;
+        }
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index c0ce82dd257..814c15dfe3b 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -22,6 +22,14 @@

 import iotests

+def filter_job_event(event):
+    '''Filter len and offset in a job event'''
+    event = dict(event)
+    if event['data'].get('len', 0) == event['data'].get('offset', 1):
+        event['data']['len'] = 'LEN'
+        event['data']['offset'] = 'LEN'
+    return event
+
 iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
                           supported_platforms=['linux'])

@@ -34,6 +42,7 @@ with iotests.FilePath('source.img') as source_img_path, \

     img_size = '1G'
     iotests.qemu_img_create('-f', iotests.imgfmt, source_img_path, img_size)
+    iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write 512M 1M', source_img_path)
     iotests.qemu_img_create('-f', iotests.imgfmt, dest_img_path, img_size)

     iotests.log('Launching VMs...')
@@ -61,7 +70,8 @@ with iotests.FilePath('source.img') as source_img_path, \

     iotests.log('Waiting for `drive-mirror` to complete...')
     iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
-                filters=[iotests.filter_qmp_event])
+                filters=[iotests.filter_qmp_event,
+                         filter_job_event])

     iotests.log('Starting migration...')
     capabilities = [{'capability': 'events', 'state': True},
@@ -87,7 +97,8 @@ with iotests.FilePath('source.img') as source_img_path, \

     while True:
         event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
-        iotests.log(event2, filters=[iotests.filter_qmp_event])
+        iotests.log(event2, filters=[iotests.filter_qmp_event,
+                                     filter_job_event])
         if event2['event'] == 'BLOCK_JOB_COMPLETED':
             iotests.log('Stopping the NBD server on destination...')
             iotests.log(dest_vm.qmp('nbd-server-stop'))
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 6940e809cde..79b961723d8 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -7,7 +7,7 @@ Launching NBD server on destination...
 Starting `drive-mirror` on source...
 {"return": {}}
 Waiting for `drive-mirror` to complete...
-{"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror-job0", "len": "LEN", "offset": "LEN", "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Starting migration...
 {"return": {}}
 {"execute": "migrate-start-postcopy", "arguments": {}}
@@ -18,7 +18,7 @@ Starting migration...
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
-{"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror-job0", "len": "LEN", "offset": "LEN", "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
 Wait for migration completion on target...
-- 
2.49.0


