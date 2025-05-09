Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21369C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 20:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDUa7-0004Qm-Mo; Fri, 09 May 2025 16:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZz-0004NS-T0
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDUZw-0000kG-1P
 for qemu-devel@nongnu.org; Fri, 09 May 2025 16:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746823458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELFByXK3STJM1F1yb6cif6MsPlsVQAZEBApnkzTFsog=;
 b=fW4j/JoFZO1ycW3tY/mIdcHJDvjICE9GanRdtO3+TEx0Xo9vJ7+LZ+o76aas5pB1KT75Xq
 vnhokewNTzDUTCPuJI66c50dt0YV9WA5ispW81PowmrRhP7DWsbGdZ4HQ/n7dhtZWpEXVJ
 E3J0ejRao30GytmUe+mG6wuW6dOc1D0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-sQuXddrnMk6d6iW-sPwfcA-1; Fri,
 09 May 2025 16:44:17 -0400
X-MC-Unique: sQuXddrnMk6d6iW-sPwfcA-1
X-Mimecast-MFC-AGG-ID: sQuXddrnMk6d6iW-sPwfcA_1746823456
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A12041956089; Fri,  9 May 2025 20:44:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6EC630001A1; Fri,  9 May 2025 20:44:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 10/13] mirror: Skip pre-zeroing destination if it is
 already zero
Date: Fri,  9 May 2025 15:40:27 -0500
Message-ID: <20250509204341.3553601-25-eblake@redhat.com>
In-Reply-To: <20250509204341.3553601-15-eblake@redhat.com>
References: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When doing a sync=full mirroring, we can skip pre-zeroing the
destination if it already reads as zeroes and we are not also trying
to punch holes due to detect-zeroes.  With this patch, there are fewer
scenarios that have to pass in an explicit target-is-zero, while still
resulting in a sparse destination remaining sparse.

A later patch will then further improve things to skip writing to the
destination for parts of the image where the source is zero; but even
with just this patch, it is possible to see a difference for any
source that does not report itself as fully allocated, coupled with a
destination BDS that can quickly report that it already reads as zero.
(For a source that reports as fully allocated, such as a file, the
rest of mirror_dirty_init() still sets the entire dirty bitmap to
true, so even though we avoided the pre-zeroing, we are not yet
avoiding all redundant I/O).

Iotest 194 detects the difference made by this patch: for a file
source (where block status reports the entire image as allocated, and
therefore we end up writing zeroes everywhere in the destination
anyways), the job length remains the same.  But for a qcow2 source and
a destination that reads as all zeroes, the dirty bitmap changes to
just tracking the allocated portions of the source, which results in
faster completion and smaller job statistics.  For the test to pass
with both ./check -file and -qcow2, a new python filter is needed to
mask out the now-varying job amounts (this matches the shell filters
_filter_block_job_{offset,len} in common.filter).  A later test will
also be added which further validates expected sparseness, so it does
not matter that 194 is no longer explicitly looking at how many bytes
were copied.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

v3: add exemption for "detect-zeroes":"unmap" on destination
v4: Rebase later in series, revise logic for pre-zeroing [Sunny], add
in python filter
---
 block/mirror.c                | 24 ++++++++++++++++--------
 tests/qemu-iotests/194        |  6 ++++--
 tests/qemu-iotests/194.out    |  4 ++--
 tests/qemu-iotests/iotests.py | 12 +++++++++++-
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index d04db85883d..bca99ec206b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -848,23 +848,31 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
         target_bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
         bdrv_can_write_zeroes_with_unmap(target_bs);

+    /* Determine if the image is already zero, regardless of sync mode.  */
     bdrv_graph_co_rdlock();
     bs = s->mirror_top_bs->backing->bs;
+    if (s->target_is_zero) {
+        ret = 1;
+    } else {
+        ret = bdrv_co_is_all_zeroes(target_bs);
+    }
     bdrv_graph_co_rdunlock();

-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
+    /* Determine if a pre-zeroing pass is necessary.  */
+    if (ret < 0) {
+        return ret;
+    } else if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
         /* In TOP mode, there is no benefit to a pre-zeroing pass.  */
-    } else if (!s->target_is_zero || punch_holes) {
+    } else if (ret == 0 || punch_holes) {
         /*
          * Here, we are in FULL mode; our goal is to avoid writing
          * zeroes if the destination already reads as zero, except
          * when we are trying to punch holes.  This is possible if
-         * zeroing happened externally (s->target_is_zero) or if we
-         * have a fast way to pre-zero the image (the dirty bitmap
-         * will be populated later by the non-zero portions, the same
-         * as for TOP mode).  If pre-zeroing is not fast, or we need
-         * to punch holes, then our only recourse is to write the
-         * entire image.
+         * zeroing happened externally (ret > 0) or if we have a fast
+         * way to pre-zero the image (the dirty bitmap will be
+         * populated later by the non-zero portions, the same as for
+         * TOP mode).  If pre-zeroing is not fast, or we need to punch
+         * holes, then our only recourse is to write the entire image.
          */
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index d0b9c084f5f..e114c0b2695 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -62,7 +62,8 @@ with iotests.FilePath('source.img') as source_img_path, \

     iotests.log('Waiting for `drive-mirror` to complete...')
     iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
-                filters=[iotests.filter_qmp_event])
+                filters=[iotests.filter_qmp_event,
+                         iotests.filter_block_job])

     iotests.log('Starting migration...')
     capabilities = [{'capability': 'events', 'state': True},
@@ -88,7 +89,8 @@ with iotests.FilePath('source.img') as source_img_path, \

     while True:
         event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
-        iotests.log(event2, filters=[iotests.filter_qmp_event])
+        iotests.log(event2, filters=[iotests.filter_qmp_event,
+                                     iotests.filter_block_job])
         if event2['event'] == 'BLOCK_JOB_COMPLETED':
             iotests.log('Stopping the NBD server on destination...')
             iotests.log(dest_vm.qmp('nbd-server-stop'))
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 6940e809cde..d02655a5147 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -7,7 +7,7 @@ Launching NBD server on destination...
 Starting `drive-mirror` on source...
 {"return": {}}
 Waiting for `drive-mirror` to complete...
-{"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror-job0", "len": "LEN", "offset": "OFFSET", "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Starting migration...
 {"return": {}}
 {"execute": "migrate-start-postcopy", "arguments": {}}
@@ -18,7 +18,7 @@ Starting migration...
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
-{"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror-job0", "len": "LEN", "offset": "OFFSET", "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
 Wait for migration completion on target...
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7292c8b342a..05274772ce4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -601,13 +601,23 @@ def filter_chown(msg):
     return chown_re.sub("chown UID:GID", msg)

 def filter_qmp_event(event):
-    '''Filter a QMP event dict'''
+    '''Filter the timestamp of a QMP event dict'''
     event = dict(event)
     if 'timestamp' in event:
         event['timestamp']['seconds'] = 'SECS'
         event['timestamp']['microseconds'] = 'USECS'
     return event

+def filter_block_job(event):
+    '''Filter the offset and length of a QMP block job event dict'''
+    event = dict(event)
+    if 'data' in event:
+        if 'offset' in event['data']:
+            event['data']['offset'] = 'OFFSET'
+        if 'len' in event['data']:
+            event['data']['len'] = 'LEN'
+    return event
+
 def filter_qmp(qmsg, filter_fn):
     '''Given a string filter, filter a QMP object's values.
     filter_fn takes a (key, value) pair.'''
-- 
2.49.0


