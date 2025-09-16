Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03767CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 05:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyOeO-0002ON-3s; Tue, 16 Sep 2025 01:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1uyOeG-0002LX-9J; Tue, 16 Sep 2025 01:54:40 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1uyOeA-0004D0-RK; Tue, 16 Sep 2025 01:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1758002055; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=PiwFxUnyG8dWIbP8fQG2LupwKBRzKhZ4u6pzMFSkzBo=;
 b=UXc14f5To8M9YFK1FeVenqez2Cj30cTDCWU8Jj+mDZVm/mM3pFl9qMR4Zcj1LAzQFF0d9jzg7UxaBig2+z+cevN71EvGIdlQ1Jl3aI49cseZyRLXUb6BCOuOJiGgcoYYE1VTyDWGNlHlbNLZjygRPe2L0FsOS83jvYFKEtL13Mc=
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0Wo76ENp_1758001731 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 16 Sep 2025 13:48:57 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Subject: [PATCH] block/monitor: Use hmp_handle_error to report error
Date: Tue, 16 Sep 2025 13:48:50 +0800
Message-Id: <20250916054850.40963-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

According to writing-monitor-commands.rst, best practice is to
use the 'hmp_handle_error' function, which ensures that the
message gets an 'Error: ' prefix.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 block/monitor/block-hmp-cmds.c | 43 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 282d1c386e..2f79a7360d 100644
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
+        error_setg(&err, "Deleting device added with blockdev-add"
                      " is not supported");
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
 
-- 
2.39.5


