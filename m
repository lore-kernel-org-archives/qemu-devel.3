Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAA0D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqaB-0008Qe-3p; Mon, 19 Jan 2026 09:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZo-0008D2-Ui; Mon, 19 Jan 2026 09:49:58 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZj-0008NV-5Z; Mon, 19 Jan 2026 09:49:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9AF638079B;
 Mon, 19 Jan 2026 17:49:47 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-z2hOBkpJ; Mon, 19 Jan 2026 17:49:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834186;
 bh=UqhAnPu8xVLK6fTiBiY6reBxiK4bUaCAZpJJSu0dE9w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FRe1xP5kNeRPBGg/kF4lCvw45lQX/qlkm+TKw8k6/QWyGxTohmH3gMtdRn8oirsLn
 GEbXh4ABHrNvMkRpWPpO+DyLeXFxE19R+fUXzdrmt5fLoe7Ni6V5xfE2g7Wg/9dyno
 uaRS0wHrp9a0pfP3Wla+FpNIUL0FTTAXso3NCnng=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 4/8] qapi: add blockdev-replace command
Date: Mon, 19 Jan 2026 17:49:37 +0300
Message-ID: <20260119144941.87936-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Add a command that can replace bs in following BdrvChild structures:

 - qdev blk root child
 - block-export blk root child
 - any child of BlockDriverState selected by child-name

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 blockdev.c             | 68 ++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json   | 24 +++++++++++++++
 stubs/blk-by-qdev-id.c | 13 ++++++++
 stubs/meson.build      |  1 +
 4 files changed, 106 insertions(+)
 create mode 100644 stubs/blk-by-qdev-id.c

diff --git a/blockdev.c b/blockdev.c
index 2540f991b3..3082a5763c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3681,6 +3681,74 @@ out:
     bdrv_drain_all_end();
 }
 
+void qmp_blockdev_replace(const char *parent, const char *child,
+                          const char *new_child, Error **errp)
+{
+    BdrvChild *child_to_replace = NULL;
+    BlockDriverState *new_child_bs;
+    Error *dev_err = NULL, *exp_err = NULL;
+    BlockDriverState *parent_bs = bdrv_find_node(parent);
+    BlockBackend *dev_blk = blk_by_qdev_id(parent, &dev_err);
+    BlockBackend *exp_blk = blk_by_export_id(parent, &exp_err);
+    unsigned found = !!parent_bs + !!dev_blk + !!exp_blk;
+
+    if (found == 0) {
+        error_setg(errp, "Neither device, nor export, nor block-node exist"
+                   " with name '%s'. block-node: not found,"
+                   " device block-backend: %s, export block-backend: %s",
+                   parent, error_get_pretty(dev_err),
+                   error_get_pretty(exp_err));
+    }
+    error_free(dev_err);
+    error_free(exp_err);
+
+    if (found == 0) {
+        return;
+    }
+
+    if (found > 1) {
+        error_setg(errp, "Parent name '%s' is ambigous: block-node %s,"
+                   " device block-backend %s, export block-backend %s",
+                   parent, parent_bs ? "found" : "not found",
+                   dev_blk ? "found" : "not found",
+                   exp_blk ? "found" : "not found");
+        return;
+    }
+
+    if (parent_bs) {
+        child_to_replace = bdrv_find_child(parent_bs, child);
+        if (!child_to_replace) {
+            error_setg(errp, "Block driver node '%s' doesn't have child "
+                       "named '%s'", parent, child);
+            return;
+        }
+    } else {
+        BlockBackend *blk = dev_blk ?: exp_blk;
+
+        if (strcmp(child, "root")) {
+            error_setg(errp, "Devices and exports may have only 'root' child");
+        }
+
+        child_to_replace = blk_root(blk);
+        if (!child_to_replace) {
+            error_setg(errp, "%s '%s' is empty, nothing to replace",
+                       dev_blk ? "Device" : "Export", parent);
+            return;
+        }
+    }
+
+    assert(child_to_replace);
+    assert(child_to_replace->bs);
+
+    new_child_bs = bdrv_find_node(new_child);
+    if (!new_child_bs) {
+        error_setg(errp, "Node '%s' not found", new_child);
+        return;
+    }
+
+    bdrv_replace_child_bs(child_to_replace, new_child_bs, errp);
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af74256..9cc7c3d140 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6334,3 +6334,27 @@
 ##
 { 'struct': 'DummyBlockCoreForceArrays',
   'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
+
+##
+# @blockdev-replace:
+#
+# Replace a block-node associated with device (@parent should be
+# QOM path, and @child should be "root") or with block-export (@parent
+# should be export name, and @child should be "root") or any child
+# of block-node (@parent should be node-name, and @child should be any
+# if its children names) with @new-child block-node.
+#
+# @parent: QOM path or block-export or node-name, which @child should
+#     be repalced.  If several matching parents exist, the command
+#     will fail
+#
+# @child: child to replace.  Must be "root" when parent is QOM path or
+#     block-export
+#
+# @new-child: node-name of the block-node, which should become a
+#    replacement for @child's current block-node
+#
+# Since 11.0
+##
+{ 'command': 'blockdev-replace',
+  'data': { 'parent': 'str', 'child': 'str', 'new-child': 'str' } }
diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
new file mode 100644
index 0000000000..66ead77f4d
--- /dev/null
+++ b/stubs/blk-by-qdev-id.c
@@ -0,0 +1,13 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/block-backend.h"
+
+BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
+{
+    /*
+     * We expect this when blockdev-change is called with parent-type=qdev,
+     * but qdev-monitor is not linked in. So no blk_ API is not available.
+     */
+    error_setg(errp, "Parameter 'parent-type' does not accept value 'qdev'");
+    return NULL;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index d3b551f4de..93a52d273e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -15,6 +15,7 @@ if have_block
   stub_ss.add(files('bdrv-next-monitor-owned.c'))
   stub_ss.add(files('blk-commit-all.c'))
   stub_ss.add(files('blk-exp-close-all.c'))
+  stub_ss.add(files('blk-by-qdev-id.c'))
   stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
   stub_ss.add(files('change-state-handler.c'))
   stub_ss.add(files('get-vm-name.c'))
-- 
2.52.0


