Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4582AC3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 01:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48Sw-0001oZ-Kt; Sun, 13 Apr 2025 21:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1u48Sv-0001oI-6h; Sun, 13 Apr 2025 21:18:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1u48Ss-0001wD-SP; Sun, 13 Apr 2025 21:18:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so42185185e9.2; 
 Sun, 13 Apr 2025 18:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744593500; x=1745198300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AFu5qTvL8qDGLhfVf2cgq04HLl4krLoPHAgJSXoIUZQ=;
 b=NJAHw47JqrNGymE73pZib6loQpOkzTFTeAVsUVG8qkXEK6OB3bCyhWj9eppzju6lWS
 xMa/zFWRfVoUSP6WD0PR5S9h6HrGOu6JF88wOhHfVEAic/tKWbKJyu4ufEByfDMDSzP6
 w+nrVhtS6z780nc3XvxStakp27FAqP3IdueGfV6s3WrwBHL6Un5xLeGqouU3hS8wyrWV
 Rb/kDWxGCI+04JUxX8HQgP5hI6KdaIUFDqLdZHRGSIS1Hgw3g0xUV2R7TCHzEoQKxAlx
 sWLHqMD98kKTc1CNXsncn6AF9R7aVwY+RMJ2uOHiT7P9qlIlX0a7U5BoAxUE1m2sCYhO
 esyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744593500; x=1745198300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFu5qTvL8qDGLhfVf2cgq04HLl4krLoPHAgJSXoIUZQ=;
 b=ULB/xFQa4+12mgMx3jTVcQrzs5mGvUJLKqIfMVhG3nihZSxFGu4E/1g+2S1RJ6qDbi
 hpjqBokyiEmpJzKYcN+NFQNpM2RQw9rwVo6R8LhzIh4DQYEJMltNqVQ/E6dNUjkNaJEq
 0GdHalRxpA4u0zjIWkTtQ+lDh3k4yDUaykvr55GGRGSy9yFJ6tl2DrEj9mIXixxn5BfE
 Py8Nph3Zz7buC0WItUcjjXsEfVnrGFUMY8curx76QRXm+2D47dYfnNpSLP/6nbttQlKw
 o8SuEf7r3cpC9xYRsnn7xMGYC7gBf02MTKUyMHxjJlSa4Oe6kMSJa/J+Z8nZa2cc4WPg
 1a6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwmw1pF30rhUV7UlRc86DpaeSmeimQOWZExgIbYJS8g6izqLoarxAQy+HNGWOmYNvFB8Go6xFINGlR@nongnu.org
X-Gm-Message-State: AOJu0YwhunBIfCTO83ktLamx/yp+CgmGsawzhCgvjdm7TvoAbnVJE7ik
 Hv0FgLfvC6eN8AE+yvaCXNAOhcQlQg/oMXOJjPRhjOofCtyzqbYxisGhfUk6
X-Gm-Gg: ASbGncuVHVKaPnQ+qrydxnIpCVyzotoGcZwBnwArLQ2VO5KcN33XJXbtRTUz6B7NuKo
 a26B17zsZEk8e2sg2fce7ooJZE1H1UwOsqQIeCWxOtFtTwvcLdCA5vigiFaW26JF/+GdwDhk8jM
 jSBY8sINKFpmla2k/lz/WNyNWldi95UjpkEN43Qztg1+eejxpk2qAYdPQ9oR1TfdzlcHeLWPCLu
 b9XQVEcaLxovtyMaCteaM0MS3Grnc9VG2gnAkGGoNfa1QWkCkVXvtArREqQh8R7OFjfdPMncdpD
 zRtcNoxuEOQy3hNF62waxnR74Gpt5PxPLEPUN9Q9fjC0w42yUgjO4j2oW1uT/nlI5e1O/xmRi1v
 zkW7GNu4i/F4buO8Jxw==
X-Google-Smtp-Source: AGHT+IFhgzmCw79GbwGChd0kOPnZXBmqjaIxwsgRzVoogVuu81Xveo1vjKEpVJQaiXDwh10a2j+4Ow==
X-Received: by 2002:a05:600c:3b0d:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-43f3a9ab46cmr70453855e9.20.1744593500072; 
 Sun, 13 Apr 2025 18:18:20 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-227-248.bb.vodafone.cz.
 [86.49.227.248]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5e9dsm163629885e9.36.2025.04.13.18.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 18:18:19 -0700 (PDT)
From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
X-Google-Original-From: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>
To: qemu-devel@nongnu.org
Cc: Wen Congyang <wencongyang2@huawei.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>
Subject: [PATCH v3] blockdev-backup: Add error handling option for
 copy-before-write jobs
Date: Mon, 14 Apr 2025 03:18:17 +0200
Message-ID: <20250414011817.671328-1-Raman.Dzehtsiar@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=raman.dzehtsiar@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 block/backup.c                                |  3 +-
 block/copy-before-write.c                     |  2 +
 block/copy-before-write.h                     |  1 +
 block/replication.c                           |  4 +-
 blockdev.c                                    |  6 ++
 include/block/block_int-global-state.h        |  2 +
 qapi/block-core.json                          |  4 +
 tests/qemu-iotests/tests/copy-before-write    | 90 +++++++++++++++++++
 .../qemu-iotests/tests/copy-before-write.out  |  4 +-
 9 files changed, 112 insertions(+), 4 deletions(-)

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
index 0020f33843..748cf648ec 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -584,7 +584,9 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
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
index b1937780e1..d35326167d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1622,6 +1622,9 @@
 # @discard-source: Discard blocks on source which have already been
 #     copied to the target.  (Since 9.1)
 #
+# @on-cbw-error: optional policy defining behavior on I/O errors in
+#     copy-before-write jobs; defaults to break-guest-write.  (Since 10.0)
+#
 # @x-perf: Performance options.  (Since 6.0)
 #
 # Features:
@@ -1641,6 +1644,7 @@
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
+            '*on-cbw-error': 'OnCbwError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
             '*filter-node-name': 'str',
             '*discard-source': 'bool',
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 498c558008..23d70c7fe7 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -99,6 +99,66 @@ class TestCbwError(iotests.QMPTestCase):
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
+        result = self.vm.qmp('human-monitor-command', command_line='qemu-io cbw "write 0 1M"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('human-monitor-command', command_line='qemu-io access "read 0 1M"')
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
@@ -123,6 +183,36 @@ read failed: Permission denied
 write failed: Input/output error
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+""")
+
+    def test_break_snapshot_policy_forwarding(self):
+        """Ensure CBW filter accepts break-snapshot policy specified in blockdev-backup QMP command.
+        """
+        log = self.do_cbw_error_via_blockdev_backup('break-snapshot')
+        self.assertEqual(log, """\
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read failed: Permission denied
+""")
+
+    def test_break_guest_write_policy_forwarding(self):
+        """Ensure CBW filter accepts break-guest-write policy specified in blockdev-backup QMP command.
+        """
+        log = self.do_cbw_error_via_blockdev_backup('break-guest-write')
+        self.assertEqual(log, """\
+write failed: Input/output error
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+""")
+
+    def test_default_on_cbw_error_policy_forwarding(self):
+        """Ensure break-guest-write policy is used by default when on-cbw-error is not explicitly specified.
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
2.43.0


