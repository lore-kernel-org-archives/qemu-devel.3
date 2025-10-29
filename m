Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7216CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xU-0003Da-Ph; Wed, 29 Oct 2025 08:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xG-00036X-If
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4x3-0004xb-AE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJ9Mv3zheL8yiMMy+qv9PakzcarQeBzCNL8821e9Hug=;
 b=MaT/P9+PJ5YwWn0e+7x1f5HFYzsDPF4AF4X1nd5jUmDoO7VL+c6Qpsv12LOzteLfqcu1oC
 lXYzUQq7avkSP8278CIVceuTqw4UK2f3c672NK76SAlfLaUbDvxL3cx9KYOkFLpdUVmriY
 4ktTJR6ifRvp0sjPxoblbwAL1fXJ+CU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-79B5HBJONfGDXQKdZqEr8w-1; Wed,
 29 Oct 2025 08:06:47 -0400
X-MC-Unique: 79B5HBJONfGDXQKdZqEr8w-1
X-Mimecast-MFC-AGG-ID: 79B5HBJONfGDXQKdZqEr8w_1761739606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69AEB180136E; Wed, 29 Oct 2025 12:06:46 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E60B0180057C; Wed, 29 Oct 2025 12:06:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/18] block/monitor: Use hmp_handle_error to report error
Date: Wed, 29 Oct 2025 13:06:20 +0100
Message-ID: <20251029120634.288467-5-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

According to writing-monitor-commands.rst, best practice is to
use the 'hmp_handle_error' function, which ensures that the
message gets an 'Error: ' prefix.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Message-ID: <20250916054850.40963-1-guobin@linux.alibaba.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
[kwolf: Fixed up iotests reference output]
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 45 +++++++++++++++++-----------------
 tests/qemu-iotests/267.out     |  8 +++---
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 282d1c386e..3640d1f3dc 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -62,7 +62,7 @@ static void hmp_drive_add_node(Monitor *mon, const char *optstr)
 {
     QemuOpts *opts;
     QDict *qdict;
-    Error *local_err = NULL;
+    Error *err = NULL;
 
     opts = qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
     if (!opts) {
@@ -73,19 +73,19 @@ static void hmp_drive_add_node(Monitor *mon, const char *optstr)
 
     if (!qdict_get_try_str(qdict, "node-name")) {
         qobject_unref(qdict);
-        error_report("'node-name' needs to be specified");
+        error_setg(&err, "'node-name' needs to be specified");
         goto out;
     }
 
-    BlockDriverState *bs = bds_tree_init(qdict, &local_err);
+    BlockDriverState *bs = bds_tree_init(qdict, &err);
     if (!bs) {
-        error_report_err(local_err);
         goto out;
     }
 
     bdrv_set_monitor_owned(bs);
 out:
     qemu_opts_del(opts);
+    hmp_handle_error(mon, err);
 }
 
 void hmp_drive_add(Monitor *mon, const QDict *qdict)
@@ -109,7 +109,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
     mc = MACHINE_GET_CLASS(current_machine);
     dinfo = drive_new(opts, mc->block_default_type, &err);
     if (err) {
-        error_report_err(err);
         qemu_opts_del(opts);
         goto err;
     }
@@ -123,7 +122,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "OK\n");
         break;
     default:
-        monitor_printf(mon, "Can't hot-add drive to type %d\n", dinfo->type);
+        error_setg(&err, "Can't hot-add drive to type %d", dinfo->type);
         goto err;
     }
     return;
@@ -134,6 +133,7 @@ err:
         monitor_remove_blk(blk);
         blk_unref(blk);
     }
+    hmp_handle_error(mon, err);
 }
 
 void hmp_drive_del(Monitor *mon, const QDict *qdict)
@@ -141,36 +141,32 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     const char *id = qdict_get_str(qdict, "id");
     BlockBackend *blk;
     BlockDriverState *bs;
-    Error *local_err = NULL;
+    Error *err = NULL;
 
     GLOBAL_STATE_CODE();
     bdrv_graph_rdlock_main_loop();
 
     bs = bdrv_find_node(id);
     if (bs) {
-        qmp_blockdev_del(id, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
+        qmp_blockdev_del(id, &err);
         goto unlock;
     }
 
     blk = blk_by_name(id);
     if (!blk) {
-        error_report("Device '%s' not found", id);
+        error_setg(&err, "Device '%s' not found", id);
         goto unlock;
     }
 
     if (!blk_legacy_dinfo(blk)) {
-        error_report("Deleting device added with blockdev-add"
-                     " is not supported");
+        error_setg(&err, "Deleting device added with blockdev-add"
+                   " is not supported");
         goto unlock;
     }
 
     bs = blk_bs(blk);
     if (bs) {
-        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
-            error_report_err(local_err);
+        if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &err)) {
             goto unlock;
         }
 
@@ -196,6 +192,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
 
 unlock:
     bdrv_graph_rdunlock_main_loop();
+    hmp_handle_error(mon, err);
 }
 
 void hmp_commit(Monitor *mon, const QDict *qdict)
@@ -203,6 +200,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
     const char *device = qdict_get_str(qdict, "device");
     BlockBackend *blk;
     int ret;
+    Error *err = NULL;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
@@ -214,22 +212,25 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
 
         blk = blk_by_name(device);
         if (!blk) {
-            error_report("Device '%s' not found", device);
-            return;
+            error_setg(&err, "Device '%s' not found", device);
+            goto end;
         }
 
         bs = bdrv_skip_implicit_filters(blk_bs(blk));
 
         if (!blk_is_available(blk)) {
-            error_report("Device '%s' has no medium", device);
-            return;
+            error_setg(&err, "Device '%s' has no medium", device);
+            goto end;
         }
 
         ret = bdrv_commit(bs);
     }
     if (ret < 0) {
-        error_report("'commit' error for '%s': %s", device, strerror(-ret));
+        error_setg(&err, "'commit' error for '%s': %s", device, strerror(-ret));
     }
+
+end:
+    hmp_handle_error(mon, err);
 }
 
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
@@ -890,7 +891,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 
     bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, &err);
     if (!bs) {
-        error_report_err(err);
+        hmp_handle_error(mon, err);
         return;
     }
 
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index f6f5d8715a..37b7ebd280 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -8,7 +8,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: no block device can store vmstate for snapshot
 (qemu) info snapshots
-no block device can store vmstate for snapshot
+Error: no block device can store vmstate for snapshot
 (qemu) loadvm snap0
 Error: no block device can store vmstate for snapshot
 (qemu) quit
@@ -22,7 +22,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: Device 'none0' is writable but does not support snapshots
 (qemu) info snapshots
-no block device can store vmstate for snapshot
+Error: no block device can store vmstate for snapshot
 (qemu) loadvm snap0
 Error: Device 'none0' is writable but does not support snapshots
 (qemu) quit
@@ -58,7 +58,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: Device 'virtio0' is writable but does not support snapshots
 (qemu) info snapshots
-no block device can store vmstate for snapshot
+Error: no block device can store vmstate for snapshot
 (qemu) loadvm snap0
 Error: Device 'virtio0' is writable but does not support snapshots
 (qemu) quit
@@ -83,7 +83,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: Device 'file' is writable but does not support snapshots
 (qemu) info snapshots
-no block device can store vmstate for snapshot
+Error: no block device can store vmstate for snapshot
 (qemu) loadvm snap0
 Error: Device 'file' is writable but does not support snapshots
 (qemu) quit
-- 
2.51.0


