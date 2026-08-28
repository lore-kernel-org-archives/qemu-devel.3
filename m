Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B7C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Q9-0007wJ-Vj; Fri, 28 Aug 2026 16:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Q8-0007tE-8P
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Q4-0008Tq-5q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0yxtRsnNgXPrXpPXUGgJhq34lX3aNVdT4/ghpoDFvM=;
 b=gU4u9C57ZeNi5uC5YtoV8h1TEEoqpnIWxat2bPidpMKnXCkJl0tlAKErfQyZUKL1ZRIOPC
 HDNCYORe3ezVQ324Ih0Y2Ga202ovTscM+SFPkSBLF3duPKgZB1st2fWwIp9UPOmveEWrFs
 XvKZVofKOFlW7EifR2fSyga1iBuNVgk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-O9bgTKQ5Od-S42hmxRIjrg-1; Fri,
 28 Aug 2026 16:43:20 -0400
X-MC-Unique: O9bgTKQ5Od-S42hmxRIjrg-1
X-Mimecast-MFC-AGG-ID: O9bgTKQ5Od-S42hmxRIjrg_1787949799
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F161E18C0FA5; Fri, 28 Aug 2026 20:43:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 337DC18005AC; Fri, 28 Aug 2026 20:43:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:01 +0400
Subject: [GIT PULL 22/50] block: add x-qemu-io QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-22-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8577;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O35SqeQo2IpeZKsiiSdgBY4xBrrl6SXMcIuOiZF3XPU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUawbONsYhZx1fZcLaGD+r4q3ISc8gT5w/e
 9p84pHWQNuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5Q5qD/9oRqT8Zhh8dvTgiGPUOyJXMp6a6cjjpIW4KEafRzaOV6ftbIoKn9XFIAfm+sZgPaKSh6v
 Mefxa9+rMIoFv/f2p+sAm7iLhMtrS/HAdcES2uXfUR3pqxNo9rh77STDUDI4lgGKNkyUvLSu6A0
 s11ARJw58mFKcRb/7iBivUk14GEMePh3M8k5jIErbgt++ESWKS7MDFgf/eQUeYvZkog0u/zfHYo
 /aWDwaCc2D8iBH6gJpf2qSIlql6CgCEDvSEcRKeRLIgRKRndPnGmcvOVzvX6NsHWdofTm6cqYDm
 sZnb0D6xpQnw5xrhjYyhEu7vrkZk4VHfAtvcY/9jHMwmp50z6XHGFWL7SJrjfrzvMgvwO3Y5Wx2
 rVnfdBTfmPfS7Usc0vxgMo1Sq0PpXg/eSPb5l6uPNz87g7p4jdebg+9ZND4wIWIW3YaJW2rQVXB
 La7d3jYYVLYRt2zwi7dwkE7kliH/yx5u3v1btR6aQ4RcAaa1IpLSO1HKQxyg/VG5Ak/o7faqDXk
 yGbxHQI2pukoHWeM4ICiFwvV0GKi3geVZzyi9zDgnVqmNsgsFsONEpJxvTc37iNKYI1WZU7oIq5
 2zvHyyTByt4OWgAJuWvbV0xXeumGzjY9RjTq6fP4YqLuv/ulSSAEhGts6ZDWLeRT+CRZfK834SA
 EnTv4e9vAWBBTWw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-ID: <20260828-qemu-no-hmp-v5-22-9227de146347@redhat.com>
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


