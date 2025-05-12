Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF94C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV6z-00016h-To; Mon, 12 May 2025 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uEV6H-0000fb-NZ; Mon, 12 May 2025 11:29:54 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uEV6D-00066D-T2; Mon, 12 May 2025 11:29:53 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:38c4:0:640:3b6a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7E98160C84;
 Mon, 12 May 2025 18:29:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b504::1:8])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fTHAn00FVCg0-6Ar38gLr; Mon, 12 May 2025 18:29:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1747063782;
 bh=chf03Ox//tfyKleijrldla86O6TVL2SLCnx4AMvAXEM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WUnAWUIJP9WLjD4pOHmx/sJ5W0+NC9As8pc0ywTm4tnem1eC9WBIvL5jmMdE2sola
 xDJ4Gs1sBwiahx9tRsUMrmc9qvtHIezPOe8edPM5VetMUwTkqxG9UAps7YL9HhRGE3
 92CJFAceqIt85Mw3UhYwKQkiVDeUEkMcwXAUwOP8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, stefanha@gmail.com,
 Raman Dzehtsiar <raman.dzehtsiar@gmail.com>,
 Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v3 8/8] blockdev-backup: Add error handling option for
 copy-before-write jobs
Date: Mon, 12 May 2025 18:29:40 +0300
Message-ID: <20250512152940.1294079-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250512152940.1294079-1-vsementsov@yandex-team.ru>
References: <20250512152940.1294079-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>

This patch extends the blockdev-backup QMP command to allow users to specify
how to behave when IO errors occur during copy-before-write operations.
Previously, the behavior was fixed and could not be controlled by the user.

The new 'on-cbw-error' option can be set to one of two values:
- 'break-guest-write': Forwards the IO error to the guest and triggers
  the on-source-error policy. This preserves snapshot integrity at the
  expense of guest IO operations.
- 'break-snapshot': Allows the guest OS to continue running normally,
  but invalidates the snapshot and aborts related jobs. This prioritizes
  guest operation over backup consistency.

This enhancement provides more flexibility for backup operations in different
environments where requirements for guest availability versus backup
consistency may vary.

The default behavior remains unchanged to maintain backward compatibility.

Signed-off-by: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>
Message-ID: <20250414090025.828660-1-Raman.Dzehtsiar@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[vsementsov: fix long lines]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c                                |  3 +-
 block/copy-before-write.c                     |  2 +
 block/copy-before-write.h                     |  1 +
 block/replication.c                           |  4 +-
 blockdev.c                                    |  6 ++
 include/block/block_int-global-state.h        |  2 +
 qapi/block-core.json                          |  4 +
 tests/qemu-iotests/tests/copy-before-write    | 95 +++++++++++++++++++
 .../qemu-iotests/tests/copy-before-write.out  |  4 +-
 9 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 79652bf57b..0151e84395 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -361,6 +361,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BackupPerf *perf,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
+                  OnCbwError on_cbw_error,
                   int creation_flags,
                   BlockCompletionFunc *cb, void *opaque,
                   JobTxn *txn, Error **errp)
@@ -458,7 +459,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     cbw = bdrv_cbw_append(bs, target, filter_node_name, discard_source,
-                          perf->min_cluster_size, &bcs, errp);
+                          perf->min_cluster_size, &bcs, on_cbw_error, errp);
     if (!cbw) {
         goto error;
     }
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index fd470f5f92..00af0b18ac 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -551,6 +551,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   bool discard_source,
                                   uint64_t min_cluster_size,
                                   BlockCopyState **bcs,
+                                  OnCbwError on_cbw_error,
                                   Error **errp)
 {
     BDRVCopyBeforeWriteState *state;
@@ -568,6 +569,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
     }
     qdict_put_str(opts, "file", bdrv_get_node_name(source));
     qdict_put_str(opts, "target", bdrv_get_node_name(target));
+    qdict_put_str(opts, "on-cbw-error", OnCbwError_str(on_cbw_error));
 
     if (min_cluster_size > INT64_MAX) {
         error_setg(errp, "min-cluster-size too large: %" PRIu64 " > %" PRIi64,
diff --git a/block/copy-before-write.h b/block/copy-before-write.h
index 2a5d4ba693..eb93364e85 100644
--- a/block/copy-before-write.h
+++ b/block/copy-before-write.h
@@ -42,6 +42,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   bool discard_source,
                                   uint64_t min_cluster_size,
                                   BlockCopyState **bcs,
+                                  OnCbwError on_cbw_error,
                                   Error **errp);
 void bdrv_cbw_drop(BlockDriverState *bs);
 
diff --git a/block/replication.c b/block/replication.c
index d6625c51fe..07f274de9e 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -583,7 +583,9 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, false,
                                 NULL, &perf,
                                 BLOCKDEV_ON_ERROR_REPORT,
-                                BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
+                                BLOCKDEV_ON_ERROR_REPORT,
+                                ON_CBW_ERROR_BREAK_GUEST_WRITE,
+                                JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
diff --git a/blockdev.c b/blockdev.c
index 1d1f27cfff..818ec42511 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2641,6 +2641,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
     BdrvDirtyBitmap *bmap = NULL;
     BackupPerf perf = { .max_workers = 64 };
     int job_flags = JOB_DEFAULT;
+    OnCbwError on_cbw_error = ON_CBW_ERROR_BREAK_GUEST_WRITE;
 
     if (!backup->has_speed) {
         backup->speed = 0;
@@ -2745,6 +2746,10 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         job_flags |= JOB_MANUAL_DISMISS;
     }
 
+    if (backup->has_on_cbw_error) {
+        on_cbw_error = backup->on_cbw_error;
+    }
+
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->bitmap_mode,
                             backup->compress, backup->discard_source,
@@ -2752,6 +2757,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
                             &perf,
                             backup->on_source_error,
                             backup->on_target_error,
+                            on_cbw_error,
                             job_flags, NULL, NULL, txn, errp);
     return job;
 }
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index eb2d92a226..0d93783763 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -179,6 +179,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  *        all ".has_*" fields are ignored.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
+ * @on_cbw_error: The action to take upon error in copy-before-write operations.
  * @creation_flags: Flags that control the behavior of the Job lifetime.
  *                  See @BlockJobCreateFlags
  * @cb: Completion function for the job.
@@ -198,6 +199,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BackupPerf *perf,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
+                            OnCbwError on_cbw_error,
                             int creation_flags,
                             BlockCompletionFunc *cb, void *opaque,
                             JobTxn *txn, Error **errp);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 22061227ca..91c70e24a7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1602,6 +1602,9 @@
 #     default 'report' (no limitations, since this applies to a
 #     different block device than @device).
 #
+# @on-cbw-error: policy defining behavior on I/O errors in
+#     copy-before-write jobs; defaults to break-guest-write.  (Since 10.1)
+#
 # @auto-finalize: When false, this job will wait in a PENDING state
 #     after it has finished its work, waiting for @block-job-finalize
 #     before making any block graph changes.  When true, this job will
@@ -1641,6 +1644,7 @@
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
+            '*on-cbw-error': 'OnCbwError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
             '*filter-node-name': 'str',
             '*discard-source': 'bool',
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 498c558008..236cb8ac37 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -99,6 +99,68 @@ class TestCbwError(iotests.QMPTestCase):
         log = iotests.filter_qemu_io(log)
         return log
 
+    def do_cbw_error_via_blockdev_backup(self, on_cbw_error=None):
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'source',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': source_img
+            }
+        })
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'blkdebug',
+                'image': {
+                    'driver': 'file',
+                    'filename': temp_img
+                },
+                'inject-error': [
+                    {
+                        'event': 'write_aio',
+                        'errno': 5,
+                        'immediately': False,
+                        'once': True
+                    }
+                ]
+            }
+        })
+
+        blockdev_backup_options = {
+            'device': 'source',
+            'target': 'target',
+            'sync': 'none',
+            'job-id': 'job-id',
+            'filter-node-name': 'cbw'
+        }
+
+        if on_cbw_error:
+            blockdev_backup_options['on-cbw-error'] = on_cbw_error
+
+        self.vm.cmd('blockdev-backup', blockdev_backup_options)
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'access',
+            'driver': 'snapshot-access',
+            'file': 'cbw'
+        })
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io cbw "write 0 1M"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io access "read 0 1M"')
+        self.assert_qmp(result, 'return', '')
+
+        self.vm.shutdown()
+        log = self.vm.get_log()
+        log = iotests.filter_qemu_io(log)
+        return log
+
     def test_break_snapshot_on_cbw_error(self):
         """break-snapshot behavior:
         Guest write succeed, but further snapshot-read fails, as snapshot is
@@ -123,6 +185,39 @@ read failed: Permission denied
 write failed: Input/output error
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+""")
+
+    def test_break_snapshot_policy_forwarding(self):
+        """Ensure CBW filter accepts break-snapshot policy
+        specified in blockdev-backup QMP command.
+        """
+        log = self.do_cbw_error_via_blockdev_backup('break-snapshot')
+        self.assertEqual(log, """\
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read failed: Permission denied
+""")
+
+    def test_break_guest_write_policy_forwarding(self):
+        """Ensure CBW filter accepts break-guest-write policy
+        specified in blockdev-backup QMP command.
+        """
+        log = self.do_cbw_error_via_blockdev_backup('break-guest-write')
+        self.assertEqual(log, """\
+write failed: Input/output error
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+""")
+
+    def test_default_on_cbw_error_policy_forwarding(self):
+        """Ensure break-guest-write policy is used by default when
+        on-cbw-error is not explicitly specified.
+        """
+        log = self.do_cbw_error_via_blockdev_backup()
+        self.assertEqual(log, """\
+write failed: Input/output error
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 """)
 
     def do_cbw_timeout(self, on_cbw_error):
diff --git a/tests/qemu-iotests/tests/copy-before-write.out b/tests/qemu-iotests/tests/copy-before-write.out
index 89968f35d7..2f7d3902f2 100644
--- a/tests/qemu-iotests/tests/copy-before-write.out
+++ b/tests/qemu-iotests/tests/copy-before-write.out
@@ -1,5 +1,5 @@
-....
+.......
 ----------------------------------------------------------------------
-Ran 4 tests
+Ran 7 tests
 
 OK
-- 
2.48.1


