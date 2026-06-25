Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F870CDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWJ-00054Z-RR; Thu, 25 Jun 2026 17:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWH-0004pT-5F
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWE-0003se-8h
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcbi6iQOJXsXwF5MiX/+1dYadWpWkRK6Z3B5qI7YnGs=;
 b=TdsdCeb0HhubaY2GHfbM7FyyqnUhFHcHNPVQLvVvaj4C4p3MMSO573G6F2xK67uRi1u00K
 ChkPsvVzvmsF4UZcDTYNIm0b1/V0AuCGbbozOjFjKXYkH9OUsgJR6AMK45671HpeKEJgTO
 oqFx+o9lx5LbC7M4Bk1PPEKHeFFIIqg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-UV46BILnMKy9cjwdgerMOg-1; Thu,
 25 Jun 2026 17:21:50 -0400
X-MC-Unique: UV46BILnMKy9cjwdgerMOg-1
X-Mimecast-MFC-AGG-ID: UV46BILnMKy9cjwdgerMOg_1782422509
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 250C61873C02; Thu, 25 Jun 2026 21:21:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D322E1800370; Thu, 25 Jun 2026 21:21:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:26 +0400
Subject: [PATCH v2 25/39] block: add x-qemu-io QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-25-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8342;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DiQcJdI1f9nONZOOEnwYdPmt6zyudOkA5HARGlaT2Hk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdsex20bZjiqCtaEMoeNQHU7X2T+ePZAXD4
 RfyZp5d/3eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5a5WD/oDrdjS/r81ThobINzhuhZiW3soP5NM/5DwFahnL3zHen03V8iS7fVnzBejgKACJ5qiUgI
 TXieL+rc4XzvnjLePHD2GnxwDlQrkzQjiUB9PhcOaXk0L6s3xJuelelhcOBkUpli6B6aVKp3IT2
 3ioVckzQ9vf5Re1+dUgsrIighLHWLmLkDWjCWEPbZhkrkAygwpJRUB3NV8vFC1A8ouoEnQ9x+0D
 s6asPrMsTz8j/HI/SX5RkcmDcTzHkjSIEVvVVctVKwgWLu4bOFg4v8N5rm1H49wUwbBgx4uoV9F
 LmIKJZ0xKuPFmQKvZcref9PEne8kFdamHDEZhjem24dXzDruJu33e5DHqfBiSI9elYgIlxxduut
 GrG4O4gLbtydzIjCQvzALIoZJY9eEqdevHILOJIu+JBv5K9T820yPPqjHmaFKiG9fxSCW0DpXTZ
 WVLaUeolXItJ+KocXiaf7xTP/UYadJ8GYNX/DZjXETUbh/iV16OVSAWe3GJHhtWxCRVEVWRNmvW
 QRPHMSRBLB0fiiVv9RDw80gxBzyNBY6nMzxgpp4JLgO20vjfkPgQP5Y4K6O5xJhS8NZtMqTdCwP
 X4AZN0oUAmC7nRzEQ3eampT7R+KvEgGr5BbAH7QUGOoZ+DGm48o6gc7lV9bX6NSeVMFsRl5f64/
 CnwXNXtLJ7yXxuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qapi/block.json                | 34 ++++++++++++++++++
 block/monitor/block-hmp-cmds.c | 60 ++------------------------------
 block/monitor/qmp-cmds.c       | 79 ++++++++++++++++++++++++++++++++++++++++++
 block/monitor/meson.build      |  1 +
 4 files changed, 117 insertions(+), 57 deletions(-)

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

-- 
2.54.0


