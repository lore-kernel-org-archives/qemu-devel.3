Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F04CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopN-0001vL-KJ; Wed, 20 May 2026 17:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopM-0001nW-Cg
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopJ-0004ah-QM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RI/GfL+YIuNQkKldDELoZ3A2iLQOpqapPwggqt66UIg=;
 b=WRqzDBvkBTi0d45K2UhJm9ZYSjm7v7bGkYMSOb2t6jeR8JH2Mo9XD0epKG+RpLCFwWQnUP
 UpBD22kQmHX0FRgj7RnvUhY+fMBXwaVc+bUiUSJ21LZeCCf6oc886hhAfk33Mzeo7Mezju
 8e0E4J5v1qY79lP9vUQoYi7sAQIA3zE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-xMRn7W_iNQCGv5Cu7PoMkw-1; Wed,
 20 May 2026 17:51:39 -0400
X-MC-Unique: xMRn7W_iNQCGv5Cu7PoMkw-1
X-Mimecast-MFC-AGG-ID: xMRn7W_iNQCGv5Cu7PoMkw_1779313898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4662195608E
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AC801956053; Wed, 20 May 2026 21:51:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:16 +0400
Subject: [PATCH 15/40] block: add x-qemu-io QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-15-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12400;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=105GLtz4Doau6tSSsomcN3HFvoAQ9hulVhQWImUMqYM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDRTZUNSm6vaO3FV2nlRfrfEINBG/3UvV/m
 NZpSgWv4KiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5U6gD/wIB1mzUip8IGO2ahmZtajxhaQkXFZD5+Z0jdoPKKruF+RC4brZ8+Na6weRHcTWEZtFtX1
 mxWxhsK2ixFvCgFIQd8fJcA3cP7djqYcVNRj9WQXwEXkYZD8oB+L8MxqO5o25u00YMA6eG9g2RP
 R/kMH/ZI10GiIbRgJc4Hp9ucLCCWY+z19jRHQn64zDX+W5TwV1r0+gwpZPFkzzRjLQ7ODAAdMIO
 doD/zNdC9B9RLgk5XuQ57mS/MNJBNFT2w7ifh2bRox+5XkoHU3z719Cug8aZUuAGRCzFpAGWy/c
 zzbw+zb6s/03wQzy61kMeiVts7YRmPQpdpWRdwZxM/YVz5xXr8l72aq/95YYC0DPKMkwiWNY3+B
 6x0qmzzP5/FubAIbOoobKUPEdMtZN4j9/YqZpa8LTCupNnjeBy7FVjAxywAx9rhq5zuUoFGHYGv
 X14m+79JljSAW9DqCLrofqfUafxlvxOv0NSe3WeBFk5ZzGBFFFbIWveY4eYD6JpLKtSANKVlIAE
 8LkDpnNJ8SpCotdYipkpTFC28TPWoa1qdjVhdndqoEtNXRcKqJ3gxE1X7QJflTcBTxPKKTgfH+l
 dDd7LLkUUaBOW4WUkob2kQsRdGlr97BZs+E0Il0aoEnl/un8wJPdQpGmIV0+iEle2aX8Q6W3GcS
 r6/t6VoQ/rzb1Zw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add an x-qemu-io QMP command that runs qemu-io commands on block
devices. The command accepts a device name (block backend name,
node-name, or qdev ID) and a qemu-io command string.

Refactor hmp_qemu_io() to be a thin wrapper around the new QMP
command, following the standard HMP-over-QMP pattern used by other
block commands.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/block.json                             | 34 +++++++++++++
 block/monitor/block-hmp-cmds.c              | 60 ++--------------------
 block/monitor/qmp-cmds.c                    | 79 +++++++++++++++++++++++++++++
 block/monitor/meson.build                   |  1 +
 tests/qemu-iotests/tests/image-fleecing     |  4 +-
 tests/qemu-iotests/tests/image-fleecing.out | 52 +++++++++----------
 6 files changed, 145 insertions(+), 85 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e3..0a588714ea9 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -603,3 +603,37 @@
            '*boundaries-zap': ['uint64'],
            '*boundaries-flush': ['uint64'] },
   'allow-preconfig': true }
+
+##
+# @x-qemu-io:
+#
+# Run a qemu-io command on a block device.  Take either a block
+# backend name or a qdev ID to identify the device.
+#
+# @device: the block backend name, node-name to run the
+#     command on.
+#
+# @qdev: the qdev ID of the block device to run the
+#     command on.
+#
+# @command: the qemu-io command string to execute.
+#
+# Features:
+#
+# @unstable: This command is for testing only.
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "x-qemu-io",
+#          "arguments": { "device": "virtio0",
+#                         "command": "read 0 512" } }
+#     <- { "return": {} }
+##
+{ 'command': 'x-qemu-io',
+  'data': { '*device': 'str',
+            '*qdev': 'str',
+            'command': 'str' },
+  'features': [ 'unstable' ],
+  'allow-preconfig': true }
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index c7113b8ea5e..254a79ce855 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -56,7 +56,6 @@
 #include "block/qapi.h"
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
-#include "qemu-io.h"
 
 static void hmp_drive_add_node(Monitor *mon, const char *optstr)
 {
@@ -551,67 +550,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
 
 void hmp_qemu_io(Monitor *mon, const QDict *qdict)
 {
-    BlockBackend *blk = NULL;
-    BlockDriverState *bs = NULL;
-    BlockBackend *local_blk = NULL;
     bool qdev = qdict_get_try_bool(qdict, "qdev", false);
     const char *device = qdict_get_str(qdict, "device");
     const char *command = qdict_get_str(qdict, "command");
     Error *err = NULL;
-    int ret;
-
-    if (qdev) {
-        blk = blk_by_qdev_id(device, &err);
-        if (!blk) {
-            goto fail;
-        }
-    } else {
-        blk = blk_by_name(device);
-        if (!blk) {
-            bs = bdrv_lookup_bs(NULL, device, &err);
-            if (!bs) {
-                goto fail;
-            }
-        }
-    }
-
-    if (bs) {
-        blk = local_blk = blk_new(bdrv_get_aio_context(bs), 0, BLK_PERM_ALL);
-        ret = blk_insert_bs(blk, bs, &err);
-        if (ret < 0) {
-            goto fail;
-        }
-    }
-
-    /*
-     * Notably absent: Proper permission management. This is sad, but it seems
-     * almost impossible to achieve without changing the semantics and thereby
-     * limiting the use cases of the qemu-io HMP command.
-     *
-     * In an ideal world we would unconditionally create a new BlockBackend for
-     * qemuio_command(), but we have commands like 'reopen' and want them to
-     * take effect on the exact BlockBackend whose name the user passed instead
-     * of just on a temporary copy of it.
-     *
-     * Another problem is that deleting the temporary BlockBackend involves
-     * draining all requests on it first, but some qemu-iotests cases want to
-     * issue multiple aio_read/write requests and expect them to complete in
-     * the background while the monitor has already returned.
-     *
-     * This is also what prevents us from saving the original permissions and
-     * restoring them later: We can't revoke permissions until all requests
-     * have completed, and we don't know when that is nor can we really let
-     * anything else run before we have revoken them to avoid race conditions.
-     *
-     * What happens now is that command() in qemu-io-cmds.c can extend the
-     * permissions if necessary for the qemu-io command. And they simply stay
-     * extended, possibly resulting in a read-only guest device keeping write
-     * permissions. Ugly, but it appears to be the lesser evil.
-     */
-    qemuio_command(blk, command, &err);
 
-fail:
-    blk_unref(local_blk);
+    qmp_x_qemu_io(qdev ? NULL : device,
+                  qdev ? device : NULL,
+                  command, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/block/monitor/qmp-cmds.c b/block/monitor/qmp-cmds.c
new file mode 100644
index 00000000000..e5759d824f1
--- /dev/null
+++ b/block/monitor/qmp-cmds.c
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+#include "system/block-backend.h"
+#include "block/block_int.h"
+#include "qapi/qapi-commands-block.h"
+#include "qapi/error.h"
+#include "qemu-io.h"
+
+void qmp_x_qemu_io(const char *device, const char *qdev,
+                   const char *command, Error **errp)
+{
+    BlockBackend *blk = NULL;
+    BlockBackend *local_blk = NULL;
+    BlockDriverState *bs = NULL;
+    int ret;
+
+    if (!device && !qdev) {
+        error_setg(errp, "Must specify either device or qdev");
+        return;
+    }
+    if (qdev && device) {
+        error_setg(errp, "Cannot specify both qdev and device");
+        return;
+    }
+
+    if (qdev) {
+        blk = blk_by_qdev_id(qdev, errp);
+        if (!blk) {
+            return;
+        }
+    } else {
+        blk = blk_by_name(device);
+        if (!blk) {
+            bs = bdrv_lookup_bs(NULL, device, errp);
+            if (!bs) {
+                return;
+            }
+        }
+    }
+
+    if (bs) {
+        blk = local_blk = blk_new(bdrv_get_aio_context(bs), 0, BLK_PERM_ALL);
+        ret = blk_insert_bs(blk, bs, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    /*
+     * Notably absent: Proper permission management. This is sad, but it seems
+     * almost impossible to achieve without changing the semantics and thereby
+     * limiting the use cases of the qemu-io command.
+     *
+     * In an ideal world we would unconditionally create a new BlockBackend for
+     * qemuio_command(), but we have commands like 'reopen' and want them to
+     * take effect on the exact BlockBackend whose name the user passed instead
+     * of just on a temporary copy of it.
+     *
+     * Another problem is that deleting the temporary BlockBackend involves
+     * draining all requests on it first, but some qemu-iotests cases want to
+     * issue multiple aio_read/write requests and expect them to complete in
+     * the background while the monitor has already returned.
+     *
+     * This is also what prevents us from saving the original permissions and
+     * restoring them later: We can't revoke permissions until all requests
+     * have completed, and we don't know when that is nor can we really let
+     * anything else run before we have revoken them to avoid race conditions.
+     *
+     * What happens now is that command() in qemu-io-cmds.c can extend the
+     * permissions if necessary for the qemu-io command. And they simply stay
+     * extended, possibly resulting in a read-only guest device keeping write
+     * permissions. Ugly, but it appears to be the lesser evil.
+     */
+    qemuio_command(blk, command, errp);
+
+fail:
+    blk_unref(local_blk);
+}
diff --git a/block/monitor/meson.build b/block/monitor/meson.build
index 1022516e93c..74faced9e17 100644
--- a/block/monitor/meson.build
+++ b/block/monitor/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(files('block-hmp-cmds.c'))
 block_ss.add(files('bitmap-qmp-cmds.c'))
+system_ss.add(files('qmp-cmds.c'))
diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index 5e3b2c7e46a..62ef15ff046 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -202,12 +202,12 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
     for p in overwrite:
         cmd = 'write -P%s %s %s' % p
         log(cmd)
-        log(vm.hmp_qemu_io(qom_path, cmd, qdev=True))
+        log(vm.qmp('x-qemu-io', qdev='sda', command=cmd))
 
     if push_backup:
         # Check that previous operations were done during backup, not after
         # If backup is already finished, it's possible that it was finished
-        # even before hmp qemu_io write, and we didn't actually test
+        # even before qemu_io write, and we didn't actually test
         # copy-before-write operation. This should not happen, as we use
         # speed=1. But worth checking.
         result = vm.qmp('query-block-jobs')
diff --git a/tests/qemu-iotests/tests/image-fleecing.out b/tests/qemu-iotests/tests/image-fleecing.out
index acfc89ff0e9..0a819539130 100644
--- a/tests/qemu-iotests/tests/image-fleecing.out
+++ b/tests/qemu-iotests/tests/image-fleecing.out
@@ -31,13 +31,13 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
+{"return": {}}
 write -P0xad 0x00f8000 64k
-{"return": ""}
+{"return": {}}
 write -P0x1d 0x2008000 64k
-{"return": ""}
+{"return": {}}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
+{"return": {}}
 
 --- Verifying Data ---
 
@@ -101,13 +101,13 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
+{"return": {}}
 write -P0xad 0x00f8000 64k
-{"return": ""}
+{"return": {}}
 write -P0x1d 0x2008000 64k
-{"return": ""}
+{"return": {}}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
+{"return": {}}
 
 --- Verifying Data ---
 
@@ -172,13 +172,13 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
+{"return": {}}
 write -P0xad 0x00f8000 64k
-{"return": ""}
+{"return": {}}
 write -P0x1d 0x2008000 64k
-{"return": ""}
+{"return": {}}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
+{"return": {}}
 
 --- Verifying Data ---
 
@@ -238,25 +238,25 @@ read -P0xd5 1M 64k
 read -P0xdc 32M 64k
 read -P0xcd 0x3ff0000 64k
 read -P0 0x00f8000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x2010000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x3fe0000 64k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
+{"return": {}}
 write -P0xad 0x00f8000 64k
-{"return": ""}
+{"return": {}}
 write -P0x1d 0x2008000 64k
-{"return": ""}
+{"return": {}}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
+{"return": {}}
 
 --- Verifying Data ---
 
@@ -265,13 +265,13 @@ read -P0xd5 1M 64k
 read -P0xdc 32M 64k
 read -P0xcd 0x3ff0000 64k
 read -P0 0x00f8000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x2010000 32k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 read -P0 0x3fe0000 64k
-read failed: Invalid argument
+qemu-io: read failed: Invalid argument
 
 
 --- Cleanup ---
@@ -318,13 +318,13 @@ Done
 --- Testing COW ---
 
 write -P0xab 0 64k
-{"return": ""}
+{"return": {}}
 write -P0xad 0x00f8000 64k
-{"return": ""}
+{"return": {}}
 write -P0x1d 0x2008000 64k
-{"return": ""}
+{"return": {}}
 write -P0xea 0x3fe0000 64k
-{"return": ""}
+{"return": {}}
 {"data": {"device": "push-backup", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"return": {}}
 

-- 
2.54.0


