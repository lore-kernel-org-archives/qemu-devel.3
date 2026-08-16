Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7CBC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJT-0001Jr-MN; Sun, 16 Aug 2026 15:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJR-0001Bo-1b
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJO-0007dH-AN
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CMMKu6kzTPjhr60fVp/ni4m6u7V9jPpiJw4QDuDdfg=;
 b=Te1lj+we7WmPSrLBYV1KygnGdNG3uQNhk2U1IB67J08wqmGfkULxD1L6BZYrAYXQdo6kyF
 6ae4jaXywkx2tS02Hhs8DCZGOEH0P/nXezfl534PBa2Nccak7aB+bs8LKEQqEPmxBnFxtr
 UaoyqgvtnQTYAyFA0V14W9T1YZZO3K8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-7sK_svujPsyXvrBycTfA8w-1; Sun,
 16 Aug 2026 15:14:15 -0400
X-MC-Unique: 7sK_svujPsyXvrBycTfA8w-1
X-Mimecast-MFC-AGG-ID: 7sK_svujPsyXvrBycTfA8w_1786907654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 217EA1956080; Sun, 16 Aug 2026 19:14:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFD91180034F; Sun, 16 Aug 2026 19:14:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:48 +0400
Subject: [PATCH v3 21/49] block: add x-qemu-io QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-21-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8511;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H7kf02DdiNn1nFNRkOMtk6kTSmAJa1hNXFx4tWwfEJg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguyF6mi5yc6OpkAK9buP7MMkziH9NP0Arj1S
 fid737VEXaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsgAKCRDa6OEJdZac
 5T9oD/9DjHXefdLPB2+BDywc872PpxnVlLvGZzZVZkclFbONK6iwXT/C4KiLYZCyjanLpqESuUF
 5PmseNhBZs8inRpl3vglVIjie8nNUQiJ+eVoootjUfZNruFdFBNQtGwHYBfrclQqxDCT1Qo5fsr
 hEbwrxA33wZA7qxs7MfRoXi3iIXQ07Mb+YAWVN83qHujlEqpfPfnPV/jmheCzy1zuvYhmAXXqrG
 6ykIJAfFQiKY+DVLUkhpUUSJ6iosagPJgqP0CS/NzpGmHF8qBkSz4TTz/SBg7LAMPt7TDb7nJu3
 1eaQ2vmKP1gjSUx9yuOP+J77drPUXunwTYrmz+c2xY13yCUcua9IeYgne1iP4SnPqxnSDO79wih
 JQ2+PtMCWLSrxCdgXM1UjYomwqZP/5S15YhyvrdyeP7T8SpGUle0Ges0d5+hFCdfZy379CA/gT/
 nZzcRJMi0bFt6KuOUqRduFhW/6Q7P8WdZ7wGn14h0ijpRWrwmKPXIdxDHVGipxK+3rhO+hbP4vt
 YPm0Du//8BgCtKCoq61l+s1Vb+eGM6hg4xlGIbuMZQciAxD/Q4ej1MnyrYmr/ElLlx+Uvlu+PRC
 wQ2WZFags2ZBqol+9ENusDX2HWWIkrgrYspsh/SIZfBSX9h7zWu4XBUV2N4ToGtznQIMx7yXwJU
 hyIff+09HoRnH1w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This change is also required for the qtest qemu-io command in the
following patch.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 60 ++------------------------------
 block/monitor/meson.build      |  1 +
 block/monitor/qmp-cmds.c       | 79 ++++++++++++++++++++++++++++++++++++++++++
 qapi/block.json                | 34 ++++++++++++++++++
 4 files changed, 117 insertions(+), 57 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 9930620a4a16..22fa03089ea3 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -56,7 +56,6 @@
 #include "block/qapi.h"
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
-#include "qemu-io.h"
 
 static void hmp_drive_add_node(Monitor *mon, const char *optstr)
 {
@@ -541,67 +540,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
 
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
-
-fail:
-    blk_unref(local_blk);
+    qmp_x_qemu_io(qdev ? NULL : device,
+                  qdev ? device : NULL,
+                  command, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/block/monitor/meson.build b/block/monitor/meson.build
index 1022516e93c5..74faced9e17f 100644
--- a/block/monitor/meson.build
+++ b/block/monitor/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(files('block-hmp-cmds.c'))
 block_ss.add(files('bitmap-qmp-cmds.c'))
+system_ss.add(files('qmp-cmds.c'))
diff --git a/block/monitor/qmp-cmds.c b/block/monitor/qmp-cmds.c
new file mode 100644
index 000000000000..e5759d824f13
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
diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e34..012a9d73333b 100644
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
+# Since: 11.2
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

-- 
2.55.0.543.g5ebe2ebe4ea8


