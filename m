Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36377C282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOOo-0002wZ-WB; Tue, 04 Mar 2025 04:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1tpOOm-0002wE-Sq; Tue, 04 Mar 2025 04:17:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1tpOOh-0006MP-VL; Tue, 04 Mar 2025 04:17:09 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso2799029f8f.3; 
 Tue, 04 Mar 2025 01:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741079825; x=1741684625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4C/8pbm9T5oXRkdca4gSEac7EXi6xynKIRzYnRYB2bg=;
 b=D8JVCXx0a7zJ4vvL5z2iZhaWgdN8SrM/EPf7TB3z/4s+r7Rv/JheNKR12umu1ij0fh
 l6TWiBID2ntXxEw4nAV7ihkLGdyrQD65UkLy+nqdAItY6skBlQFQ9chHfxsBtvzUa2ZF
 wZRJV+99cqAsIvGlyn7xvSLehq6kMeY8S4ObelGSqkUrP+l0cSJDzWlfBLnezP7Pjp+c
 foe4erJspYXyKrC7VUmJwB/4mABNmEStQ1+IIzWLKWsZrJV7Bpr9dWY1wF1sAMO9BEUR
 9JowLmyxWpsF+OefKcQP/bN/OX/Siv4SH3dC9ILjshZRUAwiQfSYTvJQxkqh7pZ5SDNq
 jq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741079825; x=1741684625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4C/8pbm9T5oXRkdca4gSEac7EXi6xynKIRzYnRYB2bg=;
 b=fzl4sEildGOR+A4fEQksORfE6ezGTwJIA74fveyYPCCnMCMPaCqnpuQAwZUOvOT05+
 QCGuY3RCYhpBj12sI3aCDUSMUGuvZnbd/UA1VqZ8r9UrXqqpcloOl+5UGMsTh+zrgxSB
 A257BP8ne1QniSlfuhW9eidXSyN9DbUUvaEcIhk8tQ8apgy3zYXPkxYGKb8Gis4QW89V
 3RoWbWmreQ4wDcA8jigFcXLYy2pI3Ihmdu4BNTALZPmuD2dTqFEhjpWzA81zYZG9QNgk
 KZRMwEbrLnRmgmsamQBQhIa0Vomj85f1mSnWJJOO0v1cGBC+fImS3BMXDEZpSweyhJsC
 7Gsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3hZwAz+oTl4bAreIjLE+dWy6N2fMv3V97o0uygoNGemJBIg6pjdLZSRsQKLmNsDCmwGGBelM295qH@nongnu.org
X-Gm-Message-State: AOJu0Yz7EtHRLc6Lo9vAn0lqvQzR2e4D9IOFZSoKVhPZWRwLFLNBRlzq
 bUxivfm4rh1P8zIWJmJIhrxPYABw6bhoy3oivytlT0snwtvue8saxVjtWJ6l
X-Gm-Gg: ASbGncscFp2lMyZyLPC7QyLeidJNkR+WHmROri3r2PlAxZt+8g76mgP8hc276sQLnY+
 6AhqiEOueTdjbtuAxo40EpVMrBL3mwOrD0t3qrPXGxL3zsUAylHtAPTYcjeZPnbSaFBAW5LUc+Y
 aIDt8+sTqbXVb3MEUZzO2jxBNEBdf1bR7LnlDYFSyqMKU4cPjIJhZ+Lc6eiZJOHBiJj1tA+hCRt
 eZuQPVn5DBWJqfVmGwCa8LcSzfzWwxbqkmnj1YNO05fyb5ttyMV8l/HsOFdA82v6QXJiYW8yF56
 O/djDbNn8UD91Sqgcrnmd8jfm2peOg3ddHxuCRYXF6v2MjdWQ9k6Jh3EEpe3tYCkG6skr1lo1KJ
 DlYgGb4TcmAp48fgicRdt4Q==
X-Google-Smtp-Source: AGHT+IGAU8zUrUgGBPysnDZUbwVG7t4Zt7LAFLukH+j3zu3nJRnRfLbLxGv9jXficnTYL+Ba4XONWA==
X-Received: by 2002:a05:6000:4404:b0:390:ded5:ce1d with SMTP id
 ffacd0b85a97d-390ec9cc0b7mr9038685f8f.33.1741079825326; 
 Tue, 04 Mar 2025 01:17:05 -0800 (PST)
Received: from localhost.localdomain (ip-86-49-227-248.bb.vodafone.cz.
 [86.49.227.248]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484451fsm17387473f8f.63.2025.03.04.01.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 01:17:05 -0800 (PST)
From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
X-Google-Original-From: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>
Subject: [PATCH v2] blockdev-backup: Add error handling option for
 copy-before-write jobs
Date: Tue,  4 Mar 2025 10:17:03 +0100
Message-ID: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=raman.dzehtsiar@gmail.com; helo=mail-wr1-x42b.google.com
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
 block/backup.c                         | 3 ++-
 block/copy-before-write.c              | 2 ++
 block/copy-before-write.h              | 1 +
 block/replication.c                    | 4 +++-
 blockdev.c                             | 6 ++++++
 include/block/block_int-global-state.h | 2 ++
 qapi/block-core.json                   | 4 ++++
 7 files changed, 20 insertions(+), 2 deletions(-)

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
index ee6eccc68c..3a7cf82b57 100644
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
-- 
2.43.0


